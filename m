Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6606671613E
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 15:14:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232066AbjE3NOL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 09:14:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231758AbjE3NOJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 09:14:09 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 640AAA3
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 06:14:07 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id 4fb4d7f45d1cf-5149aafef44so3737015a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 06:14:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685452446; x=1688044446;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fUH9XtAzWIRgOsb1MqDJfvd6qVENrkssqR4+2VADmQU=;
        b=iLSrL45SV8BP5SNaj9ihAs/HG1rHntKH8UaPf63oqwFqxFSR3voahRiA6NEluOhKtu
         ZTWv7fK83uKK5C7t5jOu7RMYdZ0qCXslmYTpIm+t+1WULQ0dTV+ziS/8Isu6K3DlYOjz
         8TG5F71WCuwaE7AwHpS7Zj7M1Lo5T+UykhITrpppwUN8RqIsUUf4Iee/kT71bNlhbuuF
         /XkTcRCmJr1HZNRZeq17NBZww56GGHJllapgC0nC/bEuBsHqLQzx+zttBSsa5qMY8IR0
         OIlVyz9O7ET9giNoKqD+fXIkU923lQIPOBa2AmO4BtTdrIgWdhXOVkNilDHJjMDJY/hn
         y/MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685452446; x=1688044446;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fUH9XtAzWIRgOsb1MqDJfvd6qVENrkssqR4+2VADmQU=;
        b=bf1bP793N21Zvs7XvpoF49zxkwAezeay3WQxdt3Tp3ZjE8L0xJxDX1X9m/s73XV7u/
         Jtx22FeWDHHWjp9XldcHotqg/AxpY2IIus5hMGcHbk3+S8ckKmtRgH/BsDwy8bYyEvpP
         PGdMbPwMuurM9pAJamB5fT8IV/cbTTWpkp08mkolrM4opPLhI+ww7tiu+UtliKUZ12Sn
         fzf2/af+Rpjs/vPkRs1EGYGFVHZEQSUNTh0RPh8aHTYNQF6FGhWWsnJpwpK9Vv1NL7+K
         8gIPRhsCMJvnKfOiUzYo+kecc8XYdupiOCeYqmqY1gDvnsFWnFXqmA3xNTm6A1shDaO0
         fv/Q==
X-Gm-Message-State: AC+VfDwdxuEfPjcJJZZutTSVO30UtsXNg8+KGfwUCMjCHnnfP9sn0rTg
        ISTytdGGvgVkjHKfVvfM15Z2uA==
X-Google-Smtp-Source: ACHHUZ71bUnQXRzAkoYWkylcW0WPdqFvOlzeWjYH5TDzER83v471t24VZ6980CJNywvjLuGF0XQLiA==
X-Received: by 2002:aa7:d8cb:0:b0:514:9474:f4b7 with SMTP id k11-20020aa7d8cb000000b005149474f4b7mr1588818eds.31.1685452445895;
        Tue, 30 May 2023 06:14:05 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.199.204])
        by smtp.gmail.com with ESMTPSA id j2-20020a50ed02000000b0050bc4600d38sm3929947eds.79.2023.05.30.06.14.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 May 2023 06:14:05 -0700 (PDT)
Message-ID: <34864c2f-dbe2-8598-ad4c-f9c3acc13164@linaro.org>
Date:   Tue, 30 May 2023 15:14:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2] Documentation/process: add soc maintainer handbook
Content-Language: en-US
To:     Conor Dooley <conor.dooley@microchip.com>, soc@kernel.org
Cc:     conor@kernel.org, corbet@lwn.net, devicetree@vger.kernel.org,
        krzysztof.kozlowski+dt@linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        olof@lixom.net, palmer@dabbelt.com, robh+dt@kernel.org,
        arnd@arndb.de
References: <20230530-multiple-whooping-ee5706fceb67@wendy>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230530-multiple-whooping-ee5706fceb67@wendy>
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

On 30/05/2023 14:49, Conor Dooley wrote:
> Arnd suggested that adding a maintainer handbook for the SoC "subsystem"
> would be helpful in trying to bring on board maintainers for the various
> new platforms cropping up in RISC-V land.
> 
> Add a document briefly describing the role of the SoC subsystem and some
> basic advice for (new) platform maintainers.
> 
> Suggested-by: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
> ---
> Changes in v2:
> - add Krzysztof's suggested method for avoiding inter-branch
>   dependencies
> - explicitly mention that tags should be signed
> - link to the devicetree abi document, rather than trying to explain it
>   here & reword that whole section
> - fix some typos, capitalisation & unify bullet style
> 
> The devicetree abi doc feels quite out of date at this point, and could
> probably do with a spring clean - but it also feels like hallowed groun

Yep, but that's another topic.

> d
> on which one should tread lightly, so I won't go near that til Rob is
> back.

Thanks!

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

