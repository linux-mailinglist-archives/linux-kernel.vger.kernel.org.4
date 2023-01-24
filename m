Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21601679DC6
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jan 2023 16:43:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235062AbjAXPnB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Jan 2023 10:43:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234979AbjAXPm6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jan 2023 10:42:58 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FB7A4C0CE;
        Tue, 24 Jan 2023 07:42:35 -0800 (PST)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30OEmoR0005244;
        Tue, 24 Jan 2023 15:42:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2022-7-12;
 bh=h70yshnGRfsaZ1CTx3Gl96c3oWs7+wnlIOENiAEJk+0=;
 b=q2nnyFIc26GNcDNL2l8UlQx6MuYyKo5Whaj/yd5kaBBBM+F2Fbiywk7OoWvMoBMZG1ob
 6no79zHF3ag5jllaepeT9zoiE4OBI5HfB3pZzlxD9K4phoIM/nxPxnWeFZN6uYG53XSu
 RkUFlbzZkNBBEIEAKDvqYOOIufDCmqp9Lo80G4IWb31582V3rBA9YM/ZUazA4dCMSM12
 rfswu6D/IiBy6+JECN2mb9SeGpOr6RCcUfxRA5Zlb9f35y3YQUZAO7+opGKNm/w5Qrcq
 m0NFHXFmWR36Ib0zuweAN9Bm3/1OPKW8s2eG05nIB6s2LiGbKfQek6F3kS4YMwzQf3vN ig== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3n86fcdrk5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 24 Jan 2023 15:42:16 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 30OFbwa3021441;
        Tue, 24 Jan 2023 15:42:15 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2172.outbound.protection.outlook.com [104.47.59.172])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3n86g53b9a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 24 Jan 2023 15:42:15 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UYQ4ND9SvWWpn5SGRUMcynwUEXHQs0Ydy38xuicM4Lo1HSRYVYQpplYHZb2gGfOvDsjmAHSf2IvPgd5Z/dLnEzJ08ixfspecbQyaCoY5TS/R5DBoO6mN5YbEwE5k/FKaM3cq1s/3WoIE62QZlefg0wVlR1pN5E5Sp1EAmJjVt6npcV01IHER5O8mqxmfx6bC5cZgOJioenNYnvBVduk0Vi9qQrlC8C9hniT0wNJ1BQo652f1K2QUEd0LS0gy+NKeyOui7pBMnQOns2L53v0l2Tod5vcRp0iA6ahh8jGOaVEHFkeD9MLviWKI4iAZCy1WOpLJqRaWz2YXgMNtRrE6cQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h70yshnGRfsaZ1CTx3Gl96c3oWs7+wnlIOENiAEJk+0=;
 b=ofkg6/3umQH+jHT824LpslXlXZDlmDrqtFk5xiorFBGr4aFIfb1kjQF5Xp47GCk8bU2nGYS1IQkjU0drygvWtrYMJeehtaqlXej6vcDfHCj3F1wi4UYR0uR7B5uvjez3LHEH/MeLJypaKDWuPxlCb8EhoLtUdihXqdoRPiclw631kOLMlQAgxOlEnAKh+sm6tZ0xk1/siOrtmwKCeCJ18tWQUcuwykuvtEEpdctjYtHEa0DV0URh8nFVry3OSI4J7GN5OoEVS2uw5zHxuD6TuPphOTgMScVg89LDX0XYeir7XukrmoKVIvQiaoX/F6/DlniI1qbHqQ4SIlVmEknckg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h70yshnGRfsaZ1CTx3Gl96c3oWs7+wnlIOENiAEJk+0=;
 b=EyRjaK7tD2dzQwBFfvmBjIpHyHYJYLQqN9qjI03R/mJPLVTUzemueHrQX0tcEMc1Iog/sUcuYUh/O/I3pGVgDIL7NyPqLv1Hco6rIhMqGsRQ37+wURMa1+JTcntyb9/N2YC2BVHJHlJOQpNUBk9Wg3/c5y58+tIsVKkwGhy3GiU=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by CY8PR10MB6441.namprd10.prod.outlook.com (2603:10b6:930:63::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.17; Tue, 24 Jan
 2023 15:42:13 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::7306:828b:8091:9674]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::7306:828b:8091:9674%5]) with mapi id 15.20.6043.017; Tue, 24 Jan 2023
 15:42:13 +0000
Date:   Tue, 24 Jan 2023 10:42:10 -0500
From:   "Liam R. Howlett" <Liam.Howlett@Oracle.com>
To:     syzbot <syzbot+1d9ec4d1a334ae9e1ca6@syzkaller.appspotmail.com>
Cc:     akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-next@vger.kernel.org,
        sfr@canb.auug.org.au, syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] linux-next test error: WARNING in vma_merge
Message-ID: <20230124154210.efkn6lakc4tj5p53@revolver>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@Oracle.com>,
        syzbot <syzbot+1d9ec4d1a334ae9e1ca6@syzkaller.appspotmail.com>,
        akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-next@vger.kernel.org,
        sfr@canb.auug.org.au, syzkaller-bugs@googlegroups.com
References: <000000000000c467c705f2ff449f@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <000000000000c467c705f2ff449f@google.com>
User-Agent: NeoMutt/20220429
X-ClientProxiedBy: YT4P288CA0077.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:b01:d0::6) To SN6PR10MB3022.namprd10.prod.outlook.com
 (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|CY8PR10MB6441:EE_
X-MS-Office365-Filtering-Correlation-Id: 79df4cd9-aa5f-45b2-f570-08dafe219017
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nBVWZ5gsf+WPaqbocbR9qp3qVgTXiAUinDHZPLGUrdTL/tcrXSkS8mHH7eFmJE5K2LmdQsnmx0t8eQ29e6ix97UxJliTiWT2OA1bABEdFC6c1j6Nbkk4RNM6n/DHzK+pqt6ZnAKSL1j1L8CdR/tHYVUxiugM9b4xWVhjQRVS+2MqFcC3tjCYvHBZUmU4UP+tQ3EBWsrY+G2UvRfkvl7TwMFJJ57KDyXG5jl8DJl21LUbxalzOzNhEadxk61mNijPmTQPTaI75+QO1joV/cGEubxnKN1/2HragCmKLYF0mgp9pb0Fx6a0chY1pdiye9u2dRoXkXkZyB2xQfaqm/TNM+TefUwf6bWJoxsiQ0gz08jxobZIgYpfj3KR7itW/2R2kat+mJJ4Pt8FjhOMInDtDrIBzW/+LeHdgJXIpgwkeQmjmfNy9N7b26xBWwvo0y2lIVUgGH7My4RBE3z1Kyqqz+bVVmyqeZcNIGUYGjAQdwi2P13i8aJSkNZyKvQTZGt9pOayL8IfYJguINwSdAVVjNen0yrxyC+3JlHi+pizaxiQU4FrlSyTeSftReSGrdzPjdNnSvQ4Azgcex/oOH2NXkBLt1ZPLP5tmQhSI9yPo8iS+2OuwmNPZxqK2HZLlLM3yebLCJBeaWdDnfk1d8j0I8McW99YpDEnEE1yl4nI/mZn1wPQA+Dnq7QLhlAS+aGst9txXBWj7KdYkOBjnTxP4MtGiwkWrYPKyDZfqfLi+jsBFTrnhB4AICq/0RzF43F+
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(346002)(396003)(376002)(136003)(39860400002)(366004)(451199015)(86362001)(45080400002)(478600001)(316002)(38100700002)(6486002)(966005)(5660300002)(2906002)(66476007)(66946007)(4326008)(8936002)(8676002)(41300700001)(66556008)(6506007)(1076003)(33716001)(83380400001)(186003)(9686003)(6512007)(26005)(99710200001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?yjubvzi0N6/F25MnK39mRiUif4lc/SjgM12yN3UEQOvJgzstDQlxg2LbwPoa?=
 =?us-ascii?Q?925ZYlnsTT6QDDdUz5vR47tTevPrEtrX6oUa1qMffqIQJpB5LRVH+GrsZqYL?=
 =?us-ascii?Q?WIhoAoYRmLAgzRlxJQ/ZUYEKUi6vN95fWFawojpmAoIGBsFlZohcgpwKB1IS?=
 =?us-ascii?Q?Q1PM1qpSde02oOXWaiohens3I2WZkCf+Fo6qvDJlLmEKUYc79lauflzm/+KQ?=
 =?us-ascii?Q?JJ/8AE8z3wzBEPijqFgMFi9EacbNDb7V6Twl84UMvZMEUlhd/c0AqQSIbq8k?=
 =?us-ascii?Q?KKN2/pogRD7xWF+2L3tM8UCQoC0STD2M+JJtJGPIVMyNXODpbeHdBnti4QD7?=
 =?us-ascii?Q?RNzXMYG4h/algs2t/c5n08snXFjRTRI73CaRTPv5NZp+pf4eeAx24Xuvgdsc?=
 =?us-ascii?Q?lG8AApYsT0bWRw4Zw8Bqgkg1MbagQWoZCXdSuGoMohPj6LfJT27OAdvyNra3?=
 =?us-ascii?Q?ysOgjBE/yfkEf9YTuAdvxIPRbLt8YNGCPQ4+d+UhF8RCL+WBtk6qmoJHAKP7?=
 =?us-ascii?Q?B+nyrbUyIXr8cuwy5h+QQZ4gFFtufH7fDaL9unIbQcChKrpA5UcbamuS08Cy?=
 =?us-ascii?Q?9Kslm7ygzjSV3C77ETiEei/glsoFLw28jeVq5Iw1N2cQe5e89k8u/bAj5F2V?=
 =?us-ascii?Q?OGjtNX7Ya5ihb0W5z/0IpS0+U+ppqk14LOhkQEbCZDHqBhQZvhqLt7BhMuzY?=
 =?us-ascii?Q?DwwozMxU02vR1WdpjnePhU9LDMZn5dT1nLuV2GCipbaa7bEQkzGMEtLLCq4F?=
 =?us-ascii?Q?E+50jPFu9GQ1rfI51G5/+lar4/95DYAbVFaFL/rivg5LIskG2YDIWE8oBoQp?=
 =?us-ascii?Q?WJeD5DM5yVwavXgQ4Ex9XhmaBHNDTuMZhyWDUpoQZE041bHZ8qncomIx+Y3e?=
 =?us-ascii?Q?qeS13g9/dI/NFh/i4i67DQ5SjQfIr7ISLbp3vfHjSMzF9aKqYtKWCE2EB/6y?=
 =?us-ascii?Q?cD+0Qzi7fXqUVlO/JOqW83g0INzTPyJHVNi5xjvCXlQJ9pj9J/p/8sIKKsPd?=
 =?us-ascii?Q?G9tTvbYlKQlrxEO7Dw0cSDjGiRsDtBc38om0icUo6+dup13+Kfl9JErO/oTx?=
 =?us-ascii?Q?2Y9VLukOXZ3gFkUwtm14PazI7aCNwOXMplfGSfMn3DHjip/9VRDZuLA2Qs+B?=
 =?us-ascii?Q?aecNKVVGoxoOeBpehrCA82ACUTAdq36S1DV61xwMT0i1O36+PF/ZDvjsBkSy?=
 =?us-ascii?Q?+2REcpvootro6PJ/bpUk7B7ZnPXMN8i+54EGt75Cyz6rHDaFbbsCmzkYXb8M?=
 =?us-ascii?Q?NCMYGaxFYjZFWJu74Yv3aLB6UBhsUXLpC6WGIlKN+wtSTd5XuPE5k2E3U863?=
 =?us-ascii?Q?VeZ2akAZw7hIjm1knZjzXJBnt/gm+QAa4wHZs+84XY971FQDS+oH775emhn/?=
 =?us-ascii?Q?jlNxTpZPLZQx6N3mLI2JcvEvBF1W25qGlhgnflXvBNbmESw6WPMw/I1yjzzH?=
 =?us-ascii?Q?tkyLcZT9s52YeZ3qCKG9IUwk9GKLtuEuLr1fEjG1STtYlNvsJSuNVqXs04Sa?=
 =?us-ascii?Q?IYS4R3HjxbubNuv1MvaeiqIEwb10cXxWjcxYzcaDOU+Wv9KaEvOtJOlkDPeU?=
 =?us-ascii?Q?ERLR1uY3caAdNcQNNO4kbYpbpvfaQFkHdU/kFtSAZhZyhuqrB4lGPc3Wpwd5?=
 =?us-ascii?Q?gg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?/1K6q5GBjUIsZNSvZLVAsVwSttXwLK/AnkWt2E9poaM9qtiUrS7Ncscgj75e?=
 =?us-ascii?Q?Q+pu9nOozeYzT2sEyMRmmKd++AOXF5NdqEhDXaOgChsG2n/rJU4XPUt1r3aJ?=
 =?us-ascii?Q?1juxvFKsxjZzokeLLCD1jVHbaxjGleS3Fv1fFhtAcr0mQfWWMdBtLnjBfsN7?=
 =?us-ascii?Q?wXkq/eZSGYMVfwJPaTR+ESZQhwxZUozKM7P5OisOB1gzLz9RKovuZGePyFnY?=
 =?us-ascii?Q?JReNI2cI1lekFZTu/uPwdgf9g02BMq3Wet4gePjTKiNSF9te95Z9yjfKYymC?=
 =?us-ascii?Q?8Ec8aMb/KpW6LJaqPJvon/RxXv8vHitp8zr4N9UjWwzSi27OUAcrzI3ifV86?=
 =?us-ascii?Q?AobAUELXjCvt1WRJ2ZnhYZ0c2zOHi4sBNItFT73n+43+uISiLGNwt63oInte?=
 =?us-ascii?Q?uGOlGAgo3fx2BcW8GHsuxuN+LjMVFr7B3gFpBm8C7srJC3E2eOfgGsSDsTfY?=
 =?us-ascii?Q?9UpVtP0mf3AVE+XWWG9MRST6SJ26nJPc5o4YUsLrG/UyjPeODgQ6AdtGZK/g?=
 =?us-ascii?Q?tKB5KnGDw1AaWnx2t9H802hP5p0eUNaYQBVKH+9aninXYvPAFsn8JG/7Ij36?=
 =?us-ascii?Q?5eWLg8vJ+nEwkUlcfqTWNh6UfR6z7H6TOcpNbPAjT/Ow91V9t1gwRPldHtlH?=
 =?us-ascii?Q?sNb4YmzS4LwAxY6QIOI5kB0+VKMhsW2iXevi8S93o5w2K/Z24qskXqT9dpyC?=
 =?us-ascii?Q?3uj9/4+am6w2pcb+i+50jMbP/5rgaoNPOwPirrCxfH/n/AzESxKP4o3V2xpV?=
 =?us-ascii?Q?VIlS3uLg/TvbojTleZET10RZrwBHRCED8yJEKaLbfQWl5J+nF3J5Buy4PcMn?=
 =?us-ascii?Q?3hxzhTn1YEtaIk0ajbBhMXiLEhS1KO6iyc+k0eUXCIDha5pvnFNeUthaPLuV?=
 =?us-ascii?Q?SiDrhec/CTiS9YHCGyr3vCjcZ3t21yO2jVcagRR4Nv8OsGa8BBB7hzj3EuCU?=
 =?us-ascii?Q?6Zfj5/ImPPdHUH/cSeDI9znwrDiPPm1hjO7AUP+7UAQuPFC56kb77BkfGf6B?=
 =?us-ascii?Q?u8Fj?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 79df4cd9-aa5f-45b2-f570-08dafe219017
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jan 2023 15:42:13.2774
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gxxtX/RkdoIsR/EGDJvDfHNBhZNI9GwmZ1vnRK3h4EMY5/+le1KuzJIZIYDkqzDxub8x/gOqz70N3R+NOVOYKw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB6441
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-23_12,2023-01-24_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0
 malwarescore=0 phishscore=0 mlxlogscore=749 adultscore=0 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301240142
X-Proofpoint-GUID: VrCNWy0R_mde0b95SamaU2NfZ6wOBBzn
X-Proofpoint-ORIG-GUID: VrCNWy0R_mde0b95SamaU2NfZ6wOBBzn
X-Spam-Status: No, score=-0.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SORTED_RECIPS,SPF_HELO_NONE,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* syzbot <syzbot+1d9ec4d1a334ae9e1ca6@syzkaller.appspotmail.com> [230124 04:37]:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    a54df7622717 Add linux-next specific files for 20230124
> git tree:       linux-next
> console output: https://syzkaller.appspot.com/x/log.txt?x=13220341480000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=32f13cf65b56e95d
> dashboard link: https://syzkaller.appspot.com/bug?extid=1d9ec4d1a334ae9e1ca6
> compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
> 
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/131be349f841/disk-a54df762.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/35330c9d8c6e/vmlinux-a54df762.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/90c182db9219/bzImage-a54df762.xz
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+1d9ec4d1a334ae9e1ca6@syzkaller.appspotmail.com

Thanks.

This indicates that the vma iterator is in the incorrect location for
the requested store operation.

I'm looking into this now.

> 
> ------------[ cut here ]------------
> WARNING: CPU: 1 PID: 5076 at mm/internal.h:908 vma_iter_store mm/internal.h:908 [inline]
> WARNING: CPU: 1 PID: 5076 at mm/internal.h:908 vma_merge.cold+0x2e0/0x6b1 mm/mmap.c:1014
> Modules linked in:
> CPU: 0 PID: 5076 Comm: syz-fuzzer Not tainted 6.2.0-rc5-next-20230124-syzkaller #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/12/2023
> RIP: 0010:vma_iter_store mm/internal.h:908 [inline]
> RIP: 0010:vma_merge.cold+0x2e0/0x6b1 mm/mmap.c:1014
> Code: 2a 48 c1 ea 03 80 3c 02 00 74 09 48 8b 3c 24 e8 7a 39 0f f8 48 8b 04 24 4c 8b 28 e9 e6 4a fe f7 48 89 74 24 48 e8 84 52 c1 f7 <0f> 0b 48 8b 54 24 28 48 c7 c7 a0 60 58 8a 48 8b 74 24 48 e8 e4 d5
> RSP: 0018:ffffc90003c5f980 EFLAGS: 00010293
> RAX: 0000000000000000 RBX: ffffc90003c5fb60 RCX: 0000000000000000
> RDX: ffff88807ec23a80 RSI: ffffffff89c09b9c RDI: 0000000000000006
> RBP: 0000000000000000 R08: 0000000000000006 R09: 000000c000400000
> R10: 0000000000000000 R11: 0000000000000000 R12: ffff888077f28d28
> R13: ffffc90003c5fb70 R14: ffff888077f28d20 R15: ffffc90003c5fa10
> FS:  0000000001f4dab0(0000) GS:ffff8880b9800000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 000000c0006f3000 CR3: 000000002af6e000 CR4: 00000000003506f0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
>  <TASK>
>  madvise_update_vma+0x21b/0xa80 mm/madvise.c:153
>  madvise_vma_behavior+0x7ea/0x20a0 mm/madvise.c:1091
>  madvise_walk_vmas+0x1c7/0x2b0 mm/madvise.c:1260
>  do_madvise.part.0+0x18e/0x340 mm/madvise.c:1439
>  do_madvise mm/madvise.c:1452 [inline]
>  __do_sys_madvise mm/madvise.c:1452 [inline]
>  __se_sys_madvise mm/madvise.c:1450 [inline]
>  __x64_sys_madvise+0x117/0x150 mm/madvise.c:1450
>  do_syscall_x64 arch/x86/entry/common.c:50 [inline]
>  do_syscall_64+0x39/0xb0 arch/x86/entry/common.c:80
>  entry_SYSCALL_64_after_hwframe+0x63/0xcd
> RIP: 0033:0x4675b7
> Code: 8b 24 24 48 8b 6c 24 10 48 83 c4 18 c3 cc cc cc cc cc cc 48 8b 7c 24 08 48 8b 74 24 10 8b 54 24 18 48 c7 c0 1c 00 00 00 0f 05 <89> 44 24 20 c3 cc cc cc cc 48 8b 7c 24 08 8b 74 24 10 8b 54 24 14
> RSP: 002b:00007ffe658ce770 EFLAGS: 00000206 ORIG_RAX: 000000000000001c
> RAX: ffffffffffffffda RBX: 0000000000002000 RCX: 00000000004675b7
> RDX: 000000000000000f RSI: 0000000000200000 RDI: 000000c000600000
> RBP: 00007ffe658ce7b0 R08: 0000000000200000 R09: 0000000000000200
> R10: 0000000000000118 R11: 0000000000000206 R12: 00007f77fecbb000
> R13: 0000000000000080 R14: 0000000001f4d640 R15: 0000000000001018
>  </TASK>
> 
> 
