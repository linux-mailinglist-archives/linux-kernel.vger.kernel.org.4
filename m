Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF3116A59CD
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Feb 2023 14:06:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231556AbjB1NGS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 08:06:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231222AbjB1NGI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 08:06:08 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 697CD2BEC4;
        Tue, 28 Feb 2023 05:05:25 -0800 (PST)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31S5wNYv028403;
        Tue, 28 Feb 2023 13:03:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=corp-2022-7-12;
 bh=7yho+QcMr7LVNv8Lp055fx0+uzU/j4kwF7WofAvte0E=;
 b=TeXc4Wl/PomAcz23sfrVuVvpMIyFE/vtJcQyQR9Xm0vYg30vfjlJ+m5dc5A75Ij5xfG+
 x8l+SnK+Y4O19JrXis11hgDe5+LbCTur1SQMhZRTAK+p+DHDxqi4qwmuqDPknh7qNfpp
 7hsj+QyeOZjiYkcLASuu3TIjwkpVekutK/uSaSz8Uh7FvobM8788qAXSqhuT8/GPPJZr
 FPLc+D8m2opyvI53WMO7MjWh1OZye9uhV0E9iPvfv8NkKAKhAFwPSxhb4SO7mStGkjBb
 wnypCBgEBDaAHfeatjpg2LIjIkdot6gQ/tvSZ5EOV3vXGiG8Cn+Mw3xx2JocKWs2MjER 2A== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3nyb72e3qb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 28 Feb 2023 13:03:23 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 31SCu1pZ013095;
        Tue, 28 Feb 2023 13:03:22 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2049.outbound.protection.outlook.com [104.47.74.49])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3ny8s6r9a0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 28 Feb 2023 13:03:22 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hs44Gp6DEqzc2ygJPxNqpaEYkeFqd3OAirzBPFnnzm7oJuN0VKRcSn4v5JDc2gH7hh7kMb/HixPwYiLxADmb5zt+EIC69NfbHxnA0pTFQr4TNT3LZ82eTf+i8GixpntTNTx7Dnn/DorqFZDZ714Py5CIZh5FGDv2rhWkmoBYMeb23isfmVZ4N+rN+taA9wa5dKwJzKDTGilAq9WT/Zu55F+g1MwRKihgk4ZJ/Oi6aWKE3CXdu4xcCe5FQxntuCSaw15O2G+D0mMq+BYgXZMPcnfFLubHzZPznq8ghjgDgMhqUx+yO3rmuEaSB1mACO/Xdkf/uKLTBiCoqKXpbFaV9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7yho+QcMr7LVNv8Lp055fx0+uzU/j4kwF7WofAvte0E=;
 b=WIdiEkXEEBWnpVD8tjKDxHsVpcQzBtad+nYjWMTtQFNkNnNNGg5nYiJjNEdezEzhtz/uK1euOfgTufRSuur1jKwv5MGh5p3cfm3tXotEfbaUxJmHPtPUFsIiXBHRDwlM9L/aDey/wONVTwCJ7u6oeyy1QYDHo8x4tGt5R4ENIMTVUOElWBIsdMGR0donv1hl2IGdD/nbzOon8ayhCDoy3LG+t+P1utooBJo+/Y3bA2Vha6Ahj/liHRjvObp9by/SQFr8LSyr6TJFZgthsgk7ivpnY3v+1mJA/7hRJtVAH3NtDFHq/Rt33ODwz7Jz9bmHUkgH/Gk0rRGzU4OBRcWZRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7yho+QcMr7LVNv8Lp055fx0+uzU/j4kwF7WofAvte0E=;
 b=Adp1J7XkRLMTz1OOIZh8Zj4UkLdZb45FGHnEjXlf64dKT6ve7/TxJeQqBukED4atku6N+67m+Wnt+1cUDD97wZIn2Y/9rXs4Kdm/DEBiJZ9Edf+4O4ZmArT3pbJaxCZNvxVu6TwCxKwAZOMHwDACnrXHOMTCCfxFHWL9OJip6fg=
Received: from DS0PR10MB6798.namprd10.prod.outlook.com (2603:10b6:8:13c::20)
 by SA2PR10MB4763.namprd10.prod.outlook.com (2603:10b6:806:117::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.17; Tue, 28 Feb
 2023 13:03:20 +0000
Received: from DS0PR10MB6798.namprd10.prod.outlook.com
 ([fe80::d0f7:e4fd:bd4:b760]) by DS0PR10MB6798.namprd10.prod.outlook.com
 ([fe80::d0f7:e4fd:bd4:b760%4]) with mapi id 15.20.6156.017; Tue, 28 Feb 2023
 13:03:19 +0000
From:   Nick Alcock <nick.alcock@oracle.com>
To:     mcgrof@kernel.org
Cc:     linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org,
        Hitomi Hasegawa <hasegawa-hitomi@fujitsu.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        Daire McNamara <daire.mcnamara@microchip.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        linux-riscv@lists.infradead.org, linux-clk@vger.kernel.org
Subject: [PATCH 12/20] clk: microchip: mpfs: remove MODULE_LICENSE in non-modules
Date:   Tue, 28 Feb 2023 13:02:07 +0000
Message-Id: <20230228130215.289081-13-nick.alcock@oracle.com>
X-Mailer: git-send-email 2.39.1.268.g9de2f9a303
In-Reply-To: <20230228130215.289081-1-nick.alcock@oracle.com>
References: <20230228130215.289081-1-nick.alcock@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P265CA0243.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:350::7) To DS0PR10MB6798.namprd10.prod.outlook.com
 (2603:10b6:8:13c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB6798:EE_|SA2PR10MB4763:EE_
X-MS-Office365-Filtering-Correlation-Id: a493fce7-85b3-4575-7ebf-08db198c2a29
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TdSglkgthXaOH5Gxsvc4r1zkzYp1T+hWMDC5b9RNSiyc9A39CtZPu6pdfIjJm6IScfLIN0tsr6a3/ls1OTMZ3Elx37F4xYi3xBpHWoheZi+tbOJ+xU/RsrKLVNYKJjjIs+hQPjTUizX0ulsrs8YLrJ0w1ZL+X3PSpWL9572Oxq/U3K9Qu2mHoOFC+P+HfK12fBh34U0/jb7yxoY/mMgYhHPyPWMMGvNC81THl6tkv5/Ljg0/us5Bg+cAIpR5HmuFZE5RVHoS7F/PcPtPVeJmIwsoA9GliS0kR+3wUEuOECEN6E7PC45Drh0Qg3XymRT9csM8op0MF8RoKkiXxTWXFklkd5I5fc+iPbcSVcEbmoG6CTtaOafEz2o8vg+lPK0bb2QoIyIS923xCgpnuS9Df9bTfalbPwQGp+F+rP94Xk7jTGX6KNZmmMREvnZd4ucNg6bX+egLVn/nbcH6BA3jILijXOZBYrUa/Ul1khEVgi4StaDaqCrCPtzDWqeKdhkFfnszRIMBmoktDLR61gUf9oDeK2M9Z45szi+AU4EEt9kohyJ48ckOGMsjeNVEwXnZKt03GcpiXpodvdxw9SVAlL5ABZ8VbpWM1Ge3O3NGYGvRQuukTQKjzvkNngDODRGEE/+k9aEDb8/CJZd0WeCJLQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB6798.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(39860400002)(366004)(136003)(376002)(396003)(346002)(451199018)(66946007)(6506007)(66476007)(66556008)(6666004)(316002)(6512007)(1076003)(186003)(54906003)(2906002)(478600001)(86362001)(6486002)(36756003)(83380400001)(5660300002)(44832011)(41300700001)(7416002)(8936002)(8676002)(6916009)(4326008)(2616005)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ZJob1WcAj9NtiEiyOqkK8jKwM9gVjpbp5Iy5/ce3BzcMzDzCC2lHC08mb83x?=
 =?us-ascii?Q?n6Hnlf3FN7ZVb50DPM7qpAp5VIlNsdnT0ZgXi01TMnrT7421IWJfRLcLigFX?=
 =?us-ascii?Q?y0U8zcTqCDraultvzDRkF8L/9OOOpKFJLvkgX+B1BXjGAsnLQGZ8YCXvj6dJ?=
 =?us-ascii?Q?ENIGEwgLkyvfpJIqV/PFiYNLXd7mOmdbFaB2ePjIfLNjsmo+aoFo8H6qmLb6?=
 =?us-ascii?Q?hJdNzhU22hhNbvf1DO87rZJSYOCFlk6kiMscWrQvNDLSa7CNeb3NKi6V44ao?=
 =?us-ascii?Q?SkJQT14N8X3VCK51yd+j0R12vgmlOsaEGMHJuA2mlUX93OY+0pzkmd03df82?=
 =?us-ascii?Q?a5vP4Y6hIaAYFsgkn465HvaXWClg5j2ySmKx7zM6QYgsQEY/aDCLfNEhow05?=
 =?us-ascii?Q?4ZNrVcOJcheCujh/3H8Epm+6Ww82tXpQcBrzwPrBhjxNNh3HVdYgYUcEM2tZ?=
 =?us-ascii?Q?iaciwpNfFyLxCTjeaKEndHwE4HIfoJ+l+b8mkeEnkSmz9aE+ejAhUIn0fS4I?=
 =?us-ascii?Q?8jA3bOMJHzEmNwcyxRqUOK7B16SjDmiJwUkAgCzs2kAig3zaDBPY3NnJVRjY?=
 =?us-ascii?Q?oF1iID876zEdAfmpnpm+7ingpG8iw/e0qD9GpSp2KaAOcNFtWxSLJ12tzwz5?=
 =?us-ascii?Q?M5O6OgsM7JbcnlvOR4u0AgFNphOKKk1HF9Ug31H4h4Dt2aAPf0RGPO03dtuT?=
 =?us-ascii?Q?VCPWwFzHJi+z1auJCBXuXvO3BYWUrOEkA9bbL4Mi7iUlKwVuDlAsR2szEeTh?=
 =?us-ascii?Q?ZRcOF0BYbcn9JeCUK/xea8mVuEmbv7NlpJQeDcrKrgW/y6szeR/Y6pYkxkSJ?=
 =?us-ascii?Q?mwMuH1mHJoMLe8US05kYQi19QYL4uGmZ0v7qyU1gfWj7Uv4Fs4WDTyNX3QeQ?=
 =?us-ascii?Q?UyCpcMVVXYy0eMKbuUhmPeLBqHgst2z0sjug5tqfinRuhfoliogpBgOxB7ml?=
 =?us-ascii?Q?pXiMVjMW3NIidjMUmYEPDl2Xfbf8Z8iWzPdIkiZQ+VnR8OgLGogNJBm1KCPF?=
 =?us-ascii?Q?Da9mwrr1EJV19tj/XLxfKCX0QnQR1epyr8AHIiMctmD8/7SBMLY19GF8P35t?=
 =?us-ascii?Q?taZB8lIQHLfJhw/IG9TyrEb5hMlOlr78r7exWFj+Ep8SKRGsXnJgvRahQ4zn?=
 =?us-ascii?Q?74xjfNhHTXVjeDsYoNPQSNkh3j6WzbSkkWwCu3aqdbdm4rBrvnuQ0zIC1mJ+?=
 =?us-ascii?Q?OL545mFaegUeuTxQpwedQmn82BjZVi3d8h/fbr3Fg3E/U0o2aG/jcP0Maks+?=
 =?us-ascii?Q?PQFV4bWCDEdrAcPk1UvWYMY7rJXCPT81dpw7y5f6wl3Dzyu/mPpacCEyks8T?=
 =?us-ascii?Q?RAt747ULsYgVGY2wMWcwSW7XHmTiahpjzotEzIcps1jNihOlYHrMF6KD5bL3?=
 =?us-ascii?Q?6UDZhmXCXwCZrTRAwQvVLv0iCIKR0HC114diGpVc6HAZgB5PDsCo7KCv7Go2?=
 =?us-ascii?Q?71dqGnJHtPd/9b71IRaQ4oaurrAILAitnp3MLuRle7k5pLMOZgMspQ0GsRcm?=
 =?us-ascii?Q?ouMOtV/VCtGEaKMT/T0sfkLWFywLjNpVhAYcpwdv3DQVK1TJoEz8v+W/F2rw?=
 =?us-ascii?Q?wxNdRjmTlFx9rSBNGKCVvWLn0Pidso3VIciS9X6D5zY8jNzYCNUp/KzkagXD?=
 =?us-ascii?Q?Z7fiPEXzZgKxH4FdMiKRgng=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?7cg0swrKbKNyh2cAiiJXZbY7llkzT9cLLwyFDWzmClLB6zXUMy7FunpE6KQ+?=
 =?us-ascii?Q?7/o+9bn4ayagfoI/YpwFn180n1eeYhUgY8oq9n+2iSEtKFH7J8QiQyn2m4Zs?=
 =?us-ascii?Q?FictQI1hLHOa7QQ3FcjXpvUFjLl4sqKKxaX2zwXjV6FTJJa4WOYmmZUBs2QI?=
 =?us-ascii?Q?OvSSNudTCCEEXRL9uvatWES2lt41u+sJRvfnNMoEmUh2KtW6MJnV9KpUFNVi?=
 =?us-ascii?Q?hxaSmVDfpshIMFi88ISNqhCU1SfjYmoKLmcgB9ny7g2R2EZcbGGZEX4LyvJd?=
 =?us-ascii?Q?HwBZZfVa/bg4Tsbp7HKSEBjcrO5et5cossLJ32a2Biw+IjExJoVLb6u3wXqg?=
 =?us-ascii?Q?vR/0d1LEqXjhZBE5pHlAM1P/lpWHV05e2lRrOF8r+Zll45Dip+LAcOuxP2rJ?=
 =?us-ascii?Q?2+DT2bqNf/ubF5xi2/opA8lOiBbhcWsvugdf5RBimbTOG/jm9yYICwpkzau8?=
 =?us-ascii?Q?SWNUt68KGbz+s+Tgco+Te3+xZk1IPFRNB9zpdq92EQCrK/epsB0wmYYqPdUa?=
 =?us-ascii?Q?Gq+QYvQ3FNdJEUc7wdu7roS1xEVGMkqQ0Imb1Dju2yy+8fg1WwwRNU5yHkgd?=
 =?us-ascii?Q?9pfpHmDihZROaAmxdeie7JDgppR7o8WX6R7E1G1Ia31RJhD3Sp0+0kqucJmm?=
 =?us-ascii?Q?80xIfiS7S3EY5k+DGBLdNWuO8mE2dyIARiuByDfq6voddBxF3SIZpfk61PTH?=
 =?us-ascii?Q?Uhl5Fxa96DLzqDF96bm9v5y71ujS6CuM8IqAU44jx8DdCc2+P0yBgCtYlQ4I?=
 =?us-ascii?Q?QCC33dFuFKJzKzxMoA6SyWJnUa5OmY0w3TT4PGdylffLovZvAR82yF3tK+Sm?=
 =?us-ascii?Q?gQQaVdgroxcCkM9geZpjlX+dzNmMRdA9A+mKf7xuDHOVjDcvCppq/lN4PYZk?=
 =?us-ascii?Q?8iCYHH77w8e5cgwqMIWsUEHmLStiPD4D46VhASWoetb36h/djBnP/Po1qDVz?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a493fce7-85b3-4575-7ebf-08db198c2a29
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB6798.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2023 13:03:19.8254
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: h3pq4gMshtsP4iQkflMZoV4lh2snILiFXzd5nuZnWLeZqoyg1dbKu1iublGSmE4ZlhyjZUI5E3QiJYGcfJxerw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4763
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-02-28_09,2023-02-28_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 malwarescore=0 spamscore=0
 mlxscore=0 phishscore=0 suspectscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2302280106
X-Proofpoint-ORIG-GUID: FQJGMxjAaRUMUeIeUVnF5dgh85Jne6c0
X-Proofpoint-GUID: FQJGMxjAaRUMUeIeUVnF5dgh85Jne6c0
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
Cc: Conor Dooley <conor.dooley@microchip.com>
Cc: Daire McNamara <daire.mcnamara@microchip.com>
Cc: Michael Turquette <mturquette@baylibre.com>
Cc: Stephen Boyd <sboyd@kernel.org>
Cc: linux-riscv@lists.infradead.org
Cc: linux-clk@vger.kernel.org
---
 drivers/clk/microchip/clk-mpfs.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/clk/microchip/clk-mpfs.c b/drivers/clk/microchip/clk-mpfs.c
index 4f0a19db7ed74..d85b345f4c08d 100644
--- a/drivers/clk/microchip/clk-mpfs.c
+++ b/drivers/clk/microchip/clk-mpfs.c
@@ -513,4 +513,3 @@ MODULE_DESCRIPTION("Microchip PolarFire SoC Clock Driver");
 MODULE_AUTHOR("Padmarao Begari <padmarao.begari@microchip.com>");
 MODULE_AUTHOR("Daire McNamara <daire.mcnamara@microchip.com>");
 MODULE_AUTHOR("Conor Dooley <conor.dooley@microchip.com>");
-MODULE_LICENSE("GPL");
-- 
2.39.1.268.g9de2f9a303

