Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE4C86C945D
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Mar 2023 14:55:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231904AbjCZMzq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Mar 2023 08:55:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229901AbjCZMzo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Mar 2023 08:55:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AE09421C
        for <linux-kernel@vger.kernel.org>; Sun, 26 Mar 2023 05:55:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EC5FB60ED8
        for <linux-kernel@vger.kernel.org>; Sun, 26 Mar 2023 12:55:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B81EC4339C;
        Sun, 26 Mar 2023 12:55:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679835342;
        bh=ubdl5TTM9L2aMksryZTZ6yEHbF8j+VsWvgFdWaQW7WM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hN5Pfo5D7EmPv5LUn7mTqJuS8aK2pJ0J8R29SOjUw+txKABL+NK5l9YX5wO9o/Y5A
         b7DusX/fKCO1kww7hWt8Zt0ZVHWR3fpDD34I4sM1xHIgrV6CeaujaYocrGu/Niw0Ax
         hihj5pLtu0+nGLx+PI+vJvGaqyqyfRh0PR2S2B1kWZbu1CHgGLTqfnwoJihqMIcmIG
         JZBELZyOgxjlDSNz54u5SqPh65KIN9gC3OVFYw/zm7Y2TiHuI2JzbPiySU/BsCKQk+
         +XtPchcTCVMfEHY/F1MCVgajTs8WXlHlzCk3Pz/Ok369H+NbuTMKkUqVamMYo+bH6X
         PqBS5+W0+3cDg==
Date:   Sun, 26 Mar 2023 14:58:16 +0200
From:   Marek =?utf-8?B?QmVow7pu?= <kabel@kernel.org>
To:     Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
Cc:     Gregory CLEMENT <gregory.clement@bootlin.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND] firmware: turris-mox-rwtm: make kobj_type
 structure constant
Message-ID: <20230326125759.qhq62wjaeu75rd3j@kandell>
References: <20230227-kobj_type-firmware-turris-v1-1-e48f65155ec5@weissschuh.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230227-kobj_type-firmware-turris-v1-1-e48f65155ec5@weissschuh.net>
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Didn't I already give reviewed-by tag?

Reviewed-by: Marek Behún <kabel@kernel.org>

On Fri, Mar 24, 2023 at 04:27:50PM +0000, Thomas Weißschuh wrote:
> Since commit ee6d3dd4ed48 ("driver core: make kobj_type constant.")
> the driver core allows the usage of const struct kobj_type.
> 
> Take advantage of this to constify the structure definition to prevent
> modification at runtime.
> 
> Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
> ---
>  drivers/firmware/turris-mox-rwtm.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/firmware/turris-mox-rwtm.c b/drivers/firmware/turris-mox-rwtm.c
> index 6ea5789a89e2..2de0fb139ce1 100644
> --- a/drivers/firmware/turris-mox-rwtm.c
> +++ b/drivers/firmware/turris-mox-rwtm.c
> @@ -104,7 +104,7 @@ static void mox_kobj_release(struct kobject *kobj)
>  	kfree(to_rwtm(kobj)->kobj);
>  }
>  
> -static struct kobj_type mox_kobj_ktype = {
> +static const struct kobj_type mox_kobj_ktype = {
>  	.release	= mox_kobj_release,
>  	.sysfs_ops	= &kobj_sysfs_ops,
>  };
> 
> ---
> base-commit: 2fcd07b7ccd5fd10b2120d298363e4e6c53ccf9c
> change-id: 20230227-kobj_type-firmware-turris-6cd4a66bac19
> 
> Best regards,
> -- 
> Thomas Weißschuh <linux@weissschuh.net>
> 
