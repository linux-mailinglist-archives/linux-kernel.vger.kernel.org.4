Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FAE5608266
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Oct 2022 02:01:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229695AbiJVABi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 20:01:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229911AbiJVABe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 20:01:34 -0400
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4A0B317D1
        for <linux-kernel@vger.kernel.org>; Fri, 21 Oct 2022 17:01:32 -0700 (PDT)
Received: by mail-qk1-x72a.google.com with SMTP id a18so3103385qko.0
        for <linux-kernel@vger.kernel.org>; Fri, 21 Oct 2022 17:01:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GXvPkVCw8FRFmA8ySfXC7nejZPHHphE93ffpATw2tRY=;
        b=TfXedZrCGFSna9xyPTV/xvgw7TKxSngElCFlu4JbD3CLtC6IdwAYHrQoBpqvKV00sA
         JvPIs5jyXU11AGgXgY3a7dEH5r6/IJP1hMYcjpd/Pac4mvcHpCMo0fdUmKGLfbjeEZ2u
         Qd6lnaxRDQLfq0zPrkcybd6qJ4KF8sMcyfXGsACxl5lP9ZR59tFHzTn13l61cMqHd4W0
         kqTCRiE3X8aM/JpY7XCf7ahCcbLpj8ju6WvC935Lk8dCaiqFQ16zICG/S/XDGhyHeQ55
         h+cskEIfg6nuSL9XLMhcJJiJ3Z1soe2mCEKpUQq03/T5+Rn0FAEuaUFb52V/f/OH3W1U
         bPlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GXvPkVCw8FRFmA8ySfXC7nejZPHHphE93ffpATw2tRY=;
        b=zoxG+tu8abGIF0x+tjAE3/WbnqTkApINT58kqKKswlDsNARC7Dz+oHpuLOb0n0DQo3
         iiS/hBSqVn/xk/LsZ1VEbl1LTocaq8PyDEVC30DIO6kp6L+QOP/l894MvpRrQrSPaN4c
         YygP0uzzcL8NBulxnDF5P2xwmm3tKrG0jrqUWGEJMB3pijEcCSVBiAm9dPQFF8wz9DAV
         Rf0cZsdcqbZ3K9CVmpiWlR+bWWm/4WjPimIl02BP5TLIeESnTyKJcghK6rfZ/5LtrUJg
         1EZi0FT22gfJ0cMBxaDrDtZvucIbPxnCFVhbaI6/4vWsSTg0xS9UjIBrf3LlhG5r3YmH
         Q5Eg==
X-Gm-Message-State: ACrzQf3a7U/Yoxn6dfbvtY3Ow3KJIZTHwLwnQzDgmxgHbemIAJkNbec5
        rn951V0wthPEiICEMDVusCNbJg==
X-Google-Smtp-Source: AMsMyM6J4oBE7EMIcpdcRXotHEo1gC0gFNjHI7KVnii0fQSaj2GCJBXKMqu/I44iaEs6U500Ld379w==
X-Received: by 2002:a37:a42:0:b0:6ea:f8ec:1648 with SMTP id 63-20020a370a42000000b006eaf8ec1648mr15741126qkk.231.1666396891836;
        Fri, 21 Oct 2022 17:01:31 -0700 (PDT)
Received: from [192.168.10.124] (pool-72-83-177-149.washdc.east.verizon.net. [72.83.177.149])
        by smtp.gmail.com with ESMTPSA id m10-20020ac8444a000000b0039b03ac2f72sm8870882qtn.46.2022.10.21.17.01.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Oct 2022 17:01:31 -0700 (PDT)
Message-ID: <f732a81a-3dad-8519-9830-57a602bb8c9f@linaro.org>
Date:   Fri, 21 Oct 2022 20:01:30 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH v3 5/5] arm: dts: qcom-msm8660: align RPM regulators node
 name with bindings
Content-Language: en-US
To:     Neil Armstrong <neil.armstrong@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Lee Jones <lee@kernel.org>, Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-arm-msm@vger.kernel.org
References: <20221005-mdm9615-pinctrl-yaml-v3-0-e5e045644971@linaro.org>
 <20221005-mdm9615-pinctrl-yaml-v3-5-e5e045644971@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221005-mdm9615-pinctrl-yaml-v3-5-e5e045644971@linaro.org>
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

On 21/10/2022 11:27, Neil Armstrong wrote:
> Node names should be generic and new DT schema expects RPM regulators
> node to be just "regulators".
> 
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

