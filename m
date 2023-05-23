Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F6FA70DB72
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 13:28:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235695AbjEWL2b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 07:28:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232119AbjEWL2a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 07:28:30 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0B45FF
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 04:28:26 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id 5b1f17b1804b1-3f6042d60b5so23380585e9.2
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 04:28:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20221208.gappssmtp.com; s=20221208; t=1684841305; x=1687433305;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=de919cKCe4wT4S260hv+KZxN0tV8ssN9pP3EBr3fXco=;
        b=P8jxl9ew7AY7pYFsvzp2552hspigR6Z9lTpMrx/E/rm0e9IVC3n86B9YEwEivObDJL
         pnKZVxH6JW3C7k0XuIoSYxW7ST2AQFmiyT8AK+Cdf4KW1E6Nxh2aOrbPP8VXJjL0icbQ
         tjFstIeHLlMxleXsg5vBL3c/Do6TW7Xi6cH9nTNfKt4Qy8vP3p5bNa3F1lBR0jdICuoY
         jkfK40NRUmzqYK1DBInaQADMSh/vP4OpRURdNPpkdhT0N+vlN5db0iVSZ1qKfw6aOmoM
         Ss8eeVP1m1v0Ax1plx4Yij+URN26nen6sEwae7yzxtDWpFCjmb2uT5EL4pspmsja6FER
         aaFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684841305; x=1687433305;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=de919cKCe4wT4S260hv+KZxN0tV8ssN9pP3EBr3fXco=;
        b=eIc0KhCQMHeoBRNupsy1eolgWVl607adHFQkyFZkW3mayliQa+WqeVwvJktSotWCyx
         8KWubCJJD3jIFAAhhpABdkyR5H5AK7sndPLEZz0LblugR2Epj92jp3AP3zvpM1/T2lU/
         LG7r3pCpp9SChJQS4Pa8d61mJUXYGMfPu9qsivAeAobceUPzgEMYRoOkxMzo/0D7Jewl
         SxLxxIwuRAZVg51iaBA7wIIEuzyIuT7VwJMvlu7vg7COWKXKymLRlmIdrhNnjULYLE2r
         Wzyftohp55kcodAoTvNCRg3LvzAdlSb320MXY1yBDOXuQ2GjYXuNmHSZ5I7JQfNm79lE
         mPmg==
X-Gm-Message-State: AC+VfDxiLFG7BHgIukDYJbqfUtwz10FPb+1FOMth3WdXqghmQpftq0sE
        e7YVPlO2yV9gMNhpmtgd20Gzpg==
X-Google-Smtp-Source: ACHHUZ6ZUa+nR/kj5kFbDcpE0lUe0Vuodny5XRTkBlniwziBN4L/FCtuVVfY4htvApP+nKiAfJ0p4Q==
X-Received: by 2002:a05:600c:ac5:b0:3f6:44e:9d8 with SMTP id c5-20020a05600c0ac500b003f6044e09d8mr4801602wmr.22.1684841305153;
        Tue, 23 May 2023 04:28:25 -0700 (PDT)
Received: from [192.168.1.172] (158.22.5.93.rev.sfr.net. [93.5.22.158])
        by smtp.gmail.com with ESMTPSA id p19-20020a05600c205300b003f60101074dsm9380658wmg.33.2023.05.23.04.28.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 May 2023 04:28:24 -0700 (PDT)
Message-ID: <b0a1d728-6ef5-9cca-4cb9-18e35df61748@baylibre.com>
Date:   Tue, 23 May 2023 13:28:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v5 4/4] clocksource/drivers/timer-mediatek: Make
 timer-mediatek become loadable module
Content-Language: en-US
To:     walter.chang@mediatek.com,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        "Maciej W . Rozycki" <macro@orcam.me.uk>,
        John Stultz <jstultz@google.com>
Cc:     wsd_upstream@mediatek.com, stanley.chu@mediatek.com,
        Chun-hung.Wu@mediatek.com, Freddy.Hsin@mediatek.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
References: <20230517022557.24388-1-walter.chang@mediatek.com>
 <20230517022557.24388-5-walter.chang@mediatek.com>
From:   Alexandre Mergnat <amergnat@baylibre.com>
In-Reply-To: <20230517022557.24388-5-walter.chang@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/05/2023 04:25, walter.chang@mediatek.com wrote:
> Make the timer-mediatek driver which can register
> an always-on timer as tick_broadcast_device on
> MediaTek SoCs become loadable module in GKI.

Reviewed-by: Alexandre Mergnat <amergnat@baylibre.com>


