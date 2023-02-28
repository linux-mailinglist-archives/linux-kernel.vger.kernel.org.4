Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC2736A5B1D
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Feb 2023 15:53:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229672AbjB1Ox3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 09:53:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjB1Ox2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 09:53:28 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C991D2739;
        Tue, 28 Feb 2023 06:53:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1677596001; x=1709132001;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=64RoQ6yrpvtLlofInariZELt4tqsUtsA8AP36IvVqK4=;
  b=ldW3ZBAck1936ySCcjcIQh8h5BgwXk/K1kpVjGQihRbwiKyO3nlSJ8Ye
   ei9VXRUeyJc0Qx3exsT3/h9cg1HT8xk6NczW7Eh0swqS4U3YNajXtNiXl
   4E65nqBmfN1VKR4xny4onhI0u0wWElVH8ngLtXPD3DIPx/0ulLwOweh+l
   rH5CQThy5xTCZglrHf46x/7/Tkhg3mdZvQmM6bha7QtW8RwQ+d7X3mv9w
   neKuxX96JUuszenWdOnSWeS3DIHxdc6P3NxOw9jdlgS4vPWbgawLQBVk3
   AHzCjLrwJsDw9gD8zYvgM1RDCAxb4ckqnwTjawB8S9FKuejutAFft5Y2a
   A==;
X-IronPort-AV: E=Sophos;i="5.98,222,1673938800"; 
   d="scan'208";a="139450127"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 28 Feb 2023 07:53:19 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Tue, 28 Feb 2023 07:53:19 -0700
Received: from den-dk-m31857.microchip.com (10.10.115.15) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2507.16 via Frontend Transport; Tue, 28 Feb 2023 07:53:17 -0700
Message-ID: <e92081e700f5a0f6ef7940cf0ec8b4e48a972082.camel@microchip.com>
Subject: Re: [PATCH 10/20] reset: mchp: sparx5: remove MODULE_LICENSE in
 non-modules
From:   Steen Hegelund <steen.hegelund@microchip.com>
To:     Nick Alcock <nick.alcock@oracle.com>, <mcgrof@kernel.org>
CC:     <linux-modules@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        "Hitomi Hasegawa" <hasegawa-hitomi@fujitsu.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Lars Povlsen <lars.povlsen@microchip.com>,
        "Daniel Machon" <daniel.machon@microchip.com>,
        <UNGLinuxDriver@microchip.com>,
        <linux-arm-kernel@lists.infradead.org>
Date:   Tue, 28 Feb 2023 15:53:17 +0100
In-Reply-To: <20230228130215.289081-11-nick.alcock@oracle.com>
References: <20230228130215.289081-1-nick.alcock@oracle.com>
         <20230228130215.289081-11-nick.alcock@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 
MIME-Version: 1.0
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nick,

Looks good to me.

Reviewed-by: Steen Hegelund <Steen.Hegelund@microchip.com>

On Tue, 2023-02-28 at 13:02 +0000, Nick Alcock wrote:
> [Some people who received this message don't often get email from
> nick.alcock@oracle.com. Learn why this is important at
> https://aka.ms/LearnAboutSenderIdentification=C2=A0]
>=20
> EXTERNAL EMAIL: Do not click links or open attachments unless you know th=
e
> content is safe
>=20
> Since commit 8b41fc4454e ("kbuild: create modules.builtin without
> Makefile.modbuiltin or tristate.conf"), MODULE_LICENSE declarations
> are used to identify modules. As a consequence, uses of the macro
> in non-modules will cause modprobe to misidentify their containing
> object file as a module when it is not (false positives), and modprobe
> might succeed rather than failing with a suitable error message.
>=20
> So remove it in the files in this commit, none of which can be built as
> modules.
>=20
> Signed-off-by: Nick Alcock <nick.alcock@oracle.com>
> Suggested-by: Luis Chamberlain <mcgrof@kernel.org>
> Cc: Luis Chamberlain <mcgrof@kernel.org>
> Cc: linux-modules@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Cc: Hitomi Hasegawa <hasegawa-hitomi@fujitsu.com>
> Cc: Philipp Zabel <p.zabel@pengutronix.de>
> Cc: Lars Povlsen <lars.povlsen@microchip.com>
> Cc: Steen Hegelund <Steen.Hegelund@microchip.com>
> Cc: Daniel Machon <daniel.machon@microchip.com>
> Cc: UNGLinuxDriver@microchip.com
> Cc: linux-arm-kernel@lists.infradead.org
> ---
> =C2=A0drivers/reset/reset-microchip-sparx5.c | 1 -
> =C2=A01 file changed, 1 deletion(-)
>=20
> diff --git a/drivers/reset/reset-microchip-sparx5.c b/drivers/reset/reset=
-
> microchip-sparx5.c
> index f3528dd1d084e..ead25942061d2 100644
> --- a/drivers/reset/reset-microchip-sparx5.c
> +++ b/drivers/reset/reset-microchip-sparx5.c
> @@ -179,4 +179,3 @@ postcore_initcall(mchp_sparx5_reset_init);
>=20
> =C2=A0MODULE_DESCRIPTION("Microchip Sparx5 switch reset driver");
> =C2=A0MODULE_AUTHOR("Steen Hegelund <steen.hegelund@microchip.com>");
> -MODULE_LICENSE("Dual MIT/GPL");
> --
> 2.39.1.268.g9de2f9a303
>=20

BR
Steen
