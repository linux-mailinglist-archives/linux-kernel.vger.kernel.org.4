Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37B89682BFD
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 12:56:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231859AbjAaL4R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 06:56:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231778AbjAaL4Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 06:56:16 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED1C84C0FE
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 03:56:14 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 31284CE1D98
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 11:56:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7272CC4339B
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 11:56:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675166171;
        bh=wRCvfnECS+TaNzM15rM9zUuk3Gnb1rcqeccYV5WNn9E=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=SoGjF9oWEf6SLcJzbKrqDxoXCmf7frtP86+EDJ3kWAMscEcl6IGlLsP6Y9lWgtjNe
         C6NnZYmX4vwoGJMElKMS6LtOttFksZARGMvzrG+ou092pGOV4+E0dEy6NMIlBgrKvg
         0Yh3OyuDxKKxEgx0Mr9yI2xySX9RJf1lNvMkVORSRhYudsd72oNIlQipN/y2FnUVnr
         o7VhpDoOhYrW+cvrAD6LxP4Lbq0l1V6MiH6iuHysoWcfay81P5gt0WMfNRgMN0+SvL
         kBUs1eLQv0UBefDa2zaL2ebLaem5JHGQ2bavF0K2K7mSoeFzRanukO6h/l84SX9dd0
         g1+sQWJRJ2pew==
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-50aa54cc7c0so172113717b3.8
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 03:56:11 -0800 (PST)
X-Gm-Message-State: AO0yUKVKwM+BdZ+i8yl8NjmYnwyvvaFF/POxuKuGZg4xshgTfLYmO09o
        XkEKP6wqGZsycPtiuzLLIMiBpTPDKwUnEinMvNs=
X-Google-Smtp-Source: AK7set+Dt/F0Do5/LaT6yA03kC67uscO3wPrVxSx/gX7jcRpuYRplli6hsYRgGDvzl6JkfmHbYXVU4x2tNZo5RojBSw=
X-Received: by 2002:a05:690c:c81:b0:506:38b7:774e with SMTP id
 cm1-20020a05690c0c8100b0050638b7774emr4862284ywb.135.1675166170545; Tue, 31
 Jan 2023 03:56:10 -0800 (PST)
MIME-Version: 1.0
References: <20230124104145.3962497-1-geert+renesas@glider.be>
In-Reply-To: <20230124104145.3962497-1-geert+renesas@glider.be>
From:   Oded Gabbay <ogabbay@kernel.org>
Date:   Tue, 31 Jan 2023 13:55:44 +0200
X-Gmail-Original-Message-ID: <CAFCwf12P7S=U+LdtQjzVYnXwnWYTOq+Cre0F+N=tWFg4f23xHg@mail.gmail.com>
Message-ID: <CAFCwf12P7S=U+LdtQjzVYnXwnWYTOq+Cre0F+N=tWFg4f23xHg@mail.gmail.com>
Subject: Re: [PATCH] drivers: Restore alignment and newline in Makefile
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jacek Lawrynowicz <jacek.lawrynowicz@linux.intel.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 24, 2023 at 12:42 PM Geert Uytterhoeven
<geert+renesas@glider.be> wrote:
>
> The introduction of drivers/accel/ broke alignment, and removed the
> newline at the end of the file.  Fix all of that.
>
> Fixes: 35b137630f08d913 ("accel/ivpu: Introduce a new DRM driver for Intel VPU")
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
>  drivers/Makefile | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/Makefile b/drivers/Makefile
> index f0972e2226c97cb5..9ea6eb3b5d7b7f17 100644
> --- a/drivers/Makefile
> +++ b/drivers/Makefile
> @@ -189,4 +189,4 @@ obj-$(CONFIG_COUNTER)               += counter/
>  obj-$(CONFIG_MOST)             += most/
>  obj-$(CONFIG_PECI)             += peci/
>  obj-$(CONFIG_HTE)              += hte/
> -obj-$(CONFIG_DRM_ACCEL)        += accel/
> \ No newline at end of file
> +obj-$(CONFIG_DRM_ACCEL)                += accel/
> --
> 2.34.1
>
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
