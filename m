Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73B16604906
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 16:19:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232633AbiJSOTZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 10:19:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233669AbiJSOS6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 10:18:58 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB93F1D8198
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 07:02:20 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id d26so40139412eje.10
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 07:02:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UJIED1GMLicc9E2xTm0vMrBYlH7QKNnQvZ0ZP1r6MEk=;
        b=K9naMjrZKs+uKZCSLVPRDZ2jSvYGjjkZf49XV8WaELqWNzpbevfDUza4cYpAaua+oq
         QCERtfMC3wjKCGvnU89DLqR/bLqjDUV8ktOm0luwt8ciKr3/wb8Gf+MF9fA7fjj5AAmP
         HUjbH8OVfJCuEl7k6AD24SN+R1te3atr2YaJkpIo00fP7TML8XcjkyE2o09hp4uYAi+y
         YE2hvmjKKbJIDIAVgtZLLTvYalXOkz560rvf6ks4AEcrM9i4inb53/yYCXjxJIZOY1TP
         54g4TUGcDLnoX3eex9RpbsVl+iAiTUyukUCPBFF+3oYwbbf/qEnxgqZK8LDFWdQuZcd9
         u8bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UJIED1GMLicc9E2xTm0vMrBYlH7QKNnQvZ0ZP1r6MEk=;
        b=3kf4LUYlzSBhVi/61ag9zSlEU6bxcc9eixL1rkUsQSg9WjBfq5LEh6UaO9yxApGPer
         Jm6PmEcBYdAJdWBg/j5Ivk6eH6L7br/IstWIGQtzygmZPWdnYobwyHsGMlhBkTxAMl5y
         552OdlZKXNBxSgdUlO7uI/W/5ThcJNN9OB/oiSC5XP5mkcZqOtXOVbbHnPrgDfE7N/l9
         F7MSXkjKX3UE7w2vZwYd8a+rJyoF5oaObXGA2Cf+EZfwWihGYdvMNMl9eK3HB0Zo1heR
         nOSUTlr5MrqYQeZDyQQ9VTUQb/r7rPAnf8J58rlzHBTkDqF+ktPQdig8ch4pc70BUh/1
         oqgw==
X-Gm-Message-State: ACrzQf0AnMRNSgaLTUAWcCt6XNdRuquN42nB5cGc/XfrfwfFI30xUapR
        n9Trrr/ZXkvVIx7W0x92l1GKc7mGFn0c1Q==
X-Google-Smtp-Source: AMsMyM7Cva7bl9FMqpWN6cGLNUl5h1EdpUNy5P98fDoiY7YC0WhyZAFXhoHFs2BmHbMdvQ9r5Xgbgg==
X-Received: by 2002:a05:651c:a11:b0:26f:db4e:e7a6 with SMTP id k17-20020a05651c0a1100b0026fdb4ee7a6mr3016661ljq.361.1666187484890;
        Wed, 19 Oct 2022 06:51:24 -0700 (PDT)
Received: from [10.10.15.130] ([192.130.178.91])
        by smtp.gmail.com with ESMTPSA id b7-20020a056512070700b004a2386b8ce8sm2285850lfs.211.2022.10.19.06.51.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Oct 2022 06:51:24 -0700 (PDT)
Message-ID: <e17c4a43-383f-110d-4682-11727cff66ce@linaro.org>
Date:   Wed, 19 Oct 2022 16:51:23 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Subject: Re: [PATCH v2 11/15] phy: qcom-qmp-pcie: restructure PHY creation
Content-Language: en-GB
To:     Johan Hovold <johan+linaro@kernel.org>,
        Vinod Koul <vkoul@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20221019113552.22353-1-johan+linaro@kernel.org>
 <20221019113552.22353-12-johan+linaro@kernel.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20221019113552.22353-12-johan+linaro@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/10/2022 14:35, Johan Hovold wrote:
> In preparation for supporting devicetree bindings which do not use a
> child node, move the PHY creation to probe() proper and parse the serdes
> resource in what is now the legacy devicetree helper.
> 
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> ---
>   drivers/phy/qualcomm/phy-qcom-qmp-pcie.c | 36 +++++++++++-------------
>   1 file changed, 17 insertions(+), 19 deletions(-)

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry

