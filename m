Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02E1470F170
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 10:51:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240390AbjEXIvM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 04:51:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240373AbjEXIvJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 04:51:09 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 577A097
        for <linux-kernel@vger.kernel.org>; Wed, 24 May 2023 01:51:04 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id 5b1f17b1804b1-3f42ba32e24so5856115e9.3
        for <linux-kernel@vger.kernel.org>; Wed, 24 May 2023 01:51:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684918263; x=1687510263;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qpwZKl15N1ARAVTzHTzpdCx10bm72H5sA4Jzbb3JTYA=;
        b=HvFRB1UTElygxUYfN+8OUAQV8DHc74GM/qd3uJNTM/5AUFFeH870fRxbP6cS6hs87s
         snYxkYZtpIgTx3j4tj+byXvhspX7IO7OThCVtps6DSplS5IzGMV853X/sqgk1yoYzv7i
         nHohAn9kJ9ofONnx71cWdBxU04VSJ0XMeBywsh83eVkPhu0SASoI3MLWX+zWAE0v3tBd
         uhnYiZ8g3udr18R9Fn2aVsB+RKVR83W7ocAZ1wyT0AIzlSnuaXoFZHmkTVAiKLAhVPgf
         lSR1L9yUrW9rVKKeWIlLIPqqYN7SbWnpObC8njObLhEF/AyST1zCxxRqnswhIRj15c36
         ruAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684918263; x=1687510263;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qpwZKl15N1ARAVTzHTzpdCx10bm72H5sA4Jzbb3JTYA=;
        b=eDBVDNcOxbwK+peRS4aWsNjP7Y3qhaTVICCKei9xBAcfXHvhJ8fWYM5t2UZppOLf5w
         Y+K9WQtfV3r/wH5g4FwvAfc2MPlrb/GKft/rvoG7EEe59c0sVWtLaU/oIQ1X49itxgaY
         nFsNPpBsEj09WJDhXXqUzbmesqxaiknEIEGBYEU5FCbYk/eTh5wG/f8nTavWdKao/B6Q
         Xn4dNelWR8aOsa3cErQgSD+b2xr62gjFg18e8o8JXZkznjzBVTcgZMvYBh6rvXFMAbMB
         0CRNNSa621UVn+Br4WEQdpHUgsCoM6jtw2RudsSKcBouA9Mn4QIK4JsShgxmGqIvi/IR
         afeg==
X-Gm-Message-State: AC+VfDyXfkLZEKTeTs7SYMaoB12AgpS78087QRwBYx2Ty9EZb0F9iZUr
        ZcAuMkWHG8bGxNRsKdvq3ycL+w==
X-Google-Smtp-Source: ACHHUZ5pq80iTCiDU+xKmX+H47kSR1xBIKDG6rPFbX5sZR6vWq/q/bTRaLpBwsF09Dabfc+MOBUfBQ==
X-Received: by 2002:a7b:c8cf:0:b0:3f6:26a1:1d58 with SMTP id f15-20020a7bc8cf000000b003f626a11d58mr594423wml.37.1684918262841;
        Wed, 24 May 2023 01:51:02 -0700 (PDT)
Received: from [192.168.1.195] ([5.133.47.210])
        by smtp.googlemail.com with ESMTPSA id m11-20020a7bce0b000000b003f6042d6da0sm1613875wmc.16.2023.05.24.01.51.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 May 2023 01:51:02 -0700 (PDT)
Message-ID: <c37b88ae-7f54-3c07-666f-010a5fd84bd1@linaro.org>
Date:   Wed, 24 May 2023 09:51:00 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 1/2] ASoC: codecs: wsa883x: do not set can_multi_write
 flag
Content-Language: en-US
To:     Mark Brown <broonie@kernel.org>
Cc:     perex@perex.cz, tiwai@suse.com, lgirdwood@gmail.com,
        ckeepax@opensource.cirrus.com, kuninori.morimoto.gx@renesas.com,
        linux-kernel@vger.kernel.org, pierre-louis.bossart@linux.intel.com,
        alsa-devel@alsa-project.org
References: <20230523154605.4284-1-srinivas.kandagatla@linaro.org>
 <00283665-e44f-457b-b2c9-1acf59d1cbd8@sirena.org.uk>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
In-Reply-To: <00283665-e44f-457b-b2c9-1acf59d1cbd8@sirena.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 23/05/2023 17:55, Mark Brown wrote:
> On Tue, May 23, 2023 at 04:46:04PM +0100, Srinivas Kandagatla wrote:
>> regmap-sdw does not support multi register writes, so there is
>> no point in setting this flag. This also leads to incorrect
>> programming of WSA codecs with regmap_multi_reg_write() call.
> 
>> This invalid configuration should have been rejected by regmap-sdw.
> 
> Does the CODEC support mulitple writes?  If so it seems better to leave
No, the codec itself does not support multi-write. All the codec 
register level interface is via SoundWire Bus. which also does not 
support with the existing code.


--srini

> the flag set and just do the appropriate fix in the regmap code until
> such time as it's updated to be able to exercise it.
