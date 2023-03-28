Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F21B76CB75E
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 08:42:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232398AbjC1Gmj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 02:42:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232576AbjC1Gm1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 02:42:27 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 466992D5F
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 23:42:25 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id ek18so45357820edb.6
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 23:42:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679985744;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Zms3f87kgqq/O54u/ZeUMcCMrrmOfOC/TKKWRsysbBY=;
        b=L83sjWQIVYxyit9rJ2Icowbk1Y+vtYb0qSPkJG5BdTHLar5gM+Q1ApzieEPleG+mot
         AfZRi3hmp2AtDhe0ZXJK2L48/Vqsgkyb5HAEMaGg0CKlc18cdeiCO9SJqPVxgxc4m5mP
         amMca7xp5CcRzIMVtTrU/GK0M4JguTbXPKULIx71tiz4eacroqtpTQ4iZwgK+GqBGo3k
         sz12vRfLRj2xEur+EdXWROpdWd083B08IcJ64o7oL1bxZk2j4t7cKDQ4UXXYjrKe6EBb
         T65dPqNOL3XfanK+2ZpJCqoMiFNox0AjYXQtga5xEjvOnW0vYa3DdXKyxuucwdNwnWG0
         jJpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679985744;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Zms3f87kgqq/O54u/ZeUMcCMrrmOfOC/TKKWRsysbBY=;
        b=0J0DE3djXob1FYUaOs+3E1PlBnsG144Cbk+uh5rFWRDkAKW6kq5pGSOqi/D3jUqMcj
         lcCeAlxycULyAqz5JSX7Qmi1ftkkdtz9wU1UQl03rLGcSRZ83iXmZBaKlP273VPDWZrl
         nX+XO9Iq71PchcPJ0PFEmyqv6x952eXOPhT5v9No0nllJHtoGIgW0iUk9vOMTCZEqQZb
         cu5tDN22zJCE3MSR/3Xs+xwHLYAREArYYKytMv8w6sADaFxKADMzVJchjfxI1GUVbBUx
         wdw5QhgZ8h1dfm7okxL0dPFGoqUPFBbGBn6kJlhyKAYzZUQqlvg7Mwa4L1+FA6aIQdCw
         BhmA==
X-Gm-Message-State: AAQBX9fCPMIJubImimy88PlzUwrLcNte3wDJT5X7TDErMKsdnj+KTBVn
        xkzzinRF2mS+wj1IKvKriIFEgw==
X-Google-Smtp-Source: AKy350bbscTch9wCANshCju8VYq8/rJEvvHED5op3C72ZbWe+OpnvYBFwEZrGUs3c4fwuYCtL7cGLQ==
X-Received: by 2002:a17:906:ecf1:b0:932:c1e2:9983 with SMTP id qt17-20020a170906ecf100b00932c1e29983mr15165299ejb.15.1679985743864;
        Mon, 27 Mar 2023 23:42:23 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:9e92:dca6:241d:71b6? ([2a02:810d:15c0:828:9e92:dca6:241d:71b6])
        by smtp.gmail.com with ESMTPSA id jz15-20020a17090775ef00b009334edaed98sm12659815ejc.50.2023.03.27.23.42.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Mar 2023 23:42:23 -0700 (PDT)
Message-ID: <5d83f4dd-0baf-41fd-d16c-0723543aa084@linaro.org>
Date:   Tue, 28 Mar 2023 08:42:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH] dt-bindings: soc: amlogic: Drop unneeded quotes
Content-Language: en-US
To:     Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20230327170222.4107746-1-robh@kernel.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230327170222.4107746-1-robh@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/03/2023 19:02, Rob Herring wrote:
> Cleanup bindings dropping unneeded quotes. Once all these are fixed,
> checking for this can be enabled in yamllint.
> 
> Signed-off-by: Rob Herring <robh@kernel.org>


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

