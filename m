Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC1CA6C03C4
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Mar 2023 19:24:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229821AbjCSSYO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Mar 2023 14:24:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbjCSSYM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Mar 2023 14:24:12 -0400
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D7CA1ADF7;
        Sun, 19 Mar 2023 11:24:08 -0700 (PDT)
Received: (Authenticated sender: herve.codina@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 39C2940002;
        Sun, 19 Mar 2023 18:24:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1679250247;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UxKJ5DqiHIKx6uJVgysoPzQWoYyFGH7gsA6iqa5x6zM=;
        b=lnJmxOVr1SeA5dJXwWhxXkKpUi16Mz6Gga2nftt9alNqQztJWa9xF8CpzrHFkHWuL9MwS7
        0d4lMp3VOfUs/F2UdbXdLu4iXnfy14Ic199tawTfU0adAg/pQFt6UvOy64vy3GdWdjTYL7
        AVSEo8Y5N37fY+9R2gbO7QU5T9CoyllK1VtyiAUDl7UbzP+6Dpq4cb24SD1TF0MQcsOsxh
        DfOQZ7T+RMZg9SC2TD9KwSbY7tN2zOLOWKUb1uIPQsQrMr3HWAE5QMOWtK/xgaqESfb94J
        aiqNeQcgk21/VIrdICiCbQlMlWcqeFuPYKE8FoLb1Kc+K/ej5ivP9hRxNdJviQ==
Date:   Sun, 19 Mar 2023 19:24:05 +0100
From:   Herve Codina <herve.codina@bootlin.com>
To:     Tom Rix <trix@redhat.com>
Cc:     gregkh@linuxfoundation.org, nathan@kernel.org,
        ndesaulniers@google.com, linux-renesas-soc@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev
Subject: Re: [PATCH] usb: gadget: udc: remove unused usbf_ep_dma_reg_clrset
 function
Message-ID: <20230319192405.6202ea2b@bootlin.com>
In-Reply-To: <20230319155910.1706294-1-trix@redhat.com>
References: <20230319155910.1706294-1-trix@redhat.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.37; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tom,

On Sun, 19 Mar 2023 11:59:10 -0400
Tom Rix <trix@redhat.com> wrote:

> clang with W=3D1 reports
> drivers/usb/gadget/udc/renesas_usbf.c:548:20: error: unused function
>   'usbf_ep_dma_reg_clrset' [-Werror,-Wunused-function]
> static inline void usbf_ep_dma_reg_clrset(struct usbf_ep *ep, uint offset,
>                    ^
> This function is not used, so remove it.
>=20
> Signed-off-by: Tom Rix <trix@redhat.com>
> ---
>  drivers/usb/gadget/udc/renesas_usbf.c | 11 -----------
>  1 file changed, 11 deletions(-)
>=20
> diff --git a/drivers/usb/gadget/udc/renesas_usbf.c b/drivers/usb/gadget/u=
dc/renesas_usbf.c
> index cb23e62e8a87..84ac9fe4ce7f 100644
> --- a/drivers/usb/gadget/udc/renesas_usbf.c
> +++ b/drivers/usb/gadget/udc/renesas_usbf.c
> @@ -545,17 +545,6 @@ static inline void usbf_ep_dma_reg_bitclr(struct usb=
f_ep *ep, uint offset,
>  	usbf_ep_dma_reg_writel(ep, offset, tmp);
>  }
> =20
> -static inline void usbf_ep_dma_reg_clrset(struct usbf_ep *ep, uint offse=
t,
> -					  u32 clr, u32 set)
> -{
> -	u32 tmp;
> -
> -	tmp =3D usbf_ep_dma_reg_readl(ep, offset);
> -	tmp &=3D ~clr;
> -	tmp |=3D set;
> -	usbf_ep_dma_reg_writel(ep, offset, tmp);
> -}
> -
>  static void usbf_ep0_send_null(struct usbf_ep *ep0, bool is_data1)
>  {
>  	u32 set;

Yes, indeed.

Acked-by: Herve Codina <herve.codina@bootlin.com>

Thanks for the patch.
Regards,
Herv=C3=A9

--=20
Herv=C3=A9 Codina, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
