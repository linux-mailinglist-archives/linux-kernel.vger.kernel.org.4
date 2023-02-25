Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B6DB6A2A4B
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Feb 2023 15:25:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229646AbjBYOZS convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Sat, 25 Feb 2023 09:25:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjBYOZQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Feb 2023 09:25:16 -0500
Received: from IND01-BMX-obe.outbound.protection.outlook.com (mail-bmxind01on2068.outbound.protection.outlook.com [40.107.239.68])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C707F770;
        Sat, 25 Feb 2023 06:25:14 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y9elovxeJ7kd19BChvO2KR5U2kl2I6h9PdLKYOUmw+/smZhTXFPuWENzG8FHkR9qjkslZi/D83sfpaTRRWMKhlcM0nuEf4HqWFbtv7D9sQ5L9T1xJ+jZzwNUtnzxmbdIJcM4i/GN9MDcVIrb+ByuL8kmW5eOJ5Zqeqo9x2ANgKWo6GNztP7xA/JUT0bE9blGmvQsKm6EOGOqeQtNVVuii7xWdP0nnp+iMfUNuXdlEdVQKGjbBg7L6nc3QZNUuV/ryUraCdmmDcUGA8taBlGSC8IoT2XuaUskGeHwSVPA38BR0fEbhfJAsOU+dPopbOVyVwpEoHlOQ8zuQvB/u3N0Ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/z57PaWp+G2myo9FbUpbieCSKzvD/MHlE8MixcAwEq8=;
 b=Bra3KkOAA3GkrovOFav5zTbGpVpWGcY9fBMsS/kZUEQBa1rTgJ+0iltBpe6EZSZNb+heJVXpmHe10xmmDguIibqjqFrlTuvSSUDe/Kg/LgwnEiZe587jSFwdxStRLUIJzr/W32PxgicNGyugGKVEqKWsPn3rpou3Q4a9ewIzYPeRzMk1k8AXOSe2PUw+Hkz+OF6EBk6GlDgv/PxREOioq9bIJmnf0k9UhIm3oM4jLMBZYhHC60ZCMvtjBkJO0lX1hX+nme8N55GvrEFrGDUut4WwCcLcFfwDO/1y2OKe2c9Dk3jFac8zsQOmAiXSuBXKjJnZxuV99p3Z1Kbls5dr+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siliconsignals.io; dmarc=pass action=none
 header.from=siliconsignals.io; dkim=pass header.d=siliconsignals.io; arc=none
Received: from MA0PR01MB7145.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a01:31::9)
 by MAZPR01MB6034.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a01:61::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.12; Sat, 25 Feb
 2023 14:25:11 +0000
Received: from MA0PR01MB7145.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::b92a:5a49:da69:235b]) by MA0PR01MB7145.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::b92a:5a49:da69:235b%3]) with mapi id 15.20.6156.012; Sat, 25 Feb 2023
 14:25:10 +0000
From:   Hardevsinh Palaniya <hardevsinh.palaniya@siliconsignals.io>
To:     "robh+dt@kernel.org" <robh+dt@kernel.org>
CC:     "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "linux-imx@nxp.com" <linux-imx@nxp.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH] ARM64: dts: debix model-a: enable hdmi
Thread-Topic: [PATCH] ARM64: dts: debix model-a: enable hdmi
Thread-Index: AQHZSSPu9xJMN6srJka2w35ih5zwSA==
Date:   Sat, 25 Feb 2023 14:25:10 +0000
Message-ID: <MA0PR01MB7145D1E9382C7F91197B259FFFA99@MA0PR01MB7145.INDPRD01.PROD.OUTLOOK.COM>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siliconsignals.io;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MA0PR01MB7145:EE_|MAZPR01MB6034:EE_
x-ms-office365-filtering-correlation-id: 4051ab19-fc7d-4bed-73bc-08db173c1a3f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: bHfHZm+Ucv0GhMoC3HnakW53klLRvyuuwulViweSBGhUnilTqsP8+NWdiHkrC/Bz3YLsj3Tblu72FT0e+pCFjZ/Vx5yEz0lKoLrGjFZAE/FUjc7/jNBrKCAaT81JuFkWtaHAndRNNBnWjTwfs+mjNiZhfrNPH4nRfMyT56py9ML6W1eZlxAgheyncJnpKBM93kBAIJantR3yNhP/EHaEbZPFoOJBqwlKjOqSXXzb4Ch8sUXMF4qxePF+h2ZDvu2iyix2yPK1cs5XNX3n17bty+4NbFTI3V0shoM36qvCErm+sa636qNJWqRbJf4idZItLcFdbDPp2IjotDi/+DAxT9m1P7zP1PfXWcQ9dn4hF1kv3GdvqM/ADg+TpNsx//Nmt0EI2357cwkvfHBKJlA9fw6m7AhRjhKJNnn/LQZN0NtXZ63MSoXXPF4RYDZ83eDW7YF84JlvpdE2asu8kn3qObLEReQ6NHAihBB313IYrzAokEOotEAiNXyIPVvYz25ouSFTLSTWXOUF+X46waAkE2i++bigpH2z67g+HR0PGo27ZAkXJ90W7nrj+eBqr3z1i8Re/zNg/wNHjU+dIOVoKbcocqRDRUjn5KV8TT1AY94hLxZa/BEvG2jTWQK8ERMsqiCDdy04fkRhwGIR1McCN8sewgEZe+xfBqVYH/+7RRHJ1dlTCiQ2ygC/RtB+b4Ym
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MA0PR01MB7145.INDPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230025)(136003)(376002)(346002)(39830400003)(396003)(366004)(451199018)(86362001)(38070700005)(33656002)(52536014)(4744005)(41300700001)(8936002)(44832011)(5660300002)(2906002)(38100700002)(122000001)(7416002)(71200400001)(66476007)(66556008)(66446008)(91956017)(76116006)(7696005)(66946007)(478600001)(64756008)(53546011)(186003)(9686003)(26005)(55016003)(8676002)(54906003)(316002)(4326008)(6506007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?H5zXS8egkU31Au9SfsOzGySeKHoNakpb7GKaHTmipibEySzHtEuirlcvMr?=
 =?iso-8859-1?Q?LsNrpebDPcsyhnqc8GuCTcLEIan7kGHtfd5DHUuQIW8h2dtjFxeOisiVlE?=
 =?iso-8859-1?Q?oqfi/Ir7DZHg1dWnyjVrS45Xm5HN1W/DGMD+c7Al8iyL1bn5//mru//asC?=
 =?iso-8859-1?Q?klWLePGxiPYlljT29VQSl1NctmjtLPmXcoj3RDJbv76mfJcKx4NQDGjoqQ?=
 =?iso-8859-1?Q?Lhuh0EG7fh93COtM7SSJ3o+8WVXD44zG5i0emeR1VwJHr79+Luz2aS63Oi?=
 =?iso-8859-1?Q?/07o/UvWmszpUSD1WBkTSuTq61qIeasbmVO9z6lHms7Ow/C02vf8Ch4fZA?=
 =?iso-8859-1?Q?m2xL2bH1WeKTVfRhmRzHbmgai9xHvJ6T4b/2W/JqVjsP+2O4YhEZp1QLng?=
 =?iso-8859-1?Q?L07G5g29LJ3xQw6f6Ij4OA/53WHpVynZwRgO5pjCruH4YthHGXXLWsQU/R?=
 =?iso-8859-1?Q?Li6PejOWdPeXLk9iqlrpTzZuo+ezFUXdOiLBPMphTcZqBf06ZATONtRd7j?=
 =?iso-8859-1?Q?/ApazbQmpL3Bb1nI1fYaEhGhV7Suk3PN0DB5yQdb1mHpDu6IwrrZ66548b?=
 =?iso-8859-1?Q?uMMBIdl0ZQ9VARnMo9guuyyBF/49SfULb9gc9Qy1EyTkYzc4O64GTMtXnH?=
 =?iso-8859-1?Q?as6aBqCF/Ed6qPfxKwQtajZc+JLIgf0oxrDHLIdmnESU+qTya8DoJEzYRW?=
 =?iso-8859-1?Q?6Tb0VyrkV1cA3pN1Sz7SNTpUhVtmMjpoYmk46hcp2/sEIhMZo3Lp2ZO9m5?=
 =?iso-8859-1?Q?/9sBzYwj7x4Exb5c66pUm4Mlc3cTAnZ8sW4nmotD2a0xtTW4BPrPQJ6dck?=
 =?iso-8859-1?Q?XcYG5T9nCvXqhrMcIJWqJex13X/JRzNnHtlFeZ9yAZ5HNNL4D3zjJUKZub?=
 =?iso-8859-1?Q?VrbxjM8+b7KN7p7u3hyuCp/3Nnv/vczaBTWK7cUW6tLHlcyI9RvFN+enAv?=
 =?iso-8859-1?Q?WnCtq/Pa8/i6IpmY6kjbX5i15/99PEFP1/AkFQtbFZ2Kj6EMy4oyyg9zaI?=
 =?iso-8859-1?Q?Fmmxj+GAnMLYIeOipwhT4YLhQYSfZuSGpgVp2g3xK7tl7vaskw0HfC7pdb?=
 =?iso-8859-1?Q?UM5222atVqN/+Bwltv7PupBH8aYcWDtgnDbVqIEng9glztkX3NdqdUGaKz?=
 =?iso-8859-1?Q?ENJvlXtn+AKQ8ik5gsSeUg+SFKsuvgUPlqCwo9cJEX0zfMLZ5au0yYJzrz?=
 =?iso-8859-1?Q?Cjs1ET7fC5mbzXgGFkGp4f6vGeOQZ4kCPlbV7uTmuayuZjiuWLl26vGnIg?=
 =?iso-8859-1?Q?MquhgSQuxA1Q3PAAkA6LYtnVz47xR+o6WOlb2SFuTUmUpSM0rF3rlHk37D?=
 =?iso-8859-1?Q?VvvjIJLVDCoDSI88N0x2GZcjI2Y4gJbgKxQ8WYzK/U9tDzR4rJCehL4BOu?=
 =?iso-8859-1?Q?YRuDWQCfUBzeEjOZr5oHzT6/oinqELmhHjm2hLjFBvyx710tV7jRrGklxm?=
 =?iso-8859-1?Q?e08kj3r/7hjWPuUdaSaQbvuNyfE1z3PjGujtXTIhHDwOoWAfGYkFmbFsiZ?=
 =?iso-8859-1?Q?Jkmmu93Ef358SUnhWCzZtiFzUxEQAYzd1gH0y1pP06aZTAWgDMQzESjza6?=
 =?iso-8859-1?Q?qLnJ9sD+75ySfQm8PMSN8Wut1UNi5+4OkuOIpCGR16qxFGHh4fDUB9OEC/?=
 =?iso-8859-1?Q?GHNuduBl9tN3pynVTtIAnKmayb7gphuy6stBtdE46CL8EYKrmmz+JVwDKV?=
 =?iso-8859-1?Q?LNFSbx4M2CPWH+kKBLI=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-OriginatorOrg: siliconsignals.io
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MA0PR01MB7145.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 4051ab19-fc7d-4bed-73bc-08db173c1a3f
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Feb 2023 14:25:10.8587
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7ec5089e-a433-4bd1-a638-82ee62e21d37
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Hmqvsb5hTG3na4S78/6175BOuh6Xj35MCNKYbdF/2MwI/EO4eSCuqiYP5Gy2Rq306ujCKsvByVPZF4H1owftcM4KjAWedNoqU4JcItZKmw81I7czKRaIdlIw5v4fdoey
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MAZPR01MB6034
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: HardevSinh Palaniya <hardevsinh.palaniya@siliconsignals.io>
Date: Sat, 25 Feb 2023 19:38:20 +0530
Subject: [PATCH] arm64: dts: debix model-a: enable hdmi

Enable HDMI support for Polyhex Debix Model A Board

Signed-off-by: HardevSinh Palaniya <hardevsinh.palaniya@siliconsignals.io>

diff --git a/arch/arm64/boot/dts/freescale/imx8mp-debix-model-a.dts b/arch/arm64/boot/dts/freescale/imx8mp-debix-model-a.dts
index 2876d18f2a38..bc2515113ae3 100644
--- a/arch/arm64/boot/dts/freescale/imx8mp-debix-model-a.dts
+++ b/arch/arm64/boot/dts/freescale/imx8mp-debix-model-a.dts
@@ -45,6 +45,43 @@ reg_usdhc2_vmmc: regulator-usdhc2 {
 	};
 };
 
+
+&irqsteer_hdmi {
+	status = "okay";
+};
+
+&hdmi_blk_ctrl {
+	status = "okay";
+};
+
+&hdmi_pavi {
+	status = "okay";
+};
+
+&hdmi {
+	status = "okay";
+};
+
+&hdmiphy {
+	status = "okay";
+};
+
+&lcdif1 {
+	status = "okay";
+};
+
+&lcdif2 {
+	status = "okay";
+};
+
+&lcdif3 {
+	status = "okay";
+
+	thres-low  = <1 2>;             /* (FIFO * 1 / 2) */
+	thres-high = <3 4>;             /* (FIFO * 3 / 4) */
+};
+
+
 &A53_0 {
 	cpu-supply = <&buck2>;
 };
-- 
2.25.1
