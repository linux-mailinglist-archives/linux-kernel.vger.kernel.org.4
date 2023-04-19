Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E98AC6E757A
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Apr 2023 10:40:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232758AbjDSIkH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Apr 2023 04:40:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232532AbjDSIkF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Apr 2023 04:40:05 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60B566E9D
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 01:40:04 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id b16so4338734ejz.3
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 01:40:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681893603; x=1684485603;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=22bAOLCz/Hy85xNiRLfskrgiPMdU7+7siODBKDyg0pM=;
        b=Roj6MyT9vIcHinFEsCO2tp5BU2nLbWl5k4IXdVB6bc+f7ht4jujN6z1Bmxd9qQ8qn2
         zFtB1wqbtsQ27dsrF9B5aagcbpMvEYG8vwTwCO5VIueFo2JjRNY1Gu4HL747upNNJuyz
         HKF08W5gs/S+XpR7VCZsrSWmDzq0PZbwV0X0NTDRAYUn39hxCKgPumQkrxJtDt3gOk0j
         vzLcwOFqPodX16rUDhNyEzInj6L39Kdsg93yQ1sZn5lpzFwy9U7bVPDx9ove2XxNyPo7
         xsV79+2rVWIu2BARwcEa9yzoXurcaUk8k1+wK4H9Xd3BX3rL52Hm4dHvc+nKwrezfPv5
         H+Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681893603; x=1684485603;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=22bAOLCz/Hy85xNiRLfskrgiPMdU7+7siODBKDyg0pM=;
        b=MbHpNAvXxIbPyNpKBpEymNK+BE6DpDFcCA5zCVLO0Ud1f2a/zLzLB8z4ABpSnNX9JU
         pm9TvR8gQwvSP344Z39FniiMKFI0gZ84FrerDpMLaR1RolhN6uDj9EBwtUQVul+u/duV
         21AVClF7Yl/xnZGeNiJBex5CV2uf6YTLuE0mZGl2yHo0WQVjq/p7+UkPNE1D21UKQG80
         /nM5Xc8CQR1X2RjHXICLzWw8GZEo0XJRrT10hap3Se9oCmGUS86CedsXSLUVY7WlnIvm
         LlU6U6ejE9KlT0AoSqmlwfCyInn2EzkPR4X3rcW0nA/4a1T/+3KGXv0FWRLiHKMtmCvR
         mzHA==
X-Gm-Message-State: AAQBX9fjr22mRo1RXe3mI6r8tqTLTv1mrdc+BUQEtRjqX/Up6eXmICl6
        is0zU/pQm5Q6VBULDG3m3IXXNw==
X-Google-Smtp-Source: AKy350b+cfnZW26IV+4t/7ysLlAr1MEF2r2CKzPqtzi5Sg7f4/mQ3aCj9ZIau1Rp/s/ffwbV1c+uHg==
X-Received: by 2002:a17:906:80d4:b0:94f:247d:44d2 with SMTP id a20-20020a17090680d400b0094f247d44d2mr12482285ejx.5.1681893602752;
        Wed, 19 Apr 2023 01:40:02 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:62f5:eb43:f726:5fee? ([2a02:810d:15c0:828:62f5:eb43:f726:5fee])
        by smtp.gmail.com with ESMTPSA id b1-20020a170906038100b0094f5f6ba306sm4636696eja.41.2023.04.19.01.40.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Apr 2023 01:40:02 -0700 (PDT)
Message-ID: <f80fcbeb-f916-63da-a5c3-f80f6315f3e0@linaro.org>
Date:   Wed, 19 Apr 2023 10:40:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v2 5/9] regulator: rt5033: Change regulator names to
 lowercase
Content-Language: en-US
To:     Jakob Hauser <jahau@rocketmail.com>
Cc:     Sebastian Reichel <sre@kernel.org>, Lee Jones <lee@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Beomho Seo <beomho.seo@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Stephan Gerhold <stephan@gerhold.net>,
        Raymond Hackley <raymondhackley@protonmail.com>,
        Pavel Machek <pavel@ucw.cz>, Axel Lin <axel.lin@ingics.com>,
        ChiYuan Huang <cy_huang@richtek.com>, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht
References: <cover.1681646904.git.jahau@rocketmail.com>
 <d4218947e354aee45589acb1060ce41727a26750.1681646904.git.jahau@rocketmail.com>
 <19ceb0f6-1225-c8cb-1469-3d657e66d171@linaro.org>
 <e6cc8658-fe93-c2c0-603e-093cdafb3cca@rocketmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <e6cc8658-fe93-c2c0-603e-093cdafb3cca@rocketmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/04/2023 23:24, Jakob Hauser wrote:
> Hi Krzysztof,
> 
> On 16.04.23 20:32, Krzysztof Kozlowski wrote:
>> On 16/04/2023 14:44, Jakob Hauser wrote:
>>> Lowercase is preferred for node names.
>>
>> This will break all existing users. In-tree and out-of-tree. Where is
>> the binding update?
> 
> In my reply to Rob's comments in v1 I was pointing out that this will 
> affect an existing driver. There was no reaction.
> 
> As far as I can see, there is no in-tree usage yet. Though I can't tell 
> about out-of-tree usage. Although if there is, adding the rt5033-charger 
> driver might already causes the need for changes.
> 
> Well, to stay on the safe side, I'll drop this patch in v3 and will 
> change the bindings (patch 9) back to uppercase.
> 

Your v1 binding patch did not explain that you document existing ABI, so
you got comments like for a new binding. This is not really new binding,
is it?

Best regards,
Krzysztof

