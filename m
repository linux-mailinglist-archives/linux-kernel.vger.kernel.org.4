Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A183874B2D9
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jul 2023 16:12:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233022AbjGGOMK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jul 2023 10:12:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232838AbjGGOMF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jul 2023 10:12:05 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E5F82123
        for <linux-kernel@vger.kernel.org>; Fri,  7 Jul 2023 07:12:01 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id 5b1f17b1804b1-3fbc0981755so21327205e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jul 2023 07:12:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20221208.gappssmtp.com; s=20221208; t=1688739120; x=1691331120;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ycpGNLsgt/ES0G1zwIWkJIdAtFjomLDl2xkjlXWSTo4=;
        b=DVbjMVlxHE9pu3YlBytLFnpsxwPBMrs4rpCRfT0334ztrG4dfj5UIdU8xKhSyHlI9y
         dGLp86nBHpb1Wu+ID9UCtE6PciybqIGVT99TKQf3pGyXZk5VATe4xCQLgdm8jDwy0J4t
         aw4jAa8+T0nz9r55f4c6Evev2l5Gqc6l5K0eSgnO3ZeyyNdDyYHbDCh7SnwkUciF2r0L
         eXqCFb4R0FaCMGVkNY6mryVPdOytgJr4TglhKevcsFBxYZJJLojSXS2c8UtF6mjIpuh9
         p22MJ0bzcWpPT1A5c6tcjU7D7C5B63Z/0/R/xV6iet0dSYSSVVFX1IOId8dTN6lYtbb3
         thUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688739120; x=1691331120;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ycpGNLsgt/ES0G1zwIWkJIdAtFjomLDl2xkjlXWSTo4=;
        b=jW0PIZNNea5/hwsHIIxXHIJC/PjDcyDSmrtsUHwr4knxad+AxxQrCEOyYMHL85FCCT
         sGtKJ0920pyjwkTPje8c2Mz0cYJbc6j3HoJd8WNJI4YmLcIlwfoO9gqaZoQgYKiZ8MTD
         S7q32dGikD4g1vzHYxyPNGEzebGwDV/pjJe5bZdAg7Cn941uCAdJQhM/aIKqtL5ebS5S
         H5ohG7+Z/R1QJPjjraIjN1YRQdqEyqho8uKJiEGdocinxpeJvqN7RNS9awRp/7JI3Ojy
         Am+sdHFEUKCKGqCgzP/Hn2mWrV5GDR3zyihRBaUWQAsbzdbOFzz4i29Lg8yHKI8w89Zu
         8HnA==
X-Gm-Message-State: ABy/qLbXtoCXF3IyQxwl2KyU4f9mUJ1mdhQDdRv3Jy7ywYmUUss95V+m
        NnVW1EPmVYBYIhO0uKo7lJ5jAw==
X-Google-Smtp-Source: APBJJlFfVX3E+RmKYUQNq3SgciMbgNUkXY9Sjj/5oyQe0BzJbpLNP6WT1j91P4EKn7/5h62zHXUB0g==
X-Received: by 2002:a1c:4b0a:0:b0:3fb:d1db:545b with SMTP id y10-20020a1c4b0a000000b003fbd1db545bmr4005976wma.20.1688739120033;
        Fri, 07 Jul 2023 07:12:00 -0700 (PDT)
Received: from [192.168.1.172] ([93.5.22.158])
        by smtp.gmail.com with ESMTPSA id l22-20020a7bc456000000b003fbb5142c4bsm2579548wmi.18.2023.07.07.07.11.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Jul 2023 07:11:59 -0700 (PDT)
Message-ID: <6fb74321-2f85-1a08-e16e-97346bd7e82a@baylibre.com>
Date:   Fri, 7 Jul 2023 16:11:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v3 6/6] thermal/drivers/mediatek/lvts_thermal: Manage
 threshold between sensors
Content-Language: en-US
To:     =?UTF-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?= 
        <nfraprado@collabora.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     Alexandre Bailon <abailon@baylibre.com>,
        Balsam CHIHI <bchihi@baylibre.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Chen-Yu Tsai <wenst@chromium.org>, kernel@collabora.com,
        Amit Kucheria <amitk@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org, linux-pm@vger.kernel.org
References: <20230706153823.201943-1-nfraprado@collabora.com>
 <20230706153823.201943-7-nfraprado@collabora.com>
From:   Alexandre Mergnat <amergnat@baylibre.com>
In-Reply-To: <20230706153823.201943-7-nfraprado@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 06/07/2023 17:37, Nícolas F. R. A. Prado wrote:
> Each LVTS thermal controller can have up to four sensors, each capable
> of triggering its own interrupt when its measured temperature crosses
> the configured threshold. The threshold for each sensor is handled
> separately by the thermal framework, since each one is registered with
> its own thermal zone and trips. However, the temperature thresholds are
> configured on the controller, and therefore are shared between all
> sensors on that controller.
> 
> When the temperature measured by the sensors is different enough to
> cause the thermal framework to configure different thresholds for each
> one, interrupts start triggering on sensors outside the last threshold
> configured.
> 
> To address the issue, track the thresholds required by each sensor and
> only actually set the highest one in the hardware, and disable
> interrupts for all sensors outside the current configured range.

Reviewed-by: Alexandre Mergnat <amergnat@baylibre.com>

-- 
Regards,
Alexandre
