Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20E516FA338
	for <lists+linux-kernel@lfdr.de>; Mon,  8 May 2023 11:26:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233608AbjEHJ0n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 05:26:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233367AbjEHJ0k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 05:26:40 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81C83191C2
        for <linux-kernel@vger.kernel.org>; Mon,  8 May 2023 02:26:38 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id 4fb4d7f45d1cf-50bc0117683so7850472a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 08 May 2023 02:26:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683537997; x=1686129997;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MiCCw6JVpqLvBjxuPw1yzCHzKR/sVakiwZutl82ltXI=;
        b=m9j3yNB/3j3E/6fpurCNLFASZERGHi46OQt8kzyW9FNlCQ1FNT2GhqeqzkgnwNp0bv
         lw1gBq9VdCQKkLzQRSqETJxJLMMy3swM+q/f3uF3Nkx3x+Tn1s1YcvrCigyW/Iz/9pVu
         HiOfeFM3VG36hNPUEcLEmYl7mVxJP0FxMaFs7Np7IfVzK47SgiuD3/PVGPXd2L/JBAOo
         8jNVmbkaQ8f6+qPEnzjIEkWBfmFUKSarsZjwAzQ22pZDHAkP/h9tjrVOH05Sgpy9a01J
         prvhC+u28HxUK8MtETLvXyKbbbH5St35kNER3QA3rrVDEkVm+KqT9x3uWKvN4AtkmnLM
         ht6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683537997; x=1686129997;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MiCCw6JVpqLvBjxuPw1yzCHzKR/sVakiwZutl82ltXI=;
        b=V5LfTuehVAYXH4HgICGqo5pmbGR7t8VJ47sK2M9NuZX9AEFDQ+QVJt7BQSpIlqNgLD
         UmEwCxVo0WliOdEuKRKTSVHctcjF41OLeEY80SjzrgNvzw78vCv7Z+9QLBCenzm43bCO
         t92BjuIzr1mEY7bn6WdmuUsVJ3+lWIYrKupipByAN6baZbLPX2bgi0KF8WWObOcUDfAG
         p0Vc3Hunkm3v7w9WeF08ieYOaYfWJ6EraxXAwYApuEQzIgzkWWN/XV/txgi9YG4q4D1M
         6tEtQHPZdpR/Agy9UMjqw8svTcXxcq285oaw1DlMdAxPQCo6HWBLVLatNjIlAapK3Ea0
         mLtw==
X-Gm-Message-State: AC+VfDzM5JEOMbuRMVPj3ZAZuP46andvs2ki6wQ0K42K+Eha01VnbEKL
        jSIaKn9h3VIXP6JRW4uTpBYh3g==
X-Google-Smtp-Source: ACHHUZ4oSPt/qB3Tyl8i9/yHcjt2sV4nl/PsiHtr0b18C6HMzsQHpCse2qMCin1fQ33JLgiu0JjN+g==
X-Received: by 2002:a05:6402:28d:b0:506:fcd5:6159 with SMTP id l13-20020a056402028d00b00506fcd56159mr7754402edv.21.1683537997025;
        Mon, 08 May 2023 02:26:37 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:50e0:ebdf:b755:b300? ([2a02:810d:15c0:828:50e0:ebdf:b755:b300])
        by smtp.gmail.com with ESMTPSA id f18-20020a056402151200b0050daa883545sm578585edw.64.2023.05.08.02.26.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 May 2023 02:26:36 -0700 (PDT)
Message-ID: <1da9fbcb-07c7-5bf8-4461-dc6578101f84@linaro.org>
Date:   Mon, 8 May 2023 11:26:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v3 1/2] dt-bindings: gpio: Add STMPE YAML DT schema
Content-Language: en-US
To:     Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        linux-gpio@vger.kernel.org,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        Steffen Trumtrar <s.trumtrar@pengutronix.de>,
        linux-stm32@st-md-mailman.stormreply.com,
        Philippe Schenker <philippe.schenker@toradex.com>,
        Stefan Agner <stefan@agner.ch>, linux-kernel@vger.kernel.org,
        linux-input@vger.kernel.org, Marek Vasut <marex@denx.de>,
        Lee Jones <lee@kernel.org>
References: <20230426-stmpe-dt-bindings-v3-0-eac1d736e488@linaro.org>
 <20230426-stmpe-dt-bindings-v3-1-eac1d736e488@linaro.org>
 <168349835606.3623231.4270033272905089508.robh@kernel.org>
 <CACRpkdZsC6s3MjX5Mkr5u763CYSAotJKcK5wZMwCQxgEzvw+vQ@mail.gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <CACRpkdZsC6s3MjX5Mkr5u763CYSAotJKcK5wZMwCQxgEzvw+vQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/05/2023 08:30, Linus Walleij wrote:
> On Mon, May 8, 2023 at 12:26 AM Rob Herring <robh@kernel.org> wrote:
>> On Sun, 07 May 2023 23:19:19 +0200, Linus Walleij wrote:
> 
>>> This adds a schema for the STMPE GPIO that while it is used a
>>> lot in the kernel tree is anyway missing its bindings.
>>>
>>> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
>>> ---
>>> ChangeLog v2->v3:
>>> - Use a compact hog node schema backed by the standard hog
>>>   schema.
>>> ChangeLog v1->v2:
>>> - New patch split off from the MFD patch.
>>> ---
>>>  .../devicetree/bindings/gpio/st,stmpe-gpio.yaml    | 51 ++++++++++++++++++++++
>>>  1 file changed, 51 insertions(+)
>>>
>>
>> My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
>> on your patch (DT_CHECKER_FLAGS is new in v5.13):
>>
>> yamllint warnings/errors:
>>
>> dtschema/dtc warnings/errors:
>> /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/media/i2c/ovti,ov2685.example.dtb: camera-sensor@3c: port:endpoint:data-lanes: [[1]] is too short
>>         From schema: /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/media/i2c/ovti,ov2685.yaml
>> /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/media/rockchip-isp1.example.dtb: camera@3c: port:endpoint:data-lanes: [[1]] is too short
>>         From schema: /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/media/i2c/ovti,ov2685.yaml
>> /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie-ep.example.dtb: pcie-ep@33800000: Unevaluated properties are not allowed ('assigned-clock-parents', 'assigned-clock-rates', 'assigned-clocks' were unexpected)
>>         From schema: /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie-ep.yaml
> 
> Looks like these are not mine...

Yep, these are coming from other issues, now happening in Linus' master.
I fixed the PCI and I will send it together with the fix for media to Linus.


Best regards,
Krzysztof

