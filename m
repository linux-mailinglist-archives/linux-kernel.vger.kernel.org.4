Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 155DF6B1F1E
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 09:59:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229963AbjCII65 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 03:58:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230250AbjCII6I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 03:58:08 -0500
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5077464256
        for <linux-kernel@vger.kernel.org>; Thu,  9 Mar 2023 00:56:55 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id ec29so4073106edb.6
        for <linux-kernel@vger.kernel.org>; Thu, 09 Mar 2023 00:56:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678352214;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/rCAQVKSrz0FwZyYOlDSHoKDBXybcsPfi8bbV/mESho=;
        b=mK8f1i3oEKsmSI+KJXHLoeP4iU9lhs0wLs5rwKmiO0qzJmsemC3CTF127p+dVSfgun
         CgtaLKak+dzzOcmif4JloBuwnvWR5UemuUqKDPjCLH/AaP7kD6SmVUx811o6bh9fWnMU
         r62FCgYzzQaqIJHOJTp7aSWBNgaDm7WoG64ULr3/QGZAliorhMNYqQdKY2ErX7O8dV6V
         U+/AuBR7Ev6/mCENCo7KMBFp9DVch4Qq5pKGJKCh15Tvx5y7GEMyJSNGeUWV0QZxrTn6
         y2+K4ppCy5qdqqwfNYsokCF9rpTze92IQgzKfkmrs0/mTtiiDYr6MYB4CYPbf0I2TVFx
         3J0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678352214;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/rCAQVKSrz0FwZyYOlDSHoKDBXybcsPfi8bbV/mESho=;
        b=0gzPfnNKRlmwkd5WeRCgIIOfXNCwQYUc9II1QMpUlxC7B/BVBBf7f9f0QoMUX4aq+c
         vv52XXENhtrR8LVqkM0YNsbNJIzkhg+aB+bg6zXEoadbPBgolXEf/EEIJTOAWG5Che3q
         8umqDEe1Qdn8XGbNXGe1unqLvmrRuWqM6+gte5rRsWheYZahWGiCVv5TnSwLHe5C53AG
         RCu2Z7qRpzKCXyAqYgbiJLZkaI8+GfS3ROSQTK4I8wdxuNcGJR+qnsdrVLogOBjGCm/X
         NTzIX04vkhebOAiHWJ8uNbU+qutQUITOlJ4Npqf5egUN4u2AWy243AKcMMp41cJmvucN
         ur9w==
X-Gm-Message-State: AO0yUKWJfIktu8EquAY3ArZfWGUeHsEym/USpQzjxuSOJAWkVH/9X2Cn
        So/gH+4tbf6MiwtMYuGCmBdtaw==
X-Google-Smtp-Source: AK7set+fDQpPHW8bqOKviqoGm8B/ByRW0DS3O8BeIg8fcotXryimjWinXMwZURKP6vy5S32ngtiqZg==
X-Received: by 2002:a17:907:3da7:b0:8de:baf0:338c with SMTP id he39-20020a1709073da700b008debaf0338cmr23213386ejc.14.1678352213882;
        Thu, 09 Mar 2023 00:56:53 -0800 (PST)
Received: from ?IPV6:2a02:810d:15c0:828:7ee2:e73e:802e:45c1? ([2a02:810d:15c0:828:7ee2:e73e:802e:45c1])
        by smtp.gmail.com with ESMTPSA id ga2-20020a170906b84200b00882f9130eafsm8491562ejb.26.2023.03.09.00.56.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Mar 2023 00:56:53 -0800 (PST)
Message-ID: <94b3f478-4806-f2aa-eba4-58f4b5bbb00c@linaro.org>
Date:   Thu, 9 Mar 2023 09:56:52 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v4 1/3] dt-bindings: watchdog: Add watchdog for StarFive
 JH7100 and JH7110
Content-Language: en-US
To:     Xingyu Wu <xingyu.wu@starfivetech.com>,
        linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
        linux-watchdog@vger.kernel.org,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Emil Renner Berthing <kernel@esmil.dk>,
        Conor Dooley <conor@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Samin Guo <samin.guo@starfivetech.com>,
        linux-kernel@vger.kernel.org
References: <20230308034036.99213-1-xingyu.wu@starfivetech.com>
 <20230308034036.99213-2-xingyu.wu@starfivetech.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230308034036.99213-2-xingyu.wu@starfivetech.com>
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

On 08/03/2023 04:40, Xingyu Wu wrote:
> Add bindings to describe the watchdog for the StarFive JH7100/JH7110 SoC.
> And Use JH7100 as first StarFive SoC with watchdog.
> 
> Signed-off-by: Xingyu Wu <xingyu.wu@starfivetech.com>
> ---


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

