Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44E1F6C9C6B
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 09:40:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232700AbjC0Hkm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 03:40:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232647AbjC0Hkh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 03:40:37 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A5C34C32
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 00:40:14 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id j18-20020a05600c1c1200b003ee5157346cso6658104wms.1
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 00:40:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679902812;
        h=content-transfer-encoding:in-reply-to:organization:references:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=ClBOj0gK1ahT7UCzB1KKn78jhUJGd6/ThX8Qzeq7fl4=;
        b=rkmmZgxto45TV5TxYS3lbMJdrFAD+Y5TOh+x/fv77Bv2IZE3RvXg+GOWS+SkDCpNDl
         Qv0tTi7xSwYLhxUy+kaMoElTho4JRiEPruE3gOz4SfuNqDAS3FV6qxnmCWbeajELqm1u
         SlrWJzE93kFMDTptxyh2v7cmkHIrsAjYUX+jBgamFaw1AJ+VGXfX1058zcsjmPVq78k4
         WM6ub73hbp8v4jLiCQ1EcsD0i+ltTicD2u3S8xISdk7ORn4UYukO1r42iZQxBbn4dgH5
         6M0+VK0paAYS277slAolKZPQ/ghiXgcUae4jfRI7C9Q5sJJzHyRDvDU3NUyjY6WYuwQy
         Wu0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679902812;
        h=content-transfer-encoding:in-reply-to:organization:references:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ClBOj0gK1ahT7UCzB1KKn78jhUJGd6/ThX8Qzeq7fl4=;
        b=QK0nB+f7mxc07QFWnRNQG5FI23suk5ppFs+X7hssc4TRCEtuJKTPIzT1y9QvHGbCU1
         OJaKLbmx0ZVjAVgefjSFV9mQh0IehRit7dtzAdRuctyPLkl+QhHumknkUzQluK+8a8oE
         zvcJkJ9Y6/zrOFaLJTLRXACcwJTP+LlJqwKp9m5Kp4iYiGwS3muCSqE+nSrpA3fguPux
         Yrb+hU0cI9Dd7VRhAPSm3JvebzNYBc/RuGaTGDJi57fj0YnbNIl49J/cpohrlICztQfq
         2HyMOhDK6SMj0NyrJmjHEfW9Z+hGu7rdruz/QS1avlu/vNzrDQ9Gk7BeXSTukCT6prQC
         3CWA==
X-Gm-Message-State: AO0yUKXj9OmLsG2iVrxkrfkWf0GM+RwtGSa95JlrPgur1+qBGshPFeQ1
        HH9gQnjAPuGUtRH3+yd5qloNUA==
X-Google-Smtp-Source: AK7set/HbomPUYJYpvAz8cosQ1bhr1ic2igEN2YfjSfVteCKmqlgQXoWWUqdknydjiR2gEP3SPDJiA==
X-Received: by 2002:a1c:f418:0:b0:3ed:8780:f265 with SMTP id z24-20020a1cf418000000b003ed8780f265mr8940924wma.21.1679902812220;
        Mon, 27 Mar 2023 00:40:12 -0700 (PDT)
Received: from [192.168.7.111] (679773502.box.freepro.com. [212.114.21.58])
        by smtp.gmail.com with ESMTPSA id n20-20020a7bc5d4000000b003ee10fb56ebsm12796925wmk.9.2023.03.27.00.40.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Mar 2023 00:40:11 -0700 (PDT)
Message-ID: <3c30663c-e78b-388a-5822-932434436a4c@linaro.org>
Date:   Mon, 27 Mar 2023 09:40:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
From:   Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH] dt-bindings: display: sitronix,st7789v: document dc-gpios
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Maxime Ripard <mripard@kernel.org>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230326164700.104570-1-krzysztof.kozlowski@linaro.org>
Organization: Linaro Developer Services
In-Reply-To: <20230326164700.104570-1-krzysztof.kozlowski@linaro.org>
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

On 26/03/2023 18:47, Krzysztof Kozlowski wrote:
> The device comes with DCX pin which is already used in
> canaan/sipeed_maixduino.dts (although not in Linux driver).
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>   .../devicetree/bindings/display/panel/sitronix,st7789v.yaml   | 4 ++++
>   1 file changed, 4 insertions(+)

<snip>

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
