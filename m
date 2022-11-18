Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3093263003E
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 23:39:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229774AbiKRWjM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 17:39:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229720AbiKRWjK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 17:39:10 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCEAED112;
        Fri, 18 Nov 2022 14:39:08 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 24BB0CE224D;
        Fri, 18 Nov 2022 22:39:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48F4AC433D6;
        Fri, 18 Nov 2022 22:39:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668811145;
        bh=7G8ECLw1ELEqxR6Z8QunxLZvnkLl+Xk4JcotDxWZGTU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MqNvnouuMLsZXAjO0uvS7Uenbre81ICnQjgiFWQrB1S4P4QV5UroFyWsFOR9omKaU
         FfoR3j0xrx0dXV432YtcMzMicjMJ+QMLDygQqlkFgXa5etVWZUhb3Sshx9uyHyDxan
         qVti8010/ZiFLOu5kV6rH98JcPZHh+XicKWuEbZdpK349/257mTO/mMH01LaVvWtHR
         4oE/WZ5fd00M4qjPRfRCjKBifoKM1v5VcfyUuAIvkmrz4LLw3NfRiNO7f7BsiyGIUv
         9w1R0Hb5afE94Nj8iEUWt5kai2gIS4mbuqs3+9ut6MblR3c2XMNauYsemh9kcpFL2g
         YQcZJsXBui2AA==
Date:   Fri, 18 Nov 2022 16:38:52 -0600
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     Ben Skeggs <bskeggs@redhat.com>, Karol Herbst <kherbst@redhat.com>,
        Lyude Paul <lyude@redhat.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Gourav Samaiya <gsamaiya@nvidia.com>,
        dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] drm/nouveau/fb/ga102: Replace zero-length array of
 trailing structs with flex-array
Message-ID: <Y3gJfLIGUTTdajY4@work>
References: <20221118211207.never.039-kees@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221118211207.never.039-kees@kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 18, 2022 at 01:12:08PM -0800, Kees Cook wrote:
> Zero-length arrays are deprecated[1] and are being replaced with
> flexible array members in support of the ongoing efforts to tighten the
> FORTIFY_SOURCE routines on memcpy(), correctly instrument array indexing
> with UBSAN_BOUNDS, and to globally enable -fstrict-flex-arrays=3.
> 
> Replace zero-length array with flexible-array member.
> 
> This results in no differences in binary output.
> 
> [1] https://github.com/KSPP/linux/issues/78
> 
> Cc: Ben Skeggs <bskeggs@redhat.com>
> Cc: Karol Herbst <kherbst@redhat.com>
> Cc: Lyude Paul <lyude@redhat.com>
> Cc: David Airlie <airlied@gmail.com>
> Cc: Daniel Vetter <daniel@ffwll.ch>
> Cc: Gourav Samaiya <gsamaiya@nvidia.com>
> Cc: "Gustavo A. R. Silva" <gustavoars@kernel.org>
> Cc: dri-devel@lists.freedesktop.org
> Cc: nouveau@lists.freedesktop.org
> Signed-off-by: Kees Cook <keescook@chromium.org>

Reviewed-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Thanks!
--
Gustavo

> ---
>  drivers/gpu/drm/nouveau/include/nvfw/hs.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/nouveau/include/nvfw/hs.h b/drivers/gpu/drm/nouveau/include/nvfw/hs.h
> index 8c4cd08a7b5f..8b58b668fc0c 100644
> --- a/drivers/gpu/drm/nouveau/include/nvfw/hs.h
> +++ b/drivers/gpu/drm/nouveau/include/nvfw/hs.h
> @@ -52,7 +52,7 @@ struct nvfw_hs_load_header_v2 {
>  	struct {
>  		u32 offset;
>  		u32 size;
> -	} app[0];
> +	} app[];
>  };
>  
>  const struct nvfw_hs_load_header_v2 *nvfw_hs_load_header_v2(struct nvkm_subdev *, const void *);
> -- 
> 2.34.1
> 
