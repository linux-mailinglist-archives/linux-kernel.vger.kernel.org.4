Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97BFC6DA7B5
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Apr 2023 04:30:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233414AbjDGCaY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 22:30:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229933AbjDGCaV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 22:30:21 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC43076A2
        for <linux-kernel@vger.kernel.org>; Thu,  6 Apr 2023 19:30:19 -0700 (PDT)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 336MQ7xg008819;
        Fri, 7 Apr 2023 02:29:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=references : from :
 to : cc : subject : in-reply-to : date : message-id : content-type :
 mime-version; s=corp-2022-7-12;
 bh=L21GWJfPiZZaCSs/mPnUGVcaxxNeQivHL9CM3du+UNE=;
 b=XiJyj0Fvu4evf3I12yOFiojVyDsM5jVgfuujd3h/lU5+/8v9UcrFyIlbqLRznVUo8+I7
 xn+jMTmoHJHRVi9Kb151YX8m35ifNVLU0eOgP3druDuRWHXwY8rhi0XDF6B6POZ07EzV
 B7Kr1ysDojCiRMqtG5uSdUwq0SspT5/7R65E1wwktTn1Ob15SGTg1tcQPRaaycYoStct
 DnXj9WSGzRyhHX0i4CxM4y486fz6Ycno9xEPezr+1c1RTTxdhUyh1VmK0tM2OPjBBS9Y
 f/TqU6AO/5MTTenkFyGa8ZRhpo9JKGs96As86GGer4ykCkX0a69rTB5e7Q2qepqSawuI rw== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ppcnd49jy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 07 Apr 2023 02:29:53 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 336NnK8B036583;
        Fri, 7 Apr 2023 02:29:52 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2176.outbound.protection.outlook.com [104.47.57.176])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3ppt3n5gdv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 07 Apr 2023 02:29:52 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=INvr0JYs/nd4nnPhEDkeCfdOI9+Ro64D/Zcn/t4/nv480WacMWhUGgRLnoPgtLdeVOtjXNw+mTc9lodO2pykL/vDIVsKjdszOERGseJL2VdBsR13WKjHRX7GTehAAtE/xC5ztARv0FuRXapQz0Rtdah8fI67U1sNZ+SxkoYFAJzRA2CCPeHKuURGZxVxbddynINI2juQHvCxsTlSi4pP5qKWV5utxbW5EW2aPbT8gtLJhtNU7nzCpWcCG7t+EaYRmkKXQVVQKF8PiiCZHEZ7xRX8pHvAsHp+agMD77h4lGKrCaRftPKSldsgHEzwU2XO2Jw9GeITkvgg+RA2qXcWag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L21GWJfPiZZaCSs/mPnUGVcaxxNeQivHL9CM3du+UNE=;
 b=LkmlUMeXMYfX3RMbAxZcsOg8vDpo3YdNmdHz35cJzNGb+JK4CuS5JxDcDznZD9Cd+v3q6OV5+W5lbaNQVX/ROIu5JcyVIx/vUcXv/GumCdLmU8SCQBiK4Ezvt6IhY/ks5wfcuuLyThBvUiSUZMpG7yVls2t9X7uMMBTOaPLcRWCEXi8LIX4TtQLavdZHNaixGXg0OGfP7E7+kcvZiu2MtZLMtFCIDHw9LhOhIZmUX7ZuyNPBJoqHEyi6/yrOwUXI1NGBJT4YIgcTvQ4SDqTXW1N+kCldr7Qzva2rYhHxo+BZ9ZwnnAfCKj0beplKQq9DADMt7meEiZoI6HZpJ5PGpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L21GWJfPiZZaCSs/mPnUGVcaxxNeQivHL9CM3du+UNE=;
 b=RCwFKG3KDdOugC3DTVw47xaarMn1CT6O/+B+4rzt+EUQMM9U9eS+tFFiQzokWQ72M3arGWa1I9vLsd0/1+Z0W+a9ddNbl0UHOkWXZ27kDKpzClJ7b/0ORv61oA3DCT9Z2g0JcX7EDYX9getSZ7Filk5TC7FjKNsWsju2K2TWjeQ=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by CH2PR10MB4118.namprd10.prod.outlook.com (2603:10b6:610:a4::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.33; Fri, 7 Apr
 2023 02:29:49 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::986d:1a90:f60a:53b6]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::986d:1a90:f60a:53b6%8]) with mapi id 15.20.6254.035; Fri, 7 Apr 2023
 02:29:49 +0000
References: <20230403052233.1880567-1-ankur.a.arora@oracle.com>
 <20230403052233.1880567-9-ankur.a.arora@oracle.com>
 <20230405202240.GE365912@hirez.programming.kicks-ass.net>
 <87o7o1lzko.fsf@oracle.com>
 <20230406201359.GC405948@hirez.programming.kicks-ass.net>
User-agent: mu4e 1.4.10; emacs 27.2
From:   Ankur Arora <ankur.a.arora@oracle.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ankur Arora <ankur.a.arora@oracle.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org, x86@kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        luto@kernel.org, bp@alien8.de, dave.hansen@linux.intel.com,
        hpa@zytor.com, mingo@redhat.com, juri.lelli@redhat.com,
        willy@infradead.org, mgorman@suse.de, rostedt@goodmis.org,
        tglx@linutronix.de, vincent.guittot@linaro.org, jon.grimm@amd.com,
        bharata@amd.com, boris.ostrovsky@oracle.com, konrad.wilk@oracle.com
Subject: Re: [PATCH 8/9] irqentry: define irqentry_exit_allow_resched()
In-reply-to: <20230406201359.GC405948@hirez.programming.kicks-ass.net>
Date:   Thu, 06 Apr 2023 19:29:59 -0700
Message-ID: <87lej4ifvc.fsf@oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: MW4PR04CA0125.namprd04.prod.outlook.com
 (2603:10b6:303:84::10) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|CH2PR10MB4118:EE_
X-MS-Office365-Filtering-Correlation-Id: 2d2a56ae-6296-475b-5cff-08db370ff5b6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hmZAz+5JYO2k305KdTQM7DBzLuB/iXbW/OWQZFH7s8xhd72OxWMOUxeTpiQKzxXOaXMrSD0x6kAEddv7Sg1g3RHn4bznOyfIcvZsjuflGAhlONFmfvi0GEN2RZDoSElwPVHBefE80nNiSdIeAZfC7HzbiKXvi9GT+pBKUw2iQ0cSt9fmnnHqx0sYHsiJZoDaz5PM70jgP95k3Ec2Fg1koHuvFhqAytxvRuS8vE2uNxO5nRkKdZ2NW8sIWcz1ISFvgQ2AiKfrnAuD2S5RKdsaM+BVVcI/tRVEqlnKGRUDUQ/g8glDJIrJ6IxY6+WHPg30pElFzyHn+txYBNfXIBT+SGkJ0a6lUK7MUvmJiwUTya3M7LH6bFm5lVEzFGeu+j5vNdFP51C1FgLpb0XnsZRYPz1prB4slVnpR2YRzoh9D9xy7VHZEToqcc4WBoHLMzsZW6OCjWb7okdusYQmb0XxvKWXPChnq0IdHYaBzIrugxXOxplsY4sge/Uijya7CKrR5G4KL0/CKXIppTGmQe/cYw4qdHdrvay/pfF4q5LzN06A3cK/UlrooXIiGb6OwnG7
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(376002)(136003)(366004)(346002)(396003)(451199021)(2616005)(83380400001)(478600001)(6486002)(6666004)(186003)(26005)(6512007)(6506007)(316002)(107886003)(4326008)(7416002)(5660300002)(2906002)(36756003)(38100700002)(66476007)(66946007)(6916009)(66556008)(41300700001)(8936002)(86362001)(8676002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?gi9bh+3SSXuProYE98KVVmUsg8TnAlMZosPBhJgprlInJvzwE384zXjjiai0?=
 =?us-ascii?Q?AImpE5rb8938rU0UDMEByufxHf+GSgQryW9GDtoEcpL2QTtNIYckOkaf6ZTL?=
 =?us-ascii?Q?6BCoLj6k3mSXfI0KxBOqJd8t9glZXKJKAQtcpXGgnDi8G7DtA5B8gdSIrp98?=
 =?us-ascii?Q?G7qLICs8WFG4oY701V5VCOUyOy3tZPvJ04oXVMeCP4+ycU/2Mtl73Z+SF4Jg?=
 =?us-ascii?Q?GLXKOhhmI7Sb4ivjPz98s1198KmAa038cfsFZMUYePzGE1HoX7/ov08823l1?=
 =?us-ascii?Q?T1Yxe5Cmb+Mt1MJf/vUu4PtfqvUygpx4IGIkvUw9Xw2/bQB6KciEi0lnc/Wo?=
 =?us-ascii?Q?qdIYBa+CjHyOIRuJTdPTou6vtueceactIhBt5kZ21+XgT3DihCx5QPW5lXT1?=
 =?us-ascii?Q?qhY9C6AjmwSYs9LPPId1cVklNmETdy1yLEbXQGS7j9B6dMbCzRFCLA7Ix7jR?=
 =?us-ascii?Q?JVt5X+n0sYTDwWvo8bsJUI+nRzfDug3fyUJ0GiWnJg5+Y2xBWofRQRx6yzpZ?=
 =?us-ascii?Q?aFR/6kRl2d7aW9L82UJeMAR1HqRRYjD+Znzb7mMCb0vcsfsfZqWxYuO128Sy?=
 =?us-ascii?Q?hedQZc21GzuzJ4KjUR+TxKavngKomd65AoOn2N6KwopqFxK7eu4PdAhpA0k+?=
 =?us-ascii?Q?CC7WgOIBNfrGreQiZiThX8FEAK6tT6uNRUFtoOqNf6x5rySXvFGMqVybUPEi?=
 =?us-ascii?Q?0snj1A235nYjsaJE5H7STEVkoSCGpRQULfMA8V9n+ENbAcBHiSyOZpNxiO2v?=
 =?us-ascii?Q?BxxqCGHAtfytLoknzP9ddQxMbnq4eiPqXKre5okFTYWZ49nRQ6WC75CcEonQ?=
 =?us-ascii?Q?x4gfBz5t5x5eS8LXe4CK0FQFirNCXFJcayyK00ucEI0eMlYJncmU1E/DJAbb?=
 =?us-ascii?Q?PyJKR70QlTMyLM89eSqv/RW6BA6raPmWB9vZCqESBD2TFCPSXDYRBX9mnhZm?=
 =?us-ascii?Q?bBPqHi2Uqg0HUWEMM5thZ9wQONRV36AyzDFQ04QfhiWDxiZ+TTtF4abzceng?=
 =?us-ascii?Q?U9gMedl06xp/BFzdogMz5J5oAEC2vCf9wQ17cIrWbdpoXijojX+841Ih9zYN?=
 =?us-ascii?Q?28NeG4W1lBv32KIYxvZ7l1y1g4cxnNuIPV2N4rZZTYZBRV3P0kpmNxahjA+H?=
 =?us-ascii?Q?cbDqdbB6hH245F3Ma0X4oiItI3RDfbcnQW7qEc866c6ROLr2jA3ydyWba2he?=
 =?us-ascii?Q?iU3IEZk2UYJRuuYq/Mi2I9wv9brSw4QOI0X9uZmdqCR7y7zWX7l3QoYzd4ga?=
 =?us-ascii?Q?M5J/QPx+XJ9Yg/Rp3nYpr5yn/Tk2ADBmSR2uPHoOa9MK9m5Qv3acUvrJQgo7?=
 =?us-ascii?Q?UWUeSRL2g0QVCJLHrOEXSwoCgSg16JtHehzLMHfUJeDrYx/Ny/BK3n2z5yta?=
 =?us-ascii?Q?wBsKFGdim2gBFVK5co55/XkOEXk6oeixkyZL3W0pVCq6cR9xjdx3C3vRpYUZ?=
 =?us-ascii?Q?eusNVQkC5fCE9X4N29z89zRvKNlqCXmbsvXObM0+Pq4HetH67hUnbhYbzfKK?=
 =?us-ascii?Q?BibbWiTX3z3q3AwkLYDrmSvna0ec73/D/Yq3f2GcSI2Cx0atPHXTjJLR6Ui4?=
 =?us-ascii?Q?tkGdYWfe5ZwuOElXwX6zpqj52vnTINSa5Bn00CuvhBKLTSmkO6ejlPAxRKyG?=
 =?us-ascii?Q?zQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?bgxJuPlrUUimXS0HIVI0NSnsKK46vvmhIqJWqeeHVT1HtU7kceZlnlFSmG/L?=
 =?us-ascii?Q?YzjE3DuIVw4NKt5h6+6ehh4Y0UEleoP+bVlSaCj7rULVgoEJc2P3sH9ZwR1u?=
 =?us-ascii?Q?xmExPnJkdpsu+e3eP2HRZDqXz8rITxbGCdHNrzWCrJEc+iyf/NLIELCFNILG?=
 =?us-ascii?Q?yc7ROff724EPGw7yIbxGDSc+vaAOCeVe/4aklDbeScYAj1ZaXKhw0OQ4kriq?=
 =?us-ascii?Q?jYzQIrvaOPkhDfLap+tUBYQEFEA11hycw/EYyy8jF3IS5SyjV46Pq819f3S7?=
 =?us-ascii?Q?hJLJ9WpUG7Zbt8+tsjk7AnCIC46a+3ieMvSXv8z38o6A7VDpbtwiqpbNAnHB?=
 =?us-ascii?Q?17IGR4wj4xP7iDQqisFnRAGWTtiV+jhMK1qOt5gJkSltBgSmVAMrQZj5h1OR?=
 =?us-ascii?Q?75S9eLIWIOZH9sMpDwfoSyNOH5zKtP1NiSDj5XEksEqtKJ7bZwzSr2XG9OHZ?=
 =?us-ascii?Q?dDD+g3mX0Tt33+ym0VdMLXG71BCXTnEq+G7aOhW20ToTL0wYQ3ZAOU20tLOr?=
 =?us-ascii?Q?M4JRy/4TaVPUaTfz60naS/cMZsrAK+gH7db8mdWhc2ZuW5bKbyZcJog+cQJT?=
 =?us-ascii?Q?GZRLT9Y4TAl3l8Bi+YRJlw2Ub9r6ZMTyGcBjim/K2ZNZRSz6V673Wd16JFN6?=
 =?us-ascii?Q?4O4n3DcyThOyipZ8qc3vyHpWPXEiOQSeKKJxnJupgcqZr1FabgrKyvJwEeeC?=
 =?us-ascii?Q?ffUlMcVy3H0gH5TVSKWyohRUptT4CKBlXZsIn3zwAgRD123rCl3vJtQ/tTf4?=
 =?us-ascii?Q?VN7nRLxCxG4j+uE01FURbRG5oEuYL+mJxRIWI5ohjaYBke4yUQBbw40mxaf9?=
 =?us-ascii?Q?5W3XfI6S15i3b/cFCosTKIxLxHf3s6M2noDiNjcBttUQBoXY7/fPWfVFPrF6?=
 =?us-ascii?Q?QWlm/fgi943j3hxwhJO6dv9x6rK0l/5d2c9qKgYkgj/kzIUrB2v2ttELRQ4p?=
 =?us-ascii?Q?UPsc1KvygH+e3AMsYT/2nx/ElBe9y1W/j+WtqTP64TUuxpTuIyYua143Ne8a?=
 =?us-ascii?Q?m0E0K3he+ou32pVnnv7PXHGG0tNyPCs8KCJm+01nrZCGvK0t5BpSVuqYUKFK?=
 =?us-ascii?Q?ddEpZY1t2SmOV82yLYeXNQDWqBoXCGjI7J1QylJEeRz6/fdp2HX5UxMa9gAI?=
 =?us-ascii?Q?3ELJ+RKhr/ie02ijT9w/oCIMgzQzN2efpLDV8UnPhdb/+quXKHeovyM=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d2a56ae-6296-475b-5cff-08db370ff5b6
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Apr 2023 02:29:49.2802
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kiVqYh0ZmeU6AQZ0g+fuEgxGO1OBhS/FKfOdDRLDoTrCM7jBuL83aG7gZfEZhh1iiqEbpLoSvlkcwpCPo8Y91iWxTTpFmcHLiMYGHrKs8Rk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB4118
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-06_14,2023-04-06_03,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 adultscore=0
 phishscore=0 bulkscore=0 mlxscore=0 malwarescore=0 mlxlogscore=773
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304070022
X-Proofpoint-GUID: ouK_bn8Msw1t0LLyfBUUSYj24kRoKMsD
X-Proofpoint-ORIG-GUID: ouK_bn8Msw1t0LLyfBUUSYj24kRoKMsD
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Peter Zijlstra <peterz@infradead.org> writes:

> On Thu, Apr 06, 2023 at 09:56:07AM -0700, Ankur Arora wrote:
>
>>
>> Right, so:
>>
>> CONFIG_PREEMPTION: raw_foo()
>> CONFIG_PREEMPTION && (preempt_dynamic_mode == preempt_dynamic_full): raw_foo()
>>
>> This is NOP if CONFIG_PREEMPTION && preempt_dynamic_mode != preempt_dynamic_full.
>>
>> > 	if (!A)
>> > 		raw_foo();
>>
>> So I would call raw_foo() for the CONFIG_PREEMPTION=n case.
>>
>> > What you really care about is the CONFIG_PREEMPTION=n case, but that you
>> > don't actually handle.
>>
>> I don't see that. The CONFIG_PREEMPTION=n (or its dynamic version)
>> is being handled here.
>
> Bah, I overlooked we have multiple definitions of the
> preempt_model_foo() things. For some reason I thought all that was only
> for DYNAMIC_PREEMPT.
>
>> > And yeah, you've got the extra resched_allowed() thing in there, but
>> > that doesn't make it any better -- this is all quite horrible.
>>
>> I don't disagree. There's a quite a lot of static/dynamic config options
>> here and adding this clause didn't improve things.
>>
>> I think just going with a static call here for the allow-resched case
>> might have been cleaner. Alternately I'll see if it can be cleanly
>> folded in with the irqentry_exit_cond_resched() logic.
>
> Something like the below perhaps?
>
> ---
>  include/linux/entry-common.h |  6 ++++++
>  kernel/entry/common.c        | 23 +++++++++++++++++++++--
>  2 files changed, 27 insertions(+), 2 deletions(-)
>
> diff --git a/include/linux/entry-common.h b/include/linux/entry-common.h
> index d95ab85f96ba..0c365dc1f1c2 100644
> --- a/include/linux/entry-common.h
> +++ b/include/linux/entry-common.h
> @@ -415,10 +415,16 @@ irqentry_state_t noinstr irqentry_enter(struct pt_regs *regs);
>   * Conditional reschedule with additional sanity checks.
>   */
>  void raw_irqentry_exit_cond_resched(void);
> +void irqentry_exit_cond_resched_tif(void);
> +
>  #ifdef CONFIG_PREEMPT_DYNAMIC
>  #if defined(CONFIG_HAVE_PREEMPT_DYNAMIC_CALL)
>  #define irqentry_exit_cond_resched_dynamic_enabled	raw_irqentry_exit_cond_resched
> +#ifdef TIF_RESCHED_ALLOW
> +#define irqentry_exit_cond_resched_dynamic_disabled	irqentry_exit_cond_resched_tif
> +#else
>  #define irqentry_exit_cond_resched_dynamic_disabled	NULL
> +#endif

So this is clever. Essentially this would toggle between the two kinds
for the preempt_model_preemptible()/!preempt_model_preemptible() dynamic
case. Do I have that right?

>  DECLARE_STATIC_CALL(irqentry_exit_cond_resched, raw_irqentry_exit_cond_resched);
>  #define irqentry_exit_cond_resched()	static_call(irqentry_exit_cond_resched)()
>  #elif defined(CONFIG_HAVE_PREEMPT_DYNAMIC_KEY)
> diff --git a/kernel/entry/common.c b/kernel/entry/common.c
> index be61332c66b5..211d118aa672 100644
> --- a/kernel/entry/common.c
> +++ b/kernel/entry/common.c
> @@ -390,6 +390,21 @@ void raw_irqentry_exit_cond_resched(void)
>  			preempt_schedule_irq();
>  	}
>  }
> +
> +void irqentry_exit_cond_resched_tif(void)
> +{
> +#ifdef TIF_RESCHED_ALLOW
> +	if (resched_allowed()) {
> +		/* Sanity check RCU and thread stack */
> +		rcu_irq_exit_check_preempt();
> +		if (IS_ENABLED(CONFIG_DEBUG_ENTRY))
> +			WARN_ON_ONCE(!on_thread_stack());
> +		if (need_resched())
> +			preempt_schedule_irq();
> +	}
> +#endif
> +}
> +
>  #ifdef CONFIG_PREEMPT_DYNAMIC
>  #if defined(CONFIG_HAVE_PREEMPT_DYNAMIC_CALL)
>  DEFINE_STATIC_CALL(irqentry_exit_cond_resched, raw_irqentry_exit_cond_resched);
> @@ -397,8 +412,10 @@ DEFINE_STATIC_CALL(irqentry_exit_cond_resched, raw_irqentry_exit_cond_resched);
>  DEFINE_STATIC_KEY_TRUE(sk_dynamic_irqentry_exit_cond_resched);
>  void dynamic_irqentry_exit_cond_resched(void)
>  {
> -	if (!static_branch_unlikely(&sk_dynamic_irqentry_exit_cond_resched))
> -		return;
> +	if (!static_branch_unlikely(&sk_dynamic_irqentry_exit_cond_resched)) {
> +		irqentry_exit_cond_resched_tif();
> +		return
> +	}
>  	raw_irqentry_exit_cond_resched();
>  }
>  #endif
> @@ -431,6 +448,8 @@ noinstr void irqentry_exit(struct pt_regs *regs, irqentry_state_t state)
>  		instrumentation_begin();
>  		if (IS_ENABLED(CONFIG_PREEMPTION))
>  			irqentry_exit_cond_resched();
> +		else
> +			irqentry_exit_cond_resched_tif();

And, if we choose between the two resched modes at compile time then this
would work.

Might massage the names a little but this should work as is. Okay if I
use your Codeveloped-by/Suggested-by on this patch?

--
ankur
