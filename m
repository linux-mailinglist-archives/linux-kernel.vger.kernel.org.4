Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC8FF69F672
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Feb 2023 15:22:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231310AbjBVOWb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Feb 2023 09:22:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229561AbjBVOW3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Feb 2023 09:22:29 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19ED43B870;
        Wed, 22 Feb 2023 06:22:02 -0800 (PST)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31M8x0nd001206;
        Wed, 22 Feb 2023 12:17:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=corp-2022-7-12;
 bh=aspHiXkuqcqFtA9ax0QFr5x7bYdaeB7gu8ysck9HvYQ=;
 b=m2syllCzhx2J/qWvg9iLd80h9UmNAmmr7VfBifJXdplwUNm0f18TXbWwfA619ODs5XM0
 B6z2qlpB/Z6/KIKefmPG+oZnVy/o1hHBDksvXkFSUDQ9ljF60ZFsAsDg4IQ7vZgs3p7I
 Ri+MRI2ADqzrYxlrQVpcypsg3OLQ0kgTuhfAcGColCnEbidEj+U4ocdipqBy8MYhMYzK
 6lT1+usQ/YN7c0rAUoMWP8d0Fjk3ORXu2L81e8BmGzistqM6HtbM3StAM11UT6mSFWeC
 9pjwB/kIdrJN2t1XrRZk7ERxO7MDm8LyIX7qulzMfKgl5lFKQ0B2hu768iQlgOB/Z6lM 4g== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ntpqcfrdt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 22 Feb 2023 12:17:09 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 31MAAkMo006784;
        Wed, 22 Feb 2023 12:17:09 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2174.outbound.protection.outlook.com [104.47.56.174])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3ntn4d2212-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 22 Feb 2023 12:17:08 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Qu1EDZ6SjAxQjG62VF6gmJCsMJ1UQbsoSwdjhdF+k1bTiQNNMOc5Y906J9wmBS9dfnGgXv3b3Yp7M3Ps4+EikETv/23ZplhdLEgOW2Wh++tyRJHv9p1oz/lMMowLGAXOIzaDowZ7WSt83Ph6tA46AR07aa4ghUhdUEMZjz/pPQzuIL9a1kgmfPFYn6ooycMcphzvJxBoDx+olxj+zqFxKhuOMt2MkUPEAdGCrPEiQNWT/2umsCPux6CuIivZ9IaLhkCRZoJb5FfStoMBqHU2G/3Tx8mm5R4ThGYKNCUt3Qx/fydOwyU7A7bpBGc/bCGpNAR8sGypH8vYQibSMYcN6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aspHiXkuqcqFtA9ax0QFr5x7bYdaeB7gu8ysck9HvYQ=;
 b=EzS9GRbSizod0R1ufRXOWkGPn7z7LINKrm8gsnG9Jsw+zat38NPPMezCKEZhhLQKbwPv+EWBT+Gipzo5711EOahaiqp8Aiu4egVNgwC3fUbSrr4qdAMV8/3sVMvWpoY2FUnbEHOEJPSLutc6C3KHMKFToepUZGRroXBLBy+EtyBEAlOMSn/+5jRMSMq+MwfDyH3XPhstGq6IIXwloH5hHCakAonkskdbn54cxglxUZU/ijSemOuvrgdApo5En0nwXJV7vknAI8kttCSq60YXp1f8UWbD7dgHS/DCMjAjvLQOPS14mh24+b7Br5SbqP7PIu8YQl4txklsaSK9sEJnhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aspHiXkuqcqFtA9ax0QFr5x7bYdaeB7gu8ysck9HvYQ=;
 b=rvFq+V+H9MGhVSA9FZnDGCyztsnsP5Rl3s33ZHUDzctVXHE2W3MOCrNr+Dr+YPlQ6QueihgvDb6xRMZrJCB31PQ477SkbYZQyiiHYqyolGYbnf6QmwHzL/w3sATVz3wJeaMGyS0oqoHNoImZZ1MOYXfb12fY16zXAWhXWrK9wE4=
Received: from DS0PR10MB6798.namprd10.prod.outlook.com (2603:10b6:8:13c::20)
 by PH8PR10MB6412.namprd10.prod.outlook.com (2603:10b6:510:1c7::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.17; Wed, 22 Feb
 2023 12:17:06 +0000
Received: from DS0PR10MB6798.namprd10.prod.outlook.com
 ([fe80::d0f7:e4fd:bd4:b760]) by DS0PR10MB6798.namprd10.prod.outlook.com
 ([fe80::d0f7:e4fd:bd4:b760%3]) with mapi id 15.20.6134.019; Wed, 22 Feb 2023
 12:17:06 +0000
From:   Nick Alcock <nick.alcock@oracle.com>
To:     mcgrof@kernel.org
Cc:     linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org,
        Hitomi Hasegawa <hasegawa-hitomi@fujitsu.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Joel Stanley <joel@jms.id.au>, linux-gpio@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org
Subject: [PATCH 27/27] kbuild, gpio: gpio-aspeed-sgpio: remove MODULE_LICENSE in non-modules
Date:   Wed, 22 Feb 2023 12:14:53 +0000
Message-Id: <20230222121453.91915-28-nick.alcock@oracle.com>
X-Mailer: git-send-email 2.39.1.268.g9de2f9a303
In-Reply-To: <20230222121453.91915-1-nick.alcock@oracle.com>
References: <20230222121453.91915-1-nick.alcock@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO2P265CA0435.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:e::15) To DS0PR10MB6798.namprd10.prod.outlook.com
 (2603:10b6:8:13c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB6798:EE_|PH8PR10MB6412:EE_
X-MS-Office365-Filtering-Correlation-Id: 93ae362d-01b9-46ae-3f4c-08db14ceb673
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 63UdGFLd6zekgFGmAmuz7QXmdbL3Z6gQUYPWPGeeW/1ZVlhlT3Uq2/6J9XfqDGvzDGhjwQwg6cGR+T0X4DElUI8yT9UndEaW/EUC9Q/+XXcm8qC/v+V8H0rgRD113JbRzcs01XGStPwbPgTUNa995RNHeNmjd2XZyQDNCS6Pk0ljLW0dILlWIoDs6NAyyFMFc2cV3zBHWeetWV2zgx3z50++pTSsLiVVaAsTV9oJ5M0DZgnR1hJlFYtTyB2ISdOIpEauC5UHVQyPx+PLeniAnlOITniBt9wzEvw6SzKXrIrpznfCBVfSBaDZ3y7VBAjJQKXerDg9mdu11DMqzx9jciyg1osx0HhHW8G28/T4UVuNMw/nmXo4GGukcBQ1lSffCMeo5+umYqP4kZOb3y/vGYfPvH578/i0AGkHxkVmSoCuXYbHfXb4D7hMVeureq5YLeo0vYhvH+blMHyR7pd2+0KfiSGTfY6gVfiCrvBy9M/esjtAbjM8npSC4CqarVC+/ta+lpRtbr7vhfCMerUk4p+agy3vWUQI2Npur/qF5ZfSCXwpGbS9GvSf1rD7btX5xWHx7nRHNODu+2S4Soy2IDMcnW6JtlBGPGEA1XpPVv1x8sFV3qeGOLTL9EtLQJY6SObLn1XRitMpDY7LdEzt0A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB6798.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(346002)(136003)(366004)(396003)(39860400002)(376002)(451199018)(478600001)(86362001)(54906003)(2616005)(6512007)(4326008)(316002)(6666004)(6486002)(1076003)(6506007)(186003)(44832011)(7416002)(36756003)(5660300002)(8676002)(38100700002)(66556008)(66946007)(41300700001)(66476007)(8936002)(83380400001)(6916009)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?uwJFhvrieQlpR6SxQopHZ288r5wWNhtNxzX820PtSQ0sfWRrX+NLANjgXeOf?=
 =?us-ascii?Q?jwAbDAQfKVI+FfrAWS1XtKed9hxwMyCrewQPfo58qr9bCbzDm9UYZtuk1BEh?=
 =?us-ascii?Q?VO9jvuAyoojLOFXKwx90FqM8jKIaRVa3v/DnrYv8q0FxqDswtoXlcgxCsZj3?=
 =?us-ascii?Q?6OqJ+gZhr6sr+b2Ayt+w7C44N5gSpht9vhGD4u4wYOof/tlk5Ohv5L3Rg8IO?=
 =?us-ascii?Q?dGEum8T+NSlVXJDQWtdnUVZmdMSNbQR3hCUbUFKWqyVkTryGgE0VYutMIxMI?=
 =?us-ascii?Q?6Nj7oU2s4Yyw/dL0QJaNCDXBSMYvhr8T006ozBa4K7mA2wGRRWhjW/nZFNWH?=
 =?us-ascii?Q?il9wFteg6+6vKo1NfBtvaTsU5kOx/HjeiIVz3OzYmm2WELbl27GQIYH9TGy0?=
 =?us-ascii?Q?ix++J4ktOcZrS8aSuTnssdE9lq85IXKfIzgHjILFF2ArS8nMRSrrUiReQV7v?=
 =?us-ascii?Q?PPvGbMtHYQ0P2sJIPyzUqfDZVvqCx/9zU1yZ8w0tRTJLneLx+2kiVfZ233QH?=
 =?us-ascii?Q?GWPDwzzQ+ToUwDgTlfVLIA33KjoPI1mqpfWnQvUuQnHmkBohgToNTL5/Nxf5?=
 =?us-ascii?Q?GwL1YB+ziyeg2h7v1sAgxLFV9RWoWgDhLsKCRrIe85KR64yACJWJ8RDVMbiP?=
 =?us-ascii?Q?ZoT+EwCiql7mWMZ2LtUk366rgsrq+mwBBvb0pi/M1Yms1RNUWjScr104Rg2V?=
 =?us-ascii?Q?IzTIVEsZnv+8PJ2vL37O65CG9toV0ok6gzav7IHAQ8ZYaVhXsOh2QCYzH5St?=
 =?us-ascii?Q?Q/CMyWce9anG8t3Lf82xk1KfU16SNsIzitDr2KigZzJZmSu0N6rfcYtIwGrt?=
 =?us-ascii?Q?iA1yt3hHHsGcBlsldNrQ+sNQ+JEtsRHOzR1oA6j88/xHaa4ZMyr8fIvLTHV9?=
 =?us-ascii?Q?sQkuq7EUhQvxE260DVZQZEhyhuel/ihm1FU6crq7ykk8yhe4bSMAMXsK3uSw?=
 =?us-ascii?Q?K8jj/41PtgX9KPTB7shtfAj4G4IBfl4BsuA53HL/zpwv09MXYWnqE9tbjKoq?=
 =?us-ascii?Q?BUQiaQYqH5YsRFR0Ev1s0eT3IFV0Tud5+3XCh6ThYqCUaEysWJNU0Jq13QUM?=
 =?us-ascii?Q?pq6RZOmPdVAqHO7zYtLLdsenEAdPSrM4YD482+lhdpYyEaa09zWn9WGn0c/k?=
 =?us-ascii?Q?bhGI4h0AQ+pRhTNBvE5wGEdn28jrIwmymLilffQCpoLTM3b9/JsEkglhtzLa?=
 =?us-ascii?Q?zZ3tuxb1TyziniNG9DoiPMK/QlpjlMeTq5rBNEPKDGgrNAuL/V74PV/RIDYu?=
 =?us-ascii?Q?/WII71ks57uVOFovieW4BhQDk6M/bztw8Gh1fzYaoPzwMMZUqRHXNCPZUO/N?=
 =?us-ascii?Q?MOdc7r4iLJH4E8KAbPrIScikgGbKULCnFnoqEDnO0bwxQuhbhQXTUDAW0GR7?=
 =?us-ascii?Q?PtTvX7spD3yFveS8mVSfDVn5qOS4tl24y7zuxo8lntCxZ1FGK4l0kJJSbLfb?=
 =?us-ascii?Q?dMmRlKRgJqrH//RsYyLIRODKnIEMFq0z5Mg4++zr+zIZufsXYuCdMoG/9RGr?=
 =?us-ascii?Q?VMIP1Hq/Ol0wSye3jsqUQeKJJ4OfR2juERq+ro8GgtOgQcYTUTappPz34Xwt?=
 =?us-ascii?Q?fQUFgQRKGW/qB7q3cbzHH+hMCPGIpVY7bDUh3xJnD/OU69UVNP96AQndXrhx?=
 =?us-ascii?Q?1kGR1Q1rPsmXmynfqGRY2c8=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?uzPCSJgkISbQDCtnb1HUWCHuJ27KtLviYwmfqtg2Kkn3umC9TtMzcKINmEt0?=
 =?us-ascii?Q?IRG8JHIdTv9tBTAX93h6RMP2a8lyOjKW1Vona4e3ALjg4ghR0k+jRkrvOcrh?=
 =?us-ascii?Q?d3YUkWpavqA3I6hnUec1aPhKX22cYzlTOICIA0+TCRzknVrM4CQBc3+URn3s?=
 =?us-ascii?Q?IpSzD1576i7QKiULH5U79DqTcZvhuuZe8CwjE0JWg4P/ibYCBozy83I7XFkK?=
 =?us-ascii?Q?fp3tWE6i4yjlyRl/mHnU/XBFYAVMTxSrQm8yJ8mzn/UjymHjiXxvxCO9yIa+?=
 =?us-ascii?Q?HUunE/nI0UfmedCcPCvYIGVbG2NxW9bWZPWge8sarxh/RfSIAYXVEnXsg0SC?=
 =?us-ascii?Q?1gYWF9oRGi0pbL8HgtrhA3B8hzSShg6eHOd5zYwJZ+QwSEl3KCHxVsAwQWu8?=
 =?us-ascii?Q?5m+VuzOJH6v5NH1pyVjjFq4un3eN5OJ9f/JcoX0Yfzz8omNSMMmgJqR/IBC7?=
 =?us-ascii?Q?WPylYCgP0QQ3Q243GiolKcKkAvqXVmhMDcwbbacu0199ylgId8/FwwIv8Tnf?=
 =?us-ascii?Q?9Jwj/NhddTTjr1Ttbe6Qw/asja7LVjSCU5xtt3/i3nQDCXTTrKaVt3XEDH8f?=
 =?us-ascii?Q?ZphXXo95olnrMBPXjkptI58FRkQAQMwS5Jg82zeuEyQFLZR1kGYC0YWV59N5?=
 =?us-ascii?Q?XQekDprPlyVcv45C1i548u8VE2ap5FSHVvY0u+Vk4mGNUtAPxeRdJBqOTpwl?=
 =?us-ascii?Q?YUym/tkMq35susUmsP1mLsmKfEhycaIMG3Aw5bgimYrycRCbFPPWgtBNAIhZ?=
 =?us-ascii?Q?sPryprMRYtKJ0DoOYDa8UV81C3T8oIZIWdp3Ij91YnIn5lcPiUh7roOW6gqH?=
 =?us-ascii?Q?koXmGGV1p0TMJLCE6ZWdEBdje3AqmzjOedHcE1UMqzMf6uDZO7S/sD6CAv8s?=
 =?us-ascii?Q?+/XuRj01pAul/QPgWkPzeknW9PaQtUuGtJ/PnVGNDXlJ/Wi7aMFQHRaFzKq0?=
 =?us-ascii?Q?mKdxA605mfA5ssXHata92ih0+rSE29uhv17iTjDWDXANnOeqkQ7U8jd4bv3C?=
 =?us-ascii?Q?WKUi?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 93ae362d-01b9-46ae-3f4c-08db14ceb673
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB6798.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Feb 2023 12:17:06.4413
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7PRm9WefjTSPxq/TKMjxKru/aTUCzHHcCa4vaIPfXQOPOrb4lKZimSSZphbwIweL9J2PHmEOLOC94pGR4fehzg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR10MB6412
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-22_05,2023-02-22_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 suspectscore=0
 mlxlogscore=999 adultscore=0 mlxscore=0 bulkscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2302220108
X-Proofpoint-GUID: a945y55iwfG2srEQ1-VYsx06yBLzSpqC
X-Proofpoint-ORIG-GUID: a945y55iwfG2srEQ1-VYsx06yBLzSpqC
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
Cc: Linus Walleij <linus.walleij@linaro.org>
Cc: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Joel Stanley <joel@jms.id.au>
Cc: linux-gpio@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-aspeed@lists.ozlabs.org
---
 drivers/gpio/gpio-aspeed-sgpio.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpio/gpio-aspeed-sgpio.c b/drivers/gpio/gpio-aspeed-sgpio.c
index 454cefbeecf0..ecc94bfded86 100644
--- a/drivers/gpio/gpio-aspeed-sgpio.c
+++ b/drivers/gpio/gpio-aspeed-sgpio.c
@@ -609,4 +609,3 @@ static struct platform_driver aspeed_sgpio_driver = {
 
 module_platform_driver_probe(aspeed_sgpio_driver, aspeed_sgpio_probe);
 MODULE_DESCRIPTION("Aspeed Serial GPIO Driver");
-MODULE_LICENSE("GPL");
-- 
2.39.1.268.g9de2f9a303

