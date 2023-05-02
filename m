Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B9566F4B18
	for <lists+linux-kernel@lfdr.de>; Tue,  2 May 2023 22:14:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229587AbjEBUOy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 May 2023 16:14:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229949AbjEBUOw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 May 2023 16:14:52 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E38D219BB
        for <linux-kernel@vger.kernel.org>; Tue,  2 May 2023 13:14:48 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id 4fb4d7f45d1cf-50bd87539c2so1069124a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 02 May 2023 13:14:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683058487; x=1685650487;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/Xq7JMxBzj9QxrO+UvNF5zLGWHECX20PKGXlzfiDua4=;
        b=q/cXQWUe4El8eMz4+gWzmpcE92p14p+snsKQL8lF7FnUGAwR4hwitIO+OIenjg9lWN
         a7vAcTYzAT2lrfSxhHisyUtpvFRDjgSb5Ib/vwoYFoewjjRvUtTXXIfeQZVJJQRB62bV
         qWMtAEk78th3ncKzNYRQaS3+nuA1dRY3JwnlZ3uZCXw/AbWriUqIdj7LbbuZLzcBxLPT
         GFGRpEe3p/bYYuagvQ7EcUZi1XcvXjuAs44kijlkD/JKPI7+YGBOErbQb4xLqkuaD6OZ
         53JKUkSXBEds5MGfT+R1MQxbLMNL4Xr06V4n8y5/fbQB6AvkANpqjOI1h0VTMwPvpp+H
         YEVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683058487; x=1685650487;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/Xq7JMxBzj9QxrO+UvNF5zLGWHECX20PKGXlzfiDua4=;
        b=g3tJ3M4rMCNT52y3PUcUsX4Lt19sy3ferSkyEV5zz8CxA6FabLVZPM+VIrXQOirAAF
         Blrptc60f+HELjTpyy0wagbp5qBQ9v+9j+0BiUCnIQtsidKSrRueA4XN0SVNKOhyjQbl
         znfBKPhO8OZezkQYPEBoSp0ImH6L/yacPpd9rDmODXLlIHhA6yPC2a3JG+peuAfSTwcg
         4atq++hup0c6zscyvrvEe9fcv9mNbdei1WPycH1goZLKE4CTKLKleZWsBWfQsoiRUuFV
         h6/7Pljzu2DmxYCbTG7Q+ebDP0ALXeOi6BwVu/fnUV7iThyyOrOLlXKS48L9nG+U9VTJ
         QVLQ==
X-Gm-Message-State: AC+VfDx6M2SBdoDBk5BkO0nQWUO5+mYiPT96rtlCx8MPEqym2tIuinhR
        JI/onoRFW/wd+XNVKIBqgmZKwQ==
X-Google-Smtp-Source: ACHHUZ6JoMbJ2y3aQ8hShRM5mNT2ifEf/VSlEtJ3P2paHQmq+YSCgci4WPTOrKdsBJWxbth4pdkzQQ==
X-Received: by 2002:aa7:d514:0:b0:50b:c73e:91bc with SMTP id y20-20020aa7d514000000b0050bc73e91bcmr5724070edq.14.1683058487365;
        Tue, 02 May 2023 13:14:47 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:37be:eda5:e303:19e0? ([2a02:810d:15c0:828:37be:eda5:e303:19e0])
        by smtp.gmail.com with ESMTPSA id r12-20020aa7d14c000000b0050be175db5fsm155597edo.10.2023.05.02.13.14.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 May 2023 13:14:46 -0700 (PDT)
Message-ID: <c018437e-24fd-7451-d64b-57080af55057@linaro.org>
Date:   Tue, 2 May 2023 22:14:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH] arm64: zynqmp: Change zc1275 board name to zcu1275
Content-Language: en-US
To:     Michal Simek <michal.simek@amd.com>, linux-kernel@vger.kernel.org,
        monstr@monstr.eu, michal.simek@xilinx.com, git@xilinx.com
Cc:     Amit Kumar Mahapatra <amit.kumar-mahapatra@xilinx.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <79bc2c83929be5536cbf10883519e82cead21dce.1683035888.git.michal.simek@amd.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <79bc2c83929be5536cbf10883519e82cead21dce.1683035888.git.michal.simek@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/05/2023 15:58, Michal Simek wrote:
> Internal board zc1275 was released also to public which ends up with adding
> missing 'u' to board name. Reflect this change by renaming DT files.
> 
> Signed-off-by: Michal Simek <michal.simek@amd.com>
> ---
> 
> 
> For more information about board please take a look at:
> https://www.xilinx.com/products/boards-and-kits/zcu1275.html
> 
> ---
>  Documentation/devicetree/bindings/arm/xilinx.yaml           | 6 +++---
>  arch/arm64/boot/dts/xilinx/Makefile                         | 2 +-
>  .../{zynqmp-zc1275-revA.dts => zynqmp-zcu1275-revA.dts}     | 4 ++--

Please keep the bindings separate patch, even though entire set is not
bisectable from dtbs_check point of view. Bindings are getting exported.

Best regards,
Krzysztof

