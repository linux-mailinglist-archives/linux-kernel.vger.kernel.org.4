Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 901BB6F8426
	for <lists+linux-kernel@lfdr.de>; Fri,  5 May 2023 15:35:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232642AbjEENfO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 May 2023 09:35:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232641AbjEENfK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 May 2023 09:35:10 -0400
Received: from mx0b-002e3701.pphosted.com (mx0b-002e3701.pphosted.com [148.163.143.35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8896203F5;
        Fri,  5 May 2023 06:35:08 -0700 (PDT)
Received: from pps.filterd (m0134424.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 345D7nr5031858;
        Fri, 5 May 2023 13:34:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=pps0720;
 bh=5nVUMixfyKgFflRWjWO7SBNJ1+vCRxS+imaf1mzdmbk=;
 b=mPRLlHcs1qbX/fZ8/pb7FFGw7izyqVQMoIJDK7nCEPbFJtO5zYESAFuoHE2DLrFs0E8s
 JraeOtSJ8s/QrTyMo7TzztaqDeKavywxyvIJUXTnwKiSbR1jMvYMbkFG9WkvULOr0uQM
 uYtZoPB0S13d+g34j0e1xzYRomLyy/i6y1Tsa/zsTcP6/xt0AOCjGCzg24YdFHFnFwpj
 MiQJWa7dzCHy/+NboCkn5OYEe34Y1Y0v+HOuH6dsOhLTmthDgKytMBwDEKaRf5kXx7lI
 b3pdViosaGaFAHM7FWa3KUX7mHgZFChz0lfXao8AnWaupooQIgl/t8zRll6OSUbdS1Eb Fg== 
Received: from p1lg14881.it.hpe.com (p1lg14881.it.hpe.com [16.230.97.202])
        by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 3qd2df096k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 05 May 2023 13:34:36 +0000
Received: from p1wg14924.americas.hpqcorp.net (unknown [10.119.18.113])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by p1lg14881.it.hpe.com (Postfix) with ESMTPS id 0697B8047A1;
        Fri,  5 May 2023 13:34:29 +0000 (UTC)
Received: from p1wg14923.americas.hpqcorp.net (10.119.18.111) by
 p1wg14924.americas.hpqcorp.net (10.119.18.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Fri, 5 May 2023 01:34:29 -1200
Received: from p1wg14919.americas.hpqcorp.net (16.230.19.122) by
 p1wg14923.americas.hpqcorp.net (10.119.18.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42
 via Frontend Transport; Fri, 5 May 2023 01:34:29 -1200
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (192.58.206.38)
 by edge.it.hpe.com (16.230.19.122) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Fri, 5 May 2023 01:34:29 -1200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=guPvZN2Ir4ViwjtXio4ZGiyGs8Xl8jwEfwdRu4R3otsJXGCYtUS8asqHpZTUitKJ5ryqw0Uo6fNSiA9STL91Mv4Vkh8ZwB6BfHs3uYnj/f8naNdYTZ6TH0/7v3U2qVZ/g7uSWQ3jG+8FspAhwYVVjTC4ADJEQSrZCCMiz7vDLq6bvU4X5e0pD9qzM/+uRS6Y9ut+6I9qC/xv8pLsfErKPtXZtjAVJVG3MFiwVaMIvoH9QfcScmR87SF48lgrx6u7c9Pd6sQ15y9ar9kyEwd0bVI7ci/ktCTuQ6DYJ6Ypw8gwYOrKkLFsG4RssX6t5pevbpn/hBLR56b858ORULHhMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5nVUMixfyKgFflRWjWO7SBNJ1+vCRxS+imaf1mzdmbk=;
 b=RYY9aZY4JxDWImH7WzX6uRfRiYb03WOCQnxVIqxL39YY8OsUUc0iROOfbu3r3yKDN9qxFYa60yVPPd3p9PMCNPK1JXLBDQKkZ7ziM3LjSN4OhjPuJH+cL+U1Fzg91v22ssncu79BfagJKDcPSpHEt3hzRRU3zaVAsD+9a+HUFygOPDqoFjUXVJ3WgxYNx0CmOdX9DOOcomILSKqRdBYVGTr248yLy1S9VdcX8oRkT4EhHK/ItQwWOwgcDpoyqMWNUMiqVHyeyx/hgVarhy0u3FfyL09kpLBPJnqIoLRNS1wk4NzwK/+gtP3wUTAqJ7jw2UiKHH1Mb1frfcKWkv0g9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hpe.com; dmarc=pass action=none header.from=hpe.com; dkim=pass
 header.d=hpe.com; arc=none
Received: from DM4PR84MB1927.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:8:4e::10) by
 MW5PR84MB1402.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:303:1c0::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.26; Fri, 5 May
 2023 13:34:27 +0000
Received: from DM4PR84MB1927.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::2a07:1ac6:6523:8682]) by DM4PR84MB1927.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::2a07:1ac6:6523:8682%7]) with mapi id 15.20.6363.027; Fri, 5 May 2023
 13:34:27 +0000
From:   "Hawkins, Nick" <nick.hawkins@hpe.com>
To:     Rob Herring <robh@kernel.org>
CC:     "soc@kernel.org" <soc@kernel.org>,
        Christian Marangi <ansuelsmth@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Russell King <linux@armlinux.org.uk>,
        Masahiro Yamada <masahiroy@kernel.org>,
        =?utf-8?B?QW5kcmVhcyBGw6RyYmVy?= <afaerber@suse.de>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        Antoine Tenart <atenart@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        "Jerome Brunet" <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Joel Stanley <joel@jms.id.au>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        "Alexandre Belloni" <alexandre.belloni@bootlin.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Lars Persson <lars.persson@axis.com>,
        "Scott Branden" <sbranden@broadcom.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Andre Przywara <andre.przywara@arm.com>,
        Baruch Siach <baruch@tkos.co.il>,
        Wei Xu <xuwei5@hisilicon.com>,
        "Verdun, Jean-Marie" <verdun@hpe.com>,
        "Maxime Coquelin" <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Vladimir Zapolskiy <vz@mleia.com>,
        "Andrew Lunn" <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Lubomir Rintel <lkundrak@v3.sk>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Peter Rosin <peda@axentia.se>, Nancy Yuen <yuenn@google.com>,
        Benjamin Fair <benjaminfair@google.com>,
        =?utf-8?B?Sm9uYXRoYW4gTmV1c2Now6RmZXI=?= <j.neuschaefer@gmx.net>,
        Thierry Reding <thierry.reding@gmail.com>,
        "Bjorn Andersson" <andersson@kernel.org>,
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
        "Bartosz Golaszewski" <brgl@bgdev.pl>, Nishanth Menon <nm@ti.com>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Enric Balletbo i Serra <eballetbo@gmail.com>,
        "Javier Martinez Canillas" <javier@dowhile0.org>,
        Michal Simek <michal.simek@xilinx.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@axis.com" <linux-arm-kernel@axis.com>
Subject: Re: [PATCH 4/4] ARM: dts: Move .dts files to vendor sub-directories
Thread-Topic: [PATCH 4/4] ARM: dts: Move .dts files to vendor sub-directories
Thread-Index: AQHZfwH1R66+RWQKnUO/r5vaV6ZRhK9LUjaAgAAIkwA=
Date:   Fri, 5 May 2023 13:34:27 +0000
Message-ID: <7984D288-FA63-43B4-956D-8D7FA6A34C08@hpe.com>
References: <20230504-arm-dts-mv-v1-4-2c8e51a2b6c4@kernel.org>
 <9d67cbbf-9be8-13c0-98fb-d0146bba79c8@linux-m68k.org>
In-Reply-To: <9d67cbbf-9be8-13c0-98fb-d0146bba79c8@linux-m68k.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Microsoft-MacOutlook/16.72.23043001
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR84MB1927:EE_|MW5PR84MB1402:EE_
x-ms-office365-filtering-correlation-id: 61711a48-15ce-40df-fb93-08db4d6d72b9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: VeW/YbQEfn3qCfK2kjM1r9bcAFz03LdfMIuInOxuPJf1WQlKHGigtmDz/S18SX/xeRVUsjDe0uEAQb/f61DkjyhPqQxLwxjhsoVkLeQ6Ojd+9T2S4OUb+nNdcEpeoxjq7oB6ThYX6aINFXvAOli3WoNpHm6OfRPL+hakEh6tikOUKVFwP62ajGmV1/fYgjrydunCw4/ztJJOe74Iozmr27okmSTYmgXh0bIWoDfQ0CjjB9WFamy+7lwW93eUScSj/IviTJ+AWS60V4r0X5LfasfO51qlrcMkE/pAqARlPhpOM3Cv7wwgwkEZvSb1lKXYaK3sWvLj+vvJzPliqlr5O1X19Fq7Nbe3MA8uV64Q2Jefbwk581MNrDGMuM0JaDsrQa8DDYHg+xnWmpmLK4OWPI6dPM3diHBjzLYMG++R+oQgAnrffBY2LhSplow/tGn1VJ7OuJvc2kuUjUdGIx2zpbBlvr7LjajY99XZvcjGGi/lLVRTe5o/kynAvrLk5EcjnS6JjzJ7T5bI4fB96lrvX7zGo3YgElbKJ0pHQqhhKaC/qNaD6NWCtZtH6t45S5sNFPn9Ai1p7GLcHK7PnC17tSeSDRSJjncTgVq2xKE+BLVDrwSDr1vXgicRLykyA9zHyUkxUdKPT/THjHnxj8cV0IlZ6w1qpS06DpP8PGzHvzyD/zAvLoG+fTWhCHWTmKCw
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR84MB1927.NAMPRD84.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(136003)(346002)(366004)(376002)(39860400002)(396003)(451199021)(64756008)(4326008)(2906002)(7406005)(7366002)(7416002)(41300700001)(8936002)(66446008)(5660300002)(8676002)(316002)(66946007)(66556008)(6916009)(76116006)(66476007)(91956017)(478600001)(54906003)(86362001)(38070700005)(71200400001)(38100700002)(82960400001)(122000001)(33656002)(83380400001)(36756003)(2616005)(53546011)(6486002)(6506007)(6512007)(186003)(142923001)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cjFLbitDZ3pKL0FhbzR2dkE2UnpkSTRtU3IyWE9jNDNzdzRVWkNVMzIyNnM3?=
 =?utf-8?B?cUhwZEpOa01NUHpLRlY1aTdYSzlUdTBMOVpHVFFGL1NONlNOOEpPeDd0RXNM?=
 =?utf-8?B?Sk9wYm13a3V4WjdDK29CYmtValBYQmpHV3VjM0Z4elFmbGdNVGwxRllsMGhn?=
 =?utf-8?B?TThlRUtBNHJzdVkyaDNNUml6ZmpMSVZLY3M1UVIwL1o4RjBiMEdnUks1K0Ux?=
 =?utf-8?B?SG1VNEt1MFhSaUhEZ3lTNlhQMXVFM1oxT0plejdBczJod0E4VklTTEdxUTlF?=
 =?utf-8?B?UE5UZ3pCbkZCd1ZqQklDb25HUENXb0RQdW0xa3lCUTBXdG90SWJvdDdRQy9u?=
 =?utf-8?B?SzJ5bnpHYnJqWFd2ZWdjNmwyV0pFS1pHczE1SnBZQlMvZXRBcFJlN1V4ZW4y?=
 =?utf-8?B?ZFArekVGOEF2N2pFbUtFT3hQQUFQb1N1UDZxWkx0YlBFV0dGaURzRU1kVmJh?=
 =?utf-8?B?ZTJwdVRjWVBOK1JjMmllMDJTaTJJSmtVUFJYL3VTNU5HOGxLbkFxRlorajdP?=
 =?utf-8?B?a3cwYTV3S2s1c3U1Rk9OTnBZMEpPL05oSEdhaW11QVN0azYwKzNBaHRhVHF5?=
 =?utf-8?B?S2ZZbDJHOFhNaXBIV2RPb1dUUnRiWWlzQTRZaTV6ZTlSd3hyQm5qK3FqeTh0?=
 =?utf-8?B?bmtJTGJ3WXhhWG9rMVZMWkxKNzZIaGdLdTVjbUZRKy85UmQzYUF3TmREcDM2?=
 =?utf-8?B?UmZlcnVMa2djTG5LT0RFa2pNVmdaam5mVElsVDVnbldDYlVPQ0NacnEvK3BV?=
 =?utf-8?B?cUlwam1UbExPMTc3bVVUaXhPYURZTGt1NTZGZmZIQTlPUCtndVVnV3o3NHB2?=
 =?utf-8?B?dmxTMEkxa0FEaWU0bURzRXl1V0JPZlZwaGE2TVZDNmtyUy9qRzZGeWtTbWU1?=
 =?utf-8?B?cXc3QVNvZjZ6K0tzS0RZMG1kL0gwSGUwSUcwYzdVMEZPUGZ6QjNmeWlxdnA4?=
 =?utf-8?B?VUNreElIL0IxUG1nZXR1V2FRcjl5eS91bnF4Mk5lWlRGM0c3Y2NMcUR1YWNp?=
 =?utf-8?B?TFZKZU5mNWdMWlhzT1l0TW5kU2Y0UXMzUCtIOEprMGwwSUNPMHo1V05VcXZq?=
 =?utf-8?B?M3hmVC9mY2ZLbiswVDBCN1hBMUtuVms3MVVGUm9ObDBYMXhPWkM1WHRVUUJk?=
 =?utf-8?B?QUtBdG5mM1JmQm1DMVdiV3dNalQ3RVdPZ3dCOUpsckdNcFhmZE9Ba01mNHVy?=
 =?utf-8?B?YSszWjVkU0NVcitvaE1JVi9NeFd0S2puYjc1bC9rOUdhQWdRTmFkLytQVmxV?=
 =?utf-8?B?OXR3cFFzUm0yS3B1UjZuTEd6bEtzazZCNzdldXRma01ML2xZd1RGa2thSTY5?=
 =?utf-8?B?MlpQK21YZHVRQm1kOXBiTGtYZWFUNW9MSmNRNnkxSVpTSmVZRDh0YThCczQ4?=
 =?utf-8?B?aGVOaVRLcUZVUXRDS1JOYXJYc2NoaUxPcGZFZldWSStnREovQ290MXFLdE82?=
 =?utf-8?B?ZS96WGo2c1ErUnpCelFwMlN2WG41RUNpRmEzTHFyenV2N0o4c2I0QWxSRVBa?=
 =?utf-8?B?QnJySjhUcWJWVW1sRFU2OW5SODk1TC9JODVPR1dsTmFjQVVCdnFySlRBQlJV?=
 =?utf-8?B?R0UwVjJsdWd6Z2lhRlN5dVR0Rll4dUd3NytVVHZ1RHFsdE9BdTIzRXo3bjdi?=
 =?utf-8?B?SUZNeVB0VXJVQXNKaVBpcjRhbzlBY1B3SHluL3NGU3YyaDZ6cXgvTlRZZllu?=
 =?utf-8?B?cUNpcmdKUmxrNzhMdnBOSWw2bHNuSE9tMXBRY3IxZzFWbDJNZ08xZFZodzJ2?=
 =?utf-8?B?WlBzMWhNdXJVaDIzS0Z0SmVLelI1YU9CZWdhYnJXTk1uZGhEWmE2WG5wZ3hh?=
 =?utf-8?B?RC9KRzIxWDdKa1JDM2VVeGd2T1p1bTROc2RUR0JhRENkS2NVYStLR3Y4RzF5?=
 =?utf-8?B?Mk8rVm9iNEY4VXVXREZvZi9rY1EwcFkyS3pOMXNJUEJKWXdNZzBxd3B1c0wy?=
 =?utf-8?B?L0JIejZxTFZwbHRFcGsxb3g0d0NYdTM0L2FmNkk0UXEyWXd1YzJRZG5vV3ZH?=
 =?utf-8?B?c2lNVTlka1l0azNkbW1ualhBNnBTelVZZnNxNmo2QmVqMzF2NXE0c25PbWpw?=
 =?utf-8?B?TmtKcjlFRjlnTm5VNWs1WjVuSkpZb2FsdGZKR1U2TGpTdDFEd1pZVXlLZEs1?=
 =?utf-8?B?T2IyYlBTUDJJVFBXWlg3VWpZK0JlUXJuNzRUbU1lejl3QlZpRHg4YkMrVzEx?=
 =?utf-8?B?MVAySzluK3F3QUhEdnY3Zk5EOUlaSXNUdkNtdzNuaTBnVngrd01PYVpheHFV?=
 =?utf-8?B?ZHhySk90cnVhZkdOclZSZVVRTCt3PT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <3011339ECBAE734F911E7AD6EA681117@NAMPRD84.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR84MB1927.NAMPRD84.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 61711a48-15ce-40df-fb93-08db4d6d72b9
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 May 2023 13:34:27.4315
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 105b2061-b669-4b31-92ac-24d304d195dc
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WuFLmWMvY16drPF5lAZuT0ybl10Npc0RVAZtPwoK1rdlEjAqcLhEqvXY2RjZvXz9bll8Tnb9ywZG5l2nZZlBHw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR84MB1402
X-OriginatorOrg: hpe.com
X-Proofpoint-ORIG-GUID: _SrmxGuznR7qWyokxY_B3P26uHMRDwp-
X-Proofpoint-GUID: _SrmxGuznR7qWyokxY_B3P26uHMRDwp-
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-05_21,2023-05-05_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 bulkscore=0
 phishscore=0 priorityscore=1501 adultscore=0 suspectscore=0
 lowpriorityscore=0 mlxscore=0 malwarescore=0 impostorscore=0 clxscore=1011
 mlxlogscore=651 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2305050113
X-Spam-Status: No, score=-3.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMDUvMDUvMjAyMyAwNToyOSwgUm9iIEhlcnJpbmcgd3JvdGU6DQo+IFRoZSBhcm0gZHRzIGRp
cmVjdG9yeSBoYXMgZ3Jvd24gdG8gMTU1MyBib2FyZHMgd2hpY2ggbWFrZXMgaXQgYSBiaXQNCj4g
dW53aWVsZHkgdG8gbWFpbnRhaW4gYW5kIHVzZS4gUGFzdCBhdHRlbXB0cyBzdGFsbGVkIG91dCBk
dWUgdG8gcGxhbnMgdG8NCj4gbW92ZSAuZHRzIGZpbGVzIG91dCBvZiB0aGUga2VybmVsIHRyZWUu
IERvaW5nIHRoYXQgaXMgbm8gbG9uZ2VyIHBsYW5uZWQNCj4gKGFueSB0aW1lIHNvb24gYXQgbGVh
c3QpLCBzbyBsZXQncyBnbyBhaGVhZCBhbmQgZ3JvdXAgLmR0cyBmaWxlcyBieQ0KPiB2ZW5kb3Jz
LiBUaGlzIG1vdmUgYWxpZ25zIGFybSB3aXRoIGFybTY0IC5kdHMgZmlsZSBzdHJ1Y3R1cmUuDQo+
DQo+IERvaW5nIHRoaXMgZW5hYmxlcyBidWlsZGluZyBzdWJzZXRzIG9mIGR0cyBmaWxlcyBieSB2
ZW5kb3IgZWFzaWx5DQo+IHdpdGhvdXQgY2hhbmdpbmcga2VybmVsIGNvbmZpZ3M6DQo+DQo+IG1h
a2UgYWxseWVzY29uZmlnDQo+IG1ha2UgYXJjaC9hcm0vYm9vdC9kdHMvdGkvDQo+DQo+IFRoZXJl
J3Mgbm8gY2hhbmdlIHRvIGR0YnNfaW5zdGFsbCBhcyB0aGUgZmxhdCBzdHJ1Y3R1cmUgaXMgbWFp
bnRhaW5lZCBvbg0KPiBpbnN0YWxsLg0KPg0KPiBUaGUgbmFtaW5nIG9mIHZlbmRvciBkaXJlY3Rv
cmllcyBpcyByb3VnaGx5IGluIHRoaXMgb3JkZXIgb2YgcHJlZmVyZW5jZToNCj4gLSBNYXRjaGlu
ZyBvcmlnaW5hbCBhbmQgY3VycmVudCBTb0MgdmVuZG9yIHByZWZpeC9uYW1lIChlLmcuIHRpLCBx
Y29tKQ0KPiAtIEN1cnJlbnQgdmVuZG9yIHByZWZpeC9uYW1lIGlmIHN0aWxsIGFjdGl2ZWx5IHNv
bGQgKFNvQ3Mgd2hpY2ggaGF2ZQ0KPiAgIGJlZW4gYXF1aXJlZCkgKGUuZy4gbnhwL2lteCkNCj4g
LSBFeGlzdGluZyBwbGF0Zm9ybSBuYW1lIGZvciBvbGRlciBwbGF0Zm9ybXMgbm90IHNvbGQvbWFp
bnRhaW5lZCBieSBhbnkNCj4gICBjb21wYW55IChlLmcuIGdlbWluaSwgbnNwaXJlKQ0KPg0KPiBU
aGUgd2hvbGUgbW92ZSB3YXMgc2NyaXB0ZWQgd2l0aCB0aGUgZXhjZXB0aW9uIG9mIE1BSU5UQUlO
RVJTLg0KPg0KPiBTaWduZWQtb2ZmLWJ5OiBSb2IgSGVycmluZyA8cm9iaEBrZXJuZWwub3JnPg0K
PiAtLS0NCg0KRm9yIEhQRToNCg0KQWNrZWQtYnk6IE5pY2sgSGF3a2lucyA8bmljay5oYXdraW5z
QGhwZS5jb20+DQoNClRoYW5rcyENCg0KLU5pY2sNCg0K
