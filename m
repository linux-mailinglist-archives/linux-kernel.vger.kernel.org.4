Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F6F86F0915
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Apr 2023 18:06:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243990AbjD0QGL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Apr 2023 12:06:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243215AbjD0QGI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Apr 2023 12:06:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96A612D72;
        Thu, 27 Apr 2023 09:06:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2FCF463E1E;
        Thu, 27 Apr 2023 16:06:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0D48C433D2;
        Thu, 27 Apr 2023 16:06:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682611566;
        bh=yAGznPCZ1f2WazjLpiWbzBNsj4vdYifi0lN+d8TNCtU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=E/3sEjGTsOwO5uk3d4zMUrh86nUJwkupb7f5EPLaMQVyPJSTGa1y6pdHXr9N/ncdw
         3mMaEmPYOHF0UypoXp6I18DLEk3U91bVOy7mdxCgPNL7gUCKKU5huxVbGPdDUSN0Kt
         pM+T9OWxhF/BhdnUuecjo+P7I53EMin0HlzUcMYSQzNsR/e85cuNE1tckjYeldSeNO
         DbD15RCUQE3w2rlu2KkzdYxJwpvGVPUuudrOxQ5oArtC6tLrHPX1aIDcvJEo0mhSaG
         OrEM0sRh6sIB80F5mji/rWA7k3se54UwIuJAy8NEoDTbwh5hsrBKhxxwuhusLZy2Mr
         vLvTmz14BukJA==
Date:   Thu, 27 Apr 2023 17:05:59 +0100
From:   Lee Jones <lee@kernel.org>
To:     Luca Weiss <luca@z3ntu.xyz>
Cc:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Pavel Machek <pavel@ucw.cz>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Stephen Boyd <sboyd@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-leds@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-doc@vger.kernel.org
Subject: Re: [PATCH v2 8/8] Documentation: leds: Add "rgb:status" path
Message-ID: <20230427160559.GC50521@google.com>
References: <20230414-pmi632-v2-0-98bafa909c36@z3ntu.xyz>
 <20230414-pmi632-v2-8-98bafa909c36@z3ntu.xyz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230414-pmi632-v2-8-98bafa909c36@z3ntu.xyz>
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 18 Apr 2023, Luca Weiss wrote:

> The path /sys/class/leds/rgb:status is already widely used with the
> qcom-lpg driver and others. Document it.

Where is this used?

$ grep status drivers/leds/rgb/leds-qcom-lpg.c
<no results>

> Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
> ---
>  Documentation/leds/well-known-leds.txt | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/leds/well-known-leds.txt b/Documentation/leds/well-known-leds.txt
> index 2160382c86be..439d4dac4472 100644
> --- a/Documentation/leds/well-known-leds.txt
> +++ b/Documentation/leds/well-known-leds.txt
> @@ -58,6 +58,7 @@ LEDs on notebook body, indicating that sound input / output is muted.
>  
>  * System notification
>  
> +Good: "rgb:status"
>  Legacy: "status-led:{red,green,blue}" (Motorola Droid 4)
>  Legacy: "lp5523:{r,g,b}" (Nokia N900)
>  
> 
> -- 
> 2.40.0
> 

-- 
Lee Jones [李琼斯]
