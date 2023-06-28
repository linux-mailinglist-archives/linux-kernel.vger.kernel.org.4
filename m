Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F26CE741595
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 17:47:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229935AbjF1PrX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 11:47:23 -0400
Received: from mail-os0jpn01on2121.outbound.protection.outlook.com ([40.107.113.121]:18403
        "EHLO JPN01-OS0-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229626AbjF1PrV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 11:47:21 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EKh4bdiRi9CZ7OLR/OtK7fcR0sWggDkYBDxVvFy6lnOlGmxfwrquGIWyo52wX35Z2PG4gfF0jcQlj57ER3Ten0dIU+9AMt8bKlNiOuKXcg9KN1JU3ZSEG38uzH+94L50SPvzeeu62xQtYsja85dZech7awdFtBXVLpYw8ZzCxspnWkDcEoHolAOyDzWr8mjbpaPZLJfiNOI9BjwNRbw337qP2+ok51Np0fJgpOuRVI7q7RuvN1cvl5XE5skORfn42Ax5csp8lAx4TmoiK/Zktc0YUs9cQSDZvzNGLDdwsYEL8nJ9VQ2W/HnON1aAnlv0fosoqMF/tdDDgCBmFNGTEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iX0GCuYbG6s3GEx14l9vMtfsbW9GO8KNPH1iqV5DWdk=;
 b=S5xzqCHMrjSPY3cTM03+Hou/0iq+rC4+XnmOIDivOXCohxP+8wUbTs8UfwLeIfs14BJwlKfZniISsriosLsHYMmIVPyJTgW8zMoWzJIk1wv9dkJi6FSozdXul9H7rDIKvQiw59skKZefSY2MTCrCYX3WHfWL/U0rkojRRf+WewzRtJHwp3MXEPl8nmBY5zqlKF+OEq+PBOZT5qxMk/Xl+tYMW8PPOKL7npCC95YsvZBYYo4n+cfFq2cNkb63yKhRapoXCF/Fna+TiIcUGEeAEPTCLNx6uFlSjsMiReiMgsW41aFqmjahhyJJwIqJnP5nu7m8X6S54eKnilQ8re5Bbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iX0GCuYbG6s3GEx14l9vMtfsbW9GO8KNPH1iqV5DWdk=;
 b=SpiNGU/w537Bco4J5aGvDKu7uFktHTMUXtr9ic9x1qF51wV1pHHTnPtiaHp4P5GSD/OtwgdxW1kn8rWRHaMIZ6Od58dn6qHVengvJwME9zt80ymSJLOyF9JCYJ75yY+qzzFgpyLOI21qSWy0ShF6ivdWZGxhTVkIYgl6JLpCMkY=
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com (2603:1096:604:bb::5)
 by OSZPR01MB7987.jpnprd01.prod.outlook.com (2603:1096:604:1bb::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.26; Wed, 28 Jun
 2023 15:47:19 +0000
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::fc77:6148:d6a:c72b]) by OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::fc77:6148:d6a:c72b%4]) with mapi id 15.20.6521.026; Wed, 28 Jun 2023
 15:47:19 +0000
From:   Biju Das <biju.das.jz@bp.renesas.com>
To:     kernel test robot <lkp@intel.com>, Mark Brown <broonie@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>
CC:     "oe-kbuild-all@lists.linux.dev" <oe-kbuild-all@lists.linux.dev>,
        Linux Memory Management List <linux-mm@kvack.org>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [linux-next:master 11663/12731] ERROR: modpost:
 "clk_unregister_fixed_rate" [drivers/regulator/raa215300.ko] undefined!
Thread-Topic: [linux-next:master 11663/12731] ERROR: modpost:
 "clk_unregister_fixed_rate" [drivers/regulator/raa215300.ko] undefined!
Thread-Index: AQHZqcAM7HG7mOzFskmlpyg7ZZhBJq+gUiTw
Date:   Wed, 28 Jun 2023 15:47:19 +0000
Message-ID: <OS0PR01MB5922893DE97EAAD6BAA142558624A@OS0PR01MB5922.jpnprd01.prod.outlook.com>
References: <202306282012.sPQAuAN7-lkp@intel.com>
In-Reply-To: <202306282012.sPQAuAN7-lkp@intel.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS0PR01MB5922:EE_|OSZPR01MB7987:EE_
x-ms-office365-filtering-correlation-id: d81513a3-478b-4527-82e8-08db77eef480
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Uk2dPZWSjk5I5D3EEiJDpggahlG2Kl1vxbTjSA/CALM8gSVW8l5s8LC9qpbO980/DaTct2I+A5WDRNi9lIkzBmjoK5ut6PyeXnTknjt13NCApCPLoi0h0d8PL9xowkWTDo12lvu3PyRqVTlEeK87oKW2XeSlsJDA7FzD4zIVprc/FKFCqMYpbPAH0Fr6ujLngIDVzn4/Z+gLpohWxurzAuvzGdWVSzUSTvftZUi+mb6ETVeIrlROdOeUR/VKq45nnE9xmEpTeiLpGJbS5KAPUFbDmdXyqvB6g0Fcz+RwZD3v+TWqe8lrTrFxNIE5LoyCjwt0eCbxpGqE2gBxZc/N9GxHBJ3qV21U7gmZzyiLzsJTkxbJ4WcV52dijIW3dGSsTbCPxzAA78UqR9GY6avOTldIYVvAz0C9bGeBkbKPOhK6ln88CFnJH6b1Jmo+QQ5TnPAXmoj2XX1bh+yi3VeIA5pHIBnX1kGbpzAXTIGHLjC+WLJzeON4JI4GJQRcJmCkRVLM4dAF5hNNiJ1JkibJGkotXi/EcMsiPl7p2TQGtiK/ES+JdkD5pi99uDpm7Ssnrz40ZaGlSt+6DBIab75/CWJNqiLAZloALVZJlSa8iIACVXGvYKLxpHsJnYOSIt5R
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB5922.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(346002)(376002)(366004)(396003)(39860400002)(451199021)(33656002)(4326008)(64756008)(66556008)(76116006)(66446008)(66946007)(478600001)(316002)(8936002)(66476007)(52536014)(5660300002)(8676002)(38070700005)(2906002)(6506007)(110136005)(55016003)(86362001)(54906003)(41300700001)(26005)(7696005)(186003)(71200400001)(9686003)(53546011)(83380400001)(122000001)(38100700002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?yD6ufzSL1eoTT2KC7cu86WGpD3gndrJAOvLl9gre7fh2gol1tkPEud8s6MIx?=
 =?us-ascii?Q?ZLuz88iJ2AD7wqQBQNjAHnVEW93TXf3UKK7CRzwAMSf0hv7H8gn6J5PlbRXE?=
 =?us-ascii?Q?HsvgAixTdsdXkPyN/g6zTOLdrrjMVQFBVXlxoWBof7WR2GtO13QtGQsq12v1?=
 =?us-ascii?Q?9JvJuBAqSfcq6y4VmRftOluuWTEIU5P5yhIsndXRBjicr9SzUF5qu9/9+UKA?=
 =?us-ascii?Q?8PFJyuckPeuU82pFLoFI7rvr/xUVOvczG2lELOLd7Jc8Oycs5LhN3kjQ44A/?=
 =?us-ascii?Q?LOZKBrgDv45FO1rA7bjKub1/n1zNPUoZgYbSjXA1dw5nOXECv2yBzhBBA3W6?=
 =?us-ascii?Q?Ung7ca4qEoMQ/xnmzT2OZE9q1hToBckSchQr/oHCXCquQbfBxhvrRLR/QxsP?=
 =?us-ascii?Q?e1+26jOciwN7mZ6Hf5hXfnJyEyWfkdN7tiJeMVY7Z98T3YTe7aS/ndiYu8ZN?=
 =?us-ascii?Q?T7PO1wZ/egMRuuNepVLT2AHgfWdpxmAQ+Ja0pwVpgh/5q8Wm10BJuI7UBokz?=
 =?us-ascii?Q?fA3GxBVMoO7mNRv7O+aXdEJzfIaJ8OQmGf5xsth2eDspP1sBZro7Q4VLv0Hk?=
 =?us-ascii?Q?hOKhfL0wGlBMqi1XfoociCquhY29Sm0ExjIFQ0F0LZZOqB0LDO88hcRZH8PB?=
 =?us-ascii?Q?Cwa07oaVm5raE+axg7eBfQL4MBuj14r1kHVKt1emitlSoMS0k9fr5KTGCF7a?=
 =?us-ascii?Q?XzVmiw1OzFCgpKsiXFNqvIt7pIdeFyvB+WiX0tel98xZmasp0+wnQFbfBkhb?=
 =?us-ascii?Q?PEjIHQrH95tCcrG/uYbi6EHML2yCBvQdDd61KCHmPC6/SWuaM8nvTZ+YYt6z?=
 =?us-ascii?Q?5F7qpMp2Eqef2T5sJvLxiGE0f3ZpSk51zr1GXSktOr2jAaB7nXstT9aouMJI?=
 =?us-ascii?Q?0/le/AA1D1zxJQxSisGeGk6qrTrymUcXGStM+21WrqObOXVh68tkS4K16UaO?=
 =?us-ascii?Q?HYQU72fvg3U1IFO5EKnM2cvwwUJUzkGlVLowXz5K3hE7gIaohVnV8Y4vAYUT?=
 =?us-ascii?Q?5/NjouLr7Prkxz8Lrp/I6+b2pHUpIzjKQ61sVt878w4Lcznu6WOAsxDYNMyK?=
 =?us-ascii?Q?h4s75iUrsS5zuYPSw01CInwGj9Bv0b0q5jZvAhey37mJJtiT+Tss1FFPY6cX?=
 =?us-ascii?Q?LDhrg7SQo8loCoqelU3hrfaToT2qi1f/wzKqvdUB5EpZCLDkVOtCDvuSeVT0?=
 =?us-ascii?Q?f15VM407lTlNv77CUEUb4oBMaL1bprUXz5JSlp0mNJLs7H7gc5O67MWQPV+Q?=
 =?us-ascii?Q?4YkqhexW3y+8wRH0QWZnVgjHW08IJpQLFr22LTVR2XFpKmtw8cPh3h1oBORh?=
 =?us-ascii?Q?6BLf7QIOdh+WcGWlWWMMDlO71Q6jzZRqY7HzQksjeN/pzfDPzkGH60xdO7yP?=
 =?us-ascii?Q?1SKzq/zkAmz6UiH3P3Zot/DsODoO689gnsKJxfIr+xfkZWxbu6aUTD4bWSnE?=
 =?us-ascii?Q?XcxQwYLdp2cvnJaPil58ro7ynhGnvuEF/9m3dcpp/+ixXOSWKWftkLYnGvxl?=
 =?us-ascii?Q?NPokTSbvfC/amH3V/YqkHjQKgp9VcPkq0GODMSZWVB589tGCtpRGdRtp69oD?=
 =?us-ascii?Q?TldOt/4Is8IJzhDsIbQ5hpKTjcntaPerrqAPbLXZ?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB5922.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d81513a3-478b-4527-82e8-08db77eef480
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jun 2023 15:47:19.0647
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6/hcxBjEV//1q3QJrrci/dfwmjgvEnSPKI0NCY8sF42vcP+axr9Z0G0h4MQgSad424Rlk5DqHe35HI6PVJCFrbc8vMyPq9CPkm4pRM1kua4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSZPR01MB7987
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

I have come up with two solutions for fixing this issue.

Please suggest which solution, I should submit.

First solution allows to build the driver for m68k architecture,
whereas the second solution skips it.

Solution 1: Add static inline functions in clk-provider.h
---------------------------------------------------------
diff --git a/include/linux/clk-provider.h b/include/linux/clk-provider.h
index 28ff6f1a6ada..425a31c2816c 100644
--- a/include/linux/clk-provider.h
+++ b/include/linux/clk-provider.h
@@ -365,9 +365,6 @@ struct clk_hw *__clk_hw_register_fixed_rate(struct devi=
ce *dev,
 		const struct clk_parent_data *parent_data, unsigned long flags,
 		unsigned long fixed_rate, unsigned long fixed_accuracy,
 		unsigned long clk_fixed_flags, bool devm);
-struct clk *clk_register_fixed_rate(struct device *dev, const char *name,
-		const char *parent_name, unsigned long flags,
-		unsigned long fixed_rate);
 /**
  * clk_hw_register_fixed_rate - register fixed-rate clock with the clock
  * framework
@@ -481,7 +478,6 @@ struct clk *clk_register_fixed_rate(struct device *dev,=
 const char *name,
 				     (parent_data), (flags), (fixed_rate), 0,    \
 				     CLK_FIXED_RATE_PARENT_ACCURACY, false)
=20
-void clk_unregister_fixed_rate(struct clk *clk);
 void clk_hw_unregister_fixed_rate(struct clk_hw *hw);
=20
 void of_fixed_clk_setup(struct device_node *np);
@@ -1297,11 +1293,22 @@ const char *__clk_get_name(const struct clk *clk);
 const char *clk_hw_get_name(const struct clk_hw *hw);
 #ifdef CONFIG_COMMON_CLK
 struct clk_hw *__clk_get_hw(struct clk *clk);
+struct clk *clk_register_fixed_rate(struct device *dev, const char *name,
+		const char *parent_name, unsigned long flags,
+		unsigned long fixed_rate);
+void clk_unregister_fixed_rate(struct clk *clk);
 #else
 static inline struct clk_hw *__clk_get_hw(struct clk *clk)
 {
 	return (struct clk_hw *)clk;
 }
+static inline struct clk *clk_register_fixed_rate(struct device *dev, cons=
t char *name,
+		const char *parent_name, unsigned long flags,
+		unsigned long fixed_rate)
+{
+	return ERR_PTR(-ENOENT);
+}
+static inline void clk_unregister_fixed_rate(struct clk *clk) {}
 #endif
=20
 struct clk *clk_hw_get_clk(struct clk_hw *hw, const char *con_id);
Solution 2: Add dependency to COMMON_CLK
--------------------------------------

config REGULATOR_RAA215300
	tristate "Renesas RAA215300 driver"
	select REGMAP_I2C
+	depends on COMMON_CLK
	depends on I2C
	help
	  Support for the Renesas RAA215300 PMIC.

Cheers,
Biju

> -----Original Message-----
> From: kernel test robot <lkp@intel.com>
> Sent: Wednesday, June 28, 2023 1:53 PM
> To: Biju Das <biju.das.jz@bp.renesas.com>
> Cc: oe-kbuild-all@lists.linux.dev; Linux Memory Management List <linux-
> mm@kvack.org>; Mark Brown <broonie@kernel.org>
> Subject: [linux-next:master 11663/12731] ERROR: modpost:
> "clk_unregister_fixed_rate" [drivers/regulator/raa215300.ko] undefined!
>=20
> tree:
>=20
>=20
> If you fix the issue in a separate patch/commit (i.e. not just a new
> version of the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes:
>=20
> All errors (new ones prefixed by >>, old ones prefixed by <<):
>=20
> >> ERROR: modpost: "clk_unregister_fixed_rate"
> [drivers/regulator/raa215300.ko] undefined!
> >> ERROR: modpost: "clk_register_fixed_rate"
> [drivers/regulator/raa215300.ko] undefined!
>=20
> --
> 0-DAY CI Kernel Test Service
