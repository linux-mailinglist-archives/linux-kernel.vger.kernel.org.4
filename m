Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FC7A69F4C0
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Feb 2023 13:39:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231989AbjBVMjY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Feb 2023 07:39:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230440AbjBVMjV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Feb 2023 07:39:21 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 082D42709;
        Wed, 22 Feb 2023 04:39:21 -0800 (PST)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31M8xHEP002728;
        Wed, 22 Feb 2023 12:16:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=corp-2022-7-12;
 bh=RxG6qkKpenjaeCQXI0DrkzFZCGFZpX5/xGj52ap59zk=;
 b=p5PRrOsBDEyX9FQDw3RHXwuvAWpVSKx2OJmBOC56Z3Hmw2WkW2xqDC5cvNf4kGfelCGR
 4nbogl9B4z19OWL9FU60tcDGPY0ywTrJe0+sjYLSXwMUI4ZJjD4C6ZLXHKrsX+Itt2Ab
 y/wpPl3EKnCfRKLZ9lwKgl+GQ48pr3/STgRAtbzXsIQIwssd5GfXUwK+pXKW0EyZsHGM
 oZX6ZAHWajc+Cc+rT0XghpCtLC5F9TQ36vFS3RpKKoJKbg2vbZzkl2P6BFb++6zLtcO2
 ZZByNGZl96Ymb4c3fvqkBYdlT5MYW4NZ1u85zgYtd8uZFbMNztY1OkaQ6borg5WmekvD eg== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ntpja7n8s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 22 Feb 2023 12:16:10 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 31MBVZuk007051;
        Wed, 22 Feb 2023 12:16:09 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2174.outbound.protection.outlook.com [104.47.59.174])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3ntn4d211r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 22 Feb 2023 12:16:08 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Uvllumb2N7hWv0chzpNt0i4lHz+/gd8TfRvres4hRBVj+oqbsADqVnpugWM5QhPS5jilTuzE08Ibs5EM0FLBbwTBzzMq3Vwk1gm+bTEVpoIYsMhO7n2Vp20B1RUbYF+gIXoqN/QUhRiygIABJ0qLdU9Ak/zqei6ZZFfqn3hVQOZX959J8P/+qhCw6sC7hoEB52HRYbGzPWPSjwlXUrEUvGYQuPRR0JtDYD0Pa8bRbottj8mdLclVvUcOPywLMvC1dLxwPXIFHcNX6m6txJ7X8umA6TjKscd0oJdWMYTvCfxCxKN3uI8odl/jLEeNCjWoY6c2uVqr84ELxdT3iUWpbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RxG6qkKpenjaeCQXI0DrkzFZCGFZpX5/xGj52ap59zk=;
 b=a9sIob4BlFP5c6lnPVShjCA+UwWFZrWhRwMl5z5ZoaNmK8gAILz/X/SdKrLp++fVzWo31U/lest8Nzh/6VKKPo2DBwzkoFOSl8HZvhRfrbJwE+Y7h197hVH0TKd+WwYmOFfpdO3yvflb4iaB4SZZFKanob3qhBGN9P2Uj0B3kFiM7UKZxWP/eWhXzww/LL1RHD9cqD+hRUK32slioKSY+tuffXJKkwbOqn5i0YMVo2G7VZfYbxbPbTeUaJu16c2husyYZsdMc8p+TRta9R8b+mmvUhokamnI2poJU1j885YGk5kMoCYbu+MM+hBbQJU9LmmSugZO7TQNTWehB+fizA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RxG6qkKpenjaeCQXI0DrkzFZCGFZpX5/xGj52ap59zk=;
 b=mYLqKntIm5uiXVwUuUGJEGvjOqLf+vIGxnQ5VAKgFZ5F3ckXusfEJPXo465XgHu7NIF8sXD3UlSHH4HQvrRzPkRjnhkWtwx4vq2aH5Y537nNHA8dI59lxF88bdlvJTirn6jyf4B1Ga5ww+kZVoFoEKYnyIRZ0DClQv6HaDBrcV0=
Received: from DS0PR10MB6798.namprd10.prod.outlook.com (2603:10b6:8:13c::20)
 by IA1PR10MB6805.namprd10.prod.outlook.com (2603:10b6:208:42b::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.15; Wed, 22 Feb
 2023 12:16:06 +0000
Received: from DS0PR10MB6798.namprd10.prod.outlook.com
 ([fe80::d0f7:e4fd:bd4:b760]) by DS0PR10MB6798.namprd10.prod.outlook.com
 ([fe80::d0f7:e4fd:bd4:b760%3]) with mapi id 15.20.6134.019; Wed, 22 Feb 2023
 12:16:06 +0000
From:   Nick Alcock <nick.alcock@oracle.com>
To:     mcgrof@kernel.org
Cc:     linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org,
        Hitomi Hasegawa <hasegawa-hitomi@fujitsu.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org
Subject: [PATCH 14/27] kbuild, cpufreq: tegra124: remove MODULE_LICENSE in non-modules
Date:   Wed, 22 Feb 2023 12:14:40 +0000
Message-Id: <20230222121453.91915-15-nick.alcock@oracle.com>
X-Mailer: git-send-email 2.39.1.268.g9de2f9a303
In-Reply-To: <20230222121453.91915-1-nick.alcock@oracle.com>
References: <20230222121453.91915-1-nick.alcock@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P265CA0276.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:37a::16) To DS0PR10MB6798.namprd10.prod.outlook.com
 (2603:10b6:8:13c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB6798:EE_|IA1PR10MB6805:EE_
X-MS-Office365-Filtering-Correlation-Id: 019b094f-78c3-4eab-e93f-08db14ce930e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pX+2wStaY0yQdxuOn52+UoemkcGx0nyf/Rey89BG/fP615hd/GNjyMd92OaPDmGJ9gUz1uFG5dGejkKkrtL/ic4rjUejZbVTdJkutPI33jvAmq2jWOHhFY4II/uisaEmAMCayook5rD8xBw49+MPNf8ivINWOWFxQ9Qxzk0MmjrhmfJlyWJ+ZZC5y4kGz/AmyKkGjKrwgqqNYTPv5RXE+3JtHRfbJLwkpr8HC6nia1RFv+mKybmpZLoO9XOL4WnctLMe3gSGczrXngBOCbGAa6vdKQ++2J8Tr4ZcwHNQAtOdqlxLQCWmw5Dzvgva6tJoQSfi3MS0cc/hpe2T9JcndnypHyP3zO46cG38hSWSw8AePuE/AbcZQhDH+EN33bRhOqGYz899L4wyGutJkIX48EliHzsIHGEFiKNl+5H61PkCTEG9FMEzZHd3f6ajQmjQ4YTXvNGQs5WK6sW5/vZbXSOjPK6oXZ63wLUNkhYS5RPc1dOkgjgZXVgeWsrLL5AITI3b52Bk6lZBO1mCMVMaNCwBem2yOhUpuWDHFysDGa6IoYb/46uFb9uRDhbZ3iMOOXsrAM3ppv6cBjlwOiE8BguHK8QRRUl5WExlBXRF1+yuvd5s+5Q/8f8SDnyublFFg+xGcf7ZCVpjPVJ70Z1YPA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB6798.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(39860400002)(346002)(376002)(396003)(366004)(136003)(451199018)(7416002)(36756003)(5660300002)(44832011)(83380400001)(2616005)(6512007)(478600001)(6486002)(6666004)(6506007)(186003)(6916009)(66476007)(8936002)(66556008)(4326008)(66946007)(86362001)(41300700001)(8676002)(54906003)(1076003)(38100700002)(2906002)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?LO7RLB00e7G3Aw3eQ8KFF9PQwDGnA9qw+6LAAI9RRnhrP2nPsJB3M1EAw0jQ?=
 =?us-ascii?Q?17KdQUyp/fGHH3ud+WLI6ofiqBlF7fmF/n9o7XElIlegQTAaIFYeVTLYrAR0?=
 =?us-ascii?Q?+wu1YN+nuejDEu7WvMRiZVFnFtKaKEzg/NRrvRxFsAOUaPn1AEhXWSCAE8pu?=
 =?us-ascii?Q?El0ASeiTQ3H1N8SAUcwTmADexV2eiDbTJ/33hEMHg3xrr0a4lsJdHsGKeDbh?=
 =?us-ascii?Q?6XkxnoKvUW5OlS6DkabzBGvhro01i5qyoNzIDgqKtt4LgGRb1IlkGSyQV4Pt?=
 =?us-ascii?Q?5AXVsx4IeiXj/ZO85z52Bv+hHNTc14Kjqj/6+pKiT6dzVDZfKO/CMLFK45lI?=
 =?us-ascii?Q?dv4ICMH77wQX57HjMuAt5v8ODrnFOyrMW69sQ4yq4Q0JQUixCubA007N0ctN?=
 =?us-ascii?Q?rVu8vIPGjIkkkoMaoafEd/8BK2BERjv73Nx3ZbE9fd0bHnXoOwD35PefQg16?=
 =?us-ascii?Q?DQe1CFE9JIl1exML1fTWPcYHGeowOxTRghvqozy6tn/jetP6TDVQx3JHqqrM?=
 =?us-ascii?Q?joMPzVttafpz369QhX/+wW+GueVWow8b3bg99HFtmMd/cXH+MKGyHJv4lK3R?=
 =?us-ascii?Q?iFn4dAFJF2O+6d4bDsWTWi76N1eJalDlMWsHVjrXygeoV1czZXLfav7ZppUC?=
 =?us-ascii?Q?d7JBC753o/+shOGQjwezfNzFMGo9SqGhcy6VOcIzvmTsY3C0MO5H/lbP77mu?=
 =?us-ascii?Q?uKXzKVTa6iI92reNjp29kf13WPlWB5iC9XnZyC1wP2p9giVuzwUSCzgw1Q/n?=
 =?us-ascii?Q?exGDVCPfUyL7UB6Az7eFJWSPIflOD/yNfRi2XI5AB2FLQuPA/BYWR1+mjtGP?=
 =?us-ascii?Q?74alZCXjEXo5ggzwYv9ujjTpONFb+ofqQtC8oc8cPPM2Qw8h4M9WhRBzR6y+?=
 =?us-ascii?Q?aGFVpr42fUKL9KsZEWkVZttxq6LRQXF4zzbkuet6l0ySMoE6qPyTDLMK65Cl?=
 =?us-ascii?Q?UuVH/YLp2Qq3jVXDiChMmlgwEKbX2k2LJGZ4ROjgcUhwK8lAMU+FuSKc1kqL?=
 =?us-ascii?Q?68BSlix7Mpb+OFBWNc5nbTXpvw9Hs6Ky59OBGbuJHVLbB0vdYHqAJ406g1DP?=
 =?us-ascii?Q?of9fzWPnh8wzOVb0pdkZT4LQ+d0mwjiLgY9lqj0XJms1Hpl2kExcht4mKUhq?=
 =?us-ascii?Q?ozY7QHpV7EhdUR4ZTGbhCLLNtgXWGj+XvvIOTJsI5OEp/mRNvLgNDLiociX5?=
 =?us-ascii?Q?Ay7/LCQum68GMEEofAD+YqdJEMSM+SAwmJIsWhRVqWau0qWYf1y5fxBIMRrh?=
 =?us-ascii?Q?emZ4XojV/9y/0s/qewFfdDZDgwfzOS4Xm+oxET8yH1Su+U/jpzHhDuB0W778?=
 =?us-ascii?Q?AvOm/Wg5D+/2zHacUh0wj6GWZjrDl6C5Zce2qn8H4aQMrVgEznXBoPmGUdGF?=
 =?us-ascii?Q?akPfgEevMppqyhYeX13wSvn2K+pbbWzenXOA5KeA33wKkv62PCQEK4UNNo6T?=
 =?us-ascii?Q?GGNTCsvF3YioDFVT2/eenFOKIXyUBB/+oXoiiSmRtS2z+hcTLpF3tkKsmU0D?=
 =?us-ascii?Q?VcwvrjhpU+lrYCiSO6AqAHEhxDrp1ZLLckh+1P15IQXd/bGZRDETxXnWm5j5?=
 =?us-ascii?Q?BSGq9q1dQ2ioOWIxhMY+ATuGwhgUR9VLwbZr/1y2O4wAzIXwAXm+DNq4hKYU?=
 =?us-ascii?Q?fMCI036Sm/pirLenyM3Mo6Q=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: MDX4KM+SCFgLoohEfRGu8nGz30JV9uOVn5/6+OkJGqYz31DpHvhBggxChC8MAFmboVyPwTKIbWWqYpUqBuqUYlhV6pHh5V46IiC/lAf+lVvnCLMu673S/ONkC+eyzVCliJxzjLrJM8n+mHae8OwNSqfrS3rmvtJxH/H23WPCbuxZBUPFtEuKurZp+h/ap4Rn7AeMZx+3WIFfPvoKN8/Kr2dGTLaItESobqWYSrqu+NBeLxterBhVgb/csym+njQ360p0/CXsqJVpQgEUt9BhoTLifj1rc/5qR+WLAwXqgh+cMSrp5KIJvysxC8NMoTdZDZYRp6TvbnqMMbqtidhpNOvj+BzVHAqZ6MkvdjWq6jWZ5A6MwVsUgYK2daznBJ3vlRpHetfjxosauIVseWpZDMWdJlhhPqwj/4uJ/zGc+rrvbuId2Vtrl7QrO74d2NztCE0TjxxXH8VbhgJPG+bkCIykQKQJASXCxBCK3L2eN/Oj7KWMORiKmZPZW3EqGjj5X0OgbJd6lmlqlmUEGWt+ZJVd4vUYJEHCJtvG4zWyJNOuZE1p4KI8QKiAP1IcchKUdiPyWtWKWMxQxfn5C2u9/lYJ3qRAznz9AtgMg12y18T/+itN6AJDFB1fD2xdVDFmh3I7usTkk/ZjKunknLWyz6fcaCevb4hJBcmZpKRQ1eh84BL2mRCh1Kl3ny3/Ja+GhLT8sK5I5RwUFCtBCftZ3gqht9CfNSC14p2BKc7zapnS29z6VxdAe26FM9z4l4x9RA/1Cz2OgYL3+vRLUFpF+gwW4cQH/nUqabi2GOTtUpSgNFh1Vc3zU/9CJe6ztUU6ZPAfe/nX44iH5ilOEHA4IldtI2pMtJM9uBkbGYwyHmMXqPUI1THopVrTioBWPrApPk+MaI/KB0vEqdG4tX5ByRh7M/78u1kLev5kqHZF/kg=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 019b094f-78c3-4eab-e93f-08db14ce930e
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB6798.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Feb 2023 12:16:06.7353
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: prYDNoR6mcJwrFUBBwbXqWs6cxasyo4qhTCqJLuZW5VdViYHPmeHTbjVmbJZruOfs3YPhhRLp7xACJ5bmF7ufA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB6805
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-22_05,2023-02-22_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 suspectscore=0
 mlxlogscore=999 adultscore=0 mlxscore=0 bulkscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2302220108
X-Proofpoint-ORIG-GUID: kpOfAeJD5s5zqt915NBobWGhP_fERCRJ
X-Proofpoint-GUID: kpOfAeJD5s5zqt915NBobWGhP_fERCRJ
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
Cc: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Thierry Reding <thierry.reding@gmail.com>
Cc: Jonathan Hunter <jonathanh@nvidia.com>
Cc: linux-pm@vger.kernel.org
Cc: linux-tegra@vger.kernel.org
---
 drivers/cpufreq/tegra124-cpufreq.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/cpufreq/tegra124-cpufreq.c b/drivers/cpufreq/tegra124-cpufreq.c
index 7a1ea6fdcab6..788672c0c834 100644
--- a/drivers/cpufreq/tegra124-cpufreq.c
+++ b/drivers/cpufreq/tegra124-cpufreq.c
@@ -221,4 +221,3 @@ module_init(tegra_cpufreq_init);
 
 MODULE_AUTHOR("Tuomas Tynkkynen <ttynkkynen@nvidia.com>");
 MODULE_DESCRIPTION("cpufreq driver for NVIDIA Tegra124");
-MODULE_LICENSE("GPL v2");
-- 
2.39.1.268.g9de2f9a303

