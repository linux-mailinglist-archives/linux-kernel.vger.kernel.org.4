Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D293613EE8
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Oct 2022 21:23:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229907AbiJaUXE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Oct 2022 16:23:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbiJaUXB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Oct 2022 16:23:01 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4381010546
        for <linux-kernel@vger.kernel.org>; Mon, 31 Oct 2022 13:23:01 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29VJmuOD014808;
        Mon, 31 Oct 2022 20:22:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2022-7-12;
 bh=nwI6PvKYT8D6KdfODtE1MmnpMMJzvv0taBRihuQgDR0=;
 b=yb9WwMU/LNHB1un8gyuahjbz5dctr63KRR8G4kcLcgVfG2lVsWbtq//XynC34FQ6L5tU
 fvPqvcyPtxy3QeACQuNuPJZx3hdgcnTAo4o7jQIS+fwfQ6m3s6TiePttyoLuiYewJ1Xb
 +9NTqeM/wkf9jy8UX4OTDuI6mvfyTXUQc7ax9xLd4zNHydn5JStu88ExoFK8CepS0oIA
 LRUnUxwqlieC8GPkGSQqIEOUpQtlR4DZisUTgCL/6I73qThs+ULFutHdBCmTrB8gSJSp
 L4dJQNkygoQWD1G79NWGheDDFQvj+DwdBPSGFFSSQfPCXW2QOXPZWLzejND0Gmlg4FHO Ew== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3kgv2acs54-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 31 Oct 2022 20:22:48 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 29VJg6mS019155;
        Mon, 31 Oct 2022 20:22:46 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2175.outbound.protection.outlook.com [104.47.55.175])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3kgtm9qs9h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 31 Oct 2022 20:22:46 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XLJZi+68K7w/Cz4TfkQXYqgeQIQGHP6B/SAUTSFR07OO0ish+sfY50f2l+vzAC0Ene1xbhfvMv5i8JKYKONCZaweJtUz17XFQe4Xm1+Njc/VtsIfx0CXh35e0nuo0Z7T0GN6O1E2Mv+zApXeTYspylopUI/7U5iF0pwHFlN86ZbRDkMn3186JltgUKo3ase8R7xmdtvGUTvsHIrzUuimCuq+35AKdQyf4S2kGbKjTq3HhJgdK36nfdNahjoVtY1J8tnefpOMQTYs1JxVt8EdeUZ2mGuu9nNI4oy0KdQNEADNWq406GSo6TlJ656AhaTyumUej/ZF78qQOGCjz32Pcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nwI6PvKYT8D6KdfODtE1MmnpMMJzvv0taBRihuQgDR0=;
 b=jMhs8Cy5oFfXL0mUvBwtreiqJKwmxT4ejJmQwikvQkSS/HihuCHd2NeDtd5WDQRlHF10MmuafuF30+FMUXUk61J8QPw3kWZHlVCLoBcOD4evz+AwRi8weqWKTeVCKk9Kl4qds49KUqRfsC3ZCwuaKVWezZqpp6tcszWB0KaUu2IT4OUFBw1LY2L9jZGuDMtfELZEwyY0rZRbsGVdOfK34Nk8aBXquIdzUBcDUEcgdAC+WvRzUGxd+hdhq2m8B82UYwfLBLVw7Gb1aZJf5lztzGpbwB21Xq1Bjktvh1Uq1frMnu6k8SM47KMuH6W+TOfKKFQeUIGZBVyb6h/McHw6UQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nwI6PvKYT8D6KdfODtE1MmnpMMJzvv0taBRihuQgDR0=;
 b=Odx5zTj+Yw+67nscPaD8X2K5m1MR3W/mRM4XYVY/yOgGSlAA7GaRIl0KhHANBQJ19ZcBRbLtkcPMHveRrEWNYDfpYJtig6KUJJtWOcyfj/RUzniZhW2HINwDpx8xM/Y1kFq1sJoFzzu6ukNmE1NsQCbR50wtBmzaG1NGzwCozlE=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by DS7PR10MB4958.namprd10.prod.outlook.com (2603:10b6:5:3a6::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.19; Mon, 31 Oct
 2022 20:22:45 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::58e9:95ba:d31e:ddd3]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::58e9:95ba:d31e:ddd3%6]) with mapi id 15.20.5769.019; Mon, 31 Oct 2022
 20:22:45 +0000
Date:   Mon, 31 Oct 2022 13:22:39 -0700
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     Sidhartha Kumar <sidhartha.kumar@oracle.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        akpm@linux-foundation.org, songmuchun@bytedance.com,
        willy@infradead.org, almasrymina@google.com, linmiaohe@huawei.com,
        minhquangbui99@gmail.com, aneesh.kumar@linux.ibm.com
Subject: Re: [PATCH 8/9] mm/hugeltb_cgroup: convert
 hugetlb_cgroup_commit_charge*() to folios
Message-ID: <Y2AujzrfNxYeJ1Te@monkey>
References: <20221014031303.231740-1-sidhartha.kumar@oracle.com>
 <20221014031303.231740-9-sidhartha.kumar@oracle.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221014031303.231740-9-sidhartha.kumar@oracle.com>
X-ClientProxiedBy: MW4PR03CA0337.namprd03.prod.outlook.com
 (2603:10b6:303:dc::12) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4196:EE_|DS7PR10MB4958:EE_
X-MS-Office365-Filtering-Correlation-Id: 76a059e7-b481-4ae0-95b2-08dabb7dab81
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YqanlhsPmayCu4F01hpnlAxfox5PUuNhn544FuSPs54YXxQpGEp+zbAW+OrIbIjyvME0AqI2/mZlLZ1lvMOeWFMyVS+75j4D7uPWm643U4CimyJXuk1R3u33RGU834rY40Gtm25o+Qv3clCNS9OkbMMZEzlmPlfMsXm4S6knqdavlreEJ4rc1W8D5LXiLotw15wNgEIOvVgf1kUtR68N3ReMuzaZqgW4DFx8lWEQ+t+3XpcRXOCkPMW39ugj3rDwSMhn2josG4S8jAd8LmxF7ftxYKZHqMeDsb4y2ppP3HH6RZRaybABAo0Wwuq7/OP9fgPmTCpSOXyoA6FERqBfkrFrobfrki61nnxeAK/+6NB6zw6a3cToJwU4pIzDUIAvcWCaMVKkLTK9+16JwY74rYW7qEQkq0UDHNYFa0x1Z25zY3VBUoc+Ojsm/49uVewC/baCkklY1z54sNBUEOTbMyrz5cR/SJnO6l93F5GR7SNTzlGZP0pES8J4bmmWAYnYbNu/b68jDuWdKYJ/40+Yzkjw/RyfcWtQ3k13HhS0wlWHsukMGMIFOziP+58z9Si1Pu7VJechydHIwMPE1XYDGWzkxNuYhwTca6wIkFUyizXlqBzAggkXtkIHmc9xpe3kfC9V/poIz6pmAJOJ2LKlwhB4nqLGlYqhKUfIYX8mO5QSCEXH8+5nRoO5CoWxY5w7F9mE4WQ2aUp2K9etpefkbQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(376002)(136003)(39860400002)(366004)(396003)(346002)(451199015)(38100700002)(26005)(9686003)(6512007)(41300700001)(2906002)(4744005)(83380400001)(8936002)(5660300002)(6862004)(186003)(44832011)(6486002)(33716001)(6666004)(478600001)(66946007)(86362001)(6506007)(53546011)(4326008)(8676002)(66476007)(66556008)(316002)(6636002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?juSmfwkFOv7w9vphQGvhnDusZJSeFEVJ4NAUFKXDvliiVZsrCza3QyCUMxVH?=
 =?us-ascii?Q?VqhS1Iwe5TXzAJ9seqaya1IFkfNUOljq9XT/MbACLR/2yXf5T13kVi0fiCbH?=
 =?us-ascii?Q?mmReZEAraf+OFB4b2iB7i8dheSnnnh6qMQ3A/HlAVaIIyCebW6Ym/Mmz2/OD?=
 =?us-ascii?Q?+dRmpERUOAryuzOtE8i2O0CbDAOr3QCIAUEwqF6MS5OutWOM6dor5ndjRUbN?=
 =?us-ascii?Q?8F0sSHgvkHYuaaxxaSnC20Y8BEQ/m1yWjRe23cfIgzhZq//fEGPfij/k6AWT?=
 =?us-ascii?Q?Gl5CnIZstazKpez4RJGlvHHowpeSV+Yts4U4Abisb4PzyoiNti4bXUapbQst?=
 =?us-ascii?Q?T8ry+BglF8HWPafyy7pLxhu8w975HaGKZ/aSHt0YwHTbF9G5WTrGgVCxTGvK?=
 =?us-ascii?Q?1+eE+61noxV+2hEBKQZAM0R+X/sUrEzAzZkpXthTaRUQ8XsKrSQKPwMrYYb4?=
 =?us-ascii?Q?sjEn4FKh8ZXFDgaACYdce19aMKcILi2WxKe/DAKHGO31F7tZhrA8etpdyKg8?=
 =?us-ascii?Q?GDLH4XkFBhUdwvje9jHqvIF4Ulzq1btamQH5ZqZHUrNJoF1HbW66sNxOzTPm?=
 =?us-ascii?Q?/Eec43iyljBqnKarr9Mn67ji770zxmc4Bi5Av41vzUNjL8BdlB6BURZbakj/?=
 =?us-ascii?Q?n8xblQnrVO3Qx3MuCUUnMArMys3wdpXK3QRxnma3ZxyvCI62eZgVCvg3q+uo?=
 =?us-ascii?Q?nnxnSh9BbjeRHzhNTYRUhXmKnplmoqmmL2rsLddhBoyATQWtqhJZXfIpNJSC?=
 =?us-ascii?Q?99HwIF3MYgfe9FzdJKLeB5gOn1tiImJcTSfhkWLpac4NF04iFkuHO/E6seuy?=
 =?us-ascii?Q?dmXPz2G3Pj/gEBiBhkOH7kBWzp4JrjlaXyaOKO1zJYgITNmQ8V6qTZq666j+?=
 =?us-ascii?Q?PFbft/zwk6dzL6osf6hat0fBV4UeNV68BceDAdr3uU/ibN3Yq/C+wX4qK6ZL?=
 =?us-ascii?Q?rgQOkOuDH7tdueeJ4JtG/pHplNOfZWbXs6efTF0eh95M/5Bq4aSB1gfNsJk6?=
 =?us-ascii?Q?SUZMjneER2r0bf8KpHf2Glw1qsYATod3yF8qPExk31TsdLPQarIDJgsMiGc0?=
 =?us-ascii?Q?WFSziODN6s9nNLPgjef727eOlWbXd80fH/f59hf3Qmq2MrbHT9hoMaciaJ/2?=
 =?us-ascii?Q?BFZtja/by0tm9xbf1IYfLrySpXNz6tFC9uJAiWbAgYEj3WiZiAlk5dAdazKj?=
 =?us-ascii?Q?1gUbE68vJJZqA787NTYqxVL3hDEu1dxezO2OIYj3o+0IZQ0rv9SGuIdKIgok?=
 =?us-ascii?Q?pYU8U+0P6d7kn/YYfiY9voAfrbCx+H/EjRQr3AzmsgfT/ivMsM61FN+ZX/Ue?=
 =?us-ascii?Q?yEEiUwuhl4Yfp2aA4vaawL8QnVSJ0ADnWfCH1nsofmCpruct+KXbXP+hkl1T?=
 =?us-ascii?Q?TGswPIbdSU5CbaGgsukIPWIP7aBiIriCM5AsXh7X+00ePhhxwlzzTlebxNTW?=
 =?us-ascii?Q?QrTp+UzMLr+uIoTZMiFMIGAsCH1qVmc3cyXk8ujrHtB0GBW7xgQL12cSROp4?=
 =?us-ascii?Q?wWD9n07jGGYJ0EnL3JA44/ZYP5GktsKWvcmt0ZWmCahXFzd3js8L4S7jZBrM?=
 =?us-ascii?Q?xv9D0kPZSjDdlHFnAmdRnZdntiBa87rol+byGMVuSBxZMQUUd1rvjf18omYW?=
 =?us-ascii?Q?lg=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 76a059e7-b481-4ae0-95b2-08dabb7dab81
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2022 20:22:45.0610
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tDMnnIfteqrCZ8UiaNe4kosW6jFVMjpYzohx2nHmoZCtlHEnCCVLmvHNumIb8N76IHft/HVSUajpTf9IluwLqA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB4958
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-31_21,2022-10-31_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0 mlxscore=0
 suspectscore=0 malwarescore=0 bulkscore=0 phishscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2210310125
X-Proofpoint-ORIG-GUID: 45Kdh_HNtGeVRYlZwyUqqakE5zvFORbf
X-Proofpoint-GUID: 45Kdh_HNtGeVRYlZwyUqqakE5zvFORbf
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/13/22 20:13, Sidhartha Kumar wrote:
> Convert hugetlb_cgroup_commit_charge*() to internally use folios to clean
> up the code after __set_hugetlb_cgroup() was changed to take a folio.
> 
> Signed-off-by: Sidhartha Kumar <sidhartha.kumar@oracle.com>
> ---
>  mm/hugetlb_cgroup.c | 16 ++++++++++------
>  1 file changed, 10 insertions(+), 6 deletions(-)

Thanks,

Reviewed-by: Mike Kravetz <mike.kravetz@oracle.com>
-- 
Mike Kravetz
