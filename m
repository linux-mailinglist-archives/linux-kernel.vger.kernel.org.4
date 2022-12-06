Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4226644C0E
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Dec 2022 19:53:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229741AbiLFSxI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Dec 2022 13:53:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229564AbiLFSxE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Dec 2022 13:53:04 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1F2027934
        for <linux-kernel@vger.kernel.org>; Tue,  6 Dec 2022 10:53:02 -0800 (PST)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2B6IkVYM015938;
        Tue, 6 Dec 2022 18:50:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2022-7-12;
 bh=o2TlzUPPngqCboHyj8X5+CNGI5NbEmqTHiDe+QaCDgU=;
 b=rp51p5tZvrg0Xwue0ooSXjJqfwj4JhqM5jVPYhttszxLI1QU7sJTy3rhvi6Rb3S51amE
 Ybxij3a23ZP/Qg6m0wil+Ct/ga+LOp5/eoLoctYyxhjnbZUdvrXzTcpMVVf2scikI7ZI
 b3jiskm62xxnQ5GDx7WAP06Q8Z/Z+2KFgACBHwCEm12d7vxGhz+AaojIaQmbKoE2yyEp
 gTKw1AJTiQPKSONz/BGfUlWla4qljA6+ErYTbq4JD3n+QXuK5Rj9oWp7w+xcBPfuY/eW
 sU/bNgnM/JPq6akgKQAeOEHML33q2Xm2nkip700a4InXN6+RMCnb+yWJphRJ+TO07mgP ug== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3m7yeqr9gd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 06 Dec 2022 18:50:49 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2B6HTDVS030680;
        Tue, 6 Dec 2022 18:50:49 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2100.outbound.protection.outlook.com [104.47.58.100])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3maa67kgjx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 06 Dec 2022 18:50:48 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iQIkjrZrZUUwflosOl2HehtDnw6eNQzCG2Hw979bqE8TfknALS9o/WqHwzNe56GLp++rBn/8Y510JbF3k64hngEdQkcMq+n3jEUNlfWVl8f+cqZc9nCwKWCzgBB+S9k94CINplMspqbA4O0Dp/L3xQRdl6nkhwuDgfU157MLMb0wKVxRiOgzqIdtiptYS7ZXracYlqwApGw8rlJFa5+daOxGe93ip5WlV+nzngrJGe37gfBr7mjhYTyeRKik+hECg+KCQnXyajvIj9SLjGLa4psBqasvXKYkdcZVYbqeb2OR4RqsCT3eiKvtaymAZxXZc1N5qpLZmWAcIIMlirC9hQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o2TlzUPPngqCboHyj8X5+CNGI5NbEmqTHiDe+QaCDgU=;
 b=kkBjmDWaSYRYHNPuJns1a75GO9q/1Woz4h2l+gQxjxz2tT7RoKIozUe2hLpImMp78JgaIsVfCCJmRG3mxA/AqPKw7ZjibpvGhMRgH/SYIbpmTA/ooIqzgyzP0HldHHnKzkt1EgQlET1YqqGI+utYnoEMPL+m36tKhzsQhTC5oOYsYVSaw+GfBPF45dIFwRoXpWKwYDDIR2UeMUT6fVpgTU5D7vgiOMI/g7lQK4G5ZcYwWJQgm25N9uVGbLGuEgXkqke2cTxwGtBHXPpW35xxLHLYRKdSiOh60AdLACpnXI0zqN7XoGMai5TSAkMUrQef4tMmN3YPuvwrZMHU6hdkcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o2TlzUPPngqCboHyj8X5+CNGI5NbEmqTHiDe+QaCDgU=;
 b=dIN91t0zrVvRoBYKTvz6QNDFDTs3dOYvyjWvHimEMuUSlVn39ldguDagmMz2s2P0YcXmR+SWTO5reB7aGNg1PPB+cGKWK8z9OJPUW+NW6KskLWRbrG0bDjJQDWWsY+dCRMaOPQdkqgjVzF6IXEwOo/WRZfeuhRJCb/jeKW0tYE8=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by BN0PR10MB5224.namprd10.prod.outlook.com (2603:10b6:408:117::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.14; Tue, 6 Dec
 2022 18:50:46 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::8d67:8c42:d124:3721]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::8d67:8c42:d124:3721%4]) with mapi id 15.20.5880.014; Tue, 6 Dec 2022
 18:50:46 +0000
Date:   Tue, 6 Dec 2022 10:50:43 -0800
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     Peter Xu <peterx@redhat.com>
Cc:     John Hubbard <jhubbard@nvidia.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        James Houghton <jthoughton@google.com>,
        Jann Horn <jannh@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Rik van Riel <riel@surriel.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Muchun Song <songmuchun@bytedance.com>,
        David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH 08/10] mm/hugetlb: Make walk_hugetlb_range() safe to pmd
 unshare
Message-ID: <Y4+PA5xsOOHz7rgV@monkey>
References: <20221129193526.3588187-1-peterx@redhat.com>
 <20221129193526.3588187-9-peterx@redhat.com>
 <Y45/5ezH6uwn7Cfy@monkey>
 <0813b9ed-3c92-088c-4fb9-45fb648c6e73@nvidia.com>
 <Y49xlV8I2/92Flha@x1n>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y49xlV8I2/92Flha@x1n>
X-ClientProxiedBy: MW4PR04CA0275.namprd04.prod.outlook.com
 (2603:10b6:303:89::10) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4196:EE_|BN0PR10MB5224:EE_
X-MS-Office365-Filtering-Correlation-Id: ea3a4a38-32d2-46bd-37a5-08dad7bac911
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GzW4u+qpELURaLWMzuE27ZcpfnyXtP+AeqgbSnA4tSSAVM0Mkm7tZ4BvTB3db3Cic35KeKwOW/O3Tce07NjLo+0O/hMweYX70dmWhcjQyFb6HNL2oQkM/l0LPgruZP18EkqTNCFNVEyuyLPh20ZWEzMQ4fnd1Y8NuIbE9xY2HoPRLTWOtKGfWUcTBG5L6FALBYWs5v+bMJyK9eKyp8yoiAQM0bomq5lkQ/zR5Wrr79Frs4jbSeEt6f/0P+oZEx33QWhy6ygKGR4q3rqYyjQZtYQIE65Cdl1AffQwhZZIS7yTkoK4HyQWmNRCZbW6Rk9uu43RuOZSV1kz3IIyKC4sA8f217vwfm90/7B7NEhaX4XJAdSEs7XrEUisYEH8iLAL2PAUNo3+h8fFXunqmqpVTaw8sy3vT0Vy5ylITdQcUXCoJN4E8pPTOgpqlKAJKFW7LIniQa6DJnyATSJzmZzuNmhx2S03SPAZ6es8QL90O1Ervnv28ZwkQU4HJV9naxiiS2c4zUOW5WbnibCM+oiqufliQEBcocfVqsYXOYtaPUoVg91HYMiaMn8xi5/P0DpGRVWL9+vByd+eMlF9Urfv6KsEK9rfRYWBpDioMBx9cdtS3BCtUk5CsjkWGVTX3p89nJ7xO6cno1TJm3CfVDZvMXJaLla/G8q4pNoHABDuKOFS8FYViw6QlF+an03W1JVB
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(39860400002)(136003)(376002)(346002)(396003)(366004)(451199015)(38100700002)(478600001)(53546011)(33716001)(2906002)(7416002)(83380400001)(6666004)(6506007)(44832011)(186003)(6486002)(316002)(5660300002)(8936002)(26005)(6512007)(41300700001)(66476007)(66556008)(6916009)(66946007)(9686003)(54906003)(86362001)(8676002)(4326008)(67856001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?GC60J/FcH1VA9Qo1va+SJxnSlKnc/DpSSg8KQfOqwIcpbtFa8OlMSrE4omCn?=
 =?us-ascii?Q?jkk0MAyEU87sIQohlNieouKML6Q6wRtu0m5D9WTLPysQtpQPhULpBrLHqnnT?=
 =?us-ascii?Q?U1/24CCLbTpeYZ9pOhVMuZtpxA+rwFJW5XtxkZdZReC6DGbK94JsKl5KLMBx?=
 =?us-ascii?Q?5lU8DvbrEWrAHMwF/owvoeE659OpoOPGL02HOfkSYYqnCBzw/mAr2vHnNYSl?=
 =?us-ascii?Q?PVmOnSilL9g09rgGHF8QrmW4yJe/nMx7PleyzhObntBpGOtApccGqG7HcA9e?=
 =?us-ascii?Q?u13MNH7NbRxnHRVk3gPIKkLYyzIaF2RZdH9zJN1rqhZjlIBaN88Napk1qRvu?=
 =?us-ascii?Q?aZzD/l3bqt4wxaeZe4+7YJAnSkd/SAAfzOixMTd5I/lCSOd0GbIezOsLE/37?=
 =?us-ascii?Q?nshzGt7rQEYN5+hJcJIGpeUXYuUUggcR8d5GS2uDSNbJVv/f5dZzxlQ8+cQB?=
 =?us-ascii?Q?Zt+CacEhP6Rd+ia2/6fKwN0QBz/hwGEE45PX/Xy5ZQ7uD19huPMOeJ0spIZI?=
 =?us-ascii?Q?Ean2gLJvE3B01nTOfcaeK4UbGZ6PB63rbeWWvIOZStdJ3SqUzZhbp4u+wkIe?=
 =?us-ascii?Q?JzzkdQ86scID4QZVKSDkMuQWvjntRAYVwxLXzUH+eS5T1vOzJ1MzcafFTo5H?=
 =?us-ascii?Q?dLMHvi9yMpy6EYyvvK0Us6DrLEQZv9m++BU0hmaapp60GBKVmcv9l7bNZUeS?=
 =?us-ascii?Q?lFFKYmH9mb2AxMjbROm3sxalDlVJ4MTfQuUe5/j7ZgM3PjJLkkDFXR4FARyt?=
 =?us-ascii?Q?xHk3PHVjVZHKt0NvJfczHucLkADcm0jKXxcpL8R6j7lGAYj2fPsyg4WyImfZ?=
 =?us-ascii?Q?2T4WQTt+fVgqi7h3UAb0A+OxWoNFnELWCCZyfFGgrhdaq2+kBVYvCCLwMZwi?=
 =?us-ascii?Q?NcZm2NpehOMnqR78qIb9yTOvSduPnQfT95KsbhfzwEe1E8nRIiUGWTX3H/zg?=
 =?us-ascii?Q?MUZdPRbGlO2wcEPPCazZMuhsh1av3DFE+R2vfStbA56kItEmA4Z+HHEYEG89?=
 =?us-ascii?Q?YHG0/qOJol3jA53Pplho3cTaUMZeSyYeqKVTIgL1dm2jzPwtddc4+3K7LvfR?=
 =?us-ascii?Q?1ZFlkOJFyw51MXBgr0FnQKR4P49SdqgE0nCn6p1fkaW77bqCF4wKzdLQRYzq?=
 =?us-ascii?Q?4l4WsA51ODJ2tf/WVQ2IBuAAprtltzoJ0FuCWwP0/he+xpg9JIqRiRev4Oc3?=
 =?us-ascii?Q?vGFsEoyjZz1kFYl6hB8YI/aXxn2hofa+80rDgho8t3rJDKHTG82nT41HtHYJ?=
 =?us-ascii?Q?PfKk86+03LT6W8tZJPQig6l4Nx0xhvK3PQVfSC63OEW4mZMm4SGri3SXoa89?=
 =?us-ascii?Q?57JdmWWf18VvXxUIUgcHl8oAkbzLLNTyK5LwXC2l2qUEAsZnVpLDt/bC9aZ1?=
 =?us-ascii?Q?wtlq5KF/QAcoWsmGmGNDHWgeNl3qImzCP1lUxrZEcoMk+KK456zAcTSvUDhW?=
 =?us-ascii?Q?FxxuxHDmSUbWMUqTeSn4PkHIK4ubYr3X7TlQgQtHzvLyeehG9j3FDuu+xG5m?=
 =?us-ascii?Q?8UgHFAjMKhcSgswq50VE//t+MN4PoftgPKy7LKbCAj1glYXsMYuk4ks1BRr4?=
 =?us-ascii?Q?CstmXraSyd/w2CprTe9TS5LHk+tKxbzqGXg4daX9ZbYQsy3UdFZ+ePmcYsbP?=
 =?us-ascii?Q?7w=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?B2WX6ixwrBgCbXNVPP+p29RCsoNpwVlSsqegQ4kkOmF23VNzxFiK3rlCDShi?=
 =?us-ascii?Q?mb1IhXou/ydhqVzZ7IRy3ubOqhnbvHRQp/5NwTHAyl7XQNtG4bO5sP39NAjD?=
 =?us-ascii?Q?PYo0LMUWJ7cj2Xjoys9ceQR8OA/d1Mv8bopVkF0Pwy7zdsIg8gPpCegzVZRv?=
 =?us-ascii?Q?ZxfftXUxUwjzMKTpNYt+3uHWO8Zsn7auaPAqXXam9Fa2ZuQ4gt6RU2OX4/w9?=
 =?us-ascii?Q?C7BLV9irtQlzEJEYb7q/99u5m0rqMK1X7Ft6Mup15bxBL8+M/1/AWH1nYYiY?=
 =?us-ascii?Q?9P2xj2p+3s0LO4NjD9NgBoIMgCk2ebIKifLBPOw49HcifJTqgmPT0Q4EX27J?=
 =?us-ascii?Q?OayLOll7d1zJgqu7XOS/wUgd6G8HAWYOcOMVl8//GGg3NpNI3LOmoeae7Hni?=
 =?us-ascii?Q?B4TVKRoG2dXgpoQRERxe6yAlMLerzplNUlePbBoe6Q7Xk40D1E727zWqvu3R?=
 =?us-ascii?Q?8XcxAHtT3qQDm7f0+SPdgbylvEjpm9aB5SBpwShQi/sWX9E4JKb3QnI03vcj?=
 =?us-ascii?Q?t0JBLJ7Rqi0uxdIbmsT8p4fIaTN6irzWmtA7TwGs+fMZdMAk/nBi9rGK2yjF?=
 =?us-ascii?Q?iWbCfJPrXQaIoGTgI5weCozjdfLUKPvzhbwXX1M6ee24Sp71gptxPPs4iTd1?=
 =?us-ascii?Q?uuDEMV/C79v8VEH38w/aEgL7tzYy/pNzOwY5UDUcDnMIV8K63AjegegYlhGz?=
 =?us-ascii?Q?xUk333JBk8c5827fMnYzvzKjHIoU3p7WFHtGZLNjyHQOcwMk/gAT2jcRzeC0?=
 =?us-ascii?Q?sbnXamMEcBa2d/eidUqmXRQJj4kGgsdeSQA0eICSopV145O3eIR5wBb08ILe?=
 =?us-ascii?Q?btc5sRz0lSOy5EHwB5xaAoiGwfc7woZFg5AphW9DfE0g6ODGy7vk7Svu/AWx?=
 =?us-ascii?Q?DcB6X92FsiqSxFgdPfZSZUSQITk/D4l1xHRnWRGMxzh3CLLPLQrz1L5LUAAD?=
 =?us-ascii?Q?IGvC2TupP0raZxp5J7O2Sim/1KL5JxRB3dFEP8SiYH8FdFqye66GCJgUpjiA?=
 =?us-ascii?Q?Es9kizbLTHP7GrmRjGQORyPyBsPRdiBfdzCGY8am+JqUz2TQEDdCtrUqxzJf?=
 =?us-ascii?Q?bzrMhkonMfNFfk8+X25aeIcVuIG7D+6/r68DEE3EQDs74eb5u7a2cuAPktMO?=
 =?us-ascii?Q?EbJJM300w3e7mg5KutYMwjsIxvc3WzrBAg=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ea3a4a38-32d2-46bd-37a5-08dad7bac911
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2022 18:50:46.5771
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: i8jfcS3iwXmPc+XynCQQk/VXDhtaXv0jr58z3DoWZJecDfhgep/Bxh60OrcCSv6eC68+p0kginXykljmZvAxbA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB5224
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-06_11,2022-12-06_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0
 malwarescore=0 phishscore=0 mlxlogscore=999 spamscore=0 adultscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2212060156
X-Proofpoint-GUID: u0KA9p_E3UQWe8OgGCh2AnfiO_DaH2hx
X-Proofpoint-ORIG-GUID: u0KA9p_E3UQWe8OgGCh2AnfiO_DaH2hx
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/06/22 11:45, Peter Xu wrote:
> On Mon, Dec 05, 2022 at 03:52:51PM -0800, John Hubbard wrote:
> > On 12/5/22 15:33, Mike Kravetz wrote:
> > > On 11/29/22 14:35, Peter Xu wrote:
> > > > Since walk_hugetlb_range() walks the pgtable, it needs the vma lock
> > > > to make sure the pgtable page will not be freed concurrently.
> > > > 
> > > > Signed-off-by: Peter Xu <peterx@redhat.com>
> > > > ---
> > > >   mm/pagewalk.c | 2 ++
> > > >   1 file changed, 2 insertions(+)
> > > > 
> > > > diff --git a/mm/pagewalk.c b/mm/pagewalk.c
> > > > index 7f1c9b274906..d98564a7be57 100644
> > > > --- a/mm/pagewalk.c
> > > > +++ b/mm/pagewalk.c
> > > > @@ -302,6 +302,7 @@ static int walk_hugetlb_range(unsigned long addr, unsigned long end,
> > > >   	const struct mm_walk_ops *ops = walk->ops;
> > > >   	int err = 0;
> > > > +	hugetlb_vma_lock_read(vma);
> > > >   	do {
> > > >   		next = hugetlb_entry_end(h, addr, end);
> > > >   		pte = huge_pte_offset(walk->mm, addr & hmask, sz);
> > > 
> > > For each found pte, we will be calling mm_walk_ops->hugetlb_entry() with
> > > the vma_lock held.  I looked into the various hugetlb_entry routines, and
> > > I am not sure about hmm_vma_walk_hugetlb_entry.  It seems like it could
> > > possibly call hmm_vma_fault -> handle_mm_fault -> hugetlb_fault.  If this
> > > can happen, then we may have an issue as hugetlb_fault will also need to
> > > acquire the vma_lock in read mode.
> 
> Thanks for spotting that, Mike.
> 
> I used to notice that path special but that's when I was still using RCU
> locks who doesn't have the issue.  Then I overlooked this one when
> switchover.
> 
> > > 
> > > I do not know the hmm code well enough to know if this may be an actual
> > > issue?
> > 
> > Oh, this sounds like a serious concern. If we add a new lock, and hold it
> > during callbacks that also need to take it, that's not going to work out,
> > right?
> > 
> > And yes, hmm_range_fault() and related things do a good job of revealing
> > this kind of deadlock. :)
> 
> I've got a fixup attached.  John, since this got your attention please also
> have a look too in case there's further issues.
> 
> Thanks,
> 
> -- 
> Peter Xu

Thanks Peter.  I am good with the fixup.  When combined with original,

Reviewed-by: Mike Kravetz <mike.kravetz@oracle.com>
-- 
Mike Kravetz


> From 9ad1e65a31f51a0dc687cd9d6083b9e920d2da61 Mon Sep 17 00:00:00 2001
> From: Peter Xu <peterx@redhat.com>
> Date: Tue, 6 Dec 2022 11:38:47 -0500
> Subject: [PATCH] fixup! mm/hugetlb: Make walk_hugetlb_range() safe to pmd
>  unshare
> Content-type: text/plain
> 
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  arch/s390/mm/gmap.c      | 2 ++
>  fs/proc/task_mmu.c       | 2 ++
>  include/linux/pagewalk.h | 8 +++++++-
>  mm/hmm.c                 | 8 +++++++-
>  4 files changed, 18 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/s390/mm/gmap.c b/arch/s390/mm/gmap.c
> index 8947451ae021..292a54c490d4 100644
> --- a/arch/s390/mm/gmap.c
> +++ b/arch/s390/mm/gmap.c
> @@ -2643,7 +2643,9 @@ static int __s390_enable_skey_hugetlb(pte_t *pte, unsigned long addr,
>  	end = start + HPAGE_SIZE - 1;
>  	__storage_key_init_range(start, end);
>  	set_bit(PG_arch_1, &page->flags);
> +	hugetlb_vma_unlock_read(walk->vma);
>  	cond_resched();
> +	hugetlb_vma_lock_read(walk->vma);
>  	return 0;
>  }
>  
> diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
> index 89338950afd3..d7155f3bb678 100644
> --- a/fs/proc/task_mmu.c
> +++ b/fs/proc/task_mmu.c
> @@ -1612,7 +1612,9 @@ static int pagemap_hugetlb_range(pte_t *ptep, unsigned long hmask,
>  			frame++;
>  	}
>  
> +	hugetlb_vma_unlock_read(walk->vma);
>  	cond_resched();
> +	hugetlb_vma_lock_read(walk->vma);
>  
>  	return err;
>  }
> diff --git a/include/linux/pagewalk.h b/include/linux/pagewalk.h
> index 959f52e5867d..1f7c2011f6cb 100644
> --- a/include/linux/pagewalk.h
> +++ b/include/linux/pagewalk.h
> @@ -21,7 +21,13 @@ struct mm_walk;
>   *			depth is -1 if not known, 0:PGD, 1:P4D, 2:PUD, 3:PMD.
>   *			Any folded depths (where PTRS_PER_P?D is equal to 1)
>   *			are skipped.
> - * @hugetlb_entry:	if set, called for each hugetlb entry
> + * @hugetlb_entry:	if set, called for each hugetlb entry.	Note that
> + *			currently the hook function is protected by hugetlb
> + *			vma lock to make sure pte_t* and the spinlock is valid
> + *			to access.  If the hook function needs to yield the
> + *			thread or retake the vma lock for some reason, it
> + *			needs to properly release the vma lock manually,
> + *			and retake it before the function returns.
>   * @test_walk:		caller specific callback function to determine whether
>   *			we walk over the current vma or not. Returning 0 means
>   *			"do page table walk over the current vma", returning
> diff --git a/mm/hmm.c b/mm/hmm.c
> index 3850fb625dda..dcd624f28bcf 100644
> --- a/mm/hmm.c
> +++ b/mm/hmm.c
> @@ -493,8 +493,14 @@ static int hmm_vma_walk_hugetlb_entry(pte_t *pte, unsigned long hmask,
>  	required_fault =
>  		hmm_pte_need_fault(hmm_vma_walk, pfn_req_flags, cpu_flags);
>  	if (required_fault) {
> +		int ret;
> +
>  		spin_unlock(ptl);
> -		return hmm_vma_fault(addr, end, required_fault, walk);
> +		hugetlb_vma_unlock_read(vma);
> +		/* hmm_vma_fault() can retake the vma lock */
> +		ret = hmm_vma_fault(addr, end, required_fault, walk);
> +		hugetlb_vma_lock_read(vma);
> +		return ret;
>  	}
>  
>  	pfn = pte_pfn(entry) + ((start & ~hmask) >> PAGE_SHIFT);
> -- 
> 2.37.3
> 
