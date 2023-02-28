Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A5F76A5B07
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Feb 2023 15:47:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229569AbjB1OrB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 09:47:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229528AbjB1Oq7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 09:46:59 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8E161CF4F;
        Tue, 28 Feb 2023 06:46:56 -0800 (PST)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31S5vPX0015581;
        Tue, 28 Feb 2023 13:03:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=corp-2022-7-12;
 bh=uFWyXhlscHxFYiA+OFGYvo7FhsjtIR0OqeAIzLjbgLs=;
 b=D2LNm35/rQm9pMfZzfuMk2E8qPD56Qm/wLRv5/936grLqGnXa6rOgcAhP8BC0CQmTI4H
 F5WjdkzEQEUhhXHTyIdojSzgtsAiv5VxmaXimHlf/F9fkb5+P36mAtqXNVcFUNM0cL6s
 kOHfeNQfvwrPEdeTut7Vm9UqvZ56+iFbdd+Rx6fLHeFXLJgIZiC73vIFxWOks0AIGiU6
 9RTmNWThKLnUYQNAIUWFtCtqR5bo/7KxiydRIzEtEaR3k/6mgjeWgoalSO3DVd4I+4yH
 iqdqOhL29jzXbsLX1rPfHoqlcYCzP7i7WBIYKVBVxG3Xy05dVnyvLD6qho/oEioTp3yD Jg== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3nybakp6dv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 28 Feb 2023 13:03:45 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 31SBljaY001096;
        Tue, 28 Feb 2023 13:03:44 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2049.outbound.protection.outlook.com [104.47.74.49])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3ny8s6gfup-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 28 Feb 2023 13:03:44 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eEb8XbuH9tEyBpgxzB3yWFdW2W7RlkXSHrdku2pUxLcYTlWVDJbAF8/RrvlxtjqLR08yMjKh46P3ySiatrnK0l4/sXjIl6kSi1sahg2iizy4DfTuSpuq4vLO223R/hzAQcF4ed9Sd5wUJcSKtm8FDqvoCeSR4qiPYPy240/o+E0219kXpciSCeDVwsetubDoz18LPRO5lTjhzNPsWR9E+gjk2stLcz9wqGsVcsKS4hHlkNqThhXa2stIPGnV+6hRH4cMv47k2W7ePSxJCSvoj5pgnGCC7VoCSpPpj36AF9PmohKhW0kIMw5hNNqTqfYu1/+rGlpo7fYToJjJNTQFPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uFWyXhlscHxFYiA+OFGYvo7FhsjtIR0OqeAIzLjbgLs=;
 b=jhFwwpoKBD8qLwZTYtNlG6/zgACYRPuUoloqI/Ag/FmGYTeAVrKVl7KI4d4o85YbenD0nu3J/OqqV17jPsiRK6MwunK9GGpk+CLeqOvF5Uw6wIvS4n3R7fhPRzQ+poSvXenaFm5DHpiLKdJivtR8E/NJ6iCoyOCc5qES4oGz2MKyleSDUeDIml7nDu9tFsPxDX/9lTHmuOuSuOt11s6F69ozfpFXlHSO7xRkUrFtC+1Lnv2tXNEDqK4goUD1lc6JCTLVK+vfu2GpnRP/Tf1rhMzw5vJrDcUO3diGX4/eWKZv2/c5COaTToLnhspceMdvSAN1WAJYK73RSV2ZCMmmsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uFWyXhlscHxFYiA+OFGYvo7FhsjtIR0OqeAIzLjbgLs=;
 b=EmwB4rd+j6cZ+o6pEv0LxFo3cWdmZhnnNryMZ2/qhsnE0zno/h5tUBbH9P7g1ersH6ZOm6VajurS2zfHSfJYQapgq/AnpFar7aJRCfDO+2zCXKhmA1452z31g7xeeTWgRSxDnHmI4TXiONgm2HXO3dVdhN7G3yIHOll3pQ7k8zY=
Received: from DS0PR10MB6798.namprd10.prod.outlook.com (2603:10b6:8:13c::20)
 by SA2PR10MB4763.namprd10.prod.outlook.com (2603:10b6:806:117::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.17; Tue, 28 Feb
 2023 13:03:42 +0000
Received: from DS0PR10MB6798.namprd10.prod.outlook.com
 ([fe80::d0f7:e4fd:bd4:b760]) by DS0PR10MB6798.namprd10.prod.outlook.com
 ([fe80::d0f7:e4fd:bd4:b760%4]) with mapi id 15.20.6156.017; Tue, 28 Feb 2023
 13:03:42 +0000
From:   Nick Alcock <nick.alcock@oracle.com>
To:     mcgrof@kernel.org
Cc:     linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org,
        Hitomi Hasegawa <hasegawa-hitomi@fujitsu.com>,
        Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
        Philipp Zabel <p.zabel@pengutronix.de>
Subject: [PATCH 17/20] ARC: reset: remove MODULE_LICENSE in non-modules
Date:   Tue, 28 Feb 2023 13:02:12 +0000
Message-Id: <20230228130215.289081-18-nick.alcock@oracle.com>
X-Mailer: git-send-email 2.39.1.268.g9de2f9a303
In-Reply-To: <20230228130215.289081-1-nick.alcock@oracle.com>
References: <20230228130215.289081-1-nick.alcock@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0377.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:18e::22) To DS0PR10MB6798.namprd10.prod.outlook.com
 (2603:10b6:8:13c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB6798:EE_|SA2PR10MB4763:EE_
X-MS-Office365-Filtering-Correlation-Id: facc4d5a-edd3-43fa-937f-08db198c37c8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TKhwl4Sg8zfcJKT+v52y76GjzQpD6rshodxwXc7WfbQ2kptQ5lM0Rkaa42EPDP5SsZFzbfuZeaEw6K6Sosw4JnvDbyQqzaWxGqDD1mLkd0FvPxeRsMe5YCtXwM5Qab+JuXLlXYwR4cVPnfIfggfuQ6mOtd/ciCASMM5jiAYGWLfunfGboiARxD2tw7QdBJ6himByS4Lse6UNwmNv1C7bhVujK40SGFU8hbc7s1bjMaPbsri8+X+EuQTdZGXlXemojKTrzR9vM7QnPRqZ1TsM4OwB4YxnwQNpoCICE8fEF80DwkWaQnCzqePjzZ/CSqxmfA46WLaWHsny+V/5+N3eQ8wS85T8ByvOAyd/orfgCDvabEKPnZk/4VZQagVoMbyMr0QbQkUXePL5gMsbUWrZaLDjrWknGYaiv3s3ZyCTTaYOuUs68ngJLkPimuHMJVVqbjC8JGXmfpNXSywTAPgipxbalYw1xgsEhVsCJ8EWzpIURrDDODuspe+p+h28UaE4Mn+us/L2ra7eSkdfDUIPEjIq2qcmBQW3XLydmG3rgNd5pS1I3H+5hTnVVdQgm4S4hkaZo80hQAn3xZmt02XWXgfrVLvGnqTs6jdGtGd00AIegmWbuOC2Br9hfq0WxmtmJU0TFmDzg4O+dL2PcxZJRQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB6798.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(39860400002)(366004)(136003)(376002)(396003)(346002)(451199018)(66946007)(6506007)(66476007)(66556008)(6666004)(316002)(6512007)(1076003)(186003)(54906003)(2906002)(478600001)(86362001)(6486002)(36756003)(83380400001)(5660300002)(44832011)(41300700001)(8936002)(8676002)(6916009)(4326008)(2616005)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?1/qMBYe0PZeGVbqqwNApyyY4Rz2cZ9FdnO/0p9noaoH9LbxJzT77jDjJv6Po?=
 =?us-ascii?Q?YkuiqjFOKa6GMTyRaJe3NKj27H0lyFcgZIB4CxNHGZUHnbpH3BYODNq0XLx2?=
 =?us-ascii?Q?+BjIQgF/dbs1EypPtjsBtZjQzZquLUBniL6Qjm9dtmGzPNqVZ5jAgqDVysMl?=
 =?us-ascii?Q?Hw+xTKoB5CPPmjL62PYc6csc47DGjPH3YJBik+s0QIfy4qgJOsHFNrYxBuDn?=
 =?us-ascii?Q?YQYJmfEEtLO9F/KNMlANn5huJeoK36AwKGlyoIK+dNAYcfb+YHqwj017IOe+?=
 =?us-ascii?Q?38kk3YLHmYmhfkLTk04EZ9NP2VKdBDukbaZhj0rDTnc1fyazGyTuaKI2WcUO?=
 =?us-ascii?Q?+NpprNSFuT+/BV3Ma5rwA/NsVHlg3pP5KDssAYfhBWOJQLSEsDTtlx2RqS6Q?=
 =?us-ascii?Q?N324RNNM6jjiPJ4Rcwl7aI2KFymeGaDqgSSnIy0EvYoYPvcqT1wTWhFqMwK+?=
 =?us-ascii?Q?u7l3X5QWVok4bU8P0DbIUR+M7UC1x9XUzxTYKkr98d22CJLMWEPHBJoGKIB3?=
 =?us-ascii?Q?DV9Wky0knd3cQKN9gc2O+lrIPaX7VOGJFlR5D4E7BVOJb55woyrdKg7aE99V?=
 =?us-ascii?Q?ubkYD9mhj4E6NStQJ+hmHKn3EQSHxbH3ivQiB20Oxq6W9UWBvjrtk4oM52Y+?=
 =?us-ascii?Q?uAnCwlB+QfXi3Y3VVTjoMX9POtOk6LXByok9ZaNqW/1rYUiB2YHHBPvar5Sp?=
 =?us-ascii?Q?mvK6Lx72jULAIp/v0lqIQt/WSRdRN+lbVEAsASBem9udmBCRpd2NWzxWgyah?=
 =?us-ascii?Q?a+CgmmGFG+E4xJ4tgsD2pEPKa5qFVag3w3jGsx4Op7QkxTDXTrHNQU+FRvzZ?=
 =?us-ascii?Q?cct9tymQIpTa5Z7DKKA4eXlHGRIBoioOSZEIwsfPj51GK85amsRSeC6B6Dtk?=
 =?us-ascii?Q?NcJeXzG3xSg9FmFZxZjVnX9crmw+UHD5da6gN56AMP8DIVNYYQLUSxNdfOZt?=
 =?us-ascii?Q?yg8I/Fn0fJWtwx+Vz1xa/AO+ZsG+ptCmqsAUTuDf/kU5aPAins5lVsv8fOMa?=
 =?us-ascii?Q?idRsd4wGmcds7OkNc961U4iyiajFv2leHJTZhN3y1IEFF0V4gygBf/1AhWFk?=
 =?us-ascii?Q?cKaupl8wmDUY7SOEkS2z40L2anIlsV21a7FfK/U0GikD0RSXw29I5aRdJ3S5?=
 =?us-ascii?Q?1iqHs3fh9jhFEdGjEQ7sxU8z7/Daksv5+3AN3L01hZVa4A3V599Vx/zomcPa?=
 =?us-ascii?Q?WcLSjdmWHzl74oQpi4AinEEgC//DJo9QNyyl0E0dYgcT0n8cRM2V550n2A8M?=
 =?us-ascii?Q?uwdSAKsZdJp9/S+NeufDmjH+wSufkJNF/5084lK2TXyhDhkqBp+5GHCOz5pL?=
 =?us-ascii?Q?tBuNMl+4Cjvf/al06l9qjlT0PV39ML5CVThZIiuEQQ5F2lC+W6Fk8W9NY85R?=
 =?us-ascii?Q?ZeV1bH4wUpi4sE6Y/7eiQjOiyTes4RpcWSLNuOWU8NxWad3ieiyv3nh3ngzY?=
 =?us-ascii?Q?gB9+3ENFp8QLIHlTqZWDVbnbQ0GjSkuSZBQulXu0q7J3Y+KQxNLgg6/5bkn8?=
 =?us-ascii?Q?82naUiWrorViVCyfCPZuuHXtrgf8wnfvRDXZakpIkjHEeXh/lnZ6B4OyQK0F?=
 =?us-ascii?Q?0tTmeWxPd9fGBLLyZf4k4XwZd1yaEYSGsz4PxLmukS7XBjujMOrkKRJ5Xy5S?=
 =?us-ascii?Q?umrcL0eRyFHnZRSeEWU/qJk=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 4H5otquhnqN6h+HX9gUoHAVN/v0WUlvQIV2GJtFceUoUKrB8D95EPSf+Zc+0PbNnp/oE32VbFb2Vn3pQRjskQiSK2U9DJFxaNiF5ckT+rIV5zpiJLnDMkft9QZg/6POrNVr21N5Xh27XmFCfBtCoS/hvJ+0J1P27Rc9hkPjN6J+9MMYrqi++tlEHWP9sTjmjKHXAk/PmbqVHDrPTt4V3/MyQ5tpFaH+bsMLR2JapjAXQuDyK12he+Edn3Hwk/KMuyQ5EIW4vQYdNUsl8a4LeYrJiG5uIaFLU/wIniMKSvawmYVbr8exoSLoAML+FL6CNJ5KZO8QLalLdlyZm/mu/phJiGJQ1dCDja/YqxW6AapK3gICIzC8G0ZcKwoEYNIYvaX/JbdToYZcruKymr0W+/24A/ZACQDigqDHsQp7enydXLlfTyx9i5ZkOJVTPFpMpRAF5z1GDB3xd9UMbTWRBTVGkgonJ7wefR97klyFGRBGE/7vfEtFnS8uCtN+TN7VY9MTdzKobE6S84sLpaxrbGRM2EELd4sXrJRO1ZojbkMWqkCneSnj1weZB55Z1BmS24TK5NJMYPt0koxynfMABfSsF5SzGfVUTvSasLp67MmeNo2J84aSMpn15XkqRM3QBavG3LyEzwyDvwj/YiVGfhw7MmZ2tDI5GFdkCQWoy7iA5AetVqNTWSyonnQLZvGJRSJwXfB1WaY9ePmvRtouXHt9o3AYyuxXEEIkvS0dwziIYnIORq4qhqHn3f9LiZb2J0y6ZnRHlHHA0zV9FgO8vtTI8U45J53K0fsEBerwIMoFul6XHpnKmWlCw1KtsfOEX+oxazet812KzL+py1opQzPZDO2BeLqvPQw4va35E+ivOY3dCLQWFYrIIQQxfnu5xR9XsvrbSLld0BSGBHv/d4w==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: facc4d5a-edd3-43fa-937f-08db198c37c8
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB6798.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2023 13:03:42.6597
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UcD5yk9LP2YxkDmIZsoyaCLseKUWrLbjH5gTit7rPs9dYgNb1jlcIBuLKrBT/Z32a43g+nAE7qjuiS+/FqR6wA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4763
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-02-28_09,2023-02-28_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 bulkscore=0
 malwarescore=0 mlxlogscore=999 phishscore=0 spamscore=0 adultscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302280106
X-Proofpoint-GUID: n8sxs1PqCUw0u1slPu7_ERglxVobhPHI
X-Proofpoint-ORIG-GUID: n8sxs1PqCUw0u1slPu7_ERglxVobhPHI
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
Cc: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
Cc: Philipp Zabel <p.zabel@pengutronix.de>
---
 drivers/reset/reset-axs10x.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/reset/reset-axs10x.c b/drivers/reset/reset-axs10x.c
index a854ef41364d6..4cb25b0af8d82 100644
--- a/drivers/reset/reset-axs10x.c
+++ b/drivers/reset/reset-axs10x.c
@@ -81,4 +81,3 @@ builtin_platform_driver(axs10x_reset_driver);
 
 MODULE_AUTHOR("Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>");
 MODULE_DESCRIPTION("Synopsys AXS10x reset driver");
-MODULE_LICENSE("GPL v2");
-- 
2.39.1.268.g9de2f9a303

