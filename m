Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D35C760E3B0
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Oct 2022 16:48:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233757AbiJZOsM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Oct 2022 10:48:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233476AbiJZOsJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Oct 2022 10:48:09 -0400
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F3B610453D
        for <linux-kernel@vger.kernel.org>; Wed, 26 Oct 2022 07:48:08 -0700 (PDT)
Received: by mail-qt1-x82d.google.com with SMTP id g16so10038916qtu.2
        for <linux-kernel@vger.kernel.org>; Wed, 26 Oct 2022 07:48:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SA6ximgWcrGZSfkvZWfqRf8tuzgvJWoN/vqehJP59VU=;
        b=RtTPtYFpF5w43UVMWtnp7DEnyHgaiVZ0UMK6eWGdkYQh6L3F7cHnyN/kEVd//lj497
         0tKl6hTAmP6O0CaCDCEtb/4yntNbcz+d4ZSnCzif+byGTMoW3Wh/wuwUxgnnd07drh8B
         EQmdqAHkaGTMaQjKkeptNLM8PEb9AzOIp9F1ZiR/liZawEPETeCF/0Nqk6AixyslkjyV
         v0mzMT91v6K77riQ6FoRynL5rLZzKAoqnsMYElw0OYooutxWUn0Crj2hLPlzsvnJ1Oe6
         aXnIOzcc6SbzXSyBVwxue9MjYRTlfmJnNzzoq/am+LE2QfRDBsL4DAUtWCBpSwLspHcJ
         /2HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SA6ximgWcrGZSfkvZWfqRf8tuzgvJWoN/vqehJP59VU=;
        b=0x7qIbs81DMdE2Adpy2Gk6P/FddTFe8w8og96nmmuKrFuHiUnBIxJtaeoaEiJVpgil
         xYDmjs1GqbjHWCrlGmcy8mbqbS8H/YExWMqvGUvQWjGiQaTkvti2wkmIx0SgzSdhuTWl
         exoqPR0Fi9DtYLG00qKkQXIMpzr50teJ20qBrEwhxLUYiBNe8DHiHZuxWhD6TsFBeecq
         sewIBa6bU/cILF9u2dFYCcmUGdFw+MTSp7Y3QCPu43xzmjcBVJ7a+TcZqOKFCeE6KKU+
         JE9ZSC8k7AF/tmlhSJRANnolntKJT9A7JYrZbBIdiW+OznfqA8v+NNxxrL0bwqlSMk5k
         l6Mw==
X-Gm-Message-State: ACrzQf1xqHeaN1cGN99lXu3yc1ELhBzwCh2swOScSvwpWx4g5le8DWVW
        HqPQ7wlT7DrJA2TU7rf2kGf8NQ==
X-Google-Smtp-Source: AMsMyM4THSiBQRYKk+evU/FKD4ggXIlSbWrvj3lViuNxvJCQDML3AEw3bCcxkl7BfC5bsgeI+3eLKQ==
X-Received: by 2002:a05:622a:248:b0:39c:dfcb:9b63 with SMTP id c8-20020a05622a024800b0039cdfcb9b63mr37872881qtx.234.1666795687836;
        Wed, 26 Oct 2022 07:48:07 -0700 (PDT)
Received: from [192.168.1.11] ([64.57.193.93])
        by smtp.gmail.com with ESMTPSA id e10-20020a05622a110a00b0039cb9ef50b5sm3310931qty.26.2022.10.26.07.48.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Oct 2022 07:48:07 -0700 (PDT)
Message-ID: <969635a9-ff58-d0a7-579d-0f3b4a208ea5@linaro.org>
Date:   Wed, 26 Oct 2022 10:48:05 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH] arm64: dts: qcom: sc7280: Villager doesn't have NVME
Content-Language: en-US
To:     Douglas Anderson <dianders@chromium.org>,
        Bjorn Andersson <andersson@kernel.org>
Cc:     Stephen Boyd <swboyd@chromium.org>, Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20221025164915.1.I38e2545eda2b3bd3fef6b41c98f451e32851ae70@changeid>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221025164915.1.I38e2545eda2b3bd3fef6b41c98f451e32851ae70@changeid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25/10/2022 19:52, Douglas Anderson wrote:
> The sc7280-herobrine-villager derivative doesn't have NVME enabled so
> we shouldn't mark the PCIe nodes as "okay" since they're just for
> boards that have NVME.
> 
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> ---
> 


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

