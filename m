Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE54C5EE3CD
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 20:03:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234369AbiI1SDz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 14:03:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234434AbiI1SDu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 14:03:50 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DCA51003A4
        for <linux-kernel@vger.kernel.org>; Wed, 28 Sep 2022 11:03:49 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id a3so21493946lfk.9
        for <linux-kernel@vger.kernel.org>; Wed, 28 Sep 2022 11:03:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=HXE9oeDQQV+iTI2ox/bIzi3jVXRhY6aBz1RqBKzY3QY=;
        b=Z3OhQW19A9BvFqqeeIvsTAbFQpLLBUrCM1V8Y6PI9Q7V94Pi0X+PZCXWN0Nhhre8bU
         hz7uzP3jWC6bSxtfSeuseK0g39FKCat0IIMZJYNrLnJljEu96rAS0+dnraeTATVLPZGA
         EareENKypzkQC6aS3KVjBWqBM1Pll8x1c2htmVzuv54xb64kgsmTnB+Hgxe0uAu8D7vx
         uPc7BcgpRxoRVHM/Le2C0NmD56f/rrSLRC8UUDWNmUMlhCy/YvJkQ08kcz2FoZoPZFcl
         3WdOm5uVBMGZvcrhEp9bWq8bWDd/H28qnD7V5GyPybYYW13j0DIs4cWrerF9eSrkDhxP
         o2Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=HXE9oeDQQV+iTI2ox/bIzi3jVXRhY6aBz1RqBKzY3QY=;
        b=0XgyvRaNfXtIZDqWSt7DulLT7zaerLzcsgQXfyjrlCTEz5rX/xp709cFuMF7LcmXbL
         FMhM2XASyQ0Gfot6+ibcZJ5XwYWmuX03ECZxLyao+3aUkJbczqeKp7JLHj6MomqJx4+k
         EbDGR+pPOj63zU43CK99i1CpNFr9Y6TdiSuxRnWIJ6e+kRLHFKztCzVRqoZI27i5byRH
         poL2Z89uMLFJ0arZuDz8bwvzISvgfVFxEcx/MyrEnyldTtdBI1m9UXyTr84eGGDvxvWy
         H1QxDcl+ymlpkN+72lhAryGbMkzotwKlmQLW7g7HXb8X6iM59eLL9MHbd1uNqQf/qJru
         bmNg==
X-Gm-Message-State: ACrzQf2ip9HV9kCh/P7UVeEkvSzQt0JntsogY7YET58Qq8SYcrV5D0QW
        BDTbbvnnYFC2Ok5Vh8wTLQGgQQ==
X-Google-Smtp-Source: AMsMyM5LFG5uTcG/mvcymrW1/P8HiYSn5bhpc/dM9E4AjvP9rptnd1GgJLYkj2f14njBNO+kHWPlKA==
X-Received: by 2002:a05:6512:1305:b0:4a1:d80d:95d with SMTP id x5-20020a056512130500b004a1d80d095dmr6564493lfu.324.1664388227440;
        Wed, 28 Sep 2022 11:03:47 -0700 (PDT)
Received: from [192.168.0.21] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id s10-20020a056512214a00b00497c3fdf995sm535795lfr.152.2022.09.28.11.03.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Sep 2022 11:03:47 -0700 (PDT)
Message-ID: <0636d53f-508f-8a86-0973-2641c9020622@linaro.org>
Date:   Wed, 28 Sep 2022 20:03:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCH v1 5/7] arm: dts: qcom: mdm9615: remove invalid pmic
 subnodes compatibles
Content-Language: en-US
To:     Neil Armstrong <neil.armstrong@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
References: <20220928-mdm9615-dt-schema-fixes-v1-0-b6e63a7df1e8@linaro.org>
 <20220928-mdm9615-dt-schema-fixes-v1-5-b6e63a7df1e8@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220928-mdm9615-dt-schema-fixes-v1-5-b6e63a7df1e8@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/09/2022 11:14, Neil Armstrong wrote:
> The PMIC is an PM8018, but was compatible with the PM8921. Both compatibles
> was left but it makes no sense anymore the leave both.

Why? It makes sense for backwards compatibility. If you think it does
not make sense, please say why.

> 
> The pwrkey compatible is left to PM8921, unlike the others because
> the interface is stricly compatible with the PM9821 pwrkey.

typo: strictly
typo: PM8921

Again, why? The old code looked correct. In all three places.

> 
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> 

Best regards,
Krzysztof

