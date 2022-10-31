Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 439C5614081
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Oct 2022 23:13:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230002AbiJaWNY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Oct 2022 18:13:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbiJaWNW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Oct 2022 18:13:22 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B2B6213
        for <linux-kernel@vger.kernel.org>; Mon, 31 Oct 2022 15:13:20 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29VLhgDx032352;
        Mon, 31 Oct 2022 22:13:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2022-7-12;
 bh=ovHGtxz1vYOjBdNLzTK6ueC6fSY0xiTsUeFH89CQNQo=;
 b=JXmfevMCSzAWGYGyeIiW04TaqMThS7vkYbtliFOxs7GjS3Xvf+farByx/TbtM+6KjhlT
 H4Rg5Cz6aa8B2z9Prle3xCH0xEccQSQ/34ZzF/EVUFYsvgo5oU+I3YRuVITZ7bi5FWY6
 M6yzX8ELiA3SWlO/ge6/Tw7IfwSH0AhtXuwxK8TZ6RnewmZvs3E2blFL/6pqKOeQljod
 6cJXSHcqW4nbgvefJcRJ9kpE4UigYkheAVq9NpY4s/w0ihlnHfPoVRKUXX/WCxNK+l8T
 tP4438SKQ779Guy5d4PVK5/x+5esFHia8Rxiqi4Ysw6txf7S773JUNmrMvpCAXIW3zy3 GA== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3kgtkd5297-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 31 Oct 2022 22:13:14 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 29VK6Wor032825;
        Mon, 31 Oct 2022 22:13:13 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2175.outbound.protection.outlook.com [104.47.73.175])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3kgtm3r5uu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 31 Oct 2022 22:13:13 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RVV4cuXzyj+3R9pufC/6HlOIJsXVcAq0Imk/wYay9ZpJtWe5CLK4AquzpNZno2vSHcKIj3RkCUStN15iZcRgScBh4f1qUa13wf8NYK6ig9T0FkA+XsOXo/0lvGPzfvyFOPjjxTYH9m8ZHfhO88hzJBgCRS+IqTf/jo/Bfy4ub2McCMtlRPMHeIQeCSU+4lzi9gFj4NmL6COTCuRr9g/wXxmuW6HiA7YW0Yfdf630gjD2A3u8h3L7WIOqqDMRUVPInqO8Xo8fCAbC9JZZPVseCKaK/aRqQ6Wf/KqMXFzPwuEUA2KCqqHB6+II79YFAxHd09nnEpR2QqVzJlmAJAhPZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ovHGtxz1vYOjBdNLzTK6ueC6fSY0xiTsUeFH89CQNQo=;
 b=JtsqnyPZJ4vhcsybVGPIgpVUybYAQu8b9PpQIGd8wKXUKT1weRGdFSwMoYEk9XRcKlzFbfX7SCOyEH4Ohyr31Cx3rClXZBh0FCwSG7paNLfyVQGvT0lQPKhodhJ7l91nIZj0k4XejHQA7KHlmlKxhhcZq9if+/b0SKs4sW22HsHeoG+fyq3o4Ys0XnimGeNGFYpHy2lhROpoZm7I1rh5jUUikC30/mxDDPG+vWkvT0+OUW03kfAJAv6cpR/uaipkHURJ1i3wVCR+bO6uIIti9Fr8vLFyVqR04NBzM++ge+2n1bQAcaZDhY4Q6hXUbd3G4UfiydJcEi54bluQby4zWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ovHGtxz1vYOjBdNLzTK6ueC6fSY0xiTsUeFH89CQNQo=;
 b=Cil2VDkfSUyfkHZrIVZcha5SSOBifWR9lVvQEz/UkCNEDOXp6cplotr445WguCx0n3+bajXZuYKWj96CZBjLIdT8fmdGrXSiDO9yRZ6vKwK/aFKuFJkZti0s09rRYMrkAy1lvFcMullkxRxJDQz/6Vv/05f+ezoy9t0RJ/4mnxQ=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by BLAPR10MB4898.namprd10.prod.outlook.com (2603:10b6:208:327::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.19; Mon, 31 Oct
 2022 22:13:11 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::58e9:95ba:d31e:ddd3]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::58e9:95ba:d31e:ddd3%6]) with mapi id 15.20.5769.019; Mon, 31 Oct 2022
 22:13:11 +0000
Date:   Mon, 31 Oct 2022 15:13:03 -0700
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     David Hildenbrand <david@redhat.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        Peter Xu <peterx@redhat.com>,
        John Hubbard <jhubbard@nvidia.com>,
        syzbot+f0b97304ef90f0d0b1dc@syzkaller.appspotmail.com
Subject: Re: [PATCH v1] mm/gup: disallow FOLL_FORCE|FOLL_WRITE on hugetlb
 mappings
Message-ID: <Y2BIbyxT0Bh6bCUr@monkey>
References: <20221031152524.173644-1-david@redhat.com>
 <Y1/0e12ZJT6+N0kI@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y1/0e12ZJT6+N0kI@nvidia.com>
X-ClientProxiedBy: MW2PR16CA0013.namprd16.prod.outlook.com (2603:10b6:907::26)
 To BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4196:EE_|BLAPR10MB4898:EE_
X-MS-Office365-Filtering-Correlation-Id: 4baa2e00-e301-4f7a-e245-08dabb8d186f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2WYlkWljG+KkBsAnJRy0LOAnjF2omP0va/eaepZWl8ufQcc2TRjvRgMfjjCznABDQJ6fuoi5lhRFfue4FjCQN1WMEBgOFXLQjqSxyQuBD1CI+PWsQ4C/VpwpcHsUcqRS1HoR6zOYqV/7PZ5iS/a+cEGZqADeRsomX3PIwPu1yMq779i9sS/pp1sIgCPA/Fiq+SYtEmHW770mx0YKc+woVIcACm8YzBSIawJlY6y8aI56Hgc2gNfp2bDRz9Oq/ChjaPkvJO80waR42gc7bQ3HEFJRTiaKgIQeYN+EDiusZSiF4Gg9irhnQe0NuZ9D4oi+Z0UJKy3/N6bZXArDE0dskEz1SoRr79Dt+izDCdmTrmvmHh9XbGg6pRamrPx/Ln+Uwsha7fwi7CW9BLEb5w0DPJIXaduCJCW9F0e4PMjGOjGsg4UrOfGXKp2eJRNR+YLd05eCsdlFbM2sPBuCi/Xb0hSPr6xLUKnG1fE09TtQ09LZlJD+UUm12XsF8c8lNyg/NNyL8yV/rFCQx1OqftRYFeC6Pk4DYfj/4rfhXlq8xrgk41FB5RPjMF7scVMxqkxv/yvz0qMmux5pRNASrHPDZOLLnVEocZpoRKEcLy+8NW/iR1+zvgPAY1rPTjfVzqc2Pux2MLTiRDLk72bMheO/9Ze2oRtiAHhKSU5Y5BtUv0F/GemcGc52XR3LPudXFtUFHdifkziGZG86eURqN96gbs/Ao6HVQa/A26OOos/+yvB8VRznCYGlWpbYoepoaIoW
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(366004)(396003)(136003)(39860400002)(346002)(376002)(451199015)(33716001)(66476007)(8676002)(6916009)(83380400001)(4326008)(66946007)(54906003)(66556008)(316002)(4744005)(44832011)(8936002)(2906002)(478600001)(41300700001)(6486002)(5660300002)(186003)(38100700002)(53546011)(6506007)(86362001)(6666004)(6512007)(26005)(9686003)(83133001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?DZ5+KTH/9pf6DcVHr8A4DswNsELlIoGdMEQJpccLWQOUkLm8GNTpsruMxdC3?=
 =?us-ascii?Q?/HfGffeE/Qv41qUUtHqbZfQbD+dZNNJi5S73+xGYb0N9W1uOJtduSNsjUhiP?=
 =?us-ascii?Q?N7bTQF7fYvsQWp7iuKYuuNEWSNP3X/xV3Hoj/baApRoj8QinwXOA0w10+RqD?=
 =?us-ascii?Q?J+XPn15nXB/6PHO9acdGT9UQNAXcdwSBM31QTauB3uW/fpPE/PaOUBhkgfQf?=
 =?us-ascii?Q?jhdr1R8a8cfrqGaU4xUpiFY9sEIzQd2Y+7ZWbmHueVacftZySa/SZymuPfxs?=
 =?us-ascii?Q?QYprXyTDwIwQ877MUQLilXD1uyqY1LuC1kGv5ivbPMZS+DmzoU7SvqRpXLGW?=
 =?us-ascii?Q?LWaBoJVtw3y4Jssqfwog6/PyCSs+QwVeK7Q+VXu3H6JxX+MZWyjmlv/p7bQ4?=
 =?us-ascii?Q?GIf0CkDRQ/nGzCZv02icj0VpCb1nnxXDwEPT5hD5Uvd5BcVpK62jRbHjBVwt?=
 =?us-ascii?Q?6V2+vNH8yUw8HNcLPtyf5/PtavwmhP7Exgyx2D1oG5Hy9FN/X/SPsM2PEIQz?=
 =?us-ascii?Q?2/yMZw5BaRGEoiUdIcXBmeABS+vXe714PN4EZ3AIfoi0Ci0ZR4iIl+zmZCKW?=
 =?us-ascii?Q?pSEnWKQBy8TcqMWw6dezcJc0Ph96ajGqD5EbCnvBq53/sftUGbDzaAeBDOCe?=
 =?us-ascii?Q?/CNv4RI/PTiIFMi3LBTUNUnAn5Mi+JYxC7YNo7j5cwJg5tA1H3YPauV3z49j?=
 =?us-ascii?Q?paNPJTZonoZGfD+uTySLif3NAJO3wib28IL0ZAqsA4inWkqyqofn/j94YcrH?=
 =?us-ascii?Q?wcivHjGOd6SfSpRV0KqvzpuheeGCjszj5Uyq9fKhLIamOqyxl4qyH2NdYDDg?=
 =?us-ascii?Q?AQodSImOkKEGmtI+ah/n6JP3bBW36uwwtiYjpfa7UvH+RPfxmIItGwdP2pyb?=
 =?us-ascii?Q?E416qRJ2lyKcQ1TPNGUlSGLIrzVHE0X6feYza2FCAivYKZZA9PgF9hV4Ltg9?=
 =?us-ascii?Q?cPGYjHLneKRYBNwsz2w+ZwFRFVZfuR7oy0ZMrZuIhOXAlH9pztMcHCX2hxkQ?=
 =?us-ascii?Q?6ac2t50WQYhdcIQR7Q7x/I1VKOxmGLLdIVKpk1S4wEfdN/OIt156IcPgpbjK?=
 =?us-ascii?Q?rh70VH918PbZ9X7ybSgTa8ktiEJ6+Mfl6ttqLEGz8eSdmzSPoiQnFGgr38WV?=
 =?us-ascii?Q?RiyWLZdDq2027dLpk4UQq5/AHbqUZ/gm4kO6og+nz1B3Ijc7L3QeyFfBvHM7?=
 =?us-ascii?Q?berfDHh6pP6xq3Ho8y7hvyOfKOHRmmrHqvT17K7+mmk28o+jwKPf7NhB8qTO?=
 =?us-ascii?Q?UODFKSEnsUaiiRvG31xj+8uv8JVR1+L41lYecPHYvG26tIGeLy1uhhAaR+I9?=
 =?us-ascii?Q?hcDK/eMO6SQXBMRilLI74MiYzjng9xxteCSTSDCgDcdniVXr+FzfA54s7WbB?=
 =?us-ascii?Q?qU5cttEAYqPKfnZCrutH+szbRgmBGLYDg3agRM/hqr0V/DlZdtmqKAR54L0T?=
 =?us-ascii?Q?5Njt7uYSCf9Y8LAloJnwMslyAKhKkskhXgIcnul177i56jgcbGQ6NchFeG0j?=
 =?us-ascii?Q?O4LRKlnCKLaFaIs5A29WxO4Hq7EFLG7Xsx8TWnvZ2+74rlUwodcCoqsNBe0Z?=
 =?us-ascii?Q?Y8wz9SExUJFPFsbHwHS8eDDUQSjUYO1ChI1pZshkyboFheEhMxek4u7NSK41?=
 =?us-ascii?Q?wQ=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4baa2e00-e301-4f7a-e245-08dabb8d186f
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2022 22:13:10.9243
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4A9vXF1S2EWkI8oe7GjXCUxqXvrIQvCz0+hD81hea0FQ1xCZPQpFCXweQLkBZcRPeMrMdfLwqrht+pEZ0/6bdQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB4898
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-31_21,2022-10-31_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 spamscore=0 bulkscore=0
 suspectscore=0 phishscore=0 malwarescore=0 mlxscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2210310137
X-Proofpoint-ORIG-GUID: nrEzBE6oq850TcgJXgCz_ycpQB2nmB9I
X-Proofpoint-GUID: nrEzBE6oq850TcgJXgCz_ycpQB2nmB9I
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/31/22 13:14, Jason Gunthorpe wrote:
> On Mon, Oct 31, 2022 at 04:25:24PM +0100, David Hildenbrand wrote:
> > Cc: Andrew Morton <akpm@linux-foundation.org>
> > Cc: Mike Kravetz <mike.kravetz@oracle.com>
> > Cc: Peter Xu <peterx@redhat.com>
> > Cc: John Hubbard <jhubbard@nvidia.com>
> > Cc: Jason Gunthorpe <jgg@nvidia.com>
> > Reported-by: syzbot+f0b97304ef90f0d0b1dc@syzkaller.appspotmail.com
> > Signed-off-by: David Hildenbrand <david@redhat.com>
> > ---
> > 
> > I assume this has been broken at least since 2014, when mm/gup.c came to
> > life. I failed to come up with a suitable Fixes tag quickly.
> 
> I'm worried this would break RDMA over hugetlbfs maps - which is a
> real thing people do.

Yes, it is a real thing.  Unfortunately, I do not know exactly how it is used.

> 
> MikeK do you have test cases?

Sorry, I do not have any test cases.

I can ask one of our product groups about their usage.  But, that would
certainly not be a comprehensive view.
-- 
Mike Kravetz
