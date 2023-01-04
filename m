Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7323765CB1E
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Jan 2023 01:52:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238555AbjADAwG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 19:52:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229685AbjADAwE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 19:52:04 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC7B317070;
        Tue,  3 Jan 2023 16:52:02 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4A15F61358;
        Wed,  4 Jan 2023 00:52:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 543E7C433EF;
        Wed,  4 Jan 2023 00:52:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672793521;
        bh=MSAiWrHIQ+/AHtGbShhE/8haLs6lILykSFR/Hd4m/9o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=AriK+kvbz8GZQ4TcnVFBgAWpSAgBQmAvPupI+tCSCTEMwM33Ml+Am/SDFzb+uaDcH
         5igUHcyuOY30ol0nEHLX2wYwIrX1Z3QPySUUduR80ienEtcHJtzJv+0F3JkzcvhFOC
         vElmJXQEdpiTyqozccVMidgDTb1j2sx+Tmwlf7XoB3Sb91foCzAmcwBjGwSFr2Gk0o
         OsVteNud+8WK23B8kwKP5tO6T9GpRKgpfmb4At6WwFwkCRvsRZR5wepOAZKOwBOaTu
         TMrwCJARp673OHtur1NshpirndBKyToWy2NaPKcV5RIGWQ2xUiVwFbKHRLT2OBfoY+
         DNQh8014wnr+g==
Date:   Tue, 3 Jan 2023 18:52:05 -0600
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     Ben Skeggs <bskeggs@redhat.com>, Karol Herbst <kherbst@redhat.com>,
        Lyude Paul <lyude@redhat.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Gourav Samaiya <gsamaiya@nvidia.com>,
        dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [RESEND][PATCH] drm/nouveau/fb/ga102: Replace zero-length array
 of trailing structs with flex-array
Message-ID: <Y7TNtQqunHIW8her@work>
References: <20230103234835.never.378-kees@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230103234835.never.378-kees@kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 03, 2023 at 03:48:36PM -0800, Kees Cook wrote:
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

Here is my RB again:

Reviewed-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Thanks!
--
Gustavo

> ---
> Sent before as: https://lore.kernel.org/all/20221118211207.never.039-kees@kernel.org/
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
