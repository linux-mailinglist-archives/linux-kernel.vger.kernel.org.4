Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8DEF5FAD89
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Oct 2022 09:31:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229778AbiJKHbQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Oct 2022 03:31:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229621AbiJKHbM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Oct 2022 03:31:12 -0400
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2070.outbound.protection.outlook.com [40.107.100.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DED8D89963;
        Tue, 11 Oct 2022 00:31:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DiiowVbglOKGGyrDS0HXUXB2znztMrRFNUvFxCadq5bKqAB7dpiaJwSzbneJeRvFspOypjEkgXDwsCtNd2YUViYeVPPXR1imWCr71aFl66gwGkK1In9CAmARHt+o+z7an3VRy87Lgvm3AYyuxPWgwzP5q2zDl2TIdSlxIZ+2zdFjCZOzfR+drQOmN46MULyTiWdORpGkfWRQwwkSbBuuYA2m+T/vB/YBZQH0dsG4OJDHHNhF3jQdDbWXb0+lYJK2bDtoKad85iZjsqbgwlwnpquygy38bOJWSdCMMmCb/s77kdB91ZNo3LymKA824fU+3aD2/6+L3+k2A3AU17TUAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4aAilchLUyFzYu7R2ar51OG3JjCCop8tq2BNI3BuRI8=;
 b=XiPCX1XVifNE5EV5MOmVreUh8exb63WiSaqpx3NxENX7T83GGcEbWugsK80x89fF0CCIRaBqwGi2tYmUEHexAkdfcuzZtAGcIEEhzv7l0ia2JHaWWuxJsSi0LSB8QZ6ueVdECoiHfY/BUeKt0tkTkq9+aKd+lMSvGwuN8U9uW673QWcuPXxj9Q97lk0ZdQN6q3Hm9SJCd6NGhmrMNkeko55V5eRCMatfaKzxIn66rFciIEZ7LcDnx3Lx0/2CN1fMV7JvjOizEpxKE9ruWh3ZiIJ2prRqbNzdmiKyQXW+HaT7AhLMLwf9TY1B9J0ClFniIVKH+4Oe4iF6FSolr5+YgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4aAilchLUyFzYu7R2ar51OG3JjCCop8tq2BNI3BuRI8=;
 b=XXbe97NLq8JQFKKlqRpbh2UyrOzpgS0DZ4+grgX2+M3tKyzDTFc+6riNgCD+Pbf404rerEm7nnHtvZf8NuF3Xx5ByV+H3Et8XvqhtObddslP+0ZiumaAL5Wza8UTGa3pi+9b7JCk5eGahK2hRZkDxSADoZKQbBkhdtV60l7ikks=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5040.namprd12.prod.outlook.com (2603:10b6:5:38b::19)
 by BL1PR12MB5029.namprd12.prod.outlook.com (2603:10b6:208:31d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5709.15; Tue, 11 Oct
 2022 07:30:53 +0000
Received: from DM4PR12MB5040.namprd12.prod.outlook.com
 ([fe80::6579:a8ca:b90b:c3fb]) by DM4PR12MB5040.namprd12.prod.outlook.com
 ([fe80::6579:a8ca:b90b:c3fb%6]) with mapi id 15.20.5709.019; Tue, 11 Oct 2022
 07:30:53 +0000
Message-ID: <d63088d7-202b-a550-01e5-345a22de5f7d@amd.com>
Date:   Tue, 11 Oct 2022 13:00:11 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.2
Subject: Re: [PATCH v2 36/36] pinctrl: Clean up headers
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Marc Zyngier <maz@kernel.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Kent Gibson <warthog618@gmail.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Billy Tsai <billy_tsai@aspeedtech.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Chen-Yu Tsai <wenst@chromium.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Samuel Holland <samuel@sholland.org>,
        Horatiu Vultur <horatiu.vultur@microchip.com>,
        =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Phil Edworthy <phil.edworthy@renesas.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Fabien Dessenne <fabien.dessenne@foss.st.com>,
        Prathamesh Shete <pshete@nvidia.com>,
        Basavaraj Natikar <Basavaraj.Natikar@amd.com>,
        linux-gpio@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-media@vger.kernel.org, linux-actions@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, openbmc@lists.ozlabs.org,
        linux-rpi-kernel@lists.infradead.org, alsa-devel@alsa-project.org,
        patches@opensource.cirrus.com, linux-mediatek@lists.infradead.org,
        linux-mips@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-omap@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-msm@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Patrice Chotard <patrice.chotard@foss.st.com>,
        =?UTF-8?Q?Andreas_F=c3=a4rber?= <afaerber@suse.de>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Andrew Jeffery <andrew@aj.id.au>,
        Joel Stanley <joel@jms.id.au>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>,
        Dong Aisheng <aisheng.dong@nxp.com>,
        Fabio Estevam <festevam@gmail.com>,
        Shawn Guo <shawnguo@kernel.org>, Jacky Bai <ping.bai@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        Andy Shevchenko <andy@kernel.org>,
        Sean Wang <sean.wang@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Avi Fishman <avifishman70@gmail.com>,
        Tomer Maimon <tmaimon77@gmail.com>,
        Tali Perry <tali.perry1@gmail.com>,
        Patrick Venture <venture@google.com>,
        Nancy Yuen <yuenn@google.com>,
        Benjamin Fair <benjaminfair@google.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Paul Cercueil <paul@crapouillou.net>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Tony Lindgren <tony@atomide.com>,
        Haojian Zhuang <haojian.zhuang@linaro.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Michal Simek <michal.simek@xilinx.com>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Tomasz Figa <tomasz.figa@gmail.com>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Viresh Kumar <vireshk@kernel.org>,
        Shiraz Hashim <shiraz.linux.kernel@gmail.com>, soc@kernel.org,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Emil Renner Berthing <kernel@esmil.dk>,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
        Masami Hiramatsu <mhiramat@kernel.org>
References: <20221010201453.77401-1-andriy.shevchenko@linux.intel.com>
 <20221010201453.77401-37-andriy.shevchenko@linux.intel.com>
Content-Language: en-US
From:   Basavaraj Natikar <bnatikar@amd.com>
In-Reply-To: <20221010201453.77401-37-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN3PR01CA0048.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:98::23) To DM4PR12MB5040.namprd12.prod.outlook.com
 (2603:10b6:5:38b::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5040:EE_|BL1PR12MB5029:EE_
X-MS-Office365-Filtering-Correlation-Id: ca38ace2-0aa6-48af-0a50-08daab5a876c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: obmo8uE5G1xlBmbDc0fZPLq+En2wJOirh3P1bAL31b3dsjHtwTI2zn5PomqkF6ax18HthN+MR62LfQpJFY6yZIctzyZbfKSt5E2ks4QYsgije19ehFaJR1Vzc7crjwrCO2RLV0a47TiZRTMBcAhUPU4BxsVqFisxZcQS68OJqHcSqYWUrOAlZFGGRLvshGCSQ3JQc7MLBI/dwNQefJ46mGX8XhG8bqt6IGxOXzQ336pwZYr7v2kJj9JNX4CzQTx+VPGZ1ABXlDgu7nkQVU5nka9iMPR5ly9gdN2j6FKk8i25MNhy4m3BVe3jqkSz3wHNSW1SxlRDFJm/KZv5SfyKes6CjIZgp2b5Vqq7LKKOIn+vrx+YUMd5IbU2KvOvii1VVgBswAFhpGCzHsXAT0Fk1x52FpJ+EGTm1fGxYX6NyFhdnGElsve9n1AgbaryQ43JPrM9f9QIq3yZWyF9RvwCSpVoDI/2774+9MIp9UCTNxKxUJ2CAzCDkekomN1hMpVE4DraUGsAiJAIEypkjAtZ0ZJWyGRVvmjnv3SDJ7Etsxu5fZ5sdkY/TrWzpEKzyF1A5qgdu0GGlGEWUohFjXpdnv5wNi7JZTJpxdRX8FJ70RGoNjdviBVTmF5FUmVEjL0+N0IX6Rr6hTMbAvNOiDXqa8i67ILGyrGNIq89C+pd5HLncCImeHPYTtfnnob+QJTlXZWMbpjEY5DQKaMp1jWvUS3edjh55xL/EnTCO5n4QfB7nAFK6nss+5Zvyx2dmq1BTqXunU7o+wlBYr1WTz4zxni19SmdPRyLJtcafH1yI/Df958vsbqWlnZniL5nHO5e
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5040.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(366004)(136003)(396003)(39860400002)(346002)(451199015)(8936002)(6666004)(31696002)(54906003)(110136005)(7416002)(30864003)(6512007)(6506007)(53546011)(26005)(2906002)(6486002)(5660300002)(7406005)(7336002)(7366002)(41300700001)(66556008)(66476007)(4326008)(8676002)(316002)(66946007)(186003)(83380400001)(2616005)(921005)(38100700002)(478600001)(36756003)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?T1RWOE9yUWtSQWs4NG1JdkFIdVpXa3RsbzR6ek5GcFNPQ3VzU3laRDMwUVpU?=
 =?utf-8?B?eVZYWERKb2hIZWZUd29waXNQRWtNN1I5V3hTVzBERjlCbmpMYzc2VlhtZzdp?=
 =?utf-8?B?VzhwMTY2d2R2d096YkFZeXJRSXlWa1gwVzBESDVtaHZKSjlUYkFVN2lJUTEz?=
 =?utf-8?B?aS9ab3hBUWExN0U1cEFnaU9UUG5aS0JQejlzRXBCejJlUjY5UEFiMGJCenl3?=
 =?utf-8?B?VldDaENaaDZyUkMxVG1EWFJhbi9IL3FFM2NFblp4ZDFtYmw2TjFVcmRCOUFl?=
 =?utf-8?B?ckZ3bFl1WlNxMi80WFFIYklhNnh4K0dGMktXamRKKzVUNDVOUzkvMWFSSTZO?=
 =?utf-8?B?UzB4bVFCK0gwS3hvckMwUzQ4UDlCVjlCT0psY3B0bVZHamNYYVVOeUUrYjhL?=
 =?utf-8?B?eHdTUjRPdW1LY0ZuZDlES1NpOVRCL0ZQUkdhNmIxYTBHTnU1YzN0akFQNUlk?=
 =?utf-8?B?NlV4WURxZ1pMc3h5b3RWaVZTTjFDK3FDU2pqa2JwMmZ0bkZ0WUtjMC9TZnV6?=
 =?utf-8?B?UnBDdnlINWl4MzZMaUpYK1pqWnRYQjlVcHFqNTExMG51VHVpRXNibGl5bXV4?=
 =?utf-8?B?Qit3T1gxSUxERXBQbEg0YTJYelM4MFJMR3R6YU5oeEM1WGR2aUM4WEV0ektZ?=
 =?utf-8?B?cDFZeE1rSkVTdDdkb25JSUQrZzVmOEhpaTlSSEFTMXZVdWNIYVZhZkpwQVpp?=
 =?utf-8?B?WkxkOUZnRnVZcGh1bldaQW9GbWhxdUU4WFc1NFZuMU5LWU9QbTlha01TclpQ?=
 =?utf-8?B?NjRib3lIMm1ONGM3Z1J3UjFoYlV3cFQxTFdVQUJsb3M2OXFTMk02eEFsbjgy?=
 =?utf-8?B?RDVxMzVka0xuZTVaTFNzcEZWL0hkMnNCK2JBVnpUbmhqSnFjTlIzNTJQZERj?=
 =?utf-8?B?bC85QTJQajNTS2lPdGFEdUFwcFNid1JxcnE3cG9IR3pMeDRjcHlWYVB1eXNo?=
 =?utf-8?B?dkJBN3I3dmFLVWRqM25jWHFxY1pBVkVwQTNpSUc4QzE0OFdubTdCUlE3bUVN?=
 =?utf-8?B?WTcyTVRaQURmTzh0L0xhdVVhUmdvSXVucmlybnhremhtVmVGNXNlV2lyTFFB?=
 =?utf-8?B?aXdDSFppS1MwM0VaVXNkOVl0TEtjWDV3TmxEY0VybVBoNW84NC9SeVk5U1dl?=
 =?utf-8?B?dllsV0JXNi9YNUZoTDRhT0c2MzN5OXJ6YVphZFNORDlFcjR1dlJmbkVtU1pZ?=
 =?utf-8?B?dGFQQkpxUzNzaFBhUUZENUF0aWcvUzBHYnZaMjRhNWJwWUd4WStlb09UR3BI?=
 =?utf-8?B?dTVFajhmNC84VTZ6bHQrODI0RndlNFFGR1RXMXliaEg0NnRkdVI4VlhkWGx4?=
 =?utf-8?B?TWRYRjhPQWFuOVhkMlFNZkZUcTRjTEE4WDVmUit4NDQzVVNtOG5veHBKT0ZQ?=
 =?utf-8?B?Rnp4cmx2andUMFA3R2V5STVTSG52dnFpd0pQcDEzV3MxaVdSVktxMXpUcHA5?=
 =?utf-8?B?b2tnM2haMlRCQXpWNmUvNHFnY2RPMWFRbWFzMUxmWWFDbzVlQVRsMFdqZXcr?=
 =?utf-8?B?d1NUN1pFZ0RGb3BwQjFpYlJGUkJNd1M1WWlVejV6K1NMNUxZSzZGTU1peUcz?=
 =?utf-8?B?dVdsQ2YzZk14TjhwUVB2NjFTTy90YVVBbzdDa213bU1lb25PM0gzekRRUk5K?=
 =?utf-8?B?bndydVpScWRZYjZMT1BFTkFQQ1p1bWdmTmQ2N2FSRlJmNGw2QjlWMkJJbUx3?=
 =?utf-8?B?Q2RjWXlTNHNPZTZ1aENNY3JRK2RtQTY4RFkwbVBPU3BHOFpkeWs2d1ltRzhl?=
 =?utf-8?B?TCthYkc4VVUyTWViMU5WY0UvWnZxdytTWWNhRnJlREt1eEhHN0V6R3ArMTJJ?=
 =?utf-8?B?S25IeUoxd1l5ZWo2MU9wNmFxYmIzWVJoaERHRHdCcDVnd0dZQ0djaTNqdW9a?=
 =?utf-8?B?YTJkSmI1UDVpYmJHVkZNM25JWDJtcEJhbFZwazREazY1Ym9jYmZmcE5iNGNO?=
 =?utf-8?B?S1NyOGM1NFVjeWJQczBtS0I3Y3BaMFJIMmJMTVdaTElCb0tsK2FrQnVsL1hY?=
 =?utf-8?B?YzdmTjZ2YldjYkpGeTdKZEhpVUJvS2FsMnNCdXJLN0cxc0NxSXVHMDdzME5y?=
 =?utf-8?B?cWVCVnllWHVrdkZVdnpHdWRJZExVTVhQekpycTlVNnBNVDdIbE9jOTl5ZWFY?=
 =?utf-8?Q?qoE12/qHUr3u9A6YRWfoXT1d7?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ca38ace2-0aa6-48af-0a50-08daab5a876c
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5040.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2022 07:30:53.6257
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: j2wXmvHzKVNrCE528VhE64zmZh5y3UsdZRUIFhTo/HGD3UuE9BcUf42QTIhWMPqI77QcYtmF6ch3D8liS2EuRQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5029
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 10/11/2022 1:44 AM, Andy Shevchenko wrote:
> There is a few things done:
> - include only the headers we are direct user of
> - when pointer is in use, provide a forward declaration
> - add missed headers
> - group generic headers and subsystem headers
> - sort each group alphabetically
>
> While at it, fix some awkward indentations.
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/pinctrl/core.c                  | 19 ++++++++-------
>  drivers/pinctrl/core.h                  | 12 +++++++++-
>  drivers/pinctrl/devicetree.h            |  6 +++++
>  drivers/pinctrl/pinconf.h               | 10 ++++++++
>  drivers/pinctrl/pinctrl-utils.h         |  5 ++++
>  drivers/pinctrl/pinmux.c                | 17 ++++++++------
>  drivers/pinctrl/pinmux.h                | 11 +++++++++
>  include/linux/pinctrl/consumer.h        | 31 +++++++++++--------------
>  include/linux/pinctrl/devinfo.h         |  6 +++--
>  include/linux/pinctrl/machine.h         |  8 ++++---
>  include/linux/pinctrl/pinconf-generic.h | 23 ++++++++++--------
>  include/linux/pinctrl/pinctrl.h         | 18 +++++++-------
>  include/linux/pinctrl/pinmux.h          |  5 ++--
>  13 files changed, 110 insertions(+), 61 deletions(-)
>
> diff --git a/drivers/pinctrl/core.c b/drivers/pinctrl/core.c
> index 9e57f4c62e60..655f9502e73f 100644
> --- a/drivers/pinctrl/core.c
> +++ b/drivers/pinctrl/core.c
> @@ -12,19 +12,21 @@
>   */
>  #define pr_fmt(fmt) "pinctrl core: " fmt
>  
> -#include <linux/kernel.h>
> -#include <linux/kref.h>
> -#include <linux/export.h>
> -#include <linux/init.h>
> +#include <linux/debugfs.h>
>  #include <linux/device.h>
> -#include <linux/slab.h>
>  #include <linux/err.h>
> +#include <linux/export.h>
> +#include <linux/init.h>
> +#include <linux/kernel.h>
> +#include <linux/kref.h>
>  #include <linux/list.h>
> -#include <linux/debugfs.h>
>  #include <linux/seq_file.h>
> +#include <linux/slab.h>
> +
>  #include <linux/pinctrl/consumer.h>
> -#include <linux/pinctrl/pinctrl.h>
> +#include <linux/pinctrl/devinfo.h>
>  #include <linux/pinctrl/machine.h>
> +#include <linux/pinctrl/pinctrl.h>
>  
>  #ifdef CONFIG_GPIOLIB
>  #include "../gpio/gpiolib.h"
> @@ -33,9 +35,8 @@
>  
>  #include "core.h"
>  #include "devicetree.h"
> -#include "pinmux.h"
>  #include "pinconf.h"
> -
> +#include "pinmux.h"
>  
>  static bool pinctrl_dummy_state;
>  
> diff --git a/drivers/pinctrl/core.h b/drivers/pinctrl/core.h
> index 840103c40c14..4d0bdb9fb99b 100644
> --- a/drivers/pinctrl/core.h
> +++ b/drivers/pinctrl/core.h
> @@ -9,12 +9,22 @@
>   */
>  
>  #include <linux/kref.h>
> +#include <linux/list.h>
>  #include <linux/mutex.h>
>  #include <linux/radix-tree.h>
> -#include <linux/pinctrl/pinconf.h>

Removing pinconf.h from the core.h may cause build failure in other files
because where-ever core.h is included to use “struct pinconf_ops”, there
is a need to include pinconf.h.

With that fixed,

Reviewed-by: Basavaraj Natikar <Basavaraj.Natikar@amd.com>

Thanks,
--
Basavaraj

> +#include <linux/types.h>
> +
>  #include <linux/pinctrl/machine.h>
>  
> +struct dentry;
> +struct device;
> +struct device_node;
> +struct module;
> +
> +struct pinctrl;
> +struct pinctrl_desc;
>  struct pinctrl_gpio_range;
> +struct pinctrl_state;
>  
>  /**
>   * struct pinctrl_dev - pin control class device
> diff --git a/drivers/pinctrl/devicetree.h b/drivers/pinctrl/devicetree.h
> index efa80779de4f..def76aba99d1 100644
> --- a/drivers/pinctrl/devicetree.h
> +++ b/drivers/pinctrl/devicetree.h
> @@ -5,8 +5,14 @@
>   * Copyright (C) 2012 NVIDIA CORPORATION. All rights reserved.
>   */
>  
> +#include <linux/errno.h>
> +
> +struct device_node;
>  struct of_phandle_args;
>  
> +struct pinctrl;
> +struct pinctrl_dev;
> +
>  #ifdef CONFIG_OF
>  
>  void pinctrl_dt_free_maps(struct pinctrl *p);
> diff --git a/drivers/pinctrl/pinconf.h b/drivers/pinctrl/pinconf.h
> index be7311373299..694bfc9961fa 100644
> --- a/drivers/pinctrl/pinconf.h
> +++ b/drivers/pinctrl/pinconf.h
> @@ -10,6 +10,16 @@
>   * Author: Linus Walleij <linus.walleij@linaro.org>
>   */
>  
> +#include <linux/errno.h>
> +
> +struct dentry;
> +struct device_node;
> +struct seq_file;
> +
> +struct pinctrl_dev;
> +struct pinctrl_map;
> +struct pinctrl_setting;
> +
>  #ifdef CONFIG_PINCONF
>  
>  int pinconf_check_ops(struct pinctrl_dev *pctldev);
> diff --git a/drivers/pinctrl/pinctrl-utils.h b/drivers/pinctrl/pinctrl-utils.h
> index cec407a8cc4e..4108ee2dd6d0 100644
> --- a/drivers/pinctrl/pinctrl-utils.h
> +++ b/drivers/pinctrl/pinctrl-utils.h
> @@ -9,6 +9,11 @@
>  #ifndef __PINCTRL_UTILS_H__
>  #define __PINCTRL_UTILS_H__
>  
> +#include <linux/pinctrl/machine.h>
> +
> +struct pinctrl_dev;
> +struct pinctrl_map;
> +
>  int pinctrl_utils_reserve_map(struct pinctrl_dev *pctldev,
>  		struct pinctrl_map **map, unsigned *reserved_maps,
>  		unsigned *num_maps, unsigned reserve);
> diff --git a/drivers/pinctrl/pinmux.c b/drivers/pinctrl/pinmux.c
> index f94d43b082d9..6bd7ac37a0e0 100644
> --- a/drivers/pinctrl/pinmux.c
> +++ b/drivers/pinctrl/pinmux.c
> @@ -13,19 +13,22 @@
>  #define pr_fmt(fmt) "pinmux core: " fmt
>  
>  #include <linux/ctype.h>
> -#include <linux/kernel.h>
> -#include <linux/module.h>
> -#include <linux/init.h>
> +#include <linux/debugfs.h>
>  #include <linux/device.h>
> -#include <linux/slab.h>
> -#include <linux/radix-tree.h>
>  #include <linux/err.h>
> +#include <linux/init.h>
> +#include <linux/kernel.h>
>  #include <linux/list.h>
> -#include <linux/string.h>
> -#include <linux/debugfs.h>
> +#include <linux/module.h>
> +#include <linux/radix-tree.h>
>  #include <linux/seq_file.h>
> +#include <linux/slab.h>
> +#include <linux/string.h>
> +
>  #include <linux/pinctrl/machine.h>
> +#include <linux/pinctrl/pinctrl.h>
>  #include <linux/pinctrl/pinmux.h>
> +
>  #include "core.h"
>  #include "pinmux.h"
>  
> diff --git a/drivers/pinctrl/pinmux.h b/drivers/pinctrl/pinmux.h
> index 72fcf03eaa43..ea6f99c24aa5 100644
> --- a/drivers/pinctrl/pinmux.h
> +++ b/drivers/pinctrl/pinmux.h
> @@ -9,6 +9,17 @@
>   *
>   * Author: Linus Walleij <linus.walleij@linaro.org>
>   */
> +
> +#include <linux/types.h>
> +
> +struct dentry;
> +struct seq_file;
> +
> +struct pinctrl_dev;
> +struct pinctrl_gpio_range;
> +struct pinctrl_map;
> +struct pinctrl_setting;
> +
>  #ifdef CONFIG_PINMUX
>  
>  int pinmux_check_ops(struct pinctrl_dev *pctldev);
> diff --git a/include/linux/pinctrl/consumer.h b/include/linux/pinctrl/consumer.h
> index 019fecd75d0c..4729d54e8995 100644
> --- a/include/linux/pinctrl/consumer.h
> +++ b/include/linux/pinctrl/consumer.h
> @@ -12,14 +12,15 @@
>  #define __LINUX_PINCTRL_CONSUMER_H
>  
>  #include <linux/err.h>
> -#include <linux/list.h>
> -#include <linux/seq_file.h>
> +#include <linux/types.h>
> +
>  #include <linux/pinctrl/pinctrl-state.h>
>  
> +struct device;
> +
>  /* This struct is private to the core and should be regarded as a cookie */
>  struct pinctrl;
>  struct pinctrl_state;
> -struct device;
>  
>  #ifdef CONFIG_PINCTRL
>  
> @@ -33,9 +34,8 @@ extern int pinctrl_gpio_set_config(unsigned gpio, unsigned long config);
>  
>  extern struct pinctrl * __must_check pinctrl_get(struct device *dev);
>  extern void pinctrl_put(struct pinctrl *p);
> -extern struct pinctrl_state * __must_check pinctrl_lookup_state(
> -							struct pinctrl *p,
> -							const char *name);
> +extern struct pinctrl_state * __must_check pinctrl_lookup_state(struct pinctrl *p,
> +								const char *name);
>  extern int pinctrl_select_state(struct pinctrl *p, struct pinctrl_state *s);
>  
>  extern struct pinctrl * __must_check devm_pinctrl_get(struct device *dev);
> @@ -101,9 +101,8 @@ static inline void pinctrl_put(struct pinctrl *p)
>  {
>  }
>  
> -static inline struct pinctrl_state * __must_check pinctrl_lookup_state(
> -							struct pinctrl *p,
> -							const char *name)
> +static inline struct pinctrl_state * __must_check pinctrl_lookup_state(struct pinctrl *p,
> +								       const char *name)
>  {
>  	return NULL;
>  }
> @@ -145,8 +144,8 @@ static inline int pinctrl_pm_select_idle_state(struct device *dev)
>  
>  #endif /* CONFIG_PINCTRL */
>  
> -static inline struct pinctrl * __must_check pinctrl_get_select(
> -					struct device *dev, const char *name)
> +static inline struct pinctrl * __must_check pinctrl_get_select(struct device *dev,
> +							       const char *name)
>  {
>  	struct pinctrl *p;
>  	struct pinctrl_state *s;
> @@ -171,14 +170,13 @@ static inline struct pinctrl * __must_check pinctrl_get_select(
>  	return p;
>  }
>  
> -static inline struct pinctrl * __must_check pinctrl_get_select_default(
> -					struct device *dev)
> +static inline struct pinctrl * __must_check pinctrl_get_select_default(struct device *dev)
>  {
>  	return pinctrl_get_select(dev, PINCTRL_STATE_DEFAULT);
>  }
>  
> -static inline struct pinctrl * __must_check devm_pinctrl_get_select(
> -					struct device *dev, const char *name)
> +static inline struct pinctrl * __must_check devm_pinctrl_get_select(struct device *dev,
> +								    const char *name)
>  {
>  	struct pinctrl *p;
>  	struct pinctrl_state *s;
> @@ -203,8 +201,7 @@ static inline struct pinctrl * __must_check devm_pinctrl_get_select(
>  	return p;
>  }
>  
> -static inline struct pinctrl * __must_check devm_pinctrl_get_select_default(
> -					struct device *dev)
> +static inline struct pinctrl * __must_check devm_pinctrl_get_select_default(struct device *dev)
>  {
>  	return devm_pinctrl_get_select(dev, PINCTRL_STATE_DEFAULT);
>  }
> diff --git a/include/linux/pinctrl/devinfo.h b/include/linux/pinctrl/devinfo.h
> index a48ff69acddd..9e8b559e1253 100644
> --- a/include/linux/pinctrl/devinfo.h
> +++ b/include/linux/pinctrl/devinfo.h
> @@ -14,11 +14,15 @@
>  #ifndef PINCTRL_DEVINFO_H
>  #define PINCTRL_DEVINFO_H
>  
> +struct device;
> +
>  #ifdef CONFIG_PINCTRL
>  
>  /* The device core acts as a consumer toward pinctrl */
>  #include <linux/pinctrl/consumer.h>
>  
> +struct pinctrl;
> +
>  /**
>   * struct dev_pin_info - pin state container for devices
>   * @p: pinctrl handle for the containing device
> @@ -42,8 +46,6 @@ extern int pinctrl_init_done(struct device *dev);
>  
>  #else
>  
> -struct device;
> -
>  /* Stubs if we're not using pinctrl */
>  
>  static inline int pinctrl_bind_pins(struct device *dev)
> diff --git a/include/linux/pinctrl/machine.h b/include/linux/pinctrl/machine.h
> index e987dc9fd2af..0639b36f43c5 100644
> --- a/include/linux/pinctrl/machine.h
> +++ b/include/linux/pinctrl/machine.h
> @@ -11,7 +11,7 @@
>  #ifndef __LINUX_PINCTRL_MACHINE_H
>  #define __LINUX_PINCTRL_MACHINE_H
>  
> -#include <linux/bug.h>
> +#include <linux/kernel.h>	/* ARRAY_SIZE() */
>  
>  #include <linux/pinctrl/pinctrl-state.h>
>  
> @@ -149,16 +149,18 @@ struct pinctrl_map {
>  #define PIN_MAP_CONFIGS_GROUP_HOG_DEFAULT(dev, grp, cfgs)		\
>  	PIN_MAP_CONFIGS_GROUP(dev, PINCTRL_STATE_DEFAULT, dev, grp, cfgs)
>  
> +struct pinctrl_map;
> +
>  #ifdef CONFIG_PINCTRL
>  
>  extern int pinctrl_register_mappings(const struct pinctrl_map *map,
> -				unsigned num_maps);
> +				     unsigned num_maps);
>  extern void pinctrl_unregister_mappings(const struct pinctrl_map *map);
>  extern void pinctrl_provide_dummies(void);
>  #else
>  
>  static inline int pinctrl_register_mappings(const struct pinctrl_map *map,
> -					   unsigned num_maps)
> +					    unsigned num_maps)
>  {
>  	return 0;
>  }
> diff --git a/include/linux/pinctrl/pinconf-generic.h b/include/linux/pinctrl/pinconf-generic.h
> index 2422211d6a5a..940fc4e9e17c 100644
> --- a/include/linux/pinctrl/pinconf-generic.h
> +++ b/include/linux/pinctrl/pinconf-generic.h
> @@ -11,9 +11,12 @@
>  #ifndef __LINUX_PINCTRL_PINCONF_GENERIC_H
>  #define __LINUX_PINCTRL_PINCONF_GENERIC_H
>  
> -#include <linux/device.h>
> +#include <linux/types.h>
> +
>  #include <linux/pinctrl/machine.h>
>  
> +struct device_node;
> +
>  struct pinctrl_dev;
>  struct pinctrl_map;
>  
> @@ -196,25 +199,25 @@ int pinconf_generic_dt_node_to_map(struct pinctrl_dev *pctldev,
>  void pinconf_generic_dt_free_map(struct pinctrl_dev *pctldev,
>  		struct pinctrl_map *map, unsigned num_maps);
>  
> -static inline int pinconf_generic_dt_node_to_map_group(
> -		struct pinctrl_dev *pctldev, struct device_node *np_config,
> -		struct pinctrl_map **map, unsigned *num_maps)
> +static inline int pinconf_generic_dt_node_to_map_group(struct pinctrl_dev *pctldev,
> +		struct device_node *np_config, struct pinctrl_map **map,
> +		unsigned *num_maps)
>  {
>  	return pinconf_generic_dt_node_to_map(pctldev, np_config, map, num_maps,
>  			PIN_MAP_TYPE_CONFIGS_GROUP);
>  }
>  
> -static inline int pinconf_generic_dt_node_to_map_pin(
> -		struct pinctrl_dev *pctldev, struct device_node *np_config,
> -		struct pinctrl_map **map, unsigned *num_maps)
> +static inline int pinconf_generic_dt_node_to_map_pin(struct pinctrl_dev *pctldev,
> +		struct device_node *np_config, struct pinctrl_map **map,
> +		unsigned *num_maps)
>  {
>  	return pinconf_generic_dt_node_to_map(pctldev, np_config, map, num_maps,
>  			PIN_MAP_TYPE_CONFIGS_PIN);
>  }
>  
> -static inline int pinconf_generic_dt_node_to_map_all(
> -		struct pinctrl_dev *pctldev, struct device_node *np_config,
> -		struct pinctrl_map **map, unsigned *num_maps)
> +static inline int pinconf_generic_dt_node_to_map_all(struct pinctrl_dev *pctldev,
> +		struct device_node *np_config, struct pinctrl_map **map,
> +		unsigned *num_maps)
>  {
>  	/*
>  	 * passing the type as PIN_MAP_TYPE_INVALID causes the underlying parser
> diff --git a/include/linux/pinctrl/pinctrl.h b/include/linux/pinctrl/pinctrl.h
> index 487117ccb1bc..31fe992412f0 100644
> --- a/include/linux/pinctrl/pinctrl.h
> +++ b/include/linux/pinctrl/pinctrl.h
> @@ -11,20 +11,20 @@
>  #ifndef __LINUX_PINCTRL_PINCTRL_H
>  #define __LINUX_PINCTRL_PINCTRL_H
>  
> -#include <linux/radix-tree.h>
> -#include <linux/list.h>
> -#include <linux/seq_file.h>
> -#include <linux/pinctrl/pinctrl-state.h>
> -#include <linux/pinctrl/devinfo.h>
> +#include <linux/types.h>
>  
>  struct device;
> +struct device_node;
> +struct gpio_chip;
> +struct module;
> +struct seq_file;
> +
> +struct pin_config_item;
> +struct pinconf_generic_params;
> +struct pinconf_ops;
>  struct pinctrl_dev;
>  struct pinctrl_map;
>  struct pinmux_ops;
> -struct pinconf_ops;
> -struct pin_config_item;
> -struct gpio_chip;
> -struct device_node;
>  
>  /**
>   * struct pingroup - provides information on pingroup
> diff --git a/include/linux/pinctrl/pinmux.h b/include/linux/pinctrl/pinmux.h
> index 9a647fa5c8f1..a7e370965c53 100644
> --- a/include/linux/pinctrl/pinmux.h
> +++ b/include/linux/pinctrl/pinmux.h
> @@ -11,11 +11,10 @@
>  #ifndef __LINUX_PINCTRL_PINMUX_H
>  #define __LINUX_PINCTRL_PINMUX_H
>  
> -#include <linux/list.h>
> -#include <linux/seq_file.h>
> -#include <linux/pinctrl/pinctrl.h>
> +#include <linux/types.h>
>  
>  struct pinctrl_dev;
> +struct pinctrl_gpio_range;
>  
>  /**
>   * struct pinmux_ops - pinmux operations, to be implemented by pin controller

