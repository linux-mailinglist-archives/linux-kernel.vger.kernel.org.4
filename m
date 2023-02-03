Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89545689138
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Feb 2023 08:49:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232204AbjBCHtA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Feb 2023 02:49:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230384AbjBCHs6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Feb 2023 02:48:58 -0500
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4638492C3C
        for <linux-kernel@vger.kernel.org>; Thu,  2 Feb 2023 23:48:57 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id l37-20020a05600c1d2500b003dfe46a9801so1707667wms.0
        for <linux-kernel@vger.kernel.org>; Thu, 02 Feb 2023 23:48:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=v5gfpczBzl62sAvBqjyZghlCn5Q/6Yh+maXELEJGN6Y=;
        b=HAO2CNODWncVDUlMlFhIV6G/1KE+6/Sw6jH7FCGny1is7RMq7DDZWism/cSfO1QPmY
         YWpE7obG92rNxg0WDwlz+/itQXkq4uMNl05IuIg+/pAkBmLGzxSGwi5gdT98lReGF6c2
         OCy8iXA3/12Ozd8KXYIQDIF/TTUXgLnq+3AJzeZhb/6wHRa7CKIo/ZS5MtOTt/uU055F
         NRHplid1x2R11lA+5CO3Jpjo9z04B70XPxxXHQSs/6Et8FsOkIK3SUEPRvFlBNjnwzst
         OWF32m2lvF3SPrp18G/+YqmIQFNAgipHr3RGG5TK6SizVkqhhVw0i8U2LJfShkhBH1Hc
         E70A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=v5gfpczBzl62sAvBqjyZghlCn5Q/6Yh+maXELEJGN6Y=;
        b=GJP+EoxZzTEitWa9lMWBAo6ZTg9LlSzdZorASiL8lCsZc3dr+t9AVTeDW3K9jk7pbf
         fb6RTEt5oS7J56A6bh20WFwgpmfj9z2eSHRWFiOYhPWEozE69RDeiti40olB8hblqHzZ
         Oo/tuxO8HlZmOUGGtALNL30gObOLCgUzMay/QGdRDAcoqMTFR3EIxVOkCADMRR6RQxwE
         3HaqXWBjxIIjXeGz88z0SOaB+KT30E4ec7Nc7IO7Tpg7lk+j5ruXFTvGpjnmX6oM5mjK
         BgX7JxJ/0sShx823wQE5rUQUHbG1aBjZ9iZy2YEz7KRYBQazQvDV2z1UwFMVPFygzfTs
         grQQ==
X-Gm-Message-State: AO0yUKWPQaiYxNYSJnn7tlRzJB9NOAK26kL6GEwmKV+JUvihxN0oETmF
        tL8wQ4z+Xn8nnXFMErI37Od/5g==
X-Google-Smtp-Source: AK7set+oqhPulJShRtcIKzg8mOnQKZu7gCG1/8sG+jlfV7LfKIvKHyV6ok09Mw27P/viyjbWaw/7mQ==
X-Received: by 2002:a05:600c:1c22:b0:3dc:37d0:e9df with SMTP id j34-20020a05600c1c2200b003dc37d0e9dfmr8634479wms.14.1675410535780;
        Thu, 02 Feb 2023 23:48:55 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id y6-20020a7bcd86000000b003dc4480df80sm7001220wmj.34.2023.02.02.23.48.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Feb 2023 23:48:55 -0800 (PST)
Message-ID: <e2d4c841-b3f9-a23e-6977-4015f8f9de5f@linaro.org>
Date:   Fri, 3 Feb 2023 08:48:53 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH 1/9] ASoC: dt-bindings: create component common schema
Content-Language: en-US
To:     Jerome Brunet <jbrunet@baylibre.com>,
        Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org
Cc:     linux-amlogic@lists.infradead.org,
        Kevin Hilman <khilman@baylibre.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-kernel@vger.kernel.org
References: <20230202183653.486216-1-jbrunet@baylibre.com>
 <20230202183653.486216-2-jbrunet@baylibre.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230202183653.486216-2-jbrunet@baylibre.com>
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

On 02/02/2023 19:36, Jerome Brunet wrote:
> All DAIs are component but not all components are DAI.
> Move the component properties (sound-name-prefix ATM) to a separate schema
> file so it can be used by non-DAI components, such as auxiliary devices.
> 
> Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>


> -properties:
> -  sound-name-prefix:
> -    $ref: /schemas/types.yaml#/definitions/string
> -    description: |
> -      Card implementing the routing property define the connection between
> -      audio components as list of string pair. Component using the same
> -      sink/source names may use this property to prepend the name of their
> -      sinks/sources with the provided string.
> +allOf:
> +  - $ref: component-common.yaml#
>  
> +properties:
>    '#sound-dai-cells': true
>  

Probably we should require sound-dai-cells at some point, but anyway:

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

