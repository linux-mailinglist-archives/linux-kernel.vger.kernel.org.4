Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D65A96336A6
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 09:07:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232498AbiKVIHv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 03:07:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232591AbiKVIHr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 03:07:47 -0500
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3234520F43
        for <linux-kernel@vger.kernel.org>; Tue, 22 Nov 2022 00:07:46 -0800 (PST)
Received: by mail-lf1-x12c.google.com with SMTP id bp15so22395794lfb.13
        for <linux-kernel@vger.kernel.org>; Tue, 22 Nov 2022 00:07:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NNBiy73Ky6s4Xq1P4P+snI/nTErvmCWvtpQD99zJ0SI=;
        b=LHSe+kbTcLpxARwfFEx119iYaivSTRuG5ExvsZoPA6KWncV5+CPvC/HFa+Lou5jn6j
         42lDSjXqN6awYg8z9RY33lVkQAEbyupLooeinvQ0S/pl2bYkpE3+TpyreVRQO4QxjA5Y
         wxIz5res3tFXXhx8L3Xay2IVXsVDEcwTLDArQt8myLC7PvhKfNuTZ5yhZSKbbAC8i5xU
         fiuN+VfKdTZlRnwdLNnk2xwl1fEtEVXBky4JqELq4e7Kl69258h7pW+/lb232fwwGF+p
         66lUCQc9QSw/BbUrQJocj8+Rks9BUvcpX9AhRv5xffAD+WMYL9GzX+iZPwde8ye0DL0A
         7eKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NNBiy73Ky6s4Xq1P4P+snI/nTErvmCWvtpQD99zJ0SI=;
        b=tgCv73R3ZWi3EmKof2uKbEZ35+x0k+eYnePk+tNUjgjj81195s8F1pzm05PAErLX/L
         0ErnBvuMwLxo0Uyv/EGD3aH3psTqiXo9MOl30SrkiVCGTuG4YtaxHiz2ohr37NsV0oMB
         uLxX20pni63MT6grAPKqG8cwlxkxIQdmoTzLGY4DyapVClpyGZ5q5y0o/sSeHP2V6wV3
         tMjRNNlhHOJFsDie60b81qzfxXV7UmByF2eaNRCfdpNKzY6qFZ3BDS5H/PmF6TFKx/fh
         cgua4PFF9ktw5QkCwR1FIB2tiGN+38XsKTRArdFM+CnNx07OsJHgWFpYXf2iZ8Mw4dCa
         9qRw==
X-Gm-Message-State: ANoB5pnx1lJ1E52tDWkUgTAFPdOU/e/KwfVLy0dQUZKDkQzCcTxQzZD+
        Ly6lTJu46Sco6TxIushrS6L3XA==
X-Google-Smtp-Source: AA0mqf5a6fD6w+lRgPB9p3LF4P8bOM7CzHxRgvCuauj2Sm5SdLzl/NlJvFi0H6ciJ8fJVseiyLxwjA==
X-Received: by 2002:a19:7403:0:b0:494:9f2a:ab31 with SMTP id v3-20020a197403000000b004949f2aab31mr8433513lfe.457.1669104464520;
        Tue, 22 Nov 2022 00:07:44 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id j18-20020a056512345200b004917a30c82bsm105105lfr.153.2022.11.22.00.07.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Nov 2022 00:07:44 -0800 (PST)
Message-ID: <0da60261-f056-45bc-dbd5-9867b6d59976@linaro.org>
Date:   Tue, 22 Nov 2022 09:07:42 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCHv3 5/9] dt-bindings: arm: rockchip: add Rock 5 Model A
Content-Language: en-US
To:     Sebastian Reichel <sebastian.reichel@collabora.com>,
        Heiko Stuebner <heiko@sntech.de>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Christopher Obbard <chris.obbard@collabora.com>,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel@collabora.com
References: <20221121175814.68927-1-sebastian.reichel@collabora.com>
 <20221121175814.68927-6-sebastian.reichel@collabora.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221121175814.68927-6-sebastian.reichel@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/11/2022 18:58, Sebastian Reichel wrote:
> Add DT binding documentation for the Radxa Rock 5 Model A.
> 
> Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
> ---
>  Documentation/devicetree/bindings/arm/rockchip.yaml | 5 +++++
>  1 file changed, 5 insertions(+)
> 


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

