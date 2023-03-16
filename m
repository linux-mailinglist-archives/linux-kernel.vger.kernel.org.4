Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFCFF6BD4BE
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 17:11:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229893AbjCPQLn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 12:11:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229966AbjCPQLk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 12:11:40 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36057CA1E6;
        Thu, 16 Mar 2023 09:11:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id E1DF7CE1DC2;
        Thu, 16 Mar 2023 16:11:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F5FCC433EF;
        Thu, 16 Mar 2023 16:11:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678983094;
        bh=nC6VwuGgll5uSPQd5tpYFf3GFAKQzNdtgYCYHTpYLHg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ba2ft+wB5oW9cQF7bI+om0lBfb30omtA6QOLI8seIHdkmSwYAk3zZzasNrfYGG7U1
         cNg56lfiDCD5j2Ab35KdAACUPJJtIpsinjigC01v/HMcOAiHhXR5ZgRTm6Pi53IlBw
         prlFMCSDwD2/JKtsfGWM7OL+S0lSCO+eGUUvmh9YMBttxms6IFbbvfZs+RKrAPs1nj
         fdPIY46zBtj8JVoKg5r1nJftJVlyq1ZCLPaC6SNaLstAwCLKVB39sfz6EIjUQ/JeJ1
         yggE+GtBhtZ3+k7YJbxSLkp+CQWYlczWo6HaajPxfjEcz9gy6BZvvVjm+NU54YUXep
         gam3RomN4ULJw==
Date:   Thu, 16 Mar 2023 16:11:29 +0000
From:   Lee Jones <lee@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Daniel Thompson <daniel.thompson@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Helge Deller <deller@gmx.de>, dri-devel@lists.freedesktop.org,
        linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] backlight: lp855x: mark OF related data as maybe
 unused
Message-ID: <20230316161129.GQ9667@google.com>
References: <20230311173556.263086-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230311173556.263086-1-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 11 Mar 2023, Krzysztof Kozlowski wrote:

> The driver can be compile tested with !CONFIG_OF making certain data
> unused:
>
>   drivers/video/backlight/lp855x_bl.c:551:34: error: ‘lp855x_dt_ids’ defined but not used [-Werror=unused-const-variable=]
>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  drivers/video/backlight/lp855x_bl.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied, thanks

--
Lee Jones [李琼斯]
