Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91FE2665511
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 08:17:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235731AbjAKHRF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 02:17:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232185AbjAKHRC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 02:17:02 -0500
Received: from IND01-BMX-obe.outbound.protection.outlook.com (mail-bmxind01on2054.outbound.protection.outlook.com [40.107.239.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBBE3DE96;
        Tue, 10 Jan 2023 23:16:59 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y/JQNv1Z5DkC0v9T1qczQZAn6fjEcLX3n0eOV1w8OVD7ebcPO2MmCf173ll3QKD9QReonQYjo5m8muO1/uv7trjdsC7Hzt/q3UWd4dF88gYXqxBP/cEqxM2UyqBTIH45ErvfZ5wgEtBdMlwbfkknvMvyqDnMNhxBwTo1pODtL/WSLjOFK6CqEeGKJDSC6LSPzLSVNaigG+Nl6FJS0FpDyReAkRfFXceSjLD9uJlA154zkrsMwyw9Vf8ffFTSBXrhXf1jLfZh+enFFgceeQKEaUIAGsw2LXn2dSqDCJdeMhES0/JC/f8O+1A1nWeowWEZ+RkgxALhYeKn5rEDCkKFqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2PAFFFk8xFs3rqXp3NMyMivym7MECt67kXf396BhG1M=;
 b=bkebROVma/8nA5esz+1xlvjGkvHd9AW+GtTu+Knm9kfXOmH5ZqpNpOXVlDOFfkrqn8+TrXv59l8e2uaf/8Dh3B55UbHdAyJ+3XcfJousufRZMwoursrhB168QSX3IqJlGRjqbtiboGlPrfRcKGws4FYrrcJ3lK4xWd2BNe/yZoEDLsfEic31DsWjz52wvE/r/iAgzSwyCDlGscQhz2mutIJs42ohYIsM9sSHMgboISUzSz9skz5CmYOL9+NxO5ZhQJTBhHquX+7ccwk4JWTT1DUYsheSADgOmNLeXPIsoeDG/uz3zR3CSTCBj14Ecgb+U+5O+NVZHvxp4u+Gg39v1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siliconsignals.io; dmarc=pass action=none
 header.from=siliconsignals.io; dkim=pass header.d=siliconsignals.io; arc=none
Received: from MA0PR01MB7145.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a01:31::9)
 by MA0PR01MB9268.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a01:be::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.12; Wed, 11 Jan
 2023 07:16:56 +0000
Received: from MA0PR01MB7145.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::e762:50f5:c91e:7e61]) by MA0PR01MB7145.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::e762:50f5:c91e:7e61%4]) with mapi id 15.20.6002.013; Wed, 11 Jan 2023
 07:16:55 +0000
From:   Hardevsinh Palaniya <hardevsinh.palaniya@siliconsignals.io>
To:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "linux-imx@nxp.com" <linux-imx@nxp.com>,
        "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "perex@perex.cz" <perex@perex.cz>,
        "tiwai@suse.com" <tiwai@suse.com>,
        "peng.fan@nxp.com" <peng.fan@nxp.com>,
        "m.felsch@pengutronix.de" <m.felsch@pengutronix.de>,
        "shengjiu.wang@nxp.com" <shengjiu.wang@nxp.com>,
        "Markus.Niebel@ew.tq-group.com" <Markus.Niebel@ew.tq-group.com>,
        "hongxing.zhu@nxp.com" <hongxing.zhu@nxp.com>,
        "tommaso.merciai@amarulasolutions.com" 
        <tommaso.merciai@amarulasolutions.com>,
        Hardevsinh Palaniya <hardevsinh.palaniya@siliconsignals.io>,
        "jun.li@nxp.com" <jun.li@nxp.com>,
        "ckeepax@opensource.cirrus.com" <ckeepax@opensource.cirrus.com>,
        "rf@opensource.cirrus.com" <rf@opensource.cirrus.com>,
        "povik+lin@cutebit.org" <povik+lin@cutebit.org>,
        "pierre-louis.bossart@linux.intel.com" 
        <pierre-louis.bossart@linux.intel.com>,
        "james.schulman@cirrus.com" <james.schulman@cirrus.com>,
        "flatmax@flatmax.com" <flatmax@flatmax.com>,
        "srinivas.kandagatla@linaro.org" <srinivas.kandagatla@linaro.org>,
        "ryan.lee.analog@gmail.com" <ryan.lee.analog@gmail.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
Subject: [PATCH] Support for MAX98090/91 codec in iMX8MM evk
Thread-Topic: [PATCH] Support for MAX98090/91 codec in iMX8MM evk
Thread-Index: AQHZJYqW0X9zj+hpQkK22Ny+RkFTBQ==
Date:   Wed, 11 Jan 2023 07:16:55 +0000
Message-ID: <MA0PR01MB7145CB5A2D487FB713CD7C01FFFC9@MA0PR01MB7145.INDPRD01.PROD.OUTLOOK.COM>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siliconsignals.io;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MA0PR01MB7145:EE_|MA0PR01MB9268:EE_
x-ms-office365-filtering-correlation-id: 3d479f1b-86c0-402c-1506-08daf3a3d22c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: R+7uzeinz2rlAO2MqWpC9R1z5PC2pvxSYjUNuDk0NTunu950cl897t1rGwVaKPXrwG2vaiTv2BYRJwivAJSOC2XSuL5vERxlxrzr7fMEfZprNr18rww7ytBFZjKFSMWasL+euGI4IoUCnf6TY3K/5rlB/9GFSdgwsp1HsaHvZ/d9ecrMh1Jl5Mt1poPFvgd4U8Ns+wIh0b7qPJGSApouOyQs9eUm8cUGnhIT5apeet2B7kSWfDzaKNL3xTfId3mcA3z+KWMbWVKokA2b3/P458ascEi4Vg/EM736pEOTV0n4Y3QYiuj02pxLv7l8/h0b36n0pEHb7zhob4zmw1mNPLbNB1LgHdohCRB+rGjHpASNLo9B008DIlzjiVaUW3/m8D3sTYAa90WLYkB1acYT+aHDN7VyoWQ6Y1jK7n9tI95Or3sDs0+NHsMCQwgHCrE/FTLZgR8SXfrF5C5E4+vNeDAeo5Pic31vnqAykCKlEcKosSk4SqBjGiwT7vnaJJZDAdFITZeuEaYiT3aysAsYExGenFpaTBwMyU9BorB97oZhM9tTyZxOPPHDaZG9TjFPEKqT4erSyK7nN/omPJ7WAEP0ROO2TNidntqYZ0PWlfQ878zmv8RyUpx/cm76IEiBejRL+75MEItWaPnaeteJmj1ISImLunN9/6PWE1bVDT+DptaJSObPo1y5iOd9RPf4kuUHLhZS4wAq5RG4Otddc80oqnHkTLrg3AbBkOsUMDju45yQi0E08aaaB+PnLL+Ey4C4BeW9tXMsw9BWHVslOQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MA0PR01MB7145.INDPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(39830400003)(346002)(136003)(396003)(366004)(376002)(451199015)(110136005)(2906002)(52536014)(33656002)(5660300002)(7416002)(86362001)(44832011)(7406005)(8936002)(38070700005)(55016003)(8676002)(41300700001)(76116006)(66556008)(64756008)(66446008)(66476007)(66946007)(921005)(122000001)(38100700002)(91956017)(316002)(55236004)(53546011)(83380400001)(7696005)(6506007)(71200400001)(26005)(9686003)(478600001)(186003)(32563001)(473944003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?b2tvMDlNUTdUaFoxWTBQL0w2THFHWUc5MEFtam1oUG5GTFIzTzZtTTBOZ3c0?=
 =?utf-8?B?VHlET1lLSndWc3VCN1lDMFgzWW9OczZtZ3NFa1RKWnNRZ09QandlYXdheUlQ?=
 =?utf-8?B?Z1QzLzJNZ1N3TjJmRW44MmFQZmZYek1OelprWkhaaHlSOUJyQWMxb3ZxQlpP?=
 =?utf-8?B?Vk13ZUxxS0pRQzJwRkZIdXlIUVFPWk5lSEZ4Q2FLc2drVzdwN1pwN1FKRnFX?=
 =?utf-8?B?QVhhMzBncE9tRzgwcEtlVzlCRHp2eFRQN0xIVWVaU1FUdW84N085aCtuc0p2?=
 =?utf-8?B?RUZGaEhYYnV6eHd4WmE0aUljLzB5b1IxZi83SHlZUVdWaWVGdXFHNUdjNUsv?=
 =?utf-8?B?akU5UEp2UEdrcU1ac2dUNkxvRmNld0FXckljM283aXJqMEQrM0p5Z2JGZ2hn?=
 =?utf-8?B?UGVzOUtjOExBWVdqenZjcWxhc3lpMFF2UExaOTBwZ1FyZk9CYmFSaVVISUtZ?=
 =?utf-8?B?ZEttMlpMQ1JOcEs1ZCsyOEdXUm9DQWFxSnNrQkVVYnZJZlA1WElpbDdnd3JB?=
 =?utf-8?B?L1hNRThiQUZvWHdRdzBnUUVrdmN0L1RwRmxrSDRGbjcyajA3NTFpRmJRWnlC?=
 =?utf-8?B?MmMxaExEd0ZySmYrRkRBamdNc3U4QjJ2dDNCU21wSUxVcW4vUk1mcDBjZzJx?=
 =?utf-8?B?V2swQWo3OFo0d0tmYlp0WVYxUUIxN1I3ZEVnRExZaXVrNUhzcTFhSVNKYzdH?=
 =?utf-8?B?VFpLZ0Q2OGh5T2FlSGc0Z3Jva1JabUJ0c3FhQjZ5aDV4R0UvQVNTb09lRFJr?=
 =?utf-8?B?SHMzejFzdVJlUk51aE1ENGFNTXRaS1pvSDcvRTZuNlpnaVpOWWgrVmxzZTVY?=
 =?utf-8?B?S0M1ckpuQTZFQTlHeGR1WFVwcjBRZjNvSE5kaVZnSU5yS2Q1Y3dCY1ZwK1Vu?=
 =?utf-8?B?TlVvZG1QUE1MNERyWHFyOUVkV0haeUpWUTVHYlBzNmRBeVpQbU1FV2lwdUgy?=
 =?utf-8?B?eG1QOVRGWTlSQXRVTmI5QVRUWFJWcWdYL1lTUmFzRDB6M04vRW5nSjZ2TVl0?=
 =?utf-8?B?SHpGOXRzOUVGY2RmUTdGaUtrcXpLVW0yN1RXTURiUzZabWxQWUJMUCsvSkU5?=
 =?utf-8?B?b2dTU0JjOElFYlpWdnhFczdFeW9STGRHTzZpY1BvaU5FNCtlVEFyTmcwb3p4?=
 =?utf-8?B?Zk5uSHMyZlZUM0prQ2ExYy9ZYkJaS2VZUlRuZE5DWnI1TnBVN2NHUFpUYnlP?=
 =?utf-8?B?Q241SGN2clZrcEllZUh0dE4wUHBOSVJ6c0RYS25jNkpiUUM4QTVNZmdwQ2F2?=
 =?utf-8?B?T3ZjbXdmVkpPTmJKR1FWWkpleDhPSHhTMm05emZyY1oydFBLT2M0OW5WTzFN?=
 =?utf-8?B?YmhnUUs4ejNGRDlxdGlEYzJiT0gwTGR5dVlReXBnMEkrTzhGV1A2OGlWMTlx?=
 =?utf-8?B?WlRHRGgzNWZqM2pqaSswbDBFUWdBcENWaStLcTB5VjUrZkxYQXlCOEJzSzUz?=
 =?utf-8?B?cXhNRjFyamZLV1Z5R01PNGJBVmV6bWd0ZFJCUjZtL3hMT3ZIdVFFOUsxSG5p?=
 =?utf-8?B?cWIrQ1EvdSt4TUQrQ3lHSmhPS2JSSG1ZZGtNNzFnYkJLR0VRcG1WSEJ2Smhk?=
 =?utf-8?B?Z2pUeFhqY05uaFlYTzdYUG9mTU9PWms4TVNlTjRBYk5CZ2lxTWovZzlRNGcv?=
 =?utf-8?B?NUFoSVFpV21NWnNWeHlXM1NhRHhNSFVKcGI3eU5GUjdJbjJ2RkJNTUVKV3hE?=
 =?utf-8?B?bHFuclJCVWcxa2lFb29RTWNQZlEyWDJGWCtlZlo4QkJFNTJPWHZQQWxpTVZZ?=
 =?utf-8?B?V0pMcjhrOHhBcTRYN0lVT2p5aTFadmJBMjVYQldJUHNCdnY3RDNsMTUzWWJZ?=
 =?utf-8?B?WFpHYWY0QktHczFhWXRRQ05CKy9vbSsxdXRtUE1ld1IybzFtTFNCTDdwMWZC?=
 =?utf-8?B?MWFXdkZZSC8waVJJYm9pZmdzMlRaQTNXYStKQnlQZHhEVHBQcmJPVjVSdmlH?=
 =?utf-8?B?ajM4T0packtnVk1lM0FZUERhNHNuYjRyTkxvVWI0MWwxeUVmZ0w5M3JKUm5Q?=
 =?utf-8?B?RFUwWGxETEZ6ZlVnemo2SDlDOW9UVDBxeVl0b1VkNUJaSVN4Q09oa3N4dFY3?=
 =?utf-8?B?b09ZMXJyRFFNRmFaazEzWE41aENobkEwTW9QSDRrUUJUaDNobkkwVmFRMkI1?=
 =?utf-8?B?cnY1RjZDV2ZMSGZVMlVGMWVjbHV0Zkl5N0ltYU8wR3BDcnp3QXQxZEk3Yy91?=
 =?utf-8?Q?pHgqvKsJ74ruNDiP56v6Jcw=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: siliconsignals.io
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MA0PR01MB7145.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d479f1b-86c0-402c-1506-08daf3a3d22c
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jan 2023 07:16:55.7198
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7ec5089e-a433-4bd1-a638-82ee62e21d37
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: l0umtnjB4EYUBvzPGdeyDGcKXL5zDjt/Gww5iERJqja/TZJS95C4Z6LPWrHUXEkfc62aBbTgl+0B+SXkOz+fBLDgVscsaZXSsu7zJVT7BxRAZyjm0K3tpBbl2HGfHuOb
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MA0PR01MB9268
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogSGFyZGV2c2luaCBQYWxhbml5YSA8aGFyZGV2c2luaC5wYWxhbml5YUBzaWxpY29uc2ln
bmFscy5pbz4KRGF0ZTogU2F0LCA3IEphbiAyMDIzIDE3OjA4OjI4ICswNTMwClN1YmplY3Q6IFtQ
QVRDSF0gU3VwcG9ydCBmb3IgTUFYOTgwOTAvOTEgY29kZWMgaW4gaU1YOE1NIGV2awoKLSBBZGRp
bmcgbm9kZSBmb3IgTUFYOTgwOTAvOTEgaW4gZHRzIGlteDhtbS1ldmsuZHRzaQotIEFkZGluZyB0
cmlzdGF0ZSBvcHRpb24gaW4gPHNvdW5kL3NvYy9jb2RlY3MvS2NvbmZpZz4KClNpZ25lZC1vZmYt
Ynk6IEhhcmRldnNpbmggUGFsYW5peWEgPGhhcmRldnNpbmgucGFsYW5peWFAc2lsaWNvbnNpZ25h
bHMuaW8+CgpkaWZmIC0tZ2l0IGEvYXJjaC9hcm02NC9ib290L2R0cy9mcmVlc2NhbGUvaW14OG1t
LWV2ay5kdHNpIGIvYXJjaC9hcm02NC9ib290L2R0cy9mcmVlc2NhbGUvaW14OG1tLWV2ay5kdHNp
CmluZGV4IGUwYjYwNGFjMGRhNC4uNThmZjYzY2JjOTMwIDEwMDY0NAotLS0gYS9hcmNoL2FybTY0
L2Jvb3QvZHRzL2ZyZWVzY2FsZS9pbXg4bW0tZXZrLmR0c2kKKysrIGIvYXJjaC9hcm02NC9ib290
L2R0cy9mcmVlc2NhbGUvaW14OG1tLWV2ay5kdHNpCkBAIC0xMzIsNiArMTMyLDMyIEBAIHNpbXBs
ZS1hdWRpby1jYXJkLGNvZGVjIHsKIOKAguKAguKAguKAguKAguKAguKAguKAguKAguKAguKAguKA
guKAguKAguKAguKAguKAgmNsb2NrcyA9IDwmY2xrIElNWDhNTV9DTEtfU0FJM19ST09UPjsKIOKA
guKAguKAguKAguKAguKAguKAguKAguKAguKAguKAgn07CiDigILigILigILigILigIJ9OworCivi
gILigILigILigILigIJzb3VuZC1tYXg5ODA5MCB7CivigILigILigILigILigILigILigILigILi
gILigILigIJjb21wYXRpYmxlID0gInNpbXBsZS1hdWRpby1jYXJkIjsKK+KAguKAguKAguKAguKA
guKAguKAguKAguKAguKAguKAgnNpbXBsZS1hdWRpby1jYXJkLG5hbWUgPSAibWF4OTgwOTAtYXVk
aW8iOwor4oCC4oCC4oCC4oCC4oCC4oCC4oCC4oCC4oCC4oCC4oCCc2ltcGxlLWF1ZGlvLWNhcmQs
Zm9ybWF0ID0gImkycyI7CivigILigILigILigILigILigILigILigILigILigILigIJzaW1wbGUt
YXVkaW8tY2FyZCxmcmFtZS1tYXN0ZXIgPSA8JmNwdWRhaT47CivigILigILigILigILigILigILi
gILigILigILigILigIJzaW1wbGUtYXVkaW8tY2FyZCxiaXRjbG9jay1tYXN0ZXIgPSA8JmNwdWRh
aT47CivigILigILigILigILigILigILigILigILigILigILigIJzaW1wbGUtYXVkaW8tY2FyZCx3
aWRnZXRzID0gIlNwZWFrZXJzIiwgIlNwZWFrZXJzIjsKK+KAguKAguKAguKAguKAguKAguKAguKA
guKAguKAguKAgnNpbXBsZS1hdWRpby1jYXJkLHJvdXRpbmcgPQor4oCC4oCC4oCC4oCC4oCC4oCC
4oCC4oCC4oCC4oCC4oCC4oCC4oCC4oCC4oCC4oCC4oCC4oCC4oCC4oCC4oCC4oCC4oCCIlNwZWFr
ZXJzIiwgIlNQS1IiLAor4oCC4oCC4oCC4oCC4oCC4oCC4oCC4oCC4oCC4oCC4oCC4oCC4oCC4oCC
4oCC4oCC4oCC4oCC4oCC4oCC4oCC4oCC4oCCIlNwZWFrZXJzIiwgIlNQS0wiLAor4oCC4oCC4oCC
4oCC4oCC4oCC4oCC4oCC4oCC4oCC4oCC4oCC4oCC4oCC4oCC4oCC4oCC4oCC4oCC4oCC4oCC4oCC
4oCCIklOMSIsICJNSUNCSUFTIiwKK+KAguKAguKAguKAguKAguKAguKAguKAguKAguKAguKAguKA
guKAguKAguKAguKAguKAguKAguKAguKAguKAguKAguKAgiJNSUMxIiwiSU4xIiwKK+KAguKAguKA
guKAguKAguKAguKAguKAguKAguKAguKAguKAguKAguKAguKAguKAguKAguKAguKAguKAguKAguKA
guKAgiJNSUMyIiwiSU4xIjsKKwor4oCC4oCC4oCC4oCC4oCC4oCC4oCC4oCC4oCC4oCC4oCCY3B1
ZGFpOiBzaW1wbGUtYXVkaW8tY2FyZCxjcHUgewor4oCC4oCC4oCC4oCC4oCC4oCC4oCC4oCC4oCC
4oCC4oCC4oCC4oCC4oCC4oCC4oCC4oCCc291bmQtZGFpID0gPCZzYWk1PjsKK+KAguKAguKAguKA
guKAguKAguKAguKAguKAguKAguKAguKAguKAguKAguKAguKAguKAgmRhaS10ZG0tc2xvdC1udW0g
PSA8Mj47CivigILigILigILigILigILigILigILigILigILigILigILigILigILigILigILigILi
gIJkYWktdGRtLXNsb3Qtd2lkdGggPSA8MzI+Owor4oCC4oCC4oCC4oCC4oCC4oCC4oCC4oCC4oCC
4oCC4oCCfTsKKwor4oCC4oCC4oCC4oCC4oCC4oCC4oCC4oCC4oCC4oCC4oCCc2ltcGxlLWF1ZGlv
LWNhcmQsY29kZWMgewor4oCC4oCC4oCC4oCC4oCC4oCC4oCC4oCC4oCC4oCC4oCC4oCC4oCC4oCC
4oCC4oCC4oCCc291bmQtZGFpID0gPCZtYXg5ODA5MD47CivigILigILigILigILigILigILigILi
gILigILigILigILigILigILigILigILigILigIJjbG9ja3MgPSA8JmNsayBJTVg4TU1fQ0xLX1NB
STVfUk9PVD47CivigILigILigILigILigILigILigILigILigILigILigIJ9Owor4oCC4oCC4oCC
4oCC4oCCfTsKIH07CiAKICZBNTNfMCB7CkBAIC0zMzksNiArMzY1LDE0IEBAICZpMmMzIHsKIOKA
guKAguKAguKAguKAgnBpbmN0cmwtMCA9IDwmcGluY3RybF9pMmMzPjsKIOKAguKAguKAguKAguKA
gnN0YXR1cyA9ICJva2F5IjsKIAor4oCC4oCC4oCC4oCC4oCCbWF4OTgwOTA6IG1heDk4MDkwQDEw
IHsKK+KAguKAguKAguKAguKAguKAguKAguKAguKAguKAguKAgiNzb3VuZC1kYWktY2VsbHMgPSA8
MD47CivigILigILigILigILigILigILigILigILigILigILigIJjb21wYXRpYmxlID0gIm1heGlt
LG1heDk4MDkwIjsKK+KAguKAguKAguKAguKAguKAguKAguKAguKAguKAguKAgnJlZyA9IDwweDEw
PjsKK+KAguKAguKAguKAguKAguKAguKAguKAguKAguKAguKAgmNsb2NrcyA9IDwmY2xrIElNWDhN
TV9DTEtfU0FJNV9ST09UPjsKK+KAguKAguKAguKAguKAguKAguKAguKAguKAguKAguKAgmNsb2Nr
LW5hbWVzID0gIm1jbGsiOwor4oCC4oCC4oCC4oCC4oCCfTsKKwog4oCC4oCC4oCC4oCC4oCCcGNh
NjQxNjogZ3Bpb0AyMCB7CiDigILigILigILigILigILigILigILigILigILigILigIJjb21wYXRp
YmxlID0gInRpLHRjYTY0MTYiOwog4oCC4oCC4oCC4oCC4oCC4oCC4oCC4oCC4oCC4oCC4oCCcmVn
ID0gPDB4MjA+OwpAQCAtMzkxLDYgKzQyNSwyMCBAQCAmc2FpMyB7CiDigILigILigILigILigIJz
dGF0dXMgPSAib2theSI7CiB9OwogCismc2FpNSB7CivigILigILigILigILigIJwaW5jdHJsLW5h
bWVzID0gImRlZmF1bHQiOwor4oCC4oCC4oCC4oCC4oCCcGluY3RybC0wID0gPCZwaW5jdHJsX3Nh
aTU+Owor4oCC4oCC4oCC4oCC4oCCYXNzaWduZWQtY2xvY2tzID0gPCZjbGsgSU1YOE1NX0NMS19T
QUk1PjsKK+KAguKAguKAguKAguKAgmFzc2lnbmVkLWNsb2NrLXBhcmVudHMgPSA8JmNsayBJTVg4
TU1fQVVESU9fUExMMV9PVVQ+Owor4oCC4oCC4oCC4oCC4oCCYXNzaWduZWQtY2xvY2stcmF0ZXMg
PSA8MjQ1NzYwMDA+Owor4oCC4oCC4oCC4oCC4oCCY2xvY2tzID0gPCZjbGsgSU1YOE1NX0NMS19T
QUk1X0lQRz4sIDwmY2xrIElNWDhNTV9DTEtfRFVNTVk+LAor4oCC4oCC4oCC4oCC4oCC4oCC4oCC
4oCC4oCC4oCC4oCCPCZjbGsgSU1YOE1NX0NMS19TQUk1X1JPT1Q+LCA8JmNsayBJTVg4TU1fQ0xL
X0RVTU1ZPiwKK+KAguKAguKAguKAguKAguKAguKAguKAguKAguKAguKAgjwmY2xrIElNWDhNTV9D
TEtfRFVNTVk+LCA8JmNsayBJTVg4TU1fQVVESU9fUExMMV9PVVQ+LAor4oCC4oCC4oCC4oCC4oCC
4oCC4oCC4oCC4oCC4oCC4oCCPCZjbGsgSU1YOE1NX0FVRElPX1BMTDJfT1VUPjsKK+KAguKAguKA
guKAguKAgmNsb2NrLW5hbWVzID0gImJ1cyIsICJtY2xrMCIsICJtY2xrMSIsICJtY2xrMiIsICJt
Y2xrMyIsICJwbGw4ayIsICJwbGwxMWsiOwor4oCC4oCC4oCC4oCC4oCCc3RhdHVzID0gIm9rYXki
OworfTsKKwogJnNudnNfcHdya2V5IHsKIOKAguKAguKAguKAguKAgnN0YXR1cyA9ICJva2F5IjsK
IH07CkBAIC01NTIsNiArNjAwLDE2IEBAIE1YOE1NX0lPTVVYQ19TQUkzX1RYRF9TQUkzX1RYX0RB
VEEwICAgICAweGQ2CiDigILigILigILigILigILigILigILigILigILigILigII+Owog4oCC4oCC
4oCC4oCC4oCCfTsKIAor4oCC4oCC4oCC4oCC4oCCcGluY3RybF9zYWk1OiBzYWk1Z3JwIHsKK+KA
guKAguKAguKAguKAguKAguKAguKAguKAguKAguKAgmZzbCxwaW5zID0gPAor4oCC4oCC4oCC4oCC
4oCC4oCC4oCC4oCC4oCC4oCC4oCC4oCC4oCC4oCC4oCC4oCC4oCCTVg4TU1fSU9NVVhDX1NBSTVf
TUNMS19TQUk1X01DTEsgICAgICAgIDB4ZDYKK+KAguKAguKAguKAguKAguKAguKAguKAguKAguKA
guKAguKAguKAguKAguKAguKAguKAgk1YOE1NX0lPTVVYQ19TQUk1X1JYRDJfU0FJNV9UWF9CQ0xL
ICAgICAweGQ2CivigILigILigILigILigILigILigILigILigILigILigILigILigILigILigILi
gILigIJNWDhNTV9JT01VWENfU0FJNV9SWEQxX1NBSTVfVFhfU1lOQyAgICAgMHhkNgor4oCC4oCC
4oCC4oCC4oCC4oCC4oCC4oCC4oCC4oCC4oCC4oCC4oCC4oCC4oCC4oCC4oCCTVg4TU1fSU9NVVhD
X1NBSTVfUlhEMF9TQUk1X1JYX0RBVEEwICAgIDB4ZDYKK+KAguKAguKAguKAguKAguKAguKAguKA
guKAguKAguKAguKAguKAguKAguKAguKAguKAgk1YOE1NX0lPTVVYQ19TQUk1X1JYRDNfU0FJNV9U
WF9EQVRBMCAgICAweGQ2CivigILigILigILigILigILigILigILigILigILigILigII+Owor4oCC
4oCC4oCC4oCC4oCCfQorCiDigILigILigILigILigIJwaW5jdHJsX3R5cGVjMTogdHlwZWMxZ3Jw
IHsKIOKAguKAguKAguKAguKAguKAguKAguKAguKAguKAguKAgmZzbCxwaW5zID0gPAog4oCC4oCC
4oCC4oCC4oCC4oCC4oCC4oCC4oCC4oCC4oCC4oCC4oCC4oCC4oCC4oCC4oCCTVg4TU1fSU9NVVhD
X1NEMV9TVFJPQkVfR1BJTzJfSU8xMeKAguKAgjB4MTU5CmRpZmYgLS1naXQgYS9zb3VuZC9zb2Mv
Y29kZWNzL0tjb25maWcgYi9zb3VuZC9zb2MvY29kZWNzL0tjb25maWcKaW5kZXggMGY5ZDcxNDkw
MDc1Li5lZmVmMmRmMzYyYTQgMTAwNjQ0Ci0tLSBhL3NvdW5kL3NvYy9jb2RlY3MvS2NvbmZpZwor
KysgYi9zb3VuZC9zb2MvY29kZWNzL0tjb25maWcKQEAgLTEwMDksNyArMTAwOSw3IEBAIGNvbmZp
ZyBTTkRfU09DX01BWDk4MDg4CiDigILigILigILigILigIJkZXBlbmRzIG9uIEkyQwogCiBjb25m
aWcgU05EX1NPQ19NQVg5ODA5MAot4oCC4oCC4oCC4oCC4oCCdHJpc3RhdGUKK+KAguKAguKAguKA
guKAgnRyaXN0YXRlICJNYXhpbSBNQVg5ODA5MC8xLCBTdGVyZW8gQXVkaW8gQ29kZWMiCiDigILi
gILigILigILigIJkZXBlbmRzIG9uIEkyQwogCiBjb25maWcgU05EX1NPQ19NQVg5ODA5NQotLQoy
LjI1LjE=
