Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7F5A5FE395
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Oct 2022 22:56:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229742AbiJMU4a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Oct 2022 16:56:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229591AbiJMU41 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Oct 2022 16:56:27 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0DFD183E22
        for <linux-kernel@vger.kernel.org>; Thu, 13 Oct 2022 13:56:26 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29DJxMgJ030643;
        Thu, 13 Oct 2022 20:55:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=dzrCGgG7tjhWeS+VrcO0H3tvhHThjfi/FSmeVDtDpxs=;
 b=eQfUiPiO2rVJ59qnEQ9/ZO8t0zl23nWkYHBZzlq9SCRVVyiUIJ+llRdxLer/agjdlMEg
 E28KvlYkmbh3U2EXLrc/dF0hjdgTSbuq5q9CkPWqPwEiOyvun7MKVOmlVtEF9GfwDWTK
 t0rv3f93Lxjps/sF/PAj77j2dbKhj6u8ggSiIff8wXLiffYnJ1qaMf0tCTIK8Hd0m2A1
 izjewy/apYm4i3Pv5Vb1IUQMF/QxDcawnEBKr3V6knto1wNWjCderoYpAHiD8I/Ikl++
 /RNZLXKrcb/g1MZN1ybndcL1DGgC6/Td5/rZ1FNkejyrWN8kRB5ZkIditBmvFXdBKMh2 Bg== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3k6qw7gcmd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 13 Oct 2022 20:55:34 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 29DIC9lL034090;
        Thu, 13 Oct 2022 20:55:33 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2105.outbound.protection.outlook.com [104.47.55.105])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3k2yn6asn6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 13 Oct 2022 20:55:33 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PXEY7QXZwe9sXJnvulNCb6ARj/E6vtyi2+Ef/XO9kZerHECYtFINj6/XPq9NxzigydHCsrHs8Cx6rmX2TSzQwvXurdEPqO2LUgNrJn80BE/4QccAMFmFQKClCldIPdnLZ+iSE+gB9Xn0q+gDrAppbOF+oJXNuauRIS+gId3XthE5XHEx7Pj35BE4+zjz2vBU/SPly4VJ1pdVExYOFdzon0vQ53CLHd7tgdOQfU+YgFt9dIZuaqCeNJH6Z1N8ewhfRkS1rGwdX9Ltrpfs95L0L2KZNImkl/M7kP/bBNCtpLIDH4qLJXsCKtOlAlZ9eQ8Eo5zT5V7TJ6Akm45qSxgKAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dzrCGgG7tjhWeS+VrcO0H3tvhHThjfi/FSmeVDtDpxs=;
 b=ehrJ6ne3b46IB2thK/3LwNCPVp9INqof77shfpzd93r1xeErceTV8p6H0A/o16LQyHbFazQtbHrCnnajihOHKkxooQl3qcdkxRttyp77PlYoGDHZ3K/O2aiwH26JkteIIJAIU73dKQVzkCE6hUx5qdSYEPNJW1Fpy9t9iLplzM4IQCNXZKIhbnhSISjL1WybY179Z47MJKMp4YkXcHLu2RjdzRgK6kHUja1mRAk6W24hO7m7GKJekmZ2pH8Q57miP/WG1FSY0c1VokLSXEGBvhhm8nJb6uP5aNxm2m/rWyJKYaC33i53hqQy8dGXL3e4ba71/sbnQt1Yix7YkDPcXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dzrCGgG7tjhWeS+VrcO0H3tvhHThjfi/FSmeVDtDpxs=;
 b=Tm8vKoqffFgNS3QloAWjv/0cJVKB210Dcg2tIUAU2/YSnENyyEkKxn08Yu0u/DplvMThms5lo8qFUDrEtL0kCXM2iBKtdBSZuVY9Gha0r/x6JViEzxAc2HyYNOvtqFLsktmpmm549Gz87gOTF1/e2tJ5cDN9/RmB/xZ2iZb+Mic=
Received: from MW5PR10MB5738.namprd10.prod.outlook.com (2603:10b6:303:19b::14)
 by SJ0PR10MB4736.namprd10.prod.outlook.com (2603:10b6:a03:2d6::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.26; Thu, 13 Oct
 2022 20:55:31 +0000
Received: from MW5PR10MB5738.namprd10.prod.outlook.com
 ([fe80::dff7:be08:8fff:b064]) by MW5PR10MB5738.namprd10.prod.outlook.com
 ([fe80::dff7:be08:8fff:b064%7]) with mapi id 15.20.5709.015; Thu, 13 Oct 2022
 20:55:31 +0000
Message-ID: <96566993-e888-6d98-25a6-818dd4f2a327@oracle.com>
Date:   Thu, 13 Oct 2022 15:55:29 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Subject: Re: [PATCH] fs: jfs: fix shift-out-of-bounds in dbAllocAG
To:     Dongliang Mu <dzm91@hust.edu.cn>
Cc:     Dongliang Mu <mudongliangabcd@gmail.com>,
        syzbot+15342c1aa6a00fb7a438@syzkaller.appspotmail.com,
        jfs-discussion@lists.sourceforge.net, linux-kernel@vger.kernel.org
References: <20220929054500.488604-1-dzm91@hust.edu.cn>
Content-Language: en-US
From:   Dave Kleikamp <dave.kleikamp@oracle.com>
In-Reply-To: <20220929054500.488604-1-dzm91@hust.edu.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR12CA0004.namprd12.prod.outlook.com
 (2603:10b6:610:57::14) To MW5PR10MB5738.namprd10.prod.outlook.com
 (2603:10b6:303:19b::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW5PR10MB5738:EE_|SJ0PR10MB4736:EE_
X-MS-Office365-Filtering-Correlation-Id: cd7bc35d-a925-4e74-cb25-08daad5d444e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EC6Y6W/AW2+N4Fi/VfKi2cWPYLzYhDx0Kn48XlmsFm45XzKi2rOtDfEzm+Wuw4hyJVZauOU/VjIT79rGBGvFD4K9y8+pgu/8RRDDJXsQW6riGR4B08jOuLXEQw1/ZseUFa5dkV1QDt+S3I4iWy0qpfWYYpIvDFdot89BuL1NIbyFq2pmfi/m3CcKaHI2wYY8bWl8mtofeGQxX+6wWM3CFkgq7XLEOYJN6wsj9wpz/FIPgpOHUwFakNE4FmET84dygdRyalvQRrkrOzmipdLL/GAkqvN9MmDO8sEP/Ykt/82JmpTsgqhYiTKQhw9kxv2UzoE71S6gfyPchhh73QZGIUk0sMFjw0YqXROvLZdqNimiV+gHoi9BVzwLR8cpr/ca+fur9e7PC7n//KyBixJ/e9/Xw7Ibb6xw3vrt6y6lNPBFLj/PbQjr1NnDhT5a92f5iBpdpooOWNOsEAqzzqcIiAc2/Gt/0gHq1x9+Bxal1zZB2feNLfp1P9sC3O5UqOKRSg4218mywUTkmK6fr/CpouTScsb6koPwVLpCIfYu0AB6j0svjJ6yyz3CN/QLrbFEm9krAQkbQGnDi3aWJVSACNetzZIh9OrXT+5/DSTbCMLJblFhB12hEyBRwqDmG81lgF6GfCx9y5H1tQfFIaM2HbthLftOTuzwfcQjwLKBOrTkvfp8HQQ9zjwxuHxSuZNdJZ4Zagr7wIp9/Spq94ML0jUfLo+RXsHtYNhrTNjcSbrqT7OW8K3cfxoCvs/emVwXBKnVpz8FCmF/jqt9B7eYCPu5Kapd2YtDrNmfCAqcbIQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW5PR10MB5738.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(346002)(136003)(366004)(376002)(396003)(39860400002)(451199015)(8936002)(6916009)(31686004)(5660300002)(31696002)(2906002)(86362001)(186003)(2616005)(478600001)(41300700001)(26005)(6486002)(36756003)(4326008)(66476007)(66946007)(66556008)(8676002)(83380400001)(44832011)(6512007)(316002)(38100700002)(6506007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NDhZWi9wYnVKaVhJUEtqNmt5dkVzSWVnWHZMa3ZHNmFHQnBudWc4a0xnOWZh?=
 =?utf-8?B?czVPZHVPWmpTSXRES3AxVDRCUkRQa0RKd1R4bXdtN1lQVWpIZDVlK0R6aGFE?=
 =?utf-8?B?WlRCaE9vS1dGK1BwbXpzQ3J1TDA3dklmcmVUekNMcFJVNlRUamxKelZvRzRm?=
 =?utf-8?B?bjJXMVFjVHFqdU9PUTVya0tyUDY0OHdBcW9WNVV1WllKNWl0SWFMWm9kQit3?=
 =?utf-8?B?dDVKV29CSXBQVFhLVnlBdDhtSTYxcS84andGSGpZTXczQ0hLVDdoUGk5dVpC?=
 =?utf-8?B?Y0hRYURVL1VDYlc1U2FFbk9KSDYvaW9wSUtlNW9PVTI1UkswRGdFVXRTaDY5?=
 =?utf-8?B?Q0ZHUjhOMTVKakZTNkRTV052N3F5cG1JVEZhTWdnaERhTWQ4VlJnQS9aR2Vy?=
 =?utf-8?B?cWNXSDdMVlZ6MmNhdlhwdkNJSTZLK2Q0aGJSVEhzSnZtbEI2VDQvaitQV0dI?=
 =?utf-8?B?TENvd0pxZ2NKZDJQNDdwOXV1cElGOUpqRmFNTHVxYUM3NUJMN3FHMktHWjlC?=
 =?utf-8?B?b1BBelVORkVXdTArQU9CdGtzVXFORlcwWXF2YktxRDc0V1BVc28rc3NhaDhB?=
 =?utf-8?B?ZGlENCszOWFYdFg2VlZzKzU0aEdVR1pCdFk4REFHcjRtZ1lwWUF1MmUxWXE2?=
 =?utf-8?B?bXZvak9qRThCU1RBMHNwOEFmRkNuVjlmRjdaRG9MVi85MnhDNWtkdkRsN3lr?=
 =?utf-8?B?V003c21IOG5leXFWeXI5K0RXTEdDTkZtUjVjMCtyc2UyUmpIYjExaTdGQW9Q?=
 =?utf-8?B?TjJDa1VraEVDMXJoMHZBb2l3WnQwTUg5a0VySFEyZU1MZ0pBL054QXNnMEdM?=
 =?utf-8?B?YkFJSkhoUTVTVytacU5iUlM5OGQ1Qk9xZmFzV1dRSy8ranFQZVFESys0cnZz?=
 =?utf-8?B?eFlBdnVLejd0L2Ura3VianJrWVQ1NlhDZ1ZvaU9vSWY0OWhuMm5xaW1qMmxU?=
 =?utf-8?B?Nmx3UzNuektvREJtUTk1bnBFYXhrN29QQVVFaU5WRHdYM0ZCR3ZZbzhsMDAz?=
 =?utf-8?B?VEtCckZhRWlUZ01uQlQxSUpwV3ZONUYzVzh0OHBXVGxKZnJuaUUxMXFkZFh4?=
 =?utf-8?B?WHJ4am9WckFralFCWi9QN2JaWDNESkxrOXZiZ0Z1RngwZCtzbStMT1h4ZjZW?=
 =?utf-8?B?a3RmcGNuWC9OS09jT0FXb2t0aXNzK0xOeG96WHFrdzR5VlRtdHp0aU12Qi9E?=
 =?utf-8?B?cGxnRFNuWE9BaXNvUzlaTlRvRjBRTG9zSSs0OFlwK1FPdXAwUG9vTTZwbG10?=
 =?utf-8?B?c1U1Zk9oZnRVZERTVU9VS0ZhME1IOStUZmJJZitXcithckZpYUQ1UU9EdXF6?=
 =?utf-8?B?T3hRSFAzZk55YjJHZGM2bUt4SmJiUjA0Q2p1SnRXSkF1NkFHL01wYTNhc2ky?=
 =?utf-8?B?TldickgyU285Q3p2dXZIekYvc1Y0TTM5eU1hMitqZkdQczFzeVlaVDVpUFNa?=
 =?utf-8?B?MUZuSE5RM3JIZU55akJLcTBqZDN3cmZYdkRyUXdxU3UwR29CZkg1V0ZGUkZy?=
 =?utf-8?B?ajlUL3JnYnk1cnd0aWNiZ3hNVUZFNjBBeWw3c3d1Y0J3d2dBR2xJQXYzdjN4?=
 =?utf-8?B?bzhydVV0ZVFKNkIySnFUTzQ4biswR2VneTRKS29CRG5JeUJyeDFoNktSZW40?=
 =?utf-8?B?U0c4NTY1WTRiM2hDbTFjSy9oNmxYM1Z4RFdhRnlyWW5WYk4yYXBOeXhlOTI0?=
 =?utf-8?B?N1k4WVRGYmJaV0ZDRkFQSmVnMFBxeVRBVzB3TVpZY1pkbWZDM1l4Y0x2WVhZ?=
 =?utf-8?B?UnBJTzJkc1VKUXEzWFVnekpmb0NNSnMwNUltMmRucGJ1clU3eElNMU40Zy91?=
 =?utf-8?B?T1ZiQWJ0aFJJSHJGYzd3WGI4YWxOUlZkdGpuOHNOOWJhM2hnMG5hRFFLTkk1?=
 =?utf-8?B?aDlpaFhsMUlSRUp1S0RnK2dzRHhqbTZUUkVpdWUwUWV3NERaWms0amdhQTU2?=
 =?utf-8?B?SVNRNGdjYk1DTUdSV1RjSXB1TjlYbThQNmpnb3BDNmNYZHoxQ29wd09HcDZM?=
 =?utf-8?B?aWx3akljYmNacVA0S2RWRDNxZHFBcHJiYm1hQUlyREFKd0RsQXdCeTNRMnhE?=
 =?utf-8?B?bi9ZQ0FJcnNoVjNncUJYVFczNVhvcGdTNU1RUHZCd2VCNThoaUt3ZERmR2Jh?=
 =?utf-8?B?YVJjZmI1d3ZJcjJISkIxZmlwTm9ZbmJrdkQ0aFlESDl0WlNPSWExL0dYLytB?=
 =?utf-8?B?alE9PQ==?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cd7bc35d-a925-4e74-cb25-08daad5d444e
X-MS-Exchange-CrossTenant-AuthSource: MW5PR10MB5738.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2022 20:55:31.7955
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FDzzMkeB52g9sWKg56TbcR6wXTLhroR0XB1/IKToO84pIVKplWtcX2Kq03to7F6aIE9DeSAISQgtL4I+tuNwyHbUr6Yl1OQJrtu764hWwAM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4736
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-13_08,2022-10-13_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 bulkscore=0
 adultscore=0 malwarescore=0 phishscore=0 suspectscore=0 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2210130117
X-Proofpoint-ORIG-GUID: 6q-ynxdUp-LvzTnV-CM4F4MQJkqhRAug
X-Proofpoint-GUID: 6q-ynxdUp-LvzTnV-CM4F4MQJkqhRAug
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/29/22 12:44AM, Dongliang Mu wrote:
> From: Dongliang Mu <mudongliangabcd@gmail.com>
> 
> Syzbot found a crash : UBSAN: shift-out-of-bounds in dbAllocAG. The
> underlying bug is the missing check of bmp->db_agl2size. The field can
> be greater than 32 and trigger the shift-out-of-bounds.

The shift is done to a 64-byte value, not 32.

The volume can contain up to 2^43 blocks, which are divided up into 128 
(2^7) aggregate groups, so each AG can have 2^36 blocks, which makes 36 
a valid value for db_agl2size.

> 
> Fix this bug by adding a check of bmp->db_agl2size in dbMount since this
> field is used in many following functions. Note that, for maintainance,
> I reorganzie the error handling code of dbMount.
> 
> Reported-by: syzbot+15342c1aa6a00fb7a438@syzkaller.appspotmail.com
> Signed-off-by: Dongliang Mu <mudongliangabcd@gmail.com>
> ---
>   fs/jfs/jfs_dmap.c | 21 +++++++++++++++------
>   1 file changed, 15 insertions(+), 6 deletions(-)
> 
> diff --git a/fs/jfs/jfs_dmap.c b/fs/jfs/jfs_dmap.c
> index 6b838d3ae7c2..4c717f245920 100644
> --- a/fs/jfs/jfs_dmap.c
> +++ b/fs/jfs/jfs_dmap.c
> @@ -155,7 +155,7 @@ int dbMount(struct inode *ipbmap)
>   	struct bmap *bmp;
>   	struct dbmap_disk *dbmp_le;
>   	struct metapage *mp;
> -	int i;
> +	int i, err;
>   
>   	/*
>   	 * allocate/initialize the in-memory bmap descriptor
> @@ -170,8 +170,8 @@ int dbMount(struct inode *ipbmap)
>   			   BMAPBLKNO << JFS_SBI(ipbmap->i_sb)->l2nbperpage,
>   			   PSIZE, 0);
>   	if (mp == NULL) {
> -		kfree(bmp);
> -		return -EIO;
> +		err = -EIO;
> +		goto err_kfree_bmp;
>   	}
>   
>   	/* copy the on-disk bmap descriptor to its in-memory version. */
> @@ -181,9 +181,8 @@ int dbMount(struct inode *ipbmap)
>   	bmp->db_l2nbperpage = le32_to_cpu(dbmp_le->dn_l2nbperpage);
>   	bmp->db_numag = le32_to_cpu(dbmp_le->dn_numag);
>   	if (!bmp->db_numag) {
> -		release_metapage(mp);
> -		kfree(bmp);
> -		return -EINVAL;
> +		err = -EINVAL;
> +		goto err_release_metapage;
>   	}
>   
>   	bmp->db_maxlevel = le32_to_cpu(dbmp_le->dn_maxlevel);
> @@ -194,6 +193,10 @@ int dbMount(struct inode *ipbmap)
>   	bmp->db_agwidth = le32_to_cpu(dbmp_le->dn_agwidth);
>   	bmp->db_agstart = le32_to_cpu(dbmp_le->dn_agstart);
>   	bmp->db_agl2size = le32_to_cpu(dbmp_le->dn_agl2size);
> +	if (bmp->db_agl2size >= 32) {

I think the right number here is MAXMAPSIZE - L2MAXAG, so

	if (bmp->db_agl2size > (MAXMAPSIZE - L2MAXAG)) {

> +		err = -EINVAL;
> +		goto err_release_metapage;
> +	}
>   	for (i = 0; i < MAXAG; i++)
>   		bmp->db_agfree[i] = le64_to_cpu(dbmp_le->dn_agfree[i]);
>   	bmp->db_agsize = le64_to_cpu(dbmp_le->dn_agsize);
> @@ -214,6 +217,12 @@ int dbMount(struct inode *ipbmap)
>   	BMAP_LOCK_INIT(bmp);
>   
>   	return (0);
> +
> +err_release_metapage:
> +	release_metapage(mp);
> +err_kfree_bmp:
> +	kfree(bmp);
> +	return err;
>   }
>   
>   
