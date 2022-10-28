Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D53A5611E29
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Oct 2022 01:33:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229824AbiJ1Xc7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 19:32:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbiJ1Xc5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 19:32:57 -0400
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 511D518A51C
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 16:32:53 -0700 (PDT)
Received: by mail-qk1-x735.google.com with SMTP id f8so4482104qkg.3
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 16:32:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=p/JONS14sR6Y7vp4o4d79QghiC8/pLCjQntTzO9qLD0=;
        b=GgYzrGqLc2vdB88vqTDV5Q4ta5r4Cxy0BnuVGeKRgN8NFFSFROCj+eKu7RDJlKzRE/
         lPtu1y2NE35wd2lyrDPBa5TgyTIIqI8qyOLNMj0F7hT4oDmm16+k6L8bzQ3fUwVtYvXV
         X1RtA1ltGex/O1PP9/X3ffzTKkseCtK1horJXfCAC18XT38N8c1qLpJPdcAPi0+35daG
         GvBeBWbFVTL0mTaPiPOJISCkL+shzSyGSeBuScJkOOXafJcC1KJnKEQegfs8pLzb6Ty1
         MGlGmQetK9a/z4v/a7pQ13DOqCTg2RVf3s5CEm+R/x+2oBbO5LNRynEbJUGlSfvkVCoU
         azIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=p/JONS14sR6Y7vp4o4d79QghiC8/pLCjQntTzO9qLD0=;
        b=rwtuEnwBMVCGi/UxknMIC5BPaEJ52voasw3ic6fKgQ8FkXIeJrubt3lz3uPBTZ1DpV
         SG5x2GLbDnCpxL83sqMIIlP3y+55F02KdRY/4NiYecxqi0ajBUb2ZWgMML61Ww4gxuXl
         DpmVg79BOQ1KPQWGjtw77LuKEhEnhA/0wpC//MR6MGZ7e1scURaAxRgLuS6wxMlpoPwb
         RvzSmedTkRcXWfGsJ/2ntQdrf39zPsMf3xiv9+UdU61XHergzprS36Q3AgNTPPIJ9yWd
         ipmyFlGtOyprAQBB7nNOv7sMwc8Tp8V0B/i9ME264I8flK2c6zF9NJlYZNb8KuJv9T/B
         C8CA==
X-Gm-Message-State: ACrzQf36Y7HM0yj/0GVHDMvEgxjmilm/79YVJTxzDJcFOfc+r5ueVSZW
        WFlW2NLiM8TSRz+2oEXHxuJSsNYDzo4flQ==
X-Google-Smtp-Source: AMsMyM5h+piJZy1yW3lpw1EdYKId/NcgvPlYP21Z5bFe8FV3psdcZYOejGm+vHjk3xZZhwcj+ejBpQ==
X-Received: by 2002:a05:620a:24c3:b0:6ee:d4bb:e5b0 with SMTP id m3-20020a05620a24c300b006eed4bbe5b0mr1364269qkn.471.1666999972509;
        Fri, 28 Oct 2022 16:32:52 -0700 (PDT)
Received: from [192.168.1.11] ([64.57.193.93])
        by smtp.gmail.com with ESMTPSA id m8-20020ac84448000000b00397e97baa96sm43946qtn.0.2022.10.28.16.32.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Oct 2022 16:32:51 -0700 (PDT)
Message-ID: <fdeeeb4e-c66c-5c18-41f0-41a9f27ad8e3@linaro.org>
Date:   Fri, 28 Oct 2022 19:32:49 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: [PATCH v2 0/5] Add PWM for MStar SoCs
Content-Language: en-US
To:     Romain Perier <romain.perier@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Daniel Palmer <daniel@0x0f.com>,
        =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220907131241.31941-1-romain.perier@gmail.com>
 <CABgxDoKeJrVK2NxJXd=MicdBWUyusf1aGbgKvyrOyB7m0xbPaQ@mail.gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <CABgxDoKeJrVK2NxJXd=MicdBWUyusf1aGbgKvyrOyB7m0xbPaQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/09/2022 02:41, Romain Perier wrote:
> ping ;)
> 

Please use scripts/get_maintainers.pl to get a list of necessary people
and lists to CC.  It might happen, that command when run on an older
kernel, gives you outdated entries.  Therefore please be sure you base
your patches on recent Linux kernel.

Best regards,
Krzysztof

