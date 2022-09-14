Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82F445B8DDF
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Sep 2022 19:09:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229729AbiINRI5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Sep 2022 13:08:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229630AbiINRIx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Sep 2022 13:08:53 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4DC04A815;
        Wed, 14 Sep 2022 10:08:52 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28EG2DFI019638;
        Wed, 14 Sep 2022 17:08:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2022-7-12;
 bh=sxnu/ud7okUwTaP46Kbo7izmkdpc98GY1qFcrzjoz/o=;
 b=CgNZ129BvNhr4mdfBI0Y0V0IwktRbmgKG6Zezu9xrai+jmtzNMlCJHxiCEiLxj4qAcl7
 fbSM2M2/MY39hL11XI+8pSxixu8gJfbtQiqH905Hti0zIxvzJaHI6u8re71Oy0CP4BJR
 Ie2jTAtZvwAXfvkLht+KoLDYuQqlrorJrewkDoIoV2JHNUQfIpRu2PwVulS8iNNj+amd
 XvwOUGULX45LH39K+up9UVVa4ay5r9DdsFZ2u5mHnKtju1zxgGm58g9KDKvuX2DkD7R8
 9apuKqqtt2ZBIKpcTOVog9QMUpk6vI4ZM/eFa+gVyK28/UkeTfoQ88M6Ay6bX+cHfXvc rg== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3jjxyf2vwv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 14 Sep 2022 17:08:06 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 28EG6pXB009756;
        Wed, 14 Sep 2022 17:08:06 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2174.outbound.protection.outlook.com [104.47.55.174])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3jjyecxdc0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 14 Sep 2022 17:08:05 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VonjfKMW/AIrLbCdyCfVJhmyCopzzGoOY3oqcw3HyDRCVW5fVzDHUasL3XvZKCz8ObJLhocZRjvp+PHisn28GgGgMuB5OH+zSKsCkxlJDnfYwZ5eO3O4xQHDFgYqdXHBe3e7Y1aCh49E/gNYm+9nvbLlxJHwmOQld76Okhw41H6ZDrS23O14+8/VfVBzJ4fPRKmZnfPsnKqJOuN0KoeHKz5nfoxf5Ie9Zvcc/xR1+B2O08gnGS/H6U6cY/Tm0zlfAJsepPBq/DNTr7mVqGlOoxB9VNGxX543uFvdcbW0PB0I75TH7lrT0CiK9Awa9al0EvBlATZw33E+rG/eja+HJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sxnu/ud7okUwTaP46Kbo7izmkdpc98GY1qFcrzjoz/o=;
 b=C49b/HVBXqWREjxpDDLF77VkSSP0ZV2j/08A80EejU0yiD4bn+TA2xHvb/3tUym1HNSgwZXg5VUNjK4Iv2ip0r5YwONA691pS2ZaOYiDFyRufCvzYLcF/f5pDz23XIQFhfCfb87MMxaXipW0xozP/pYWBZpwG9KEB+YoMbVM4K6nEADNssl8eqRJ6ZK+TjMlGGS9FxbN5fuanv2HesKrPg2Y+If8Neal1VdIMmZMYPS4rVbFhazJivocwI0Tqnp7QZBlpfV/nnw+1MoEjjp8W+NHfd1qYb5/5+du19xIXb73nZpvyV/hAq4UyPDckXFw7BNBlP7PbtTeIKfxkh0BHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sxnu/ud7okUwTaP46Kbo7izmkdpc98GY1qFcrzjoz/o=;
 b=MABD7BPzAQNXEBC/+ZTwgalgAGGP1xVBdPHlu8KOZNqkbJr5N8ttWbTGAJDIq0LNOwRv9Dx8oMQmFUcs0d1zdpMVZe6vkQems5gGnHPW5SZx0pTeqor4X8J16Khro9nSD6+xfMLrI2/m7uJqPjzfroV4VBztCisjVyd7RaoT11I=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by CH2PR10MB4149.namprd10.prod.outlook.com (2603:10b6:610:a7::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.22; Wed, 14 Sep
 2022 17:08:03 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::e9d2:a804:e53a:779a]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::e9d2:a804:e53a:779a%6]) with mapi id 15.20.5612.022; Wed, 14 Sep 2022
 17:08:03 +0000
Date:   Wed, 14 Sep 2022 10:08:00 -0700
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     Doug Berger <opendmb@gmail.com>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Mike Rapoport <rppt@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Borislav Petkov <bp@suse.de>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        David Hildenbrand <david@redhat.com>, Zi Yan <ziy@nvidia.com>,
        Oscar Salvador <osalvador@suse.de>,
        Hari Bathini <hbathini@linux.ibm.com>,
        Kees Cook <keescook@chromium.org>,
        - <devicetree-spec@vger.kernel.org>,
        KOSAKI Motohiro <kosaki.motohiro@jp.fujitsu.com>,
        Mel Gorman <mgorman@suse.de>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-mm@kvack.org, iommu@lists.linux.dev
Subject: Re: [PATCH 03/21] mm/hugetlb: correct demote page offset logic
Message-ID: <YyIKcNRP+Q0Vt3CT@monkey>
References: <20220913195508.3511038-1-opendmb@gmail.com>
 <20220913195508.3511038-4-opendmb@gmail.com>
 <YyETeBdbldnoRZ+x@casper.infradead.org>
 <33ff9543-3396-7609-3865-7eed20b853f5@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <33ff9543-3396-7609-3865-7eed20b853f5@gmail.com>
X-ClientProxiedBy: MW4PR02CA0007.namprd02.prod.outlook.com
 (2603:10b6:303:16d::33) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4196:EE_|CH2PR10MB4149:EE_
X-MS-Office365-Filtering-Correlation-Id: 3ed0a77b-28fc-4240-9658-08da9673af4e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7N1MeNe1tT3vrO7FV0TboRdzyGPIrZ3MRBvjjg5U7iWgpDsOXqVnJjre0cmhBFlKBBDu0vAoNeMcI5ygRKQDyQ50NEt2tqIkdCy+ehRzwQaRp7OIXIexXeBk9d8iTPWOTFK2Q8bqWUxn3sVhRfHxiuQg1CE3U8piEVJkTFSf7xY19jE97pROoO57F+c5gM3ntmv0rLN9b87f2FMM8XbdXMwfNEsnIpFzJbfWKUprBfXvl1E7eWq30UMKYAZtYdr1vyrjL5ueeg4w29ZTucFQLcxlwqyjYTBUlgmk1iMZKhZuRDngS50EDZAldpwSebW63TM/y69dL2BSKD9XJjeh0pokjsGSAwuV6lGf1PKJS3KDV6zbY/30yQZZf6ZimTeGaFmfxya3Im247HRCONa8SNSKzp9i8EPskDTLrW2nCtqshbJiXqomUgj2HzixdraWTkY44wbU/SqI/156B5zlUodCseRuOqGvl41lG/adinMBCZ4VMV71eMmjO0m0qi+QAFlX1C13ONzSdBG+UtpJ7Sa9JpU4iJ/1SE+Qzp/GsaHSiNdLv7YPQLOT8nE8g5GdLLtoshEj49FxYjrXMwD5RFaXBP8hCB2r+RyrXsR1JSUZGQmmM1QiHegU45nLU4YN/6z6bFQ1Uuijv8onONliL+Gr98uh2LAjXH/drs3GHeKJQywQUYu+Xl9fLvEnlPf81xYSHOXE+qbUHDHDTUFhPVefE7h54LwF3qpnLdUUhqRkIWwiVHCChzaPl0WHgZFd
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(396003)(39860400002)(346002)(376002)(136003)(366004)(451199015)(66556008)(2906002)(66476007)(26005)(316002)(4326008)(66946007)(7416002)(8676002)(6486002)(186003)(7406005)(9686003)(6506007)(38100700002)(41300700001)(6512007)(8936002)(53546011)(4744005)(54906003)(33716001)(44832011)(83380400001)(86362001)(6916009)(478600001)(5660300002)(67856001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?knZ2ZqrGiEj3eBWtMRs4PDCbE3aJzxPGFzWt0nLgIYeIFaMZbVAKufrn4v2r?=
 =?us-ascii?Q?NISZDavDnrXNzP9obS/z9jkCz0gmWnd/7qaukeUmhBkMNROVQXpldgTEebHd?=
 =?us-ascii?Q?5bJ1LoLXRgx/CGAQMfuatykwsUnQgV/MusM4eBpz8rxLM+P8d1n9yGQM0Jmw?=
 =?us-ascii?Q?5LiXWVyL5S8EML+fxRvDNPJ2w7iy3hLW2i8fMC+RRGJKDUPJ8ipqBAX+sc6g?=
 =?us-ascii?Q?oUyc/MUBkk7pvQ3WOgOTdTQB9qKWbnD0zQv6RNdIAsQmxFOoRPAJAF7zJ5M6?=
 =?us-ascii?Q?RLarze7AFdcc0O6dDZ+DLgjpBvW3VEg86l41KuSmS7QMpYqOWNB9tvW4UGj4?=
 =?us-ascii?Q?ZQn107NQnZDNLVDPQQjyBXobjhPnLJRGF1dt67VCsjFjRfwdNlwmMozZCzCs?=
 =?us-ascii?Q?uwjO55a3I7WMaSYs8kFRy4q9Sk1L9jC+O93I73sm6taqhivOZsan7FEx9834?=
 =?us-ascii?Q?2UlM0bNiXKG/WprNNnEiGGUdwa8N79vcmu4hu9CulyzfzeBv57xtHM/2SMwS?=
 =?us-ascii?Q?f6XpqfI7zd8Zy+iep+uJUaOaNa5sZIUpOEdPapl311AOfC+DWjYo4uuw9Dnj?=
 =?us-ascii?Q?U9WKo8rc5pW2F5HIdvPabkEcKPNPAsAVVjV0yaABD0zZWeOvGW8AgQ/HdAW5?=
 =?us-ascii?Q?hSchvx4kb0uA77q0f2k0Z8XP/u2XviBXl8aYv2oHtoEbEAl8wEay57kYI8uc?=
 =?us-ascii?Q?JGLu1GRh+rwxdrInmfyF6Iwipq9+vUfbquzM2Pb3zVIGF+FsIEFM1YmE64dd?=
 =?us-ascii?Q?i9HM8AG1dHfBvE0hBHaJkeLO0zYenxVZo/83lmHKFHDlV0fqQ3Zu94sW/9ID?=
 =?us-ascii?Q?dGPjC+/0aW6NwR+Cb6j8SoEGGlC/xNL75RlIvU0GQQBaZmMh0br2CnX+X3Qd?=
 =?us-ascii?Q?uVQ/2fR33Q2q0+AxUXRD3fZ/gycv+AX0KQpazTQFiDhrXPzriaj7vir6ULS4?=
 =?us-ascii?Q?zA+cruh/3FkmiHip7zU+k8W3e1IGdlfNXzSOv+mDQdfg2I9dJHJ5Gfa0w7yL?=
 =?us-ascii?Q?nfC8ERfZKlXE77Gma62sSZvuCidg9zznU9Q3Z1bcTPdm9K29IvZXdHqYNxbt?=
 =?us-ascii?Q?VrO2KMkt4TpXdjawRZmPh18JKb3Ssd/4SUkd2P8YuHHPEqcTNqdn/UUYZKMu?=
 =?us-ascii?Q?7k+/A+MDmkF7Fd5YhWG3yh8QXAlddE1kNv86ZR6A9sH8/SDsII6tHeSA2DAv?=
 =?us-ascii?Q?Q+9W/+bImRqaM+gY1gGtlI90EK5nsg3kQpHYjM5dZXU15plm5GA6HUqvDxoN?=
 =?us-ascii?Q?hn5wH+0wv6cx20svAl0YZ5P2TOu0xF0lAV2fDIjOPx59AhMySg+KmKEf2qFQ?=
 =?us-ascii?Q?xWgKx2CBUpyq7zIAS37Gs9CJ7Q++VQSnWCAfABiXF2D6fCPHMD4P4Ba/EcGJ?=
 =?us-ascii?Q?0S/pJzWaRd+854Ql9nFmpoXz12B/O88tFL80MvbwiOeqvQnW/SEaQGMvZkbq?=
 =?us-ascii?Q?GDaxkJOsz7c9Whm9HaSL2bFWXidVh4M1BoC4bPqy1iyP63kKVEDBOaky+Za8?=
 =?us-ascii?Q?uA1V5RvU3qdwu9W+97NYXHzrllKi6bhLvsFvtrIOddDE/8i8Yw+UJeQgsjfE?=
 =?us-ascii?Q?jXMVDIywmaEFBRHbzXFp7D/MwhX6UR5dtJwmhMdTuhcvyXl2Nlfhv9WncZZD?=
 =?us-ascii?Q?ww=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ed0a77b-28fc-4240-9658-08da9673af4e
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2022 17:08:03.5414
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /NQG/Di8089dYWYcI8veLTApzl3kGrSD6E3Bfl4MCaBvJVbVaBshwTZOv9N2FQwGp78XuKU0FPHFIfuK2xTfVA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB4149
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-14_08,2022-09-14_04,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0 adultscore=0
 phishscore=0 malwarescore=0 spamscore=0 mlxlogscore=842 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2208220000
 definitions=main-2209140083
X-Proofpoint-GUID: bc0MjNNQTBxUiAaxWQSyLoC09UJ72SJO
X-Proofpoint-ORIG-GUID: bc0MjNNQTBxUiAaxWQSyLoC09UJ72SJO
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/13/22 18:07, Doug Berger wrote:
> On 9/13/2022 4:34 PM, Matthew Wilcox wrote:
> > On Tue, Sep 13, 2022 at 12:54:50PM -0700, Doug Berger wrote:
> > > With gigantic pages it may not be true that struct page structures
> > > are contiguous across the entire gigantic page. The mem_map_offset
> > > function is used here in place of direct pointer arithmetic to
> > > correct for this.
> > 
> > We're just eliminating mem_map_offset().  Please use nth_page()
> > instead.That's good to know. I will include that in v2.

Thanks Doug and Matthew.  I will take a closer look at this series soon.

It seems like this patch is a fix independent of the series.  If so, I
would suggest sending separate to make it easy for backports to stable.
-- 
Mike Kravetz
