Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 268C56D1CD7
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 11:45:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230411AbjCaJo7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Mar 2023 05:44:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231417AbjCaJoy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Mar 2023 05:44:54 -0400
Received: from todd.t-8ch.de (todd.t-8ch.de [IPv6:2a01:4f8:c010:41de::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECCCD1C1E3;
        Fri, 31 Mar 2023 02:44:33 -0700 (PDT)
Date:   Fri, 31 Mar 2023 11:44:27 +0200 (GMT+02:00)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
        s=mail; t=1680255868;
        bh=+6zYt1zjRTaRH/C18JTTsKBaYtC9zToJR3ul5Gq1b4E=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=BjeW3bEA0rzHVzpWrSPd+bszHoqhFbyDX1mN2FbQDzdfub94Hty3ldaftyNSX5Qe/
         egyRYmVFJCdZJqf0p7Ng2QO9hLOnyZgb2nhJIeYJBnaIlLr8r/DpzJw2OTndzv+3R6
         /obWaDUzoJUOz2zv9VhxvKkzbyLuqTlN+QETsMag=
From:   linux@weissschuh.net
To:     Brandon Nielsen <nielsenb@jetfuse.net>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Message-ID: <2cf99af4-2d6c-44b6-a133-4ff0d94dca20@weissschuh.net>
In-Reply-To: <20230331014902.7864-1-nielsenb@jetfuse.net>
References: <20230331014902.7864-1-nielsenb@jetfuse.net>
Subject: Re: [PATCH] Add "X570S AORUS ELITE" to known working boards
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Correlation-ID: <2cf99af4-2d6c-44b6-a133-4ff0d94dca20@weissschuh.net>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

thanks for the patch!


Mar 31, 2023 04:01:37 Brandon Nielsen <nielsenb@jetfuse.net>:

> ---
> drivers/platform/x86/gigabyte-wmi.c | 1 +
> 1 file changed, 1 insertion(+)
>
> diff --git a/drivers/platform/x86/gigabyte-wmi.c b/drivers/platform/x86/g=
igabyte-wmi.c
> index 4dd39ab6ecfa..ca5124e31d2c 100644
> --- a/drivers/platform/x86/gigabyte-wmi.c
> +++ b/drivers/platform/x86/gigabyte-wmi.c
> @@ -160,6 +160,7 @@ static const struct dmi_system_id gigabyte_wmi_known_=
working_platforms[] =3D {
> =C2=A0=C2=A0=C2=A0 DMI_EXACT_MATCH_GIGABYTE_BOARD_NAME("X570 GAMING X"),
> =C2=A0=C2=A0=C2=A0 DMI_EXACT_MATCH_GIGABYTE_BOARD_NAME("X570 I AORUS PRO =
WIFI"),
> =C2=A0=C2=A0=C2=A0 DMI_EXACT_MATCH_GIGABYTE_BOARD_NAME("X570 UD"),
> +=C2=A0=C2=A0 DMI_EXACT_MATCH_GIGABYTE_BOARD_NAME("X570S AORUS ELITE"),
> =C2=A0=C2=A0=C2=A0 DMI_EXACT_MATCH_GIGABYTE_BOARD_NAME("Z690M AORUS ELITE=
 AX DDR4"),
> =C2=A0=C2=A0=C2=A0 { }
> };
> -- > 2.39.2


This patch is missing a proper subject line, a commit message and Signed-of=
f-by.
Please send a v2 and take a look how similar patches are structured.

https://lore.kernel.org/lkml/20220705184407.14181-1-parherman@gmail.com/

Thomas
