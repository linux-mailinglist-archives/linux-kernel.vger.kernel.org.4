Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D81B5ED7CA
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 10:31:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233921AbiI1Iay (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 04:30:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233698AbiI1Iaq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 04:30:46 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BE0612AFF
        for <linux-kernel@vger.kernel.org>; Wed, 28 Sep 2022 01:30:44 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id s6so19254700lfo.7
        for <linux-kernel@vger.kernel.org>; Wed, 28 Sep 2022 01:30:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=Dm3uqPAg8eoPnHxqMu1a0UAUiwGTZ3ONRjALLMb+mpA=;
        b=YiwvPQYOdIPSHTaWtpm0Ztw/euiLF2X9COCToOuZMSrJ39DO4Q+lxRCG+k49HwIy1i
         T/U0vwK48QaBji5MB5YLwYmkxObJop79YT/8HG8ZD6IY+o6bGxHHt1JjPZd3WNHPgeMU
         GXqrwMBS3WJMTkghn1W2y1X9eL4JsCpA/L6N+y9Aip2j39UOpXJwvXhZVzGpdBS4htC/
         dg3aGi4ATdZ1YHnbgHIr4Z+AzYq8xLOK8B1XNCNUqf9NtHkZUBfXkHAk/2WjcBhYOISc
         9QYLoVyBhdU7rnk9aeGUJWNws/0fuuzes35ZW2O5Ez1EzJxQrYxaQGuC8axwKQf8uKbF
         lgaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=Dm3uqPAg8eoPnHxqMu1a0UAUiwGTZ3ONRjALLMb+mpA=;
        b=vN6KMbu11+2GklnmTUYTz5opKUHpPTbNOfeTNOi61oznKg0RNaHwZtaujPhdEbCDzb
         JaCXoB+hLsHo11DuuPzIFNg2DY9PkeUl4VgwWlkCyNipAUNVMPCPN95PFnLEW/sGY2Z9
         GbV8IAxP68E+IDhgGkTcZ06f3Q1/lnA1X3kV+Ilq2yjYLQXJNUIXNeD7j7X6AECFfkx8
         UgYfQ/mRn/srJxOS3PPaZ30CvQ4MHDfuIE1JiUzyzz0u/BKY8L6n2SBBRLw1PB5IiUeP
         S25D5qRM3/9v7Y+/gTyJ4n2d5/7ztg6o6oBwhZFj6v/f7Q2W7FcLI5CyTKdruH288odj
         cVew==
X-Gm-Message-State: ACrzQf2+TIBKdxAJtbwrLRUXPlISvOUtcAvVierkMWi7Irc9tWfb+Mxd
        muVhE77Ps4OJgDe0NAi1JxCTeGtyKJQ2tg==
X-Google-Smtp-Source: AMsMyM5ulsXpzfd2Ir/2GftYgLXdnxDjNfTpMcf3y7fOu0+QpNaOTgfm1zuqTvzYKuUrdi4jqMrG0g==
X-Received: by 2002:a05:6512:3981:b0:49a:d169:5808 with SMTP id j1-20020a056512398100b0049ad1695808mr12078473lfu.241.1664353843045;
        Wed, 28 Sep 2022 01:30:43 -0700 (PDT)
Received: from [192.168.0.21] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id 9-20020ac25f09000000b004977e865220sm409650lfq.55.2022.09.28.01.30.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Sep 2022 01:30:42 -0700 (PDT)
Message-ID: <06603279-df45-b52d-7b9d-a11230a1f9c4@linaro.org>
Date:   Wed, 28 Sep 2022 10:30:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCH v4 1/2] dt-bindings: arm: qcom: Separate LTE/WIFI SKU for
 sc7280-evoker
Content-Language: en-US
To:     Sheng-Liang Pan <sheng-liang.pan@quanta.corp-partner.google.com>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     dianders@chromium.org, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
References: <20220927112343.2700216-1-sheng-liang.pan@quanta.corp-partner.google.com>
 <20220927192234.v4.1.Ide53082044aac56877c4ff5725777769e377476a@changeid>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220927192234.v4.1.Ide53082044aac56877c4ff5725777769e377476a@changeid>
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

On 27/09/2022 13:23, Sheng-Liang Pan wrote:
> evoker will have WIFI/LTE SKU, separate it for each different setting.
> 
> Signed-off-by: Sheng-Liang Pan <sheng-liang.pan@quanta.corp-partner.google.com>


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

