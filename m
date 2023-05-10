Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28E136FD9FE
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 10:52:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236802AbjEJIwX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 04:52:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236767AbjEJIwK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 04:52:10 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 549FC7ED5;
        Wed, 10 May 2023 01:51:39 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id 5b1f17b1804b1-3f195b164c4so45553435e9.1;
        Wed, 10 May 2023 01:51:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683708698; x=1686300698;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Dlbrk4ZPhxYJQ2iwlQYUgs1YMic9U6ZFVKSub2IU5aA=;
        b=Yp8TzKP3TmqtoNZ+fCizpDtzsNuLZntoDVf8jYnpn9qBGzOCC7t/hwHmQBX3wV/ns8
         kySBKurqNOP4UJQGYmQ0WaW/LSziLYl5JVvzVzJwXkdxR2U44bplU/5IGsy+VoN0frEM
         gMooL/sEXvab+yLWktPd+iW7AQKIcBzV1nIupZqU5wnqlDFXJJAR33zfGr+1fPCdWiys
         LYNtW4YfILFX/wB5JuvE+Im8c7O7XbHODq4wDlxObrLPR9PHnww+Sn5SAgGB5bXud38u
         MTlB8+FvvuCbMP5zDJ+mHQilzaSyS5DEU4k7as1Q9Rd1Aj8Fe1VZORR7Gy58EBUwFFha
         UcWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683708698; x=1686300698;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Dlbrk4ZPhxYJQ2iwlQYUgs1YMic9U6ZFVKSub2IU5aA=;
        b=VQuV522rrBxZlQrm/mBYGYrV3cAEhvTEkSyVpdDHTCgk85TN4fgUuGafwoz9vftzut
         bsRI7gURVAodFZtw74r7AzEMqBuicOQ6J6NyZ9OAx723E2/NR5TILTVwVKqcaTbiLc3D
         qxoMOZxZj21AHGQBjTjPcJ9ocMrKJdH9lIZ/6tZ4r1/E1mX+d/fWXUbDJ5EH/K6aBRt3
         2blv+fEb+G8O0bbFDK9w4kAHbRInSz1zkEo1WWNU9yS5qH84EafnONs5s3SsPvr45LAX
         rw59u87gv8SAQ4Z5hk3iq7XViC47b/SqLAdUeqP0Qj4dFgHIdC2KIrLxeFr/y90so5jl
         rueA==
X-Gm-Message-State: AC+VfDxPDmRqCGGmfEQyfaKc0+Whbk/RH20Q7Kzg/N2ygLTfz89PijEF
        mY/pGL8yp0KaUhYxIFaPW8U=
X-Google-Smtp-Source: ACHHUZ4AeXulhEHTiTvL5HA71WfLqKjAEc3fIwJyAKBWxzr5/LME6Z9PVS3weTa+vNfic/xkXytfZw==
X-Received: by 2002:a7b:ca4c:0:b0:3f4:2819:7777 with SMTP id m12-20020a7bca4c000000b003f428197777mr5585021wml.38.1683708697661;
        Wed, 10 May 2023 01:51:37 -0700 (PDT)
Received: from [192.168.1.131] (cgn-89-1-213-9.nc.de. [89.1.213.9])
        by smtp.gmail.com with ESMTPSA id h1-20020a5d5481000000b0030647d1f34bsm16850080wrv.1.2023.05.10.01.51.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 May 2023 01:51:37 -0700 (PDT)
Message-ID: <9b89164a-bd8a-bdea-2c17-101428aba98f@gmail.com>
Date:   Wed, 10 May 2023 10:51:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v1] backlight: lm3630a: turn off both led strings when
 display is blank
Content-Language: en-US
To:     Daniel Thompson <daniel.thompson@linaro.org>,
        Maximilian Weigand <mweigand2017@gmail.com>
Cc:     Lee Jones <lee@kernel.org>, Jingoo Han <jingoohan1@gmail.com>,
        Helge Deller <deller@gmx.de>,
        Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org
References: <20230505185752.969476-1-mweigand2017@gmail.com>
 <20230509132735.GA31274@aspen.lan>
From:   Maximilian Weigand <mweigand2017@gmail.com>
In-Reply-To: <20230509132735.GA31274@aspen.lan>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



>> Use display_is_blank() to determine if the led strings should be turned
> 
> Shouldn't this be backlight_is_blank()?

Yes, indeed. Thanks for pointing this out. Fixed in v2.
