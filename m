Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1828D5F60C2
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Oct 2022 07:46:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230186AbiJFFpz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Oct 2022 01:45:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230016AbiJFFpu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 01:45:50 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2122.outbound.protection.outlook.com [40.107.255.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF23E4D4FC;
        Wed,  5 Oct 2022 22:45:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Sa+Cy4ghmaHe7kzeo+WDhOH3AwiZxjyAqhsaB8B6lhxQbboT30QeUvYPDwFL5jhmY8Oz9DA3LwMq/vanSXVOEWI6IoVXKMReq90bKNgKuq7u6UcVyoa16n7cNVTRf6kJH/CiCgzi2A2Uy7m80PBCWdxaeOATsEHK5QlNpGL7cZen9Ji+Mvdy1eXP6mkluNun0Ccngj2wjqpy3PGTvT9JdJiVt5UGrEq55gvjODcpNBV07ZSWX+oHLfgdVcUOa09r7GhmgYEnYP0+WGR7A4tv6kKTsUANrySMNVx8lBwLhd6uRFibz26R9wmiNIz9K7Ww0nGXWYGDo+j1ehhcOL5iCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EYn/brhlM016ERIBFX6Z/B1mcDTxOhPKteLBh4WzVLo=;
 b=S38yeN4xhdhGHfNN51x9+fxu/1T/gYlFmqdhQHxwyhd8vkzSyiEiIe2q4SxyJXVsF3ruz5RqAjLZIDOEENXXz46s2NAaSaKOAet4Z6KHcww+X/fyYhYPvQWtUDRCsB/fK62H6Ciiltw1pfWcDHvYj8OSz2yoydCNEmry3I0o+2OpKJaKc/3uqDmAEnVefvwA2zrrffo4uc3xEPcpJGasmxluAA05UyrpxLKNhNvjO8+2vGYcZighso1kn3dAtYr8InN6BBI+F8TmqNALtVd/eEtCAbslKzxY/9rlsWxjkwfIHq+iXp3zqZ4lJOgEEQErjxSURoSYYl05PgGBnjliIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EYn/brhlM016ERIBFX6Z/B1mcDTxOhPKteLBh4WzVLo=;
 b=VfsHdijFEXkarrscCKgIKpcfxA7WHiwAt+qx+yF677N9SOLsPpWHwb0gikIwEVJDpYrA/7B/L6l46XIi7owY8WqkoScin1R4OLRENvCw841sAjFjf2t+gs0kF1vf7XXX8mSKpP9DgDDY/epgGxkgrTHtO1FpCLOTxLyU1q172cjKX1LS3R2pjFp1pWO0MMhjBVBbDoCDHoELmUt4vIL8b+wHEmm4uQKFaPoNZxtCcg/AXXWsgXWae5YeRleJ8Ct3fMyX2ELov7AfHMfTCZw7KamCNLbcnwJDdJvi5BjWxBruCuuq1dbCBRzlK1ioWv4a+Hsj1GZ4TE2YvARk3VFK/Q==
Received: from HK0PR06MB3202.apcprd06.prod.outlook.com (2603:1096:203:87::17)
 by TYZPR06MB5323.apcprd06.prod.outlook.com (2603:1096:400:1f1::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.28; Thu, 6 Oct
 2022 05:45:42 +0000
Received: from HK0PR06MB3202.apcprd06.prod.outlook.com
 ([fe80::c94b:7dc7:548:3c18]) by HK0PR06MB3202.apcprd06.prod.outlook.com
 ([fe80::c94b:7dc7:548:3c18%4]) with mapi id 15.20.5676.033; Thu, 6 Oct 2022
 05:45:42 +0000
From:   Neal Liu <neal_liu@aspeedtech.com>
To:     Rob Herring <robh@kernel.org>
CC:     Herbert Xu <herbert@gondor.apana.org.au>,
        "David S . Miller" <davem@davemloft.net>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        ChiaWei Wang <chiawei_wang@aspeedtech.com>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        "linux-aspeed@lists.ozlabs.org" <linux-aspeed@lists.ozlabs.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2 4/4] dt-bindings: bus: add documentation for Aspeed
 AHBC
Thread-Topic: [PATCH v2 4/4] dt-bindings: bus: add documentation for Aspeed
 AHBC
Thread-Index: AQHY16FydoFvy/tRik2dFUNH8arC163/yrUAgADxsdA=
Date:   Thu, 6 Oct 2022 05:45:42 +0000
Message-ID: <HK0PR06MB32020E4C2124FDD9C68F811A805C9@HK0PR06MB3202.apcprd06.prod.outlook.com>
References: <20221004032841.3714928-1-neal_liu@aspeedtech.com>
 <20221004032841.3714928-5-neal_liu@aspeedtech.com>
 <20221005131840.GA3256371-robh@kernel.org>
In-Reply-To: <20221005131840.GA3256371-robh@kernel.org>
Accept-Language: en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: HK0PR06MB3202:EE_|TYZPR06MB5323:EE_
x-ms-office365-filtering-correlation-id: 7e07d835-d7b4-4cec-0f4d-08daa75e01a5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: sM3/oFt8nf/7QUz44u5GxKTD7FzHJlqplV/0hR0yI4foGHSZp15bT8u6H0gFilZTpYUNFAeAwlJmcVnAU0B8iSknJKFpN0of/ZV37IRQuSwMPd+P8scKgfrjQSm3LtNxmcHqyaSOAZNszEVZpwHNA1Mb0pxvIMj5AO+K9PKcm05fe7PrcDPkhtJAo0EBAhEGuEuS/MCYKCZnKo/treU64xhYU1t1VcIk1jq6tD0O2B7UqrG3wKiP0ANLl4cUivwf8Jn+UnLn+EUbiK3AHn27vV/1GeE7zUKIT1kH+yJ7mDOpTGtg1xNlpZaF3iysHAYfA1t7AirXgWacbaneEaVnDyvdjOcgjDk6hCjohqVTw0fnbFA9UPNE+i1WzlacJhIvxEqaxyioL0a5r+Ut7lzXvpbvtJNqra9/fD96YtkSCmQLpCqDINa/YOA1XuVwmWFOsOsYcQz/Jh3WiX2TPfW4NF8VC3+WBX9SDr+EYOSSkXdhSKN7aPnAKEvUDgFDAxiJiiZYqjo2LFCeABMcONj4adXKbknwB7DByDqFhwa4CXZjzbMdjlvhS5kaGFkSYp+/5bNQmoR/oDb95k4Smg4vP/ffTRufL8s08KD2nkVEWiBQG7zWF4BGxj5nKNn6kMTVuPJp7z1eDb6JwTk0IoY9J5r1ZFjVNpeIUh1x2M2oSKBqCySPNBj3amBmgSZo0vp74gb+iLrk6KCy72eOfGrlGao16wCFoDWj+5eYNkK3fCZyTNOCSGA9J+SJcHRdgHS7ggScXRK5d3dNUNRTOsjPuEky5iUkOy5eKkW/Ar+MqX6DrP6CQ5nmlHEn7JHvsX1/MH70Z3k50/q2GIPOqSYhuA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HK0PR06MB3202.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(136003)(39840400004)(346002)(366004)(396003)(451199015)(8936002)(52536014)(7416002)(5660300002)(186003)(6506007)(76116006)(122000001)(4326008)(8676002)(966005)(38070700005)(66946007)(66446008)(26005)(64756008)(7696005)(9686003)(66556008)(41300700001)(66476007)(54906003)(478600001)(55016003)(33656002)(38100700002)(6916009)(71200400001)(316002)(2906002)(86362001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?yc/82TXUBafv0HuGYPLByz/E2+BKlm3RrBbEIPXznkSKyf9VOjxmPTfYUn/J?=
 =?us-ascii?Q?2u5etxvm64byB9OE2+WBCYnxts5isOx9eXRD5AUXaO9iUglfDCaW0Yont2Th?=
 =?us-ascii?Q?d9x/C6iIPu0A0zkidItXy6gFeYSYDNrJIEuzMHs4mWcE5I8lT5etjpN7moyr?=
 =?us-ascii?Q?JVfU7/LvEBdJKBekq8ej7J+Xxiv3elNXlU+9cs6ZaLSgw0A1jOnGnUxv3Gkv?=
 =?us-ascii?Q?MvidO0uhNZkzma561SVuQdy4/GDPUWdpGirwyFFDZNcwjZPPOEtJT7qgQgmn?=
 =?us-ascii?Q?wgrhf9CkhQaSo/4BWJJ5OLxwI444TSpWxuHubUilGgJLUZx8pqRclXZt2lFY?=
 =?us-ascii?Q?8xenAQMQ1NkhTr8F/l06blQdMs0zFDGFxAF5/Qt9dovpHjLiuzxVaXgmhYKP?=
 =?us-ascii?Q?6amJtYBzro2EcBzoZFtUIqNF/HvHBgl+rktkDDfeWoY3EuY7XSjMeWwPr72W?=
 =?us-ascii?Q?IU8T9oDZD0DL4pbJKlpah1RsVpOXM2UOtJv7w/5zOY6NMHT+62H2ly4hezZ6?=
 =?us-ascii?Q?9G0e7zj4pImyD8clfgbg7c88u3AUM6/OHZIJ7BXwBpSkpWpggFR2iwby4Sa9?=
 =?us-ascii?Q?WTWRr7HukLp1QEsmpWu5uM8b0nCnqIxbiCdYZbT7cB3jJtulJ1kweK8CnvO8?=
 =?us-ascii?Q?ubMkInPqgyNP5PwKv3l8oSEnmnIS91BUJ1462wvDwtUVcSbzfPthyIGMcQjB?=
 =?us-ascii?Q?Jt4vxQHCN9RLAgSdsaaA5rLGekk3NXWsJUn7X7JERQd6SXpLCysi9Ohnh4Sv?=
 =?us-ascii?Q?lcShK6onNcngZR5fbpU5LUgum31slNEUTNy1SaorOWvsBtYtHRZqurzZ2SYe?=
 =?us-ascii?Q?l4+UvrsRw8LehfvTQDNvdZ2YrT5WaqLrd+H+0MVKCuq0PCDEX14KIsB7oTQN?=
 =?us-ascii?Q?oVY06hC10QyCMZkIbbGCnpE1yYK+bqKh2VjFPWrfA50ANr+PVCcb4LcXTlre?=
 =?us-ascii?Q?WvbLT+wnMQ8BUekxFGDOnI0adYKHdTpghIBpo0tNW/6mluO0Uh7Xvo7NUTZm?=
 =?us-ascii?Q?eyazab3swVwOfSg1tJrdBfkPN26oHgfM4EVjAVrx1xg5ryNc7VFXOqood4/A?=
 =?us-ascii?Q?qxvhuAG88+FSxhBdRAGR90AXePDe/qtvbEiBL4qaN0DFPLd7f61SJscG4pED?=
 =?us-ascii?Q?6w5fyjTp7mM7jRF/DdplU0HO5ohPh4VjLYMqRrvVbSkyCRmH1p6FAhNAxZCQ?=
 =?us-ascii?Q?VpGoBG5vtJJ1jj0RcOM6KXcI+RaTfiuDhLAX3FczoMTzzCrLnwxQTKwkCjuU?=
 =?us-ascii?Q?cHHKMi/7IFasAd3+83DbaRVajOF5MMsIlmVkAKLMopwR+7FB5yij4zMuD2ma?=
 =?us-ascii?Q?1m2AwhwL03weXzA3NS8srrDw1JGVNz8bepA39SAT7jX3cFbNduwzb05IL0eH?=
 =?us-ascii?Q?uJc8+D8CpiwpW2lKFRq8GI8BzIH/scARgx8xVCC9+druTusYj6KmUbpy2yxb?=
 =?us-ascii?Q?CovuBexmb+txa5+wvRxBV+50jJP3nQlBiKcE14yNAF8XsG9mnTrKxNimxHWT?=
 =?us-ascii?Q?ZT91MAjZ0f3OKz/qTGQygxeaFEUJEfBZWANbioAxFkWOgTOu3kiydA8rcv/e?=
 =?us-ascii?Q?UNcPuzcoTdpDkaav8lKEiiWwDWCL1AWl+e3ngguG?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: HK0PR06MB3202.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e07d835-d7b4-4cec-0f4d-08daa75e01a5
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Oct 2022 05:45:42.2549
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MRqRBuSHLCS8B9ffWxmZiGyP29X6CqZUaMT929fDnMby6gCK5Sg6QmuCkY7hYNXPy/6oJeJReYSzlagRKz9TDQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB5323
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > Add device tree binding documentation for the Aspeed Advanced
> > High-Performance Bus (AHB) Controller.
> >
> > Signed-off-by: Neal Liu <neal_liu@aspeedtech.com>
> > ---
> >  .../bindings/bus/aspeed,ast2600-ahbc.yaml     | 46
> +++++++++++++++++++
> >  1 file changed, 46 insertions(+)
> >  create mode 100644
> > Documentation/devicetree/bindings/bus/aspeed,ast2600-ahbc.yaml
> >
> > diff --git
> > a/Documentation/devicetree/bindings/bus/aspeed,ast2600-ahbc.yaml
> > b/Documentation/devicetree/bindings/bus/aspeed,ast2600-ahbc.yaml
> > new file mode 100644
> > index 000000000000..c42a350d30a1
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/bus/aspeed,ast2600-ahbc.yaml
> > @@ -0,0 +1,46 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) %YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/bus/aspeed,ast2600-ahbc.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: ASPEED Advanced High-Performance Bus Controller (AHBC) Device
> > +Tree Bindings
> > +
> > +maintainers:
> > +  - Neal Liu <neal_liu@aspeedtech.com>
> > +  - Chia-Wei Wang <chiawei_wang@aspeedtech.com>
> > +
> > +description: |
> > +  Advanced High-performance Bus Controller (AHBC) supports plenty of
> > +mechanisms
> > +  including a priority arbiter, an address decoder and a data
> > +multiplexer
> > +  to control the overall operations of Advanced High-performance
> > +  Bus (AHB). AHB is the main system bus for ARM CPU to communicate
> > +with the
> > +  related peripherals.
> > +
> > +properties:
> > +  compatible:
> > +    enum:
> > +      - aspeed,ast2600-ahbc
> > +
> > +  reg:
> > +    maxItems: 1
> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +
> > +additionalProperties: false
> > +
> > +examples:
> > +  - |
> > +    bus {
> > +        compatible =3D "simple-bus";
> > +        #address-cells =3D <1>;
> > +        #size-cells =3D <1>;
> > +        ranges;
> > +
> > +        ahbc: bus@1e600000 {
> > +            compatible =3D "aspeed,ast2600-ahbc";
> > +            reg =3D <0x1e600000 0x100>;
>=20
> Devices on the AHB bus should be child nodes here. Unless this is just fo=
r
> device master interface to memory, but that's not what the description sa=
ys.

Sorry, I don't understand. "ahbc" device is already a child node here under=
 AHB bus.
"ahbc" is a controller to control the overall operations of AHB, which is d=
escribed in the description.
Could you explain more details?
Thanks.

