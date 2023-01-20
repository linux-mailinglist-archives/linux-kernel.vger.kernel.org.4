Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F434674F43
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 09:18:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231134AbjATISg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 03:18:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230526AbjATISe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 03:18:34 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B848677AA
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jan 2023 00:18:33 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id e3so4093777wru.13
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jan 2023 00:18:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=04cr3oM77vtN8LfGWpfaCYtk7vDm8eozzkmdIql1hhs=;
        b=h5U1ItDyBVg5MkRF35lpFx4g3kTNsCUg80glYG5X1vv6D4cXwIkXMA6qri2t90+Tbx
         ra+JDdqw6RH6zDBf/RQohRtBx4eGXSyapN7FZiltRhXU+xzRrmGknYNrMLBeXQh6ywIP
         6go0CV7QQAVuqCSKRQJhUUINsSOUDFYL4ecjsPFAQt4aG9bp9CCgVHuPS0vA4hLpRhVh
         +Xpfyt+LBbtqxYKTgYUyFTd6yCKKUAUECrJL1HbH4sGBR5R0dgZelw9s5ir2PIYYoQ2k
         sfHmSrfmMcnAaE1B1zc3MtW+F8sofSjNxt7a3J6a/zIPdZR1sjPSs/Mep64QQLH4bYfx
         4aBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=04cr3oM77vtN8LfGWpfaCYtk7vDm8eozzkmdIql1hhs=;
        b=jfXYNYR8dSwZPRf+VwM81VMnFMq8UDvE7nmwmz84TM/hJftjPNZog2uKe2h/vufogw
         LFXUlSr6a4YcJOqjBk8EEGxG08PWyuVyYkqND9sdp/Fz0fCCBZIUlhFXJ4t3gnkcDaR4
         g3oLDcyyYh36uYvORfXlLcGNIxr/v/pqC8Z/RATLw+eXoNb5XwBiCc0C7d0ixxaDPbkS
         29QighuhsulyGyc+xNGgBys8dR+dgNBC1ooElPbtvHYs2Qs8KlbtlTI22S1FEjdR8FXa
         FFTHfFZHtNUNebh3eojLRKjF8DXL8GuPSVO472RcBjxCkDZOZgod2RfWvsXXJaLUTVut
         2lAQ==
X-Gm-Message-State: AFqh2kof97c+lSgywVuChZelXt3fBAxQJxCy8JChNilsXSRuZ8gstujY
        j8OCis+W8p7bGKXJRuRd1zrRtw==
X-Google-Smtp-Source: AMrXdXtTB7C5TqJJt0iSVIDXrkSwRPe5tbKe9Mtkw56Xr6RYqWyp/++OsQ1xifYMqHgGBgoDr6bJPQ==
X-Received: by 2002:adf:ef4f:0:b0:2bc:7ff8:fb83 with SMTP id c15-20020adfef4f000000b002bc7ff8fb83mr11997475wrp.47.1674202711681;
        Fri, 20 Jan 2023 00:18:31 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id bt19-20020a056000081300b002bdc3f5945dsm23285543wrb.89.2023.01.20.00.18.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Jan 2023 00:18:31 -0800 (PST)
Message-ID: <78f963ca-8cd7-ff02-f651-28ade8b7537e@linaro.org>
Date:   Fri, 20 Jan 2023 09:18:28 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.0
Subject: Re: [PATCH v2 1/3] dt-bindings: clk: Add apmixedsys/topckgen
 compatibles for MT7981
Content-Language: en-US
To:     Daniel Golle <daniel@makrotopia.org>, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-armkernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     Chen-Yu Tsai <wenst@chromium.org>,
        Miles Chen <miles.chen@mediatek.com>,
        Edward-JW Yang <edward-jw.yang@mediatek.com>,
        Johnson Wang <johnson.wang@mediatek.com>,
        Fabien Parent <fparent@baylibre.com>,
        Chun-Jie Chen <chun-jie.chen@mediatek.com>,
        Sam Shih <sam.shih@mediatek.com>,
        Jianhui Zhao <zhaojh329@gmail.com>
References: <cover.1674152610.git.daniel@makrotopia.org>
 <ac08655ce45fa60fc0f510c72dce18fd4807b345.1674152610.git.daniel@makrotopia.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <ac08655ce45fa60fc0f510c72dce18fd4807b345.1674152610.git.daniel@makrotopia.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/01/2023 02:25, Daniel Golle wrote:
> Add compatible string for MT7981 to existing binding documenation
> at mediatek,apmixedsys.yaml and mediatek,topckgen.yaml.
> 
> Signed-off-by: Jianhui Zhao <zhaojh329@gmail.com>
> Signed-off-by: Daniel Golle <daniel@makrotopia.org>

Use subject prefixes matching the subsystem (which you can get for
example with `git log --oneline -- DIRECTORY_OR_FILE` on the directory
your patch is touching).

You got comment to fix it with nice example, so why using something else?



Best regards,
Krzysztof

