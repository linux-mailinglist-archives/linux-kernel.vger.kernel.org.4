Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E5506C77DE
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 07:29:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231168AbjCXG3u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Mar 2023 02:29:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbjCXG3s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Mar 2023 02:29:48 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4732C17CC2;
        Thu, 23 Mar 2023 23:29:47 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id s20so653999ljp.1;
        Thu, 23 Mar 2023 23:29:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679639385;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hH9ReKrWmbRFTyiuvOPNN8/j0VR2qXnASEVkCT8MBz0=;
        b=FpNALg9qwHuQnFF6J29CLFRlezY4BIbry7EjaUkYzplmC8BhbUcPPDiElZUd78UfvW
         SSj4DEN+WoFvgVBtuCj7hYjUwPDPWsQmB+vf078/gDH4EbwFnltToix8gJZiPx7xzSGE
         feS2WjyQhoSZhlpvwO8wjL4sH7ZafMjMWuWNPr+VRjaaSY9QweUZ4PE66TdLJVY/3dlJ
         EYJC/w/4vyNLzQ9NRI2T0E+yozSUf237ByL/7nrlQBiQ/qKey0VJiMwBUl6NLSDwIR6k
         KK5xOb2hPsBK4iuRhrHxxTArtdc7TR3BV1MXjHs4b8hlK6tcx6z6JTbIQVFzrOFPFDH2
         7Lvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679639385;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hH9ReKrWmbRFTyiuvOPNN8/j0VR2qXnASEVkCT8MBz0=;
        b=bfKXUs8GypJHZaSJVqrxyObIr7EM4XN18iXOgxKgPtG8Shq4FfCB/+2kBSbXAdVeRo
         8mnguAxSvRSkw16BHNgpp0og7P0a44v3FerA+CuKf6wUVLchRj5PyAsW0poQTIv9dBy3
         h5RWBiGgDzyQGVn8bLzsxhoigZAdcLS5wvxfNqpUMb5pDs6JtUnkLrxcUCuIzdTkegNT
         Y9EpeQw50cC4/74Y916nPbk9aoz0a88rayNouhGqV5BHf5c8cj+XHzguugvtyvSwqgPg
         FhYOSm6Ea/aWqokNPoEbjADDP7WTUwwQeKjSe0GCUOXc2zbusB5pzy9nJ5x6f6AEYyrv
         Gnzw==
X-Gm-Message-State: AAQBX9fxwgBFEE0BWl1q8cWtlw9S0Udle6kVlfGtZ3ax5LM5r95a1XSg
        N2u3c581BG4ZwiTpIaV5dIg=
X-Google-Smtp-Source: AKy350ZWAJCQpjhChzSTDGzoPlTu365tVPg0gFLRN3+twcy68mzHkASezWya/EdsbyggYqZnDFA7xQ==
X-Received: by 2002:a2e:904b:0:b0:299:ac61:dedd with SMTP id n11-20020a2e904b000000b00299ac61deddmr609653ljg.40.1679639385190;
        Thu, 23 Mar 2023 23:29:45 -0700 (PDT)
Received: from ?IPV6:2001:14ba:16f3:4a00::1? (dc75zzyyyyyyyyyyyyyyt-3.rev.dnainternet.fi. [2001:14ba:16f3:4a00::1])
        by smtp.gmail.com with ESMTPSA id b8-20020a2e9888000000b00295a583a20bsm3256731ljj.74.2023.03.23.23.29.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Mar 2023 23:29:44 -0700 (PDT)
Message-ID: <21a888a1-95e3-cdf9-2a1d-1bb8b3d27a16@gmail.com>
Date:   Fri, 24 Mar 2023 08:29:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Content-Language: en-US, en-GB
To:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Liam Beguin <liambeguin@gmail.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        Stephen Boyd <sboyd@kernel.org>,
        Maxime Ripard <maxime@cerno.tech>
References: <cover.1679474247.git.mazziesaccount@gmail.com>
 <3f33fc551c0698b4cddb0d39911dddf7599c6317.1679474247.git.mazziesaccount@gmail.com>
From:   Matti Vaittinen <mazziesaccount@gmail.com>
Subject: Re: [PATCH v5 5/8] iio: test: test gain-time-scale helpers
In-Reply-To: <3f33fc551c0698b4cddb0d39911dddf7599c6317.1679474247.git.mazziesaccount@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/22/23 11:07, Matti Vaittinen wrote:
> Some light sensors can adjust both the HW-gain and integration time.
> There are cases where adjusting the integration time has similar impact
> to the scale of the reported values as gain setting has.
> 
> IIO users do typically expect to handle scale by a single writable 'scale'
> entry. Driver should then adjust the gain/time accordingly.
> 
> It however is difficult for a driver to know whether it should change
> gain or integration time to meet the requested scale. Usually it is
> preferred to have longer integration time which usually improves
> accuracy, but there may be use-cases where long measurement times can be
> an issue. Thus it can be preferable to allow also changing the
> integration time - but mitigate the scale impact by also changing the gain
> underneath. Eg, if integration time change doubles the measured values,
> the driver can reduce the HW-gain to half.
> 
> The theory of the computations of gain-time-scale is simple. However,
> some people (undersigned) got that implemented wrong for more than once.
> Hence some gain-time-scale helpers were introduced.
> 
> Add some simple tests to verify the most hairy functions.
> 
> Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
> 
> ---
> Changes:
> v4 => v5:
> - remove empty lines from Kconfig
> - adapt to drop of the non devm iio_init

I think you may want to skip reviewing this specific patch. After having 
a chat with Greg, David, and Maxime it seems this will be changed quite 
a bit for v6.

Most notably, I am planning to drop the generic helpers and struct 
gts_test. I'll also simplify the signatures of 
__test_init_iio_gain_scale() and test_init_iio_gain_scale().

Yours,
	-- Matti

-- 
Matti Vaittinen
Linux kernel developer at ROHM Semiconductors
Oulu Finland

~~ When things go utterly wrong vim users can always type :help! ~~

