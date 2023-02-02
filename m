Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AEFC6873C3
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 04:23:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231612AbjBBDXn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Feb 2023 22:23:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231200AbjBBDXk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 22:23:40 -0500
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2123.outbound.protection.outlook.com [40.107.117.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 063404FC13;
        Wed,  1 Feb 2023 19:23:36 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MpPTeTIaIh3AaoOYhg3Z4mJWARpkmXNwuKZl+RVLNx5boXOtji/5dFseuq36xQcW52P2qOat4QM+llkVxVY4uBGOkJ0r1cqtvaZlma/amKtI22m8BwTNv25L7SDcjkwRip5ASLQY3UWsNrZRnySKgHWiRKmBbVqavgqAII/VLODBAdOMNkOgC4+/l/7SUoP8QuO32UILJh/jiPq/RcxKgFwOWaxUJtqwGunqyxDMMb1a/8tiz7vpDivDAaucVr5DqZydh2y4CBfp2M0Fws5QXsKiP0z4wsc0m7PmEgN5bf7NA3/nIg81Cm/EkbVS5NiQXTN4y8lJ8HJemStLmxGtLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cog8qpzSmcaxWDqx/naGpx+aMgX9wjn/cvx6pAkm6Gg=;
 b=GgQmq+zm8l2FXlR5IlC3uW/6wTQ7lez4Oo+zt9TuPqJXVe4RbVVnasJ/JEKZ69PiaQtvEcXDqJyAKL9qHeh09DQtUnq7EemPlrDCUqm4mz113tHD00ohIUSfwKD/Jid9zSxiAP0vehzDnd+JG2hNwPF8k7gX0UZ3YNVUfjACNwjMtrDOEGZnaIPuvmFFvdxn6tKy633Vt1O/I63o+rQOhxwHKn1Cue2HexkAf0OW/Z89dYgjvEcwi58njDzffMqMNV2y2FpkEIucUxLX0usQDRvrrOoHaNeUzaQ+WZATH/If567aZmhrQX9mQWgqlBd76vRJesGf+nWj00xkqhDGUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cog8qpzSmcaxWDqx/naGpx+aMgX9wjn/cvx6pAkm6Gg=;
 b=DmRRC2L8n7F3Zpo37BNYlpCNmOx3iMN87/oblW34hQi3x6JM9kqhgt2D4947fxrBR5IpCHSMDath6XONk/HsvROyNpKsjp1V/1c+7qJsQRTdB+tyAKIBbNgC0KshzWgJwfpnqNLaCQMG9rh9YsfZtoFB4NPxfcYHiYcthJl1wEs+m/sfh4x5IrTPkx/zLfHohwCrrbOHlb5H1ohnjkDkvwfcCyZEr9oT6bPSVe4BQcfk2AojzlDBwbZKjQomhhK1Qeb9Z4rfx3ZXnXUKiFgxxprhdC4NqFDExpx0Pi+5Cj0ddL8XHEZnEupFnfr6K6WilanL93H4+8LF7CE3HccooA==
Received: from TY2PR06MB3213.apcprd06.prod.outlook.com (2603:1096:404:97::16)
 by KL1PR0601MB4559.apcprd06.prod.outlook.com (2603:1096:820:8f::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.22; Thu, 2 Feb
 2023 03:23:30 +0000
Received: from TY2PR06MB3213.apcprd06.prod.outlook.com
 ([fe80::b113:70f9:7dc9:543f]) by TY2PR06MB3213.apcprd06.prod.outlook.com
 ([fe80::b113:70f9:7dc9:543f%7]) with mapi id 15.20.6064.022; Thu, 2 Feb 2023
 03:23:29 +0000
From:   Neal Liu <neal_liu@aspeedtech.com>
To:     Herbert Xu <herbert@gondor.apana.org.au>
CC:     Joel Stanley <joel@jms.id.au>, Andrew Jeffery <andrew@aj.id.au>,
        "David S . Miller" <davem@davemloft.net>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-aspeed@lists.ozlabs.org" <linux-aspeed@lists.ozlabs.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>
Subject: RE: [PATCH-next] crypto: aspeed: fix type warnings
Thread-Topic: [PATCH-next] crypto: aspeed: fix type warnings
Thread-Index: AQHZNrHmMT+Cp3JQVkSaFLeXTAj48q66+kKAgAAC+UA=
Date:   Thu, 2 Feb 2023 03:23:29 +0000
Message-ID: <TY2PR06MB321395387369059BC9F9722E80D69@TY2PR06MB3213.apcprd06.prod.outlook.com>
References: <20230202025600.2598548-1-neal_liu@aspeedtech.com>
 <Y9spg/66x/wQ3x+g@gondor.apana.org.au>
In-Reply-To: <Y9spg/66x/wQ3x+g@gondor.apana.org.au>
Accept-Language: en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY2PR06MB3213:EE_|KL1PR0601MB4559:EE_
x-ms-office365-filtering-correlation-id: 5352615a-824d-44e8-fc79-08db04ccdb12
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: yo0pIUoE01ryxFZq2PpjoZoGAnf5h9wNoHYUKDlaO2qddYsN2220wuwIEONtpZR3t9HfFpPQDcgPaex+KLzCEXDEA4y0bce89q+FveHZkku0zwOly58DBu6H1n+onO3B5tIDfcGAVzerwVgxlQtl0ot0Ui28w7b91KRlJAFs3QILGQenvZq7lG6y5v4+dxjF9tkiNeOLycWepg/Tbd/uwAha7Ukp4YfzrinGxlqZQkBBYFm60Gyw4n7SIRphVmXcFdukMGHnKuP2q2W6NSCuOyATX7lqpz7VdSk3E07KVQCMVJSxHcIa4i+BfV9k6OUQlkljfOK/5pURK5XfhPdNnbJI+wRVQs0NLTZSg5f4crCfRLnvyzfb5jglPonvdq4zNqglASd3/zhTaPrAjYroPMiLuPkfFhx/F191PCduBHFeZmeSpTBVU1oYSpmEg0IJN6+a050NwGOTqdWr8uHzqIIucCH4J0AwdZoPYYPsTkHRWWU71SXSJDc0x2WOeHiDWlzWnXU50nW5TQRhSuWvGA/qV1czbn73PxcZdNPSMKYlHzRnPxRReP5hS+lqxb5fgbZZ72z+2eG1CJmDHIwaJXW8TbdeHxr5qsXCVO9q7RJ6nF52do/ROCxfAeaRvKI4FbspCHqm5DCCZc9j0d6K0XhzDDf/HhnXnLT2eQKL0vwL/a1IjOyVvk6wAsAew7Z5YTWnX5PzqRXakRccd89h4Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY2PR06MB3213.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(136003)(346002)(396003)(39850400004)(366004)(376002)(451199018)(33656002)(66476007)(316002)(64756008)(66556008)(6916009)(54906003)(8676002)(4326008)(5660300002)(41300700001)(8936002)(66946007)(76116006)(66446008)(52536014)(38100700002)(38070700005)(122000001)(86362001)(55016003)(53546011)(26005)(6506007)(9686003)(186003)(71200400001)(4744005)(2906002)(7696005)(478600001)(83380400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?8PCUFn4sd/VatAIX9SBDGXf7XzkHlvKE6OzmpffNU+12qfsRQZKL6afX3lFY?=
 =?us-ascii?Q?Xkd6mZfTvc/f99vB2Y30EgfvniElIOxDe6d8qY1lXqWtdYpIubDNR7dYhz6q?=
 =?us-ascii?Q?b3ebSg/9BG0VsvSkX0pGPxxg8T1iNr8kIIfzxIWSa5262S0f9Yi6eqWSXptw?=
 =?us-ascii?Q?w14/F46iqbmFc71gUDeJOqi30D4N0tE1ox4Ckl4fk/WOpAHv8Tn3upGr1Sxy?=
 =?us-ascii?Q?9+xXk8mA3qR+cJhxsuajsPqvD1HRsFnLn9hJ0i9/Ei4YFKbyBqgXEzJgWK2f?=
 =?us-ascii?Q?jaIqa/0303YzaiDwdS0irQF/Yi/qbHdx5aSUhUy0i1rV1v/XA5drRykHiECe?=
 =?us-ascii?Q?w6B15jJC5RtGqPcozX+cZAIlYII1JUus1VlKx63OYChDfKdn7u5lvXV1zFNN?=
 =?us-ascii?Q?s2NbluvJtmTYUaa235WpmL8nBgY2EataXxQ2pMJ8YsRDrYmBXFxF9vUsrHyg?=
 =?us-ascii?Q?zwLedVBSZcVp3W0/3I9b5jLpfiR10YlcPLYJiLWkZleyfeORTg36wsOnBP21?=
 =?us-ascii?Q?1PAbFUxHNxiYruIpi79u/p8rc68Ucsq9QSnneh1PaLRu3IwHH54RCNUhEVtq?=
 =?us-ascii?Q?14JuKBXW8b7IkcjH1OaxUUe125B9CXAL7wEszxdzot1CJro3UiNxdhaBZ5rL?=
 =?us-ascii?Q?+okukk9+9dMDfFBZTR6hXXJ2RPZBFTleRS5aMoW0NzY/naom6ee4+1xWRtB1?=
 =?us-ascii?Q?l08UUwr/26jssDQJ2CV1UA4sfGTE67hy05tAliEeXB9EDderWsU6R1iSZA38?=
 =?us-ascii?Q?gdHB9/8ndokSFDycSTahCKbMCH6zZb7EckYkKa966LOPnzOLu0A16zKpKfT7?=
 =?us-ascii?Q?gWTvd+L0whi3qpmKlFuRMhME3UzHrqG3XzZFzw+cin440/EWZdz2Ynfrtar+?=
 =?us-ascii?Q?tER4Gx92HK5W4tmPHYQOzykcI5ykFYsu1ZqwXtWqTlAtFatnZ+DC7BqOFw2b?=
 =?us-ascii?Q?rwAqyYhOXqFaFv9xsW/fPfFK/fvRnyR3GeACXd5hCXrr0jCA6WbOQLR9Zgrf?=
 =?us-ascii?Q?YBgQPM7SZNPWeeIW0+nyRDJf7Vsi7DSD3DtRds+55TvmhVHXS3L633TQi8f+?=
 =?us-ascii?Q?3ZlwEzpn2qSKsI8CLB1D3KOz/C8uDoMFrZP/JB2HP2bLtwCCsavCG3i522Ip?=
 =?us-ascii?Q?pUsaYiELs+my32uBcGHjmKrkmhzxcJz7+d6tJ3V31UCBau5XyavZfhqeYqom?=
 =?us-ascii?Q?z83qpEOGJ6dn0BVDLIKZ3Rdkid/67InjfgSxx6zC1IfDXnHEzSjvujBCUGC9?=
 =?us-ascii?Q?RZ/JmWjzaES5aL74Xqb8coai1ybsFoBLucyYk/owVW0CsjFyxu1KAGt+JmjR?=
 =?us-ascii?Q?5xakPsXJ3BtrDibn3+6DOxPjj0fYIup4GsEKHK6ecQsY5ZOpKVL4H/0INScr?=
 =?us-ascii?Q?z2EK9UmLzMHG5Dictyn5u1DpNEUToIUjOAs5i7AsK9i2zKNfnH1c4AzFRZEM?=
 =?us-ascii?Q?lG0ClmuSayV7d254dkN7Su14FnkfTcPn2cesIz+qBWgJWSvm/+fSZ7OBKE2k?=
 =?us-ascii?Q?q0porg3QeY0o3IobvNVuZS/XtJNUSP/vxM8PB2eyX0wm16YBJBCpB9zBBs/y?=
 =?us-ascii?Q?tak2m+tYvXBGvD7gn6zn0tlwfOkpavp1KhZZL5w8?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY2PR06MB3213.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5352615a-824d-44e8-fc79-08db04ccdb12
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Feb 2023 03:23:29.7726
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WO4TWgfL9PfALmP+9B0sBPWj+t7yM5vxrm9FBqckMaAyb9OECeNI02Qys9twSa2Fhf8rQ7xb3QoT2YzOyXtAkw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR0601MB4559
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> -----Original Message-----
> From: Herbert Xu <herbert@gondor.apana.org.au>
> Sent: Thursday, February 2, 2023 11:10 AM
> To: Neal Liu <neal_liu@aspeedtech.com>
> Cc: Joel Stanley <joel@jms.id.au>; Andrew Jeffery <andrew@aj.id.au>; Davi=
d
> S . Miller <davem@davemloft.net>; linux-arm-kernel@lists.infradead.org;
> linux-aspeed@lists.ozlabs.org; linux-kernel@vger.kernel.org;
> linux-crypto@vger.kernel.org
> Subject: Re: [PATCH-next] crypto: aspeed: fix type warnings
>=20
> On Thu, Feb 02, 2023 at 10:56:00AM +0800, Neal Liu wrote:
> >
> > @@ -302,7 +302,7 @@ static int aspeed_acry_rsa_ctx_copy(struct
> > aspeed_acry_dev *acry_dev, void *buf,  static int
> > aspeed_acry_rsa_transfer(struct aspeed_acry_dev *acry_dev)  {
> >  	struct akcipher_request *req =3D acry_dev->req;
> > -	u8 *sram_buffer =3D (u8 *)acry_dev->acry_sram;
> > +	u8 *sram_buffer =3D (u8 __force *)acry_dev->acry_sram;
>=20
> Wouldn't it be better to keep the iomem marker and then use readb on
> sram_buffer?
>=20
This way works too.
I cannot tell which way is better. Do you prefer to keep the iomem marker?
Thanks

-Neal
