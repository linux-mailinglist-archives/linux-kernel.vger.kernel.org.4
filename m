Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDF046F7CF2
	for <lists+linux-kernel@lfdr.de>; Fri,  5 May 2023 08:30:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230293AbjEEGaq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 May 2023 02:30:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229893AbjEEGan (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 May 2023 02:30:43 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2052.outbound.protection.outlook.com [40.107.220.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECEF3150EB;
        Thu,  4 May 2023 23:30:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bwQcmWKe38kdUC87+CAlCAAlXltDKuqYgsbHYfEkDfNAEkZNENSxvQDnUqwEUCkWTzbd3WxDfiU9Oam9gZGid6USPHS6vtH6WdchCODPfIBOlieaAba6Q+fnuOu1qydwEaSy3R7UxJmhoxxpxbnAYHOENtjvRvbQwu1vokLpQna3H0v3jmoSfuEFmVdyuz0H4UVcOtb4am+kAYjbiTUfWaloRA2hzeQT9oLwsk+YruyUObia6plzvEWDv7dxheZehPx4aTqmwZyfH19Qu6RLhoIYQAVY2r0GJ7Dt7uq+ICx99j1qXgClSzCFwg3w3zBtm99omJjWWUva0Bw9S1IoOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Pq1evS0wRlueNU2sLO8jdprSqFPNNe1YaRGcjaleu78=;
 b=F4lghgWe80BpuYOmg4cEQKsBcxP6svAEMxLAontHGZ/hp0wsmvPg5GRZytIOPKjPX2rrqW3YnJGyNJD5W/nIjRoKwu59HZvTmn6Y6eh9tdwehDxUnJnQcJf8n9HWhRPXyzAhGJAjDIcLt1DraqN2+NLirWNC7xgFojlXuP/neTX0Nzyd9By56gVnne95M5JeVqgNoDVQ3RKQQMF4FKzOo0WZDSRnrcG7vE6659O9+lsGfcNU26fFC7Ghb5gW1eWcKOVTYwOeuNoIgZu/siES8QqvnGJmePzbLzZknvrCk28+WBHE/cI6YRgTp6bN0j2+t+LFmhYCpigYECytumR/RQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Pq1evS0wRlueNU2sLO8jdprSqFPNNe1YaRGcjaleu78=;
 b=wYMB0OX5j7DZ6ixC0MnE9XwPwqfgRmo5teZ/vhvvBf/dnRvM6PSV5I602zQSgwfC2ix4KCo6UzJrwvZptFdT1kE9uAEOOC4JrB03TwGtoC/bqrg7Qilc1o9fBA4DXRTYqPWcj/Qim6GkcJ6PILV6UtMm+s2SgcETQZLxJEgP1tA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB4758.namprd12.prod.outlook.com (2603:10b6:a03:a5::28)
 by MN2PR12MB4222.namprd12.prod.outlook.com (2603:10b6:208:19a::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.27; Fri, 5 May
 2023 06:30:30 +0000
Received: from BYAPR12MB4758.namprd12.prod.outlook.com
 ([fe80::20b9:d472:1981:cf94]) by BYAPR12MB4758.namprd12.prod.outlook.com
 ([fe80::20b9:d472:1981:cf94%4]) with mapi id 15.20.6363.026; Fri, 5 May 2023
 06:30:29 +0000
Message-ID: <8dd4296a-47be-4536-5194-1bf25fa40f2a@amd.com>
Date:   Fri, 5 May 2023 08:29:45 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH 4/4] ARM: dts: Move .dts files to vendor sub-directories
To:     Rob Herring <robh@kernel.org>, soc@kernel.org,
        Christian Marangi <ansuelsmth@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Russell King <linux@armlinux.org.uk>,
        Masahiro Yamada <masahiroy@kernel.org>,
        =?UTF-8?Q?Andreas_F=c3=a4rber?= <afaerber@suse.de>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        Antoine Tenart <atenart@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Joel Stanley <joel@jms.id.au>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Lars Persson <lars.persson@axis.com>,
        Scott Branden <sbranden@broadcom.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Andre Przywara <andre.przywara@arm.com>,
        Baruch Siach <baruch@tkos.co.il>,
        Wei Xu <xuwei5@hisilicon.com>,
        Jean-Marie Verdun <verdun@hpe.com>,
        Nick Hawkins <nick.hawkins@hpe.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Vladimir Zapolskiy <vz@mleia.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Lubomir Rintel <lkundrak@v3.sk>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Peter Rosin <peda@axentia.se>, Nancy Yuen <yuenn@google.com>,
        Benjamin Fair <benjaminfair@google.com>,
        =?UTF-8?Q?Jonathan_Neusch=c3=a4fer?= <j.neuschaefer@gmx.net>,
        Thierry Reding <thierry.reding@gmail.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Heiko Stuebner <heiko@sntech.de>,
        Daniel Palmer <daniel@thingy.jp>,
        Romain Perier <romain.perier@gmail.com>,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Viresh Kumar <vireshk@kernel.org>,
        Shiraz Hashim <shiraz.linux.kernel@gmail.com>,
        Patrice Chotard <patrice.chotard@foss.st.com>,
        Marek Vasut <marex@denx.de>, Qin Jian <qinjian@cqplus1.com>,
        Jisheng Zhang <jszhang@kernel.org>,
        Tony Lindgren <tony@atomide.com>,
        Paul Barker <paul.barker@sancloud.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Nishanth Menon <nm@ti.com>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Enric Balletbo i Serra <eballetbo@gmail.com>,
        Javier Martinez Canillas <javier@dowhile0.org>,
        Michal Simek <michal.simek@xilinx.com>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@axis.com
References: <20230504-arm-dts-mv-v1-0-2c8e51a2b6c4@kernel.org>
 <20230504-arm-dts-mv-v1-4-2c8e51a2b6c4@kernel.org>
Content-Language: en-US
From:   Michal Simek <michal.simek@amd.com>
In-Reply-To: <20230504-arm-dts-mv-v1-4-2c8e51a2b6c4@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR0802CA0007.eurprd08.prod.outlook.com
 (2603:10a6:800:aa::17) To BYAPR12MB4758.namprd12.prod.outlook.com
 (2603:10b6:a03:a5::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB4758:EE_|MN2PR12MB4222:EE_
X-MS-Office365-Filtering-Correlation-Id: 664116bc-bfde-4d57-5b5c-08db4d32387f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gCbLlO1kJGRLntXUVW/5BN9d5cQWfmbSPNsRUxM21wouGovERIUBIqSgY9MfgPDAZitVijVjGRTsizVZs9iD8/Hkd52WBY8tAsLLrdWP1OdxqLmaJhwgfDKEsiSOERkxxXW2/JskUnw71pjfGwzF2sM3iCduU/WzvokYXQafuBTsSmr+J62OI/dn5qyO05yjGks7fd42HZijx9YWd8gPLZtAdN14qKDXiaclb8cR1qq6UyJmjK/cqpG5Me2gXV2WY7lZJwEFnkm4CMtK9rvpWlcpmhZCYz6yq07yUd8fqynD6Lj/ReXmxLt2UjbuHcy4tDH6BMh11G2h6wb87Ch8K5yrxeLp31h7cpos9SxSCVeFx0unMijxoFDa2AIR1/w5Svx+Iz4R+pjRQVV0rgFh8mFKUhEaY110CySr8dfqr8ui1mq/b0V/OtvUoXNLXw2qqAhmqowCc+Bp7ST0Cv0S3J6K8RKs1ofXZP95iSuYFAQ10bFGtKJruXSqyO1eZIWbjk4f7f/bPrSnW3avNN6iZpZump1JUOoL0Hs9Ci22mBthBgh09/4d7w208XmFhqF9R6eLfCmtyp19w9Twcd75nsA+dHMUX/nQNhJLMz2Pz6APO1zsLYVDkFLS+Y+b3qyg5Q2+CMV0hxoBfZ+vRRMmeC8p+PqAUZVNiKNeuIDjb2/s4rqd0HC1qL3f3SVGlP8f
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB4758.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(366004)(39860400002)(136003)(376002)(346002)(451199021)(31686004)(66556008)(66476007)(4326008)(66946007)(6666004)(478600001)(6486002)(316002)(110136005)(36756003)(86362001)(31696002)(2616005)(6506007)(26005)(6512007)(8936002)(5660300002)(8676002)(7416002)(44832011)(7406005)(2906002)(7366002)(41300700001)(1191002)(186003)(921005)(38100700002)(142923001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QWdLZU1DTzk5SGVrbmdyT0cwS1ppVUpnMXJ0RTNPZkxaSnFPVUw2eWUrQzI2?=
 =?utf-8?B?SHBZV1dKcGY0VUQ3WE9scXdYR0lJWFAxRWlPM1ZOYXhCOFlmWnRON1lXYUJz?=
 =?utf-8?B?TjFVbEpRbjBwcTMwNjJXOFQ5cm1MY0JDTVU5dnozbFZWYkNHMkRpSGVKaU1Z?=
 =?utf-8?B?bTBIVERIblpZamRpcDN1QndaWmoxTS9lVldISWNMeGdsa1BUdENESEx2U01R?=
 =?utf-8?B?czZSTVVRazNvS0EyblZ6ajdTalhsYzFDZWFMMVI2aTdNYzRrYkdyQk1DZGtY?=
 =?utf-8?B?YldJYTNsYXZuaWhLaXlWa0pZMFF0OUFVUnE4alB3djlocEZ2TlFuRlFua0hz?=
 =?utf-8?B?R0MvTVY4aWpTL3NVbXBrdTJXM1BjSzdzWGs4dDlSTVhKSFI0WXYycENDcWFY?=
 =?utf-8?B?STdxSHFTdldKcjVLZ3Y5cW1wVCt5UC8vam1lQTVkZElXNVd2WlJHVndsRlg0?=
 =?utf-8?B?ZzJaZ0Yza0NmRnBrb3VTaG5JelF4WDd3YUZQdklHanBOKzB5RkF0MVYyemtP?=
 =?utf-8?B?QUtSZDJqMTdKbmFncERvNExScUhSWTY4MG9nM1diQ3ovbGRsdkpKdDRrTzM4?=
 =?utf-8?B?Z2FkaDZ0TEhteEpBTk41ODNzeEdDRHNKOUw4djIxR01GQVdTTVRDMkhaeU5T?=
 =?utf-8?B?M1I2WkJtMk1vaXhUWFc2VThySmFobnpnZGZlQ0xkWXp3SHN0UW9CaVQxWUJW?=
 =?utf-8?B?WDM0WjkzREg0RDZvL3cvQVZFL0Y4aTFzU3hGRFl4MGIxYldodWVIcHcyMVBT?=
 =?utf-8?B?akhpRFUyTVJzK0k2bDJLTllvSWdpRFBqZUFJTENROW5HWTlLbFZaN0gwdm9s?=
 =?utf-8?B?TFZxVXBGQXNxa01MKzdEL2orUlBnS1FGOWJJd1l4RmVqbStacDBwWWpzbmln?=
 =?utf-8?B?OGNybXF5RG44WW1mbUpnaUZrSmsybnRSNXZlblg4aGZ2b2lPajZGcUQvVFNs?=
 =?utf-8?B?Ym4weG5US2phWU5ZeUJnaFpIRDVqQUkyTHlzazRQa2ZhTWdtNjJaT2JqQ0Qy?=
 =?utf-8?B?QzlrYlFOaS82VW44QU9RZEtXUy91dDY1OWErVDNQVGNlTDZSUTNlcmZ1Mktw?=
 =?utf-8?B?Q3FRMzV0N0dKWW5VQXdUMUtRWUp4ZHFXTnh5NC9ucW1EaDBieTVpLzh3a0JE?=
 =?utf-8?B?VkVjNUdOQnhnekdYRko0eHphaXZ2ZUtZbjYyMzVaRGRrcE9iU1J2U2ZFdU1R?=
 =?utf-8?B?SW1ZUlEydDR1Tlg0Y20wMFBnL0ZEUkRhbUtEYWxaVGNWRUJ6U1RNdkw1WTYy?=
 =?utf-8?B?WmtMc0tlS3FiNjEvTE56djBhQzBBL0cyand4YVNlb200bWZ6NzhjVEw1TDBs?=
 =?utf-8?B?QURRcGV5ejFVMkxoYWlqK2lxc3N6aE9RYWlKTDQvQUNTcENwUVlHZnU5L0hv?=
 =?utf-8?B?MkhDMFdMV2tXQk1XNjRLVCtQdHdmMm53azE0MGUycTZsSzNRc1VEb2ovUkl0?=
 =?utf-8?B?U1VTMzhPT1Fkd1NUd0g1Y3lTN3JHR1llNmcxQzhxVlpzcEtFSm1Uck90WWdO?=
 =?utf-8?B?QUMyS1YxM08rTndVK1oyYzhGZk9CL0YrbTBKazluYStoSTRYWUlWSHFDQlN2?=
 =?utf-8?B?ZTE0RTdZWjJXcHJiNGxEWGtaYTRPVExBUk5taVFXRVhhaDhXVU9reERvcm5B?=
 =?utf-8?B?cVk2U09nYndiY05NbThDajJScmROaXZNS3BMYmU5dU5QWThxai9EZ0FpYVh4?=
 =?utf-8?B?ZGhqQkkxOGFSUkQyTDdIN05NYUhja0l1ay83cVhwV0hnVkg2Nm9xbUZia2w2?=
 =?utf-8?B?UHRpVHY1Um9uQkR5UFk0VVV4MGF6SVJZQks5NEl2RXBmVjhmSko1azU4cTBB?=
 =?utf-8?B?SGZDeEZ4dkF1OFAyZVlycGF3MGNKb3BndFlZWmpsTEZOdytUQ2Fod1UzM1Ru?=
 =?utf-8?B?WThpdlpENzdYdmtidFpxNmNXTk1XQUNxS1dMemgrSDM4aitQRTd6RzJLeVQz?=
 =?utf-8?B?OXprSGZqNmxKclk2Qit1QjdnNlB5N1p0SEFxZGMxWFA0NnNYSTJkb0s1ZUNi?=
 =?utf-8?B?ZGQ1Qm9jMEthWEppY3JrTlpHTFBraXU1dU8zSjRTUFFZUEp4ZTlUYXhpT08z?=
 =?utf-8?B?VGc1QzZxdmwza0ZhaWw1ODhYU25hZDg0bG1kc1pGa3ppMFdMY3VVdkxOSGpI?=
 =?utf-8?Q?39mPpVEcQYrixoFDtemGIS28W?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 664116bc-bfde-4d57-5b5c-08db4d32387f
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4758.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2023 06:30:29.8259
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mjgxEY+S+ttBHX4iEQ0H0JIKkXeKdbPtk16Gq1v66KoWi96/y5QkCfPSIo45JBYM
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4222
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


>   arch/arm/boot/dts/xilinx/Makefile                  |   17 +
>   arch/arm/boot/dts/{ => xilinx}/zynq-7000.dtsi      |    0
>   arch/arm/boot/dts/{ => xilinx}/zynq-cc108.dts      |    0
>   arch/arm/boot/dts/{ => xilinx}/zynq-ebaz4205.dts   |    0
>   arch/arm/boot/dts/{ => xilinx}/zynq-microzed.dts   |    0
>   arch/arm/boot/dts/{ => xilinx}/zynq-parallella.dts |    0
>   arch/arm/boot/dts/{ => xilinx}/zynq-zc702.dts      |    0
>   arch/arm/boot/dts/{ => xilinx}/zynq-zc706.dts      |    0
>   .../arm/boot/dts/{ => xilinx}/zynq-zc770-xm010.dts |    0
>   .../arm/boot/dts/{ => xilinx}/zynq-zc770-xm011.dts |    0
>   .../arm/boot/dts/{ => xilinx}/zynq-zc770-xm012.dts |    0
>   .../arm/boot/dts/{ => xilinx}/zynq-zc770-xm013.dts |    0
>   arch/arm/boot/dts/{ => xilinx}/zynq-zed.dts        |    0
>   .../boot/dts/{ => xilinx}/zynq-zturn-common.dtsi   |    0
>   arch/arm/boot/dts/{ => xilinx}/zynq-zturn-v5.dts   |    0
>   arch/arm/boot/dts/{ => xilinx}/zynq-zturn.dts      |    0
>   arch/arm/boot/dts/{ => xilinx}/zynq-zybo-z7.dts    |    0
>   arch/arm/boot/dts/{ => xilinx}/zynq-zybo.dts       |    0

Acked-by: Michal Simek <michal.simek@amd.com> #Xilinx

Thanks,
Michal
