Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D4C25EEEB3
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 09:17:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235122AbiI2HRT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 03:17:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235095AbiI2HRP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 03:17:15 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22F541166C3
        for <linux-kernel@vger.kernel.org>; Thu, 29 Sep 2022 00:17:13 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id i26so896148lfp.11
        for <linux-kernel@vger.kernel.org>; Thu, 29 Sep 2022 00:17:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=VV14SN0wq48/xruHCsu1VKPTfNLR6vqna8T/ci26yZ4=;
        b=InfhY58eTl/Cv7rMpEYc1moFqD3wqvorMh+S24CCzRrdabIne33Oj1aH2ZEThb16yS
         HPO+0v57kGlh/QCU01lOPa+W0lh1ACQ0x23VeTOcjCDV1T9sy8LXwKat6uyhTH+zDNVI
         ZloslMv9UEocJOgIP6HFtBskJkRvZRaQ3/M5RVreuHjQDYm+3C2uy2oadVlkbDCAX6s2
         sQYkWlmkFlepWunQejGBbrYRdBkevTefWSg3QaN6k3wxQo1PFrxaQfFh7NhH+RW5eqkW
         xmSI/IlLcW/omwTyvdIxYj+gKLUDgAjIqk7avSTNyp5eBYhp4c4Gkl1yqc0eFwaw884w
         +zmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=VV14SN0wq48/xruHCsu1VKPTfNLR6vqna8T/ci26yZ4=;
        b=H8VF16mbV041jSuOR7Vh5s696u+tQtr3zwldRrUEv/qGinEouD3Ng3nrNUPXQM5LYT
         dskUlzWf4JwPARXayIsUi9DaU7l6ia9KYEtQeAF69rD/ZS5MPj8wXrKljlNAfOzFX1L4
         41NdSudb53bMbSYmeaaCLOTunu2LHh+ksgBhRDwye1B3Ub5qI5AJYZusdHLV7YzIIEOB
         JjdIOwor0iB7kt4orLIM7Hv/FZr5HJVzEJtL/Bwg6PJJjLfcHrZO7q+ZxaLZGjJAmNwX
         bZf21/cEpYtIWEVvcbANAhMr6DckL0uuAhKXH2fYszRvkWZYIb5/UM1/THFYFm12w8zR
         ER2A==
X-Gm-Message-State: ACrzQf3Hm1XR6L1QOoLeZGTpmJ988WRuzpoASofwKP055IhDxXs96tT8
        BT5gw5Xgl65izdk9AbfV4cwTkoo1qHELww==
X-Google-Smtp-Source: AMsMyM4Ve26xtYplTF/bm8INXv398LABxanI2DUP5ewhXXX6KeYoVcNAI8xF4H5umOsN0/OliXb4Ww==
X-Received: by 2002:ac2:4f03:0:b0:496:d15:e70c with SMTP id k3-20020ac24f03000000b004960d15e70cmr717138lfr.102.1664435831518;
        Thu, 29 Sep 2022 00:17:11 -0700 (PDT)
Received: from [192.168.0.21] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id 9-20020ac25f09000000b004977e865220sm701306lfq.55.2022.09.29.00.17.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Sep 2022 00:17:11 -0700 (PDT)
Message-ID: <288e0496-7411-138f-4494-20a38d1195c1@linaro.org>
Date:   Thu, 29 Sep 2022 09:17:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCH v2 1/4] dt-bindings: net: snps,dwmac: Update
 interrupt-names
Content-Language: en-US
To:     Bhupesh Sharma <bhupesh.sharma@linaro.org>,
        devicetree@vger.kernel.org
Cc:     linux-arm-msm@vger.kernel.org, agross@kernel.org,
        bhupesh.linux@gmail.com, linux-kernel@vger.kernel.org,
        robh+dt@kernel.org, netdev@vger.kernel.org,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh@kernel.org>, Vinod Koul <vkoul@kernel.org>,
        David Miller <davem@davemloft.net>
References: <20220929060405.2445745-1-bhupesh.sharma@linaro.org>
 <20220929060405.2445745-2-bhupesh.sharma@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220929060405.2445745-2-bhupesh.sharma@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29/09/2022 08:04, Bhupesh Sharma wrote:
> As commit fc191af1bb0d ("net: stmmac: platform: Fix misleading
> interrupt error msg") noted, not every stmmac based platform
> makes use of the 'eth_wake_irq' or 'eth_lpi' interrupts.
> 
> So, update the 'interrupt-names' inside 'snps,dwmac' YAML


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

