Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42FBB705AD1
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 00:54:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230480AbjEPWyI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 18:54:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229651AbjEPWyH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 18:54:07 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 576C126AA
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 15:54:06 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34GJx26k021250;
        Tue, 16 May 2023 22:53:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-03-30;
 bh=HoUqa13/pV05OncT7ff9LplOkd2bjht2QlOFiDRyPDU=;
 b=YkH0Kw+Yh4z4o1y76rGqJq17McDkCTWGyHO597OhPgtGAvq0SmppKnwd90vlRqSrHs4O
 ZOuAgYD/wJld7OQNPYG0Qy1xN0cPtjPl2alIOUGROQe6PyDd12bAxi+bpEzTAXAKkWvv
 RCel0eNJgzvUZuBjmq5I3EJkJUSsM3U4KyO+Xy0nq0VIpEuaVsryNGb7oDTmr7UIGbEn
 8i8H4iX/0SD3NH9k9bmVjwQwL1jSKW7MxrlJvOZ9fD9F0mf7mBjOHlKy7J9pXX2wKfGi
 vr1bzPMRnO71m1fLsCRUGfCMuAvu8RACO78aHrhPSnDe2dqnFi7IZAnW6tQ61TemmiWW UQ== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3qj0ye48ds-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 16 May 2023 22:53:53 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 34GMoppE032130;
        Tue, 16 May 2023 22:53:53 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3qj10aq3w1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 16 May 2023 22:53:53 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IXjOh5c+A2W+6GnbIfCs9xVo9VDPxuG9Ch0f/cFB9gj/SSABby8gPRxLiWDjEjECLJKqXz/R87mLo6asw3fXqphLcYef5wcf4Rpz64YtKaznrcu7Dy7zhgzUKVII7ZuaXLjBc9GT2Nj1HRgYUGWdx+e9XAp3Md8OmRBMDCLqIJGMIZizFnHvi2l5afPH821Kd2UNwm4/6SghibLeBLQFo5jF6RG5JOmZo0cF5QEjvq9j+JGp+97e7Yg9WjohDFZhq2wTAh8KfmXVLR0pFC9SBWiaEJwXdckgTsvXCYSQtu3MckNHSOiW5jKiP7k8rCn3KqbUf+sFSUQ2FnvHXiNTJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HoUqa13/pV05OncT7ff9LplOkd2bjht2QlOFiDRyPDU=;
 b=FN57lkyvfl3AU06BqLkCNVrje9VpZtsT1bwzruz1gtIyvmaNhqW0PcjKCxO6bnQJjAkQIW5DKcMR9tr8CEBR3QSgh0aaRKIhgjaeGRgSq3Y5xWgj9WQ0tHkoX8bgAjQKnaIhUzr1Pk7RyLx1xpy4uwDIsH+HrPsmSiqxi2B92bM3dsXcPKH2GB2ImF3KWYShTdo8DEx7sNRbWdwVoB5791zd134tY3CNK15//FmSzJYP6lFYizOeUImr4RwM/pYoIra49JtKB4NN8OzsJZtEWYor5wsZZIYgM8VdF/TWsKVfynB1E08vibojunHZ0B5ZEGHwUhzCDeMTuSbhNaI9ww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HoUqa13/pV05OncT7ff9LplOkd2bjht2QlOFiDRyPDU=;
 b=MPhtnbvKoWhhUD+cUmrmBl24AzsSlJrftfbVLDw4M9zDyO8fDjhG6bSqyby6OJIfpfP5X3oswVUKfiJT+1pMSfjPHTVKnn/Ll8zXtYwvG5sdvH9/O983Q9qtk/z2ZB0K49EVeyFfSG2CeG0bz+GZpUmdbQqv7cw8pNSMBXxo/kI=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by DS7PR10MB5998.namprd10.prod.outlook.com (2603:10b6:8:9e::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.30; Tue, 16 May
 2023 22:53:51 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::998f:d221:5fb6:c67d]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::998f:d221:5fb6:c67d%6]) with mapi id 15.20.6387.030; Tue, 16 May 2023
 22:53:51 +0000
Date:   Tue, 16 May 2023 18:53:48 -0400
From:   "Liam R. Howlett" <Liam.Howlett@Oracle.com>
To:     Peter Xu <peterx@redhat.com>
Cc:     Lorenzo Stoakes <lstoakes@gmail.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>
Subject: Re: [PATCH v2] mm: userfaultfd: avoid passing an invalid range to
 vma_merge()
Message-ID: <20230516225348.yrh5qpwwodezebak@revolver>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@Oracle.com>,
        Peter Xu <peterx@redhat.com>, Lorenzo Stoakes <lstoakes@gmail.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>
References: <ZGKjvceDfpKMxtfb@x1n>
 <bcfb0376-ccf4-4467-9da5-8ae6f1c86876@lucifer.local>
 <20abea10-5307-498b-b9df-8f0b2fed1701@lucifer.local>
 <ZGOcAOFOjx3XPGqO@x1n>
 <9739133c-3ee7-4e94-a6a8-783045a50ac6@lucifer.local>
 <ZGPn00ZqqQqdmk2e@x1n>
 <e90c2b38-805b-4df1-abdd-8ee460b12b72@lucifer.local>
 <ZGP4KSw/yD5ItTYu@x1n>
 <20230516223830.64ege7magdtx3zsr@revolver>
 <ZGQJCaZiPDjYS8w4@x1n>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZGQJCaZiPDjYS8w4@x1n>
User-Agent: NeoMutt/20220429
X-ClientProxiedBy: YT4P288CA0070.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:b01:d2::18) To SN6PR10MB3022.namprd10.prod.outlook.com
 (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|DS7PR10MB5998:EE_
X-MS-Office365-Filtering-Correlation-Id: e9db60d2-6eec-4650-e533-08db56606ae7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RKhBYe+LN0BxRkRyXhf+8n4lnm21peo+xX8CLDY5Z3W6Souev7E95Cmq6vU2NF/65OZlzfeW2FDEfbj3AB08WatRRhjdHozwZZPkXx0ZwnDUFcUGaA7RuKx1ON6CQCqzOn5vJhzGi7ls2OyShaOW6j4TCSR/h7kI2ZahNkGFqTficUOAOGqdzq0v6e4PR25ceiPU0f9Rq/vORbcyhG0Re9rUYWfYXPrNoR47NKWJLhkM3uznngXTJ8WoSZqozF80WZ1BnvsHHuPw0/CYUU2xSpPFlDxuSstcOfDJQsFSsRtZkL95qNk1odlaWmJ+BczmF8aVZkKNU1OhBnme82hJeQQxWTa8D/qOnJsjRKyz896Tv9cCFe44xwNID8Lb802IAz+ZqyD8lHcY3Na+rctnGP6ybe/VI1IK2N6gwgAtCSt3LWDtMthWwWA5e6C7okXzKDSkMcZt2hCUbSiTb7XRWm9/txCNkxAX1bdIu4t316LjumdL1TAvUPQeRfEMKPws37Wjd3faNklkRrtFhLPXOG9MhalwpJZoFAyPp5UlQ+yBiH5JCifoRpiw0CLxsFUM
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(366004)(136003)(346002)(39860400002)(396003)(376002)(451199021)(66476007)(66556008)(4326008)(6916009)(66946007)(478600001)(54906003)(6506007)(6512007)(38100700002)(186003)(83380400001)(9686003)(41300700001)(8936002)(2906002)(6666004)(8676002)(6486002)(316002)(86362001)(33716001)(5660300002)(1076003)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?SAqkARObpEXC0PPFB7URN69i368Tt/63LftKXNhO1QEAsuqn4J2Zdol7aDvN?=
 =?us-ascii?Q?QLU7cqW9wPm4YhPMiIv1NSS17xfcAGdpEQ1sDFEDa1vLS4tGJIjYgRM8TcoM?=
 =?us-ascii?Q?M69Ql6YynVS45EIoEuZ5JlHJekVUGtbqZxM7dfbYqbmZ+fc/pXfY3VwRKReo?=
 =?us-ascii?Q?tciZCu4AmBvcZYXzbb2fr9/fQXgb9jN2VFusiuL+08G5yDUy011lFKdEBcK7?=
 =?us-ascii?Q?qCGSY7DNQwMhFC6eJHPdU8tMakveXUIAZXd5+YlVuHTbtEv7wImh3UM2RcUy?=
 =?us-ascii?Q?XhROIOBckj0hf+0iV1dxELwVObFMZnnQVd0U4P7+WGxCQO7aEBpJb/dBPBx8?=
 =?us-ascii?Q?vkB1s6lugPeVLjr03p3SLYhv6oyvAoYfEDIMJfoXD+qmicEMdmhi2h5PvrrL?=
 =?us-ascii?Q?GQKtTZ1OI4Ne+eXG3OuNsRTB9HIO59kB+hxPZkRfZXBrYOWV3Bb9JuCeew0M?=
 =?us-ascii?Q?gG1PsBvg+KJUdf+mM1AY90poOQZVeJd7dKoLp5NBDkYZlwa+HQKcHYyQD6Dt?=
 =?us-ascii?Q?cDDYIiWN71YCwRlj83aOyuT29e+FVb8WVne6c7UmQ7Q0ryvJjVhutoGwWNup?=
 =?us-ascii?Q?ASsDN7DMv7SpQvDonLd97TEiXCpK8F8C4flZ6Bj4g8UKSybV5twL8Bmt7Zi4?=
 =?us-ascii?Q?DK70Kg+FhhqpC+X0NNrsAmdSgyUJftu8S7v/hM+u1O6oMB8aCNPy6afo01le?=
 =?us-ascii?Q?9NdOdZQwTMQtWadN8pscvl2mHxl+I60JjBiCNJAIUTfUz5ggMle/yMR/jZou?=
 =?us-ascii?Q?WTyDz6D/S3wiw+hPNF+TFbWCqaMkyR/jMT3q9EWJNxPDQJdWJtIbwN+MmEON?=
 =?us-ascii?Q?acaC19PiOmIaNt3jJhii9PXVkpndFE8aJxcX3zxc9s+ISUxPjpU4qYW924Dk?=
 =?us-ascii?Q?/sCF1W0b50yBnnoZgF7dXRCBBeJBK0kn8sUeLm7U/4qQPg+viYCtPL3oVxYk?=
 =?us-ascii?Q?VRDjiwgXQHtr5MtASM43u2bg7No0MhIlWasDpm9U6iaOU4/pckWmZiAkgkMb?=
 =?us-ascii?Q?wZ1xqjVvCw2zFLh9u1ZO7YGM1qnYICEM2js+RdVDg4o5sPFjL3ByYiBKmdtf?=
 =?us-ascii?Q?NtqctA7xRZfWB0h5QHAR9hCof1PJ1VU0X3EyZwm2mX0LhQ8lby8ZmJBotNw5?=
 =?us-ascii?Q?C+36qvb5yivj7OdYCM+b+vOqvW/az5BVvFr34Do87VP4f5nJtFzt0XKuxg2h?=
 =?us-ascii?Q?RdFzn6Uk0j+M5yV9BUpPuIRzK1csNKZFrIf4u7/fHmBx/l7pOAtpRyB7SkH/?=
 =?us-ascii?Q?V9ERqWjiK0yk/mtnBbg4uVBMMFb5/YXFMX1bS5jWexEXHjhac1h6GQ4Ne6dT?=
 =?us-ascii?Q?FSohDlJ3p0WdbvZ59GJmmOWUK52qJiI7S4LuACG0u2zDIfsL1iIebFLcWNZG?=
 =?us-ascii?Q?8KRHCHVQt9WFwGCLNwSIpl2frQKglhFfPUJg5ILTCu5dauTK+JzmkNYq2jSN?=
 =?us-ascii?Q?G8G+Wq6z6VqABpI442yItlXPsqTz01f/C+4DEUFGmUcBPAZKLEewcVHEQ6CP?=
 =?us-ascii?Q?8ol/0R7TMscaq7T0LMIQCKTv1jAZ2QfRrzvrGW0coh4XGpfZdbVVxA3mNWv0?=
 =?us-ascii?Q?NDelTuRG56j9Enr2VwQ2W+YBbwPO4xTN4JUDWVhV8Kba/R8JhfxgvYVPFzJh?=
 =?us-ascii?Q?Ig=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?27z92ZR9Xrg0bgZO4GZlGwUeaNBXYoK8umqLeQAoBQ8YdxTSGNzXqApiF4i8?=
 =?us-ascii?Q?E60MjI8nAA05NcZbOJRW9HYWS2IC/62L5OPx/WDXMXUWqAKjyxDQtSAJMgXN?=
 =?us-ascii?Q?UGUqU5Gna6euOgvBeT/d+j714kCO5BRKkd+T4djkP++S6pPNZoUlnvw5KGEb?=
 =?us-ascii?Q?w2ZL1p85K9vh62Z+UCo5r1ExK9/ahNaMH3uHNFFD68WK76eLimyvCgIWBHuH?=
 =?us-ascii?Q?J5EomjWwPZPenhWEhv5WVLFFn7on0iJtWzap6orlnPViJDzR5RfTHpLUGjFR?=
 =?us-ascii?Q?s094zrmJtOHNxenRBfbTc5y6JLXcep6Wb3V4TiqTbUDULiu6RQTh6JYE0hHO?=
 =?us-ascii?Q?XS2jvX7PrAzvkpZ/bh0Whw78Uibvf3HJf9rXSCWqcV4m/9WZIoer3ursi/iJ?=
 =?us-ascii?Q?ClOmD5WLS4PltLVaDh7qEHgcdhc+BymmNnaHaGIjfSb9bS00+RREIjNS/K6D?=
 =?us-ascii?Q?W9hLPxE3xIEIC3XfHmu+KKR1pQ6FO6Og8nFPVu7zucAQsQexgZbruBbHU1Pd?=
 =?us-ascii?Q?ufrAVI0CR/j1EIyAaQltKyiVsEb/AcRb/uuBvdcHBscXpME/OGpHe2VW1YkD?=
 =?us-ascii?Q?fI8CP6n2ASAfK4cJRQ5802/eaj6v+nw9/Nhxk4gOTAZKfMJZmAwtCCrcx7hq?=
 =?us-ascii?Q?/vsmRohNcm0jjJRhssov4TsifwE43V4RTcXhJ5ib1mxPFRrLmKkj0/eaHcAX?=
 =?us-ascii?Q?SeF+q/sJIlbHibGWn11RotyOXrNO6CUU1ntp1OTpH+HxfIUorzraj4xlYZAp?=
 =?us-ascii?Q?wYSqIOUeHv5YB76b7oIpBWpp2O9ss0o/dagWZ4jFhaByQxXwdJJg30OkeQJb?=
 =?us-ascii?Q?M950CAoXZbHFwoFiXE/a06ebQNT4h6bJe0aIm5CAPCehOZ0fYvRVvLmnbpVm?=
 =?us-ascii?Q?oX2vLyWCOln/BmLe35OqKpT4cseMH03U6UM6tZy0Mx8UD2UGQl2hpDxE7ubs?=
 =?us-ascii?Q?FvbyoC1bKG7YsG0mgYt5+uAF7IV+sH3eMHWu7o3Vs+WcCqtUqy5Wt8hqCLde?=
 =?us-ascii?Q?gjVg?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e9db60d2-6eec-4650-e533-08db56606ae7
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2023 22:53:51.4610
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EBxBYPc7Lof1x0314ilpWngXs/pGEYg3xF/DAut32SiOOHiBo1gVBId0hxujyy6tDKqTj1Eumyx7yFLGOB+Zpw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5998
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-16_12,2023-05-16_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=724 adultscore=0
 malwarescore=0 mlxscore=0 spamscore=0 bulkscore=0 phishscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305160194
X-Proofpoint-ORIG-GUID: HaaVGltFqrTt_coV_OrDez6fDJNhKaZO
X-Proofpoint-GUID: HaaVGltFqrTt_coV_OrDez6fDJNhKaZO
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Peter Xu <peterx@redhat.com> [230516 18:52]:
> On Tue, May 16, 2023 at 06:38:30PM -0400, Liam R. Howlett wrote:
> > > It seems to me what you're trying to explain is we shouldn't handle any
> > > split in vma_merge() so we should move cases 4 & 5 out of vma_merge().  If
> > > we split first then merge, cases 4 & 5 will become case 2 & 3 after split.
> > 
> > We don't split in case 4 or 5 - we adjust the existing VMA limits.  We
> > don't actually handle any splits in vma_merge().  I think splitting
> > first would change 4 & 5 to 7 & 8?  2 & 3 would require a split and
> > munmap, right?
> 
> Right, I referenced to the wrong numbers..  2 & 3 are when CUR (CCCC) is
> empty and newly mapped in, if split happened it means CUR (CCCC) exists
> which is 7 & 8 correspondingly.
> 
> > 
> > > My question would be: if it worked perfect in the past few years and it
> > > looks all good enough, why bother..
> > 
> > I suspect, but it's not clear (like all of this), that the other
> > arguments to vma_merge() is ruling out this potential hazard I thought
> > existed.
> 
> Some more elaborations on this one would be appreciated.

I just responded in the other thread, as the context is more complete
there.
