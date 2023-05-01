Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0108E6F32D6
	for <lists+linux-kernel@lfdr.de>; Mon,  1 May 2023 17:26:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232810AbjEAP0Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 May 2023 11:26:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232584AbjEAP0R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 May 2023 11:26:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40CB7173F;
        Mon,  1 May 2023 08:26:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CA42560FD3;
        Mon,  1 May 2023 15:26:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10C41C433EF;
        Mon,  1 May 2023 15:26:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682954772;
        bh=5qeRpZp3lKr2TwyZog4Y5gLVDvkqlF9uZ3wIvrhrHeQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=B0jMvsb/PoHj2wz9OVdMS7NQresP5elPUAFuyZSRAuNgXi38VXBZgMdNz1YFqlM8l
         gy9GrD1c1BXaEr0s32SoblOkIdOCbKrOkJRayIozIvRB7mTrhU0PbmgMGss62pqxPr
         ftA1+sjofF0SWg2jrHXIv0MVx2AzcLkKUdBEXrazqPeKopnaiGLaXK+u0r+AqR3KJN
         uDy3VyvLTADg8+imcBIoOGgytFFYA8TNdXuNfkkJEXOwtMrWCMfr0Km5QJi7MHgN/J
         4De9erxc/Jt4VkWNzmyFn469aGT74EhWR3RBWrh4s0KGyQzAASsmt8PInI/43cKR92
         pKzIVWsi81Kpg==
Date:   Mon, 1 May 2023 16:41:57 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Matti Vaittinen <mazziesaccount@gmail.com>
Cc:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: fix doc for iio_gts_find_sel_by_int_time
Message-ID: <20230501164157.43ed033e@jic23-huawei>
In-Reply-To: <ZEIjI4YUzqPZk/9X@fedora>
References: <ZEIjI4YUzqPZk/9X@fedora>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.37; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 21 Apr 2023 08:46:11 +0300
Matti Vaittinen <mazziesaccount@gmail.com> wrote:

> The kerneldoc for iio_gts_find_sel_by_int_time() has an error.
> Documentation states that function is searching a selector for a HW-gain
> while it is searching a selector for an integration time.
> 
> Fix the documentation by saying the function is looking for a selector
> for an integration time.
> 
> Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
Given this is a very recent introduction and I don't like incorrect docs
sneaking in, I've applied this to the fixes-togreg branch of iio.git
(which just got rebased on char-misc-linus which now includes this code).

Thanks,

Jonathan

> ---
>  include/linux/iio/iio-gts-helper.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/linux/iio/iio-gts-helper.h b/include/linux/iio/iio-gts-helper.h
> index dd64e544a3da..9cb6c80dea71 100644
> --- a/include/linux/iio/iio-gts-helper.h
> +++ b/include/linux/iio/iio-gts-helper.h
> @@ -135,7 +135,7 @@ static inline int iio_gts_find_int_time_by_sel(struct iio_gts *gts, int sel)
>  /**
>   * iio_gts_find_sel_by_int_time - find selector matching integration time
>   * @gts:	Gain time scale descriptor
> - * @gain:	HW-gain for which matching selector is searched for
> + * @time:	Integration time for which matching selector is searched for
>   *
>   * Return:	a selector matching given integration time or -EINVAL if
>   *		selector was not found.
> 
> base-commit: 52cc189b4fc6af6accc45fe7b7053d76d8724059

