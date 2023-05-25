Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA3AD710AF4
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 13:31:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240931AbjEYLbq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 07:31:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233558AbjEYLbo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 07:31:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D38FE4A;
        Thu, 25 May 2023 04:31:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D71FC64501;
        Thu, 25 May 2023 11:31:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3EFEC433EF;
        Thu, 25 May 2023 11:31:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685014292;
        bh=4Dz9zMJVhxwMMiquc88J5UTjI72zXQLwzeT/4mr38VY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=biPs19dkMBRvz+eupbEagngMdLtHrzltjYKo7RPIOy+428C5+o8aWHIrAHSDFUIY5
         csL6OR2vN6Bj/MGkBrJEyBaF9cAzhcq13JkH5cO4KJpi/cZc4lENp9VK6+w52SX33D
         tXvX+iuxLSJc3j3W4XjBjd9dvtL2de2DK8Ztew973b1KvTtfkN+t7+iVfqpwy53FL7
         kCGhYnca9c9/vgDGqmTBbYoHWXrUqfYDf+TVJuS8s+rVGzd6bDSwFMPVE88cjwjJBP
         VS3xUSmR8E4g+rw5ThyJBjzRxLCjQ7GN27hx6AwYK+vKVxDn/Iqj5qvvp9D5Q6Yx/2
         r3mnkiDCsvJcw==
Date:   Thu, 25 May 2023 12:31:27 +0100
From:   Lee Jones <lee@kernel.org>
To:     Azeem Shaikh <azeemshaikh38@gmail.com>
Cc:     Jan-Simon Moeller <jansimon.moeller@gmx.de>,
        linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org,
        Pavel Machek <pavel@ucw.cz>, linux-leds@vger.kernel.org
Subject: Re: [PATCH] leds: blinkm: Replace all non-returning strlcpy with
 strscpy
Message-ID: <20230525113127.GD423913@google.com>
References: <20230523021228.2406112-1-azeemshaikh38@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230523021228.2406112-1-azeemshaikh38@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 23 May 2023, Azeem Shaikh wrote:

> strlcpy() reads the entire source buffer first.
> This read may exceed the destination size limit.
> This is both inefficient and can lead to linear read
> overflows if a source string is not NUL-terminated [1].
> In an effort to remove strlcpy() completely [2], replace
> strlcpy() here with strscpy().
> No return values were used, so direct replacement is safe.
> 
> [1] https://www.kernel.org/doc/html/latest/process/deprecated.html#strlcpy
> [2] https://github.com/KSPP/linux/issues/89
> 
> Signed-off-by: Azeem Shaikh <azeemshaikh38@gmail.com>
> ---
>  drivers/leds/leds-blinkm.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied, thanks

-- 
Lee Jones [李琼斯]
