Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C36E7731A39
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 15:40:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239957AbjFONkp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 09:40:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238906AbjFONj1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 09:39:27 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C86DF3C19
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 06:38:13 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id a640c23a62f3a-9745ba45cd1so265152666b.1
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 06:38:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686836253; x=1689428253;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mYo4mo9LxJ5Bb1u21M6AxJhHfaaBpi4Yfj8oS2RZGik=;
        b=gwnpCAL+9XD9YTcrhW22JHHze+0ln59G79fG0PbzPCPkUume7cpPMe9N1MpVazB8T0
         1VNcvHhrMsDbjcPaCwwELzdmSj2CInEWwxUmLYNOwRUXECqbkD21NOCA6zL0LkId1xTe
         Jmz5KNhEGQlTF8AQJe7uUwDQ4+pi/99NutlpmFMGKD3/SppKORWaGtI+PmV14ZbcTUXg
         SQ/xFGrRUrJug8frUn3FxCFoHdEvGjOv0zxfZtED6wTv76W+YYbrOe0XjczsTNc6FnX6
         BTbrSi6sWw9Hr8PLExxfqiIVT6LsvR3Q/5vN6OlV0JnK2Yv0FbMnNpMYEzZJu4bCBpMD
         RaPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686836253; x=1689428253;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mYo4mo9LxJ5Bb1u21M6AxJhHfaaBpi4Yfj8oS2RZGik=;
        b=NHaUZ9tCjMWK22SY2aGcZj2+TCdEjTTrs0VW7yZCgF7x6rFo81rCb/jS3wm/n04oh8
         9s5iy5BOTsBJSKJnWyKxypeDBNwblV4JO/MwpgXeGrslpUu2gkL+eUwVvaSm/ctJkeMV
         9dNlEF+uUTYcUul2dqYDTd+BogK5nAagYZPxfKksJZrVX8ehT0I1UqcgD0Ag7YRyPGKX
         O8kyHAtriYaSfu8R/OHH7kF9uBjRm8uaF4GESRAH9+AFuz5YP5WJ6/5uqaC4nVzMq13F
         m+O4kT1OTON+z6y9oQVR5Ye6yKZ2ht7WaxU23pIdcPEBiT1yUdw2EZHS/4lPCOi1JCQJ
         xbQw==
X-Gm-Message-State: AC+VfDzrnXrukpccKQaMYYEAkumFlqI8w5Trj+g5SP5x8E1nBxDPIUeM
        eO0+QI3ByxtFUheUIL/0juX+Zw==
X-Google-Smtp-Source: ACHHUZ4+n13L4jhgYrrrc4ptTI3RmwMq1dwvCZV4MDbjtdu4sLMN7fnVBOOcDFGxP2/w6+shDoBlfg==
X-Received: by 2002:a17:906:6a07:b0:982:a376:1d3f with SMTP id qw7-20020a1709066a0700b00982a3761d3fmr1542823ejc.41.1686836253221;
        Thu, 15 Jun 2023 06:37:33 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.219.26])
        by smtp.gmail.com with ESMTPSA id d23-20020a17090648d700b00982c84e5dadsm196414ejt.170.2023.06.15.06.37.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Jun 2023 06:37:32 -0700 (PDT)
Message-ID: <b326151c-24ed-e603-d1c7-3ebe8dbaa6c4@linaro.org>
Date:   Thu, 15 Jun 2023 15:37:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v2 17/23] dt-bindings: net: qcom,ethqos: add description
 for sa8775p
Content-Language: en-US
To:     Bartosz Golaszewski <brgl@bgdev.pl>, Vinod Koul <vkoul@kernel.org>,
        Bhupesh Sharma <bhupesh.sharma@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Giuseppe Cavallaro <peppe.cavallaro@st.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Jose Abreu <joabreu@synopsys.com>
Cc:     netdev@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-phy@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        linux-stm32@st-md-mailman.stormreply.com,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
References: <20230615121419.175862-1-brgl@bgdev.pl>
 <20230615121419.175862-18-brgl@bgdev.pl>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230615121419.175862-18-brgl@bgdev.pl>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/06/2023 14:14, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> 
> Add the compatible for the MAC controller on sa8775p platforms. This MAC
> works with a single interrupt so add minItems to the interrupts property.
> The fourth clock's name is different here so change it. Enable relevant
> PHY properties. Add the relevant compatibles to the binding document for
> snps,dwmac as well.
> 
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

