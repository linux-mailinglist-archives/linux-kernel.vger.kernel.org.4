Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E65E74B2AF
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jul 2023 16:07:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232990AbjGGOHK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jul 2023 10:07:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233000AbjGGOGw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jul 2023 10:06:52 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 908C32D62
        for <linux-kernel@vger.kernel.org>; Fri,  7 Jul 2023 07:06:25 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id ffacd0b85a97d-313fb7f0f80so1985808f8f.2
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jul 2023 07:06:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20221208.gappssmtp.com; s=20221208; t=1688738760; x=1691330760;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ypN5vITkkhGfPkJuwEgCilvTnXaVJG+QXbGwWF3FDlA=;
        b=U8gTuONmR0RGUohWTlcfQ9UAZEkZtIioCQKg4mgY0r/MJ/TM+Zpill9AVXG4dL+n1J
         75f8QB231z1Fd0ceajdas6iwgBBsoo74bl11HgBPwzbZZl7J5SBqmNGvUJ+KY4i/tVpc
         PJMGs+aWolF1d+2lmRul8XsaV1oIefZNmBndfcDd9IgbEc15nODg/tE1iBH/VeMcpr1Z
         BHNKem+bIBCi34voVW5WDXlUyu5XKHYsOL7tr0SsqpqT0j1caJDD0v1r5AJ9NlsUXcp8
         tPx796BR+LndDrv2zLi2l+eu7RYcsyjyS29slTh59y7tA030Ofl1tqvV5FSxZCB1/szd
         iRQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688738760; x=1691330760;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ypN5vITkkhGfPkJuwEgCilvTnXaVJG+QXbGwWF3FDlA=;
        b=HZvpACi5mU/o7CQ31GnJSnhnkX35H2sxf39gk4H/hHcJ4TB92WT89jqG7Ot2T0Mxwl
         wjAYNWXEsFd4rPZSqjcaQy5NUe39nB8YpXZknDiMKr0AIbPXyVvGwyXmzQPN4cWKsLoj
         6CRZcMZm00YkT1RgMgKxL1KDVqSlLAeRFMNBRXbxi8uWgwvFBPx2NhaZYXBYLz6rFT2/
         IbnWZFGmdM0+aOhLOy6Mszu0kZNsQ4ZFLaq9ECHZNR82/jCt07kd/JPL4wC4sObBHeCC
         Uj+ldOLQE1MYTghk4NguKEGU+mpvlflSP6FxKLCAsWpRc5OtHv2KOpEsWY+7xc61AoIb
         EcMw==
X-Gm-Message-State: ABy/qLby5A+ppIyWzEgxQ7mTXzR/K7Mp2yYjOFAU9SJc4m0lfDO9YTHy
        X+unBEi2b0934nAmNEYZNrWp3w==
X-Google-Smtp-Source: APBJJlE4nXzGIyRM7DxqinqjrJdnm+zgxihOIhoG+vQl/r1Bz95EDhhnhhzYxyE7FPttJhhJ/yJ+1A==
X-Received: by 2002:a5d:6045:0:b0:314:35ba:d02a with SMTP id j5-20020a5d6045000000b0031435bad02amr4720202wrt.13.1688738759840;
        Fri, 07 Jul 2023 07:05:59 -0700 (PDT)
Received: from [192.168.1.172] ([93.5.22.158])
        by smtp.gmail.com with ESMTPSA id q24-20020a056000137800b00314172ba213sm4525758wrz.108.2023.07.07.07.05.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Jul 2023 07:05:58 -0700 (PDT)
Message-ID: <8557e0a2-6ab8-f056-6796-770b3675b474@baylibre.com>
Date:   Fri, 7 Jul 2023 16:05:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v3 5/6] thermal/drivers/mediatek/lvts_thermal: Don't leave
 threshold zeroed
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
 <20230706153823.201943-6-nfraprado@collabora.com>
From:   Alexandre Mergnat <amergnat@baylibre.com>
In-Reply-To: <20230706153823.201943-6-nfraprado@collabora.com>
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
> The thermal framework might leave the low threshold unset if there
> aren't any lower trip points. This leaves the register zeroed, which
> translates to a very high temperature for the low threshold. The
> interrupt for this threshold is then immediately triggered, and the
> state machine gets stuck, preventing any other temperature monitoring
> interrupts to ever trigger.
> 
> (The same happens by not setting the Cold or Hot to Normal thresholds
> when using those)
> 
> Set the unused threshold to a valid low value. This value was chosen so
> that for any valid golden temperature read from the efuse, when the
> value is converted to raw and back again to milliCelsius, the result
> doesn't underflow.

Reviewed-by: Alexandre Mergnat <amergnat@baylibre.com>

-- 
Regards,
Alexandre
