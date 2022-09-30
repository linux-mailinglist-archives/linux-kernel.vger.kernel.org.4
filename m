Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 444795F09EC
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Sep 2022 13:21:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230163AbiI3LVD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Sep 2022 07:21:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231540AbiI3LUZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Sep 2022 07:20:25 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7255115817
        for <linux-kernel@vger.kernel.org>; Fri, 30 Sep 2022 04:07:31 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id s6so6329435lfo.7
        for <linux-kernel@vger.kernel.org>; Fri, 30 Sep 2022 04:07:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=XWtzZixKfPniF8uYcbLfI+qJWOlIt8bodoZy8GBfZjU=;
        b=VP39Hq1nZH771I4kAuqaT7SU1qU/V/fC8+lyHsiV/fG+DybXrU+bZu0IOBMJBDixiO
         mHZUKHEdJ4VFIdW0ZH4lL5ilq7rT1DnjHlZMIviF8s/QDWKOLDJPd0ebnwBaMH3ytnJt
         btWeBMPyXRMk3BeCvf1YrQpg6lEZ7hb9T6YdouuAIMMQ8Xivvv0axwQSaZkhAKesXzlV
         +xwyuWaSIv24HmPV+xXjy0uZK4jZvrXa+7miJLYfQj2rF05xOEAB3l/gkMP1FCuXXxsH
         82GMhFY0Figqa2/wwccUQMCKmnxkLaTgFIkh6U1ZjyXp2cJt5t+mLtsNEJJC8EL1N9qh
         TmWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=XWtzZixKfPniF8uYcbLfI+qJWOlIt8bodoZy8GBfZjU=;
        b=I2ZQNK/4hE1rYHAk2NOzDNPq8bO+IyjYIiejhC8vw8NPKZ9he5ScF45AmAjQkjOO5Q
         N+1IFFXA8Y5cx96IIYKOiCx+JCubQQuuZjRjo3GFtGmS/qVFzFds9QMJBomgsbWfbacc
         J1rjAXmgDO3ErVM1F7sWmnsC7V8qHk9uIIM5dOlx3btEhGh5UTc6UnAxR/jmzRYlChKt
         b+t/Kic4K0e5s2MaVkHcGrzMsS2qSyt2LZ0ElpS+jif49/u5tEF6f/IskXFt5SELuv5T
         Elp5Cs7ubiwVvKjSnBQVisQjeq6rQDZMY+7M8HZcXHhvIxmRDBvw/yRv/K4doHmJ3loT
         RNXQ==
X-Gm-Message-State: ACrzQf0Yjj/xfp9G9YAg2S4ykJWtmMuZFQ4/sJKnN7n+55olHxOdFglb
        Fc30sZxYWogkv+dO+wVwh8MrZmniYfpCJA==
X-Google-Smtp-Source: AMsMyM6/7L83ANARnxB/O8luSGnfbMwGPrhqLgELtxw0omADZ9sf/N+xGqlBs+SFO66pNBucO42c2g==
X-Received: by 2002:ac2:4c30:0:b0:49f:53dc:324d with SMTP id u16-20020ac24c30000000b0049f53dc324dmr3296030lfq.395.1664536049874;
        Fri, 30 Sep 2022 04:07:29 -0700 (PDT)
Received: from [192.168.0.21] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id d10-20020a2eb04a000000b0026d92d78732sm131963ljl.13.2022.09.30.04.07.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 30 Sep 2022 04:07:29 -0700 (PDT)
Message-ID: <1d309a0d-1636-ba59-667d-f055151b2406@linaro.org>
Date:   Fri, 30 Sep 2022 13:07:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCH V2 1/3] dt-bindings: gpio: Convert Unisoc GPIO controller
 binding to yaml
Content-Language: en-US
To:     Chunyan Zhang <zhang.lyra@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        Baolin Wang <baolin.wang7@gmail.com>,
        Orson Zhai <orsonzhai@gmail.com>,
        Chunyan Zhang <chunyan.zhang@unisoc.com>,
        LKML <linux-kernel@vger.kernel.org>
References: <20220930082405.1761-1-zhang.lyra@gmail.com>
 <20220930082405.1761-2-zhang.lyra@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220930082405.1761-2-zhang.lyra@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30/09/2022 10:24, Chunyan Zhang wrote:
> From: Chunyan Zhang <chunyan.zhang@unisoc.com>
> 
> Convert the Unisoc gpio controller binding to DT schema format.
> 
> Signed-off-by: Chunyan Zhang <chunyan.zhang@unisoc.com>



Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

