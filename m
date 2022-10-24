Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8686260BEFC
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 01:51:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230362AbiJXXv0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 19:51:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230273AbiJXXvF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 19:51:05 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C034240B5
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 15:08:54 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29OKpDio010282;
        Mon, 24 Oct 2022 21:05:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=whDEstjGgEl5/QsfnnIW5PJydQYwHlZwHedOU/bMKas=;
 b=OuvO05SvlskulAHn+igAtfyQKqUL8l6ig54MJJQNdDxEcMrGBddg4V/qNgwTCJGUF55D
 gxsYI38ui3FObZEAJVBYwE6JeRjt63YzxwNHdi2+pVbbQ5Nhym14C+3Mn41i95Bn2o7s
 L4MFl5vq+kSbLW4dcVpB0qn5xD56ZembZKeqazhqk4BjAS5A+HSYgHYNaKBr0qNB1pVd
 Z1BLRXMCyphm23qzsaSl6FISTF38VY0v9LrUGeG72/Ar2PFgdElu01eOR9sl6zJUM6xT
 LZkunjlji7z1neOFQ6h0s82Y7E9swRT7caDXfuR7ti/9c2c9QGqdYcvQn1ij2FKEGiFm Bw== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3kc7a2wf3s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 24 Oct 2022 21:05:35 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 29OJ4xmX017396;
        Mon, 24 Oct 2022 21:05:35 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2048.outbound.protection.outlook.com [104.47.66.48])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3kc6y47j0s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 24 Oct 2022 21:05:34 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WP+wP3NQaPBo4l7Lufreq5YbxugGO8SgHNzYiqhpbtWyZI4ihzT6bP9vtj8cq0MNfsNKTvuhXaxpch3sNVVavFOzfA20yiO6zKFQoytF+1RFXPV0gmArmFzRGxOYj47E9nsSTaDVkHwscIyYVvcjY5dkxqqa6KtN8cFGTSdAk3sLMTKbufy7SHEPQ3eMgBqbkoufHmZVnAQrd3BdRBQuGu+Db3daIE3p0CHUXAqgnCzwwHbWjrzEIlI7fAkO1XblX3FfpCtIZ0SyWCdUQVmJpJ3pJXzdQ6LDOyK90uZUL2NWmRVwoU0MFxLjMABMGqsgkzsi+OklAVcBhwnRLKMygQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=whDEstjGgEl5/QsfnnIW5PJydQYwHlZwHedOU/bMKas=;
 b=l+PDosqZ6Z1KWGzM24ZFBPJTN3n8yvR5ZkHw9k5h2e2q5CEVTtk6nRqzC4pq4tjrL46corxNPqONL+W/hc73vE1vz3E2A1s7M6Oe/YRJAc7jLDYhvAZwsLgbZRuu4dyrIJXsYg/JMkmKmVfJrBKuDwQgUXHsVVib1JKO99ucQ5q8wx09DrtayENxmkwzKeBDUlzVUgz6aAjuJ46m7c9h0xHSmcobRZiTPTaMKD6jRWxkK/VvdeJx40hsUWwar4LKEX6Q0cvtHVNLU6Dube0kxep+4EK8Xk72Wt1kZ6pdt4Mu7LPIF0MbHdjVWhaq1dnigS2w21nmEzv0YOnFkmE/cg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=whDEstjGgEl5/QsfnnIW5PJydQYwHlZwHedOU/bMKas=;
 b=Zbd6w2XLkJ5hwAycU0oMNgxpA+2Tc69N+LuJTBeNwvWCH3UDv4vdLTzApdgcN6SE8fTliu+iRti0t7JdKiK05AlIbIg53K+uqOln//mOH4zX9dxP/KbMMif+ZiHy5EIbjsZJX/f5qSqkaxP6yBVdEYg8VTdwqwlFOGG9gWndPvk=
Received: from MW5PR10MB5738.namprd10.prod.outlook.com (2603:10b6:303:19b::14)
 by SJ0PR10MB5648.namprd10.prod.outlook.com (2603:10b6:a03:3e0::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.29; Mon, 24 Oct
 2022 21:05:33 +0000
Received: from MW5PR10MB5738.namprd10.prod.outlook.com
 ([fe80::56fd:b251:fc9e:aee4]) by MW5PR10MB5738.namprd10.prod.outlook.com
 ([fe80::56fd:b251:fc9e:aee4%4]) with mapi id 15.20.5746.028; Mon, 24 Oct 2022
 21:05:33 +0000
Message-ID: <286146b0-51bb-a1d0-fa28-50e5a792aeed@oracle.com>
Date:   Mon, 24 Oct 2022 16:05:30 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH] fs: jfs: fix shift-out-of-bounds in dbDiscardAG
Content-Language: en-US
To:     Hoi Pok Wu <wuhoipok@gmail.com>
Cc:     jfs-discussion@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        syzbot+f0e0fcf3cd1047ae60ad@syzkaller.appspotmail.com,
        syzkaller-bugs@googlegroups.com
References: <20221019093825.339991-1-wuhoipok@gmail.com>
From:   Dave Kleikamp <dave.kleikamp@oracle.com>
In-Reply-To: <20221019093825.339991-1-wuhoipok@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR03CA0342.namprd03.prod.outlook.com
 (2603:10b6:610:11a::16) To MW5PR10MB5738.namprd10.prod.outlook.com
 (2603:10b6:303:19b::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW5PR10MB5738:EE_|SJ0PR10MB5648:EE_
X-MS-Office365-Filtering-Correlation-Id: 98c86430-8014-4f53-dc9b-08dab6037d37
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MMgTG+1IuytMQ677h0KyYG++p8eP2tn2XZUI6zqnQkpaRACcfjO5pp8P+i7/oesFS4U6UAgP3j6Ghh6e5jZGzuiQ8MWrdSG/5KH7AXK3W61qmCPmeSrw4h0BFmR9gA19XGrpyzUMjN1MIZMsLd44rqvqNwlFTjk8Nk7sBZc+Y0XZZDBZ6wDJLSlK+pJvjEphdB1DxbaCTMIys7Vsq++q/9j++uNjxPZGP7im5FvWBQLnjn8VpVKKM+SfONWY+KsvgrLfhmsh+n+reKJU2utiSOIDUTSJax0U1izkp5MaJKemwNbePtPxT3xqRkwmFOlmee3kKYqsIvWgrVhX6nA1I0KaRrI0tIip7MLqwgOh3zAPwD0VIc0fXsTdHvgLe7pDlR21qe25oVIA1gmnXJ2juf7YQpKeaTWSpN4ydaRSsvXBM+BYIvyFPZzsCHP/ifoFeB+cOXghzMJF8MoakIGaKbADgq9Od8gNV+d7Ynehm9BXdCf0ANGBJGBa52DhQbLHffNK/nZaL72ETobDbfKXK5hdWbpfqro+5gxNJe80i1vB00zHFpR9V195XWzGPUGSLW3Ej8caT4bBHDM9BtCVAHStbVaPVx3Uwfx81GPwN7OSwT3tnjFNxy6x+Fw/me4KjD2uUjGnA90tUIMk/wJO7aUSQREyfB32o2RG8iOkgS7Tw2G2YWc/o+xu+g+IG101HLZLrH0RO90y6/2809GMzPNsOAV6RJVGw30Vm47w+3nRPWu7IbeAwUwnL6GeqLAh7Bqb9cUfKFc+L6NakXPGXA0YndtQR0lOf2zv4pGov1M=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW5PR10MB5738.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(396003)(376002)(346002)(39860400002)(136003)(366004)(451199015)(44832011)(6916009)(66946007)(8936002)(316002)(5660300002)(2906002)(66556008)(8676002)(26005)(41300700001)(186003)(6512007)(478600001)(4326008)(31686004)(2616005)(6486002)(6506007)(36756003)(66476007)(86362001)(38100700002)(83380400001)(31696002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aGY2Y0Y1Q08xLzE1WEZGWjJWc2I0NHNzczFRQ24zSWVwT3JHWTl3Q1RSZmxE?=
 =?utf-8?B?aDdNVyt5Z0dHejlrUDVJZkRMUHlCWXRsNUVSL09WK3hoVUpBS1VmemRCcWVT?=
 =?utf-8?B?MGpEZVNySWl0K0JaWlYzSzdjTjlmK0tTWHdYR1QzS2RGQW9nVTNkTW95ZUtw?=
 =?utf-8?B?bEIwcUc2WWFiMDZKVytzYXFGVUtzdFkvOStXMzBQbHNoWXFNT0dyU0doeHo4?=
 =?utf-8?B?NTJtMllQeU5FVm91ZFUwdEZENUY3SzN4QU5TeHZ6TDlKaWlObmViamwyTlA3?=
 =?utf-8?B?NUNMTkM4WG5yYnNpMjNaeEsxMi9JZlluY0l3V09xNTFvV0UxdWU2VHVMOTF0?=
 =?utf-8?B?QVBsWUFyK1c0QXNGNCtZMEdCWEZKaXFHeFRBWWN0djhJN21NSVcweUhwK05D?=
 =?utf-8?B?TS9PUDFMOUptSTNsVlY0aitEL2ZkYnd6UXVKLytrTlJFWmtnNkFDKytobERs?=
 =?utf-8?B?dVRrckxLMnl5dFFScnJJVDJPWHYrL0o5cFJxTDRTbHQrdkNHQVI3dnE5L1A1?=
 =?utf-8?B?VG5TamtXZlh5Q0RqeVB5dDNETE1DVS9nWXBaeFZpUGgzdHkzaHQxYTNTMzdO?=
 =?utf-8?B?ckxwditnbVRwWDBFbVR0eDVFc05wV0V3RWFqeGFtMFJlclFxaExQYU0vQ0lw?=
 =?utf-8?B?NDhtbUlLVXBQK1BWSEN1T0xQT21RNUtWYjV3Q1dHdHJBRHM2ZmNZdzZHQjBO?=
 =?utf-8?B?TmZYUTNzMklqUmxmUEZSdWhLYnRUTFNUemFrK0lYSDd5NHBvZ3ZoTmlYbWtE?=
 =?utf-8?B?dDdhNGRoQ1o2TXJxc0wyRm1NTG8wK0FLS3hWLzRNd05nTmVxeXR3eGU2TStv?=
 =?utf-8?B?Z3krSUZxK1htT1pIRUNmak5zN2hEanR0VzNMOFNOWlFua2dpQWZNK01rSHk2?=
 =?utf-8?B?dm5UU2hacUMvK3ZmeENld3htME1WTEd1Y3MyQkpXVE84RmxPbmVTN1plQkcv?=
 =?utf-8?B?UUszUm83OGFsa1hNdDcrUXVoQXdRRGpqWTg0L2h1am1udlE5NTl2dVBEWkFx?=
 =?utf-8?B?OTZwYzh4TEt5aU01cUc0eEo4RENSQ2gzMVo0RU1xT0s4ZjZ1Sm9RZjVhVHVj?=
 =?utf-8?B?QS9wSGx4U3QycmJPdVZWKzlQS290eXpNUTFQV01lM3hvR3NyNTRYYW5teDRD?=
 =?utf-8?B?bk4zVGRaM1RTSVUrdlRqb2JFSlhvSFczRE9kY3h6QS9ZWmpYdnJZcjc3TWxn?=
 =?utf-8?B?enNxakcrWStnR3hLZ1VTc0ZGOVJkZ2pjeFlkTHpPd1NmdkEvc1JRUHMyekNC?=
 =?utf-8?B?Z3NjRkM0NGRWRnZpdUp3dnhKaTVONnFubHRuWXQ2NmV3S3QyZHQyamdtajRB?=
 =?utf-8?B?YzFndjJORFdMNVF5WHErV0lHY3hRZTMwU3RxS1hSNFBpOXJSaXEwRDNUb2FY?=
 =?utf-8?B?S2pOYnJsTVdDaFE4ODNiakEvWjJXY3RKNnFyM3JUeHpEbng5NGFtRWFISmcv?=
 =?utf-8?B?b2JvOU5zSFNFczd5dHBURHZMenJwdHZGVWxaMXBRWTRGWCtkUEluN0phSmxL?=
 =?utf-8?B?czZzZmwreG4vaHZyZE9UWVNnczA4MFF3R3NuQ0RObngwVU1zQjN3UkU5RS9Q?=
 =?utf-8?B?SG0yZC9NZGJOQklWcWNiM2srWk54RFdRSVltMERNYXkrWktFQXhOYjR6ZGMv?=
 =?utf-8?B?RVFZd2t5dlliQzJPTG0wOTlNSVlxR2RsVXowK1c2TkpZUk5xTVVickVXYUFa?=
 =?utf-8?B?ZW9LS3RNVG8zTzZpQ0Vla1FrbzdFK2Q0a3J5V2VFZmtvUXRnWUVhNFhMck02?=
 =?utf-8?B?YjJqZkJ2bnR1cnlBNzh0OGg0RytQbDUxV3llU212cHJ0RGxuYXpiSUtkWllM?=
 =?utf-8?B?alNsUjUrdFc5L1B3NEJ4bjZScFZXd3RVUk42RlY4dURMblh6MFVHTlFPTjhs?=
 =?utf-8?B?bGgzRFRtOWpDQ1Yrcld0UDl6VUJUeVRVSzhqK3hPV1IyOFdBdzVnVkhoVFl3?=
 =?utf-8?B?VUp1akVQWGJSa1RxbU5CdjlYWUFiTE96N2ZiTXZIUFVCcGZIRzdvQWJhNHIv?=
 =?utf-8?B?SEQrOG5rRlFxOHZycXVqUDdESy9weERvaTMzQUtocmpDNWJrUXpaTWI0WTRp?=
 =?utf-8?B?Y1ZrVEdZYjNadnN5Z3ExT2l0alpaNCt0TGR0aXYrbUgrMjRha0JrdkZzeGJ5?=
 =?utf-8?B?bGdreXNMNUJpbVRQUXhEZktEUmNSbTV1N1NPL1BleWFZc0gzaHFiaEtYY3NS?=
 =?utf-8?B?dWc9PQ==?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 98c86430-8014-4f53-dc9b-08dab6037d37
X-MS-Exchange-CrossTenant-AuthSource: MW5PR10MB5738.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2022 21:05:33.0503
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hE3PUQsuPxwLQkCod/SETnSGIz+Xx1L2tQKb0IwzQQJiBRoKSBKFRtvvsw28jg1RPEort2dZ9edzqlxMaNS7gQWNx3zXuJWFTAPoCHJq+EE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5648
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-24_07,2022-10-21_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 phishscore=0
 mlxlogscore=999 adultscore=0 malwarescore=0 spamscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2209130000
 definitions=main-2210240126
X-Proofpoint-GUID: wqnbjppyQ6qLSR_fMZhTq8pGUsKpgQSt
X-Proofpoint-ORIG-GUID: wqnbjppyQ6qLSR_fMZhTq8pGUsKpgQSt
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/19/22 4:38AM, Hoi Pok Wu wrote:
> Bug reported by syzbot, UBSAN: array-index-out-of-bounds in dbDiscardAG.
> Fixed by simply rearranging agno_end smaller than MAXAG. However, I wonder if it
> is a better idea to return -EINVAL, rejecting user input. Thank you.

I don't think the problem is simply that the user input is bad, the 
range is already limited:

         if (end >= bmp->db_mapsize)
                 end = bmp->db_mapsize - 1;

It seems syzbot corrupted some on-disk data structure to trigger this 
failure. It may be best to call jfs_error() and bail out.

Thanks,
Shaggy

> 
> Reported-by: syzbot+f0e0fcf3cd1047ae60ad@syzkaller.appspotmail.com
> Signed-off-by: Hoi Pok Wu <wuhoipok@gmail.com>
> ---
>   fs/jfs/jfs_discard.c | 4 ++++
>   1 file changed, 4 insertions(+)
> 
> diff --git a/fs/jfs/jfs_discard.c b/fs/jfs/jfs_discard.c
> index 575cb2ba74fc..3101eaf3098a 100644
> --- a/fs/jfs/jfs_discard.c
> +++ b/fs/jfs/jfs_discard.c
> @@ -96,6 +96,10 @@ int jfs_ioc_trim(struct inode *ip, struct fstrim_range *range)
>   	 */
>   	agno = BLKTOAG(start, JFS_SBI(ip->i_sb));
>   	agno_end = BLKTOAG(end, JFS_SBI(ip->i_sb));
> +
> +	if (agno_end >= MAXAG)
> +		agno_end = MAXAG - 1;
> +
>   	while (agno <= agno_end) {
>   		trimmed += dbDiscardAG(ip, agno, minlen);
>   		agno++;
