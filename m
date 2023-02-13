Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DFF4694B77
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 16:43:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229904AbjBMPnT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 10:43:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229630AbjBMPnQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 10:43:16 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB6E118AA6
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 07:43:15 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id r2so12685650wrv.7
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 07:43:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=grZOW/8aqAxwWW1v+gy6Pklv/5DczNl6MJ8KfdGTD48=;
        b=Mn0epFcPhTHPvPIiTCKz49cfIAIM+YjqM9xB6cayrF/pkYdfjOIHLc/xGZGhBMVE2X
         1FVAmEk7CYrsaIzgV01uHkXgmnVZceRHE9SYeB0Otpxsd37gxUa2ZAeBAVHESnp9iNwI
         qeawgugiKeIuqjajD0obzmYzQ13jcEzo9gc59pN65kx+0euEYDnM8XmT3mTzQxegoptM
         QUQZ+mwp46/thb1S44mhedYlAkOVuOwnqAGAkdyTps8DgUFH92F7Jz8OLBUnKwJ84ty3
         IYrCywkjd5TuUfWpeTOAYYrOpBeSNtVsRAmyFiU1bu+zSJ8vCa5DYc1X6SbXSL/16+O9
         sp5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=grZOW/8aqAxwWW1v+gy6Pklv/5DczNl6MJ8KfdGTD48=;
        b=ang+AjbNgvcp0msgjS9tnfhqPG2CI8EpKKJZBqYQ4JBpXnQP3Nq8un5dzBMZYMHxDl
         5nQXzU3KVTMgWJ2ScREzT35H+/z9UqoURtkrr+nmLoOE+yleFhnd2zAoQi+5rGsHFSCA
         N4GE0G1tZ8SzDTSIl6utZGFKOOsv5twqNcD90B7tqx0jq/KghxA0fltjtN69u0xhEnn4
         rH+GeRdtAGYw5JP2F4Cc4P1pSQF6BCOqZlEgJP74bCIR8XiOjQAmnpzaPBnkPQqS6Gj4
         hSVSikIfSE878k7jy53aJcAlt7Vibj7mxYvlO03pna9xMJxBTwwnxLlUKFSS0XOMJvma
         v3fw==
X-Gm-Message-State: AO0yUKWiWmRUzEfkqdiiO/i9Ip8QWZWQZsOzg5fG1/fEiE2IuX/LniVX
        L15Wt3Pw6AeaAaEABN8W/yFJ6W4P856hNTnT
X-Google-Smtp-Source: AK7set/fv3IfkRhQdb43GUNWPWUP+KWdabW3q7k8WpoMLDKXd9GZktRrSRP+huAK9bzTxI9M3fP0XQ==
X-Received: by 2002:adf:ec83:0:b0:2c5:56f6:52ce with SMTP id z3-20020adfec83000000b002c556f652cemr4737026wrn.26.1676302993959;
        Mon, 13 Feb 2023 07:43:13 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id a4-20020adfeec4000000b002bfc0558ecdsm10735081wrp.113.2023.02.13.07.43.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Feb 2023 07:43:13 -0800 (PST)
Message-ID: <ea8b3ed4-2a94-5378-8c93-4bff1f58c70b@linaro.org>
Date:   Mon, 13 Feb 2023 16:43:11 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH 1/2] dt-bindings: mmc: rockchip-dw-mshc: Add RK3588
 compatible string
Content-Language: en-US
To:     Lucas Tanure <lucas.tanure@collabora.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Shawn Lin <shawn.lin@rock-chips.com>
Cc:     linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel@collabora.com
References: <20230213152740.359055-1-lucas.tanure@collabora.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230213152740.359055-1-lucas.tanure@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/02/2023 16:27, Lucas Tanure wrote:
> Add RK3588 compatible string for SD interface.
> 
> Co-developed-by: Shawn Lin <shawn.lin@rock-chips.com>
> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
> Signed-off-by: Lucas Tanure <lucas.tanure@collabora.com>
> ---
>  Documentation/devicetree/bindings/mmc/rockchip-dw-mshc.yaml | 1 +


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

