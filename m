Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36717700D97
	for <lists+linux-kernel@lfdr.de>; Fri, 12 May 2023 19:04:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237795AbjELRE0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 May 2023 13:04:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237701AbjELREX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 May 2023 13:04:23 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 973AAEB
        for <linux-kernel@vger.kernel.org>; Fri, 12 May 2023 10:04:22 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34CF49L1010136;
        Fri, 12 May 2023 17:04:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=Tj5Brq9IiymGAt4RNESREOCdOeizSeaBQisJylHAziI=;
 b=ZR9x3OmTbQOazukm9V8S3BqpcsYnfDBIZsAFRjOZpE2KegHFXOb31EcrBX4Z/db/A9aX
 D6Hwhrt3pBEzXarz0OR/rL9ihqNx5LxXZqSU4gf2scUvoEzWVvXZuodv8wRMqdVPO3Wz
 nGbse8c5wiir54lMBbo7fQKb6ERfoK8By4D1PXOZGLKieY/IVkymPk9goOzXQCTopyVq
 Sb6nPrCn0kUC0crQpRtnOEmR00WDVwgeA+pqqAzTpFqhGkl9xNvTlDOxJJXGuk+vKe51
 yEi9wOplu0K8q4BuFrjMWJEHsm2toEWH/aw6WR/OJjXRBldiB+mlXhXvJ/2FHMqYoU4k Xg== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3qf776u25x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 12 May 2023 17:04:12 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 34CH2mmK014331;
        Fri, 12 May 2023 17:04:08 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2177.outbound.protection.outlook.com [104.47.56.177])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3qf8313m2j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 12 May 2023 17:04:08 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q4l1P9B9ZDAmRQekvwOVTy6XqkUs/l/0iBOwERT2JzzPzEn6uGbjZyGuIvstQpWixvMJw3muD6hqcdUyW5sgXuoT1YBx6Whe5jz9QropRcsc45kcWi8/icr/lQp35Ki21BK61998XWWzAb6aZ0Xvrs/LoaULJe5HoJmS74SBmE5eNpc/jrbXDEQVMob7xIDhuQbTvT96TC6IXExdsMpguAojsQLaRr84X5RtqmKCnVYeaL5YoFq1Lh2mANDOxqXVB7bo4Pkxlhiyu3LOJiPUR9L78zihYIpsozX3FXiVi3QHRUQIMxetv7qKN2gw9/txj+CDfne3i6PVESr+n/9IIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Tj5Brq9IiymGAt4RNESREOCdOeizSeaBQisJylHAziI=;
 b=WF822hsFUTxRF6Dcxp8/NgJ8E7pgmmtQz2PRzwc5u9I0BLp+YaVPDrpsowfK+OPZ+hRjjgaVVW86vcbXriE24BJu4MIKS56NyvSeVrjPaJC7xAeYi4EpjkGvIHSTTmcyil1QyJ0dZ6dMYt+1Qy20fjiZhX3Yu6Gy4bCEzY96iaX4CSlnKa/BhRCZOWRd5QqYLT1BAYJP1QVLWwLWssy4LsnDIXsw/7xpomHkUYs0fpzIy7ULCRPLqMSi2EIRAkBCRqih6T0DuDzGgPtVO/BLSLnww3+2zZug+0lwgHePb8ddqd4z57R/No5ZEwJMQdV5z2zQaOmhPGzxOT6t17P3yQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Tj5Brq9IiymGAt4RNESREOCdOeizSeaBQisJylHAziI=;
 b=uuLYzZ9ebkoULdIpf+h8Q/TESGtyAJBh3RdjeGEmLFTVr5/HPuHRUWAmR7weZvDKTo6C9+ZbtASxKNR2mw2usA/zwmyWk6COxS9zJckQsthT73Cn58wCHT2i3CAGSRjG2dgordcoMiPa9oKiEPP4L9cW6E8wlj01JjjNbaQHF1I=
Received: from CH3PR10MB6810.namprd10.prod.outlook.com (2603:10b6:610:140::15)
 by SA1PR10MB6391.namprd10.prod.outlook.com (2603:10b6:806:257::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.20; Fri, 12 May
 2023 17:04:06 +0000
Received: from CH3PR10MB6810.namprd10.prod.outlook.com
 ([fe80::ba49:e5dd:6a80:37ae]) by CH3PR10MB6810.namprd10.prod.outlook.com
 ([fe80::ba49:e5dd:6a80:37ae%6]) with mapi id 15.20.6387.018; Fri, 12 May 2023
 17:04:06 +0000
Message-ID: <4824666a-baa6-f380-5e79-3e13303abf8d@oracle.com>
Date:   Fri, 12 May 2023 11:04:03 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] mm, compaction: Skip all pinned pages during scan
Content-Language: en-US
To:     Matthew Wilcox <willy@infradead.org>
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Steve Sistare <steven.sistare@oracle.com>
References: <20230511165516.77957-1-khalid.aziz@oracle.com>
 <ZF5g3p+FFc4Gkw69@casper.infradead.org>
From:   Khalid Aziz <khalid.aziz@oracle.com>
In-Reply-To: <ZF5g3p+FFc4Gkw69@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0333.namprd03.prod.outlook.com
 (2603:10b6:a03:39c::8) To CH3PR10MB6810.namprd10.prod.outlook.com
 (2603:10b6:610:140::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR10MB6810:EE_|SA1PR10MB6391:EE_
X-MS-Office365-Filtering-Correlation-Id: 55f4eed9-a390-451c-ce18-08db530ae4db
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0U23gjfoj+jjbvx84gs3xzL/mApcuaJGrXHvcwnra7uHcMqjwJb5/R+9g7z2lPPuLgvUSgxqyN3NOGA7+gfYLxKV01mKJDrZlsJr6pTi0bqmT5WnLnCPtXj/0Pylv2d+H8tlSJXLq1ZYuyU1DazRttP/3pwSlpLte+xEp10+TjvBOdbQO1SBMyTz1JbPlnpj+g/X0b9iQYmrFcWHID0Yq21EQS+YbkxfjVD0COaP9nxSubFTTLFrYIQLWw1wYuLJWrup671ytMd7FUi7Kz8Hgq5Mxv4gxFdrS+n3q75W+pm6hzc3nkDKRH6GPmPA3BOm5e7pV4x5/50EIYGfVgPyB76qdvjsaEI3/OWOYZwV3aoou6Vscn+pnbVpcL3H7gO6Ldb2h3JEnKUE8AmqJLtMUmbAJM7ZTFw1PD9iU5ZqkxHxrHagKkUuFDj9lbgR7KxIixW7XpMOm5N9CujBKNz8Bg4hgmakW3EByq73k1jfpkDd7yJVhzv5G2piYODXFP8aC57im4ZvxKgg6rEPpWRBRGf2lWiBc7/dRVWpHIoI7TYY3rBNpV0MLEMjozBqXd8MlvYLIhEnqv4CVv4g2Hlc+WZBGKdmcMzyrs7+4b5PUdv3WK2uNr50cWLUZtmwVk4QbcjiAdmumCbppnIAykMMpQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR10MB6810.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(346002)(136003)(39860400002)(376002)(396003)(451199021)(6486002)(31696002)(2616005)(107886003)(6666004)(8936002)(8676002)(86362001)(38100700002)(53546011)(36756003)(186003)(2906002)(5660300002)(26005)(44832011)(478600001)(6506007)(316002)(6512007)(66946007)(6916009)(31686004)(83380400001)(66476007)(66556008)(4326008)(41300700001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?M1dtZmhwN3pHbmZZczRKRHA3dys5NnNzVHpXUXEzbnJCQ2djYXRlaGwyUnpQ?=
 =?utf-8?B?S2Y0TFZDK2RmTkxtRUpXSnBpSUl1VXRFWG1SeSthdVcvSGE3RnkwS3pjQ1hX?=
 =?utf-8?B?cUpQend1UjlSU3FBVzZDc3d2aXJsOEd3OWJpcnFaOGtPS3FwL0tnTDRvazFO?=
 =?utf-8?B?TGRNUEhFdi9Ba2ZxWHF5Q21OVGlod1ZieHpaV2hYTEwreVFOM1I2RHNZMzJy?=
 =?utf-8?B?U0FpY2pIY1cyMS95b0tocFJTdG1iMzZGR0RtUnR2ZmlsbTRlcjExSWRzcXlZ?=
 =?utf-8?B?M2xJM1B6bENkZHVYTVYwUGJrL1hpNHY3eUlEeWtULzlVTVJtVzd6MFZTdnp4?=
 =?utf-8?B?WjNHcHdsV2YyNW04QldNTFBCQUJnTWl1Y1FISFJJaHFJRSttRjhTbkpKdTdt?=
 =?utf-8?B?enJEU08ydG5FeUczV0RtNWtac0pTZm5hdmNWZ2daVnBSQUN0WklkWWMra3Bo?=
 =?utf-8?B?c1F4Z3MzRzF0VnhGbHZWMzVLQWtaeWdQeThDZm1id3U0bUVlLzRSOUhvQmVm?=
 =?utf-8?B?dVlTQ1ByYjUzZVVWV2IyUFgwcjhIZ3ZGK1V2czY5eDF0NVREUUNiWElpc2Fq?=
 =?utf-8?B?bmlxK2JLSkQxTjNxNGJLWTF2Y0htYXh6RVl0eTlKSGw1QU5sWjVDc3dJV3Ft?=
 =?utf-8?B?RlEreDlWSWRUQ2hTY09mZCtXYngvM1FwSzdtckNlSWxzK2Q3N3M3bk9ScWMw?=
 =?utf-8?B?QTB3eGJrY1A2Z01DZFZzNWFTT0x1SlpCZE5tS1Z0dnUveUgwNUVOeWl5NEUy?=
 =?utf-8?B?MTZRTUdqdGhldWJPV2R3a2NyV25WM3d0RzI0VXBQaTUyNlIyTi9jblZFSHJr?=
 =?utf-8?B?VS9WaHhDVjRMOXNGTGZrcmRSVkJtTmxUM1JQS3VvWEN2WGVNaGNFYmo2elBR?=
 =?utf-8?B?N3RKRGg5T0h0cllXbzdNV1F4RDcyS2Q5N3BTTHVUNjkrUmFhRjhPUG1uUE5K?=
 =?utf-8?B?ZlRjTzBBd2tBQmc2bUVyT2g1YnZHSzJJNjBpQ2FCTFlaU1pYZi9NNzh1dk1q?=
 =?utf-8?B?QkppTzhSTjR1MGhzOXlLRmhtWXc4aW96YXNFdmpONEV5QTdjcTRnRjVDdnpK?=
 =?utf-8?B?TVd0OFZ3TTRmZHJiL0cyZTh6VmNEelZ3UDJYUWVaSUtzQmdSRytkV1dxMWJm?=
 =?utf-8?B?bjNUMk91TGh0VmxkYmhQeTlkWHRicGVyZ1U5eG5FQ3k2d1d6RXJkSGVSaTR5?=
 =?utf-8?B?MWtjVkx0bE1jVS9GZWZKREc1UGYwbUhJWWQ1Q0QwTm9FY0NYM0NvdlRyZk5v?=
 =?utf-8?B?TU1hTUgvWXlEQXhpaElDc1lycUJKVWdYVENYNkpDUG13YTNtdHNYSDFMZi9r?=
 =?utf-8?B?ZkhYTTJ2WjdZb3JmVUNza1h6cmQ3QnNaR3FsaldaRlJSZllteUZXZVl5Z2Fv?=
 =?utf-8?B?SG90dnhLN21VS1BLWTYvaFE3QnB1a0gxZEJEeFlTeE9rQ1hLMTl6bmVYY1ZS?=
 =?utf-8?B?QUZ1S2NWM093ODBzcTRZVDJaMHUzRVJwNTAvN3dYZHBJV1BOdmFFcFRVaHBC?=
 =?utf-8?B?VkxQc2Nkdkg1OTFmZkFUcGh5V1NNb1ZWV2ZDanVwNFJhVVhLTW84Z1d2VzR4?=
 =?utf-8?B?TTE5a3ZydElENTNmcGZzeG5KRklLaXhoT2Y4ZVZpTjhza2c4MEZ1VnpMd2d2?=
 =?utf-8?B?M1d5OWZWZ1ZyNytlZlZZdTgvZGRUTlV6UTRHZzM4YUFza29UekQxbEFKcjZC?=
 =?utf-8?B?ZXd0eHJjL25TTFErUm1TeUhCWU1wRUdaK01LQWNrMzJnY2p2dGtBNUtoNE1s?=
 =?utf-8?B?YmR4TTdZUUhWaGlRL1NwVnhRK2Q1THZYOUhJSEFHaFlZQWlPRnh2U21EcXZ0?=
 =?utf-8?B?dUxqZThucDZuOEl1V2VyOEk3Zm1rNEdTYlJsT1QrNk5USndtTENZNUJKa1ZE?=
 =?utf-8?B?Szl4cEtWZE1WaUJBZlhaN0E0ekdYanpIU3F1T0I3aGJNQll4RWtvdTErWGN6?=
 =?utf-8?B?Y0RrSWdINFNHKzlQQkRhekJ4dlNKQWVoUC9rdTNZWE1rdEdlQ0Y3ZFJadUZx?=
 =?utf-8?B?ZkIwNEZ2OHhWWW1FdTlhMmpkdkl1cHdTNUQrbkkwWXdlS3dDL2ZrMHlpeWFN?=
 =?utf-8?B?c1RHUGwwaUh4cGlpYnNmQkx5UnlBMloyeG1KSUVjSGpldWtWcU44WE0yT04r?=
 =?utf-8?Q?RqJFrC07x5gj+OL86+3kPmr3F?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: NXSZ8wCyYiotwmaA+rtF5xgoiXMRy5th54iHKV8BPEqURgs5i8gmhOFt8XNNqRB0WUv3BRhKD/YvWSvcWWLiNpcZ3thSAY6e4as6AeTLbUBniFJGNqKHA5gzQzLMiE+zWTW1nVpzS2G/ZEhs/so87KiSufGQiGZS1uyYwX54lXghFmVOZ4WQh4U82lryBsmUCFOQpbRNTFjv36Kw6CXcWwqhGrUaBQFr19OccHdT/GIiZgMZw+flAryRfnV8sHG4uWdIPuEd5tA+BBz5zFoF0u3TjuEAV4iPvRDI/ar9/QaIrLnevK9TM1Q1KGdASJ6eC7WkSgI9jWtatWk2GpyMhK7mukHOIUTFSvsy3nx/Gv877Y+hrsHcSBs3pPQc1/GzABtQs3ajt4g78tIvBO6JeFSA7aZS9nljxp9KHVCI9eIQ2ouiXjL7tDciMnTTw44Ye9kPmvR/+pUE81yWDpoeu0fv1jsj5Y3qTndlCDmcuCInny62Nx6bAtoBR2vsPsCOcABr9JtxuXIo8lcmQZEO1B0v2FYxJU8rmPT0IVfXGywDPGp67QH60J//HbWMOv022e9plK2NggX96Q3D7Z672bhbuZV3C3j6/wWcQqWRfVdzLRNYmP7EnfozE+gYo+pe+YFxwgxVN5EyxhLYPxsjQ+cEfOoR7dREr0C1cLyWCIn2yBObk7EAF4hVtirxcY/vSkZpZXyRrvwF4PGeCYIr6MxuhsMPT9haNmQmM+5A0wfHTAOxif3pnpaE8LW19oVhPSlNbTx3uzsQO9BBTaxpzDOVsCeHI74I/IKYOmjv10EBLvo/T0CjLohikbIZuzFhobpDCG0y5cYMbtoHh8dv0GBfnP3NxYATj4T4HvWoaoArNKWMhP0di5qaSjsABLU5
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 55f4eed9-a390-451c-ce18-08db530ae4db
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB6810.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2023 17:04:06.3191
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ScQzZuWK4ggBVxG/xT3qATPZi6CMt6usmzpnHs0yit8OsQv1QHTA+YmFcfSpEm51442Mc8OLjThWkiJbTyXHlg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB6391
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-12_10,2023-05-05_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=967 malwarescore=0
 adultscore=0 mlxscore=0 bulkscore=0 suspectscore=0 spamscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305120142
X-Proofpoint-ORIG-GUID: VleQX1Q4C0xJ6UVnrwMR6rRRap13wztX
X-Proofpoint-GUID: VleQX1Q4C0xJ6UVnrwMR6rRRap13wztX
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Matthew,

Thanks for the review.

On 5/12/23 09:53, Matthew Wilcox wrote:
> On Thu, May 11, 2023 at 10:55:16AM -0600, Khalid Aziz wrote:
>> +/*
>> + * Check if this base page should be skipped from isolation because
>> + * it is pinned. This function is called for regular pages only, and not
>> + * for THP or hugetlbfs pages. This code is inspired by similar code
>> + * in migrate_vma_check_page(), can_split_folio() and
>> + * folio_migrate_mapping()
>> + */
>> +static inline bool is_pinned_page(struct page *page)
> 
> ... yet another reminder this file hasn't been converted to folios :-(
> This part is particularly hard because we don't have a refcount on the
> page yet, so it may be allocated or freed while we're looking at it
> which means we can't use folios _here_ because the Tail flag may get
> set which would cause the folio code to drop BUGs all over us.
> 
>> +{
>> +	unsigned long extra_refs;
>> +
>> +	/* anonymous page can have extra ref from page cache */
>> +	if (page_mapping(page))
> 
> We already did the work of calling page_mapping() in the caller.
> Probably best to pass it in here.

That makes sense. I will change that.

> 
>> +		extra_refs = 1 + page_has_private(page);
> 
> page_has_private() is wrong.  That's for determining if we need to call
> the release function.  Filesystems don't increment the refcount when
> they set PG_private_2.  This should just be PagePrivate().

I will fix that.

> 
>> +	else
>> +		extra_refs = PageSwapCache(page) ? 1 : 0;
>> +
>> +	/*
>> +	 * This is an admittedly racy check but good enough to determine
>> +	 * if a page should be isolated
>> +	 */
>> +	if ((page_count(page) - extra_refs) > page_mapcount(page))
> 
> page_count() includes a hidden call to compound_head(); you probably
> meant page_ref_count() here.

You are right.

> 
>>   		/*
>> -		 * Migration will fail if an anonymous page is pinned in memory,
>> -		 * so avoid taking lru_lock and isolating it unnecessarily in an
>> -		 * admittedly racy check.
>> +		 * Migration will fail if a page is pinned in memory,
>> +		 * so avoid taking lru_lock and isolating it unnecessarily
>>   		 */
>>   		mapping = page_mapping(page);
>> -		if (!mapping && (page_count(page) - 1) > total_mapcount(page))
>> +		if (is_pinned_page(page))
> 
> "pinned" now has two meanings when applied to pages, alas.  Better to
> say "If there are extra references to this page beyond those from the
> page/swap cache and page tables".
> 
> So it's probably also unwise to call it is_pinned_page().  Maybe
> 
> 		if (page_extra_refcounts(page)) ?

I like that better. I will make these modifications.

Thanks,
Khalid

