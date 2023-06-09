Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FCCC729F8B
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 18:02:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237994AbjFIQCV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 12:02:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240758AbjFIQCS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 12:02:18 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0766E2738
        for <linux-kernel@vger.kernel.org>; Fri,  9 Jun 2023 09:02:16 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id 2adb3069b0e04-4f649db9b25so2511945e87.0
        for <linux-kernel@vger.kernel.org>; Fri, 09 Jun 2023 09:02:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686326535; x=1688918535;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/diqD3NpPKvrdT/PglDaUindrvAF9YnnJpjqcDLQuwk=;
        b=OaT2/2lykBok8kG0mFvLWbuL/Di1Xsf0YerFWCD0stGaF0Y45ENM3HCnnOqW08gYK1
         hmOh56lZr5Uy22pSztUzgxykKIbk9mUpPlzQcFcfU0GLtzZ4SX5RNzIIqPjFokdZ5Yes
         ayCdkyNoAwBeGxLog9cjCHqZn/YIcQOIhV2Xxe6ENYdZ32PCsgdo+6GK8pvbD+1lZ1Dm
         o+IMxYmll1OstqC/vds+u7J48Ec7rCywqWN4uPf1OiqGbwvd7CVPup+ZgW8wX1EPixlY
         p3v7G+rMcRS+JRNLLl05npjklYeh54gOFfC1hhPbTQ+d9O3rivnq7c6hNf0AtbrfbHVT
         Uqgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686326535; x=1688918535;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/diqD3NpPKvrdT/PglDaUindrvAF9YnnJpjqcDLQuwk=;
        b=Vk30aOte2g69Adu6v+fk9PkwAj5D7MUXjE7gKrPlnRZqbT0Jabf+5sBsgiXUtAnK0e
         +DiyMY6iEIx7VzV254TT2dTeDY21/DB78/UYT/vqwDb8a/uISMpH1geUHcgLw0SlTlyp
         4q18jThxGAQm/Kda86nV+5Ryg6hZBNDEC2a9e95HSgI5vndvPExQBwGtYyHzgsC5oZab
         sahKJbmFVntDa49G/06Ptow8Ty7sDICXQlDdZsS/LBxljx0XB3idOCVHU9gsgaEujuF0
         +xk9p5H4p+MEIDtgKmGwvsdBvtOlmUQ37yt1V+GPr7UbPwpugHNDmcjvPrgOQ4rdnoAY
         ylug==
X-Gm-Message-State: AC+VfDxZbnGvQb5FHdI8fNr95mdxChAkUJoKphJ/9yCSbG1tIvv8NemO
        5GIEuTnIJaWEdmD2FFlDZ4fNZw==
X-Google-Smtp-Source: ACHHUZ54W2dUrKBXAiqlJt0QoNgmLYGw7d1WXAQZNwq6F8mPGyjFDj1+/qnaCYkQz70ENTuhZHDrsA==
X-Received: by 2002:a05:6512:521:b0:4f4:d071:be48 with SMTP id o1-20020a056512052100b004f4d071be48mr1523652lfc.14.1686326535092;
        Fri, 09 Jun 2023 09:02:15 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.219.26])
        by smtp.gmail.com with ESMTPSA id f9-20020a056402068900b0051495ce23absm1903726edy.10.2023.06.09.09.02.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Jun 2023 09:02:14 -0700 (PDT)
Message-ID: <9b09e358-ef9c-1242-4077-c5ad97bbb9ff@linaro.org>
Date:   Fri, 9 Jun 2023 18:02:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH 1/9] regulator: dt-bindings: mt6358: Merge ldo_vcn33_*
 regulators
Content-Language: en-US
To:     Chen-Yu Tsai <wenst@chromium.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20230609083009.2822259-1-wenst@chromium.org>
 <20230609083009.2822259-2-wenst@chromium.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230609083009.2822259-2-wenst@chromium.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/06/2023 10:29, Chen-Yu Tsai wrote:
> The ldo_vcn33_bt and ldo_vcn33_wifi regulators are actually the same
> regulator, having the same voltage setting and output pin. There are
> simply two enable bits that are ORed together to enable the regulator.
> 
> Having two regulators representing the same output pin is misleading
> from a design matching standpoint, and also error-prone in driver
> implementations.
> 
> Merge the two as ldo_vcn33. Neither vcn33 regulators are referenced
> in upstream device trees. As far as hardware designs go, none of the
> Chromebooks using MT8183 w/ MT6358 use this output.

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

