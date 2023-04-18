Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B2326E5A79
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 09:30:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230369AbjDRHar (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 03:30:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230045AbjDRHam (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 03:30:42 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F53B4216
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 00:30:41 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id 4fb4d7f45d1cf-5052caa1e32so4788430a12.2
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 00:30:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681803040; x=1684395040;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rVgNSlQei7ClLmAXgHdLYMij5O05eDXWOobwGEh17DQ=;
        b=vR0c1V6fHjkOyv3+jlpqY5zM6LZj07DmVTLUWBjOaBOnR6s/0Baom+vEKaqJuhxeZ/
         Xc2D6F3qbZCYol/JMWRydydPtMlGMn5e+nfsLiGcOe5rc+35obwyzfmNe1GgK97zBtTt
         1Koogst0alt2YUOp73Y6GIQGW4PtGqo+3GIbQ5sYJDaUBLFX+vSBPMZa8Z6RiFe+5SP9
         yt3weQk73jK4zbBsH2P4E87ne3NJ2xeH/QFqzjwYBdS26g7e7C44okeVj6RGWC5JQhu+
         im64hz/ErmPn7+rNBHTtTkWqnC+09/Ynd1k5kWaNwVHcekfYvFmrb29OqVqmTdj8tHfQ
         sdLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681803040; x=1684395040;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rVgNSlQei7ClLmAXgHdLYMij5O05eDXWOobwGEh17DQ=;
        b=LVb12L0W4H5YA+WQI+DRk5L0D/+6V+PHsFnn3U7tB94/lSH0ylhyd+gdQ36SxBaCnp
         p5rQfwfHPk4aplmOc1QD5Tmz7skMonweBfEpBvhovDKNLgWq3ZPWLVQK9PSQ+aqgzGeV
         OTp0GIJ8TWsiWa9jJDhsZ55IaJi2P53dwCVZ5vJ8Fi3Z1kNjcPAIKotBj9d/s27QNCvG
         KMARz/5kRz0HYBX4jBVtziI95zuIlqXqXK2E16K/jLj/61kF636ih7iAhaI2h6jLMAOi
         9Km+UxYjv2/gQAuD0OTy/CXmdZC+OR8gdMPNSdK7t5WTcsLMU6dtmKr6reMwW7Q/yPoh
         0IJw==
X-Gm-Message-State: AAQBX9f5Sxiv8gIGFZcmndt3idhyskvn07Pp/U2w2N8k2xW0w8jNhhhh
        uEAfW99deh5YGylx4gwZ2jY3Dg==
X-Google-Smtp-Source: AKy350Zoyxpwx+/pSMVZgdFa6Mkl6usfBX3ptXBL+sCtn0/rIgDyyeOnSAiaOQ8GnTcResGJW+JT7A==
X-Received: by 2002:a50:fb17:0:b0:502:70e9:2c14 with SMTP id d23-20020a50fb17000000b0050270e92c14mr1498794edq.29.1681803039878;
        Tue, 18 Apr 2023 00:30:39 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:a276:7d35:5226:1c77? ([2a02:810d:15c0:828:a276:7d35:5226:1c77])
        by smtp.gmail.com with ESMTPSA id m21-20020a509995000000b0050684020babsm5369235edb.27.2023.04.18.00.30.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Apr 2023 00:30:39 -0700 (PDT)
Message-ID: <b28e6e12-6eb3-582a-25e2-34fa2f3544f8@linaro.org>
Date:   Tue, 18 Apr 2023 09:30:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH] dt-bindings: phy: qmp-ufs: fix clock and clock-names for
 sa8775p
Content-Language: en-US
To:     Bartosz Golaszewski <brgl@bgdev.pl>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-scsi@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
References: <20230417130522.401605-1-brgl@bgdev.pl>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230417130522.401605-1-brgl@bgdev.pl>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/04/2023 15:05, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> 
> We must set *minItems* to 3, not maxItems as this platform requires
> exactly three clocks and maxItems is already set to 3 globally.
> 
> Fixes: e5796a9cdf73 ("dt-bindings: phy: qmp-ufs: describe the UFS PHY for sa8775p")

Your change makes the code easier to read (more obvious), so I am okay
with the change, but I am not okay with commit msg and Fixes tag. Issue
is described inaccurately. There is nothing to fix here, because
original code was correct.

maxItems:3 in implies minItems:3, thus everything worked as should.

Feel free to re-phrase the commit msg and remove the Fixes tag.

> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> ---

Best regards,
Krzysztof

