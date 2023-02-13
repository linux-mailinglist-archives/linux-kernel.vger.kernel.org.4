Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2AB3E6951BA
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 21:17:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231149AbjBMURt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 15:17:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229975AbjBMURq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 15:17:46 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1298D2203E
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 12:17:44 -0800 (PST)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31DI5De9003196;
        Mon, 13 Feb 2023 20:17:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=Gn2A8lybsNqZEoOLQFHA661x0RLpEcj+D+f8Qv9GtSs=;
 b=ypLWhn7WCycwzr18iBRgphm6mI5jL/ARmfEr0IpHmYvQ2Nkvrs10LaGSXZ8NprxeVvZv
 jvqfOUPyTtXcKm1UwzODs9tbtNQe8T8E29EsPx+qiBHDk64LW2puPqT3L25K57BnCpH0
 aYlnor+6Tj7dwzygN2fW6+QI3JZG7fPMaWOQfVAUQODvD/YuQLm/ILYc63KCvsqYdbvV
 eFgJ35/VQo34Py9LgQBbwLw6iLahjbkuGLBZMXF5JwB4caCSJqCVTexZCHYRCSjXqn4Q
 OiryBGc8ui54OzyS2rDvbiV28zSOxPBfGIrccooylL5tuVKJv50UVyKVg/hIt17JGp+c AQ== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3np3jturcd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 13 Feb 2023 20:17:40 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 31DIYvlO011688;
        Mon, 13 Feb 2023 20:17:38 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2042.outbound.protection.outlook.com [104.47.57.42])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3np1f4m8vv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 13 Feb 2023 20:17:38 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y9o0stmklBcPBQbUcziEAQLjjb6EdPetzf3vsr6ehBTnti5CU86dB7QMAtlI2tMAc4rFZI7/1mkYAbqnmRS7dkcaoWIHe397H3MPWEA2j2LQ5k88bE4jZweKFDyqUg3PbZAiXH40qeXcFBST+RLg205VS6rUGkW9q7V1aVpGB6RHF2eN6acv8SNVKRTClZFJ7jbD3jvi9BYiyy2eEHm3pw5lcKMkVVlJV5IzyvJ2/xfvSkDP2gCf0oVUGMudgVXQwMsfVBCev38TmcsQXohhWTvF0V5FWIvQ8X897LbXDbeZtK0nHejv37fL1s2FICOUyVnDLRSimKwFDNNfdmCQpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Gn2A8lybsNqZEoOLQFHA661x0RLpEcj+D+f8Qv9GtSs=;
 b=Irp547Tp3P3t4/Yk5QzfxaYTY/69pzczN/7ICNjzZo0uk7VfTwWSpNkkt0o99QFIEvRCaWu7ADMF+1ux5DT4IGN8K0y59ICiGUUdq0QnPoIqrnTmnCcqavVSmUeHrgfuQ3mzGTprK2h4YDNVI6apdd9FP8alhgwB2SDUrmhVim8UFljML/a/SQ7bAjIOX5+opx5Cp1I4zpIOL5y8v0csZKB3eSDmj4KDkljUyRhYoxVDEtDsufZIVr09dgVLwW4hrLFPNuvxx7akP0VQBs9nBabhk6zGeqL7YKTXDGPh/2nElR30ZqLa0RrLiztE9+msLOlNo9XimJTf5/ktRpsZ/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gn2A8lybsNqZEoOLQFHA661x0RLpEcj+D+f8Qv9GtSs=;
 b=hEO6DAqqPm3gkZL9oKZi1R6ZCv6+W38O4RsiTAI32lyPaKZa4Bm4vVe8208F1vgocNaA+A3GAhde3R5X053obJ0mFE19jYBiiHGnnbdEtZtjn//uUg5I+4q3pm0r1VnZ31QJTttWgAcwQdZTGBydPgkLvhgH/chYcDiV0+N3ad4=
Received: from MW4PR10MB6535.namprd10.prod.outlook.com (2603:10b6:303:225::12)
 by PH8PR10MB6501.namprd10.prod.outlook.com (2603:10b6:510:22b::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6111.9; Mon, 13 Feb
 2023 20:17:36 +0000
Received: from MW4PR10MB6535.namprd10.prod.outlook.com
 ([fe80::25da:8594:cf75:8ef3]) by MW4PR10MB6535.namprd10.prod.outlook.com
 ([fe80::25da:8594:cf75:8ef3%9]) with mapi id 15.20.6111.010; Mon, 13 Feb 2023
 20:17:36 +0000
Message-ID: <cec254c1-4508-56de-96bb-f6bf82a7fd18@oracle.com>
Date:   Mon, 13 Feb 2023 12:17:33 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH] vdpa/mlx5: should not activate virtq object when
 suspended
Content-Language: en-US
To:     Eli Cohen <elic@nvidia.com>, mst@redhat.com, jasowang@redhat.com,
        Eugenio Perez Martin <eperezma@redhat.com>
Cc:     parav@nvidia.com, virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
References: <1676095694-15563-1-git-send-email-si-wei.liu@oracle.com>
 <536e8152-b575-7b8f-d7c9-37975bbedd3d@nvidia.com>
From:   Si-Wei Liu <si-wei.liu@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <536e8152-b575-7b8f-d7c9-37975bbedd3d@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR03CA0038.namprd03.prod.outlook.com
 (2603:10b6:a03:33e::13) To MW4PR10MB6535.namprd10.prod.outlook.com
 (2603:10b6:303:225::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR10MB6535:EE_|PH8PR10MB6501:EE_
X-MS-Office365-Filtering-Correlation-Id: 8b9b379c-4568-4b68-30c1-08db0dff58d3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zxM/iRMvE+uG682RRYvf5LQYxOmr5nhBWnKn/yckzKFZz/DfrGFeG95lugwt65R4tbWz8T1H/iqVf8WpoAV0/ZFqO+Zy9ZMO+ACDKmRlfsvNL+8RepEyW3xKDhqIUkdhWm87i3N1n0BVhWKVGAnoPE18y1l4f9Nm30S0kRZdhb+YGJhyYkIyMoNMBLtt3GriYPUgVrw0+JSxnYMxpgJIq7rIi9TzNZGA7c4RnZ0c/kdQdwuzPcp3LUCmgUO5EsbVP71xFoRnXd0ULl8nnPwrIjA96lUwWlxQKXfmkluiqKn6LkxakERtt4BJ2Uj1qHHP7u7UH8ZXkXhBSslvTaPXAcSoVaoP18tC8jKWF4bmYBuz623Q/DDDjEgr23E3Gel06D7G2GKj9g9ooYS9Lvt/q19l2iaxL0WI9mo5MWU99Oa/LiSHTUTJwfjkdad71wlzCcThNxnOHsPoI00Pcvr+f/h5NQSYTl+XVfuFEQFndgdogxQ8IbkxwRF6QdiLQfyO5ZZiKmA6rSKopKXwIl7f9r3hjHIBWAFQfiK/vYfNAqSd5h3oHRy9g0gJ6gDSY0LvNBINK4BdSAepWpi0B4aX8UtYx+3OelQBVsyAhcX8lW3hAW9uJcsL6ypGtw8KRh8HcHJtucKG2cec7qlHtmnU1q0CxcRT/BNrcyr8KEffqzPxLNEM1lawWeqEo2zansFliaG7x/bZ3nIrVLYejJSc3zirtJ+CmzRb4ZjrPdrv4XQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR10MB6535.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(376002)(396003)(136003)(366004)(39860400002)(346002)(451199018)(31696002)(6486002)(110136005)(36916002)(53546011)(186003)(478600001)(26005)(6512007)(6666004)(6506007)(2906002)(41300700001)(8936002)(5660300002)(316002)(15650500001)(8676002)(38100700002)(66556008)(66476007)(4326008)(66946007)(2616005)(83380400001)(36756003)(86362001)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?c1FCTEY5eWFDZWdNd1dlTG5GZElOTkNpaFUxcHY1eUVEV3FlM1hNNGd4UEdJ?=
 =?utf-8?B?VXdkQ3dyTkI2SmVxM0l3akZwV0pvWmxCb2o4aWx6SkdCcjA3cUtrU2dkaHlP?=
 =?utf-8?B?czlMbHZMbXRKZXpPK3Jzamd3a0lQWlZZblNOUFhIZ1VROGpFS0s5cGdqVUF2?=
 =?utf-8?B?aU1nb1V1T2thZE9ibnR3bVNlakhwcXdldk9Zak9sRzNCKy9jRE5aeSt4SHp5?=
 =?utf-8?B?Y2NxMGQycFNzWWZjZlNkUTN2TUp5bUpQTE9LaU5KY3EvTlJ1RGR5S3BEbDBm?=
 =?utf-8?B?SGVhVHcvTzMxb1pqb1JIN0pmTlVaVVo0N1cvdTVwQkZISlVRanZqaXcvclRG?=
 =?utf-8?B?TlNZazNzbXdZUWM5QlQ2RFN3Zmo5NkMrczU5WDVIRnE4dDBpSTNQSldpNThw?=
 =?utf-8?B?eEVHbmxGQnZRVm4rOFBhTUhtMHlyOU9hU2F6OUxPUTB0UEN1NkMvTmpqZGE0?=
 =?utf-8?B?dGhZczg0Sy8ybFREMldMbEkySFE5aEd1T3dybUxGUG1VMU1BM0l1dCsrQ09S?=
 =?utf-8?B?MitVcFNmZk1zd3hUeTNDWUF4WG90aFdWNGMvZ1pMejJad0t2U2J5RCtYdUIy?=
 =?utf-8?B?VUo2WWFaY2JudFBDMHN4cjhBd0dSZUlEZHBBUit1UmwyUHNQMXdlL2hoNHNB?=
 =?utf-8?B?WklYZkZ2MU1MY3NuRzhzUVU0WDdkeWZlMkNvMGtzWHFBdk1EOVVaSE1VWmFw?=
 =?utf-8?B?RWVBeGlGaytPVGRuaFA0SW1RVTU0Wmo2YStONmZrYXZ5TlBFbmZ2YnNvYmZq?=
 =?utf-8?B?L3h2dnJKTUIxTGxyVEJJbEV6NFFZekpjeU8vWHpqcXVlcjZFL01MTnFpL21a?=
 =?utf-8?B?bndOSTlZYmRFY3o1dllaQ0VOZGtNejBFOUFXVWg5Y0xnS0QwVzNId3ZkS3px?=
 =?utf-8?B?VUpsU1J5OHo2WTI1cjgrQnVNZ3ExTmZVOTFLNVRxcjFMK25YSDJPaXR2MXN2?=
 =?utf-8?B?djIvSVVKWENSM1g3MGNSdlFvZ1plQ0R0ZVJGTEI3VGJEZVVMNm9MRlVaV3lp?=
 =?utf-8?B?NVBrVTh4elRQUE8xQmQvYm10ZHFnQ3ZkSzhkWmgxY05HRXF2VG9iclBUK3Ru?=
 =?utf-8?B?Z2FsaGZvZFdmWWtZNHRNdFNIZURWdkVwNnh4Sm9iOU1QR2ZGcDhHQVNMWTJT?=
 =?utf-8?B?Z2QwVklwYzNhRXh6bUcrZ2g1em9SeWg3UU1TaGtybnFtc0M4ZXQvWGtMYmNr?=
 =?utf-8?B?STJzS1BjSGoxbVJYN0xQcUxXa3piMWVWcjhDdzJFN0k0VU16Z0Zub3FnOStV?=
 =?utf-8?B?ZGNpWnZYdWZvdENKNnRldXdrV2owaVc4d1N6WStxR2VQaE96SEpVRUxJcHpX?=
 =?utf-8?B?R2pwQlE5T1BFc3VqS2xaelBvZnF2Slo1ZThSVVhCL0tZdk93eGMrNHRUK1Ey?=
 =?utf-8?B?RGRMenNHM1pPSWdzbTBOcENXRWwzZUQ5YWJCTVUveFIwM2JLeFNHZGdRVlFu?=
 =?utf-8?B?M3Q4Mmt5dTVqRzl1azdpUGhQZ3d0OHpFSlB4Mnk4QUNFUjZmbXIrQWc3aUZU?=
 =?utf-8?B?TDJrT0VQcEpoaDIrYVQ5Nm9KdGF0TVEyL3dlVDc0NEZmbEhkN3VackE4dWxp?=
 =?utf-8?B?eFZpUWlBLy9GM3NIVFozZndwK0hYdHB1R1FBK1JyclNTUW9DY004N1dCbHFr?=
 =?utf-8?B?T09pZlBoNlZEMTRyelJwQkFQZFVuWmlHNHhadzZETmhYdmpkYk96Q2MwTkJp?=
 =?utf-8?B?RmR0NTA2YllCb3YxSUtYOXFtYWhRQS9ERkozRTRkTGdYV25QRTM5cVEwY2p5?=
 =?utf-8?B?R0NTa2UrN3FYNVlreEp0YkFFamE3NGNOLzBRSTRKYkhqdUlXUDV0MnZyN2Yx?=
 =?utf-8?B?b2FKWlAzLzVZT3pmY2Rnc1E1bk5VWXEzRzVENEN1N2JaU0N6SURmNmszbjN2?=
 =?utf-8?B?Rkw5alZ5QkY3aUdqWGdGbEcxOUFNN3Zna09YazF6WVc1VENvMFV4SFpoRnI0?=
 =?utf-8?B?dGpkeVIvQW5NbVZIcXZkSFNpMVprZXFyUlJmcjF6Sk9YdmRKRVRmeUtVbFVY?=
 =?utf-8?B?RkVFUis3NWJHY0EvMTlXdGdDUHd2R2l3UzVHM0owZnAvWGZyRHVERlkvTUp6?=
 =?utf-8?B?TW5JdlJhOVFKS3Q0dVhsVzYyZ2F1a0VmUWZCbzYzNjF6ZjVUeFNPc3M3SFlB?=
 =?utf-8?Q?RuLdbEM8t755sjcNgNI5WTpF9?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: NqAk32VAa12/vk0bueLmTRnB3JokGRS9kgQZr8zTVBkHvpWObCuvKHu+CkCYh/wcVn+8kRGi0rNRlEyclWWVv0d8l/Ui2TDoahw7hy5pclO2RdpbdnYNjIhpz00B4EtFAR7KJBvVjoFkyP7LXVaglBxd3S6j15Uty9OXQbb9zFn/SaYaOPnb0oQI/AsUOWhYBdWKPugQZ1D5jM33XanTWW3hAu60gfBA3gK3SKvhccsjiy34qgRRntoW9pkV5vgkvcFVAw5N2Sttqv4uXLVW/dY+HH+oz2n8HJJvQ7Irrq26x/mB4oN30Kbs5F44SVaYp0On+fy5M1DHjQ2Skp5CzXDiQDYxwk+UHc+t/4Wi1OjhqIoJl/a1sH5uXtYz97eTnz6LByTWDBe2XhRFPoNcxDPGMtNPseeFy8GxBLFK0yQ9eUuvI7QdRxDEJySAhnCdfqNuNA0QfLgoSqD+S+oQHtGmS+px0Khn+cOcVfrqTZr+wile1elBRjZkxSNrww4kFcDXfp+kBtOP9Y1ABus27LKTr70A27e4UtA/UqaUAt5iMskSqHmnXLCp5UK2JKoVYW0GxCJ/jny0R86dbi3f2jFxjuIOn21VAvsl2gG7uVGc5Xl1TU5BGFY4OpgSBa48/Y0ew8IZO7QnRKlfdiPUV+cJvP/dnqG7M5TaxItIoI813G2oJxCFATKv0NdQa0Dv3KznMDFR8pjHeg3CVvAPUiBLOGGfhiCN180BOIB4Aw99V6k0n8GgUBKbC3To3wt/vXnSnbGqXnHK13gFhg8aNsAcmel3xUiYP5aoggQSY7n7on2rcdGdNJqcdtVR37LvnB8+GOySqsHDXAcGOZiYLOlXhErRvEs9pETKSLmOaEo+4wRFR1TXFaAbj40SsIEc/DDMQ9XgsJLrpYjqLRFSlg==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b9b379c-4568-4b68-30c1-08db0dff58d3
X-MS-Exchange-CrossTenant-AuthSource: MW4PR10MB6535.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2023 20:17:36.3013
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GTOsiOEWFVwkDHsgoX5hWAFbSzwZmzs1dRXn9ZSnGZSiqTqr4B34+GiIlx56Sm+n6if6jY9Fx8UrVaJP3ltQqw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR10MB6501
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-13_12,2023-02-13_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 phishscore=0
 suspectscore=0 mlxscore=0 spamscore=0 mlxlogscore=999 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302130178
X-Proofpoint-ORIG-GUID: R5jRQHndacG9aP6bklCMCIGyyBdve9NV
X-Proofpoint-GUID: R5jRQHndacG9aP6bklCMCIGyyBdve9NV
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+ Eugenio

On 2/11/2023 10:55 PM, Eli Cohen wrote:
>
> On 11/02/2023 8:08, Si-Wei Liu wrote:
>> Otherwise the virtqueue object to instate could point to invalid address
>> that was unmapped from the MTT:
>>
>>    mlx5_core 0000:41:04.2: mlx5_cmd_out_err:782:(pid 8321):
>>    CREATE_GENERAL_OBJECT(0xa00) op_mod(0xd) failed, status
>>    bad parameter(0x3), syndrome (0x5fa1c), err(-22)
> I am familiar with this issue but I think it should be handled at the 
> qemu level. This logic just hides the real problem. qemu provides the 
> iova and the VQs' addresses so it should not shrink the map while such 
> that VQ addresses are out of the iova range.

Here the whole device is already suspended, which should guarantee no 
further DMA memory access will be initiated by the device. What is the 
problem the mapping can't shrink in this case? Noted the code already 
allows shrinking for the reset case (~VIRTIO_CONFIG_S_DRIVER_OK status 
check), I see no essential difference the same couldn't be applied to 
the suspend case. On the other hand, map shrinking works well with 
platform IOMMU iommu_map/unmap() calls while vdpa device is suspended.

If your concern is that the device won't work with the shrunk map once 
the device is to be RESUME'd, I think I agree that's what QEMU has to 
guarantee, by either adding back the required mapping entries as needed, 
or change VQ addresses during suspend that points to mapped IOVA 
addresses. Or both can be done at the same time during suspend, with 
that we can build a fast path to switch svq mode with on-chip IOMMU e.g. 
mlx5_vdpa, rather than go through full device reset cycle.

>>
>> While at it, add warning message to tell apart which object is
>> responsible for the CREATE_GENERAL_OBJECT command failure.
>>
>> Fixes: cae15c2ed8e6 ("vdpa/mlx5: Implement susupend virtqueue callback")
>> Cc: Eli Cohen <elic@nvidia.com>
>> Signed-off-by: Si-Wei Liu <si-wei.liu@oracle.com>
>> ---
>>   drivers/vdpa/mlx5/net/mlx5_vnet.c | 17 ++++++++++++++---
>>   1 file changed, 14 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c 
>> b/drivers/vdpa/mlx5/net/mlx5_vnet.c
>> index 3a6dbbc6..c05c7f6 100644
>> --- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
>> +++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
>> @@ -165,6 +165,7 @@ struct mlx5_vdpa_net {
>>       u32 cur_num_vqs;
>>       u32 rqt_size;
>>       bool nb_registered;
>> +    bool suspended;
>>       struct notifier_block nb;
>>       struct vdpa_callback config_cb;
>>       struct mlx5_vdpa_wq_ent cvq_ent;
>> @@ -1245,12 +1246,18 @@ static int setup_vq(struct mlx5_vdpa_net 
>> *ndev, struct mlx5_vdpa_virtqueue *mvq)
>>           goto err_connect;
>>         err = counter_set_alloc(ndev, mvq);
>> -    if (err)
>> +    if (err) {
>> +        mlx5_vdpa_warn(&ndev->mvdev, "failed to alloc counter on vq 
>> idx %d(%d)\n",
>> +                   idx, err);
> Although you mention in the commit log, maybe it's better to have a 
> separate patch for improving warning messages.
Alright, I will move the improved warning message out of this patch. 
This issue effectively blocks live migrating mlx5_vdpa device that has 
to get merged asap. While others can post patches to improve warnings on 
top.


Thanks,
-Siwei

>>           goto err_counter;
>> +    }
>>         err = create_virtqueue(ndev, mvq);
>> -    if (err)
>> +    if (err) {
>> +        mlx5_vdpa_warn(&ndev->mvdev, "failed to create virtqueue idx 
>> %d(%d)\n",
>> +                   idx, err);
>>           goto err_connect;
>> +    }
>>         if (mvq->ready) {
>>           err = modify_virtqueue(ndev, mvq, 
>> MLX5_VIRTIO_NET_Q_OBJECT_STATE_RDY);
>> @@ -2411,7 +2418,7 @@ static int mlx5_vdpa_change_map(struct 
>> mlx5_vdpa_dev *mvdev,
>>       if (err)
>>           goto err_mr;
>>   -    if (!(mvdev->status & VIRTIO_CONFIG_S_DRIVER_OK))
>> +    if (!(mvdev->status & VIRTIO_CONFIG_S_DRIVER_OK) || 
>> ndev->suspended)
>>           goto err_mr;
>>         restore_channels_info(ndev);
>> @@ -2580,6 +2587,7 @@ static int mlx5_vdpa_reset(struct vdpa_device 
>> *vdev)
>>       mlx5_vdpa_destroy_mr(&ndev->mvdev);
>>       ndev->mvdev.status = 0;
>>       ndev->cur_num_vqs = 0;
>> +    ndev->suspended = false;
>>       ndev->mvdev.cvq.received_desc = 0;
>>       ndev->mvdev.cvq.completed_desc = 0;
>>       memset(ndev->event_cbs, 0, sizeof(*ndev->event_cbs) * 
>> (mvdev->max_vqs + 1));
>> @@ -2815,6 +2823,8 @@ static int mlx5_vdpa_suspend(struct vdpa_device 
>> *vdev)
>>       struct mlx5_vdpa_virtqueue *mvq;
>>       int i;
>>   +    mlx5_vdpa_info(mvdev, "suspending device\n");
>> +
>>       down_write(&ndev->reslock);
>>       ndev->nb_registered = false;
>>       mlx5_notifier_unregister(mvdev->mdev, &ndev->nb);
>> @@ -2824,6 +2834,7 @@ static int mlx5_vdpa_suspend(struct vdpa_device 
>> *vdev)
>>           suspend_vq(ndev, mvq);
>>       }
>>       mlx5_vdpa_cvq_suspend(mvdev);
>> +    ndev->suspended = true;
>>       up_write(&ndev->reslock);
>>       return 0;
>>   }

