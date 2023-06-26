Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC14473E5EF
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jun 2023 19:01:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229901AbjFZRBG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 13:01:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229628AbjFZRBE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 13:01:04 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E62C5E71;
        Mon, 26 Jun 2023 10:01:03 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35QGoJOS013232;
        Mon, 26 Jun 2023 17:00:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=hOSj3JT8Xyo5CYEW8CxX6abiuDuH9sHpVruS2RhxgcM=;
 b=o4zqqucnEMyBuDpXwz6lrgseB1/PtINFkDRMcxl7MeOzrq/eW6ZP2ZRs5oum7OIjTdDt
 XSW2Ve8d0v5745vpA7VDg3qE8PJAEqP1p+WoNEqv+0hzfxQveW8P26r+9ZtcS6V6hWZT
 7k5mzYxiiLeCvR9v7o2jXvIqbeO54J3R5REBivHp59xnQ2N4KmtFbgBwA3b2iJR5kTvR
 g2Mw7KGkqNovn1S0BgYc2D5E4ly/wgDAYcyCVeTqFFzJeRecKnjkMjCSyEHQYqGb0UKr
 pjlrAYN1NVZ0Bzi0Cz/nnutlhV2RiO32uyO47WxTyXWw9+TdFjuqQTdmzK+ppccyCLYw Ug== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3rds1u334t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 26 Jun 2023 17:00:37 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 35QGtFjI005121;
        Mon, 26 Jun 2023 17:00:36 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2106.outbound.protection.outlook.com [104.47.55.106])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3rdpx9c1er-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 26 Jun 2023 17:00:36 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BQeaEgTmaRpdANB0L43YKvQGOq2uViRCX9vRltNg1+sNM5ogh1wS/CSSynQVWqvmd8sVNda3LyDC5T3o1K5+MyWFw9ovm9u9BjfogwAOA1dZOQ2/0wkNTLP/CIsrew+o2vQBX+nGnYznTV7+4cYhIsLnXmtKVW575gv5id4tQBPb4cwpKU2MkEmA6br3XSAzYwuyHqpNkefcDesbkE94KWyVgUD8WZYtquUYJZ1x6ztMlQspjhD4dynniAUAhCLnUmutqonUpFqxFi0SUWYW7n5rFljQoIdilv9YW9+wkMy01WcImpRolalLsC9vetMoL+2NBfbmwVTx3zd3CDD7uA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hOSj3JT8Xyo5CYEW8CxX6abiuDuH9sHpVruS2RhxgcM=;
 b=CngWDpulWif5ujHXENNGK9Fnw6vxP1/J2HqtvzAujuv3zjFie+mRw6J7b2zVreCQIopnX5U+7K3IiyzkLVWNeKzWm7EqgdN0DwO5H86oiLE7UrkFXl1PPHcy5t5ZHDzsoMXAt13eRQP5AhThMUyebKeO5cpG8jtsPCMvHxaZT52p4dZT62dqfE6lrxGMaWsWh+xaYMAL5W5ODsG3ZGy55wf3naN+pjnwb2A7DaDSiBDB/CT2LNyXSN2oaOYYPvcb5GmArwq7CmW2XaE7lq0x3H2QTNo1zXRf1+7xlDsOTJr5ehGVEXpHnIGepvVEqh4roGD+W39qhmSPhBSt762LtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hOSj3JT8Xyo5CYEW8CxX6abiuDuH9sHpVruS2RhxgcM=;
 b=DzjzjoGqv7eJtgzvu86fiTeLhLMAN9uijSPmXs/hl1E1fZNI733cgWUSAvsuwy60vtr8t12hylyGJuE7CgcsbNjI6om6VycOCxKhbYPRYQtgMqtOBnnj9lURHGfmIXAig2sHNqQ8MpsnG7SVQeGtPLCEfNK1HVooZ5h6Rg6Ii7Q=
Received: from MW5PR10MB5738.namprd10.prod.outlook.com (2603:10b6:303:19b::14)
 by SJ0PR10MB4479.namprd10.prod.outlook.com (2603:10b6:a03:2af::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.24; Mon, 26 Jun
 2023 17:00:33 +0000
Received: from MW5PR10MB5738.namprd10.prod.outlook.com
 ([fe80::9c17:d256:43b9:7e96]) by MW5PR10MB5738.namprd10.prod.outlook.com
 ([fe80::9c17:d256:43b9:7e96%6]) with mapi id 15.20.6521.023; Mon, 26 Jun 2023
 17:00:33 +0000
Message-ID: <25821273-d391-1502-ff8a-07ea7a59c8f3@oracle.com>
Date:   Mon, 26 Jun 2023 12:00:30 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: Duplicate unicode tables in smb/cifs/jfs
To:     "Dr. David Alan Gilbert" <linux@treblig.org>, sfrench@samba.org,
        linkinjeon@kernel.org
Cc:     jfs-discussion@lists.sourceforge.net, linux-cifs@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <ZJhPIYSUzBpuqosh@gallifrey>
Content-Language: en-US
From:   Dave Kleikamp <dave.kleikamp@oracle.com>
In-Reply-To: <ZJhPIYSUzBpuqosh@gallifrey>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR04CA0100.namprd04.prod.outlook.com
 (2603:10b6:610:75::15) To MW5PR10MB5738.namprd10.prod.outlook.com
 (2603:10b6:303:19b::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW5PR10MB5738:EE_|SJ0PR10MB4479:EE_
X-MS-Office365-Filtering-Correlation-Id: f625c388-ad75-4646-8e5e-08db7666dac3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1i2ssWy57E8K8rd3fYBY4TYnJvWYTlwWO93posqc+hZEiTBI/bolLNDykNQ5ZEuoK+F0OK/JdXUWTNn76/wbrTRktltFovEQ5cm6MP6lfYmzdFF7RebhGUMj3iuKYZ9ec+IzKeTrO5DOASbSgMB9dGVFn/kxCQ7flytMrfhvLyupCdAx/7a6rOcKMzTQ1zrD9inm6zHRrnfILjCdF2rrMI+omNw6T0z/c5HiJxa0VJmiamEeduRLuFvfARyUrqoBMgGo4BTFElmTkaXMXNnKyp8Z7vMfYlz6RNY9vNfOHZ65YGBGw+lMG4VQ2LKjwuR9/uAxM/KmCI1rugWeUhzaUpM6S8rXHf+BBoIYLOGDu4ZZGzZPuUDOX11JKX//Bwy4Iwv3TVW5GpUsEXZSqs1jAwXebH5HuYlL24k6WQozPaMgj3lxTQZJ7zk4zRbRGVq4jxq7Lro2os2rKDdwbR7n0kYX9Ouhrj+e4yIRG0RBaO3dv8cNCX23YOvl9Q4LLiPes+YgyMDjVCij37hRHT4njem1/yuzwiMyXOCuFJIVEtVu0mGG0p7fy+GqiHZ3KkIdQLwaQmKYBl9Vjcua5N80XURVO6G+KCvPaNFtYk8V2MwZftITQGwiXQP8WnQyION/b4jxoWV054WmANMo3Tq+jQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW5PR10MB5738.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(136003)(376002)(346002)(396003)(366004)(451199021)(6512007)(44832011)(31686004)(66556008)(66946007)(66476007)(4326008)(478600001)(316002)(36756003)(8936002)(8676002)(5660300002)(26005)(2906002)(31696002)(86362001)(41300700001)(6486002)(186003)(6506007)(2616005)(38100700002)(83380400001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aG9iWS9TTldGK25ZWHlLTk85Rk1zNlU2TFJXVzlpSU5MdjhMczg4T2JPWkpO?=
 =?utf-8?B?V1NHRldxV3g1RFc1eGorUW9jckUzMEYxTkZ5dHhpdGpWMjNRUHZXS081eDBv?=
 =?utf-8?B?Z2RNc2tEWjhMSHJ3ZFdMdTFrNTlHWTNDQW5kcWgxbEp6Q1NST0hIbXVGWU1M?=
 =?utf-8?B?TlNnSkZ2K002WjNQaCtOazJROTZYd0JxKzRjUTlEZStHMEhQNC9uaVZ5REwz?=
 =?utf-8?B?OTJkT200YnIra1UxZjNBYmxEZkJaUm5KUTVFSCtieXJnakJ3bEFxdk1DdHdR?=
 =?utf-8?B?UEloajd5a0EyRm90T2Q2d3pBU2p6L1FvcDVwWG05ZkthOFhoY3FEc1U2YmFq?=
 =?utf-8?B?WkVPMFVvcEd4UlhsRXg1ZkkyRVlTN0haWk55djBIdk93VlowVEMwOFRXOTFq?=
 =?utf-8?B?ODhEd0c4djBNOWJJc2psTklGdUVBTzFSQkJKd3puQ2xDd3Fnd0t6NXFkeVNY?=
 =?utf-8?B?WnFrajNOWkJIN3BMZS9oRTVSaTNmelEyS2gwUjhrNGswbWs5WHRHUVlLdnBC?=
 =?utf-8?B?ZGdwclREV3F3TXdmb3kreExtZDdrQzhRYlhBMVlrRnVNdjM1bUM5TFRuMHJl?=
 =?utf-8?B?R05GcFYzYmt5N2REdTY1TFYwMFdqTyt6c0QvYmNjWFZlY1BZYi9reUNYdjQz?=
 =?utf-8?B?NXhlMEgwbWwwNTNLT2ZpTjEvSmwyNU1aaGFBd0p0TEQ2SmUxNDU1a1VTekJF?=
 =?utf-8?B?ZWxUSXdpZEk1UXBGZnZCMjdPdkpUcStxUEJ2bWdTenI3NU5uajFYOHorLys5?=
 =?utf-8?B?NlB0Sk05UHNTMmw2endZK3ZRZ0tndk9DUVBZNnY1M3BWblNPMFBRMnNRY1Q5?=
 =?utf-8?B?UUorV2V4c2VFYS9mMGZ2K1dIbDZnQjVwR2Vja0kvL3hYK1FuMFEyVCt2L2Z1?=
 =?utf-8?B?b2UvcGVtNjF6bVJlRmhLVGJ1Vm93NW9RMkFzRUllRzBqZUlFTUFmaDhZZkNH?=
 =?utf-8?B?RnBVUzZNOTYyN0NPZ1RHN21teUg1enNwOUhNUnhHMTNEaWZ3TlRyV1dvQ0Fi?=
 =?utf-8?B?NkRzbStWK3N3Vjg3WndRcExqbkZwa0NURFdKQjVhTnJ0OHMyMnpLbFVJSFVj?=
 =?utf-8?B?RlMzUlRpeVFJU1l3RGZ5akluY2c3YmJCNFhmb2ZZdFBTWDNKMVZhS1p6ZklI?=
 =?utf-8?B?MFlZMzY2ajZHeGo1Vng4K0FzSFNHZlFvWG53cXE0eHJqbkVMMk5yb3pyT3VJ?=
 =?utf-8?B?V2hGTmtKUjdTRm9oTkZ1Vm1pTWY1TFhNU05QTk16SEgrdTJva2JyQUJUNm1p?=
 =?utf-8?B?TUliU29SNGhqZ3prblc3VHR5ZkdMTC85RVhnQ1p2SjhXZVIxbjVpVVliTUNs?=
 =?utf-8?B?RndTTFdaNjZYTnRObDNBMzlVRDNzdU82d2VHRWhNQzhaNHlvcTFCZWdmSkhw?=
 =?utf-8?B?VE55ekZ6bzl2V2xiSzNNZ0ZkUmtHam5seVNNR2g2U21INCtCdUFQamdUdml6?=
 =?utf-8?B?dFUzSGJ4OFFvM2RxL0loTVJ1UFMrRndER3NDZDFKVVl2Y3owVERYeitxN01D?=
 =?utf-8?B?bDh6M0JtS2tzVGQyc3VVYU9SWVJwK0RvMFc0dWlNdlViek9CU2IrZ2Y3aURk?=
 =?utf-8?B?eFBhTVhvTllqajlqeGU3aUJpMjh3TnNEUkxDVmEvQTJSMTAyb0RTdUljbHRM?=
 =?utf-8?B?eHo5cjVWTm5QV1ovUzFSOEFOS0RtcnVhVkwramZmcEdxTjY5UFlPQlo2UEV1?=
 =?utf-8?B?ZzFsbWFsWlhJWXFNb1BjQWVqWldTTDYrMWpQY00xUUJpYjlOT283Y1RwdlZU?=
 =?utf-8?B?K3RoaDBvMkpBZU9Fend5UmVmVW45RE5RcVlkODlxSGtYaE41Ukp1VWJwZG53?=
 =?utf-8?B?T0hhZ1RyTm93UE9jS3V4OU9VWEdWY0oveWJDOGlMUEsrVUhJTXhrYXBVQkpG?=
 =?utf-8?B?WGJDU0tBOXZIY2hmOXVGTVByRWFJYTRlSzkxUnpaaGZzZW5YKzUxK0crUjZM?=
 =?utf-8?B?UFNvMnBENkFNWGlFUitkSEdjcUhNbVUxaFFlaEV5VVR1VlVFL1pMTzJyR1ZK?=
 =?utf-8?B?MHErUVR6Q2t1dU9LT0JPU294aVFJR3pwdHhWTzlkUlFOdmt1Rkd6QXltRmZM?=
 =?utf-8?B?Q2xqaytUemt1NUpLMFJSdVRtdHd6S1hqSUpLT1pWSWU5eEFtd3grcmFtK1BE?=
 =?utf-8?B?UW12MGF1b0tBbUYxcGNmKzRScmp1dVJiVzI5dzREeWxhb2s2bVBzaXkvRWlx?=
 =?utf-8?B?WGc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 2+PXWLqxhNozVN3S+Q7PcqPF669yyYCs1HGApXSQwrRMZ/SK9lh3LpRu+D+5LBonazo4W3NwYEgb3t0wkeSjfjamvMFB87urHTm8AoieF0QrsyBL9IqGN4UK05ZPWKrwAFmUEPKzMG3BPGbqReCOrtFB+v5ZaPp9vdy5IQ+vNl8ptHvBnvCSJcEOIzVsmtgRWoHjSmK7cT6LkUzL9cEskXwtWplyTL6lwSduxrhpR83I7M6covrfHwH9sgVSm5ZbwjXII/nm5v8DX/HcK4c3hacE3hICTvuYx7AZlv4d7wKSTHTaOpoZ187mmeY5n/Or6gdPHmpi4+iHXdAn8CiLIf8dYxWHBT2+X7fYsLFjnpvBrL3X0bqp5EuNVISMK7PZT1lQz2X7h0Jl5FSolFQtp+p7RQEZOWTz8Ag0at4pyFt9OT3f4ga4HVjQ6W1eynslcMbCbx/KDKqdBpKxF2yRnUWVcyom7e3RVQN5rjlgVuqUsdqSrFrB+2jqTodGkj4qvaoogNHXhaUbQG2pPspJjmUsePiVvU4mEhdtZvH1UpSCRYdKzw3AM2aEuZPZf5XvAakg0GoDRB++ZfUawC3y2m8TZYMEggmJCzuFXI2HgUB5SDTmDDYnByXvuT5JbGqC3IvNk1PmuV8v3zEARUm3cLetTj3PtscI+xUU+wVV9a+Iwh3XsDQbEMA+i+XIqWWQNVGS1FCtdc+Fc3T1pQ75nH/EVgRdcxFf0UadGu5EX5PFF1l/I6t/wdRF8kMqS+WKaYpQ+YTXpYFClY4t17X5jdPy6BYuz9vxeKEP4pvOX7FD+EXponzeRJ8iW7P0zqCJ2eVuiTLBQFdhhbFoF0ML3rmN1siB69N0LvAlMyfS/Fj9OK32kVsYBoKp5cOURW2lynD0cQ3XLr4yxFMe7udYfw==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f625c388-ad75-4646-8e5e-08db7666dac3
X-MS-Exchange-CrossTenant-AuthSource: MW5PR10MB5738.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2023 17:00:33.4021
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OpKIOFWK3KPovRdAsVpLVSxsL9frQwt/t4juaBOSl4RmL8GgCMvEZ4jtV+LmQ1bDJ4Vl/BcgvTOGAHyXPWTzHILhYVMhwyPqQ3q14X5/4/4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4479
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-26_14,2023-06-26_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0 mlxscore=0
 mlxlogscore=999 bulkscore=0 spamscore=0 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2305260000
 definitions=main-2306260155
X-Proofpoint-GUID: JHun2xAAPp8Lln3XLdjr3MfgJcCVmTGQ
X-Proofpoint-ORIG-GUID: JHun2xAAPp8Lln3XLdjr3MfgJcCVmTGQ
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/25/23 9:28AM, Dr. David Alan Gilbert wrote:
> Hi All,
>    I just tripped over three sets of duplicated unicode tables and
> wondered if anyone had tried to rationalise them:
> 
>    The pair of:
>     ./fs/smb/server/uniupr.h
>     ./fs/smb/client/cifs_uniupr.h
> 
>     are identical except for formatting.
> 
> ./fs/jfs/jfs_uniupr.c,
>    and I think this is the same with some change in variable name.

 From JFS's point of view, I wonder how relevant any of this code is. 
The Linux port of JFS originally was interested in compatibility with 
OS/2, which had case-insensitive file names. (Case-preserving, if I 
remember correctly, but names would match in a case-insensitive manner.)

I would be surprised if anyone cares about this feature anymore. Without 
a JFS_OS2 flag set in the superblock, none of the case-conversion code 
comes into play.

I assume SMB cares more about this and if Steve has an opinion on how to 
address this, I'd be happy to follow his lead. Probably better than 
ripping function out of JFS that could break some user that I'm not 
aware of.

Shaggy

> 
> (I'm guessing the same thing is implemented in a bunch of
> other places as well in a different way)
> 
> Would it make sense to swing fs/smb/server/uniupr.h up to
> hmm, maybe fs/uniupr.h, remove any of the cifs_ prefixes
> and then use the same include in all 3 places?
> 
> Maybe then later look at using some of the nls code?
> 
> Dave (who just tripped over this stuff)
> 
