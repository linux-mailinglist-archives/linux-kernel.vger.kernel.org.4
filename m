Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EFC662931C
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 09:16:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231992AbiKOIQB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 03:16:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231966AbiKOIP4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 03:15:56 -0500
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F8791EC5D
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 00:15:55 -0800 (PST)
Received: by mail-lj1-x22d.google.com with SMTP id z24so16527613ljn.4
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 00:15:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lKNE4suE4Xq9bLfqtt7DRJYJuAXCcWCc8o+W/CVSbcE=;
        b=n0HJtSjX1I6FULGQvhFZpt0pxRXGBSbnI/NMT5fbB3fMn5h7d4qTLTOnXAychY3Z5U
         neUQgVhe8KKo1Es2Ege8S08gbM4v70vvs2X4hv3H5c49UIOw68RMnhykQhZNmZYNkuKl
         G4cUfxhWHjQ/aynpdnemuH/jSqFT5wwxbRWqcX36vEKO9YcZx9OkHa81YHZBdOp8IJ66
         aG8dO/gA4OHqpqfqtlCqcxKI8qdlEJlsXmKj06uZubAW/8VQwO03M1CSGl+HTMmLk4/z
         FVRO5cWlOuUis6v+w5/ieTtq2Cxvsw1mlObTCJsjdZMCDVjEgXdRS+nUM9SJ1shTUNhj
         o4jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lKNE4suE4Xq9bLfqtt7DRJYJuAXCcWCc8o+W/CVSbcE=;
        b=x10U8Y54EbHbS2POeFhjPjW+fnOM8kI8nd2MxZdi7Sr3VU5Dngo1JAmPWR7kqhxmHH
         9B/0S6Ipv+RnAQl9Le3j94ZlfU9i4RdFGe+lXXrBoW8lrFs45X/unQCJOnD1Y1GXAgRF
         CJgOhZGq3ENM5tdkiqpO7v10zh0B3Pqe2yMtIVsVQOi0E0ZbdW+3pY60yW3NdNl74wtE
         on3vYLHObWsaVtZuSLow7A/o18bbWYmJl0OLS8Kvk663/GkywweYbWq0f5IeU0HlUMel
         el76aMc/rnhJ5Tl9K2RJq8Amfmvjxi24e2uvSoJlv9p/DRay9rOdw5S0r5+/2fIabk+Z
         KZLA==
X-Gm-Message-State: ANoB5pn8Dpz5D+JFiC7Lf7+gxfCrm8pmKjyk0DlK26UhaeyO/AtTEttu
        3WW8lEFUiCR2zY0uO1lLfDjLrQ==
X-Google-Smtp-Source: AA0mqf6AOtcM9oAFJUYI7DC7+YNPPzruSzNsYADn099tCIhkzNGYwqIH/0wr7C9PTQ8R+U9gvZ+47Q==
X-Received: by 2002:a2e:711a:0:b0:26d:e647:dabb with SMTP id m26-20020a2e711a000000b0026de647dabbmr5673338ljc.134.1668500153379;
        Tue, 15 Nov 2022 00:15:53 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id j29-20020a056512029d00b0048b365176d9sm2107058lfp.286.2022.11.15.00.15.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Nov 2022 00:15:52 -0800 (PST)
Message-ID: <450262a9-d9fd-b686-f64c-2cb339c9480a@linaro.org>
Date:   Tue, 15 Nov 2022 09:15:51 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v2 4/5] dt-bindings: net: ipq4019-mdio: document required
 clock-names
Content-Language: en-US
To:     Robert Marko <robimarko@gmail.com>, agross@kernel.org,
        andersson@kernel.org, konrad.dybcio@linaro.org,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-arm-msm@vger.kernel.org,
        netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20221114194734.3287854-1-robimarko@gmail.com>
 <20221114194734.3287854-4-robimarko@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221114194734.3287854-4-robimarko@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/11/2022 20:47, Robert Marko wrote:
> IPQ5018, IPQ6018 and IPQ8074 require clock-names to be set as driver is
> requesting the clock based on it and not index, so document that and make
> it required for the listed SoC-s.
> 
> Signed-off-by: Robert Marko <robimarko@gmail.com>
> ---
> Changes in v2:
> * Define clock-names under properties and disallow it per compatible
> like clocks
> ---


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

