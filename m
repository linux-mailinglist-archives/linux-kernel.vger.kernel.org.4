Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0D406A59B5
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Feb 2023 14:03:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231278AbjB1NDC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 08:03:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231608AbjB1NCx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 08:02:53 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AE3310EE;
        Tue, 28 Feb 2023 05:02:52 -0800 (PST)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31S6GSHS028680;
        Tue, 28 Feb 2023 13:02:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=corp-2022-7-12;
 bh=BQQm+BdgXnFzmwTRnoGX487q7zhcg4bUcK+YmDgMG4w=;
 b=gcMynJ8WyYCQPAbgvFD99VVkV0LZDf52r1uMwkYgBYnKLkGY8JJAXSxkWgEwrfUw+36B
 32gCsyz05X0M9bz+PAS8/tMnhujRD4TKZXnPq8k7j/9yzcSwI4mxK5yA9lfpnnVusSKX
 k/X0xizAF1prb7JtJPsfNo7jQLzXyeOXB67uNu9EIUSWmHaEGNFoDdMJwPTVLJj20hHN
 s+zEF8U/W0GRGUxbE9BJtg3yf/rfSCY4uhoC6saDPNB1N2BzDvYLSO3EEyeA7wGAeYkt
 o5S2GWgAQi7TOeogI1FxTFUQv40/lL8Jx7SCiYcCpnJKnTRIAZeLW6hFY7RCv35mambD 7A== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3nyb9ae35v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 28 Feb 2023 13:02:32 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 31SBif8i015877;
        Tue, 28 Feb 2023 13:02:31 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2041.outbound.protection.outlook.com [104.47.74.41])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3ny8s71mex-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 28 Feb 2023 13:02:30 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aC0XYQJEBal6snuAuJ8QBf8eQO9khlLe2UKacnZYKEpBTDLa7nwdWj1zLlO7gfgGzFXHkLBjjSjjCuzQlxX/nn1uQhvamQ7iTLHLW8TPZ/68w6tC0Ojsu76fW43ofCD6z0nOIP8mgrk3D4Xm/FUx+C3G+kqzZVW2Cu/fHrUYdKOrXcMn7/WSmr7n+NW826hmB4830gucxpmw/yvTHy+Hi2/vWGxERRwld3hWW7ZPUUK/Bwif0bqd3sTB/0m7GrkKfdViPGFNaQMr4m++ptUzoHZBzGyyXLzGO5vE9d7DY3oUahCNP70DrtH2RDITy7VgD3UNJpZkPsSMRBtzXLR4tg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BQQm+BdgXnFzmwTRnoGX487q7zhcg4bUcK+YmDgMG4w=;
 b=J8U6ujWEVUxz6nON6P2qsh+YaP08qE+6vXop0kclYw44QkapOAGSvK+0sp5Av3aI64zP5Rci3+mX2ysytBDdn4hl1Ch5GcoOf6+qmLz9wvd2OctLei8cF7hPbY+RU47e6gG24EVokaHJlcAszNs+banG6mQqDL2b5gZXDhvgqvEXbkKEmMbwq38E5dUd9lyLs1SW2ohHjw3ixDFsnNQ50VLe74Gdw8BnEBjYw+CE5EeXZRKT92kB04+fvxAB1WTpv4QghuWQGyAoH43IHOLjzHB90/+xFrj1FUBlIm0ZANd197/MoOn/deAEdHdFmeLWLXuHqG2GbAKKHjBlkQeeJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BQQm+BdgXnFzmwTRnoGX487q7zhcg4bUcK+YmDgMG4w=;
 b=p8PzbxgiH8k4+irM6qa34ypHvg3sITsCduZQQkDeN39A/DWICipB9chcOKANyJUX/MTjPhg02kWOl7g8Xy8WYIhcAFSM67rT8EW5nhlZvbD/zW/DuzgVMDKkkln1GHAcEc2ZmwVgTNakwv6rA5ou2/K7o1VNHFMovxIx6XzQofs=
Received: from DS0PR10MB6798.namprd10.prod.outlook.com (2603:10b6:8:13c::20)
 by CY8PR10MB7290.namprd10.prod.outlook.com (2603:10b6:930:7b::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.16; Tue, 28 Feb
 2023 13:02:29 +0000
Received: from DS0PR10MB6798.namprd10.prod.outlook.com
 ([fe80::d0f7:e4fd:bd4:b760]) by DS0PR10MB6798.namprd10.prod.outlook.com
 ([fe80::d0f7:e4fd:bd4:b760%4]) with mapi id 15.20.6156.017; Tue, 28 Feb 2023
 13:02:29 +0000
From:   Nick Alcock <nick.alcock@oracle.com>
To:     mcgrof@kernel.org
Cc:     linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org,
        Hitomi Hasegawa <hasegawa-hitomi@fujitsu.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        linux-perf-users@vger.kernel.org
Subject: [PATCH 01/20] perf/hw_breakpoint: remove MODULE_LICENSE in non-modules
Date:   Tue, 28 Feb 2023 13:01:56 +0000
Message-Id: <20230228130215.289081-2-nick.alcock@oracle.com>
X-Mailer: git-send-email 2.39.1.268.g9de2f9a303
In-Reply-To: <20230228130215.289081-1-nick.alcock@oracle.com>
References: <20230228130215.289081-1-nick.alcock@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0318.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:197::17) To DS0PR10MB6798.namprd10.prod.outlook.com
 (2603:10b6:8:13c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB6798:EE_|CY8PR10MB7290:EE_
X-MS-Office365-Filtering-Correlation-Id: 4d25583d-e0f4-4448-babd-08db198c0c1a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ahG0lfhytXUhq7rGPxM2wwFw367SxO6TWtLDLq+t2AVFICEXMg5uxiDVcXUGgjCc5Flk8E9X/1XpkWc9JhK5sBtpZt1u52gaQEMEW+RB68mcQQEgSEqlQIVLovG6BiezVAEN/fTDmxJqTxRcO4GJxLSzyNyeynnfO4qXAIjNqC10KvKpVFQsgmvuG67EwuigWdzmKstLa1apDbOvLRGwKoSOM3J9xLKJHgjroTlh7GrO6tnuBVlt1DiEFwRgEQRAWvQ+bqhFb1MlpbPyOVUqYf7JaBgpP1gdOpDtI+2YaQ/RlRNS7HprB8NpQkP05PPsGWvEoHPI/B5YdRwiET65yjsuL/auSjhTdIytZccsfF8Hx9zXkvXbXaVNoSvbLJ10dCcpoJF72tTSto+Z60OB6ytLz/dCdTuvbsfA4+RcOCLKdsOAVk2WwjKlTg/Sp9oqyjfPqG2l+wMTXDQBUBEpcb57dqcFoVRpprRrstHPld7Yuu0fj13ng8ajTGGrTRBMrzKWI9fKVDiy16IvnFViUJgCFyhANVVGNOad9s5imCyFQ8E5EK9KyEzK9j9iL9o1K+dLlrOpknCi7XAGW1nJP/dl1g3vdHMhdjGhoFeOK3ieN4M90y8DukbqVNkpOYU9dFanFx5PoRHXKZTBFKk+Cw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB6798.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(346002)(366004)(39860400002)(396003)(136003)(376002)(451199018)(36756003)(44832011)(5660300002)(83380400001)(478600001)(6666004)(6486002)(2616005)(6512007)(6506007)(1076003)(186003)(4326008)(6916009)(8676002)(66476007)(66556008)(66946007)(41300700001)(86362001)(8936002)(54906003)(38100700002)(2906002)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?2DJE3RjULQB85fn4oS2aLuYwjRFFfMwDvUVkoALpXfKlc8dAyVO0sD0Pz1Vp?=
 =?us-ascii?Q?o/px+M0XFvDWi2W65w2mu9Jr4sXsDptwcyUK6KbTWtayZYu6RqR/4Jz8Q3lD?=
 =?us-ascii?Q?ycP4DV2C5QHXhgF0XZlVOxfgTTa/KbfVIcQA5F6jcFP+oo9nwp4pPJwRxRFz?=
 =?us-ascii?Q?zm9GeqInSuo/r14G5RJ5b1BbK6X4UG6X3cLbZ63QrTF1BC3joRtQiQkEUO2I?=
 =?us-ascii?Q?ukjSWEVuc0pLp051zJkD1k6lA1NcvhDs9Lk3DaF1q1/LSXCT+Hulg2uJO93D?=
 =?us-ascii?Q?MR129ghxGnJV7aVazOJC6dRSfkdTITETEq2EkS6++h6/GLsEEG62aN/bMqoq?=
 =?us-ascii?Q?cVlA4IAHY01L1bNK3HQ+9JDStjcK6obKWJUU+4Fr2SsvCykzgnm8ypCATIQN?=
 =?us-ascii?Q?VtB6y04Mo+UrxqQU0uCDOpJ+Y6b0UD1pc9OFO1WLiC0s94xC6wMm5l88lpqZ?=
 =?us-ascii?Q?kiPBOhAvmBsUTBUy7g1uJwh22C8qPbKfKGY4R1ldxn2cqlhz35IpL0LIjprP?=
 =?us-ascii?Q?W+QvoSZHgq7yRKfhqLNucY6GKKVZPOLY4Sae/HBJe+2CdrWauI24e/gST1nP?=
 =?us-ascii?Q?9OjM9MDSu5qrF+ZiMPdLKJE7xyUogwOuuLMWXQWIteVAPvwrnh1j8T2mIsSf?=
 =?us-ascii?Q?5bTn1c9uVe+jI5g3UhC9ftkhhzaERZVqgg3UiqRmk0vSukFR3qm8raL/Z+9U?=
 =?us-ascii?Q?EGZCJrk264OmSncBhKK9f9oehsubLSBRwo4UWph0MHeSdHyy1RzkEWPZz77K?=
 =?us-ascii?Q?/YsA/IaGdip3iT0sh2/8aL06f5UhxvVuDj+HByp3GKMu2HWFFfM78Opib7EB?=
 =?us-ascii?Q?7XbQhxfUIKXSANzlM/XzTI54Zm5TiWCrfkbPwLg5VWUNT4rJxs/vZ8E7FnDm?=
 =?us-ascii?Q?DITVp/6nT9gOWlW9lsnkAvQHHiCLc60hyGks2wQp/sIoOFOXwWB6qE7KlR85?=
 =?us-ascii?Q?IRNVITF0FI6NrPxC04wjtWEyHnTvhneU3Wh7fXeAWCf8hmaMMREm+ZCvWhlt?=
 =?us-ascii?Q?mhhpbTkU8bXSsNFF2E9hPT7pY3RUS/iMtgDn9/MeqFVZ3/I0mCNNj393ssRW?=
 =?us-ascii?Q?0Rxl5m/wo+iFTxP2I+/DN5tm2l04S2DBMlQCFzT4xXyJor7LutagRw+6J8gK?=
 =?us-ascii?Q?FdIotfDgU6OuImfJHnsJG1OIAmUGmEj9HE9iipp10vklWN+vBXJFs4UdqWk5?=
 =?us-ascii?Q?NM69WgCpdwnajQow3DCjUSIdeLvvzqhRdQKE5wY81o1j2JT7ag1tV6TKnUek?=
 =?us-ascii?Q?UoSVgep04yRiC9dzJDP0YlmAlz4O5+s+05NzOtpv0fULMNK4jywiNytSHD+1?=
 =?us-ascii?Q?baoq2yfe4AM092RxwUc16/Q27pudiOHMn3oHGd0OaR3mCwZQwxJzNYs+1SxT?=
 =?us-ascii?Q?fLt7n57Q5/dkoKOODik1V0c1S1HB2SM1HkrOdIXyREZaL9foSf+lnbLd0K/v?=
 =?us-ascii?Q?7r3KIKA5HfAGvQg0w+I9YMCJPb67NjIOyt9C1ENZXe5503yC8DCjhUBOy1ds?=
 =?us-ascii?Q?RNfkSC6w4BVLkOjPRQUsg0WQcMqb2/C1RRusW06fZNwbSruZCHL0EhDoc7+y?=
 =?us-ascii?Q?RsTM+M8qQbK9fptt9w2uCosclTMQlNBWKUWw40pYXziNIykPmfJUI0wnbyRx?=
 =?us-ascii?Q?vw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: /LWbT55qHOMzVVevmWb/cOsfziOHHPNFJAKW2GSlABRcfZHAVK7PfDMpZJW0TN7z4j1inIgx7eUnPu+AMUlSnnsgTnIQR9NFn0AlXNEOWCVKxDBdSsuuMUEga9wnJtObIiLqqZCr6PEKZnk2i7scmooCjHz3CyiBn32dTTjLYruaHJq1QHBqFLMdpJChsiF+A34QfBVt0NUxZcd8I8KlibXdBpWm/njQNLq8HlncNEhdr6tgFrGEZ4pPo3ZJzhGBDnc0fYAT1j4Yap76kmZf7moTtsjVazgaQB/K0g5UzATX3WEueh5ZU2Iis9Qc4kJJZ3DPc1iCU4pjn+zfl4f5WlwhQwkrTJMrDhfh4XI2W2yenJWGgeVHq6WqBCzPvJmOV1wHXrikh71KhWe4ZVuhuVbTFTCPjvUI0OlMf2uxcro4Ndb0mCzZeB1EPn8UxJWrmTzwZYzZ39WNfLEKztMjhhzfQVfMF3b5XDs234AAYV00ilKhZcxzB+a/8VvJ/nCy7eh1Z98sdRU3gcGXeV8spHbrWdNJw7ddKx/PXCY59AnSDA3Eo1tOJF7GKMxs/LI4cEGB0FU7XPsZyPOqe4mGVCbR6lSiOoH/thPn7f1+Dq8BcS/R1R7IlCHo5UZ77KF6e6FSMlPmP19z5UHsOPyKFD/nPSA1luhpODho91IZlxsAxIRWT6vwoSmePYFhBYdkU5Sr+EPWGi38BtukhzH1D+S8Cje9i2xTCaJz4zTmEfZG8fu4JiqhYK4Cr+i3DUdUnX99JMXnpxSBVaojbDeQ/1EWSkcY75ex5waswFVodpBm54DXmRYmBReE+057lZ6+g6I7Zdu8kCLr153HcQRU5LpTKfMiNR8SBAJGL30sZucwoTDr+yFSNWx/GQ0WLlhYW+bWCIVzxUg8T1Ew3tWvGg==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d25583d-e0f4-4448-babd-08db198c0c1a
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB6798.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2023 13:02:29.3670
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GO2tFq8ppdeWJQksfNK4kWV9+/I4Ohzxcf741vkK+2YXFRWy51lKburmIqUZbocXjdMoUDZnQAXK78WdxGSfBw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB7290
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-02-28_09,2023-02-28_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 bulkscore=0 adultscore=0
 mlxlogscore=999 suspectscore=0 phishscore=0 spamscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2302280105
X-Proofpoint-GUID: YbGzxvc8q62IY8r0N2apUa_4zxu1HaRA
X-Proofpoint-ORIG-GUID: YbGzxvc8q62IY8r0N2apUa_4zxu1HaRA
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since commit 8b41fc4454e ("kbuild: create modules.builtin without
Makefile.modbuiltin or tristate.conf"), MODULE_LICENSE declarations
are used to identify modules. As a consequence, uses of the macro
in non-modules will cause modprobe to misidentify their containing
object file as a module when it is not (false positives), and modprobe
might succeed rather than failing with a suitable error message.

So remove it in the files in this commit, none of which can be built as
modules.

Signed-off-by: Nick Alcock <nick.alcock@oracle.com>
Suggested-by: Luis Chamberlain <mcgrof@kernel.org>
Cc: Luis Chamberlain <mcgrof@kernel.org>
Cc: linux-modules@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: Hitomi Hasegawa <hasegawa-hitomi@fujitsu.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
---
 kernel/events/hw_breakpoint_test.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/kernel/events/hw_breakpoint_test.c b/kernel/events/hw_breakpoint_test.c
index c57610f52bb4d..2cfeeecf8de97 100644
--- a/kernel/events/hw_breakpoint_test.c
+++ b/kernel/events/hw_breakpoint_test.c
@@ -329,5 +329,4 @@ static struct kunit_suite hw_breakpoint_test_suite = {
 
 kunit_test_suites(&hw_breakpoint_test_suite);
 
-MODULE_LICENSE("GPL");
 MODULE_AUTHOR("Marco Elver <elver@google.com>");
-- 
2.39.1.268.g9de2f9a303

