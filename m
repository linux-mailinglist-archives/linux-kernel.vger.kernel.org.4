Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11EBC6A4B6F
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Feb 2023 20:45:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230253AbjB0TpJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Feb 2023 14:45:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230099AbjB0TpF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Feb 2023 14:45:05 -0500
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2098.outbound.protection.outlook.com [40.107.20.98])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 464A22916D
        for <linux-kernel@vger.kernel.org>; Mon, 27 Feb 2023 11:44:37 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bszVqSk25kyoNDRXHRk1RrZnfMOUdpJiI24hU2cJg97UsR8Y7+7N8aYzQD+1KGxPTP2rc4BvX5yHiH1HI2YgiqVSF0i4vglLVsYsHEcUYkAVwA3vVOnf4UVI4uG7GVFwkfck2+FJIbpWZTZy35vXbaXqZb9lN0xX6218THv0f6JlpzzqSeyutgoH2RMujYjxb0FN5d8rxe/IqKXIcz9nzcmgDPmwck8DJsu18i0oiRdi4mo8Flx8KpbOx/c+oEF9PIh7U03GmHT5XP7hCQPY7Ck5iPjLXjT0gfYm3Y2mqNKt7+vNiZ2N844KSHeBdGlFITguh4C7ig2/4yk+o79cZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s9HhFfF3rcGMrnMSYg5k5VxaVN7QClmwCHCykIhnGXE=;
 b=ZG8Yw3O4sFNpLfKBRmGeFRGxanAb2DJSW3mGR7SjvDei1I2eQs72BEsqxAR9qnQii4EZ/uiK90Jd9iBp/8ba4gMTh6MqG7GwBFkSSmsJsIjaPBt8ssZzR5UUhmRBWvegPZ3xa8iqOAll7JQHasnotwZyBRhlsLUhcFGduQgTIsN0ss4Zq9HaKo+qscKNTFVJhxoYVYqncMvyXLjVLdP0eW60bWS3nzAkWpywNd1KIX3IgEUrvDWgBuIN5izWP2wUTBC2yx5xv5DR47qwBKfkO/JqFFtQXFU3K30WzOHJPAsKLrHe3Q1YBJMzl7da5UfB7PR4gANx8FGlU7tMTCsL/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prodrive-technologies.com; dmarc=pass action=none
 header.from=prodrive-technologies.com; dkim=pass
 header.d=prodrive-technologies.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=prodrive-technologies.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s9HhFfF3rcGMrnMSYg5k5VxaVN7QClmwCHCykIhnGXE=;
 b=O9cPSlofhA+MXhaYvs64jgNG4DJ/sSzKX9G0PCLzAUlPO+c+5KmGzBoYVL+A8SeaUShD4SdU1Pd+d24i3msuEorRnddnkrYlLX1Bru8VZBB7T113G5P6USsG6QLXDVYTRmX0dDm2MEZiNixDWx3u46/kqstV2F9E1gOZAhc5fso=
Received: from AM0PR02MB5524.eurprd02.prod.outlook.com (2603:10a6:208:15a::12)
 by PA4PR02MB6717.eurprd02.prod.outlook.com (2603:10a6:102:fe::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.29; Mon, 27 Feb
 2023 19:44:07 +0000
Received: from AM0PR02MB5524.eurprd02.prod.outlook.com
 ([fe80::b0de:8e68:fc8:480e]) by AM0PR02MB5524.eurprd02.prod.outlook.com
 ([fe80::b0de:8e68:fc8:480e%5]) with mapi id 15.20.6134.029; Mon, 27 Feb 2023
 19:44:07 +0000
From:   Paul Geurts <paul.geurts@prodrive-technologies.com>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH 2/4] dt-bindings: net/dsa/: add brcm,bcm53134 as compatible
 flag
Thread-Topic: [PATCH 2/4] dt-bindings: net/dsa/: add brcm,bcm53134 as
 compatible flag
Thread-Index: AQHZDjG/ekUYOqqJTkeoSW37sDG0067jqvCQ
Date:   Mon, 27 Feb 2023 19:44:07 +0000
Message-ID: <AM0PR02MB55242B90172EAB35D0ADF44EBDAF9@AM0PR02MB5524.eurprd02.prod.outlook.com>
References: <20221212135640.3590545-1-paul.geurts@prodrive-technologies.com>
 <20221212135640.3590545-3-paul.geurts@prodrive-technologies.com>
In-Reply-To: <20221212135640.3590545-3-paul.geurts@prodrive-technologies.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=prodrive-technologies.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM0PR02MB5524:EE_|PA4PR02MB6717:EE_
x-ms-office365-filtering-correlation-id: d3e2e7bd-f5f2-4c59-e103-08db18fafd4f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: jHog/nF0YIBVi22Z0aA8nLg8YDIER/MamKJY7/T4vVfgJqz26ZM8urLyftnBsduZIU8JwbUy12wQ+XheXRrl/iKKrhT/zbh+uTFcvbarIpfYZAEOk1LREkTuUqpeqUP5Dl+YGJlqBnnlxJqsp5gEtm7/5vot6d60TPsn1Sqt7deCzNaHeYq9P+tQfEMr61gGByzWWXldEwmvWdRAF7aTuKq3T8WMbbnlIEHxJpgX4/NVqC37reqhF8nECPnFFbkz3I8oV1zUkyZYDSW279fK56ypGn4gVGcbzvFt6gVYLEilRQXPmG6j92ZP5plZUK5AgpXjDC2HtBohOXhsS83mvzGaPC+NzIRd+Sb6+TOruUwvSR4mq7IkUOMnTfGO84rfWR9yK0FUdBcVNrXGedJyOueYGuVQwkFvx4+MZuvkaKSjJ9scG0ykt1TVlL9ztmeIXV+tcM8TsSujt5LrIkQyo4Yrr7papUsPMY2PrmgcPwdZIoWmkSkmJj6gnG4/PrBPAuoYPdxVVme2YF9D6xOmZL+KvqN6woOVAp+ry+RugEJL3D4Ml2hOb5HIlhEE3Uj5RnOYXGMwGgnHWhfmiqsxN8ueXGPSU0LD2DWne8QusGpmv206pHvCWO7cmHePrLZQFl28tEaixTukYzDmhNd8vjuhoa3od7RDUlXWth6jyJPp/6RAWoC3SfQ7X9mhQ+O3jxbVdY3WgTCHdHBXfgfiUQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR02MB5524.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(366004)(136003)(346002)(39850400004)(376002)(396003)(451199018)(71200400001)(9686003)(186003)(26005)(6506007)(478600001)(38070700005)(86362001)(33656002)(122000001)(38100700002)(55016003)(41300700001)(66946007)(66476007)(66556008)(6916009)(64756008)(76116006)(66446008)(8676002)(44832011)(2906002)(8936002)(52536014)(4744005)(5660300002)(7696005)(316002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?NCnQelsIwngc43xhkZ4mj6RN0cQS8DVJyh6yj9hasEHBShTYCTzjWXh+vhV/?=
 =?us-ascii?Q?it+4h8rOXHuorTT9Q/S0u4kKM+3ixBIx941hAktbhqjRQHgs+z0GBL9Sy6rZ?=
 =?us-ascii?Q?bYRZvh2ZWfhXQ9PJdGDsKdXl7y4z6DitahM3gjZ297VC93atfixaq1cbTW/j?=
 =?us-ascii?Q?ajn99arX6phMqfUbKRLzSP8F6AnJEf4qIOuKJbYoo+wCounpeh7iTZal5WHZ?=
 =?us-ascii?Q?fXiZhHQ3L2iy+5yt1pNigd4T+0ZIL5vgu8Dl8tJzg8GVIGcLadQ6sIZQ/VV0?=
 =?us-ascii?Q?+kxJAZ26CWP6EYAT2TKDzhGps8MGADdcuaQYAdo/l+qt2pKHtYnMzPLMM496?=
 =?us-ascii?Q?f3n2rX8ARxJDHUONMA+cBHP0eJx2moVUNQ4sB0mjSr8Cwg4YZcFTivJijFLA?=
 =?us-ascii?Q?/p31oc2OUl44C8jYJex0BJTGeqbfGzVXvxb7xo6YpMNy/C15ZJE0ineFNcdD?=
 =?us-ascii?Q?Up0iwltf05Q2UcvbyM1uqt24tVt6JWyoonQlFbCfQB9XJZpfyo/i3jNlSmIG?=
 =?us-ascii?Q?EXm5e9V7GsvzFlnTSS6dmgj4njO9Gidy9RZw0N4TMfgDlagYD9vBH7VGTLyF?=
 =?us-ascii?Q?PpZmHhL7Frwl1UpfqJ9xp6rIfmHuWbykYazheMnR14uBgOWg2mLkKyxMy34v?=
 =?us-ascii?Q?7gUk2Q3QbFzZ9imaOKQL3oWOdeO2Tkd/rcBJPFzg0SPjb4aLuvGlqQEwVdE3?=
 =?us-ascii?Q?9pNKJWsc4M9DGtzZaCN61G4v+2qYS55GN/5RCTcYbWJIprZcV7w4c3yFYEQy?=
 =?us-ascii?Q?D87d3oxHQCwbktOxFf7A5u/lomhr7jLxbVK6IpAxak/h+Q8R+30UQD8J4duE?=
 =?us-ascii?Q?KSkc8DHrQ9b15CEj4mbyQogKDIXVXTcY8iVGcY1d+DA1UBL/Pd86DEfrFyj7?=
 =?us-ascii?Q?Jeo8471laWe+v7Ve145ajINZZcolAyJqQvOpt7sxmeW0ahkHGhnP5rR5xELT?=
 =?us-ascii?Q?LnchEV7FhU2+47FVXJj5RHoV/Pb7kYcF+N1KPKlqGMq+ouNAH/s6FooLqE+w?=
 =?us-ascii?Q?FYEgBgZqLL1GQctBxfqSx2gEo6WXcQiiX22ubNqx7ftBqQOM41JVml4dNIto?=
 =?us-ascii?Q?SAAXb0PjlwpOlgg19VT76S0sEK8IUlNnXawX3dQnnL2cbLHtvqoiPxnz8a6D?=
 =?us-ascii?Q?g/kfl47cFaU7APf+jUWvBi9P17bnjYTdOosKTxznqnWtvscClqsAUDOlHbn4?=
 =?us-ascii?Q?+rWifFATvKBx6wN9aeo6VOf/SJHwiWk6w5w+4CggfHturwntv4JHXGLX/cMg?=
 =?us-ascii?Q?xqSEtoRgCEztkZs1GocY9lgBC981o4RLFFgZgAmvfPFw/lsSxoAuZP7hzCT2?=
 =?us-ascii?Q?IIVOW8WUczusoTG2+9OfP6d/ygas8bMa8trVpdwEBZPu/eYZnCi3U3wP0Im0?=
 =?us-ascii?Q?qoeHksAEmQfgQNkWWKNlBlYqsOgXqKC/0CMYBr5/1AZT/HQpli2f+FruZl1G?=
 =?us-ascii?Q?hhayB566EbsTAorN0toGODRVESxXek8UgUi4u9YyDZda3RnWTcV7e8Ovpcpi?=
 =?us-ascii?Q?ckfAV97LN/jsuC/WZIHGl4GR5iVwdq2sDvbJkKmpwi9s2m7NAhAtwCGluVCX?=
 =?us-ascii?Q?+jGHS3oZJlVgyHfxpBPxlWI4juWHc2X+QtLsj2fuUR0ueQ8QyG9v9+9pNHse?=
 =?us-ascii?Q?lfz/qHt3I3Isi6Ip7TTlZ+U=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: prodrive-technologies.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM0PR02MB5524.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d3e2e7bd-f5f2-4c59-e103-08db18fafd4f
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Feb 2023 19:44:07.3505
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 612607c9-5af7-4e7f-8976-faf1ae77be60
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ofi4xM/rJzFhzR/YOcv24588ixcmbfvszPRNvBky8S090jH/V5j4nmpPrGQX58FCjPrumL8SQgDHI7XE2wSKoXVFKdyF7Nd7ICCjPSEgLVhXTYgtXTbZ+wKQ3aisxIGE
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR02MB6717
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The b53 Ethernet driver now has support for the BCM53134 device.
This means the driver has a new compatible device, which is now also docume=
nted

Signed-off-by: Paul Geurts <paul.geurts@prodrive-technologies.com>
---
 Documentation/devicetree/bindings/net/dsa/brcm,b53.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/net/dsa/brcm,b53.yaml b/Docu=
mentation/devicetree/bindings/net/dsa/brcm,b53.yaml
index 1219b830b1a4..87065f6c32b7 100644
--- a/Documentation/devicetree/bindings/net/dsa/brcm,b53.yaml
+++ b/Documentation/devicetree/bindings/net/dsa/brcm,b53.yaml
@@ -24,6 +24,7 @@ properties:
       - const: brcm,bcm5389
       - const: brcm,bcm5397
       - const: brcm,bcm5398
+      - const: brcm,bcm53134
       - items:
           - const: brcm,bcm11360-srab
           - const: brcm,cygnus-srab
--
2.30.2

