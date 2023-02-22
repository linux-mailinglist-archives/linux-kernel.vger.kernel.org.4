Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE13B69F44A
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Feb 2023 13:17:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231974AbjBVMRy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Feb 2023 07:17:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231976AbjBVMRh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Feb 2023 07:17:37 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF6FF3B0C8;
        Wed, 22 Feb 2023 04:16:25 -0800 (PST)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31M8xFie029564;
        Wed, 22 Feb 2023 12:15:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=corp-2022-7-12;
 bh=L6EaaOhVreH1kplkXI6IAzfq5fr/kIPICDShG8yFjFk=;
 b=oTxs9EfUwaMn7yCap2ahkNoC6UbRLMerY31ZxqgKDreLuxTCj4p4ElWbgXpO6U82BBuQ
 ohVStc3GFEI9MB39GsbHQZhalnkF1eky/NiR1xuMIC7d+pm3TF4jT/v3/iXSGz5Nz3hW
 OxMwR4eOEmaWwP50nw4iHUPCpwHC2x7+CmnilVGzwcV1gJ+d8fmCJhFt5m1wwMypODNF
 pTwXOhbbOAn/0uvLtY6zJ5enxlzm6+9jp6+Pmvs44v3WLJ+WlVbQCE8YYMV+JPj9VTJ0
 2d7KmfLiqjKz8dnFP46IyODajJaxUnKFsjlTplt5bLJajAP/zwKZnVopChCo0+Ie7e3v HA== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ntn3dqqdk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 22 Feb 2023 12:15:58 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 31MBAucs027301;
        Wed, 22 Feb 2023 12:15:57 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2177.outbound.protection.outlook.com [104.47.59.177])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3ntn46qyr1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 22 Feb 2023 12:15:57 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TTkBX1N7/vgfySNmnCLMF2/eZ0CPIqbdcZAGq/f5k2Z3XuFfAEim5+nXclKQDumymKJ5Tg3qfVHcArFB8r01TLLp0+pRXiAB3z0hTgsf6G3q+vs52INcRvAu+z8EnEWyF+0feRL3KjIomTXDuKjlMeIDRPXh+5mz20WNkKA/qP4tAjnOe2GDiu/m5cSsJtA9jIWBrOdQmtkTh2Q0T4Gv1vgkY34LlDRBxbatrI9uSDzVdC8ZeexgYGnirbVjYqybvAnlftARFjwy9HO3dm0iyZsOOPk0dykeWXVgoITh0VuWQ1yrV0QZwhLR9RhJDhRsUMydywhce2SsGF9tx8TfDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L6EaaOhVreH1kplkXI6IAzfq5fr/kIPICDShG8yFjFk=;
 b=O8q4wgT0tmydr1TeGm3cbghsk+rVLVMApB/f97+ys5nqb58RfPDZ9pgsqrlnx/ovPBxxNdYWjTjGupCqbP3+s698qbGBcWPfBwm+LHXsAiz0G1Q1V8dQ25/LPDnDAcc4KtBXOMB7WQ/uGAx2RhEtdhyV5qJ+rJcniq403dH9q2klYHGDp34mpQRpeBi5d6ZnxgLy8c7YoKqDErPEWnJ4W/dS0jLthFyhSMB1mwno1eYDRIWuoKKuQdlmdvjxROGyPcYoGcdbz4D7RGVjEmqDYMkPnwCcya2kqOTGPJRK0IDwD4LQnupzYWJBMt/AMHMtCJUkQXsQJG6E4OrWuCiv6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L6EaaOhVreH1kplkXI6IAzfq5fr/kIPICDShG8yFjFk=;
 b=qY9EnoqlOcHBk2kBf+WugHyeIZUBekN8go68KV3AR0mUz3pr15Dm4SXMwrQN0GK9hLKusPqG/qrRsqj6no+N9aUJ587trOUP0fDi/dzmgGcKu6YiCLmYdnWpCbcGKWwsCvOgiBCXE8zS6Qqd2NEyh+9cYJi0eV+7z3FfyLNgdwc=
Received: from DS0PR10MB6798.namprd10.prod.outlook.com (2603:10b6:8:13c::20)
 by PH8PR10MB6412.namprd10.prod.outlook.com (2603:10b6:510:1c7::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.17; Wed, 22 Feb
 2023 12:15:55 +0000
Received: from DS0PR10MB6798.namprd10.prod.outlook.com
 ([fe80::d0f7:e4fd:bd4:b760]) by DS0PR10MB6798.namprd10.prod.outlook.com
 ([fe80::d0f7:e4fd:bd4:b760%3]) with mapi id 15.20.6134.019; Wed, 22 Feb 2023
 12:15:55 +0000
From:   Nick Alcock <nick.alcock@oracle.com>
To:     mcgrof@kernel.org
Cc:     linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org,
        Hitomi Hasegawa <hasegawa-hitomi@fujitsu.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        linux-clk@vger.kernel.org, linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH 11/27] kbuild, clk: bcm2835: remove MODULE_LICENSE in non-modules
Date:   Wed, 22 Feb 2023 12:14:37 +0000
Message-Id: <20230222121453.91915-12-nick.alcock@oracle.com>
X-Mailer: git-send-email 2.39.1.268.g9de2f9a303
In-Reply-To: <20230222121453.91915-1-nick.alcock@oracle.com>
References: <20230222121453.91915-1-nick.alcock@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO2P265CA0059.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:60::23) To DS0PR10MB6798.namprd10.prod.outlook.com
 (2603:10b6:8:13c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB6798:EE_|PH8PR10MB6412:EE_
X-MS-Office365-Filtering-Correlation-Id: d66c9306-5c38-4fa6-2b19-08db14ce8bff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: l/VB7D+kcH71969uj8f27nEhVqIbKUAfptc9CgT49PiAWR+Y7+YrRc5CSnVcQORgqDQGhFdiewhEZ27Oqs+8gPIppXEuq8PLhhT+TpiGFvfNf5ayki7E+M8gTSgQTP36wZeZuGDU18YW659xl1WqAaFtR//3gR12LfYMToVa6FKy0BpoGtKO5kdRq9dk/xFa6TolKqopXYsdhtVy5R2hcGVbMYEvWRBspM8PnRW+HsGrsHzkngkOEc3BvI4SCTmeDbSgr6Ixw1FFKAuvJnIP5Mj4dkBJEgRj/8Sg02pgcjo9w41zLFZSOLSXI+WHzWBxmrMLomBTKIVpZnGVwz/0RrSKtRxdjjJcUMP+iS0J9ulfWMHY5k3nwxuDt1ZYEYpT3cnMgTB0s9ZGOtnVYh0moyIfXvr9yO8VRzckAYXYzIsiZve8xg0tJfDO6vvKwE5Jml/1SKGRGGKu+qda7Ay9bQ6AyjUsa6s0eGpRpMkTT12ly013lScJWOL0ClKsgpTj5bZKfOdRnV6D/xkv4iMVbtNMA/FWOHtRyd+V1VDmhufwAxfF37uqePKEGHWrbeoNemIai2cOjNNJAY+4m3ANduxDrSPisfyIuuy5xSQSZjmvz2pXqYme0qoKgwpQXgBw3AMYymovD/SW5VkILmwoxg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB6798.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(346002)(136003)(366004)(396003)(39860400002)(376002)(451199018)(478600001)(86362001)(54906003)(2616005)(6512007)(4326008)(316002)(6666004)(6486002)(1076003)(6506007)(186003)(44832011)(7416002)(36756003)(5660300002)(8676002)(38100700002)(66556008)(66946007)(41300700001)(66476007)(8936002)(83380400001)(6916009)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?WOXjvCfsGec33crg6tEat6RGEgHLiLDyvWb4cSAHASCGX2JDG6YCECWiZNm2?=
 =?us-ascii?Q?DKA80HtnWmjxXQ6oAELAyNh7KtFHXnatAPOk8Rel92pKsObKjMmbkMi9TPfH?=
 =?us-ascii?Q?7xeECAMcHAjVy0AspwWvfVDNiQDZ2Z+Vcs3h7VKpfMY1sHK+XyXBy4uTz2KK?=
 =?us-ascii?Q?DWWUd7BQtkkdPYP6HafJiecH7OfEjh8F3g7y3WAJxtiaYRxp511sprcRgK6S?=
 =?us-ascii?Q?Nsol8Hv9H1lrgut2ZGstwV5kuqMnQsxwhjY1x0qp54wwiukKQWlt1B6m3iig?=
 =?us-ascii?Q?nn/u80dHv0P3+/qI0LKxWH99MqZgN9nZHLq4DrtoOOCqIQmkmPaRfvLV6/na?=
 =?us-ascii?Q?h8guLF51nDhVISzd16gmk2sChCKcjsN5vMwJNLVa4K14U+Kk5AJdVQy9LCbM?=
 =?us-ascii?Q?bFvQWOwu8mmlIgm46FeZnb0q3Uj6cY0eHFmhblsGqse5CJ9To/5zW4IEIaKW?=
 =?us-ascii?Q?KjH++iQpU9ZDiCIsi8QYnc4TFPGZoyb/WDwAxFlBtVS/LVRnXhDiAZWYZ5QR?=
 =?us-ascii?Q?LSQ7CyusRB/crnlgVql24Y33a7UEoY3Fx51pUrQfIjBwHFH6J3X8gC1ailjW?=
 =?us-ascii?Q?D9jt/xU+DAcOYBYRpH0vewFWp74/PdfqKCKjSKZ419qvvShUhX70ZleuzUlG?=
 =?us-ascii?Q?BJm7Ie3wI6JYmHG3VvN4UGZzs2b4ruw6YwITi0xlehHlRA/zFYnPAfPqSkKT?=
 =?us-ascii?Q?pOlTdGIJPhl1RTZJVmp3mJbGMD7JhQ6ZAXiEaMI/2EIM4Nd8fq/Zeub4MluJ?=
 =?us-ascii?Q?3Kanc9di9qI3tKcWy7wXIpbT+JJhGl9t9FuimCFyuDt8hgAshCwdnrtCB6Ng?=
 =?us-ascii?Q?9YJb8QsZC/u89HiuHUBzMAcfHYKdooHvftXBw6p+dIcfhlvh9ou3m7oiq/r0?=
 =?us-ascii?Q?TpYbmkssV5qbfIjUuexCJBXQc0dxK5phdkAJQdX4EpbhIxKTwgqUL0jKuTdv?=
 =?us-ascii?Q?t+ryavIQl4p/u/szLqtxgBScJiZFyBny7thajc5x81KaWVor5rLvWIHR3ynt?=
 =?us-ascii?Q?miaaZTgnmoWwBC8jSD6cCvUxce3YYUS+rmzPokiRAExwpfyzmNnM/OTx1eLw?=
 =?us-ascii?Q?azzht1srPhoVyTuqQqoUi74VCMRHJB2p1B81xRB8xnuv/YFbUQzaQtcnvram?=
 =?us-ascii?Q?is29DTY93f0U/dIP00+zKfy1XSA5qinLbuS0EDDwSneyuFDIq3K8aLGdkHg8?=
 =?us-ascii?Q?Vld22rwoJd4RKWR6FS3q4BWT1vT9aXrIn6XEC1G55oN+JvJUXMeiCuxwlvVR?=
 =?us-ascii?Q?S2y0N3+Gk1/+el8EqZSAeu+ekGhVDIWuiXiZ6K/yskStXu1sX+vYPm8z5yBr?=
 =?us-ascii?Q?i9aDQDYHNKKlvW58UFrM111hVi26clPnnRDjAaulRCUuHSWP00csot1ThPKU?=
 =?us-ascii?Q?rRMR3qTwo2B4r19y+Nc9opuLZK85NvNB0pBI2dIn2pQkhzI5cV2utEFYFZT4?=
 =?us-ascii?Q?7Gbdm4H1tEwgOrB24tw9paoGx6YJGbb1bgCJqMosloOeV33dM8mBStpQTL7F?=
 =?us-ascii?Q?L4ZFuSKT+xw8X1KG5xW7eIQO5evaDWv2i2e4ezAKHl9IAq1bC7gblfUCcFNX?=
 =?us-ascii?Q?gouSSF4QJQgRjGx547/XPqIKcRe3K1kMozJmYG/j9A0V0JRSQLcu70qFrBLJ?=
 =?us-ascii?Q?s/jcCZA1Xy5qU1I10P8jwHo=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?GUtncShnOFp0kVVjd76WUW1f2yMleO7cFxNlu8R5kGvj5qjtE0ftnCVk2eIV?=
 =?us-ascii?Q?uv3lAnOIxvjW1QqS56KLwVmUPDiGdk6hSn2UwxFW2lzJ1OW8Cx1fHUE5jVjV?=
 =?us-ascii?Q?RGMFYf9aWdBJ4isURcd3GBJhQbcm/IsTGSVBMgRKce0ycsetFNJStb8dqIvL?=
 =?us-ascii?Q?LNsuDCnJ4KLWCvDMNoUruiWSeH/5lt0Hh8F9/6gp0opAgneHL+s34obXkKj8?=
 =?us-ascii?Q?o1NB9jc+KJ8v4TVJVXNWr4V+Hc93w//kufmMH9neC5RJaU6upKl8QwS4BbSq?=
 =?us-ascii?Q?WkEtS6izp2hRE4XoCfiwbGGqnepE8kjJKR38kWOyxy9ZxXAsrnCBaiDgpdPn?=
 =?us-ascii?Q?Mk4hv6RZaqXMMrL8teh1nrZVqoqWrljEBkLJ4AHM2B2CLuPYYTmlAPgOaOOx?=
 =?us-ascii?Q?98jZ3kfW0i1ZdcFujtbEZcvCnAsK7FHSOi5iGVpDxbKm9Hg5ic6/TbjyLvRW?=
 =?us-ascii?Q?bwdI+XYKqOjPn5Wpd2ie14g89cD4adFf0rOkj/cROJv9KxAHqARGCmKIujju?=
 =?us-ascii?Q?c3Y/lB/euA3iCnGiXAvm2L9qOlw1D1UrkjQ7bHwTMpbabeuXM9Y6KCUV8V/X?=
 =?us-ascii?Q?ps9N8xl46KigE+qPhup8/B2dI0DD4ehtM/0Lqqvpfpv3+gANXt2V51Qp9/yf?=
 =?us-ascii?Q?CFsLyNfgdC1jJE3/1dwbx4cBJ9/HRdLuJ/RT4Kbupvd4wi+q/ZQoiEElYRPO?=
 =?us-ascii?Q?efxzxytqPJTDgOBL/wBzSQIjSK+cWSviNEgiZR95L/Ylqop643tE5Rqr2C1I?=
 =?us-ascii?Q?9kUaBhJV3Z3s0nhrEbipffUFdWo1cntHgEVffFAJCjrk6FaRW0ByyfTXpnAE?=
 =?us-ascii?Q?TZI/Ff3ud8HsKxRnQESyOz1AeQS22wx0j1uUax7klwCbgu4ME7w9n7z2dYGS?=
 =?us-ascii?Q?SLTDPvvYoP8J4P0byiKln7hN36KWrPHmhNkxugLgj45t6vG54HMFcHaPzgFA?=
 =?us-ascii?Q?XR1vfUEcA19I61gVob71a9+u0BnG6hHUb/WiIAWkS44=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d66c9306-5c38-4fa6-2b19-08db14ce8bff
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB6798.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Feb 2023 12:15:54.9819
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hLxYdFI9dI/OX+pfb6N/3VXtyqLUzH3Eu8tZFe1oLLHGlnH2jYZweyfhTkvJduattbgh3ZxDV3EntP/RNOIROA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR10MB6412
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-22_05,2023-02-22_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0
 mlxlogscore=999 bulkscore=0 suspectscore=0 mlxscore=0 spamscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302220108
X-Proofpoint-GUID: D7ZzeOBWGOXnKjlyCmjvtBZxZvU6DuaS
X-Proofpoint-ORIG-GUID: D7ZzeOBWGOXnKjlyCmjvtBZxZvU6DuaS
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
Cc: Michael Turquette <mturquette@baylibre.com>
Cc: Stephen Boyd <sboyd@kernel.org>
Cc: Florian Fainelli <f.fainelli@gmail.com>
Cc: Ray Jui <rjui@broadcom.com>
Cc: Scott Branden <sbranden@broadcom.com>
Cc: linux-clk@vger.kernel.org
Cc: linux-rpi-kernel@lists.infradead.org
Cc: linux-arm-kernel@lists.infradead.org
---
 drivers/clk/bcm/clk-bcm2835-aux.c | 1 -
 drivers/clk/bcm/clk-bcm2835.c     | 1 -
 2 files changed, 2 deletions(-)

diff --git a/drivers/clk/bcm/clk-bcm2835-aux.c b/drivers/clk/bcm/clk-bcm2835-aux.c
index 290a2846a86b..0fafa5cba442 100644
--- a/drivers/clk/bcm/clk-bcm2835-aux.c
+++ b/drivers/clk/bcm/clk-bcm2835-aux.c
@@ -69,4 +69,3 @@ builtin_platform_driver(bcm2835_aux_clk_driver);
 
 MODULE_AUTHOR("Eric Anholt <eric@anholt.net>");
 MODULE_DESCRIPTION("BCM2835 auxiliary peripheral clock driver");
-MODULE_LICENSE("GPL");
diff --git a/drivers/clk/bcm/clk-bcm2835.c b/drivers/clk/bcm/clk-bcm2835.c
index e74fe6219d14..8dc476ef5bf9 100644
--- a/drivers/clk/bcm/clk-bcm2835.c
+++ b/drivers/clk/bcm/clk-bcm2835.c
@@ -2350,4 +2350,3 @@ builtin_platform_driver(bcm2835_clk_driver);
 
 MODULE_AUTHOR("Eric Anholt <eric@anholt.net>");
 MODULE_DESCRIPTION("BCM2835 clock driver");
-MODULE_LICENSE("GPL");
-- 
2.39.1.268.g9de2f9a303

