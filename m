Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B12A26A2506
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Feb 2023 00:26:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229786AbjBXX0e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Feb 2023 18:26:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229771AbjBXX0c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Feb 2023 18:26:32 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 152A264E31
        for <linux-kernel@vger.kernel.org>; Fri, 24 Feb 2023 15:26:28 -0800 (PST)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31OMx1xT028876;
        Fri, 24 Feb 2023 23:25:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2022-7-12;
 bh=Ulva4mYlT9upKw5g+Cea0h1q8XN3WWokusV4Ft1DAoE=;
 b=Yy+9XiB8F+h3hYW9p9ldWn9gXHsEHm35vJyRT6Hz16U2w6o+/Ebro6db7RYwvFsqXwOR
 w3cfcGkw4JIAFRhPQRdUtA6QGSB/rDp6qymLDF4kXjELY6cRxGmjsukRzrD/2N/hxcMg
 TbAXYi83PoU/QAJHYQ8vFzf70e9M9DcZxDGrVqUdThAkHDeuBDVJVkJexiOAUjOogny/
 lppj775GqEud8KhJqO/gCnxgwnA2eoEvEMeAU8mFa+RgyD0nvENU1BodOxVXesogPQov
 r6v9/tcxk10650vUCfoTUzQMB2op1/ElSiZFnM8tkgpObyr/r9tlLQbc5/JVht8yYo/C 4w== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ntnf3pea2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 24 Feb 2023 23:25:32 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 31OLDKAt031548;
        Fri, 24 Feb 2023 23:25:31 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2100.outbound.protection.outlook.com [104.47.55.100])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3ntn4a8mdm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 24 Feb 2023 23:25:31 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lYdDgSJf77rV4AmQ+1AL9TNLPeS8Ja7hZY8jb240f6+nKW3tCoecHIy7EqMmuvTQhBU8kM68fd/RLMpj/Sdd4oauwjCQY9piT9Tgc4pNk2C21jCVIebAhv92h1anLWdR2oBJ9SPJZTl0H+WIehtixKEZl9BVMJq8qvnOkHhAlABGVSUogK6iMYvtHD33XP5OqZBc+82g67eUgPCKc98+KHXI9vZjb7uuYOuDIfXs9mVBaqe8YbSzArXLMc+B3l3scHde/CpTvdfdP42NObu0rnvtmVO3FkGKXTX+FnGAPL8SItWNAKSS9Aj/PKSGac/tqdR5Pf48iGk8RxxQ52HM2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ulva4mYlT9upKw5g+Cea0h1q8XN3WWokusV4Ft1DAoE=;
 b=LZkj5UrEsCgncrdfaZx22M7qNP5qggDxQmIyu/fhhx0Vx8e3XJdaXtPiHAcxOAPpfnNQLHiXixiNpSHgI3nDMUG4FxQzNo7VoPyPPknDEGfWasH4rG8DPcxk3aen46T1yUhkLJaGmPS4oQDAf/Rs1pcCnRUC9Y8rk3ETpVQ2ai1KuT0akPBlBa2rxGIcYJnGmmf9eZFM0Lub3QxFf7XCo7DMFY5EfFPUJ55HNjqsKcNX7J4VyXhmVQRO9A+Z09S1FghQBLMbEO8Sqvt9vsc4X9mHiyQw153pfygZpOK68pu3Y/jAPqewKRdKHUNazeJSRBcknjKQBImIwcXNROwXWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ulva4mYlT9upKw5g+Cea0h1q8XN3WWokusV4Ft1DAoE=;
 b=g4mYSBW5QSR2+TaESPe3ysMTyWWUoGGIrPsy+3g6h7Nifv74f0yN6Q5OQyVyA9Nuy+r0NI5MhPPNR55R4qLhFxvNQ/+XFcNMQyR4dfi2pj/1l7lGUgsjm4WDaANHvqP2GKZiLd1IECJHjOjKUqofMwMCmN86z8JWC4sBMqQ+o88=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by SA2PR10MB4745.namprd10.prod.outlook.com (2603:10b6:806:11b::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.7; Fri, 24 Feb
 2023 23:25:18 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::3db5:6e11:9aca:708a]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::3db5:6e11:9aca:708a%8]) with mapi id 15.20.6156.007; Fri, 24 Feb 2023
 23:25:18 +0000
Date:   Fri, 24 Feb 2023 15:25:14 -0800
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     James Houghton <jthoughton@google.com>
Cc:     Muchun Song <songmuchun@bytedance.com>,
        Peter Xu <peterx@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
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
        Frank van der Linden <fvdl@google.com>,
        Jiaqi Yan <jiaqiyan@google.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 09/46] mm: add MADV_SPLIT to enable HugeTLB HGM
Message-ID: <Y/lHWhxmv/hhg8Jl@monkey>
References: <20230218002819.1486479-1-jthoughton@google.com>
 <20230218002819.1486479-10-jthoughton@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230218002819.1486479-10-jthoughton@google.com>
X-ClientProxiedBy: MW4PR04CA0106.namprd04.prod.outlook.com
 (2603:10b6:303:83::21) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4196:EE_|SA2PR10MB4745:EE_
X-MS-Office365-Filtering-Correlation-Id: c0fba1f5-bb74-4324-8422-08db16be63c6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 210AVSsilRV6FPCU633yaqaA04FrrGIoH5I6E01CKU7cfQM/Z2AbmZ/RMLOVP3LqNXbr9kvDW51zJR3TL/9EISffZjsnAnoRwHLcnOGqlpc4jo2moKK2BDBm+9MUJk+u/3QL4dvD/zsygzILK61/3XEg52SN9DQw768JYygjWR3WQVm0nozkogBxexIt4zLYI86Y0ltD/98hUCZuDarsm5+pqnxnriEjNGrdMzZsuglUbwfhgjWeBKBWbdz6ctNnVBm7MVK7TaEOLJ4Hhw5YOHWfxnxiSWAz73ZbNXBIbp2JlNg7fTsBRbhkR26k7w81n+QH5+6+joOwNhT7M1NpGJDnbPqcpZKakHT+Pvhm08JWaZNkLy4Cdt3tWKfGn/9nBGSvfwH6xLSbmwkSx2vMdZE/txV3WZMtrn1+NcmZO7vGAm4WgrUbTsVmzGbOAUQkZOwR1k/uDJJ1NIRPXk6D2LodqUrR3C3oEJTba7kOdY+bC9GIidwbaq51Wy9NJptyU7qWAmyZsd5BnHCHM4DuesC3quxwH7ga2TgPUjqQf/HkfbNNZvVvIhRMQYoOl5vzh707OjUsETo1dfqLkBU0LskvlypszDtHGXyCjHuS56+qOkbPsDdqWstLvtlgW9VEeKV5hiIejJQDhcrBVFbKnA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(7916004)(396003)(39860400002)(366004)(136003)(376002)(346002)(451199018)(2906002)(86362001)(33716001)(7416002)(8936002)(38100700002)(316002)(54906003)(41300700001)(6916009)(83380400001)(4326008)(8676002)(44832011)(5660300002)(66946007)(66556008)(66476007)(53546011)(9686003)(478600001)(66899018)(6506007)(6512007)(6666004)(186003)(26005)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?JTklt5jQ71UdzUvjEQ3wb/I9fD/z9PYAC9BJZgWhzrXvL/5RZ05Bbk/TNihd?=
 =?us-ascii?Q?9ygzep8ktqm6NrM7qtoZ3Xu6ndyV13efAYlsLR/tuy2W3V4vupPqYR2EtEfz?=
 =?us-ascii?Q?P/UUVdiq0krOdt4pfdGRWAW8za1Uxqd03PSaatd3G9RMz/uuq8keiSeaBnRw?=
 =?us-ascii?Q?gen6lUG7vrNjZT3HROEkLJocbDE+iRZ4oiL/YOopwUD+cBIlKYEkkepWi0IS?=
 =?us-ascii?Q?9oGz53fWcyU0BSdoXLoCNGOphFKRj6sj38L/fCqflg6Dvkjgae3ZSKaZ0YOr?=
 =?us-ascii?Q?LuFXJmmdjfSy33I7x79P104NQHZUNenHBUNi/4cnyzhSnIHRG/z+Ue/7i5LX?=
 =?us-ascii?Q?oVUyv55xyuh0WpDl9IQsKBdzSB1qYtl6iEueNfcUN7eEMyTNFNHoyvQxnXJL?=
 =?us-ascii?Q?aSTKTYFCNQPzhZSQlJYeRfhWV/n4l+Dw5fgkUYDWN8dEgy+7nXGUEBhSoGUp?=
 =?us-ascii?Q?DTHsAtF869x71wArUe6U8qnBcvsRirrD4h6xhl8iASaAf6K3QrwHMvbuCZBE?=
 =?us-ascii?Q?re1Eh5aeuJe7eNIRV4lCV7KZEHWcYYIET75UuqodXa9zO6F7GxR6H2LO1NIL?=
 =?us-ascii?Q?74GsjRWUbbIV43A6lJIGHhVjBlqnsW4oGaOL7oThWkhxdypwqNG7WRgObbqt?=
 =?us-ascii?Q?KgHQKRlY0stWuzj8BraoG9kLy4NypGc8y7AZpPKdLlP6rW5EOzpSsGFcX/dU?=
 =?us-ascii?Q?uOYhFKgNa9xSt8CNlxGyAK5TTwl9XVBROcWBYy2bKbuDlHIqsJ74IgDv3g6J?=
 =?us-ascii?Q?SQtcv9WvMkjUA0YxtIIy7udxZiMk13AFQSnukRobsD7JFljbkvC6WeTr/DbX?=
 =?us-ascii?Q?53kYV/4PD6VIh2ghZQXa6/t0cIdTc79BhXUKuoVsZmBMCgMbuCV7eEFsMAYR?=
 =?us-ascii?Q?rct/LdKWEsDZ1u2cFkXtkfToDRm7xR94YqKmWleApLnYyx7+v+LtxWcJMEBI?=
 =?us-ascii?Q?04n1+FIoVtPKkctlbw5e4GTolWcxdWfyqWLslDWPhh3ChCStaX1r/Ao0v12a?=
 =?us-ascii?Q?JzXXiAYbo76daK4/TCPPzxFSoY5E2hMqTXstU3V761CT7LKIOovyIJYgKkl+?=
 =?us-ascii?Q?NUbqOAJ4ugQTJFRbjr4mZojXqEZzENHR8sQESvcMef+3a84A8okj/McO9j9j?=
 =?us-ascii?Q?SMntlQ0G+ysr4zSmdgFEbNSvHmVI3qWb2iyN6xXk1rewu2phtz59BcxMfOy+?=
 =?us-ascii?Q?B+MdjCgJuRbrzvvk+ztGPwIS5qrQjqVjK4pOAtfIuxA9W7b0oC7QlYe8k6ua?=
 =?us-ascii?Q?W3mzazrBgN+B40Mvr93B8DDqg+j7aEats037qbwmHtPQw/AYu3eQDq5vTwFj?=
 =?us-ascii?Q?X5X1KPFSaTW1Z8I8XM/qSgv9QZ1RoTp0gNMCHSzJWeJYdZkV/NlibjqEfOFS?=
 =?us-ascii?Q?ZmzBcprv0eyEdsj/WGv9qhUzywAMdupMwZKSX+GQaHUfDniUKz7QAsKZenpo?=
 =?us-ascii?Q?ynIq0C3bTnZPFgUB/tdjZCtybgXp1DtmhNDje5Nh7VLb0RVBTLvqp+sZqCp5?=
 =?us-ascii?Q?0GqHE5feCL/FR9RGBl6QCBPd97qE4r4RBmXSzh1/OlDb3THA3wBxEJboKIb+?=
 =?us-ascii?Q?qCPhj5CF0WwtWmIZShpdWq2DdezDYvFcImxxQX32afQai41FJtNyaQvnzvex?=
 =?us-ascii?Q?sQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?iSS5l4YykBRBkV0EPfetCmu0EQlPrwiO43F4NnR/qIPhaNwWCz8tc20NpIrI?=
 =?us-ascii?Q?Vaqqjx4RLKI3yxwWgBi6P2sta35FFPWqtbakhNc6XPXXBGdRJZ7Cs+8UdV7m?=
 =?us-ascii?Q?INFkp5SBfZlfQQNYC+VNKsjnPBpXL/qSYLjU55EEyOIPTt+5AdtnxiY2Ha23?=
 =?us-ascii?Q?vEtJATYDMpyv0r8pMuDDBLyAWXwKNa4UmX90achD/wKKk0gnXlFRb2I4dRXO?=
 =?us-ascii?Q?yi325DAFLxW8tljXt66jsBF80RhoLXEf0xLpdL3GhJe58Le2UTTIpOBRJvuY?=
 =?us-ascii?Q?Nuxm/joSa0vmcao/yDOkjmpXGFUpeqMwNbWnSTCWQ+13JGyUkk4fGr445LUt?=
 =?us-ascii?Q?COERLnVWzW/5Ll3tzjppDfphDTBs5R+geHFat1g/noGk4CsQh5/jvRxI7AAL?=
 =?us-ascii?Q?bG0swE79mkY3Af2VFgeNK87eXAIQoLApLA5gL8Jx2JK7rPvJHhH3l37fqCEe?=
 =?us-ascii?Q?vtOlTwSFAHTsWMSu/RVo6yNGvSlBg9kHk5PJjnlscIoqoMeMOeWC0fKJBpfY?=
 =?us-ascii?Q?g9DOA2RkLbnDgMeNfK6gzmgscnqj93W7mgh3fd8nXNz2cw+GVtYemAt8R4r7?=
 =?us-ascii?Q?4LuePino0j1nQlWQgSyaM/+IAlV1sznal3zfJjs7o+avThnwjgUvr5TwCVAi?=
 =?us-ascii?Q?RK79JQDlttFdjuw4YCkiaG0b1YjNRqzLE2LcLLOnnsSZcqWLm0BQnwoB3ai5?=
 =?us-ascii?Q?uEnR77KE7qiSUGQDq2sTAuBdKOzvQo7TSmdxiuI8n54qCQZ0sY4KV6ZWqci5?=
 =?us-ascii?Q?SvDL4B9k7a3zSPUWIyQFgaluEtFMsRtuF92cViCCRqad/o/lVk1RIzVWz+PE?=
 =?us-ascii?Q?UUzuGA4URiTwFI+bdZVCxMOGC+2Cv7lhnR+CUWJlLrHfEyatByaYjf1Paz20?=
 =?us-ascii?Q?6eCakshPcQZeSKo4GuyBj9SIVOQhiXhdSXt9fP+NarNxaFXefKvfkZpqi1PZ?=
 =?us-ascii?Q?aqi2tk/bymc6/R1w9Oep5oNffOsgiBQpimIqLdmBoFzCzGnnytr+utKl+sv0?=
 =?us-ascii?Q?Jqr6eIZVpXXDaXK2k30GbQ9/b8rGYx3GgEmjSDLEVtx5aCEIi8r/BZX2TPrE?=
 =?us-ascii?Q?ejRSQB3YjKC7Vd9LeiQxj5HuEVKRcjY5+ah0BXBwCHbSNYQtd4nl015x+UM3?=
 =?us-ascii?Q?O8CAw2BFHA9lKk296xYJnPg7wvLY+mCmLw=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c0fba1f5-bb74-4324-8422-08db16be63c6
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2023 23:25:17.8808
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xCrpZPaJ62vOGq0iCco7LRqF3T3bxStqNg5ew+3t4FhfVO5fLhtWOAwuKIHNC/41Jwx5abgVJ//Wnt+MzrKL+A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4745
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-24_16,2023-02-24_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0
 malwarescore=0 mlxscore=0 spamscore=0 adultscore=0 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302240189
X-Proofpoint-GUID: jhH_AO1CClgAYLRlTTA8uOx9rNOGfE3J
X-Proofpoint-ORIG-GUID: jhH_AO1CClgAYLRlTTA8uOx9rNOGfE3J
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/18/23 00:27, James Houghton wrote:
> Issuing ioctl(MADV_SPLIT) on a HugeTLB address range will enable
> HugeTLB HGM. MADV_SPLIT was chosen for the name so that this API can be
> applied to non-HugeTLB memory in the future, if such an application is
> to arise.
> 
> MADV_SPLIT provides several API changes for some syscalls on HugeTLB
> address ranges:
> 1. UFFDIO_CONTINUE is allowed for MAP_SHARED VMAs at PAGE_SIZE
>    alignment.
> 2. read()ing a page fault event from a userfaultfd will yield a
>    PAGE_SIZE-rounded address, instead of a huge-page-size-rounded
>    address (unless UFFD_FEATURE_EXACT_ADDRESS is used).
> 
> There is no way to disable the API changes that come with issuing
> MADV_SPLIT. MADV_COLLAPSE can be used to collapse high-granularity page
> table mappings that come from the extended functionality that comes with
> using MADV_SPLIT.
> 
> For post-copy live migration, the expected use-case is:
> 1. mmap(MAP_SHARED, some_fd) primary mapping
> 2. mmap(MAP_SHARED, some_fd) alias mapping
> 3. MADV_SPLIT the primary mapping
> 4. UFFDIO_REGISTER/etc. the primary mapping
> 5. Copy memory contents into alias mapping and UFFDIO_CONTINUE the
>    corresponding PAGE_SIZE sections in the primary mapping.
> 
> More API changes may be added in the future.
> 
> Signed-off-by: James Houghton <jthoughton@google.com>
> 
> diff --git a/arch/alpha/include/uapi/asm/mman.h b/arch/alpha/include/uapi/asm/mman.h
> index 763929e814e9..7a26f3648b90 100644
> --- a/arch/alpha/include/uapi/asm/mman.h
> +++ b/arch/alpha/include/uapi/asm/mman.h
> @@ -78,6 +78,8 @@
>  
>  #define MADV_COLLAPSE	25		/* Synchronous hugepage collapse */
>  
> +#define MADV_SPLIT	26		/* Enable hugepage high-granularity APIs */
> +
>  /* compatibility flags */
>  #define MAP_FILE	0
>  
> diff --git a/arch/mips/include/uapi/asm/mman.h b/arch/mips/include/uapi/asm/mman.h
> index c6e1fc77c996..f8a74a3a0928 100644
> --- a/arch/mips/include/uapi/asm/mman.h
> +++ b/arch/mips/include/uapi/asm/mman.h
> @@ -105,6 +105,8 @@
>  
>  #define MADV_COLLAPSE	25		/* Synchronous hugepage collapse */
>  
> +#define MADV_SPLIT	26		/* Enable hugepage high-granularity APIs */
> +
>  /* compatibility flags */
>  #define MAP_FILE	0
>  
> diff --git a/arch/parisc/include/uapi/asm/mman.h b/arch/parisc/include/uapi/asm/mman.h
> index 68c44f99bc93..a6dc6a56c941 100644
> --- a/arch/parisc/include/uapi/asm/mman.h
> +++ b/arch/parisc/include/uapi/asm/mman.h
> @@ -72,6 +72,8 @@
>  
>  #define MADV_COLLAPSE	25		/* Synchronous hugepage collapse */
>  
> +#define MADV_SPLIT	74		/* Enable hugepage high-granularity APIs */
> +
>  #define MADV_HWPOISON     100		/* poison a page for testing */
>  #define MADV_SOFT_OFFLINE 101		/* soft offline page for testing */
>  
> diff --git a/arch/xtensa/include/uapi/asm/mman.h b/arch/xtensa/include/uapi/asm/mman.h
> index 1ff0c858544f..f98a77c430a9 100644
> --- a/arch/xtensa/include/uapi/asm/mman.h
> +++ b/arch/xtensa/include/uapi/asm/mman.h
> @@ -113,6 +113,8 @@
>  
>  #define MADV_COLLAPSE	25		/* Synchronous hugepage collapse */
>  
> +#define MADV_SPLIT	26		/* Enable hugepage high-granularity APIs */
> +
>  /* compatibility flags */
>  #define MAP_FILE	0
>  
> diff --git a/include/uapi/asm-generic/mman-common.h b/include/uapi/asm-generic/mman-common.h
> index 6ce1f1ceb432..996e8ded092f 100644
> --- a/include/uapi/asm-generic/mman-common.h
> +++ b/include/uapi/asm-generic/mman-common.h
> @@ -79,6 +79,8 @@
>  
>  #define MADV_COLLAPSE	25		/* Synchronous hugepage collapse */
>  
> +#define MADV_SPLIT	26		/* Enable hugepage high-granularity APIs */
> +
>  /* compatibility flags */
>  #define MAP_FILE	0
>  
> diff --git a/mm/madvise.c b/mm/madvise.c
> index c2202f51e9dd..8c004c678262 100644
> --- a/mm/madvise.c
> +++ b/mm/madvise.c
> @@ -1006,6 +1006,28 @@ static long madvise_remove(struct vm_area_struct *vma,
>  	return error;
>  }
>  
> +static int madvise_split(struct vm_area_struct *vma,
> +			 unsigned long *new_flags)
> +{
> +#ifdef CONFIG_HUGETLB_HIGH_GRANULARITY_MAPPING
> +	if (!is_vm_hugetlb_page(vma) || !hugetlb_hgm_eligible(vma))
> +		return -EINVAL;
> +
> +	/*
> +	 * PMD sharing doesn't work with HGM. If this MADV_SPLIT is on part
> +	 * of a VMA, then we will split the VMA. Here, we're unsharing before
> +	 * splitting because it's simpler, although we may be unsharing more
> +	 * than we need.
> +	 */
> +	hugetlb_unshare_all_pmds(vma);

I think we should just unshare the (appropriately aligned) range within the
vma that is the target of MADV_SPLIT.  No need to unshare the entire vma.

> +
> +	*new_flags |= VM_HUGETLB_HGM;
> +	return 0;
> +#else
> +	return -EINVAL;
> +#endif
> +}
> +
>  /*
>   * Apply an madvise behavior to a region of a vma.  madvise_update_vma
>   * will handle splitting a vm area into separate areas, each area with its own
> @@ -1084,6 +1106,11 @@ static int madvise_vma_behavior(struct vm_area_struct *vma,
>  		break;
>  	case MADV_COLLAPSE:
>  		return madvise_collapse(vma, prev, start, end);
> +	case MADV_SPLIT:
> +		error = madvise_split(vma, &new_flags);
> +		if (error)
> +			goto out;

Not a huge deal, but if one passes an invalid range (such as not huge page
size aligned) to MADV_SPLIT, then we will not notice the error until
later in madvise_update_vma() when the vma split fails.  By then, we will
have unshared all pmds in the entire vma (or just the range if you agree
with my suggestion above).

-- 
Mike Kravetz

> +		break;
>  	}
>  
>  	anon_name = anon_vma_name(vma);
> @@ -1178,6 +1205,9 @@ madvise_behavior_valid(int behavior)
>  	case MADV_HUGEPAGE:
>  	case MADV_NOHUGEPAGE:
>  	case MADV_COLLAPSE:
> +#endif
> +#ifdef CONFIG_HUGETLB_HIGH_GRANULARITY_MAPPING
> +	case MADV_SPLIT:
>  #endif
>  	case MADV_DONTDUMP:
>  	case MADV_DODUMP:
> @@ -1368,6 +1398,8 @@ int madvise_set_anon_name(struct mm_struct *mm, unsigned long start,
>   *		transparent huge pages so the existing pages will not be
>   *		coalesced into THP and new pages will not be allocated as THP.
>   *  MADV_COLLAPSE - synchronously coalesce pages into new THP.
> + *  MADV_SPLIT - allow HugeTLB pages to be mapped at PAGE_SIZE. This allows
> + *		UFFDIO_CONTINUE to accept PAGE_SIZE-aligned regions.
>   *  MADV_DONTDUMP - the application wants to prevent pages in the given range
>   *		from being included in its core dump.
>   *  MADV_DODUMP - cancel MADV_DONTDUMP: no longer exclude from core dump.
> -- 
> 2.39.2.637.g21b0678d19-goog
> 
