Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 582686BF0FB
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 19:46:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229787AbjCQSqy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Mar 2023 14:46:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229533AbjCQSqw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Mar 2023 14:46:52 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8529CC927F
        for <linux-kernel@vger.kernel.org>; Fri, 17 Mar 2023 11:46:49 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32HIjlEv031186;
        Fri, 17 Mar 2023 18:46:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2022-7-12;
 bh=ZFlVTtWjm59W5PZnLFj2JirmwhO3tfcKK6WjXGrT0dk=;
 b=fgg82bKHwUqvRWXlrjYsS9V1Mmtsno0JOWFoCOCcEGIILZEz6FuUv8fGIfZOOkOPWKrc
 bLo7WnNBDzwaREJhmFB5HLVVRtkHPLpEegrU2n1yLrLnc8huXACuFVDGrUGyXMgGYMof
 Jsu0SKHm3lGCe+ygfkt3kl4whudR3LAICPl2ZbePbGK8YB+/I58ZPEiTudAf8DAzEHoi
 Rcc3lkjLSsRpC+9N7V5o3l7iTBGud2KhKWzskg8P8EY1h3/OxSX04fP24xwSA42yNj3Y
 A097IJfHA6KxdG1iuG2E2IrM2t6e1C1uN5mBgcAVdiQ9UmjimNeDldkT/arMmFXZdat5 Fw== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3pbs2ammb3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 17 Mar 2023 18:46:39 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 32HHGWi2020727;
        Fri, 17 Mar 2023 18:46:37 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2174.outbound.protection.outlook.com [104.47.57.174])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3pbq46npb8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 17 Mar 2023 18:46:37 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ht5pnGryV4GIBhBFa6bBP6Z7W3MTZslnQey63LSors3YEXK7vfP9ZEEq30xO7TwFBSqn1+6g3yLo7S9gsZdbjFUmBXwkoHn0ScEoS7PW+IJ4gQCv58WzhIMGviOSGI46I8pOjAWI4dUcAGBHwK0ZWOnoTI/LaQPnXnNtbB3Vh7dTiRzh7Xvzgxz329+7uroICCvo2Fzznpb0x/0hHizNetMUiJxrEwhWqiAKow9BqW5BBgVUerIzn8TnAGBCVjUZp5Q9VcUKFF/wclX7IjjYBqN6GBsDWtrbIjyXPHRIkYC/YKP9E52D2UH44jwXqD3yr+Cx9HKd7WGUawhS2R1/gA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZFlVTtWjm59W5PZnLFj2JirmwhO3tfcKK6WjXGrT0dk=;
 b=B2qcAsMUwoo//pkLYRehRMXL9LRDjX7cuJf73hfXNtixu8MEGCGo3IrI7mLAilswwQSNa8tUPWrNj2f4m0IQheXDdpIBr79AlJsobD42hRJS29OaXuteFT7M6nny9xqkBlgSasUrkIFChnX2F8GfruEFrW2lfRJYwWLMyI404zqjMQJGMAMeSWP+lFDtkp0BD+0E/zVWAmls6Mxvbn6xAIZsdkDbaeCs4VSullTTd8wroLkVAapzjkz43m3DLuD6/zrcoR87BM4TUsH4iiYECL2Bp0y46BMbN9wAI9G9id8fHDRl2t/MRPRzdarAzHSp2W7XEbQwz+DwrIbZ/qiGqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZFlVTtWjm59W5PZnLFj2JirmwhO3tfcKK6WjXGrT0dk=;
 b=cJ9AVaLOFEYvOQDLkDf0srDioR+Q8/fOfcyQ37oxwMFF/UNbDkaAeey2YmN/WsitpF5hwRGDpUMYjI54oVZXB7oLZBpr5yrX6IkqOhC1R091ufX5JRJmSQZVbyB/+WP1LnfDgRY36n/rkruKO5dJvcu6x0Ge6sAwu2rAp7LX4+o=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by CH3PR10MB7704.namprd10.prod.outlook.com (2603:10b6:610:1a9::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.35; Fri, 17 Mar
 2023 18:46:35 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::3db5:6e11:9aca:708a]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::3db5:6e11:9aca:708a%8]) with mapi id 15.20.6178.035; Fri, 17 Mar 2023
 18:46:35 +0000
Date:   Fri, 17 Mar 2023 11:46:32 -0700
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: THP backed thread stacks
Message-ID: <20230317184632.GA69459@monkey>
References: <20230306235730.GA31451@monkey>
 <ZBSo+mLUOsKvy3rC@casper.infradead.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZBSo+mLUOsKvy3rC@casper.infradead.org>
X-ClientProxiedBy: MW4PR04CA0275.namprd04.prod.outlook.com
 (2603:10b6:303:89::10) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4196:EE_|CH3PR10MB7704:EE_
X-MS-Office365-Filtering-Correlation-Id: 03af3b14-dd52-477a-435b-08db2717ef4b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XTOKemPxuWtb+Lfiu9bws6QgW+yeWNANQtPm6pyRWnDkdmvR7YlkYJ/rAoVd96lZ84Efb9MU7nJMLMzl0TlD5tYJUQjLttTsqEBXH2/TJ7UrcuNGmu7X3Qkmb0B3DxT1sAGkBQM/FbUOYLEocpKJNTpyKp0Ky4OcWIF8lDH6ZJXJ3q4zgGIx5LEzujSB8ogf1kyiMwQjTmnc0pMIbh+rID1kvaFRtmUe/o+tJcHhmbMdPx7QLRTuk4ySFzWYxXhwQm3YG9UG81nq9xdygREv6WlDfjEdBaxhdfi3lPL+2eJYiS7G0GdScsjN+bn8pvhD9D1CbWIz2cygqXGyIaafXkbpftqwjN+IVZVaY9IcUrNZo/O8SdPAa6fyf/kxK77ICcSvzikbZKhdvlwjRgiHRfonld6p4a2eI1AEPCN4TVM9koMebplNiPcXnVRJBEFSuEjtY0mXNJotDs1Iuvw9000etWLy3TmLx+9vvOHpG7rpjIVEQX4jDDZxXQEAMYxW5849apMAwHqv16a/LaAhdX10Uiu8257wYw7mq2qcf6VFcFkv2c64fr26zv7rR+SfR84UXXw9ThYzd098d2iOOpob8FVULzPPT2dbqB9jP6xo6MpihuI8sm8RO9n5N50nux9ZLwX3i1qjOsbQp7kxTQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(7916004)(136003)(366004)(39860400002)(396003)(346002)(376002)(451199018)(66899018)(33716001)(83380400001)(33656002)(3480700007)(2906002)(316002)(6486002)(478600001)(186003)(6512007)(26005)(1076003)(9686003)(6666004)(53546011)(6506007)(38100700002)(86362001)(5660300002)(44832011)(8936002)(41300700001)(66556008)(8676002)(6916009)(4326008)(66946007)(66476007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?UUR88MSazYKnbne9Q34Xc6igrW7sUiqFY1zugljIfoVwHHyux4xvE68xDxuK?=
 =?us-ascii?Q?QdP3m80ZmIsMEzXCJg876u777mWwNDHpcni0RLVH2Abpe+B/gLqIZUaDrtQg?=
 =?us-ascii?Q?tF6UNH4r4V5pcg9hPOx/RlImLINHxs06K4ODcR1qhNapzLXF/1vTMeFrmLuI?=
 =?us-ascii?Q?VX+ZMJrqeiP5XS8amDFD2OZ2g/VXtsf3Z9DXUZMFw1U9+D+D4Bj9bvWcDf/Y?=
 =?us-ascii?Q?oSHRvx/a9jGDUr/XT8U6R3Pu9RM17zuaJiVqq+wQLPfpnReLzLPFKUOX1ueE?=
 =?us-ascii?Q?LYq2wSBo5vLrYZdJxKhxxx08One8koilZRxaQv0u+99l60mPuCoepVLqS2y1?=
 =?us-ascii?Q?KbbQ2dB7lF6UQk0bQ6NUTNt35JCOOoqBOuqRWD+hZWo2T5v9deuFgaW27FGe?=
 =?us-ascii?Q?3+Cm/HeNHJblKI6Yxdk1470e03spvZ1r2dsR0VZRkC4pQ8G6TtFFfceI4kOV?=
 =?us-ascii?Q?TaogFdqEhr1Bkv2WBNYc1lxB99MgL9XIHkmb7IxidsR2Q2ljpcI1eS2hrYDs?=
 =?us-ascii?Q?9jlzSLOtJYk0M/h8x61ofBsmqXnyP91Vd/GaQy1N8OOwvINV5K2F4SQI9SRf?=
 =?us-ascii?Q?HZPjljKmRTOMDJkVXZp6++BHkhNtZ9p8G6jPqhRWD+Z/gFebs3asFJvqL5EB?=
 =?us-ascii?Q?tIoLudt7XP9QumzFLlUVHnw/rnftmelP/pYMFhShmOKExRPpEkes4OZcaHK0?=
 =?us-ascii?Q?IF3xixm/Gb5KUTyn9eknQC7Ai0XQ3Hi5xYzdzOmMb7dFnNSWCHgCBvN9EDkz?=
 =?us-ascii?Q?2yXNUHqXQBHBx9L0b3qDLf92H+KhcuOAVuNO4U/yaDd0rTsImWy/lzrEzGtd?=
 =?us-ascii?Q?FnHkFWXYN0Wfk4UIYoRhCtH/wfnRltsr/MOTjOqtTjoOhtZgfYXljdu3CVR2?=
 =?us-ascii?Q?MIMkwPzK6havjBy7h/+/nVDCX3U29ccY5PF/Zh+04usfJQqy0SooHTm1qxoJ?=
 =?us-ascii?Q?cC5Hc66Oh6NmmUKrq/GfxCTr4iZ0oyMKS1xC/eBbWqwYOvbU1jgTek8zpg5s?=
 =?us-ascii?Q?BfopHCuUQS3Tm/ql6gf8+2Kc2pTKWgi4J99aRR75Xeq+wYvJjmx/rjgZNaEe?=
 =?us-ascii?Q?tIsjVYr10WcDWKHa2W/NdgvshbzO3tgXwoxTXP9fbUdkwXu8EHvKD4Gl/E8R?=
 =?us-ascii?Q?a5o6Z5uPZvgGuafPYIquShZnbLie0Jxhhqv0yIz03avopxe7QY7YZ7ueRaSs?=
 =?us-ascii?Q?omRQeGuVxIOrqp3U0GV+50JrD8ogNHAiLso+/oOFDYuG7QN/VZk6IxzLkQgz?=
 =?us-ascii?Q?J9NMVRyvlTsi+7KA76yOs4Ys7wAzd1+/9OTD2H3AVwle88tcBhJHu3j403rv?=
 =?us-ascii?Q?VIWSK2Ly5uAQTel4a27ig1KLPeY+hOtgmcY7CDPC489QECvzlhXt7FlCa87L?=
 =?us-ascii?Q?mWTu0H4OLs1fkvlClprfIvjN+tpFEWTTv1tZ4Z9YMvp4zsVwP1hQzXMYD87m?=
 =?us-ascii?Q?B+yt8qvIn3Ov7rlsAzcmzSCjhp/SgyQWyRfDnN+tfLL8kiZS07hrGpSKhWPZ?=
 =?us-ascii?Q?clYAUQoo8JMtJadq7/uZzF+4uHgJtE7dn7P42ueKSY0QxWHGllRvt6AieVll?=
 =?us-ascii?Q?3BfhjeeKxwa6GHjx4SqVvkydyytGfROr2lG9zTCHH2VrKDPiFzppt4AQqv95?=
 =?us-ascii?Q?0A=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 0z2jHq40S7ytZD5SU4DYj3wqKDS+jX3OICIi7EMk5jT1dDgMtWdHCd2a/2/l43n8e3atzfkwCs3juc16DXK6tKqU2wwCfIgtLSzSeBt20XJgsjCA3/pE5ZXCF6AR+rtNWFmP2KMmnfiEa1bjv2+xgYtwirQ2NAH/9wmRq/2MyF1jDCixXrdlgiRHQKx2TMtdvhEYDuwasEuKwscXkKzW1FND/8UzpHY4iv9fK/6gYmt2QAZEVH5szVwINj5uBufDXEtQ+DkrZwi+3Rf75aAbNU5zO6WgvTFoXHDltKfyVhyUq76Az1MnVR4XgAm9fwn7ze/NnOjZAzfg3dfUN5+S4AyvDDWWpS1N7Yy/5ecUd/oBZBasyoe9MPlzvjamx9GWXvkP+n70lAdSu2b/dY8Q8o/9i9nYwLRrPx/UHr6Oyc57K6baPLG1bB8zkOkfUcoKHxerRN7IG4oMYo/HMWrNlvCIteSEU+3joUexCIN8L5UN2pVxs8cFAG9MKfcbQqddaAjBs+LZ6oi3SPnhjx8uGk6rUxGTvWGCNi9JyR1gAWbMqXa+YWjJlGUrPyto0pbqF5bgWR98aC2MFFQFh8Qe+ibGUbNr4uhnAZwCS+cQnfl4hLbqkj+VSURct9rM5uRLMRN5xIZijX3uJv4dSJSCbuhLoNOra7Zk0q1RzyNGenUppBWii8HJ0FfvOvWgRNLvLZ+z/r20zGy4WQ+u6WnKZMIJg2rLlBCWarknnBt4m40niN23iub+OI7bmfNjuaRk0VEsdO3/nKVUzL3ddlABftiQcTWJndEewHRlEa4kxyWedYFHjXA0WuDJkRy4oq3FoNdKSCX9x0MdnfbuQwsH+A==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 03af3b14-dd52-477a-435b-08db2717ef4b
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2023 18:46:35.7349
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VZZchtTrT3J6VBTEWRgbRyUnkZpF0yMAgYhC7+hZ7oZc3M8EYMMoRfTe4YNxDv5zKpFSHeBxXYKShi5faduRyQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7704
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-17_14,2023-03-16_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 suspectscore=0 mlxscore=0
 bulkscore=0 mlxlogscore=999 malwarescore=0 spamscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303150002
 definitions=main-2303170128
X-Proofpoint-GUID: 4_fSLZwwhW_RNHqoLEjDz3EEEI6sfa8x
X-Proofpoint-ORIG-GUID: 4_fSLZwwhW_RNHqoLEjDz3EEEI6sfa8x
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/17/23 17:52, Matthew Wilcox wrote:
> On Mon, Mar 06, 2023 at 03:57:30PM -0800, Mike Kravetz wrote:
> > One of our product teams recently experienced 'memory bloat' in their
> > environment.  The application in this environment is the JVM which
> > creates hundreds of threads.  Threads are ultimately created via
> > pthread_create which also creates the thread stacks.  pthread attributes
> > are modified so that stacks are 2MB in size.  It just so happens that
> > due to allocation patterns, all their stacks are at 2MB boundaries.  The
> > system has THP always set, so a huge page is allocated at the first
> > (write) fault when libpthread initializes the stack.
> 
> Do you happen to have an strace (or similar) so we can understand what
> the application is doing?
> 
> My understanding is that for a normal app (like, say, 'cat'), we'll
> allow up to an 8MB stack, but we only create a VMA that is 4kB in size
> and set the VM_GROWSDOWN flag on it (to allow it to magically grow).
> Therefore we won't create a 2MB page because the VMA is too small.
> 
> It sounds like the pthread library is maybe creating a 2MB stack as
> a 2MB VMA, and that's why we're seeing this behaviour?

Yes, pthread stacks create a VMA equal to stack size which is different
than 'main thread' stack.  The 2MB size for pthread stacks created by
JVM is actually them explicitly requesting the size (8MB default).

We have a good understanding of what is happening.  Behavior actually
changed a bit with glibc versions in OL7 vs OL8.  Do note that THP usage
is somewhat out of the control of an application IF they rely on
glibc/pthread to allocate stacks.  Only way for application to make sure
pthread stacks do not use THP would be for them to allocate themselves.
Then, they would need to set up the guard page themselves.  They would
also need to monitor the status of all threads to determine when stacks
could be deleted.  A bunch of extra code that glibc/pthread already does
for free.

Oracle glibc team is also involved, and it 'looks' like they may have
upstream buy in to add a flag to explicitly enable or disable hugepages
on pthread stacks.

It seems like concensus from mm community is that we should not
treat stacks any differently than any other mappings WRT THP.  That is
OK, just wanted to throw it out there.
-- 
Mike Kravetz
