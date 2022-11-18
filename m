Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C57B62F2B1
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 11:36:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240846AbiKRKge (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 05:36:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234724AbiKRKgb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 05:36:31 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62EF992B6F;
        Fri, 18 Nov 2022 02:36:30 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id r126-20020a1c4484000000b003cffd336e24so2518236wma.4;
        Fri, 18 Nov 2022 02:36:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=o2gq3WkhxO5jelfwCv/WS0BWOBOHKufpRkH4v9U9Wao=;
        b=d4PKh8zw6k/K/IW7TceQGwknGbrYWtGWKCioj737b7AqjDamyVEgbP8oStwlBRCsgr
         2r+/vH1UGVJOQi3gaRMn2/XRtbLw90ezM4z5Ya2pPGHfUfTa3oyxFx9a+7DOoqP0b2IL
         Kf5PO5zgnl/Rxe8HXYNlDFTV1qDvsgryqooTi2Xg1eCd+lL7Vm+m3IFbeDrbmrvPFrR4
         1z2QirjNW8QjJ5uhQD1nVJ6F8m4i1ujFlklWkQRMdwxsyqoTzhnrwxCIgN9RanPK0Zy3
         eYOPIE73fiy1sLxHGUNDjbLWFPhV55RCsjfoJGT3y+8U0p71f425cbNfu5I1QBh41G/X
         sc6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=o2gq3WkhxO5jelfwCv/WS0BWOBOHKufpRkH4v9U9Wao=;
        b=2igmWQCfVmn8yxtSfBPis2WC1VULT4PkrYT5wBo1m9TdQhpGMzOE5glia4TJNu1qb+
         5GY1vJ+upSnY1AXP/ADk5QKu72K9NU7xHhHS4Sbo0J90gYD99C+QnRTgd4eD2F+MBxoq
         x3Txbnb9xm9kgosR8pI6/t1xKFX+l0Y7ecKSeDF4E6/JTqTQzETFBzA/9Wf0hzKS/2n2
         QrJi3Zed7VJaf6rdd5rMYwRJYexdKxRk6F3YUjLnJLST3r0sLkdGJTKITLY63YIQ3tCa
         kJygGrMMcaVF7QvglmK0U7zMaWvTnSGZe8jD8pdxvP+A0Yn6AhFXRSll7Jn9LzcKkqFk
         Rr+g==
X-Gm-Message-State: ANoB5pmDbVfKq4OD74xLFbdhIT8gK1igSjhhoyF+iN7sRSuCOCnlkVYq
        bZJOBhGS6NQaDPPnh4uhTHs=
X-Google-Smtp-Source: AA0mqf7o5IRd2H8nnmtyx5JfUpkr4cMqOd/06z+Ilwq8xBCC6RfYEnOjn0eWatL/t/qAOLXQQG9O4Q==
X-Received: by 2002:a05:600c:4d0a:b0:3c6:a7a1:eebd with SMTP id u10-20020a05600c4d0a00b003c6a7a1eebdmr4357430wmp.176.1668767788532;
        Fri, 18 Nov 2022 02:36:28 -0800 (PST)
Received: from ?IPV6:2a0e:41a:894f:0:c794:607e:a911:a21e? ([2a0e:41a:894f:0:c794:607e:a911:a21e])
        by smtp.gmail.com with ESMTPSA id f28-20020a5d58fc000000b0022e36c1113fsm3230241wrd.13.2022.11.18.02.36.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Nov 2022 02:36:28 -0800 (PST)
Sender: Carlo Caione <carlo.caione@gmail.com>
From:   Carlo Caione <carlo@caione.org>
X-Google-Original-From: Carlo Caione <ccaione@baylibre.com>
Message-ID: <e36142ec-6b7f-e667-7d6b-48234318c8cd@baylibre.com>
Date:   Fri, 18 Nov 2022 11:36:27 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH 2/3] drm/tiny: ili9486: Do not assume 8-bit only SPI
 controllers
Content-Language: en-US
To:     Mark Brown <broonie@kernel.org>
Cc:     Kamlesh Gurudasani <kamlesh.gurudasani@gmail.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Jerome Brunet <jbrunet@baylibre.com>,
        David Airlie <airlied@gmail.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org, dri-devel@lists.freedesktop.org
References: <20221116-s905x_spi_ili9486-v1-0-630401cb62d5@baylibre.com>
 <20221116-s905x_spi_ili9486-v1-2-630401cb62d5@baylibre.com>
 <Y3YWdeTLfmDh7UyB@sirena.org.uk>
 <cd2d4d1e-f42a-da5b-e498-fbb32f792094@baylibre.com>
 <Y3ZMT4F3+3bjNXKo@sirena.org.uk>
In-Reply-To: <Y3ZMT4F3+3bjNXKo@sirena.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/11/2022 15:59, Mark Brown wrote:

> So this is an issue in the MIPI DBI code where the interpretation of 
> the buffer passed in depends on both the a caller parameter and the 
> capabilities of the underlying SPI controller, meaning that a driver 
> can suddenly become buggy when used with a new controller?

The MIPI DBI code is fine, in fact it is doing the correct thing in the
mipi_dbi_typec3_command() function. The problem is that the ILI9486
driver is hijacking that function installing its own hook that is wrong.

> I can't really tell what the bits per word being passed in along
> with the buffer is supposed to mean, I'd have expected it to
> correspond to the format of the buffer but it seems like perhaps the
> buffer is always formatted for 16 bits and the callers are needing to
> pass in the capabilities of the controller which is then also checked
> by the underlying code? This all seems extremely confusing, I'm not 
> surprised there's bugs.

Correct, the buffer (pixel data) is always formatted for 16 bits and the
bpw is to indicate how this data should be put on the bus (according to
the controller capability).

If the controller is only capable of 8-bit transfers, the 16-bit data
needs to be swapped to account for the big endian bus, while this is not
needed if the controller already supports 16-bit transfers.

The decision to swap the data or not is taken in the MIPI DBI code by
probing the controller capabilities, so if the controller only supports
8-bit the data is swapped, otherwise it is not.

The problem arrives when your controller does support 16-bits, so your
data is not swapped, but you still put the data on the bus with 8-bit
transfers.

> At the very least your changelog needs to express clearly what is 
> going on, the description doesn't appear to correspond to what
> you're changing.

Gotcha, I'll try to clarify that in the next revision.

Thanks,

--
Carlo Caione
