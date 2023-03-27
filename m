Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAD696C9C83
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 09:42:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232774AbjC0Hm5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 03:42:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232728AbjC0Hml (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 03:42:41 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81DE13AA4
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 00:42:18 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id r29so7588314wra.13
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 00:42:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679902930;
        h=content-transfer-encoding:in-reply-to:organization:references:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=JOOOBiroamhenwfuo5ga6dE+XPuQESypbE4qSgQtMmw=;
        b=p/Brd6ggDoF2ypyCtWUYx9hxs9tk4yrURUQxVCyXR3p24EObbQ9+nRO0YIl73Solxf
         k1JaXKrbxsxsP81V6V5gHBOcPz7s5iSomtk/ZpFoKXO1bytHoMgh0dZEJnmHTIdBM97Z
         8maNgbwBmv1gtySCMnGhM6faanOdwFQ5VDaq5GBH6b9aU2s2jKfsSe/6eebQfcUVsFTh
         AmgTTcRhMxCgYc7AC6AWBL+L/SpzLwsehxm6EzJLjisXUbVw/jsnatXTktUEGk26eoUH
         q92VBezC7lQ8ygCmOFIgBFWxFsbNKIL7h83j5TkOGU9hgqieiv1raW83bNB3eihw+GUb
         HRhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679902930;
        h=content-transfer-encoding:in-reply-to:organization:references:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JOOOBiroamhenwfuo5ga6dE+XPuQESypbE4qSgQtMmw=;
        b=f+OicHmiW/6SKofwc6PZxk3sAdlY8K9e7runP5FJuYG06nzrczdVnFOBssrDb/rDkO
         1c8MziNzO+VKs3DndObomS4waRzew3WfRpYyr0RLRGbfVnlyRfMYtzWI17BnvwP8PG01
         nM4FmB/3kbJv4g9APKJNSmdwM4GrxQqBE+vnrkDNdB/EYhizO563HUYQPM4roZBZ92Fw
         xA7LwgZzzbjGyXbrCZ+mX6roz0yooiKzhO8pDd0Y+nJLESu1WS0LJMMcy0Pe8UfCnr1c
         6kpgvvgFDaBEjdaRw3/S+apHu5+qZMY3+kEsqBZKSx/llrx5DcdFGoP4zpZVQ5IhbV2l
         0Y4A==
X-Gm-Message-State: AAQBX9eqLttNpt829lS6Hx3+tR7TBEDv/q9c1eF/ziD3fOrKcVjNxCBn
        xswkcDPJAM4pKl3cD+GhYcxhxA==
X-Google-Smtp-Source: AKy350YqQy+pbOYZ6Soh7L7C3RBpiSINUxjeCX9YBoZBQYWARi3ekoerDhsAJpTYKLCwciDv0Od6Cw==
X-Received: by 2002:adf:e84d:0:b0:2dc:f007:38d6 with SMTP id d13-20020adfe84d000000b002dcf00738d6mr8668408wrn.6.1679902930106;
        Mon, 27 Mar 2023 00:42:10 -0700 (PDT)
Received: from [192.168.7.111] (679773502.box.freepro.com. [212.114.21.58])
        by smtp.gmail.com with ESMTPSA id v15-20020a5d590f000000b002cfec8b7f89sm24490954wrd.77.2023.03.27.00.42.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Mar 2023 00:42:09 -0700 (PDT)
Message-ID: <8a4b3e73-2dc5-3b2c-ed73-f43893406beb@linaro.org>
Date:   Mon, 27 Mar 2023 09:42:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
From:   Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH 3/4] dt-bindings: display: elida,kd35t133: document port
 and rotation
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jagan Teki <jagan@amarulasolutions.com>,
        Heiko Stuebner <heiko.stuebner@theobroma-systems.com>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230326204224.80181-1-krzysztof.kozlowski@linaro.org>
 <20230326204224.80181-3-krzysztof.kozlowski@linaro.org>
Organization: Linaro Developer Services
In-Reply-To: <20230326204224.80181-3-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
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

On 26/03/2023 22:42, Krzysztof Kozlowski wrote:
> Panels are supposed to have one port (defined in panel-common.yaml
> binding) and can have also rotation:
> 
>    rk3326-odroid-go2.dtb: panel@0: 'port', 'rotation' do not match any of the regexes: 'pinctrl-[0-9]+'
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>   .../bindings/display/panel/elida,kd35t133.yaml           | 9 +++++++++
>   1 file changed, 9 insertions(+)

<snip>

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
