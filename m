Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BCB768753E
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 06:31:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231698AbjBBFas (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 00:30:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232153AbjBBF3U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 00:29:20 -0500
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2087.outbound.protection.outlook.com [40.107.255.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61A211207E;
        Wed,  1 Feb 2023 21:28:23 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lsn8sm1c932Xz3VytaN+C0rKl4D7xbTqmtKCf5d9/qREHUccYcsEw5D3u04sPGfYV45iaBWgaH9elqGQTzpfz8D/SEJIOfnUSWqI6NJqVOnr/nACzlTvLYr6paIhQYYehKeS63R3xAu4hXHs5QICwLAErPR8nHpQo9A2CQ21xxqM9v8cpRHCNDnUP4xf/YKOMhBsw2bhUudxRgQoeSjJGerVPU7lZ8u8GYDzTxH09b74kTjEx/1HYoN7eUA+Kmh/Ie4qc5wJKBWV1K2/nI3Ho/mwL0L9MxE1X9PVMYn8RdGgoR4iBk8AYnGba1nRVxdKuYL14pbfTH1dLhVm5TaYWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Yn/jLHOUUYWvqBWojaKlGdt92vSwQyBVM/02A+t/0z4=;
 b=bJ5VuuefLq/lAIx6JOuNX5nihayvbeu2NHFCypXZM5KGkqD6KnZU7NQOUAJFlio16SAAlfswz4QNI0MpUdMLZcYgl7x/NTJaEJDDAI4ZbQnlxiozdVmGbGr5N+dNdcZeDs6mD1lwzykSaraoo+JL1enwb4oDz2nRpzTfj4rcVDjl9ifBRFOdjmb0WJz0+1poKz82BDPON53cjnKfhLh0MHQsbH0Z8JtJIbKAXMCNx2ubAU09RYL6c8N4GLWsqpd9y82johSY/WsoEqirLUWyFEmLHLJ8A/pxTwYHB5xKbQ6nOp0w38UAR5JmbJR6WXTDOAKSsfq2uVrYr1VuPJoRAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=irondevice.com; dmarc=pass action=none
 header.from=irondevice.com; dkim=pass header.d=irondevice.com; arc=none
Received: from SLXP216MB0077.KORP216.PROD.OUTLOOK.COM (2603:1096:100:7::23) by
 SL2P216MB1816.KORP216.PROD.OUTLOOK.COM (2603:1096:101:101::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6064.27; Thu, 2 Feb 2023 05:28:21 +0000
Received: from SLXP216MB0077.KORP216.PROD.OUTLOOK.COM
 ([fe80::3d9:7f82:fa73:e727]) by SLXP216MB0077.KORP216.PROD.OUTLOOK.COM
 ([fe80::3d9:7f82:fa73:e727%7]) with mapi id 15.20.6064.022; Thu, 2 Feb 2023
 05:28:21 +0000
From:   Ki-Seok Jo <kiseok.jo@irondevice.com>
To:     Mark Brown <broonie@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
CC:     Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ASoC: dt-bindings: Drop broken irondevice,sma1303 binding
Thread-Topic: [PATCH] ASoC: dt-bindings: Drop broken irondevice,sma1303
 binding
Thread-Index: AQHZNj6z/oQKqHubAEaPcBezJAe7N666EYoAgAANx4CAAAs2AIAABPOAgAC2qMCAADu0cA==
Date:   Thu, 2 Feb 2023 05:28:21 +0000
Message-ID: <SLXP216MB0077228B6071F62B183F4D648CD69@SLXP216MB0077.KORP216.PROD.OUTLOOK.COM>
References: <20230201131059.65527-1-krzysztof.kozlowski@linaro.org>
 <1bcd61d6-810f-1239-1b6e-367e0fe87370@linaro.org>
 <Y9pxGUMWyMeXQpZM@sirena.org.uk>
 <6491d6fb-2a10-1c80-d422-8300d5a75ce4@linaro.org>
 <Y9p+p6wt8WugDBuH@sirena.org.uk>
 <SLXP216MB00776F066D70DB2F3F77B09E8CD69@SLXP216MB0077.KORP216.PROD.OUTLOOK.COM>
In-Reply-To: <SLXP216MB00776F066D70DB2F3F77B09E8CD69@SLXP216MB0077.KORP216.PROD.OUTLOOK.COM>
Accept-Language: ko-KR, en-US
Content-Language: ko-KR
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=irondevice.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SLXP216MB0077:EE_|SL2P216MB1816:EE_
x-ms-office365-filtering-correlation-id: 70294a38-a72d-487c-6acd-08db04de4c50
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Ejsn35EVewYQB3BBfXZjDWuT9J2N13fafgR9H7Y1bXY4pBZA0KOdPx+SiD76kHtAQ71FN4lSpA8fzV2x5VauZkqxitDjYIJ/e+F1Q7qt0vwLbwZQ96cAzBmx0Vp8kqhbeR7jCk/1HUV+xHFOFXNdToFwUEn7wkdFZzBUaXRHRz78rYlsX+D3UlVTPLOUe9Vj10UErXpH1semeK+xZX2XMD5BJtvk26ccH/BcbLtwtRw/6DjACvGM28HdADnaoDS3DBYqA5dmFxk6UnDmQ5LcyIvxToHHtBIA0OWbVWR/hSgUprky/ps6hhPqz/1/cXaCNhOCbG3vq/AWtslFpOEtyCUBsL+79xIuY1CsxqDinibgMW/LiZ47lgg5XKrugFbaskED5ZkGju8fyCOnPlZ244gzHMwaWHK4OYpYmr2F79jA2TzckDKjeZ0FWjH2/yI3NAL8V6KcpJSa8laV9DIu2Ch/1trRHJa3OKI3g6EwXVFTskH09WZKeMAM9wBPA1fEkS4+VmI260EoF+TuMWT19HilcfB9/E/RTsTp3tFmVFqE9xLf8EzL9wEnKIYPwMSbkopu3nrnlSRz8aKNBSP2DhCjNnTCohEU8r8jY8XtXyxgFOI1gRJfskD53jdVQguoil0wqnmOVO7qOMs3qC9OEvFFsqMc8yXHlcQtomeVLcwH4u8AoIZp9buBBd4e2d2G
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SLXP216MB0077.KORP216.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230025)(376002)(136003)(396003)(346002)(366004)(39840400004)(451199018)(478600001)(76116006)(64756008)(66476007)(66556008)(66446008)(66946007)(38100700002)(83380400001)(8676002)(4326008)(54906003)(110136005)(99936003)(122000001)(316002)(6506007)(2940100002)(9686003)(26005)(186003)(33656002)(7416002)(5660300002)(86362001)(41300700001)(38070700005)(55016003)(71200400001)(7696005)(8936002)(52536014)(2906002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?uc4VEgExXWl1ZtFgP+ffhd+6fC3vqGuZDLhsK4ou9YQUrv3QCR9/4EF85JVh?=
 =?us-ascii?Q?dbw9MiyUIoF8ra3ts3rKSUj09nG7DIEWQMOhCHrW1K2d0WHm7xejdPCTunxN?=
 =?us-ascii?Q?GbeJjAufzI6n7t+i4xM6UYMTrIqB8BVD6Fk6RvoQTEH8IImFy3uFGbyUGeRV?=
 =?us-ascii?Q?xyRgx2xwwbU7I2AcWQcl91dovIElXpoF7niSRcL4WdTgSe46YhVex6YLyyu3?=
 =?us-ascii?Q?P3z5gkNjpE89engs/5PdrEsOR83ky5xNxTuyHjl3v8g8a1DfL59iY5up7kzO?=
 =?us-ascii?Q?IuL/s9D21lo6IQMlp5/ukyUj38S5s5qJbi2GzHodr3VHqvgbGV5u/vSgBb1/?=
 =?us-ascii?Q?DKp27CzykZo9w2m4npr4NzE6XAM+rGW/Qo9z6Bp52iMvtZ+eHHyZS7OCgJYj?=
 =?us-ascii?Q?Ez2R89f3+HkeLWbhm8Gc5iSGdrjK8+DcM5q6jafFA/2vAJsmH13YVXYSQkrU?=
 =?us-ascii?Q?z8K8x5nxQbHVHkZFuASrhv97X9sg8lwq+1wlO4UcS0eqnZCQf61ZXHD6lYCM?=
 =?us-ascii?Q?wzXAxi768HZs92tldQ51+gwkxJOHM3/tHCaEWvhr2qEkEoBxLc5rmv0/CN9X?=
 =?us-ascii?Q?WKRdB1w4TXsWK14if++MYMJLG5dIocxjDFuUQ3lts+MStK/S94FISael/6nY?=
 =?us-ascii?Q?warSBdgque185YXU59O3JjkRtKOvNEjN7arUExZz+n348cPAvJ2HVmKYJe0L?=
 =?us-ascii?Q?SrtDTaBru4o+R8bn8EIE1PhpdbmKNw4U/dQ8IltYWg+/AsqHhEh3lbEPCMWL?=
 =?us-ascii?Q?fXOBT5d7uFdBpo/UeTahC2t1mRO5cbX4Ezij/vJxk9ZFw6Hgd0BCDtdhrk4p?=
 =?us-ascii?Q?S0/7J3mJJ8cPp3icrsJYpYSTtQ/w0f1dUerUBHhecwkceU1kN4oaN2g5Ui9C?=
 =?us-ascii?Q?qrl6EaGyBpfltzgLwjk5JrT6+BwtM5Nms+uI+Cclezn8JfGxM9zeb0O+7z/c?=
 =?us-ascii?Q?UVrIRFE2z0F6gV+ncI/UkTmsj202bV6cAlbEhs6cBylePop3efP31PQEJzZD?=
 =?us-ascii?Q?SA/z6f5Bkfkzu40Usdb9GQhZARrihk2Xoo9zfDaj3v+TsiW7BII07Rl776Nn?=
 =?us-ascii?Q?11kvMuNb5RdkzqsFNFXXcxaiE83cYdpa8cqJ4QLG0ZspaE8Qcmd5pfXphNcB?=
 =?us-ascii?Q?OPKB48PIIXLlU3C9hmEqHjBP53wU/yVzlnD9gFA7MwOMvkW5sW3nul6h69mz?=
 =?us-ascii?Q?9Nigo9hWgbk++JTT/sSKQHoU0IDlz8kvR6f7D29Lh5GXILouBKSyuVhMHCfR?=
 =?us-ascii?Q?pNzPtfnlvRAi5J6sYs1dDX+kpjWklMVT2EeaaEa5mHnetG8GUi4HV7t50Dfn?=
 =?us-ascii?Q?tdeLe3OJ3D5WmHZBN+SGx7qQFwWZuYZYyss6khkW83at1ClrXn+wlOBO840h?=
 =?us-ascii?Q?eXyMZ7zgiTSwmIKGMvnhf/8KYIR1hmuG8PuWoGY2+bkhURfTQED1U5XouJBO?=
 =?us-ascii?Q?0rVP11OG1A5+EyNknZW6Ibqd94mINpOp/qfw/18dzc7sNwup6gq92mTJBtA5?=
 =?us-ascii?Q?Tm7OGp9BOztjaWUZFjdQOoLQ2k92VfC/NXOXfEJWBbL+T0ZQDhpuoten53+n?=
 =?us-ascii?Q?OiVM6w6dCgWFX2P0c3fUhwAAcxZUpGK4CaGrqe8o?=
Content-Type: multipart/mixed;
        boundary="_002_SLXP216MB0077228B6071F62B183F4D648CD69SLXP216MB0077KORP_"
MIME-Version: 1.0
X-OriginatorOrg: irondevice.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SLXP216MB0077.KORP216.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 70294a38-a72d-487c-6acd-08db04de4c50
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Feb 2023 05:28:21.2177
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b4849faa-3337-494e-a76a-cb25a3b3d7d1
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8S00MM53tpcFuBpFo+ybRlldnTbDM775z/A8iPr0ksM11vDFcU8OZpsDMOnHFSCu+t7uAXxVhydNkNaSuLn+XRMLg+40hJPeduCYwPzVnAg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SL2P216MB1816
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--_002_SLXP216MB0077228B6071F62B183F4D648CD69SLXP216MB0077KORP_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

> > > I tried. I started writing patch to fix few things in this binding
> > > and then noticed that it is entirely empty and documents nothing.
> >
> > I really don't see an empty binding as a major problem in and of
> > itself, we can always add properties later.  Again, I can't tell what
> > the problems you're seeing are.
> >
> > > The trouble is that soon you will send it to Linus and then it
> > > becomes the ABI even though no one ever approved or reviewed the
> actual ABI.
> >
> > So send a patch to delete the property parsing code then, like I say
> > removing the entire driver is very much an overraction.  The
> > properties are all optional in the code.
>=20
> Ok. I'm sorry for not checking correctly.
> I only reviewed using the full source build and checkpatch.pl.
> But I missed the config setting...
>=20
> So, could I get the information how to test the binding files?
> From what I've checked now, using make dt_binding_check, right?
>=20
> I'll try to read again like submitting-patches.rst and writing-
> bindings.rst.
> And then re-write the patch. I'm sorry again for not checking properly.
>=20
>=20
> Thanks Mark and Krzysztof to feedback.
>=20
> Best Regards,
> Kiseok Jo

So, was the entire thing dropped, or was only the binding dropped?
If they are not also, can I just patch in the current state?

And I tested the rewritten file with the following command.

  make dt_binding_check DT_SCHEMA_FILES=3Dirondevice,sma1303.yaml

Is there anything else I should do?

Thanks to your help, I think I am becoming a better developer.
I'll try harder. Thanks so much!

Best regards,
Kiseok Jo

--_002_SLXP216MB0077228B6071F62B183F4D648CD69SLXP216MB0077KORP_
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: signature.asc
Content-Disposition: attachment; filename="signature.asc"; size=499;
	creation-date="Thu, 02 Feb 2023 01:54:40 GMT";
	modification-date="Thu, 02 Feb 2023 05:28:20 GMT"
Content-Transfer-Encoding: base64

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0NCg0KaVFFekJBQUJDZ0FkRmlFRXJlWm9xbWRY
R0xXZjRwL3FKTmFMY2wxVWg5QUZBbVBhZnFZQUNna1FKTmFMY2wxVQ0KaDlCNFNRZi9WL3NkTldB
SEFrdGdMbC9UL2R0RktyeDM3UWU5d3hObHNJczVuQ0xEeCtQNEEwNzVMaG1MUUM3Lw0KQ0JSaE1J
alZQbVdvWE12TXorUWNyTDFZWnc0WXVxdCtwTWcwdk94a0t1UVFwbFBMSytzajFPczM2alQrTkxB
Ug0KVlhtdmhoc3kvb2hYdG5UZEQ3dHgrWXljcmxRQncyNVdkL2lNQkt6QlJIb3FqQkZDWVN5SnFL
Y1l0cXh3MmpxUQ0Kd0FveFl1TkppM05JWllIbE9kNHFWTEpUcDh6R21XMDIzTCtNb21oVEZUaW1i
cjk0bnBDVGJ6NDlDalZaOEI1dg0KYTlZSEFLaTNqc0RXcEl6NDVoTHNvNUdRWnZydmJ2UmJzdDN1
OTJkQU4yQ1hTUXBiM21XNzVFRG0rcm4yMVR1Rg0KQU50ZVYrcTVjUG9PMkNUOXpHZEdZQmhGWWU1
cEx3PT0NCj1tRmh6DQotLS0tLUVORCBQR1AgU0lHTkFUVVJFLS0tLS0NCg==

--_002_SLXP216MB0077228B6071F62B183F4D648CD69SLXP216MB0077KORP_--
