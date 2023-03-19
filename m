Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6E3A6C01A4
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Mar 2023 13:29:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230167AbjCSM3v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Mar 2023 08:29:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229689AbjCSM3t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Mar 2023 08:29:49 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A7F8144A2
        for <linux-kernel@vger.kernel.org>; Sun, 19 Mar 2023 05:29:48 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id ek18so36903033edb.6
        for <linux-kernel@vger.kernel.org>; Sun, 19 Mar 2023 05:29:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679228986;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UsUw48AeQfsuxhASleLQv/pMcvboLL7epplAN7QGvnA=;
        b=e11tqFxkO2vEWgK/fYt4JNN1jqJ6BmE7iiWx1OBXuupEzGzzxx73gK6UmKgZNqO3lM
         b///VqVZaAouyjcn1bsy8R+vZ10Y0XsnW5FtYRXvOeG3E2hmpF5CTDpZvWCVCtjgUYHT
         A99eDabjw7KHBjfYOibtRWRYNlEf575FSChx0SHbSDs0G6/ucCQ33tMdqZECj5g+x8zZ
         rvGwfHMdgVAR6azQzWh256MWjgnJmMz8q6UPhjPc8IBbyha11ahGMu0JoXvxQ7Gr8lM8
         nLQNX5t0SJ7lmjISDuw8eSlLx4V2FVojXb+a/YYVbTzb90sng5xVh0tPDUbKtq+M4ObH
         HEfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679228986;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UsUw48AeQfsuxhASleLQv/pMcvboLL7epplAN7QGvnA=;
        b=uD+a8Orm222viNOM4r69QZUA0s9PZd07r8oaviWtR0N4FJRHMhGgtt5AzH+JGj13jj
         eW3hfWWQQQXIXdeQxTUD6h/X3JLJNh4hnvx25f/9j/PeN1cdTJ9OTRZkFygIs8tzJH9G
         6aN8N4967oQE/+4VaAg5Xp4umNqXQVC0UixIEf9mLOnzeP7KmEq3tRmzGDXWn/jH0Qku
         yQcGgzKYZRVDMomWCId2KBstxw5OGHQpvazleTB3kLa3W7I99V72XL1GqOdKzs2dB+SB
         uWin9L/kCSr0yvA6lYJEPiEi96riTIzooQaRY8ksx0P2AJj+COPlXXTC05oSm9TKj4gH
         h/1A==
X-Gm-Message-State: AO0yUKWJMxSTIeEfIJoxQVpLiTF3k8TWip9LpURk5xNnp2tS3rRHrmbm
        QQg59wGXMPCORjIOrM46nN+Mzg==
X-Google-Smtp-Source: AK7set/sIqucjJzsdjLw5anFET0hlUfDmKmuGp8IZBJkYMcu3uNQirYCo+/8Hw66VbUsFcgrAUJkKg==
X-Received: by 2002:a17:906:36d4:b0:932:d2bb:507 with SMTP id b20-20020a17090636d400b00932d2bb0507mr6793730ejc.24.1679228986490;
        Sun, 19 Mar 2023 05:29:46 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:5b5f:f22b:a0b:559d? ([2a02:810d:15c0:828:5b5f:f22b:a0b:559d])
        by smtp.gmail.com with ESMTPSA id r10-20020a1709063d6a00b00930e95446d0sm3185334ejf.120.2023.03.19.05.29.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 19 Mar 2023 05:29:46 -0700 (PDT)
Message-ID: <9dfc752b-7ae9-5e45-e9e2-50b87dabbca6@linaro.org>
Date:   Sun, 19 Mar 2023 13:29:45 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [RESEND v6 1/2] dt-bindings: soc: starfive: Add StarFive syscon
 doc
Content-Language: en-US
To:     William Qiu <william.qiu@starfivetech.com>,
        devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor@kernel.org>,
        Emil Renner Berthing <kernel@esmil.dk>
References: <20230315055813.94740-1-william.qiu@starfivetech.com>
 <20230315055813.94740-2-william.qiu@starfivetech.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230315055813.94740-2-william.qiu@starfivetech.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/03/2023 06:58, William Qiu wrote:
> Add documentation to describe StarFive System Controller Registers.
> 
> Signed-off-by: William Qiu <william.qiu@starfivetech.com>
> ---
>  .../soc/starfive/starfive,jh7110-syscon.yaml  | 41 +++++++++++++++++++
>  MAINTAINERS                                   |  5 +++
>  2 files changed, 46 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/soc/starfive/starfive,jh7110-syscon.yaml
> 
> diff --git a/Documentation/devicetree/bindings/soc/starfive/starfive,jh7110-syscon.yaml b/Documentation/devicetree/bindings/soc/starfive/starfive,jh7110-syscon.yaml
> new file mode 100644
> index 000000000000..ae7f1d6916af
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/soc/starfive/starfive,jh7110-syscon.yaml
> @@ -0,0 +1,41 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/soc/starfive/starfive,jh7110-syscon.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: StarFive JH7110 SoC system controller

OK, I found the patch changing this. So basically you add knowingly
incomplete bindings and a second later you fix them.

Add complete bindings.

Best regards,
Krzysztof

