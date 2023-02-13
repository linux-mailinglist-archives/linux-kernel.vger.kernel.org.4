Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A91DC694380
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 11:54:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229876AbjBMKy2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 05:54:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229814AbjBMKyZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 05:54:25 -0500
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19F97CA26
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 02:54:24 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id r18so8385125wmq.5
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 02:54:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=c4gMj6DLk69LRUfrPQck9bSlMaISXZGCTkv4ZK5wjaA=;
        b=xabJSuvfnWQ37OhcxWukJ0rXnPEPPnqpfPEl3xZ9fab+kcs6mpfL4TM7e8zIRCjW/4
         cbyiT9qL5tOjl1arDVGpYqSYxESw8hMGf8evAiiZNAOcFams9kls907jCDm/PHJVZuqW
         7a7rIklVAFSV41LWtX/EIADWfNc+dAJA73ppMk9wHuxfVHBAerHdJAVsHQnCr30BNUcT
         gSPhyTZv0MaH6gyT857R0bCz0/kFmca+6WP5vcuxbxTCLZGZrZokHL/U8qKY8LSBk4Ly
         gyHCSC86sq5RuEvEJzyYg62jNjnv75DBnfJCDMB8IwQ03o3CSs+cftV9AgKTewri8keA
         tb7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=c4gMj6DLk69LRUfrPQck9bSlMaISXZGCTkv4ZK5wjaA=;
        b=Drhgy14OrtOaYok9WBM3rGLaVvkq9aHCfY37dBCr7HPWKfXXwgYOoEXtuTeOoNMuO9
         WLYYaxo+3dam/dyQk9QU8yAwoJA7+gkXkn4XOu+wmNB2DZylRZZvY8pZq9fi+PDY2BOH
         prBj3Iwho4uPrE7WAHnZJxQVbBRPnP9eTGi1z0IlzrvKcAviz+XIu2N3IY5mEI6yEUMv
         o2r48nypckOErFU9BWGASzSVhRM6CvYYwdWYEJBfZNJ60NdUid7s4nvv2gixrB2l28FX
         /Mmwkk33vQsefokEVWy640NNbpNLTerYXy783TwphcolF41HJDBBQIUhH5cZWH0V/hV6
         2dCA==
X-Gm-Message-State: AO0yUKWPrUMbuzulJMfxAVznO71G4ahdIcKJfii1S54peDrf3BwHHmgg
        NiwAxpbeoI6n+f2Nr4BTAlGHnQ==
X-Google-Smtp-Source: AK7set+dmnC8fFHSMMpTa9TbZ82Axtabej6jsHRu8DYMsSuwhXURadcSWX18R3jADIv3rFMAblj0Sw==
X-Received: by 2002:a05:600c:1688:b0:3dc:573c:6601 with SMTP id k8-20020a05600c168800b003dc573c6601mr20411857wmn.36.1676285662715;
        Mon, 13 Feb 2023 02:54:22 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id j23-20020a05600c1c1700b003daf681d05dsm14507052wms.26.2023.02.13.02.54.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Feb 2023 02:54:22 -0800 (PST)
Message-ID: <28f16bc4-a1a7-9345-10e8-e292b94420a7@linaro.org>
Date:   Mon, 13 Feb 2023 11:54:20 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH 2/6] dt-bindings: soc: amlogic: convert clk-measure.txt to
 dt-schema
Content-Language: en-US
To:     Neil Armstrong <neil.armstrong@linaro.org>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     linux-rtc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org
References: <20230209-b4-amlogic-bindings-convert-take2-v1-0-c4fe9049def9@linaro.org>
 <20230209-b4-amlogic-bindings-convert-take2-v1-2-c4fe9049def9@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230209-b4-amlogic-bindings-convert-take2-v1-2-c4fe9049def9@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/02/2023 14:41, Neil Armstrong wrote:
> Convert the Amlogic Internal Clock Measurer bindings to dt-schema.
> 
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> ---


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

