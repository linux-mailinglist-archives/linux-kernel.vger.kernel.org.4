Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93F9E6F4863
	for <lists+linux-kernel@lfdr.de>; Tue,  2 May 2023 18:36:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234303AbjEBQgP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 May 2023 12:36:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234127AbjEBQfw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 May 2023 12:35:52 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CE5E49D6
        for <linux-kernel@vger.kernel.org>; Tue,  2 May 2023 09:35:01 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 342GNx43016600;
        Tue, 2 May 2023 16:34:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-03-30;
 bh=vOFZqaVg+6fLE4Q7ig+0q2WDXtE5Wew/WEHDxeZVZS4=;
 b=r0Z/SKf/UyAZRfKmfFpwbrgB5LV2i0udqlU0fZuo0E5WZ35CJErcDCOP80evv82IviA8
 YAhsEt3aUkRyE5JHLKnRgA8ZOKZTG8iZ25R+62NU9YlYRwiVR66r/uvC0Kyz+J6kSMJM
 U8kEIeVHLz2SWTo2dWYaJRP8v/CEgB4NO7MwUzWEnkdATQk0CXGUoae7K/MzJeXMewTL
 GT0Bmxkur8BvZ8tH8rwS+bU8zxTBAvM5vrQ5jtExOngy8QhZ0ey3E+RS5I/eGza+39uq
 A2Il8RUXAnl0ZCOvPBuWxAw2FPInNyzLUCCGuB85/q0vX8EaODlVycMnxprBq7zGyJhG SQ== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3q8sne58da-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 02 May 2023 16:34:48 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 342FRV9o040442;
        Tue, 2 May 2023 16:34:48 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2104.outbound.protection.outlook.com [104.47.58.104])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3q8sp60pyq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 02 May 2023 16:34:47 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ug7ztdNPT6/Ru8uWIHqoIHikTomruf9jxVFrEL1DVQNLqYLikqOmv7tEuJREPVXfqu5XMJWAo2Mdl5k1wHphLnPUldB3Icj2obhpUpWrbJe2PH2gteHti9XAYiwxa0Q36VH2TRKAQn5wpc5tKVHtAqsa79oS/KFWF2hh4L9cf5pvMvL6xz46D0xmX28zX6UUDi14tTqCUWvdMDRGpPtCgH7Q0NJyPh3uc947dFP28RQ363RJKyXLiSW+1V/kexoVYrQ2mFW2EisRM/kvsdBOarEngp+ghUw5Ht4T93rHdiCt40yD37y5NdpKsRIxUB9sRFWOTq3Ljhsb6hlxsaYMQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vOFZqaVg+6fLE4Q7ig+0q2WDXtE5Wew/WEHDxeZVZS4=;
 b=Rd15n4eaXxzi3cJzDJcg5p28OOtykwqtcSdIE7FIzihJB6QNmjdKfNIJD96Fs/7zZdaA4FDwR0RQC6A7O8C/6CsFk1XssDjaA7sjfmWI5IFwgi78likoflnlKG0DUrujEeelK7qlUL27qAPqZqcJmLQOo9K5rtf+p1xM4huW6r3Uth3cqHRrI6zXRlMBrtgy1+fdMUyEOjeUh9zeZGVpWxSo+lEu/k/TC+NdGC0kqt9Ea94vWFe5eSn3KOW+lQipSwV88q69gHbwadkjFfUqZfHv7JDcz+5d4spEIdkWwLIwpfh9WAZfQTHJ1jUpD/Ai//sPqr3e/wRV0cnXn3unSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vOFZqaVg+6fLE4Q7ig+0q2WDXtE5Wew/WEHDxeZVZS4=;
 b=M0yvzn1fFukMae0+eoztK1uKx5q5nQSbVB0v3ScDvbruGRXAwjq5NwaI0NrTqvkS7GSpGTkYcAqr3veGAvSXAhtIoq9DQDXZuEHxE3WMpGCVwt32tBxZcfVBfdLQ6+3K6Bp516f60m4G/ac/ftsg3fjPqfL8oc+PAbVu2+WXaZo=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by SA2PR10MB4812.namprd10.prod.outlook.com (2603:10b6:806:115::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.31; Tue, 2 May
 2023 16:34:46 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::ffb:de39:b76b:52eb]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::ffb:de39:b76b:52eb%3]) with mapi id 15.20.6340.031; Tue, 2 May 2023
 16:34:46 +0000
Date:   Tue, 2 May 2023 09:34:42 -0700
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     Michal Hocko <mhocko@suse.com>
Cc:     Vlastimil Babka <vbabka@suse.cz>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Lorenzo Stoakes <lstoakes@gmail.com>
Subject: Re: mbind MPOL_INTERLEAVE existing pages
Message-ID: <20230502163442.GA3873@monkey>
References: <20230501185836.GA85110@monkey>
 <c8d21c1e-1bcb-e995-9b58-01ea3320085e@suse.cz>
 <ZFEMMg7gP7hJzIvl@dhcp22.suse.cz>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZFEMMg7gP7hJzIvl@dhcp22.suse.cz>
X-ClientProxiedBy: MW4PR04CA0183.namprd04.prod.outlook.com
 (2603:10b6:303:86::8) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4196:EE_|SA2PR10MB4812:EE_
X-MS-Office365-Filtering-Correlation-Id: 4d17b220-611a-4148-9166-08db4b2b237d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DsnFWjRKVdSUCXVMz7x5+o0mKIq+9t1oBfFZPDjKE5Dh//EGS0evVRgQ4M1jL+koWFkFvaVdNnXnJpCO653b+u2uF7pWT78xFuH+mEbEcQgyU51ntFMakjPnNYCqW9Lx6qQZMalX5+jCNFZcxkhmpvAP1sWht4x+x0dRu2y2/EKZQ0DRELJDQsR6uCbJa2ofoVO4ZvzcYa1ZuKV71jWZ93CEy08tpGG9X8X1KuxeeEDGNJ1WShxZZbCjMQfDZp2Duzi+mIQP6uAaLrNPM6mocCDpavKBhf7+KTRLI3dgw54kT8kHhG9U/iPuLy/AXdmJRhrCNif5BuOnZ3RnkiLIN5LGUco5j43aAyE9QVqqIxcue1JTx474xBpeaMQCYUaOy5JpLuhuOuVX6LL+eHPK+MzMI3c0kEcHwbc9efBzh9LBZcRaKh9yCr4hAPB/mJqItI9pIicpACCYIj2LxIruJ1LFCh4tTFfs/oZK/s4Y6v41970rC2Z7sqQOWwohDUGUd79RTfBdNNuZ8f4BlOigMYLWpw9mP32GR916yAbZ9j8LJVh8T4/CeJ9pd3q2MV1F
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(39860400002)(346002)(136003)(366004)(376002)(396003)(451199021)(5660300002)(38100700002)(8676002)(8936002)(66946007)(66556008)(66476007)(6916009)(41300700001)(316002)(2906002)(86362001)(44832011)(4326008)(33716001)(6512007)(6506007)(1076003)(26005)(9686003)(53546011)(6666004)(6486002)(186003)(83380400001)(33656002)(478600001)(54906003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?aO6EXoIb5wuVqRbWux/j1iJqEwGuzU/Phev7wKKXn976N71V+a+WsDJH5rOB?=
 =?us-ascii?Q?vFiceEjfpxkrS4B4n8Xvnb7hgX8WLFmb62vezm0HtTixmhxdnarPEgSQEgYU?=
 =?us-ascii?Q?+uIPiDJX+8CkG9G5MSz1NwAiiYr0h/v7n6XMAf2JUb1U2cy3tNY2+G2vcilH?=
 =?us-ascii?Q?viccEokfJNNgL/S39YG7g0/H+2MIE1JO9PDHO7mEAu5639YuS4vG+iQ6yBMU?=
 =?us-ascii?Q?WxXf14h4sZNmNeFOOwN4XjFRMpYNiaHLURwgN2CASekzbbOLRQbfQC+EI8Eu?=
 =?us-ascii?Q?N/0Wv929Bh4aUDQVUeFKfQe/0lb7Sj4mitNAMIpZYon/FVydNY2GA/zM1/wj?=
 =?us-ascii?Q?WppcUFiDfkO/rC6fhPtRlPxMrX0JGKQp0nV416ZOOT+Vm1E3GRh2ZkZ1PpIn?=
 =?us-ascii?Q?6MSgCtXupq0SeSb2Rh37XzA9icmYJnwBKmP43zVUQKhWhfb1Vw2oxaClmkH4?=
 =?us-ascii?Q?xch8nVZilVWpTdA2IcGUu2oC9iqj3FyPUNYa7V74BfM4OEyTmQJd7JClEwkn?=
 =?us-ascii?Q?KuWuF+y5+uQjb32GI8PmaDEuGLgwFzd2qkkbS2vwpQ0tSFU4iLPp5+46sqNw?=
 =?us-ascii?Q?JOFqXgp6UKqp1vL8ofFbvIWn0hZj6xxxz0CTdaajhnAKeZAQUjzOeIaMUDVt?=
 =?us-ascii?Q?9r+8etve/XhxiPmmBIVugELsZwhE2qNZCMiPD3eeEt8Zz+80nVkCiYCKnXJ5?=
 =?us-ascii?Q?RwH3fTj46QSU1vM/Sqh1u9j+iZbCB/I636O5jKMDfkuE/flBecmtYlzgsbrn?=
 =?us-ascii?Q?ThUCcCziUmwuS/h/FKdleayp9H+VF8lIJ/mG/feuSot97pyNKxAXxD8PPzzw?=
 =?us-ascii?Q?5hxCJ/lpNSSCvzy/Y2bTpotmudiBLodr9NoCm3RzS99KLK4zOvA2u9fGJltl?=
 =?us-ascii?Q?DJA/SyY21ZlNnh8VDz9rwXGYicIDRa7lwNpl2VbcMUNNpRq0YH0Sf4pFlMz7?=
 =?us-ascii?Q?SUE9vv6TVpQqSTuPeJG60kabeX0quczGEhJ/mzshA4WqOCXrNLTCo3PBDFiU?=
 =?us-ascii?Q?c/EQCWxzF1fDkdaXDA7qps87u/H8hKNd34JtsHowo6QNxsOi81rJ//eaCr4N?=
 =?us-ascii?Q?WyGsBykVDkISC3WOy2Ch4EPOqahz6/XVK6Cc9aH/44E17NX3kiCZt5qU5UdX?=
 =?us-ascii?Q?CUaS8yiYDsCxAmwPaY3DDpPAsnz58bMV7UHrx7dF3wAhBUBI/TcTSP2/a1Dd?=
 =?us-ascii?Q?FMKD1/hGTpo8mBFgrJyuhw77pMQ0i1EzfOif1e1+rkCUchG3pfnsEFvlIYVq?=
 =?us-ascii?Q?XsBO2/R5z/o84rN3Lwv0dMCH1r5kq88PmYtUzohLykK5ISZiidbBs20ZOyfv?=
 =?us-ascii?Q?Xz7YNsjJmqZRysbln14kVa8IbPgpokXW2jp2mgDzAGPaI/VacRjmwCxCU2rO?=
 =?us-ascii?Q?T+LGEwpNZQ4B17E+hBV2n25Fn5t18Hz49+1CQr3K8QNZaZFZD0N+iPOpnOez?=
 =?us-ascii?Q?O/pyjTrPtAwlW2hE27i7x5+M7Px/WZpx9kXN+ZcD3X3IJ86cLzrBBF9rC6sw?=
 =?us-ascii?Q?Xy8GLeUNRYbaf2PFS1+fDfKkzIrO4dtDMdvPoh1qhbejuD0mjk4jbW+avGHo?=
 =?us-ascii?Q?Q53Lhv/BL7Bc2X7bw/pJbQ4Mh7bwUx/hUUP+S/7+?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: sJx2i+WVXLONpnYz95wHA5AzWXWYUZ2263s0Y7bppJ1UfdFETpbG+4Ilyihs9/MF/G0ebW5gajmTpBEsbCyDJ5hLTOG7yFu9nDl42OlTrY5dG7A7qPhKj7O7wMs/ZVSnNUfsGGHnK/wJOHj2HqnWlNJJu5nLMaaj/PyqqgC9HxAGerYs4Iuksoiw2Et7RqvymhWbu0bIzDAElMYO+miqWTC+opPlCuUviP2lEEFpFnsseu+Xdp+S4m/4wOoeidsAm8aI1nvU3AA26IsIALa0QbmkfMybveTSWNd0hZ0AbVstzchHd6rAU9QCeqW//T2E4o5FUzikA5HkUlllDbtVKWFJrlLJPJ6RpRWP3Pn1dIPA316W51ngPo4A7SHsAQsSr+zVtAn9ZDrhOKHqJPIDab2mrJ3HfhiEjrb2m/Feb2gfINC2MdWXQNGLZqkAMcoM0xc60OJSYhfJaBvF3Sx0uhxcgMxLQL0eBtrdAI3ZxaUO9svOHdDxzpOhBkwmENQ3iOlevA5csa8mr5yETBFBnj/27HrNKeG2yc8jIu8sSAb7lZPqqj/Mj6t2tZeClj8TvpPAu2Weq+ovD+06H9n6z+13JgHFPlMkdPLv/8mezq6t73ajlHjIKZA9EUVFGnjb+K9803tMG9qgFcXyMOZek3631/ITd+o+jDb82hu7zJI+9Rv1HyodC/iUetcxyaXAr5EvyOvJBhsIGdEDM/+hV3+5ns5ZI0uJ8jAj+HroqC1sjdWjs4ix9MupD7rE8K61JzIdIlHGz7iYpfiXK/z/60XduYV2qBZ22quf4YLWoX3pLcWH8t5nbCb+uyz2AR5nNHuKV9Pe7uilmsZNIs9JVyRibKvwxd5J5uK9K7TTZMQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d17b220-611a-4148-9166-08db4b2b237d
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 May 2023 16:34:46.0949
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WVJSavYXAoawRgXFPVNSzhzqZSJK8Kr1wagTbwOFfBO6H1bSbcddoHeg36HMtTXrEB+29YGnhIfHj/Rzrt/qVQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4812
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-02_10,2023-04-27_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=956
 phishscore=0 bulkscore=0 suspectscore=0 mlxscore=0 spamscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2305020142
X-Proofpoint-GUID: PPTH16YwPbQyFFSl_8nUm9Ab5iMYiIXi
X-Proofpoint-ORIG-GUID: PPTH16YwPbQyFFSl_8nUm9Ab5iMYiIXi
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/02/23 15:12, Michal Hocko wrote:
> On Tue 02-05-23 09:45:40, Vlastimil Babka wrote:
> > On 5/1/23 20:58, Mike Kravetz wrote:
> > > I received a question from a customer that was trying to move pages via
> > > the mbind system call.  In this specific case, the system had two nodes
> > > and all pages in the range were already present on node 0.  They then
> > > called mbind with mode MPOL_INTERLEAVE and the MPOL_MF_MOVE_ALL flag.  Their
> > > expectation was that half the pages in the range would be moved to node 1
> > > in an interleaved pattern.
> > > 
> > > In the above situation, no pages actually get moved.  This is because mbind
> > > creates a list of pages to be moved via:
> > > 
> > > 	ret = queue_pages_range(mm, start, end, nmask,
> > >                           flags | MPOL_MF_INVERT, &pagelist);
> > > 
> > > No page will be added to the list as queue_folio_required is called for each
> > > page to determine if it resides within the set of nodes.  And, all page are
> > > within the set.
> > > 
> > > I have reread the mbind man page several times and agree that one might
> > > expect MPOL_INTERLEAVE with MPOL_MF_MOVE_ALL to move pages and create an
> > > interleaved pattern.  My question is should we:
> > > - Change mbind so that pages are moved to an interleaved pattern?
> > 
> > I guess it could be worth trying, if there's a use case. And hope nobody
> > else is depending on the current behavior and will complain afterwards :)
> 
> I am not sure this is worth it wrt. complexity. Essentially it would
> require to build up the distribution for the whole range first so 2
> passes. Also it could become more tricky if the final node mask has
> nodes of difference distances (it would be a reasonable expectation to
> distribute withe minimum total distances right ;)).

Yes, I was worried about the complexity of such a change.  At a high
level, interleave sounds easy.  But, like most things the details
could add a bunch of complexity.

> > > - Update the documentation to be more explicit?
> 
> Yes, please. I do not think. While this sounds like a neat feature I
> think the additional complexity is likely not worth it. A strong usecase
> might make a difference though.

Well, this user has a 'work around'.  They simply make sure to set the
policy of this area (a shared memory segment) before populating.  And,
I don't think they would really be happy with the cost of potentially
migrating hundreds of GB of data.

I'll send out a documentation update.
-- 
Mike Kravetz
