Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A57F72030E
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 15:18:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236022AbjFBNSj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jun 2023 09:18:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236149AbjFBNSc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jun 2023 09:18:32 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CBD110C6
        for <linux-kernel@vger.kernel.org>; Fri,  2 Jun 2023 06:18:12 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id a640c23a62f3a-97460240863so108294166b.0
        for <linux-kernel@vger.kernel.org>; Fri, 02 Jun 2023 06:18:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685711891; x=1688303891;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=+NwS3zwEZvLwZpFK4ZiaFDiysXGsoIUw128QiW5LtVU=;
        b=y4SvAQHWgG5smj0nfr9cPL7rQvdt+tK6xIKJN0ulw65aVNy/YL45IdSDjNDnQcMYUs
         Kj0wjGYzG93cyd6LOUYTn21uAVPRLY6nXj0urvDaZy4/6Fdo0KvV58x2jBQjl8sxMGkp
         F17BWTrDcCC1zPba7hYt12q4F/0G742A1CshaNWFJdzOX+mCMg9p2fb3J9/BRvCQqD2C
         MI7BP2tA1WBhHD4vzsFGkkvrOFS0WVTi7AHK92+OYpbpEvBg0jdSoj/a8zKeOcVQk1Kv
         NGk/Ate+EL5OQhweq+scBl3NcZEh6E88/c86+0VHj54iid0E8n97Hk7e8XiHhcFwVcHV
         fmSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685711891; x=1688303891;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+NwS3zwEZvLwZpFK4ZiaFDiysXGsoIUw128QiW5LtVU=;
        b=Av+We5dTy9SjnNmhn7F+vTN1BAJzX7DC7+bTyAh5bPxUY/ZZax+R5rUgeUN4eV6lQY
         DApjU/3CbR13akwPMPjyNhJ7UL+9kqMWcHVMJkaxC5NgCph6O1GpeZ35PjITvkM7tqcW
         NMU2o7SfWAum2IJ9eQdA25iQM3bGMTaPedXdwsdRS84b1lt9Q1Mh2mN+0PEm94OCYVzt
         hWYEWtKdzkYa2rNxH/+XexQPq4g1JwWvJt+7paGWjsxMhu4RWKJyNqgpMNtz4w6Rcq9k
         rF0XjUILYqlune5skRD9e42I/6aVragAsljlqwPXLBksQJEfUJ1saU92bQ9P8zsq4aEq
         Llow==
X-Gm-Message-State: AC+VfDzyVLMUzpZqQ9k+8bV2Yhfy+A0PCRCKEt+WWsHhTbW2+WIjFLej
        8AblT4m6Wyp7XvowN7hXV2GbXw==
X-Google-Smtp-Source: ACHHUZ6JYFwp/knwwWxf+ufp1RJgv7D7BecZvMAW0KHV56DSQ8VwVIvFUeqNQttcyPPpjVyDgEDmXg==
X-Received: by 2002:a17:907:3e14:b0:974:545d:cfa3 with SMTP id hp20-20020a1709073e1400b00974545dcfa3mr3324224ejc.64.1685711891425;
        Fri, 02 Jun 2023 06:18:11 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.199.204])
        by smtp.gmail.com with ESMTPSA id x17-20020a170906149100b009764f0c5fe6sm19622ejc.7.2023.06.02.06.18.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 Jun 2023 06:18:11 -0700 (PDT)
Message-ID: <b06070d3-a272-9a0b-2d02-df8fbca4e951@linaro.org>
Date:   Fri, 2 Jun 2023 15:18:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH v2 6/6] arm64: defconfig: Enable sc828x0xp lpasscc clock
 controller
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        andersson@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org
Cc:     johan+linaro@kernel.org, agross@kernel.org,
        konrad.dybcio@linaro.org, mturquette@baylibre.com,
        sboyd@kernel.org, conor+dt@kernel.org,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230525122930.17141-1-srinivas.kandagatla@linaro.org>
 <20230525122930.17141-7-srinivas.kandagatla@linaro.org>
Content-Language: en-US
In-Reply-To: <20230525122930.17141-7-srinivas.kandagatla@linaro.org>
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

Resending as my previous email probably got lost. If you got it twice,
apologies.

On 25/05/2023 14:29, Srinivas Kandagatla wrote:
> Enabled sc828x0xp lpasscc clock controller driver required for X13s laptop.
> 
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> ---


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

