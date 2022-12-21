Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B528F6530D7
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Dec 2022 13:33:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230465AbiLUMdb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Dec 2022 07:33:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229652AbiLUMd2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Dec 2022 07:33:28 -0500
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93CE6DF5F
        for <linux-kernel@vger.kernel.org>; Wed, 21 Dec 2022 04:33:27 -0800 (PST)
Received: from pendragon.ideasonboard.com (cpc89244-aztw30-2-0-cust3082.18-1.cable.virginm.net [86.31.172.11])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 51A6FFB;
        Wed, 21 Dec 2022 13:33:25 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1671626005;
        bh=5Fd2x2guEXhJvwsldua4/D1afcQdq+w5Tdig2fs5xT4=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=oylmFDmpwe19jgOU9ccsnHaXmatKYGIHtxpuqVJpQsyWHx+HvUbI60OYAfRcSH4Pm
         dFq8xU+Z2huSzm3NiJalMifeCXhUJYBS9hkIBvvv7mqyBMd35Er2jtSBSLMPLE4woj
         bMBrzycYHMJ+DwLgEKZnZLZp22Yw2tFHbuA53xDY=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20221221074047.233473-1-umang.jain@ideasonboard.com>
References: <20221221074047.233473-1-umang.jain@ideasonboard.com>
Subject: Re: [PATCH] staging: vchiq_arm: Remove extra struct vchiq_instance declaration
From:   Kieran Bingham <kieran.bingham@ideasonboard.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Adrien Thierry <athierry@redhat.com>,
        Stefan Wahren <stefan.wahren@i2se.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Umang Jain <umang.jain@ideasonboard.com>
To:     Umang Jain <umang.jain@ideasonboard.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-rpi-kernel@lists.infradead.org, linux-staging@lists.linux.dev
Date:   Wed, 21 Dec 2022 12:33:22 +0000
Message-ID: <167162600273.3944359.9522944722768752331@Monstersaurus>
User-Agent: alot/0.10
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Umang Jain (2022-12-21 07:40:47)
> Additional declaration of struct vchiq_instance was introduced in the
> commit 726e79f8a648 ("staging: vchiq_arm: pass vchiq instance to
> service callbacks"). Drop the extra declaration.
>=20
> Fixes: 726e79f8a648 ("staging: vchiq_arm: pass vchiq instance to service =
callbacks")
> Signed-off-by: Umang Jain <umang.jain@ideasonboard.com>

It's tempting to move the other instance up to near the top of the file
too, but not necessary.

Reviewed-by: Kieran Bingham <kieran.bingham@ideasonboard.com>

> ---
>  drivers/staging/vc04_services/include/linux/raspberrypi/vchiq.h | 2 --
>  1 file changed, 2 deletions(-)
>=20
> diff --git a/drivers/staging/vc04_services/include/linux/raspberrypi/vchi=
q.h b/drivers/staging/vc04_services/include/linux/raspberrypi/vchiq.h
> index 66965da11443..52e106f117da 100644
> --- a/drivers/staging/vc04_services/include/linux/raspberrypi/vchiq.h
> +++ b/drivers/staging/vc04_services/include/linux/raspberrypi/vchiq.h
> @@ -78,8 +78,6 @@ struct vchiq_service_params_kernel {
>         short version_min;   /* Update for incompatible changes */
>  };
> =20
> -struct vchiq_instance;
> -
>  extern int vchiq_initialise(struct vchiq_instance **pinstance);
>  extern int vchiq_shutdown(struct vchiq_instance *instance);
>  extern int vchiq_connect(struct vchiq_instance *instance);
> --=20
> 2.38.1
>
