Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E80A601C82
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 00:40:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229932AbiJQWkO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 18:40:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230273AbiJQWkI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 18:40:08 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79B4230F4F;
        Mon, 17 Oct 2022 15:40:06 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29HLmcuq008613;
        Mon, 17 Oct 2022 22:40:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=4J+q+FvVKbbUfhLqP6jmSpDs96DdVacTLa4lzGo6IrY=;
 b=Y2PJPFUP9CLsPP/VSiCl48AlPnstyWdq4oNkNUy3pWrf3tiJrhKa7t8jF3pYABly7Tq0
 cAOkcUpi1Wv3H9SScDoj56V0YOiet0P9dNF/8hwURKVcOjtiNUehfcS+qc5QV2X/pu4j
 KUZlDoBduR6i4E1HrN0udhA3NBiLLZnyglXfqLF2Ds8uGuG3r8eW82/J4HU7BWAK/1y5
 YZqvkR94KNInzmduxWjSICNRO6Kh2FO34nTzXffojGL1sj5Xn6dwoPNnelUnmFlsZnfi
 KP23iuu2XfOR2bOrgOm6U1ZqLaT2TgOR3sLtw4CnGtNvvc+EDMBjD/0YkKPpYJoSaTgc 1Q== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3k7mw3cx32-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 17 Oct 2022 22:40:05 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 29HKScw3036505;
        Mon, 17 Oct 2022 22:40:04 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2175.outbound.protection.outlook.com [104.47.56.175])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3k8htfa7vf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 17 Oct 2022 22:40:04 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LjIoA3JmCBtSN8fF84a/RbdtdWrbAaDYfKzOhpXfI/aWZ6QZyJ/xYy7I7NDIOmrfMZ/ZnedLaBkGeT5jPkCtEsvKXz6HbEAOlQvusnXykZ86iipuWVkzwV7vm1os3KbyaI4K6j/9XmmngoB6Sy0O3EmW72zhDjtaUGb4ZqwSAQFFbRI1l5xnH0hYZygnoepFxwHd0r/ENDLh/BRMuHhrHn5wfN/RZi9xj9zbuxTyeZqwSIkkkqn2Z7g3Oy3Yvyt5hlD9M3hQZgYxBSOAzrU6+3H88EUiK5cJ2oVxcpONJVm10zEtNCay7ryqQsG/7DnkrQflQHAjKisjPUN1n4ndig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4J+q+FvVKbbUfhLqP6jmSpDs96DdVacTLa4lzGo6IrY=;
 b=Nzcax9W25APq8mW2EpSbi4Ls0s5MHxepyot8VSViG/Y5boKuiJXXZIAO/ev4a115RTAcsLIw3nCGjIhVrWjSPUmkgA6CV/INg9dBpuqeasXGBsbTGmDTWxnQAN6bV/ox7ysnpS6BNg0AHK794QDWhu237XdZj/4TdRYorMLeoJDf4ektuxZJ9svEqsQ0iiCbtal03rSKmumNEzBniAZkOT4l8TiO1sL8a9aA0LU7dCGLPQqbiIpB3m/dF6rN0e0dus7OLQiePNr4arIWN6DWK39GoKmbtSaS9bSypntfF9i5Plgl8AMlmVVzl5/WsYZUeCk31JAm6rkFSQ3ouY+RFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4J+q+FvVKbbUfhLqP6jmSpDs96DdVacTLa4lzGo6IrY=;
 b=y75qlyscv8rHucmp7BTEWjBFghZCg9uLFSUiJqatB55kGCfrzBuh7AQ/jLuUY3v+AuwpZVs4U8aLqKuET+G7whIYsq72Qb8dZFXnHPqp5mS5XgPfq/o42bdCNe7hqF/hGdf3l8oPipxLtSXORSN1+1JbCmZo7S2tAalxPPHA3Ic=
Received: from MW5PR10MB5738.namprd10.prod.outlook.com (2603:10b6:303:19b::14)
 by PH0PR10MB5681.namprd10.prod.outlook.com (2603:10b6:510:146::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.26; Mon, 17 Oct
 2022 22:40:02 +0000
Received: from MW5PR10MB5738.namprd10.prod.outlook.com
 ([fe80::56fd:b251:fc9e:aee4]) by MW5PR10MB5738.namprd10.prod.outlook.com
 ([fe80::56fd:b251:fc9e:aee4%3]) with mapi id 15.20.5723.033; Mon, 17 Oct 2022
 22:40:02 +0000
Message-ID: <f31307ae-8413-d25a-d602-76016a52f7a7@oracle.com>
Date:   Mon, 17 Oct 2022 17:39:59 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Subject: Re: [PATCH] jfs: remove redundant assignments to ipaimap and ipaimap2
Content-Language: en-US
To:     Colin Ian King <colin.i.king@gmail.com>
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20221017215636.863916-1-colin.i.king@gmail.com>
From:   Dave Kleikamp <dave.kleikamp@oracle.com>
In-Reply-To: <20221017215636.863916-1-colin.i.king@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR03CA0236.namprd03.prod.outlook.com
 (2603:10b6:610:e7::31) To MW5PR10MB5738.namprd10.prod.outlook.com
 (2603:10b6:303:19b::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW5PR10MB5738:EE_|PH0PR10MB5681:EE_
X-MS-Office365-Filtering-Correlation-Id: abe45768-7359-4d9e-6162-08dab0908758
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: juvznljDQ20QgZFXm2w79Ib+NMJVIi8TX2cihIuAJmC7EUG0TvyUkwTat0Vl5ngUMdOn8nAFJ6RYSeNf1jZirMax3IuHSlzDqi1ZlsgB5sNt56Lvs0DzD4lCITeoT/F86szzrqMHHiWgCcWOL27IDtABmacWJn9vq46LHlpo7pJnY9N9tQwOHJx8Kpqn0sUw4PwU5DZKytj9uQx2E0ZSB7+sUl9fTjKRJxGXDWUkD7WaBAk3BriVIcz6A7867ujCOPDzB9bfLzXxYOm6thtZyPJeKDonI2dcNJrdmUUv/1pA2mM5gwuQg0YOHFEohfwzAIuERH53KOsQzUwlAFsO2/8qoSMCioXw3ZSxbT2mAvShqSKPvMzaYLKTyi7gWX4PsOVCeAVSYczN843p2FbZo/4XYhATTG83kG/nmv3QDj97OmL6jvf5fSgGWAvpBwlKJu61XY4sXtWpB+hnUoE50Wvvylx6JL77o/79IbsnliB8al3l17QO03Q3Fs8UxNeL5jCYtJuvyM+D5+C05c2F3TBzuz6aJ78eASLXmeMp4O9ykoFZGwPaDcnmGRqiljjHxLxgJ74fHxgXbHTu3akvHju52PTG5XYIOFXvmEDZK3SK+2k155EygBWLfU5dEMPbY9K275TRZ3jBfJAZBqEw1sT5Lmpa0PFPHpfS3GH45gi3jLCNPKQ+GI+eeCUzFoGyd2l1lwY4MJDse5kr2TvPc2/pZauMknW6a2omdJS9sSNF+tA+dnSQXPkfiryIiXe+aM1GBFM4ccM2QOa424Fgp5z08SoxjXCJF2pQyAkUb+Q=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW5PR10MB5738.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(39860400002)(346002)(376002)(396003)(136003)(451199015)(6916009)(31686004)(66556008)(44832011)(8676002)(66476007)(316002)(478600001)(6512007)(4326008)(41300700001)(26005)(6506007)(186003)(2906002)(6486002)(5660300002)(8936002)(2616005)(36756003)(83380400001)(38100700002)(66946007)(6666004)(31696002)(86362001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Mkp6NmRINmN1cXdlb2p2S1NnZ3M5VXdQd1VadDBxd0FEem90TlNsSnF6UnBX?=
 =?utf-8?B?ZlRDazRXSkVTQTR2R0RLOHF3RjJsYnF1VURvZ2xpTmNZeVRORWtNTEtsUzdJ?=
 =?utf-8?B?SlhJRlhjZDBTRUhkQk9TTGpWb0JlUlVhSk1nTk0xOTRYT1c1dUIrdGw0dUNY?=
 =?utf-8?B?WnFJRGw5OHhxcU1FTXBtOGJPZElkbjIyamY0eFY3bzh2TE94M2NWU3hVT2h3?=
 =?utf-8?B?K2ZNL2V0OGJmRFk1enh4Mm9WL1JzK2ltV2daRFROVThCaWZ5M1VLdG85cDRJ?=
 =?utf-8?B?QTd2VzNzaUhnZkNPcnp5MTV1VFFDUkVrWk1WT3FoekVTSmxNU2lDb2dXSFFk?=
 =?utf-8?B?K054WXdSN2NlSEVWeUUyU01nRk91ajgybDNiR1JIZ29SbDZJVnBxMlZEVXVD?=
 =?utf-8?B?QUpqSlljcEttUGN4bURPVmlFQlVvZDZsYVFhVzVRWlpnZGdXc1pnRDBkVDBP?=
 =?utf-8?B?anhzVVpKOTlKcXRNU0xNa3VRY1IzemJta2p0SitTdWtGcUdMTjBlVEJTVVgr?=
 =?utf-8?B?NUk4SkVsajN3ZHpMVk43VitRTWovekoySVJDNFRYWTcwUzRpa2dOUEtrNFNn?=
 =?utf-8?B?UUY3NE5FT1BkODd0LzR3WXZkeUdlelJPRmJVZCs3SlVISUFSVncwQlRwNzNu?=
 =?utf-8?B?ZWpVcTlFdkpmdzkxRVN6c3RscGgzUEdmTGQ4bHRub0hOd2NZYXNPZFgyOFlq?=
 =?utf-8?B?UVhzVVdrcGd2eXM4N04wSGg4bUpoWlRjWG1rMnFnVHBIRHZWelNqSnNPZjhZ?=
 =?utf-8?B?WWNBNTdyaUhxakZFeDhPUWhmYkVHSnRITGxST3BnRERza3lrMGt3RXp0cDFr?=
 =?utf-8?B?Um15cTJzWngzelVERzVBYW5HM3FrSWVBalZiMTFvOUJNZ1BVdEw2ZUd2SkJQ?=
 =?utf-8?B?elhqa3FkU0dkWUxuL0pCQk9aTXJiZ1EzRld4WU9JTVpBS2tpcUFNb1l2NE8v?=
 =?utf-8?B?d25kcjZodW9Mc0JhcS9QY2lKbTlxSnJLVFdNRFEwa2pRWVVmNGtVOHdEWElC?=
 =?utf-8?B?YWhTZGRxWm9kZVFlQ0VhTmhDSTluSXQ3Y2JtbEo5aHZQaGlaNktYV0FZNksx?=
 =?utf-8?B?TmV1WEhVeExjRE5BWGdmblFXZEhzbDcvOFp4cE9qMFAxaGpDNElzdEFzMTl4?=
 =?utf-8?B?V0tqVUwzV1pPenZXZUNSZTJGbEcyM2h2TkIyRjN4Z3N4TkdQOTlsTDBvekRF?=
 =?utf-8?B?K015NlFyaDBEUHByWFJLcEpyNWhpaHRBb1l3VWxJNmZoV3hPbnNzMTFKZERt?=
 =?utf-8?B?T09HYnZaNW51eGVVUUxkVWFMNXBIeXl0ZWdXY1k3T2lnM3VrOHJUcURGTU05?=
 =?utf-8?B?dFFxaEFZRmFwczFpN2IxS1ZTVnREWDBvaHFIdjQzL2lMOW1NN3FUOTlaK281?=
 =?utf-8?B?SWlmZlUxRGFXbGtmMzdGNkxvVVFTTDR2NHRDZ0NMbWpJcUZVV0RSaTJ5bFNQ?=
 =?utf-8?B?VzFMZldHM3NES3ZuZjFsYkQ2YUpTMDJrM1ROSWxGMGgvOXhXRHd4N0JvNmIv?=
 =?utf-8?B?ZHJKTTdiL25QRCt3aElrbzBlYTRCRGdXcUV1VlMvVENhak1xamhERnhIYjRZ?=
 =?utf-8?B?QVYwYU1kSWxLK1BVTFpucTNZakxvYzNma00ySW1CZm9xMkpyazhaKzJGZjc4?=
 =?utf-8?B?ZGZYYVhzUUtGZW9ZT3I2U2MzcHVSeDJMTFhYWExWejBIMmd6MDBMUzk2dXRk?=
 =?utf-8?B?SzNtSitHc05idmpvakdBWVErcFRIWUdCV3Y1dXAyUmt1dEpZK01XNVlvWmZs?=
 =?utf-8?B?bHpJdllXakhiTVByTmp3UEp4K3VrRE1kb29sRjBRVkF3d3l0Um4yZ3dKQlFo?=
 =?utf-8?B?ZWt5VGZheUdpRXRMS2lDb0V6U3htSEIzVnZLS1hlZ1J3YTlKS0JWQWllaFVh?=
 =?utf-8?B?QUdkeU1CZmZqWXhFMnFCV2RHTnZiU2ozQ3ZNc1FWRkJiSGs3TS9JYlBLdG5I?=
 =?utf-8?B?NGFxakxpVmI0S3NWaDM4bzFrZXJXTm5oNlVCRjA1SHBuQlZraXkxNU43VDV3?=
 =?utf-8?B?VzdaUzJJQ3grcHhZZzRTaG05VHBXdXhIZ1FzZmNZcjZ2elRKV2pzSVIvemxF?=
 =?utf-8?B?dUZsNDJOdTZsOUw1Z0VDYWhsWjZMUlJlVUpwSUh6Y1FQT0hFeWZuRTR5ZkFI?=
 =?utf-8?B?NVQyVjZzVW5jbHlVZFVOVXhjRVplbFlGYUZzN2xSTWtGUWdCK0QwQXI1ZnVt?=
 =?utf-8?B?Rmc9PQ==?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: abe45768-7359-4d9e-6162-08dab0908758
X-MS-Exchange-CrossTenant-AuthSource: MW5PR10MB5738.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2022 22:40:02.0707
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KPfz0zrl7Pjc+iDjye4mXISYBMBQdKZh3QktD8jzNMf/XeMhl/A6C5bpewsMp8gyHrJtXbUQ/DJePYRoRhiMqub8bzJZPYpTlb53ITc+b+U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB5681
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-17_13,2022-10-17_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=857 phishscore=0
 suspectscore=0 spamscore=0 adultscore=0 mlxscore=0 malwarescore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2210170129
X-Proofpoint-ORIG-GUID: eBWoDvIbfoVeXzyzyYfOyx9d8YtzIg8K
X-Proofpoint-GUID: eBWoDvIbfoVeXzyzyYfOyx9d8YtzIg8K
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/17/22 4:56PM, Colin Ian King wrote:
> The pointers ipaimap and ipaimap2 are initialized with values that are
> never read, they are re-assigned later when they are required. The
> initializations are redundant and can be removed.

Hmm. Or we can remove the later assignments. That would seem more 
consistent with the ipbmap and ipimap.

> 
> Cleans up two clang scan build warnings:
> fs/jfs/jfs_umount.c:42:16: warning: Value stored to 'ipaimap' during
> its initialization is never read [deadcode.DeadStores]
> 
> fs/jfs/jfs_umount.c:43:16: warning: Value stored to 'ipaimap2' during
> its initialization is never read [deadcode.DeadStores]
> 
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
> ---
>   fs/jfs/jfs_umount.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/jfs/jfs_umount.c b/fs/jfs/jfs_umount.c
> index 3e8b13e6aa01..cc4d7e6e8a4b 100644
> --- a/fs/jfs/jfs_umount.c
> +++ b/fs/jfs/jfs_umount.c
> @@ -39,8 +39,8 @@ int jfs_umount(struct super_block *sb)
>   	struct jfs_sb_info *sbi = JFS_SBI(sb);
>   	struct inode *ipbmap = sbi->ipbmap;
>   	struct inode *ipimap = sbi->ipimap;
> -	struct inode *ipaimap = sbi->ipaimap;
> -	struct inode *ipaimap2 = sbi->ipaimap2;
> +	struct inode *ipaimap;
> +	struct inode *ipaimap2;
>   	struct jfs_log *log;
>   	int rc = 0;
>   
