Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C902E734059
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Jun 2023 12:45:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233620AbjFQKpD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Jun 2023 06:45:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235082AbjFQKnU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Jun 2023 06:43:20 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2740D10DB
        for <linux-kernel@vger.kernel.org>; Sat, 17 Jun 2023 03:43:19 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id 4fb4d7f45d1cf-51a4044b7a1so1803321a12.2
        for <linux-kernel@vger.kernel.org>; Sat, 17 Jun 2023 03:43:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686998597; x=1689590597;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SXehPHfp4hD58zuOBHpI3CN7ZUjU79jauVD9+CTL9CU=;
        b=v/5eAneTfiOB6RtTochY284msjQvoPq6a4pZgXDJuLXT70Wi1NKtsfoCOmebDSRwGw
         9xwMFYw4JDSFzzDLdiKFaEYKaP55sLzzpy3DX2rd8eYhzL0NEXLCB+EJ99YzNwlky3kW
         ngmYmxg/RuPQdw0kWxG4SYpQ66dUDsKoc9LH4dgJPsPznX59YNwWz/Hdi9ldxMcOgYQy
         ehjmkv1au49VmSREY6VLfRRBQEYdhQE90/u7DHHUUK2CPpma2YYRpiTRSmdasEj5AUGk
         VIYTlu8VXoibu9ti6g97DJCOEKI5J2DV7MGgu80iGu83kc8h803oJFu1IZRUpBC3I5Q3
         I3ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686998597; x=1689590597;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SXehPHfp4hD58zuOBHpI3CN7ZUjU79jauVD9+CTL9CU=;
        b=LNobHpbyGMwQjIhizbudToHfjadyvIC/pEe9cb2t9aDtyeZWKpEMFjxG3K0LuKupG/
         AqBMtmBjTpnWZdkyaOw4c6DqQsctrXbkhti2YgXj9D3rtpwhOyyPZzcrqS2WrfNWrx4Q
         A2qpaSxeUmP/ovj1bPVBKFmkFqKDmyXrDfEQQlGSqDvvnCvXO4OoitBH8Bg4wtZOTPoM
         uf0D3J+FIk4TUw+Y6wRGoSFCkkHTHh1t7PlcCIxr3WhhjC2zsOI2tlfTWOa0zuYAq0k/
         p82Q8BhXZIk0ZLtwk/ZrImCwaCIxWWQQ7Y2L+m4MQMfIwS0EfmQDAuAyPrIcEodVTY6j
         MRBQ==
X-Gm-Message-State: AC+VfDzw2su9SIIYBHmV5yZyBsVYGmHI2JntuJCH06MnzSfB2qrF+IdT
        btNnZfg6Ny2XFCMkbE8NXLUjuA==
X-Google-Smtp-Source: ACHHUZ5mNmonmeX1pj58nQ8JJHbgPkGUtqFcLoO43kCROLgIVGLDO/BjBAkgHRjsjF0V8RgZ50iQ9w==
X-Received: by 2002:a17:907:16a6:b0:978:66bd:d771 with SMTP id hc38-20020a17090716a600b0097866bdd771mr5423085ejc.55.1686998597567;
        Sat, 17 Jun 2023 03:43:17 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.219.26])
        by smtp.gmail.com with ESMTPSA id z20-20020a1709064e1400b009745eddf997sm11789464eju.198.2023.06.17.03.43.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 17 Jun 2023 03:43:16 -0700 (PDT)
Message-ID: <168b28ba-cc37-84a1-2b1f-a045525b50a1@linaro.org>
Date:   Sat, 17 Jun 2023 12:43:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [RESEND PATCH 1/3] dt-bindings: remoteproc: qcom,pas: correct
 memory-region constraints
Content-Language: en-US
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>
Cc:     Neil Armstrong <neil.armstrong@linaro.org>,
        Bhupesh Sharma <bhupesh.sharma@linaro.org>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh@kernel.org>,
        linux-remoteproc@vger.kernel.org,
        Manivannan Sadhasivam <mani@kernel.org>
References: <20230331092125.44885-1-krzysztof.kozlowski@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230331092125.44885-1-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 31/03/2023 11:21, Krzysztof Kozlowski wrote:
> Qualcomm PAS devices expect exactly one memory region, not many.  Also,
> the memory-region is now defined in device specific binding, not in
> qcom,pas-common.yaml, thus also require it in the same place.
> 
> Fixes: cee616c68846 ("dt-bindings: remoteproc: qcom: adsp: move memory-region and firmware-name out of pas-common")
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Reviewed-by: Rob Herring <robh@kernel.org>
> 
> ---

I sent it in March. Then on 31st of March I resent it. Almost three
months ago.

Shall I resend it one more time? Any comments? Applying?

Best regards,
Krzysztof

