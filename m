Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACA6C6D2F76
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Apr 2023 11:45:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229810AbjDAJpO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 Apr 2023 05:45:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229549AbjDAJpM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Apr 2023 05:45:12 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12CBAD50C
        for <linux-kernel@vger.kernel.org>; Sat,  1 Apr 2023 02:45:11 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id e18so24706778wra.9
        for <linux-kernel@vger.kernel.org>; Sat, 01 Apr 2023 02:45:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680342309;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=enLSXvC9cOIGUaRnMgYw4KnAx/zsnnPatWKBKRZeUhs=;
        b=DB4GBhIICc4dXx4AUyVmnX90Z5uhn16tnAF6/gW4OPxZ2Qh97CQpD2rmfa5kKZIfTa
         EwIleDu1NJTSBMjTbKSsSe4M0pQ8p9aBmZq/c0wLa5kkSR13wWYC2lj2LjsoPXnZKlwY
         +IhMIPdZV321uCwG8WERPBl5WTy5Fw6UeGb6OC3zsaYNVL3j6ruY75uBxQAk0qUZJhEj
         iMLGa/i9gXeZFbWtIYPD7o9mPTa/p6zjYmsRbZ165W4EFjkKOGP9xQM3ei1vySrfkZsS
         15P/YeZzn3+Jvcz+UuaMPr6CzyhilvbjmKDhRldVXoB8b21RxTWrdDspWcS/jOALG7vf
         jZcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680342309;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=enLSXvC9cOIGUaRnMgYw4KnAx/zsnnPatWKBKRZeUhs=;
        b=NFPnv1W7WNFZ2u0z8CIpqcVcGDbLxDxS9pp9UR3k3ts9DTvG4f3Z8XkJ4AIyNR6jh7
         v9vIch5Tcqgy3b3ogtMU9/KVi27LWu/tRpYDBl8UgY9g7Tcv7LysH+rF3kVfEJqsPWiO
         AoAnN3rhlBYstnoyZur6h0ikI5K2Lpy0sKHv7yc2P6p81rJg1AzyCVdD1pAAi3jmTvcc
         6hf1S5YT35/Lb4X4tBKINdM1+CPjixnEP5XZlncrITVZpMPXYOZbLTwS+qKXU0VhE4Oc
         36yRYOuSGa3UkXQrN9Wqcglbp3SFZY1eDdRHXAOmBVIilKTksXCHyXGMO8kUtUexSIoo
         cikA==
X-Gm-Message-State: AAQBX9cYA7yakX+ouBDkfaDKMLec0Uf2PHvlTvobca5/ZWGbC8UFH3HE
        ySpkLLMHVMsgsfIG1BSe3veDVg==
X-Google-Smtp-Source: AKy350bdhrPXteAy14H6wTreJILApVyTmS/XDg66OMR/3heapL9ZmGdi17szArp0VJxBbQMcJI/m9A==
X-Received: by 2002:adf:e644:0:b0:2c5:4c9f:cf3b with SMTP id b4-20020adfe644000000b002c54c9fcf3bmr9084520wrn.7.1680342309583;
        Sat, 01 Apr 2023 02:45:09 -0700 (PDT)
Received: from [172.50.14.32] (5-226-109-132.static.ip.netia.com.pl. [5.226.109.132])
        by smtp.gmail.com with ESMTPSA id s11-20020a5d424b000000b002e5f6f8fc4fsm3877194wrr.100.2023.04.01.02.45.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 01 Apr 2023 02:45:09 -0700 (PDT)
Message-ID: <1d08d7a7-0682-cd05-f2a1-2b458a2eb25d@linaro.org>
Date:   Sat, 1 Apr 2023 11:45:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v2] ASoC: dt-bindings: maxim,max98371: DT schema
 improvement
Content-Language: en-US
To:     =?UTF-8?Q?Andr=c3=a9_Morishita?= <andremorishita@gmail.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        anish kumar <yesanishhere@gmail.com>,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     mairacanal@riseup.net, dri-devel@lists.freedesktop.org,
        daniel.baluta@nxp.com
References: <20230331020527.482991-1-andremorishita@gmail.com>
 <20230401035756.856752-1-andremorishita@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230401035756.856752-1-andremorishita@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/04/2023 05:57, André Morishita wrote:
> Improve Maxim Integrated MAX98371 audio codec bindings DT schema conversion

Your patch changed much more than your commit log is saying. I don't
understand why. Previous subject was better than this, I only commented
on missing prefix.

Commit msg now is unspecific and misses full stop. I don't understand/

Do not attach (thread) your patchsets to some other threads (unrelated
or older versions). This buries them deep in the mailbox and might
interfere with applying entire sets.

> 
> Signed-off-by: André Morishita <andremorishita@gmail.com>
> ---
> Changes in v2
> - Generic node names - codec (Krzysztof)
> - Drop label max98371 (Krzysztof)
> - Add sound-dai-cells in example (Krzysztof)


Best regards,
Krzysztof

