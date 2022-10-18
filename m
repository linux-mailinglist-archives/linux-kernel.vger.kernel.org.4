Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63CF8602CC8
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 15:21:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230366AbiJRNVn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 09:21:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230235AbiJRNVl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 09:21:41 -0400
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D759C8959
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 06:21:40 -0700 (PDT)
Received: by mail-qk1-x734.google.com with SMTP id o2so8546785qkk.10
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 06:21:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6ig+blfSfBs18EHKk3dw3QfARjQKs3aEr45NE9posnQ=;
        b=OG+CtEde8mcfeCFT2sUnKVswv+u3i/1KM7a4XFRPzXDgV0ZPVLYeJfh6CTtbiViEzz
         hmfLMssv71EY447OfzqDE4GNmLuAmXkkKeWlXmkGBMu8O8JkV57bM6w5xf/aUCZQjMPM
         Keh2SlXVh55RBpJmEvRDZilFegfb4qXdn9MeVEFizwGXc8Lu1EhP6VdYMOydcq1lPt+p
         NVT7JXr86kacLnDWOmO3gdwGuA67NzSyhpw54/5KNrxvZ082ipRa5kXk/jODYDeE9qGP
         ELS9v8ANw9XLUYqnPT7hy3Hc2+33Mrrgv+xXUv5BZ/wkqBMbBbSdobZJwLFMpeyIUFYg
         avLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6ig+blfSfBs18EHKk3dw3QfARjQKs3aEr45NE9posnQ=;
        b=2C3mkio1b/DA9PxsuDIoKvPr4GWGAS9ux7wKPBSH++UKzlPeLJ4xmjzXapBixnHHbg
         65XA1FJGz6J6xcirOL6CnVJ5x6rCBfq2QMmR9SRYiwg9l2xdUlEP6iZntY/qVx98ZSDx
         K7lslgWIGEQTsFLiN+FYVJjqBw7+f/FVgkvRx4o2qLSd7Ibv4oqtLb8vUMxwxzIjO5fL
         vk5Om07dZxvBhlPNuT91ptpmyXOePzsH8kvmdBYmWRFd9M4gLqrNJ9qo5lYHPAs+QpOF
         tqm2f510GCup90X6xllJwKkJUYb1ZoWupd1quhjAZkM3oJlcfB0CO9OEtvZr9cb9gDCU
         CE0w==
X-Gm-Message-State: ACrzQf2BnZvjU+V9o6GJya6GxRidsRJZnGz0AkT05+vuYAoXhygjj73c
        OepquKQglMaxWTBvoztrtxgiTD14uqjovQ==
X-Google-Smtp-Source: AMsMyM5uTpI6sFxgq3Dq/5ws0P0oioq2dNFYGcQXkmomTLRA9XMh0W8y06p2rd2ORxEToWW8XKLnhA==
X-Received: by 2002:a37:b885:0:b0:6cf:4bb1:f056 with SMTP id i127-20020a37b885000000b006cf4bb1f056mr1767359qkf.167.1666099299222;
        Tue, 18 Oct 2022 06:21:39 -0700 (PDT)
Received: from [192.168.10.124] (pool-72-83-177-149.washdc.east.verizon.net. [72.83.177.149])
        by smtp.gmail.com with ESMTPSA id m10-20020ac8444a000000b0039b03ac2f72sm1910313qtn.46.2022.10.18.06.21.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Oct 2022 06:21:38 -0700 (PDT)
Message-ID: <3f8a8069-d97e-0e96-906b-ce740cd07aaa@linaro.org>
Date:   Tue, 18 Oct 2022 09:21:13 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH v3 0/4] arm64: dts: fix drive strength macros and values
 for FSD Platform
Content-Language: en-US
To:     Padmanabhan Rajanbabu <p.rajanbabu@samsung.com>,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        alim.akhtar@samsung.com, chanho61.park@samsung.com,
        linus.walleij@linaro.org, pankaj.dubey@samsung.com
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org
References: <CGME20221013110708epcas5p3c54c22bbc77175eb2a26dc9fd43814d5@epcas5p3.samsung.com>
 <20221013104024.50179-1-p.rajanbabu@samsung.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221013104024.50179-1-p.rajanbabu@samsung.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/10/2022 06:40, Padmanabhan Rajanbabu wrote:
> Padmanabhan Rajanbabu (4):
>   arm64: dts: fix drive strength macros as per FSD HW UM
>   arm64: dts: fix HSI2C drive strength values as per FSD HW UM
>   arm64: dts: fix UART drive strength values as per FSD HW UM
>   arm64: dts: fix SPI drive strength values as per FSD HW UM
> 

Use subject prefixes matching the subsystem (git log --oneline -- ...).

> 

Best regards,
Krzysztof

