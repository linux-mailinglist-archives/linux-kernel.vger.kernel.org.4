Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A23F36A5B21
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Feb 2023 15:55:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229740AbjB1OzV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 09:55:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjB1OzT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 09:55:19 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE5D5B446;
        Tue, 28 Feb 2023 06:55:06 -0800 (PST)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31S5wDZq015596;
        Tue, 28 Feb 2023 13:03:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=corp-2022-7-12;
 bh=BtOvFC4v+NsTapGKfDee3ylRc53Z6cEU7BJcnWMcqTE=;
 b=Hu7EttX1QlVK5FFEeV/xofeMBBU0n1LNBCzxYITA9fIZ/2E2tY064T62hBr6Vjq4FjLg
 TqZTUan0xb3pbUJgEPsDmrSQosLeGsqtZ6cF6mufRK2mIq/LMNB3SGnd5Pf2hV34lkzZ
 fR+tmcg+1R7pVulGandRwsTY4ZqvlNtoGVI8piB7KrJ3HetXgd62lpcU94MCh51lRd4E
 OYj9vmaJav2c2d1/KHzNBeH+UfX6G0EuaN46gkIGbEg7u5nuGs72xuGFcWcCuvarxb+y
 tYDoAr/wSLOD2r5ZSt0vufIi+1jcJB9R78VsSBCzIFsxlhfm/qbfSwFdcpvz/+XjjJ7/ 3g== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3nybakp6e2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 28 Feb 2023 13:03:50 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 31SCqX5l032974;
        Tue, 28 Feb 2023 13:03:49 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2047.outbound.protection.outlook.com [104.47.74.47])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3ny8s6rant-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 28 Feb 2023 13:03:49 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iVRCGUUxm1neJC9FnQF7fV75At0WcwIvBhKBtHSANXjYnLNKtWE080EY4u2n++7iY9mQZgkOdw6Mm+s6o1+COM581ETB8ziafbE0FtQ93lAXnjlgqGf2+LQh/dl3AWb+6lpolCJC3r+2ew+dsJas3xe6ovPLly8vmImuO7hA47zHzuc53VjOkB4yjhnx7sQOJczR4aQWV+pFqZqQJWyEZzWzZ46r6iTfLIaMZS+L3UV4cIbjI9I1luX+6iv+BYMuSGs/ueWeC9rexH0fgK0Q/GudFrYmiuqsYAuOVbWkn8pFMxG+/m3ezSbCTDQe/carQX7RXOGzQM4+uQOpItY87w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BtOvFC4v+NsTapGKfDee3ylRc53Z6cEU7BJcnWMcqTE=;
 b=DXDKpg9z1e8luhvfjf+vLaDszUSTSzRkGm4Knqq432/Gvj4gtNVy7UVEcamgzgMxmnpR0ni+ekoQVVJYgrYNzViiPX7Czw/qFT0jFArMQyP00Fu19XzyivnRIcg+Zrb1TtbHa5UG0ec5HQVLb3nxWkpvZaWJdHij80OHdXyzHB8gDwatpmfOxKtMfBfGIvxpo1kH7YGwcjKJ4Bg0x+3rz7oSuAamCzbabvHNccPQ+m5oBPmih86Yny2FQcB0zufe1PKjEzeEdPF51+NPZNmbgiux2VMxWYzprW+apyv3soVNrfiVwS4FKOngK6JDGTL1jJFInsNO7LyMF4KyrVvbxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BtOvFC4v+NsTapGKfDee3ylRc53Z6cEU7BJcnWMcqTE=;
 b=ZNr0sY6oc2pN27gPxUudAZYu55hHNgjpSCwhGUdDp3XrLnhs/gIBfrcAKS/1SDNdGlIAXHBxNb6cCZC4jYrQbD84xMryBKHSoMOemyqCD98jGKggMqM8DDzhfQgBNqiNdCmirGM6E3wW6Pz2rWbdRwz/uKN0jU15u1inZ6FKSE4=
Received: from DS0PR10MB6798.namprd10.prod.outlook.com (2603:10b6:8:13c::20)
 by SA2PR10MB4763.namprd10.prod.outlook.com (2603:10b6:806:117::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.17; Tue, 28 Feb
 2023 13:03:47 +0000
Received: from DS0PR10MB6798.namprd10.prod.outlook.com
 ([fe80::d0f7:e4fd:bd4:b760]) by DS0PR10MB6798.namprd10.prod.outlook.com
 ([fe80::d0f7:e4fd:bd4:b760%4]) with mapi id 15.20.6156.017; Tue, 28 Feb 2023
 13:03:47 +0000
From:   Nick Alcock <nick.alcock@oracle.com>
To:     mcgrof@kernel.org
Cc:     linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org,
        Hitomi Hasegawa <hasegawa-hitomi@fujitsu.com>,
        Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
        Philipp Zabel <p.zabel@pengutronix.de>
Subject: [PATCH 18/20] ARC: reset: remove MODULE_LICENSE in non-modules
Date:   Tue, 28 Feb 2023 13:02:13 +0000
Message-Id: <20230228130215.289081-19-nick.alcock@oracle.com>
X-Mailer: git-send-email 2.39.1.268.g9de2f9a303
In-Reply-To: <20230228130215.289081-1-nick.alcock@oracle.com>
References: <20230228130215.289081-1-nick.alcock@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0420.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:18b::11) To DS0PR10MB6798.namprd10.prod.outlook.com
 (2603:10b6:8:13c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB6798:EE_|SA2PR10MB4763:EE_
X-MS-Office365-Filtering-Correlation-Id: c34f91c7-c228-4993-76ad-08db198c3a68
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bvrG0+A0LBdkNvCDl0rfrEDp0S3DHpN0RuOyGW5AnwoATOupsNs5eR9T7p+EHolTygDwzOF0OrjxweXwtivo5qoc1o4IbkCji7OWii9OxCpYLmhY2uJ/kq2Sku50fE26b49laj+S+hYsZXW33fWxWRJggdJLw9jh9Pg8Aw5POxCyb00vbimQg7rc7hDQqEIQXEgvQ2dApFCeDYFobO2g8ZFfhPJ+Y1cooZJa3Bku1vktnYVdarf++0DNsNRP+2NV8EqJQrj4ujoxhQB+vS/vw+yieLA4ALR7+uXX9mmdyfD5o/7AdUBwYvn9iFw2gY4W7YS0ZRWr+n3xskNYs4j8/Qo2nvhjNrEI/fwT18xqhHXbUnDrZDUL154h56+YEssB5jKAwpw6tGv3N7y9Tc7RAD7JeELimmSxNvU4fbUU1hrqWZvrQ/eW6UNIEVb38jHU4teBVrSzcNrvj6PQqtHPQ1rHWThqaQw9G6Wl2lvx0CrcI8gT/Ac7YjmEi5x+I5uUIfL7fviXJsZr5KuO3n4HlP3HLc9264xe6zGRKyIDco3XAmF+1LEw5sonbZmP/5fKe98EMbKzS2RX/sEM8c4EFm0SwD481NcQr8JM53TBx7R8VO09EEWI+tiX/Dbmm8+Rv+72ZXsC3BkPVldVmKy2uw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB6798.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(39860400002)(366004)(136003)(376002)(396003)(346002)(451199018)(66946007)(6506007)(66476007)(66556008)(6666004)(316002)(6512007)(1076003)(186003)(54906003)(2906002)(478600001)(86362001)(6486002)(36756003)(83380400001)(5660300002)(44832011)(41300700001)(8936002)(8676002)(6916009)(4326008)(2616005)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?y2fhNLdrVcHkox5H1XuiWblG/NBt2TgUOED69BhhXgl/+P74D2pfhTNhumf6?=
 =?us-ascii?Q?9moIv8HBfxvorlvweq2OuRROapG18jxwuBqZTIDNyeknscSollKdg1lbRFpO?=
 =?us-ascii?Q?XdM5U6dcaIOAp3KpDqZsFS0Zp5sqv5qZB65JuuSGNdkSum12XqTWZty0Fi5r?=
 =?us-ascii?Q?1uCPyhcdIdKVSUt79bSWJKk52Glm9peudepsxxixx9pnBnIWHOjGuID3kNe5?=
 =?us-ascii?Q?LSVi4X4ZydP0F20y5AqxuptRDVv6bGHskmWoCpq8WN1TS9o3Ceu74nJXowF7?=
 =?us-ascii?Q?+UmbmND3Ok+ps172tZY3LZs+rKIvcniZfthUuOl+LyQnVFhjhmiBWsLqmyWQ?=
 =?us-ascii?Q?iNiWUlWzvWEI7N22AM/IMK/ySjUI2CQs4ldABpTp/IPqnkyifCJqKNbq+lf6?=
 =?us-ascii?Q?u5GwSAxDSOM5BXFaB9UGOKiM2lKuJ2Db4mq7ldze5uwrWdE78wl85ZR5WoZC?=
 =?us-ascii?Q?nVs0HXUtw0QXTau0D/InAxJvSM6KkyjuaFgVCn3qN4nxkl2f9GTT19p/8PsV?=
 =?us-ascii?Q?NJU1RDM0l2huOGAC5CZ6hlM0vbrJA4/lq3Tp16kxJ0Mflp1fkA0Xq7fbbjSw?=
 =?us-ascii?Q?3v/4akCBvvuhyrmciqW+YChuF4x+l/PJloAe8f91hx2IhW4g51g7Q+WTlK8j?=
 =?us-ascii?Q?WDUMBSJaSZLY37R3d0VLFax37IzYKvaOTwzxreGgWztxJNnFukMsm8I+oMU9?=
 =?us-ascii?Q?2SnjSUsmCPvMRXCdOBMTdn0FgEARdvgjVDoi83NOMLuuUsVqqZyoyqRFSyVb?=
 =?us-ascii?Q?ocDD0HTa/r83VMdaxf/dmaluijs5UJTlshEKWgLtW43UnDX598fCalaKzskh?=
 =?us-ascii?Q?v4lfGoOnL9M2rkQ8fDdvI2FAFxGeDIQBtdRf2WfxwrlrOpbg6R+MBwVKf1AQ?=
 =?us-ascii?Q?GHP4y5Vy2FBXGhHq5xvnpw+QLue3Cx4fs+MIKWo9BYRs1oa1yjkcZ3RNHKpo?=
 =?us-ascii?Q?Ghq70khYl3RLUWV5Kp3VItJ8ySk8tBVmacGUWBZBN6Nnt/pjN5AgD7ar5fvw?=
 =?us-ascii?Q?GPMkCeIBQcgnfjTpYX1P2LBLQGJOH3BUKURc6LKksX4kWOpvwzSgC0fPrDFU?=
 =?us-ascii?Q?q/D9UZXbWMiRjyjaTKKFbDieF7JSeYDueI/w/O3ucRBPimk7Q4pUng6klbSR?=
 =?us-ascii?Q?6rEmqN7D2xl46LqCtBphzuQIefw9Nynfbv/boZ3GMFiDWV9qPXDC++GDeX1l?=
 =?us-ascii?Q?CLEC1r3qLlNhkLh+h1PPQ6TeP75tcL0NKdcRptI317vOxe8erHZ466cHXSRz?=
 =?us-ascii?Q?VgxLOh7/ulTV3/6OXa+k0sx1CpkhpDJVAR7X1H72bgP03Q4w1LOYBfblSLs+?=
 =?us-ascii?Q?mJIS+gOyuPLIvoJvOSf8uOgSNWqniMyKGAMXjj3XIAe6xjvbrt+g418voj4y?=
 =?us-ascii?Q?t3B0bqFigen2FMxoM0btpNPp3bDVIB5D2eI0reYFh6VtqH5WQhojDsKLFomR?=
 =?us-ascii?Q?yELygQHFLpR9I9JSKEhvbS/K70T3BPmzW1SP8rhWM0XOqWslfZMTLaQG2anC?=
 =?us-ascii?Q?fiA1XKO/fgQwVpG/6+MI9vbW5Ng+8CgqiobvD8+thCY/mclXJdXLhaEyYRDt?=
 =?us-ascii?Q?mueQm7nKk0r1uVYgCWqs+oB25zZz8D/5HhUoo16U6Agr4zHEOsVTyqzIGVRy?=
 =?us-ascii?Q?4aG3s9DQOrZKAufEyGCn2Ic=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: kmab6J9EdalBzkhcoK1plipnrldshXWF02yi+Vm9IN8R7bJd2Z8hl9XUuORfjBcA4xUfgwIBKNty4kvhu1YykvYX0SMBxVVfElYR3RhSru56FepD9c+M+WUWh86V2Jd8BEG0cEK1ek1lPG20SDPr998OZKc67vr6A9/MbAGDx/Esi7J2dL4xMUXqS2D5aklVc58Jr+1fUEXsGXY4STs7IDx7MuFzcdo+frAimvXGBU7e+sXsJfs0MiMy7fKue6TIiSlwyAILH50UkYjOXNOJwP/VCAKdYOocHRpkCy4Sb6GI52c9bwBU0yzpnYHe91U+gs/tJRlDnBhLf8J5VI1cOQW3tiX1mqQxfQAj45bXfCckQ3deeL7L0FyqlHykl7O1osdxFqtPXgR+f2yJqrNNzHIBmlUMfYxEnpXID/RLXdxaPvS9rTmW7Y22+w1yDBxlMy+23FUUj+n2o8yDPZkMEZbhNY8C9AIAbDFlVrvGdMEB/DSKIzHW6/zjGaURnQqn+4QpoKZc31/s3xLB8wcZEl6lvhXC35vB2FMVZiOlr2XTJT9ixzk/2twF+r3AsqmwAfG5GsO6WQ3hI6Vcox7c95z+75Tsq3xJNJ07+w5PvqVu/o7KxIR6SDblzN4ZQmmaKDKTk6FgtfstDn7EserhkA5durdp2H/8B7aj3UpB4Lk4WBmlIpqigdLryjiz0+qx6j9TfHuHJtMKg+gjgWdQLzUXKzm7MVrsMSu49xJs/e8WUqw1SZiZYpQofckTIlMTDLacvtxPLxmqqvIYSVF4x+HwTcuUizPjulARN7xVsrtTyMyqZJpGfSvwMQ4ZaOTrWYJVlcK6DKH4euRxZuhImSYuja7tO9NKFClIXmBnqyVM8hbr/TqzqekBqIGS4ldNc7Bu50z/PV14mVzTbEMKoQ==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c34f91c7-c228-4993-76ad-08db198c3a68
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB6798.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2023 13:03:47.0660
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4E35swTZ+G9QGSQqjMssmy3+ryEXBZ1aOvkHJAWESpoCHI93B2rAaZ6ertJF/m3vNJG01VaIXjug4VUiywjjkA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4763
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-02-28_09,2023-02-28_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=999
 phishscore=0 bulkscore=0 spamscore=0 suspectscore=0 adultscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302280106
X-Proofpoint-GUID: bf0CsAT9QjGJB7b-vKOqffNhgMqpJ1z0
X-Proofpoint-ORIG-GUID: bf0CsAT9QjGJB7b-vKOqffNhgMqpJ1z0
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
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
 drivers/reset/reset-hsdk.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/reset/reset-hsdk.c b/drivers/reset/reset-hsdk.c
index 4c7b8647b49ca..92a37f30bd817 100644
--- a/drivers/reset/reset-hsdk.c
+++ b/drivers/reset/reset-hsdk.c
@@ -135,4 +135,3 @@ builtin_platform_driver(hsdk_reset_driver);
 
 MODULE_AUTHOR("Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>");
 MODULE_DESCRIPTION("Synopsys HSDK SDP reset driver");
-MODULE_LICENSE("GPL v2");
-- 
2.39.1.268.g9de2f9a303

