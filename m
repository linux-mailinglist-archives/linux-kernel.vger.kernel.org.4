Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57D755EED5A
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 07:47:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234780AbiI2FrG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 01:47:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229780AbiI2FrD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 01:47:03 -0400
Received: from us-smtp-delivery-115.mimecast.com (us-smtp-delivery-115.mimecast.com [170.10.129.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B38AF12889B
        for <linux-kernel@vger.kernel.org>; Wed, 28 Sep 2022 22:47:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maxlinear.com;
        s=selector; t=1664430421;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=KzKmbycffM+3EFojRt7wDQwTm+r1a3K4lVt2tTJkC6c=;
        b=RrxzAWy84nP0gLMMaAsfDykmsvbUh+nDZbR53DCG7Tc0dxlhKzyG76UgxD65w3SMrrqy6g
        sr/iCpyklYZGxO9cqvTIQXXK6f0s98TpNmlwYZXolbXQheaf6URYAc+N8uf28sn9W76BMg
        QbSfV0bcK30zKTnkyBx+m++HK5AZS8afM8K1QYOMWxqeTazL61cGJbrO4bLaHD3+T69iwv
        B0Acj6s4DrgFvdmhGy6loArTzrAo4WI/WS0h++e+0o9c8x//yxukQUhFzv6r1xav+r710E
        fsTZc8ft3w3NJPL78zKHrFDsSlMGXQ6Xq3x6Nrc+D2cgS/DTnoxqSPK9zUH2uA==
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11lp2168.outbound.protection.outlook.com [104.47.56.168]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-391-18PeHrGpNpee3uMiPvc4XA-2; Thu, 29 Sep 2022 01:46:59 -0400
X-MC-Unique: 18PeHrGpNpee3uMiPvc4XA-2
Received: from MN2PR19MB3693.namprd19.prod.outlook.com (2603:10b6:208:18a::19)
 by DM4PR19MB6173.namprd19.prod.outlook.com (2603:10b6:8:b3::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.17; Thu, 29 Sep
 2022 05:46:57 +0000
Received: from MN2PR19MB3693.namprd19.prod.outlook.com
 ([fe80::f362:51bb:74a3:fe2c]) by MN2PR19MB3693.namprd19.prod.outlook.com
 ([fe80::f362:51bb:74a3:fe2c%7]) with mapi id 15.20.5676.015; Thu, 29 Sep 2022
 05:46:57 +0000
From:   Rahul Tanwar <rtanwar@maxlinear.com>
To:     Stephen Boyd <sboyd@kernel.org>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "mturquette@baylibre.com" <mturquette@baylibre.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-lgm-soc <linux-lgm-soc@maxlinear.com>
Subject: Re: [PATCH RESEND v2 5/5] clk: mxl: Add a missing flag to allow
 parent clock rate change
Thread-Topic: [PATCH RESEND v2 5/5] clk: mxl: Add a missing flag to allow
 parent clock rate change
Thread-Index: AQHYzkwIRUsGmIhXX0msbxfxInDDFw==
Date:   Thu, 29 Sep 2022 05:46:57 +0000
Message-ID: <MN2PR19MB36934441D5D78B03E03DD81AB1579@MN2PR19MB3693.namprd19.prod.outlook.com>
References: <cover.1663827071.git.rtanwar@maxlinear.com>
 <73cdb7cb3919b29a41a52da4904b1273bd81c7fe.1663827071.git.rtanwar@maxlinear.com>
 <20220929001815.D2F72C433B5@smtp.kernel.org>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN2PR19MB3693:EE_|DM4PR19MB6173:EE_
x-ms-office365-filtering-correlation-id: 10c371e8-d921-47e1-d2e2-08daa1de0589
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0
x-microsoft-antispam-message-info: q3fxVMy7lp+08QSXC225BlWT8QxpyubyQ9ai6c1NeyGtTXjx7IVHYRMTHRSHVlA0MpwXGpcrmjR4eGY6S3EANPkhCyqcBf5Y3JlSTNAMp8Nh+7Bb3W7upTpDAovhk8inQvhibT2ArOEONVBQYaqF8AteOmwjI9zZr4sXFShUM50SVVvGzu87QTjZjDBXL4wkPYSDz1gQYacQoqNd1254mjeG7hq1bv8S0VD3U9+JZqq12yrLer7UQfUZQ6BmVPcqobEG3uNhrpPAhDRcBgl3QhvDO2q/nHPN8qKdA2n8c1CHh+/qrx5Emiwp/Gsgwyj9+lPKQp+JjWQi5n3y0kNGjm9AFX7roeAL3UhsBsimScn/kATxW3BbQGKY7ViXHBU5IVxA+gJbFVvtkUEBZ/YVfh8aUdBDfKPtiKtPFuBAsUsuhERAn4I6iKsCzr0w06iQLlGhhZX1Yr5B6ulEMmDDMK6faPwfKcHKsr0FG4q1hpXjjbmYsBznl3ZsaYzpbLchc8DdqSlyfKKs3mHbdIHdv3Myn4H4E0xVckhTGRUq1EvehkWXB9V47cR6r7BXznH9936vgBIFH5Ops2tyQbNllgJrdzRwZ2gMfYUpmezzueKBKEBUah+gRNqDLLWYbU9FacrxGLf9t0XPDJpuzdFWcwqeE+K5WEh3gnK2ZYVaOYvifb/OeekvixXgybwtXDqkM+Vtbc0E8av0tXWH5AAd1V1Fv3VzW+Z3KUO8JoaEXrpoLYKfYmh5yT+Igjxb0uSvqtuQCx09Bunf/0SYV209dA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR19MB3693.namprd19.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(396003)(366004)(346002)(376002)(39850400004)(451199015)(83380400001)(71200400001)(54906003)(316002)(66446008)(66556008)(2906002)(55016003)(66476007)(41300700001)(64756008)(186003)(38070700005)(86362001)(110136005)(76116006)(52536014)(66946007)(107886003)(6506007)(4326008)(33656002)(26005)(7696005)(53546011)(5660300002)(38100700002)(4744005)(122000001)(478600001)(91956017)(8676002)(8936002)(9686003);DIR:OUT;SFP:1102
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?487L3vE6iPUitgfDpIjvv27Mdn9JyyPrDpHQLHdEIMHjfpa/Hkh4Y/nuja+y?=
 =?us-ascii?Q?l/+V7xDuoKSDdIGYegkBPOu+D5fPYdBQsBRXiSJckZDpK9mLxy5l5oSBN7gJ?=
 =?us-ascii?Q?UZrDvIeVAqZ1JXm5fqGKZGH6t4CwKRemTrHluPOYU18bI5dJxza3CVaTJJKs?=
 =?us-ascii?Q?xDqaMv0T4BJ9FqTVXdx1tYXk5M2H8k2cfMF7/EyUst9l9HWFNPj8c8NfOa5N?=
 =?us-ascii?Q?7EqcM4j3XXXfpGjBrQvnjAOI+Xal41fxwKrSv1eECa21l0AlVreVheM+NMg0?=
 =?us-ascii?Q?IlIGlKc43lHeBhNCbhWX6ZaR867waU53WXZFIPmYPoQjJ3AHCwhClpo26TqH?=
 =?us-ascii?Q?x3bnZZ5ho/9frwnGUgKGXP7a7e+kDPAZ5rHO1uwdmN9CZ7fo4PnLOxV4bg57?=
 =?us-ascii?Q?Mhj30Vu0LV/Fw1Rq5/DT2b2KHSR1MdeglfgbJGyDdSZxLjKw4m+6OGx8c+A5?=
 =?us-ascii?Q?CE99hRmF2du4pKZk1SDTuC1mmntdfszpYija6gi1wmTgL1teoejtxBdGQoAv?=
 =?us-ascii?Q?AE4QxWEElFO69scLEItGRaiutjTfdXgu7FbVHNiYG5BqfxI2RIJgBxYEnJ0T?=
 =?us-ascii?Q?iSZGgyJdr83AY18x1Sx/4Zs/gcwN00h4zvqjlZPRHGmWJQDx6sYnGUa2Is9e?=
 =?us-ascii?Q?hAFh+Y3BipYmuLjQkPAPdI/8q6sOcVXqpNniqnbZy3fKo20igxoZv2FdnYQQ?=
 =?us-ascii?Q?EgwDOyuVWqk/862H9ZodczEmOvF3L9699r8A8J2R/oN0aqIQiRjuFLk/n//Y?=
 =?us-ascii?Q?xRr9M8VIDa4EQWwFMdgN7VIAQD6/dMKG0wfEexaKuAd0+5FxF4CenZ0hZPVR?=
 =?us-ascii?Q?d5E6BoMYySePZjVRSW/KsJRw/s6tnskt3VGOv256Kksm+ARDFEnv9Z5JbhWf?=
 =?us-ascii?Q?dZGGgL46859m3EK4cELmadC5allTW4Lr4KmjBoPurpuUE8bE8IlzJxFtKS2u?=
 =?us-ascii?Q?ZRct4pvzAsQTagePaKEt+ZAlD6fetmiVkeC1RF9Xc85V0e15WpbI/3wGj3wh?=
 =?us-ascii?Q?0/vIjgR21j+0FSOwjgNfPxtNh6LhMlQWnv+ptUBmZlqjdIgQD/oExdkPBFQq?=
 =?us-ascii?Q?QSK8n5b2EPrRvxIhrvGLS4SC0OFfnzUoKvsSgQbdp64EoLYk4S9vk9FWkCuO?=
 =?us-ascii?Q?XI8be8GhMomPXTekjofVLPWQzkUFmQD6hEYDXoq7lso5D8JtLtswX7Owf6ji?=
 =?us-ascii?Q?6EyhBMKkvBsv1iuje94E+B9vae5pwyEc1WWYtWim3HXmwCpteurmev6+6wXj?=
 =?us-ascii?Q?kOQvs300i7vrjo6zUSqT8cIdULPNwI5oyhvv0HC5mrGEh0eARRc/H3BT8oji?=
 =?us-ascii?Q?d3Etg9wOKgHBnpdy27KFwahN//OHiA1B8SolvL6y1VVY6v925cCgPCI05ZrZ?=
 =?us-ascii?Q?X1FHuar1/Oql2LKhxOPdDSvAIOzUrAQDnjjG6k4lVnv1I/uSZ8Uyat9ZwOif?=
 =?us-ascii?Q?LFkGfPyIhLbCbA++Tvv1pKIzX8HBqcVKGHkjH098gWDpiEDBbthDaoGmELYq?=
 =?us-ascii?Q?SW/ZKlua8zoVPFmWi8a+/UOsTN4I+0YBLBN9uMxiUiPn3MEU/QLSeZPxRo0f?=
 =?us-ascii?Q?KQu/+327oxIOPrrM7YhkvtdxGXhZxxnENNJxDp8Ri9v2WAi/oqAYxh2E8xkB?=
 =?us-ascii?Q?0A=3D=3D?=
MIME-Version: 1.0
X-OriginatorOrg: maxlinear.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR19MB3693.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 10c371e8-d921-47e1-d2e2-08daa1de0589
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Sep 2022 05:46:57.3764
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: dac28005-13e0-41b8-8280-7663835f2b1d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SuPcyJrNcpBZ2xmjBe//CeZ75iwhLRk/B6loCxo+idWnQ3g6bYiKCY9bLoOE8DMH17TRh0JNxqi6ZslHNXYxfg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR19MB6173
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: maxlinear.com
Content-Language: en-US
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29/9/2022 8:18 am, Stephen Boyd wrote:=0A> This email was sent from outs=
ide of MaxLinear.=0A>=20=0A>=20=0A> Quoting Rahul Tanwar (2022-09-21 23:24:=
28)=0A>> One of the clock entry "dcl" clk's rate can only be changed by=0A>=
> changing its parent's clock rate. But it was missing to have=0A>> CLK_SET=
_RATE_PARENT flag as enabled.=0A>>=0A>> Add/enable CLK_SET_RATE_PARENT flag=
 for dcl clk in order to=0A>> allow its clk rate to be changed via its pare=
nt's clk.=0A>>=0A>> Signed-off-by: Rahul Tanwar <rtanwar@maxlinear.com>=0A>=
> ---=0A>=20=0A> Any Fixes tag?=0A>=20=0A=0A=0AMissed it, will add in v3.=
=0A=0AThanks,=0ARahul=0A=0A=0A>=20=0A=0A

