Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 038D860821F
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Oct 2022 01:44:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229832AbiJUXoU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 19:44:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbiJUXoQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 19:44:16 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFFC12AF652
        for <linux-kernel@vger.kernel.org>; Fri, 21 Oct 2022 16:44:14 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29LLDn3H005590;
        Fri, 21 Oct 2022 23:42:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type :
 content-transfer-encoding : in-reply-to : mime-version; s=corp-2022-7-12;
 bh=o2hOB+5stE1tvwN8KkxRejjp5WgFw44nJH9OrG9/fLA=;
 b=kj2FSwcq0owTFIweTedSpOHNAOt35ACu12aKcLiFi6VkrXCxCiPDs3gMe4WYnRvDPUKI
 mVJs44J2DmK+uexOZo/Cfh5VUV1WMgFkygLlhS2FyrVNjxQxltjP5mYibzpOeLTI08bF
 qY6zTDd7K+dN1/boSER3mEYlia3U8NelEdk3ZoeoJUqaXVt1mzUemDN6n7FYR/WQVEKk
 /KygrQYE6c2bycP+OsuRhn3MJ/lS/oJDjsKjs241M8YsDnf3Mq6uuvaqeSp6xdG0dj8j
 ArDVUl6RQpvw23EYy1FtJr/G+bLretOwGVcibw4DAzRljo6gvE/enMyr37hEY+kM7zb9 +g== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3k7ndtuc4v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 21 Oct 2022 23:42:06 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 29LLPxxi016974;
        Fri, 21 Oct 2022 23:42:05 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3k8hub9jxv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 21 Oct 2022 23:42:04 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L/5kvBGNGKaZ2PwDnE5yZSk4PIOI+V+cM1H9Vd4vDrQrQhUQzQ+z1O3bDryJz+XKJ3rLwdvOL6Z0GztTV66HQanau3FjkVVzRYxCllF/fXzxjtT7CWYSxvBymHazLMMZjOQgRu9tF3L39Esr3l9c4a0OnUhmoLlQXYszkkh2So1gqrpNHbq3apBozA/WcL6oKs6rhvm1fO7D/drgrfI3qXCbyxwQG3UZt0mo3bnWwtOGNzgRfTXWAHQ4Cm1s0WeWB66PYPwH1onhbaX+YJvXFmt2LDV+PQNQ0fypK1GK5rDQSvah8Gdz1s9ZwNG6ot/M+ysp5YhkB2r2q6wf03i8+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GNGefHcywQgU1O3V2jurio8wzamLLaNAQ4Pphp9SGOQ=;
 b=kMjvoRRwfTmZ/2C3jSdt5gd+goH2gzlAiFGzoBSFjakSjpEs++/9weK+hILOta1yE42duSRfmnq5CniV58O/ZtrnLtxAMRYul96wqgJZmr1CzBNYYvGDD4TsfcHx4SE7ID6h88oqBUoT6ViJXdAcjR+XwSVPaH7b5GZEyqGhz2ingiHfSMeAOxAxU15EfEHDUE1k6p2RccaATw3AeWTC6bR9leSVysVXf7VOjurj9AJCFrRHOM2wIH2rTYWLobfY0guFehhFqwTqC5Q3oiD1jJVFM3NpLTSuOzftKKUcUg5Eq3UKhkWPutTHW9duyZho4lBO4NJ0B69UIZENW+Ky0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GNGefHcywQgU1O3V2jurio8wzamLLaNAQ4Pphp9SGOQ=;
 b=g08x9oOJNoF/rcJpNLifVwoVCAHwcDzNpZ2TIZXMc+zpKPCWgE1uXKyMUJdrI5tDiWuTzr3FkwZy5GTEi5Hq/YfcYIAvgtjre7IyxBExZ6RRBSFVI8ogvsGZwkxlk9NLgZM094d0UQXfUStPuNI2HKqHzeO9LCyqnGoILnURuZk=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by BLAPR10MB4899.namprd10.prod.outlook.com (2603:10b6:208:323::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.35; Fri, 21 Oct
 2022 23:42:03 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::5f85:c22e:b7fa:21bd]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::5f85:c22e:b7fa:21bd%5]) with mapi id 15.20.5746.021; Fri, 21 Oct 2022
 23:42:03 +0000
Date:   Fri, 21 Oct 2022 16:42:00 -0700
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     Rik van Riel <riel@surriel.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        kernel-team@meta.com, Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH] mm,madvise,hugetlb: fix unexpected data loss with
 MADV_DONTNEED on hugetlbfs
Message-ID: <Y1MuSFgBkPZmLu7o@monkey>
References: <20221021154546.57df96db@imladris.surriel.com>
 <Y1MFjnDBOzpCW/9Z@monkey>
 <e0fc94ec3e6e088ad26d1b2ba7a1e9dfb4fb8079.camel@surriel.com>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e0fc94ec3e6e088ad26d1b2ba7a1e9dfb4fb8079.camel@surriel.com>
X-ClientProxiedBy: MW4P222CA0029.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:303:114::34) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4196:EE_|BLAPR10MB4899:EE_
X-MS-Office365-Filtering-Correlation-Id: 69b4b6e9-5156-45ae-5a13-08dab3bddaf8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zXlW/R8LKleFs3jYAeMuHPvcPp6NCVzWr+lGI4Qq7fY9D6ecg5EheOEe2sWSBTzuo7mZTPJsYrATvJqHdUzB6AxlvliuCUC7aHhfHbxsALBvOuAO1t/kxvRyepnKAgdlI6L+MXQus7upH7i2ucw1Slc0yEBXVlTzyoxHqwo+1eZbUZuXWGYUNu4cpENJbB+Upo7SnkPITcP7mppp/E+EXlQpQiKkK1QXFpVB5GLfotZ0I0fTHO0U13P2a3Nsyff60WtkODw8NvlUzFC93QDTMbBm+tCFyxGsfBhn7f84HxLL+4JRAFthhpBKlovthgmQeoKRqACCeyeZKScKBpYEYy4q2Iw35PSxgX587y6kkAqeacYz99Bsa6aljglLQvUMFezXNHuN6M6Vh+5TmoSnZgf2fStvybQbuRR6b8pg+tY7qxZl2SsoLoBbHI7ypCP1nPJkDGJ0xscWa7sNYoFF12SSIcqGVd9COfnrMJ1Z+DD6XUpSNd2OJ8YRtRhFNln7v7UUMGHxAOIYGcF7hj35HHMerX5ID1fxQ9gdvAw1I84IHh8Kkahed5cRuiFj7gK4gLbQA0Y16oVqUcIKDOFI6sFwJqy9YXeLURQA9Gwzdjblhd5kZP+T/bEHBvrDSgqcjhmF2vXqWLmgvd5gsQqi90EcXm9kNm3jDEsXfbIlgGVuMiGE/iOh9gvCdv21Jx49SvZj0ZT8gcWvBO0CsKL4HASUyAg/AVFCt79UP+XPXNk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(396003)(346002)(136003)(39860400002)(366004)(376002)(451199015)(316002)(9686003)(54906003)(6916009)(66476007)(8936002)(6512007)(8676002)(26005)(186003)(2906002)(5660300002)(44832011)(4326008)(66946007)(66556008)(86362001)(83380400001)(6506007)(41300700001)(4001150100001)(53546011)(33716001)(966005)(38100700002)(478600001)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?FPi5GbRwM3AN34YcLQYCa1uOYMJT60UoaTqHr5UytC5KrBe2k0y/+3KEtT?=
 =?iso-8859-1?Q?MDzHiJqPo7a9b12khBzTomcTFV1TykNQk9FR+MxccmudD0zoreG4mnfnsi?=
 =?iso-8859-1?Q?EJdy+fUJrWhQ+w6Rflxp+saxQBwoSE5mHg2GkvGUZs2pIFXLatY2fqHtdc?=
 =?iso-8859-1?Q?vIfOFa0g0EdioYAw1u/Ne0d8Bhe9sy8ZUpI/XYPe11XW220KOnTmP9xkr4?=
 =?iso-8859-1?Q?6rtPJ0OqpaRSy3taIXLW+n4Q+g9dUlzfBsctmeQGAIDoMHCfQF90ZRRp7n?=
 =?iso-8859-1?Q?zmsPA7fMB156e4iFfYaUSRkA/fFj+RKyu0fuIF8A2Aizb9ndarKCLSZTBd?=
 =?iso-8859-1?Q?DKD37Xi0IPph8Grm2TI//aIX2D0vTqFV4Eu9VympGk3ec+8XS7Xz4v/lQx?=
 =?iso-8859-1?Q?CcwCgfGupJm7uW2ME/letNorT/fkeB3OxyYFkg/ta0+K9dyx/VEMXg69VL?=
 =?iso-8859-1?Q?ilrbnuDuD22GPOBXWVj9mTDC8ZSX4h624y+Pr1sjh0cZGruXIkY0I8KBbg?=
 =?iso-8859-1?Q?qNh4nOUBHmpiXXHpFBJWE5HJOlZ+BrZjDDyvLaoBfAm0WGIfEg9ocIT/SP?=
 =?iso-8859-1?Q?Apyf1YpUg5X5vHY2mWMBt5xd4M06j/h9qFCTUMnezEHZsEN41UhxL4jZS3?=
 =?iso-8859-1?Q?NpNynAnbqMwkPRHbhasIHl02fGq8LZM7W3GRXnK6CLBTP/LHkCqKftwFWj?=
 =?iso-8859-1?Q?MosXOyvf32o+ZUlHfMxT1Mn2XZ+kaldyJhI5qHNXYb/AgdxPyxQgQY36HP?=
 =?iso-8859-1?Q?X4P2juuqQexVHYJWCfrwBkaOpw9cFxFs0eH3G8onhXMiudFJTWxfzAUA2p?=
 =?iso-8859-1?Q?5ahwQE05+MN3RX7q6f8tcK8qTsFfdh8d1cXTCFpDHkFnv8cr8KaFuYuy8q?=
 =?iso-8859-1?Q?ROOg4Wzv8aTDKzSZSyq0mTm2O9FJ7WG7rnUopDXbIVjOqLsgst7KNw0QoR?=
 =?iso-8859-1?Q?GPg+Z53SF4Wy5SRExygmk/PJGjUraRArPKemi6kOfWMFBisAfefu2TtPc2?=
 =?iso-8859-1?Q?XLahe0jrq7HQ/uQL4Bgup7gRv9uhFb0zxgt4cjZ4nQHppr5Ji6wqkZTUNx?=
 =?iso-8859-1?Q?8VU0vG7f48ISQZ9ckNzgWHzBizOOCJsQ/Q4tL5EtLZdkJG9rSyAO+4Topp?=
 =?iso-8859-1?Q?GUnOEyuejZmggrc6iTG4XZ6CLTq8VP2OWl8aXgA5OfKS36sraC0phv4jXs?=
 =?iso-8859-1?Q?rqqJMgE8CrTAg7a1UJA1GmL8nOlg6JFre8cCWenf4OeBGVWuCuSKzSsmQh?=
 =?iso-8859-1?Q?X2wkrV4fK4sSw51QMw1kGLGMKnyhj03Fr9cc8JOSCtyeb9xL2htbdHAkEa?=
 =?iso-8859-1?Q?FWZ4edmD9c7wJ82k8WnRpO4vHL3xNePjEvlNGfvfWa2o0oM7Gj4ERRU4+l?=
 =?iso-8859-1?Q?w5YnMGL5j8envRckZgLb6FYHvtM5a9XWEJhAehHztMXlqzHTJ/tCqOIpb9?=
 =?iso-8859-1?Q?Wa9CSMIbrLIEYwPRP99FYwLSxnF+AIsZenyqul9UJYiSleiTycGAIg/RVV?=
 =?iso-8859-1?Q?EzA5yEm1NC6+GfTFS6KCkNRm9Vtx8XSw4a80PmwdLJNMicybzVzZ77U/n2?=
 =?iso-8859-1?Q?1BO/S+YKG/fr+BFVYGXycNXnrPNxAj1CK6YnoKAm/4ORzPgz4yjHnPCrTA?=
 =?iso-8859-1?Q?7nyx1bC2kIAOpJB1mCSXCVZs7PS0h9WobAgjx2iKIJlopn7UsoRI6Mgw?=
 =?iso-8859-1?Q?=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 69b4b6e9-5156-45ae-5a13-08dab3bddaf8
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2022 23:42:03.1182
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rxSyASFiKfVbl4Ok1EBC3y+JKUD3NXWYSz5mvuI6zDt2k4RzOZrcdCocrjoORgdyXznvh7Z8qRjeBMvIzHR1NQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB4899
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-21_04,2022-10-21_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 adultscore=0 mlxscore=0
 spamscore=0 bulkscore=0 malwarescore=0 mlxlogscore=820 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2209130000
 definitions=main-2210210138
X-Proofpoint-ORIG-GUID: hXAxE3WOTGGueziMGKciDxqB5xqHFL9u
X-Proofpoint-GUID: hXAxE3WOTGGueziMGKciDxqB5xqHFL9u
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/21/22 19:29, Rik van Riel wrote:
> On Fri, 2022-10-21 at 13:48 -0700, Mike Kravetz wrote:
> > On 10/21/22 15:45, Rik van Riel wrote:
> > > A common use case for hugetlbfs is for the application to create
> > > memory pools backed by huge pages, which then get handed over to
> > > some malloc library (eg. jemalloc) for further management.
> > > 
> > > That malloc library may be doing MADV_DONTNEED calls on memory
> > > that is no longer needed, expecting those calls to happen on
> > > PAGE_SIZE boundaries.
> > > 
> > 
> > Thanks Rik.  I tend to agree with this direction as it is 'breaking'
> > current code.  David and I discussed this in this thread,
> > https://lore.kernel.org/linux-mm/356a4b9a-1f56-ae06-b211-bd32fc93ecda@redhat.com/
> > 
> > One thing to note is that there was not any documentation saying
> > madvise would happen on page boundaries.  The system call takes a
> > length and rounds up to page size.  However, the man page explicitly
> > said it operates on a byte range.  Certainly mm people and others
> > know we only operate on pages.  But, that is not what was documented.
> > 
> > When the change was made to add hugetlb support, the decision was
> > made
> > to round up the range to hugetlb page boundaries in hugetlb vmas. 
> > This
> > was to be consistent with how madvise operated on base pages.  At the
> > same time, madvise documentation was updated say it operates on page
> > boundaries as well as the behavior for hugetlb mappings.  If moving
> > forward with this change we will need to update the man page.
> 
> I'll send in a patch for the man page after the patch gets
> merged. I'll change the text to clarify that the system
> may round up the specified length to PAGE_SIZE granularity,
> which is a quantity programs can get through (IIRC) getconf.

Ok, the man page now says madvise only operates on page granularity.
Perhaps we can add info about using sysconf(PAGE_SIZE) if that will
help.  What will really need to be changed is the description of
rounding hugetlb mappings up to the next huge page size boundary.
Just need to describe the hugetlb behavior.  Unfortunately, we may
need to define/describe the arithmetic:
	ALIGN_DOWN(PAGE_ALIGN(length))
i.e. Will align down except in the case length is within PAGE_SIZE
     of hugetlb page size.
-- 
Mike Kravetz
