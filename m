Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FFEB6A5A5C
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Feb 2023 14:50:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229668AbjB1Nux (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 08:50:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbjB1Nuv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 08:50:51 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57E5B2F78B;
        Tue, 28 Feb 2023 05:50:43 -0800 (PST)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31S63rr4016327;
        Tue, 28 Feb 2023 13:03:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=corp-2022-7-12;
 bh=v5kJgciwMDTvekLG199gs2J1LP4q1XKNcyyXocnqIuc=;
 b=fkq01FUFZvquUQoVYeCn538w+Yt2JcudNYpTh4rc69YpzNagiLAf6Kp+bC0hIgcPZGXA
 ru9ACEUKqvucpfRu9zXYr7Qa6EuEvALloPFhH1jqDo6CTHgO+4ZUcPdREvT1zlklla3L
 rGqxF86reDuhyWNXKyCYt01tQjY9GV96QboitiRRt1rH60XAl6rTXAGjpFo+aosekU3C
 ANBjtxx5nrlMwdO+yhZa0OgdbfI31oNs4b/TLQOLNRyOux3XHT8BN+x1fsvsJGtyWkMW
 2iP28BPyDzluuuhgFNee1VVZpaQVbCII+hlH+LHlBL8EKt/bghpNmtwGAX0KlTPZAkKv 0w== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3nyba26844-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 28 Feb 2023 13:03:08 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 31SB0nSd031559;
        Tue, 28 Feb 2023 13:03:07 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2169.outbound.protection.outlook.com [104.47.57.169])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3ny8sdh7dn-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 28 Feb 2023 13:03:07 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YPa1wQqearj02R3mT5IbM1SStxxxl4ckzQEs20kYBt4CkMh/T9mU4qg/6bybZ24uMuU5zFEYAq6tIgglJYxnBo/9g4O5vsw1ZBsCWc8ydwexgLebEE3HR4hqvVFvtdklGZWAVo5jAMlBR/DoAIT7kYt9FeZ+g0WjlRnZI2WMxNwcd2zuWUoWvqDC+2Xf3H6d48JOHLJAQVd2w9qhRaES6Oyc5g9IousdN4qG2lUH58rCDtaUdlwT146imKdp+T9y99HlUGLPF/dskkKvLq9IG0GLva/KIlX2t7SX5qHPu1LsME9ZdwOv6sb1Iyt8WPmfCQ7rrVP2/lv0H1FbS/s40Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v5kJgciwMDTvekLG199gs2J1LP4q1XKNcyyXocnqIuc=;
 b=aUMZlKxXwsVrDzGgihrd9q9KbsHwtwkUpeaa/PcSBNPFUgv81i7ByvRDsVSkhv7qAIPxk6hJ46H2jEwjWrLGZero0MDD8kW4Fb7zOwSxUZUo9nyAfa/Z1yWE/2c6NEvVYe/Whh2PfWx/K/68TB1v1hzMH9frmIAnUy8OuA317xf28SUvOS3AvyeDTxrjvlnySTzkJephFDPUr4uwb5wtFf6H14azY4g5oqlMO7Dh1n1tWEYVpwxkgn/ApLCH6cbH6FYNU5rG/WDtPFKodWiOR0g6+Sw9KPQS+y/C1Etj+Zq93+2/LqqzfvTGcpJy0oI09q70l9ozycynesAjiSGVQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v5kJgciwMDTvekLG199gs2J1LP4q1XKNcyyXocnqIuc=;
 b=SvgdhnJGDktBjYutD02JFc/PzAk4QjUloXpJxsAFC2y/xqnQjRiEZJiptqVWV4jtWnXrPQpIdkicHxaKRIEqt+zNL2+XvR/WT21j650egsiTnQL+ZVvRbadtn87b7npAXciwGugqm6bGKZydEjzBNgxZkKVBV4ESojyOyGAHTB4=
Received: from DS0PR10MB6798.namprd10.prod.outlook.com (2603:10b6:8:13c::20)
 by CY8PR10MB7290.namprd10.prod.outlook.com (2603:10b6:930:7b::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.16; Tue, 28 Feb
 2023 13:03:06 +0000
Received: from DS0PR10MB6798.namprd10.prod.outlook.com
 ([fe80::d0f7:e4fd:bd4:b760]) by DS0PR10MB6798.namprd10.prod.outlook.com
 ([fe80::d0f7:e4fd:bd4:b760%4]) with mapi id 15.20.6156.017; Tue, 28 Feb 2023
 13:03:05 +0000
From:   Nick Alcock <nick.alcock@oracle.com>
To:     mcgrof@kernel.org
Cc:     linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org,
        Hitomi Hasegawa <hasegawa-hitomi@fujitsu.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        linux-renesas-soc@vger.kernel.org, linux-clk@vger.kernel.org
Subject: [PATCH 09/20] clk: renesas: remove MODULE_LICENSE in non-modules
Date:   Tue, 28 Feb 2023 13:02:04 +0000
Message-Id: <20230228130215.289081-10-nick.alcock@oracle.com>
X-Mailer: git-send-email 2.39.1.268.g9de2f9a303
In-Reply-To: <20230228130215.289081-1-nick.alcock@oracle.com>
References: <20230228130215.289081-1-nick.alcock@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P302CA0021.GBRP302.PROD.OUTLOOK.COM
 (2603:10a6:600:2c1::12) To DS0PR10MB6798.namprd10.prod.outlook.com
 (2603:10b6:8:13c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB6798:EE_|CY8PR10MB7290:EE_
X-MS-Office365-Filtering-Correlation-Id: c7a917dc-8526-45d3-2e50-08db198c21c4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wef6+gGV0Wa7amYUZVzTAH25Hx5uXF8z15uSxZQLwJHt1ls/AnB0z39+laDFLgQTh2uXSeMVgTh8S+DSPWCICXJJeavbPEuYOXjxSXUlah6+6cunMqxe9QHvSj9TcTqbp/IDCzydeRnkujv16ALPJ2mOMjgAdeshRzQ783EA4wIEIFBpWWUNjjIr6p8HwCGyGdgzO6fhLZDAUHAEjMJlsN373Rw21yFdRISoJPctJojzWD1ag4H2q4XtttFB1zzfapDNW5VAsUyV5MoavXItMySjv/JkfaATcXFZ0cTWCMzsXXsE2OqjSOUxivXotv3Tt+AkHKBq3JO/aLCPgpOZhPyH3ZuYQ5PPFOi+tZQJs6Xv42o9MgkcIQkQ+F0rGXtJIY4awhRBz1VoPxIN5v4j72iaYubu1xyNrcS5qdwztjyz5IP8IcDxbzBRxH/12O1ESODWEZA396ae/3VQSIuba4JOZ+vIQTmcRU/s8u1Ak08nTzA14iXaP1LGHg5vFzxMitLepoXmbWPx0sDVBPEowLXUb8a3P/iCUdEDaYr/WEcwcy8OY54RW+AVBxqbLrj/3PST1GZBPa7XA6XnaIyKeWdn8nRvP8zXRv5EugYqsvOxZar/DYxUxqzYKpE+Ex6KBCRC+6p//cBsFIsudtp92Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB6798.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(346002)(366004)(39860400002)(396003)(136003)(376002)(451199018)(7416002)(36756003)(44832011)(5660300002)(83380400001)(478600001)(6486002)(2616005)(6512007)(6506007)(1076003)(186003)(4326008)(6916009)(8676002)(66476007)(66556008)(66946007)(41300700001)(86362001)(8936002)(54906003)(38100700002)(2906002)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?erdaKmGqT2+MARCF38wF/upJbfSJ0J3Q1RrgLzqTvseCQtNQJQOQfAdxqqij?=
 =?us-ascii?Q?3v3+aS/9DaQjxt3hFrvGQhiFllUrdVNjzgqjcvXrZnpmIWmzYG0uZfkYhW0y?=
 =?us-ascii?Q?D5zR+sV6fnSXKi0aNKXVu/eIC0kAzadhC95/FZiNq79+BzBYbBdO+3+9Cz0m?=
 =?us-ascii?Q?JLsjn3Zza6NC7byqz9xN9TJ+zNHqlVkiJU3DlfOfFs4QUXwnP6N8hxSasZvz?=
 =?us-ascii?Q?af4yYJZ04SmyaBw4y3PqQWLP9U8V0pdbXjGqXATfVCBtAONB55PbRuMTcPKD?=
 =?us-ascii?Q?yzA7DWiu9G48qgbVMIuWJED81/j6MHmoKf1HYpAPeLU68JxQ112qnZ26MVV7?=
 =?us-ascii?Q?V0NtbX2vD78dU5NR236MS0d2RAYm5wMi50C2r8vJ/4ZsdHsVR0LrM7bjWtAd?=
 =?us-ascii?Q?+/lOMEHJl/tjt2UlvVJWqG03Ly7mNpZXP//2SN3d792CIeC/xDqyi4R0mt5Y?=
 =?us-ascii?Q?gMoYt5sIB/C7NM7R6+VVOZGivDEFFk5LIl5Pfsx0RfXCDE5ZNJlmvtTAq4Ir?=
 =?us-ascii?Q?k7IvNHjxsdXmZqvz6A5xfgVbeYtiqCzzC9Qx/DhP/T4YCGiEJJxeR5brDFMO?=
 =?us-ascii?Q?hJeU4OKFkI90YDJMD36Lk/L8/RkvNVnpvh4guK1rx1E5Dkqim3dumDR75gKJ?=
 =?us-ascii?Q?XkNSAzbSDSKRykEV+tMvO+RYBpAbGzg/VPLEDUv6IFw5G1aZF9nctIi8JMfO?=
 =?us-ascii?Q?OpSnwAoIkDUOSMjf2Rdv7Ol+pc+fTdjDx+g3jOP6K+HJlpnbc4QoNPYA6zDq?=
 =?us-ascii?Q?ZVM7zE2cokUXGQf/bBLQXGMHBVFpy9zshihsdG5kmB9oG7ixiY8uuTE2D7cZ?=
 =?us-ascii?Q?GSQBUmI0XV4Dyl11TuDNf4AxKBovgUmkTKSUzORyy1cVOd+mn/YvVcwTGL53?=
 =?us-ascii?Q?XLay02hs04/MHXZRynyHQUsIP9DgSfL1Id+WduYeheIhhp62mg+s1iivzKIr?=
 =?us-ascii?Q?b1+tVjLDeio6pX0IMpWitZPChjPEJkabS8eMxA1tfanlOBTZaG5Bp6v2v/ZL?=
 =?us-ascii?Q?oNNfWEX76AjgVnMpivgDTmvAniKmOK59cIEhQeP9Vwq64hVVskgr8sUcaqGs?=
 =?us-ascii?Q?Bl6aC+2992i9vB/vv20HgUg7UqozpqTWKRo1DL60YhL3hb64nz07CEL29ve6?=
 =?us-ascii?Q?UBwChltwyihNAE0e6WGSUZHai1eZx63kU+JEPWrHUGM++vaQ8IoSgoxdsMfF?=
 =?us-ascii?Q?fJrNO+rDZ+2lwfWqDYc4qXi5VV1V7JfGWslhG3SywP7+x7tmT8bToh8ySGMp?=
 =?us-ascii?Q?uG3s1F4TiswGr5/eKVGJ4xnMxFW8OSm9RapB36/62zqncpRTZAeMAxLIokzc?=
 =?us-ascii?Q?HM9vAFUTfKbxAVcC1/HNZqL3NW5qqHXIwSqkt3RwXcb/+oBytQCgs+yq4Mql?=
 =?us-ascii?Q?vgONT8eIRfiMl4bS74Za8HE3esywsGomaY5bI/2dLFfLjH9Oc7wt3X2KHYGG?=
 =?us-ascii?Q?uKrPIWSZ3q7DdHbfO9ilNr1LPYoFUp12TWLln7gX9TGi5AHxKcEII8UxavDs?=
 =?us-ascii?Q?+mfHY7vTiHiuKABezqz6KufxPzlKH1EHgRRt963GGzUC055wpORmatN5q4yn?=
 =?us-ascii?Q?RM3CiiJRjhhRXJkAQomKiOqxm9IMqFNQxNZ1LL+apEEqohdjZZMGEvk4eTMx?=
 =?us-ascii?Q?nArJfMxoSvsOzWgnU8P1Mls=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 88ef2Jyt6//K8ukCLL87u2NGtDaBDZQsevzzrAQdkrt3y8b6ecdyN3auW8M+XTt3H+NFKpmb4mhzpUeo+6MhlBTP7DcOi8tOK7HHCcsV9+ZFK02JK9rBqtfw1wY9SLMMOHzYmk8T7YWez+bTVaPAZzJRL1xxrDSYc8Q4KAN8EwrtxpeU5ZXyOx7HL9By7V3YNqxcxWy6muY2Isqk3y4lfwCOn+KgGw9ADH6KLQtvUlD6Sb9EnGlhbMHbO9o8wZjNtWQxO5LpXsk1mYP7/QD6UqevNPGsnhFdh/sIIRcUV1FXwymupPLQjc613WU/beJA+c67M3geL+CcMC/eGgJisa3Se6ee0jRY9nDYM5BkcYjwp6+YMTwpim6lcPRJmK+mNSNhaPnguk2fl6DjITd1Zi+bi2UnIe0HXS2A6BIYdRM2EhHyCKk+kc4uPnGy7jbdRJFYNKwvXBm4DGKmfSsu+8GGST9p7DMUNz7yL/9QPgsg0pZW917k6H8RpEpoed5KtoTqrpFwrQF5QOlBfcs5MvWedOjLCcURID0uB1slUX1uo0fJ5ZyXAgJqeP6/FTW6JVvs82Kz8umNtMtCWky3iI4TYzzlPSEKApf3BFqjTlmCeQ9zUp34SIm2F6W/waWm2hpjteOKlXAo1/qOxlnG0/qMyyRGQuhF5cZH9oiochEPuTaDFlxGhaSxLsNkTU10PnELL34fjUgNWYaTWieI/H2dlLRpKw3oHFor5hnA5drFOQbKv7RLkRd9T5f5cJN273UE6NMo/HZVblMeloqxhnDdBytDtRBinT38atEdumvHbhWL3gEWSQM7S+d9LrkAkf1HoOzy+Wu/AVm0+RgPZ5ZCzMFKVYP1W73kzIBcpdIvetRNwM1vVrmDrFfNbqmx03mGrprDq9WRr7WoNEzQpx4g/0aXo/YkpwmnhhfVte8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c7a917dc-8526-45d3-2e50-08db198c21c4
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB6798.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2023 13:03:05.8334
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yWTO4ySrHY1FVJIVcZrYWwEPLJw+fr8eO7hPboU45AtD6HJRp68rITw5vk8pBrb0aXkOqr2KfKzH1K6m5+6bOg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB7290
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-02-28_09,2023-02-28_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999 mlxscore=0
 adultscore=0 bulkscore=0 malwarescore=0 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2302280106
X-Proofpoint-GUID: fp7TpVyTRymru56ksoif8LLUCgunoOj5
X-Proofpoint-ORIG-GUID: fp7TpVyTRymru56ksoif8LLUCgunoOj5
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
Cc: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Michael Turquette <mturquette@baylibre.com>
Cc: Stephen Boyd <sboyd@kernel.org>
Cc: Philipp Zabel <p.zabel@pengutronix.de>
Cc: linux-renesas-soc@vger.kernel.org
Cc: linux-clk@vger.kernel.org
---
 drivers/clk/renesas/rcar-usb2-clock-sel.c | 1 -
 drivers/clk/renesas/renesas-cpg-mssr.c    | 1 -
 drivers/clk/renesas/rzg2l-cpg.c           | 1 -
 3 files changed, 3 deletions(-)

diff --git a/drivers/clk/renesas/rcar-usb2-clock-sel.c b/drivers/clk/renesas/rcar-usb2-clock-sel.c
index 684d8937965e0..ba6b5bd67786f 100644
--- a/drivers/clk/renesas/rcar-usb2-clock-sel.c
+++ b/drivers/clk/renesas/rcar-usb2-clock-sel.c
@@ -220,4 +220,3 @@ static struct platform_driver rcar_usb2_clock_sel_driver = {
 builtin_platform_driver(rcar_usb2_clock_sel_driver);
 
 MODULE_DESCRIPTION("Renesas R-Car USB2 clock selector Driver");
-MODULE_LICENSE("GPL v2");
diff --git a/drivers/clk/renesas/renesas-cpg-mssr.c b/drivers/clk/renesas/renesas-cpg-mssr.c
index 1a0cdf001b2f2..bfe5dc9a2e36b 100644
--- a/drivers/clk/renesas/renesas-cpg-mssr.c
+++ b/drivers/clk/renesas/renesas-cpg-mssr.c
@@ -1154,4 +1154,3 @@ void __init mssr_mod_reparent(struct mssr_mod_clk *mod_clks,
 }
 
 MODULE_DESCRIPTION("Renesas CPG/MSSR Driver");
-MODULE_LICENSE("GPL v2");
diff --git a/drivers/clk/renesas/rzg2l-cpg.c b/drivers/clk/renesas/rzg2l-cpg.c
index 4bf40f6ccd1d1..93b02cdc98c25 100644
--- a/drivers/clk/renesas/rzg2l-cpg.c
+++ b/drivers/clk/renesas/rzg2l-cpg.c
@@ -1440,4 +1440,3 @@ static int __init rzg2l_cpg_init(void)
 subsys_initcall(rzg2l_cpg_init);
 
 MODULE_DESCRIPTION("Renesas RZ/G2L CPG Driver");
-MODULE_LICENSE("GPL v2");
-- 
2.39.1.268.g9de2f9a303

