Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B43FD5F2F8B
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Oct 2022 13:24:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229782AbiJCLY0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Oct 2022 07:24:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbiJCLYX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Oct 2022 07:24:23 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF76B4A80A
        for <linux-kernel@vger.kernel.org>; Mon,  3 Oct 2022 04:24:22 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id a12so1395557ljr.7
        for <linux-kernel@vger.kernel.org>; Mon, 03 Oct 2022 04:24:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=WF1YkiRGRhpnhgG0MdjR1Rgf44GJQe4txZ7kZbtuE7U=;
        b=ATQv3IsamPVbotj8GgPwBLFZgwn4aA6SJFqTvn/tMbIvYPxlghtHW3uvGlQh1HV6op
         PgJSGMYBtGQiO4xbottomfzlzQ5OAlsGVN/g0L5prp9VEVQIPUiRQDgV2MVhGcgPE+o+
         g7K3nDLpKsS8+lmbuPTMYb6Op87omIjdQwIohXFDqYXA6Lo80q26c/Wm9ca48Gmoi7Hn
         /XjXR+NcyJ4p+rSQ8+BQdttsPP/Bpt7dIL6oe50HjR8tcVzHrHadwbYEahE4r5YdR/aa
         RMCS5qivj4I5MpGD535czlMQADuZCzzPLkw81i4PcQ2zbw6HhoW08WXqwd37XbbeVHH7
         y07w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=WF1YkiRGRhpnhgG0MdjR1Rgf44GJQe4txZ7kZbtuE7U=;
        b=F9KC9fV/qEPbeg7LqLsIpTtii31XDeuGWQrNzCUXnO88sWUt9MIOV2GiawEGKLU6CC
         OtGXFx/GxSaqY/7f2VVNQYbt7+dgRbqlAjDaTP5GyDjbfuUQ+etaEGglWGq/1X0l/x2H
         wkuvU3G2HyJHi6SoX5XI11wmSfgF54Sq4JP/2vU3pgcChlYILZOpLYhAa7URZ/FMg5GY
         ho6xDQ//A0HbKYzpfvyDrkpfrSmS3mdjZBmdGLZlnlHw/soBucWb9aiRDeYK+n8gjjLf
         TCDN0HLotwQUvxPnVLZbFgSz3BJi/eeF6BOaPPtSBlkmrU9B6AH24qCFsVrT+3gHebH0
         Xomg==
X-Gm-Message-State: ACrzQf3m0vjTUQtCynwW8WUJjZIbag/WGlpzZmjTL3Yyn1GUrsjmcnt7
        Gp+yNb25GGVLXICN2y8r0OXhKBTba9+ppg==
X-Google-Smtp-Source: AMsMyM7vPpmc4h455++S9oOL04kXh/D9Rg5XKZfQQxiHBzr+waGoEtDC65ZJ/Y+UXEH8tKm9Qljk2Q==
X-Received: by 2002:a05:651c:983:b0:26c:1c6b:8473 with SMTP id b3-20020a05651c098300b0026c1c6b8473mr5975005ljq.341.1664796261157;
        Mon, 03 Oct 2022 04:24:21 -0700 (PDT)
Received: from [192.168.0.21] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id a9-20020a05651c010900b0026c44771d02sm176616ljb.11.2022.10.03.04.24.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Oct 2022 04:24:20 -0700 (PDT)
Message-ID: <30ecd769-7820-0e0c-20a0-efa7c88e8923@linaro.org>
Date:   Mon, 3 Oct 2022 13:24:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [GIT PULL] memory: late (3rd) for v6.1
Content-Language: en-US
To:     Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>,
        arm@kernel.org, soc@kernel.org
Cc:     linux-kernel@vger.kernel.org, Krzysztof Kozlowski <krzk@kernel.org>
References: <20221003073237.11488-1-krzysztof.kozlowski@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221003073237.11488-1-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/10/2022 09:32, Krzysztof Kozlowski wrote:
> Hi,
> 
> Late pull for v6.1 with minor stuff - cleanups and bindings fix.

I just noticed that v6.0 was released, so this pull is a bit too late.
It's nothing urgent, so feel free to ignore and I will re-submit it for
v6.2.

Best regards,
Krzysztof

