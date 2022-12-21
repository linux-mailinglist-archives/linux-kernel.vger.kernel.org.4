Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC692653845
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Dec 2022 22:40:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231834AbiLUVkj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Dec 2022 16:40:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230072AbiLUVkh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Dec 2022 16:40:37 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FB03248C5
        for <linux-kernel@vger.kernel.org>; Wed, 21 Dec 2022 13:40:36 -0800 (PST)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2BLKd8On006209;
        Wed, 21 Dec 2022 21:39:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2022-7-12;
 bh=/KpTbCFs4WxYn+u7Rg/M2ZnZhLJz7Ac8vOlfdAYsEh4=;
 b=WZ93xLYEli/Ca5/YM4a8flaSksUIZvluWXyBjuPtMWm/Vb0Z5EiMb2Kyw6YD0ulhCKrX
 F8aDB0t3VoMfcQQ2npeK9yo/tPw6ET9ou1Ngx1cJyLnMHcTW4NVdxxcDaWI0kIOPkhxj
 lmXkv9kvGJ5bkkse/tTc6mREZGohaO5be7e3NidHdWCta7QvcIFOxvYgkP/paO0Jzkoy
 04atdulwKOYeQXJTgPeOyTMlV2RJX7WcAytGL09UTxQ2IFP+ms/vkhfxfGl24xtrp0np
 QTz73Wc5v6tUBsHAiJp/CEaMrQB7qKzfoa4yvhpb/EMmf5S/CdRaPkpxdinFfQJXjG75 NA== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3mh6tpa2ng-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 21 Dec 2022 21:39:45 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2BLKssKw012176;
        Wed, 21 Dec 2022 21:39:44 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2047.outbound.protection.outlook.com [104.47.56.47])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3mh477dcn2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 21 Dec 2022 21:39:44 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=alDPvxKq7K68DJ6vd5UG5BWi6tLB/DVH9Yl3E4IvtTbv6O0l4jr4SUgmfT09x4IZBb/HgQdprr1Q3yIFu8XxcdVb9G3cab0DmLBhf0NzbiF8NujxFRhvsRMukX6bwJMRKtRyDlbn2zEsaW+3uw7ipCQeGYX+yTEunDp+q5T9mc3DXx4hlg4gxcnbq8SiAzv3xuBubZBS3rCZRh3BnQWyWaUc9zTT6B5mqxlBna91eMzIeTnGh5j0APyhbR8YX5r4pL6P4Zow10I8pqt8bW7o+teBot3MVkFOhPlcCjhUz2pOkJ7mB/XaTv7BY+HVElZumnpBT1zLEgSNrMQDOEOwLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/KpTbCFs4WxYn+u7Rg/M2ZnZhLJz7Ac8vOlfdAYsEh4=;
 b=iET48eO+jRVqbOQbC+L8MMGgl4TrphgChHfO5knW6Q6w1GNaPjU5kdrKAsjecYBci4r3f2bWnJnsl6v5tDWXexOr6Du7C53vcUbzqi0D7rPwg+jRLqhCBISkqWUWYGuZ8Ygu6txhRXDHwysr9oIcgDA/8stHeiaGve+Yrm5Lz2BBCOLCiTwsVkb1MQrzdFnhOtjnm1W4i9ygYZy8ee3bMSYLdLfZY3plPhZfcGcowe1giCXiHpdgowNEsVkWANIpsUsC11j4T/kULuv+gK1Wsdb8NMapDDuTXvgBRBwL09uqbkQ4qL+3LRCyEr6cdMY0683XudY5gH7FDoZVYlhqJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/KpTbCFs4WxYn+u7Rg/M2ZnZhLJz7Ac8vOlfdAYsEh4=;
 b=JK5h8FxP0F85GqPbrp5BR1B0yuW29X8xfdfcre7c0Iena0bJSfiN5sb4Eorq0jI5Ah7MML8qPVUOgVtrp70DlXwas2NkQvdjf7Z94iN6Jw1xRw+w3nylKnJ0KOtER3rfslqB4NMAVmTujJzK97sdMN2KwsxnYFexJDhWkLptiBY=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by BLAPR10MB5156.namprd10.prod.outlook.com (2603:10b6:208:321::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.16; Wed, 21 Dec
 2022 21:39:42 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::8d67:8c42:d124:3721]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::8d67:8c42:d124:3721%4]) with mapi id 15.20.5924.016; Wed, 21 Dec 2022
 21:39:42 +0000
Date:   Wed, 21 Dec 2022 13:39:39 -0800
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     James Houghton <jthoughton@google.com>
Cc:     Peter Xu <peterx@redhat.com>,
        Muchun Song <songmuchun@bytedance.com>,
        David Hildenbrand <david@redhat.com>,
        David Rientjes <rientjes@google.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Mina Almasry <almasrymina@google.com>,
        Zach O'Keefe <zokeefe@google.com>,
        Manish Mishra <manish.mishra@nutanix.com>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Yang Shi <shy828301@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v2 33/47] userfaultfd: add
 UFFD_FEATURE_MINOR_HUGETLBFS_HGM
Message-ID: <Y6N9G0Y2j98V8Pnz@monkey>
References: <20221021163703.3218176-1-jthoughton@google.com>
 <20221021163703.3218176-34-jthoughton@google.com>
 <Y3VkIdVKRuq+fO0N@x1n>
 <CADrL8HXixUPyTVmYMiwc11Ot5sDMsA3x7VhgXQjimJ93MSZihA@mail.gmail.com>
 <Y6NdN2ADVCcK70ym@x1n>
 <CADrL8HXqE3s4ckxh0OU5onkhystj=1jMTS+S7GFeiO+kwBo0QQ@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CADrL8HXqE3s4ckxh0OU5onkhystj=1jMTS+S7GFeiO+kwBo0QQ@mail.gmail.com>
X-ClientProxiedBy: MW4PR03CA0109.namprd03.prod.outlook.com
 (2603:10b6:303:b7::24) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4196:EE_|BLAPR10MB5156:EE_
X-MS-Office365-Filtering-Correlation-Id: 2d1f2e53-d8a7-4c18-7ed5-08dae39bde63
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gjuxeWN/4N4yTimRcARCYYRukwFHuhNIywBwXMxYGdv0yu92FmQVQNqrKCxZ/KfbVkeQOKpKqPUDCkQJXCEYp/8dzOliJ2C7ZMXkFpX2GUmpJEzf/9ookNP7CZ0PlvvPuPNCVXYlimtXlHT+ohm3zjEUi2mXU7tSHeqtbgvgB7FoTXR3THJa0h4YgdfY6PLgeh0qvLIcWn6ZHxkAYRNY3RPvs2YNuJhyOkLTydgvPk5nLoTuxXBalvzjmJcozZHz8VoDIQcGLMe9c43Lp5dP2FYqLzNqEb6Jgzyc3GtVLxiDURRF8VdU8nL3d7e0b//G7ZD+6HC3fYdrjrD9j9M+G5XHsqpy6EeVXHUTuEdfhHNCUpTb+EylSfDTTRAUPbbaz8s8WcM42jvB+7ua7Ci0h+yOhhVbOKR0uWie4hYdYGfI9EqU+6BCJ3HLq+7DFLHVsxk0uKO3ZRDZEpKdOS9KN6VNxr8Y/9FrXvUakenaqvtVMd19ODCNqsLLUQUtBi6ngAld414WgjRPo+QyQc2l1YSJbATNtfTwrlT7lepKaZWHSzconA19376hxUT503n28/YXBwctcrEkl1wEFUeNoFbpcgbA98RgBtpHoArtYvv6dX4CHYLd5zx9/HO/rYuS/87IQX+ByqxekY2ZtvprnA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(366004)(136003)(346002)(39860400002)(376002)(396003)(451199015)(6506007)(6486002)(2906002)(478600001)(6512007)(26005)(9686003)(186003)(41300700001)(66476007)(66946007)(4326008)(44832011)(33716001)(5660300002)(7416002)(8676002)(66556008)(83380400001)(54906003)(316002)(8936002)(6916009)(38100700002)(86362001)(53546011)(6666004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?SB9yjec+D0ySqNsStJ6HDP4yx1yMgVzKNoKB5d9RSkm8tdGaCNGnuJnJ/JnW?=
 =?us-ascii?Q?CNzdc5SE9bdTqpwdZJakqy970QZE4YXU1aO3JweThyYySJzAj5iKJYszfmFw?=
 =?us-ascii?Q?Moi94bZs3mMcGtKQnqPxnODFPYU6bXVgD9DQ9C5XBd2CatWRWPHU32v4C7C/?=
 =?us-ascii?Q?zMWmg+gjeyfT+2/mZC6+O6lKTK8oXl9yabPxX5FNCtivHBIsV7cyHhFFbByL?=
 =?us-ascii?Q?tCdgkynkKz48jM2lY9el6x0k1I+axpNO11PlkN7nQmLYxUzrtZsd8TT7oqZN?=
 =?us-ascii?Q?kwKofZlP08MYFSq8WQDrquPNcyquMU37zxYurH7YGC2Klp25gDr70LTZD0MD?=
 =?us-ascii?Q?6eEv23ZtioziXuuGBZzHuwIGVcP6eZ3kDRhaoMQhWhmxSeN+lkoTmK+4F3wG?=
 =?us-ascii?Q?Pbw51R1Q9WN4jMZw4q1u5TgIGa04G9ay/VcjzebRT6OT7iHYU5Cr70O/V9Dg?=
 =?us-ascii?Q?hmxAx3rHKiuJRXCtgcVZ4dpuL/bJlL5gdZ/FD56adY4XWTvqftUC6ksTiL8C?=
 =?us-ascii?Q?vAoE66U/pCeB/6/PCvg5048AcCpFQHAyant+6Q+SNdnJGGGqzkm4Ww+0OQXb?=
 =?us-ascii?Q?zf3qZCkH6nBXdwwGMaLqBzjiDQbAQ2HnRra9gg1eoCqlZ78ZJds1fFqKLpan?=
 =?us-ascii?Q?pEAmeKkKSe+P52U2wervIK4DGCUICN2TP1oD0Um1NoOuFOn81Swbw999rccl?=
 =?us-ascii?Q?X23pV1NQ9QWUHNZAPqb292LHdYqSHgSjabOhEDB7g577ri2P6CRLcEwOqtdy?=
 =?us-ascii?Q?tKuRjrj4k/EOzn/azLwNSdR4H24BGbwDxp2gQj6vh228BsqM7cWEfrtUz5ob?=
 =?us-ascii?Q?PSlahYuqomCT9jsyta/IEEX0LSRFmoWf5PxYbHXP/VX+fc3GgAwZw2+dFEpn?=
 =?us-ascii?Q?ZAnloNT1wcxiBLCMns1iV0khTCrb/hrbYri2rtdokzzP96HRiyvERsHSRCUe?=
 =?us-ascii?Q?sx0mfzmuFnsoRooMMC6isQb1cECa0Yt6DAuR9MnogAldn4lv7BldoVYIPKCS?=
 =?us-ascii?Q?s6UJEWqmQag2LDjK5Ao/iIABa6/JvdnyzAAjpTkov6UXoQTd5wWs2u7RZf+z?=
 =?us-ascii?Q?PS4lCuY2QTS/RR3DxF64qzW02HDbjijGtWmNqLYowf5wW6eI99fbt2nIibPS?=
 =?us-ascii?Q?F9ORui+F0r1O3znOVUhyib8cUWrur0jxFudf5w3EEBFO99jBy1TLgHko5sZl?=
 =?us-ascii?Q?jq0QLY3gMJAhPmcFtkHmsjPUFoQCh7dZdivNmjL2Vzu/23J1TzviPwf+BD2S?=
 =?us-ascii?Q?dpRLhgcnuVFbMX6zFzpGH7ug2kGrl303fozga+ga+8+sU8LSG6cZqfb3bsyx?=
 =?us-ascii?Q?HcIAkw4cEQwf8FpxctoCO0IJEJgK8PTLinz/PU3lg/R0pxaItLJbGubkTOJY?=
 =?us-ascii?Q?mcZZGjHECgIAPV7Kge0WS3hG+ss8W7e607K6zaP2Dv11+eoW3T5UhbtXcZfs?=
 =?us-ascii?Q?nm00vcJR7cSKJNTokbdbJ/q3PfTTBoisxfutm0TwbXNGznjju5up7zWWFFJ5?=
 =?us-ascii?Q?Fv5b2Vj0RIlb7cmQhr/tCg4l2vkYC93XQO8pukm/v6n8keABFulxPrJsw81b?=
 =?us-ascii?Q?LqAjtxD27m5QOUsH+JHTl35z4BS7+mPa8V9YSZRPqd6HpnoqvXvHEpY6fCVj?=
 =?us-ascii?Q?yg=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d1f2e53-d8a7-4c18-7ed5-08dae39bde63
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Dec 2022 21:39:41.9825
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Qpe0L6wThwWwY1UdlKgOZ8xbsqjQOf9k9mC35V03dmvLgsMxP+eEPmaGTEHmdsx29afeEVXSADadp+w6KONdXA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB5156
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-21_12,2022-12-21_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 bulkscore=0 mlxscore=0
 adultscore=0 phishscore=0 suspectscore=0 spamscore=0 mlxlogscore=920
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2212210182
X-Proofpoint-GUID: _rEbxhm-OWYmMu8J_lsE0ah2ZEfxSxm8
X-Proofpoint-ORIG-GUID: _rEbxhm-OWYmMu8J_lsE0ah2ZEfxSxm8
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/21/22 15:21, James Houghton wrote:
> On Wed, Dec 21, 2022 at 2:23 PM Peter Xu <peterx@redhat.com> wrote:
> >
> > James,
> >
> > On Wed, Nov 16, 2022 at 03:30:00PM -0800, James Houghton wrote:
> > > On Wed, Nov 16, 2022 at 2:28 PM Peter Xu <peterx@redhat.com> wrote:
> > > >
> > > > On Fri, Oct 21, 2022 at 04:36:49PM +0000, James Houghton wrote:
> > > > > Userspace must provide this new feature when it calls UFFDIO_API to
> > > > > enable HGM. Userspace can check if the feature exists in
> > > > > uffdio_api.features, and if it does not exist, the kernel does not
> > > > > support and therefore did not enable HGM.
> > > > >
> > > > > Signed-off-by: James Houghton <jthoughton@google.com>
> > > >
> > > > It's still slightly a pity that this can only be enabled by an uffd context
> > > > plus a minor fault, so generic hugetlb users cannot directly leverage this.
> > >
> > > The idea here is that, for applications that can conceivably benefit
> > > from HGM, we have a mechanism for enabling it for that application. So
> > > this patch creates that mechanism for userfaultfd/UFFDIO_CONTINUE. I
> > > prefer this approach over something more general like MADV_ENABLE_HGM
> > > or something.
> >
> > Sorry to get back to this very late - I know this has been discussed since
> > the very early stage of the feature, but is there any reasoning behind?
> >
> > When I start to think seriously on applying this to process snapshot with
> > uffd-wp I found that the minor mode trick won't easily play - normally
> > that's a case where all the pages were there mapped huge, but when the app
> > wants UFFDIO_WRITEPROTECT it may want to remap the huge pages into smaller
> > pages, probably some size that the user can specify.  It'll be non-trivial
> > to enable HGM during that phase using MINOR mode because in that case the
> > pages are all mapped.
> >
> > For the long term, I am just still worried the current interface is still
> > not as flexible.
> 
> Thanks for bringing this up, Peter. I think the main reason was:
> having separate UFFD_FEATUREs clearly indicates to userspace what is
> and is not supported.

IIRC, I think we wanted to initially limit the usage to the very
specific use case (live migration).  The idea is that we could then
expand usage as more use cases came to light.

Another good thing is that userfaultfd has versioning built into the
API.  Thus a user can determine if HGM is enabled in their running
kernel.

> For UFFDIO_WRITEPROTECT, a user could remap huge pages into smaller
> pages by issuing a high-granularity UFFDIO_WRITEPROTECT. That isn't
> allowed as of this patch series, but it could be allowed in the
> future. To add support in the same way as this series, we would add
> another feature, say UFFD_FEATURE_WP_HUGETLBFS_HGM. I agree that
> having to add another feature isn't great; is this what you're
> concerned about?
> 
> Considering MADV_ENABLE_HUGETLB...
> 1. If a user provides this, then the contract becomes: "the kernel may
> allow UFFDIO_CONTINUE and UFFDIO_WRITEPROTECT for HugeTLB at
> high-granularities, provided the support exists", but it becomes
> unclear to userspace to know what's supported and what isn't.
> 2. We would then need to keep track if a user explicitly enabled it,
> or if it got enabled automatically in response to memory poison, for
> example. Not a big problem, just a complication. (Otherwise, if HGM
> got enabled for poison, suddenly userspace would be allowed to do
> things it wasn't allowed to do before.)
> 3. This API makes sense for enabling HGM for something outside of
> userfaultfd, like MADV_DONTNEED.

I think #3 is key here.  Once we start applying HGM to things outside
userfaultfd, then more thought will be required on APIs.  The API is
somewhat limited by design until the basic functionality is in place.
-- 
Mike Kravetz

> Maybe (1) is solvable if we provide a bit field that describes what's
> supported, or maybe (1) isn't even a problem.
> 
> Another possibility is to have a feature like
> UFFD_FEATURE_HUGETLB_HGM, which will enable the possibility of HGM for
> all relevant userfaultfd ioctls, but we have the same problem where
> it's unclear what's supported and what isn't.
> 
> I'm happy to change the API to whatever you think makes the most sense.
