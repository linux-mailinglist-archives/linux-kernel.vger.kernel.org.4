Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E0957053EE
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 18:33:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230423AbjEPQd3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 12:33:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230152AbjEPQdG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 12:33:06 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA6899EC5
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 09:32:19 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id 4fb4d7f45d1cf-50be17a1eceso26457806a12.2
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 09:32:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684254738; x=1686846738;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FKXutpug0K0rcLgauEj/wEuCLazV6EJGkQmsisOUf5w=;
        b=jJIIbp3H9JJ6wWbsM7XKZXuYodA6rnUXuRhjMf3Sn8FEme6Yp3WAaetKy/Y9MILkNy
         Imp8f0JIs8WdxijCepidzoWoddj3Qva4UwEP5mmeu7vRf5bRV7m7/KERO69O66okqiCs
         y6ujX5vJ9/236eznfNB9rfNsr2PCFz/3XazVMlWZrqrmhivNIO9hcEo9w5FkuN3TniXW
         PAPeBpHz5jHEkTBarFOlivmnBsa05IyX6LKlHhRvEmLjDu3dXpyrO8aT7OxCNOhH/8QV
         gWozqb7sCI5l71FHes+dGvC6py47jZ/v1NyIkERfANYP+8glyhs1nHHXdViqnA+TuO1p
         fiNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684254738; x=1686846738;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FKXutpug0K0rcLgauEj/wEuCLazV6EJGkQmsisOUf5w=;
        b=EMT8uwX4mgMCvl9PhJHx6NX0oDI1XUAr+tPIcEuCet3mWx/Y80WyL2vDJP0TzqCnrn
         7YCPfDrFDSAz59VwgiwiJinF/TWHqxRNQH8NvbPZV5JP68jsPLuN/sR1z7NceGfLCxY7
         fxSsA5+er5o7s2Bdp7sp4Pwq0tQEwsXwaYgtBoRYDP17P/bViS8Rz3rVfGKvoF/qAJJl
         oOLL3anSEvfsQiv8r4/mx1qsdq7SY6RRKKiotHEEMf6mkqFndiVHTuneXjba8X8vP5jf
         od+dj3eFAeb9pBsxssCH0THh57yNSqxkbweF86f9ITWVNe+GYEnlQKpV/kLpiY9TVcE0
         wD5A==
X-Gm-Message-State: AC+VfDxvmS04jips2y5owAFmTgovmLIwJw/draHSnMc3FPIR5hXsI3Jo
        GOtT+mzjVm0tNqppMbvrIJ6mPQ==
X-Google-Smtp-Source: ACHHUZ64wWKpPBDs7UQNr4OLIsM9BNXBaHD+PYxr3NwuMYgRbdM1sHJOfIIROgwr0koAW1/Gj9wsVg==
X-Received: by 2002:a17:906:fe07:b0:953:8249:1834 with SMTP id wy7-20020a170906fe0700b0095382491834mr34033983ejb.16.1684254738364;
        Tue, 16 May 2023 09:32:18 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:77d1:16a1:abe1:84fc? ([2a02:810d:15c0:828:77d1:16a1:abe1:84fc])
        by smtp.gmail.com with ESMTPSA id my14-20020a1709065a4e00b0096643397aeesm11088233ejc.184.2023.05.16.09.32.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 May 2023 09:32:17 -0700 (PDT)
Message-ID: <b2d8cb74-9675-d449-971d-016a1df66ba6@linaro.org>
Date:   Tue, 16 May 2023 18:32:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] arm64: dts: marvell: add missing cache properties
Content-Language: en-US
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <20230421223159.115412-1-krzysztof.kozlowski@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230421223159.115412-1-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/04/2023 00:31, Krzysztof Kozlowski wrote:
> As all level 2 and level 3 caches are unified, add required
> cache-unified properties to fix warnings like:
> 
>   ac5-98dx35xx-rd.dtb: l2-cache: 'cache-unified' is a required property
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> ---
> 
> Please take the patch via sub-arch SoC tree.

Hi Andrew and Gregory,

Could you grab this one?

Best regards,
Krzysztof

