Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E4FB601876
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 22:02:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231134AbiJQUCq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 16:02:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230416AbiJQUCm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 16:02:42 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDB8AF00F
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 13:02:40 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29HJi7br003700;
        Mon, 17 Oct 2022 20:02:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=bvRc9S/kGgpIUw+r0pf7uRBCfZzWqzUCapDD1yp2xGA=;
 b=L/86BKJ6aOHc4LYrrFWWBrjkC5AIEx6mJNrsZZFqsjP3L3qKW69fZL+FXQBQQyfIQfWI
 geZPkVuFHCVNw0YeN8WcqXYVt6jyAaqYlAfGN1/9izTGpRpxTcfLKrNXcQ7GApRWgt5b
 e5oFx6C92ZIRHBlzsyVlBT2DEDzNz4LPuQvL00on5rRUOL/gEZln3yBwAZQ+gp+Pgav8
 /VM+Yhkc7qYnQ30Gu4eLR3xu8CWxK5GCs38e9Azn1cMmKYCRMFqhQ5RlHA4nj3YKSdlJ
 EA6jzBM6VWAykUC9AYzqFRaV9EfnB11eqTaru1/YT6uVEvV0sD+RTKz4TnqndMRDauMX tA== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3k9b7sgdk8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 17 Oct 2022 20:02:07 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 29HHexkk036359;
        Mon, 17 Oct 2022 20:02:06 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2171.outbound.protection.outlook.com [104.47.55.171])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3k8htf61k7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 17 Oct 2022 20:02:06 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bfD+y85JmfkDG2bGPTfTWS2blOPFNW6xDNabpCK9Tj6MmsrtAmLa4iko3r0Zw8ljm5I46eWAvHtex0CUjIAD+Nf2N008aAzPgaFvQZJKbO8WdQoisEfpdbkm4b0aY2YDeatfiZRXwxy7lSML5Pg2UyRBiTwqc3RTPMLrcHUU+q94ucgpVbQz7T1/R17QuG62gJEt0srfGyW5rENZGsSQZjiyUuPD2p2kmr+fBH8/hA4YcBmGQvzwmLlUi0xPbZOTuxZ3jV239L3dWt7OJ4h7nJD3GV1AUdmIQHLf1VUDHLUjIxjNpLAjT4EDTu0ABOZ1nIMvRCo0wyoRwdCMZQINzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bvRc9S/kGgpIUw+r0pf7uRBCfZzWqzUCapDD1yp2xGA=;
 b=N3tq93pEt8K6O4YWWFileLnQIIuYNstfw5RofkFw2yf8xDkHyKUqx0b33eC7oBAnJ68KzzhZECOKmzld1ZNDZAh/tg0MJgCYTBGtCvciu00heh1m3W+Zo03Cb1uZbgR6Xutekp05Pi5eOfq076u+YkSp00g956qFKZ4Ce7loafu8jhddRnKHdFWmFqQzMKUc3VCYAoS9DeCPlGC1E475EE+pdJyp4HjDXBvqdaYpwy/OgKZAgbl1ZpSZtTjhBBx7RgUKUrAf7caj1FnMxsdlYaD9SG6HnE48EDjE8x508OTXOyQklvuMRHGpjcbb4dJZFAx/9+itBqc6AfKI/o8zPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bvRc9S/kGgpIUw+r0pf7uRBCfZzWqzUCapDD1yp2xGA=;
 b=mqAsRhkN981JuxiRGM7TSbfOWU+r9RNvF1wmM/Hj7DGGsKqPqlgYeM+f1lLMdnt8ylinnLqpQL7UAL+Z+UMwe+uv9u8fnHbgyNe4+yKb/qsXFd8Tc2NtbCTytdTsBNExxccKmI/lCq/OHuKlXij/Q9QT5jCtD8cWSB2NSqMBl6E=
Received: from MW5PR10MB5738.namprd10.prod.outlook.com (2603:10b6:303:19b::14)
 by BLAPR10MB5314.namprd10.prod.outlook.com (2603:10b6:208:325::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.30; Mon, 17 Oct
 2022 20:02:05 +0000
Received: from MW5PR10MB5738.namprd10.prod.outlook.com
 ([fe80::56fd:b251:fc9e:aee4]) by MW5PR10MB5738.namprd10.prod.outlook.com
 ([fe80::56fd:b251:fc9e:aee4%3]) with mapi id 15.20.5723.033; Mon, 17 Oct 2022
 20:02:05 +0000
Message-ID: <9e4e1fd8-3ff7-dcce-428f-88dbd5fddd09@oracle.com>
Date:   Mon, 17 Oct 2022 15:02:02 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Subject: Re: [PATCH v2] fs: jfs: fix shift-out-of-bounds in dbAllocAG
Content-Language: en-US
To:     Dongliang Mu <dzm91@hust.edu.cn>
Cc:     Dongliang Mu <mudongliangabcd@gmail.com>,
        syzbot+15342c1aa6a00fb7a438@syzkaller.appspotmail.com,
        jfs-discussion@lists.sourceforge.net, linux-kernel@vger.kernel.org
References: <20221016012507.428006-1-dzm91@hust.edu.cn>
From:   Dave Kleikamp <dave.kleikamp@oracle.com>
In-Reply-To: <20221016012507.428006-1-dzm91@hust.edu.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR08CA0024.namprd08.prod.outlook.com
 (2603:10b6:610:33::29) To MW5PR10MB5738.namprd10.prod.outlook.com
 (2603:10b6:303:19b::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW5PR10MB5738:EE_|BLAPR10MB5314:EE_
X-MS-Office365-Filtering-Correlation-Id: 28144617-eeec-4f14-6f2b-08dab07a7686
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CFZf5XUrMjXFHMP53Ikx4C8v/t787W2ww/U2SxA8hPVklV+3Q4Mxzx7CN9kvrcXkd4iuhFDoJJN/7uLLtTltPTytHVZz7I+nHX/+39Z0jP5QRNoncAyxa5AMzoTv3n6NYET5EPH7h06WtyGQF+0WyAl4xOJt+rftfp6IvkgH0XWVp5VY+GdlVin1hythKC3tufn3egJBR0M0EYAPVxtkkI9NvSFWIMFrhSIpEktiSOUMdtpOAbvrIbc88tnix9YZrwoKZ1Or5xuCcGib9LonnMRMCfHzvImVGmWuktuKtGtDx0ot/q9OFvkoNwz6rPLDmjlgrM3UvgXjBfCDRUz+VKrwJgkIfUkzK4cxKAVYVIbm+slNPVzKhHWwoxB/pkyq0q65mmymzUj5D1OD3kUcawhDfp8xOCFoQKHUUvmaQ8mRdVFNYFgGpzt/U3CNM91lxT1WIO4uPY7WM/0TDrZLbFlN4AptKA7qmZmFapNTAHZJFKSnp3esgiBT4SA19+8y0crxT1N/UHvjSX+FOWtto5mMxrqc6zgO+0kzaRIOsYslQASgXkdaCkyFZt54s5PVzBZarD3qagdQsKVKObAbNh6kZENUc2qF829pXnwNhGe4r9mAtkCrvR8QYRz3wxj1MafNP4ZBR54N7nm029e19/n0cfRC2faxl9BnY3VValki0tpRN0JCwy1HYGJE35LR/xG2m6T/MAKyYWujubTvZrES4laoaxuI9TIyQUDBXDmBxoEDXgj9xnS3bvfZ+bCPbD2C12EiuZr31jtVG3iVA4xt7j+NMC4+hvn80FZFVL4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW5PR10MB5738.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(346002)(396003)(376002)(366004)(136003)(39860400002)(451199015)(316002)(6916009)(44832011)(186003)(36756003)(2616005)(6506007)(4326008)(2906002)(8936002)(26005)(6512007)(83380400001)(86362001)(41300700001)(31696002)(6666004)(66476007)(66556008)(66946007)(8676002)(5660300002)(31686004)(6486002)(478600001)(38100700002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VkVTZHdEelUwS3c3TTRqOG1FdjRQTUgyZVF5RmZSVUJQUGxCUTQzQmFFYlJ2?=
 =?utf-8?B?ZnhRdENDSVFKOXZOb2YvU3MvYXpNT21IRno5L2g4SmJvd050YlVTdmlVL2Nh?=
 =?utf-8?B?SnNJMllYSS8rM1BONzVFcmVuakdpN2pZeTRnVmpFMXFXQkt3N2htc2h4V1hp?=
 =?utf-8?B?empWMncyekJJQ0dUWkk0WXlSUC9JMnBVNHRUaVhYQnN4VUdOdkZ4NzZhUmlO?=
 =?utf-8?B?cW4vQmduYVlqMi9FM3FWUm8rL3NXUzU5VU8xejdKZGY3YUJnaXQySDA0WE5x?=
 =?utf-8?B?Y3JVckFsVzR6SWZqZzAxc1dHY24zN2tyaFMzTXN2S2VySWxmZWEvTHZtdkM5?=
 =?utf-8?B?K3JrbGxqaEZKYjl1OE9GQUFRcU94RkNGVlJKZmlRNWluM3E5cnBZUXNZd1lB?=
 =?utf-8?B?UTJBR0F2cmlVUGNGTVZmbm85Zk9ZZS92SUM4UkpPdnNqZkFnSUVzUWJseXN0?=
 =?utf-8?B?TktXdTBHcG9PR1dIYW5Ub0RndEJLaVZNREFPdG9FL1NXQVBCZ2tveWFvMjVJ?=
 =?utf-8?B?WVhCRXVyY3RpSmIxODYwZHZLanNmZTloUytjQkhHaFZuOXNKUXVXYXhKc0JP?=
 =?utf-8?B?RmRhWXcydkt6Ujdqd1FlWDRCWTYxamRVRW94ak1OdHJNejNZZndWZFJsOW1E?=
 =?utf-8?B?aTBRSTVYUHNQa0l3eXY1NlhqL0lKYjhqVnlzZkE5dEZYdy9GMVd5ekZ0Q0RG?=
 =?utf-8?B?VVVpUVl4WU54cEF4L0piVW4rY205dm1RVE5iUDFWamFHTExKc1NZMVU1QjRy?=
 =?utf-8?B?aDNDcjVPblJLZHBhSG9WRWh1TVE3bXR0Q0hmQkVuakl6WVJnMHRsK3NoQ2lU?=
 =?utf-8?B?dUxiY2RvYkZobStGdUc4RmgxY3RUc28zcGVzRDBuUEZyMlVKeCtmRUF0WXN1?=
 =?utf-8?B?U0lmM2lZb28vTGtPYk1JRnNQaUlhcXNZaVRkNHZYaUFGVVNaWmxLM1ZXbFU2?=
 =?utf-8?B?NjY3MStPRUlUUEM5MGVKeXZXSWFsY3VpMWZVQnNLWkZqZGdQMXdRNStoV1lY?=
 =?utf-8?B?ZGkzRzVpQklTaitFcGtuVjBlRWRCWm4yREtSSEhjV29OMm5PMkxRazJGeHlR?=
 =?utf-8?B?OG80MVJVSkpOWUwxc2hkUG5US3JZK1BlUFc1bDJkdzVtRjZvL3prTUlVR05q?=
 =?utf-8?B?aElDQTNnTzhLL2h6N3hQakFLOUNPbHkxWWpyVDFQSGZqamtzZjRQTU5lTFAv?=
 =?utf-8?B?MlMzR05XR2xaSTNSOWxjbXF0cTBDRzk4eGd0amRRbSswck9ic2cwdGV5UjRE?=
 =?utf-8?B?eHNGNk0yejdEbFVrNG42OVcwSEovcytjM2N6TkVSRFVVejNiQ2Fvelg5M0xM?=
 =?utf-8?B?RTl5eHh0VWE1UVJHWlNyZ3RPNnNHUFo4TmtCS3JCVTJBMlVoUVJ2RmlCNmZ6?=
 =?utf-8?B?ZXhlRkJHYloxMEJydlQ5K09LZkdLeHI3YlBZNGcrN000WGwzNDNIVndEdHFt?=
 =?utf-8?B?b0MxWUNhUnJLVjkvcUUxbnZUcmZnSE9ZdFhqeXRONDlTaWMvd3JvblpKdXlS?=
 =?utf-8?B?engwbmhRNkhsTjNoQmU4L0NVS2s5ellXUzdaSWFJMjdSV29acTNoOTV6dTgv?=
 =?utf-8?B?eG42TG9EUUdMMThCNkIyb0xZODhsUmVsaGNIVm82bkE0azRBT3NJdFIyTk1s?=
 =?utf-8?B?N2ZlcXU0R29nMHluaGd1K1lhM1ozdnBtZzdBQXhBaGRDZlp5RXVHWkRlMmpQ?=
 =?utf-8?B?aC9SWk4wMHJkYmFOUVBmSFNjdVVmNXFKaVV1NmdSRGRVSUtuWE5WMUQzVzZu?=
 =?utf-8?B?NTVLeENjQ080NytpZ1g1eld1RnQyTm82Umt3QXlIVmYzYWVyTk01S2d5R25s?=
 =?utf-8?B?bXMyblhrdU9hUU5sMDFqZDNRTUMyQVJ5Y05OZ0pUOGRGQy9Icm13cGR4V0xs?=
 =?utf-8?B?RSt6WTV6NGxuYVBmUUFHMm9HcTRzWU9ST3VVSU1kNE5FeGN1amxvS0lUaHpz?=
 =?utf-8?B?MmNlbE1DY1pTNndCREJKK3YzaE51WjFJR2lnc085R3d0SE9XVlJ6SWQvYWgz?=
 =?utf-8?B?OUVlZ0JCWE94SDdnTjlGWk40a1VRWThDNCt6SVBFMjVuaVdZVjI1UE8vZUp5?=
 =?utf-8?B?cGZnL0VQcWl4WmJ4T2tTbTd5ZEhCV1Q1N29DNDNCaXAveFQ3U2RpbjUzMlVF?=
 =?utf-8?B?bUJ0UHNCQ21PSnRuR0hsNjBaeHlDVXVDZ3ViRGhFelY1YVJPT2p2Nk5sbDJG?=
 =?utf-8?B?SVE9PQ==?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 28144617-eeec-4f14-6f2b-08dab07a7686
X-MS-Exchange-CrossTenant-AuthSource: MW5PR10MB5738.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2022 20:02:05.0022
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AdqXk4TlIvso6CXCdcoRiUOtkMU+J9vpwifi3eXXoYXLvR7eInuHrXbgstSZL0tj14gToySB+3i5//RKm+Z24odXimEladz1lsCra7qYQ1g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB5314
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-17_13,2022-10-17_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0
 suspectscore=0 spamscore=0 adultscore=0 mlxscore=0 malwarescore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2210170115
X-Proofpoint-GUID: TKc3aI9IDTl1PtUeXFwUa9OzvmeSbHhA
X-Proofpoint-ORIG-GUID: TKc3aI9IDTl1PtUeXFwUa9OzvmeSbHhA
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Looks good. Pushed to jfs-next.

Thanks,
Shaggy

On 10/15/22 8:25PM, Dongliang Mu wrote:
> From: Dongliang Mu <mudongliangabcd@gmail.com>
> 
> Syzbot found a crash : UBSAN: shift-out-of-bounds in dbAllocAG. The
> underlying bug is the missing check of bmp->db_agl2size. The field can
> be greater than 64 and trigger the shift-out-of-bounds.
> 
> Fix this bug by adding a check of bmp->db_agl2size in dbMount since this
> field is used in many following functions. The upper bound for this
> field is MAXMAPSIZE - L2MAXAG, thanks for the help of Dave Kleikamp.
> Notethat, for maintainance, I reorganzie error handling code of dbMount.
> 
> Reported-by: syzbot+15342c1aa6a00fb7a438@syzkaller.appspotmail.com
> Signed-off-by: Dongliang Mu <mudongliangabcd@gmail.com>
> ---
> v1->2: fix the size of bmp->db_agl2size; revise the correct upper bound
>   fs/jfs/jfs_dmap.c | 22 ++++++++++++++++------
>   1 file changed, 16 insertions(+), 6 deletions(-)
> 
> diff --git a/fs/jfs/jfs_dmap.c b/fs/jfs/jfs_dmap.c
> index 6b838d3ae7c2..962c855631cb 100644
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
> @@ -194,6 +193,11 @@ int dbMount(struct inode *ipbmap)
>   	bmp->db_agwidth = le32_to_cpu(dbmp_le->dn_agwidth);
>   	bmp->db_agstart = le32_to_cpu(dbmp_le->dn_agstart);
>   	bmp->db_agl2size = le32_to_cpu(dbmp_le->dn_agl2size);
> +	if (bmp->db_agl2size > MAXMAPSIZE - L2MAXAG) {
> +		err = -EINVAL;
> +		goto err_release_metapage;
> +	}
> +
>   	for (i = 0; i < MAXAG; i++)
>   		bmp->db_agfree[i] = le64_to_cpu(dbmp_le->dn_agfree[i]);
>   	bmp->db_agsize = le64_to_cpu(dbmp_le->dn_agsize);
> @@ -214,6 +218,12 @@ int dbMount(struct inode *ipbmap)
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
