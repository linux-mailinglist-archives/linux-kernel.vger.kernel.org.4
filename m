Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C917872F5B5
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 09:14:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230123AbjFNHO3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 03:14:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242990AbjFNHOE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 03:14:04 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09DBD19B1
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 00:14:03 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id 2adb3069b0e04-4f6454a21a9so8044635e87.3
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 00:14:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686726841; x=1689318841;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wXKHed6+j3YBrrxp8AhQhFGlVOHvFUCBH9GPXEoaEzo=;
        b=ZGmuxDkhsAalBig4v1AtxqfenTa9oHltsyUnycHLWUoEv/eCk7scpXtexHXjYEPFTB
         I5kXHlSPrqYz+33urIOC+twEm1kzgyg8jbonYStoPSjf4qCu6uca4RfIxCGTnH7cDpKA
         DAbGrnDmtaFUuMZYZErjWVDcBikPAFJM+kUso3aFafgqCt6bwxcV5MeuibqNO0+Jq8BW
         4GjtwvDpW2Xol7UI/lL71HZyR+tqFhHC8Y7ZdfAp4cyHeoYeLdXDCTNX3YLFrpfIeqb1
         K+a6tbjLw3ZZPR1fwAHNk4OGupAWnjHpACivT8IFDkz7V7MieEvPvnLw1aUCPfbRQLPE
         EcVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686726841; x=1689318841;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wXKHed6+j3YBrrxp8AhQhFGlVOHvFUCBH9GPXEoaEzo=;
        b=g1ew+BsOFW/poVolTNoXrBTh51Xbkvw02XrskxV+KFiL1qRjy8DHu1m5mtwSG8mhjM
         W0ISoiIRVVifg/heNIPm+DLNTGhd+tCSqOvl5DymJ53Fb53Qa8qK2OR3KHe9Y60oq47a
         ouEFLqjdspDmDS8d30/te7rgy3sAHFcpkXJK1yVOSZZinlVut6vjubDBzfzRa2rkIITS
         +hIAuHt3GIBIdfQuKohSU6vmR1WkrM4/0AVgJKkTYS8XcuntWs45wwXuMB6/peMKoj6x
         xuuEln+UYhb/1SZPny2E8HCbWa6X9KviP4+ptCz2MIUKblC1ElJLKVXuywRGeEbQ3dSb
         4XiA==
X-Gm-Message-State: AC+VfDxFbOUFO/iKuNeEiJgyIBtsEEtvjpHOrcg5KkPJwASmg+5FpkED
        C9Gx1tgcUWzM149EOw6iuv+zxQ==
X-Google-Smtp-Source: ACHHUZ6UUVEg8GBaPlHMq9L3Im2SMaz+Jvnddpr22VGirb893Y/RtH/cprjUAq6IjFSaN5o14+X86g==
X-Received: by 2002:a19:6611:0:b0:4f4:b783:8556 with SMTP id a17-20020a196611000000b004f4b7838556mr6082949lfc.66.1686726840952;
        Wed, 14 Jun 2023 00:14:00 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.219.26])
        by smtp.gmail.com with ESMTPSA id v4-20020a056402184400b00515c8024cb9sm7510329edy.55.2023.06.14.00.13.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Jun 2023 00:14:00 -0700 (PDT)
Message-ID: <03b672b5-46f6-5df5-e0c6-050886cea311@linaro.org>
Date:   Wed, 14 Jun 2023 09:13:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 04/26] arm64: defconfig: enable the SerDes PHY for
 Qualcomm DWMAC
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
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>, Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>
References: <20230612092355.87937-1-brgl@bgdev.pl>
 <20230612092355.87937-5-brgl@bgdev.pl>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230612092355.87937-5-brgl@bgdev.pl>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/06/2023 11:23, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> 
> Enable the SGMII/SerDes PHY driver. This module is required to enable
> ethernet on sa8775p platforms.
> 
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> ---


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

