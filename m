Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C49E674757
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 00:45:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229831AbjASXpY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 18:45:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbjASXpW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 18:45:22 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 570A29F3A3
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 15:45:21 -0800 (PST)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30JNEAd3016384;
        Thu, 19 Jan 2023 23:44:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2022-7-12;
 bh=SaF5NiBPivLMilPHMfSaRJxZtzsVgYOL4ri58OHRKLA=;
 b=S+Aqu2fT0mT9AvpY57ICnry3uiOt5KKEBDp8SPHo6DmfK8PMMBap3HlVmyIV6DPJOupq
 K3WCTWJRUwiccH0UYHRy6BBe8NPD1ZVf4W1C65thChj1cW1N1fNpvy9bu8/3BpeLw4bW
 SAj3TJ2no/XmzYAk0a3mirqTvFqQfjcDkmvpui/MeQRIKbHb5oOKx6aFK9nqQBwgX9NO
 g5uMTvS0ra6bC73/A4Znp9NUFBl/qjX2baw/IKW6YdOFdRUxZLGoQ7h7ACBbZlyucepX
 jKTLhVd/pON4klPVHdkf5fQZVZGk1Vi0jUkmvNSOwL2ZyGf9VzufPJZm3H7npBzyIANd Xw== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3n3k013jq1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 19 Jan 2023 23:44:33 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 30JLSumn000781;
        Thu, 19 Jan 2023 23:44:33 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2107.outbound.protection.outlook.com [104.47.58.107])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3n74d1w1vt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 19 Jan 2023 23:44:33 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SNP9PvO0dq7iMMCF5AMTGzmsfPoRhqMf63iMKBFTPyic4GpQtXM34I+WiMVCSNjAmD4liC5k4SYS0RrMtL4QjGmoa1MzLXBZwPpx4k49EPzxqw5l4IjcghCUA6XsXW/0N5W5MDL3wKgaDA2P8tO8eZ9l0YA8zz7c4YLAhfWlJ+6Wikgr+03zdMNMRfK215F6dA0pP/RGIHu/ILB0sIBMu4PMpFqr3HNQrOARAMM86wmG9SBFn4d/a20iKtE4bw1uE6GV/Hu79xyVupc6j/oJlTFHfxUJ7Fd68yjk7hWCIC0PZGKGtFiye5fOp1WcT3yxd0T1JzM+wNi7+8i2Actxlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SaF5NiBPivLMilPHMfSaRJxZtzsVgYOL4ri58OHRKLA=;
 b=h1DKbQotCEkkIpE+JBsSsvIR2jMC6ceus+/81itbdmfTjLlGO5U5gPeF1lOcObbKdZEi+OiyU6MYJI/uFoxh5pAaZ3Mmvcwje4AoRFfV4jzajEnGFco1pdLc0y676l1TLV3LP+y2M79DebG+LBfY7eO6G6rjNJGZBK7/2K/2Xl4M2T8z0rEtVBe2ISpIxji98p9d65E5rxipFdmcCP2LLIPRXeShqEnzCFmCWxnJaXbHWL0Bs7qkbU0+suKVhpQj3I1WH6fxLtomp/9a4KSo+whBJJkfS/bhQYXdNXesrOSPofJvd18qyu4N/QZXz502CCMQOhtB0s4AaIuQ7vBI3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SaF5NiBPivLMilPHMfSaRJxZtzsVgYOL4ri58OHRKLA=;
 b=ktLzfcEFK6Sgv2fyQLwZbjOb0vzhAhMwtux/BGujFwEr0kPp7lbAQ8rcf3ZD3txjBF6pnd2fLU09wqByspMdqUWBegHRokcS5PAY5QU6eudERd+VhJWtcEsHYJTraurpNxmmtbWBIlQOeyN/SxJdnL3WfyzpvxAuaoqo+nlTWAU=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by PH8PR10MB6621.namprd10.prod.outlook.com (2603:10b6:510:223::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.6; Thu, 19 Jan
 2023 23:44:28 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::3a1:b634:7903:9d14]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::3a1:b634:7903:9d14%9]) with mapi id 15.20.6043.005; Thu, 19 Jan 2023
 23:44:28 +0000
Date:   Thu, 19 Jan 2023 15:44:25 -0800
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     Peter Xu <peterx@redhat.com>
Cc:     James Houghton <jthoughton@google.com>,
        David Hildenbrand <david@redhat.com>,
        Muchun Song <songmuchun@bytedance.com>,
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
Subject: Re: [PATCH 21/46] hugetlb: use struct hugetlb_pte for
 walk_hugetlb_range
Message-ID: <Y8nV2TvMK12yTPzE@monkey>
References: <Y8gRpEonhXgqfb41@x1n>
 <CADrL8HVGMTowH4trJhS+eM_EwZKoUgu7LmfwyTGyGRnNnwL3Zg@mail.gmail.com>
 <Y8hITxr/BBMuO6WX@monkey>
 <CADrL8HUggALQET-09Zw3BhFjZdw_G9+v6CU=qtGtK=KZ_DeAsw@mail.gmail.com>
 <Y8l+f2wNp2gAjvYg@monkey>
 <CADrL8HVdL_NMdNq2mEemNCfwkYBAWnbqwyjsAYdQ2fF0iz34Hw@mail.gmail.com>
 <Y8m9gJX4PNoIrpjE@monkey>
 <Y8nCyqLF71g88Idv@x1n>
 <CADrL8HXkdxDdixWRKNw6RFdbiBX-Cb1Lk7qxg6LdeNywbMOaOA@mail.gmail.com>
 <Y8nNHKW0sTnrq8hw@x1n>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y8nNHKW0sTnrq8hw@x1n>
X-ClientProxiedBy: MW4PR04CA0261.namprd04.prod.outlook.com
 (2603:10b6:303:88::26) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4196:EE_|PH8PR10MB6621:EE_
X-MS-Office365-Filtering-Correlation-Id: a3139502-bdd5-4fa7-f2b6-08dafa771acb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KspWniqIBSXIicyigX3YCC3Dm4/BbwKgZXT/rZoZacZq0YWnmMJB4oNBJdQZcSVNXmDyKGAcqZE/oCMY8+3ZNWcq2HaTbM5DgNrZtUXXwHkJXe9lea7N731IjoBSmu5ZDfSObTOBVYLXWxT89/DHkiZ+zvXfd7MwjWGApZvnI4wxjDqKjAAn9ZW/2uUHX2VfFvEFLLTvSsYxIKs+kaytatdHOVIoskBuU8xb0UjVjDNL9klZbwiTGL+IKATEON9uesZz05UPZVinNxHOM0EVDDEe9tFJ1oZL7ohvjLxYXcFIGD3N80oK9qguUUijY2gc/d35AWEtIR1tpR/sQHgsfDoJmDEQHUimCYgVxYX2om26LLQN2L47+jsEwKawTJEaqDdpKGP4EqLJKlrZeE+Qfi0Qvo6sR9xVAeeF1vWwsXfiNZnSCmCfLmxTaBhEaDoXvKy1/qB4F+J4pvu6FtnWx3AslXDhdfbhxrUyciQeqynFiQmeIRnPqxMWNHpsVw0mBe5Yq8mIM0LSwzUF1Wno6qfewUrdZ3ZmhVM/Y+CZxpgrf9PvSbTGHTKE5HDohEMvDSoa6zbdE/x47ZqMtGQ4qkg2LauxifOdD74qaChmAX18k65ZqTCaOvxQh/bsr5/pBp58SldNkEGaCUIPLBw3GQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(39860400002)(376002)(366004)(396003)(346002)(136003)(451199015)(44832011)(478600001)(33716001)(186003)(6486002)(6512007)(5660300002)(7416002)(9686003)(4744005)(83380400001)(316002)(66556008)(6506007)(2906002)(26005)(53546011)(66946007)(6916009)(66476007)(4326008)(6666004)(86362001)(54906003)(8676002)(38100700002)(8936002)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?9nlHK+sIAAYUsdEh/GfBZ3oM/oMnpLW9AMjj+OZ3Gl3sqS5eO79t1tZQMwf7?=
 =?us-ascii?Q?5d1YAZ0cwp49U95sYee1nJ2hPT7+BNOZ7ApkLwF8pOR4rd9TK+XAsvakv4i1?=
 =?us-ascii?Q?Vbk+CSyw7rn4pTjlozONQazwy2P4vVhpLdSwtHBrokwlDmHpJAypiM2sDSQ7?=
 =?us-ascii?Q?0yYS4L9tCUM5hqlCCKGcSM5uuKGL73R5+O/0PwFpx+aoNLSHj/15m7QfhTPA?=
 =?us-ascii?Q?nvS4YVILo58ctaZ9xRfLOwVzgE3LZCWMUgvJ1MJNQOGOJ7gtD7lt7bHZaxxC?=
 =?us-ascii?Q?NpxxvRPYbDDbIXMLhemC9Ibca5fEVNkImbeddOEPvnRsYeMJU8XfF2yPCc3q?=
 =?us-ascii?Q?UUtxMIuLhCRZepb/0BzySw4fDhqweVhVc4O8SXYjRWUr6WD9I8jvTQq41X3b?=
 =?us-ascii?Q?P/XXDwp/K62KUJK8DhUNY9mOmAu1Y2njO9k4CrHeBBUOL2Xwekof31MN2FOp?=
 =?us-ascii?Q?B2ugRTXvA5z6W33MxqaogecpIgbZ+GdDR0L3cshXxehywxUbJfnEMNIiGzzh?=
 =?us-ascii?Q?xUS0io6t+2OepOcOmKwyD4F7KbTucYZ6bBpu1YjE5pCcmPA9U2T8CZJ+GhWP?=
 =?us-ascii?Q?SPwjUmwhLzOEeYVYoiaQ14tQfLWPzwAMcZGMZVc+52Kz+a3pO6CWLllW//Zh?=
 =?us-ascii?Q?SQlmufnEty9PjL2SOwQ7XW7Ci/cJxC0f2xxKX7/fQweMghvEaFa/NnHtMvkW?=
 =?us-ascii?Q?hz2FzM4yKTq0EKVCCyQd//I9mrCcTSFG6viRFd5u2WbceOYr/Ic+G/it3nwB?=
 =?us-ascii?Q?yibtNSf7H8+5UUFRR1H80hm9+JEiBlfcjB9r3wxNyS9kkP1IClad74xXT5+T?=
 =?us-ascii?Q?9Qb50q7Sko995yT/+wKRYOWHE5W3W8u8JCGCYLDpkpRXjZ6SUNcZTlFucAp2?=
 =?us-ascii?Q?VCLqTOHYhA8Fcbs3UjRu63WYIi58HfH4TH/RmU3omkq1Fpnlhvevm8ZeV4YN?=
 =?us-ascii?Q?zqMB3rWTe3V/qDqsBdpN31buD7w2VPPOhj63BMqjkbz0pntda2tFBNEEWOy3?=
 =?us-ascii?Q?nnd+/7NygtW7Tzv/ZGdTq6uRfB7ckkHJESaQUbIYTftpm7l6YrGQeB2pkQ9T?=
 =?us-ascii?Q?bzP2nYOc9bvj75XkP42YA5Xn8sfOOQcyj7FCR4Tq34LOkU5whtIrmBm+G/4q?=
 =?us-ascii?Q?+5VwP3x5WXs0gKewSUU3BnRYj4lYmHL1hwgXMhTa6ZDHvqQHrE4NwwiNveyJ?=
 =?us-ascii?Q?N/0o5okvU/QVM/wEBE5DH1EpWxTkg5SpOwnAe6TvhmDySU5C14ybMrdwhdR4?=
 =?us-ascii?Q?r9E5GcGx1Zq08044Agw9Lze7z+5bk1RIBiU7D/HOvzL7FqHD6Hm4ti5L8nVU?=
 =?us-ascii?Q?h0ekrS9VV4XyVaimKafSUUJSvrpsEnxrzCXHCejRG6DAxb7wxqContGkw8u3?=
 =?us-ascii?Q?KshiVEVw9PRh6NiDWFCSOITSdcmmstRWNJJxVejln65cICmZRrs6Wpkqr32F?=
 =?us-ascii?Q?ozujWrDEouoKRayL/kJ4I0oo+u2NnYLG1sbcjMHiMZ/WofqdVpM5xrdrNLZI?=
 =?us-ascii?Q?qEN/ebf7F6V33Cm+3vrQiYCo01U2RtUgSaIRg/rkwJj00rwrVqCYAWxkPadp?=
 =?us-ascii?Q?KHzrvGyKZC2M/YAzhBnLnOwCiYMSteWZn8uere+4T+ldfWwiuZ3qROlEZ/MC?=
 =?us-ascii?Q?pg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?ldrJbPruBFwjegwmhTrNRPBzKAp3x9bC/yTRlBGmyOsPy1ebNCjScK72bN7H?=
 =?us-ascii?Q?07B+fIIm8nBiRmxgXGXzwim0BAnttjlHE5ya2LOu94rJEyr/sVIS3FxUjT3z?=
 =?us-ascii?Q?kqCvWmaWOuCKuwKy1BuTKYcoAqpjFaeWI0yPcVzPkN+mtUA/rNzAuA/4S3tF?=
 =?us-ascii?Q?vL5aGt056yCl7+1rpgVDp0llX5Z0Ff3Eam1FXYAZL2fuZ7yObu/y+dhGHbQv?=
 =?us-ascii?Q?l0KM9wi/g0NJO+O15F860nMPVyBz0u2InWJmpn8IzmY1+ISC7OKDFK8pJIZ9?=
 =?us-ascii?Q?MatVIfb0g3yRmJA1xsGOismA3MJ6OZpfn+Wui5GB2LRs6Hndzi6Wdml2G8iG?=
 =?us-ascii?Q?mHiXREcYlDwUHiPhHboqRVKlcM4rmnAeU2SNiTnovoGv4K/VfIeLqSmZQ2ov?=
 =?us-ascii?Q?cnkf9GukiiN7HEjEq3UMo4E8BK7MpD02bvkS5gRrdjS6yuydSPa2qWdKSV/z?=
 =?us-ascii?Q?3iYoVfTzg6w/05f8It23QRAM3OYKtyUO64W/pcpRWg2C0zd7n1oLS8CwxGPI?=
 =?us-ascii?Q?UOerrzQIDnhTdv7vwsRV7XLQsuIOj6hxztIaW/jCqAsz6cMhk1M4bF1uxhTK?=
 =?us-ascii?Q?LG1ib0ktiz3maZ53M2lF9DWih+oxtFZPU0zeokG/pD6kzEnndnVh0caFhGVp?=
 =?us-ascii?Q?NLRPYxXg8dfOtDNdSpMI17ErQlchIhBvlV3vu+GjSTFe8WZ2qWMRNUVp187e?=
 =?us-ascii?Q?OMVreOs2u2qqSR9GnZgHq2N4+l+YsW5krcpJAzvYEbuxlUlCMGbjmXx+XrRH?=
 =?us-ascii?Q?uR8fza8aB9yQ3F47riXDJB5B3jihHO/patsgbBqSUgXgJ/B6TpTPKKdz3fGr?=
 =?us-ascii?Q?agmBAiyjH46uRuXsAKytUNuQa43MTAwyp6iBpcjwxHUU8xdL/4BVl6YDwg93?=
 =?us-ascii?Q?SciNWAkcm9q+aUJAV7IShCWjlmNWf5eyGbDvO5NPgejZi5zyqUtJet7wU1iq?=
 =?us-ascii?Q?/mYJ9xEyPQpcPm9iJlnb70wmwVuJbZ8tZUvKuoAFGwqBenIy7x8U55DtYhqe?=
 =?us-ascii?Q?yZYhcDqDYK0mRQ5Ppc0qNQYRA0AUPYSQ0dZSbTp1DRp9aYb0Pt6unXRmaIcp?=
 =?us-ascii?Q?7YmszVbb5g71j3eAUN+bRGqVFC4TMu9Sn9vBAdmHHu6R1DcZBFhtQIzusVYc?=
 =?us-ascii?Q?CTjcpQoXnYOwbmOMkP1CFKPqiqMXCxIECg=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a3139502-bdd5-4fa7-f2b6-08dafa771acb
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2023 23:44:28.5690
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: envkgo1KYFn1di+imuB80ZOBJOt1IXocMcRH7XQezVmVMJjSdexmL9ElJBOVdvz9hreBlnMBUnhUxO2E3fD8JA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR10MB6621
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-19_15,2023-01-19_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 phishscore=0 spamscore=0
 mlxlogscore=762 bulkscore=0 malwarescore=0 adultscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2301190202
X-Proofpoint-GUID: xwve10mHDy_abZqlrIssgzqxSs0npH2W
X-Proofpoint-ORIG-GUID: xwve10mHDy_abZqlrIssgzqxSs0npH2W
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/19/23 18:07, Peter Xu wrote:
> 
> Actually when revisiting the locks I'm getting a bit confused on whether
> the vma lock is needed if pmd sharing is anyway forbidden for HGM.  I
> raised a question in the other patch of MADV_COLLAPSE, maybe they're
> related questions so we can keep it there.

I can quickly answer that.  Yes.  The vma lock is also being used for
fault/truncation synchronization.  Commit e700898fa075 make sure it is
even used on architectures that do not support PMD sharing.

I had come up with a rather ugly method of using the fault mutex for
fault/truncation synchronization, but using the vma lock was more
elegant.
-- 
Mike Kravetz
