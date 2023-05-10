Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 965166FDA05
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 10:53:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236859AbjEJIxC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 04:53:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236872AbjEJIwm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 04:52:42 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 692D73C27;
        Wed, 10 May 2023 01:52:17 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id 5b1f17b1804b1-3f4449fa085so5914735e9.0;
        Wed, 10 May 2023 01:52:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683708736; x=1686300736;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+W0u0yW4mt1eIi/4crd+vyLCw2vSkQ6ty0fIhiNv5ZE=;
        b=IEXCK5RaT8/jHtwqWGvJGg3UVFM7d7GsjZYVh1tmATAN547tNCCLl5d7y9Iv5K2Y/l
         +1gjQxx8rphBqAmlO/4ExZLjDahGTYxdV3rJPf9lvXkwesAbnwX4UAF7j8JkS8a20UP3
         3fcAmxsmxIErIAkoRzihqKSEB46YQNDV9ZWSsz0wfN/11Yj6/DpEt8zEOqjjBzhDqNsP
         bzrMQRKOt7Kbio7/28N1u/9Fr6t7PE92sxtQHJWMJ5CASCttJ4DyRhMaEud7GoO27gHv
         T1GnYby7wGMQg7Pp7wNHQnybdSxxW5mPs5k4bjuDtOJhwGVyA3MuRxdtqHFhhMdl3yfq
         saPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683708736; x=1686300736;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+W0u0yW4mt1eIi/4crd+vyLCw2vSkQ6ty0fIhiNv5ZE=;
        b=fq4nCffzdgo9P8CaF/ESCj+WmCFhie7vjmduivS0rlReKe8gjl/VLNze9NqGkXlwNG
         gumDU9phUSCr/0o1LjAsRN1KDQsZruqs7vGn2PVyWpDyZdtFm2WjpdhI4UPcd8WZuueW
         Mtatk2U8l+8vBG2OWogXIq40ONYNarDD5nCpIn/dcllJAV24nluC7PBS8T7RWgJgoE0G
         daJB2RRvSzlnh01XRpGuISqCY9MeWm69Z2E5//ME+7HAYm/Bb0Xg34N11B21crA6POlU
         eqJ+k8jZlz8dLbuwyLYSmMFTsoMdGAZyc3iBOtR6Jv4eOgxEMyMCGIf5Ipek/OCQTY6D
         nrMw==
X-Gm-Message-State: AC+VfDyFbiMTCB6KXf4NmCGIBqRvFJ4id5O955IR25Ny5BhJnSgWYGVo
        cgU2fRcBSKYWkMM/soFo3v4=
X-Google-Smtp-Source: ACHHUZ7ivHBQG4YpZufVS236WKTcLxuvGLQefRgCKFpaeE5Ooo0XYy/L/+l61SuQWpkbjrIqePoofQ==
X-Received: by 2002:a7b:c5d3:0:b0:3f1:6ef6:c9d0 with SMTP id n19-20020a7bc5d3000000b003f16ef6c9d0mr11110681wmk.17.1683708735582;
        Wed, 10 May 2023 01:52:15 -0700 (PDT)
Received: from [192.168.1.131] (cgn-89-1-213-9.nc.de. [89.1.213.9])
        by smtp.gmail.com with ESMTPSA id q14-20020a7bce8e000000b003f182a10106sm22166844wmj.8.2023.05.10.01.52.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 May 2023 01:52:15 -0700 (PDT)
Message-ID: <4378f2ba-f620-b4e8-f0b3-9d08dcb6e2f3@gmail.com>
Date:   Wed, 10 May 2023 10:52:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v1] backlight: lm3630a: turn off both led strings when
 display is blank
Content-Language: en-US
To:     Sam Ravnborg <sam@ravnborg.org>,
        Maximilian Weigand <mweigand2017@gmail.com>
Cc:     Lee Jones <lee@kernel.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Helge Deller <deller@gmx.de>,
        Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org
References: <20230505185752.969476-1-mweigand2017@gmail.com>
 <20230509165232.GA1072872@ravnborg.org>
From:   Maximilian Weigand <mweigand2017@gmail.com>
In-Reply-To: <20230509165232.GA1072872@ravnborg.org>
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


>> +	if (backlight_is_blank(bl) || (bl->props.brightness < 0x4))
> You could replace bl->props.brightness with backlight_get_brightness(bl)
> to avoid direct access to the properties.

Thanks. Changed in v2.

>> +		/* turn the string off  */
>>  		ret |= lm3630a_update(pchip, REG_CTRL, LM3630A_LEDA_ENABLE, 0);
>>  	else
>>  		ret |= lm3630a_update(pchip, REG_CTRL,
>> @@ -277,7 +279,9 @@ static int lm3630a_bank_b_update_status(struct backlight_device *bl)
>>  	usleep_range(1000, 2000);
>>  	/* minimum brightness is 0x04 */
>>  	ret = lm3630a_write(pchip, REG_BRT_B, bl->props.brightness);
>> -	if (bl->props.brightness < 0x4)
>> +
>> +	if (backlight_is_blank(bl) || (bl->props.brightness < 0x4))

Thanks. Changed in v2.
