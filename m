Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F259701682
	for <lists+linux-kernel@lfdr.de>; Sat, 13 May 2023 13:51:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238057AbjEMLvT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 May 2023 07:51:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230205AbjEMLvS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 May 2023 07:51:18 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB47210D5
        for <linux-kernel@vger.kernel.org>; Sat, 13 May 2023 04:51:15 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id a640c23a62f3a-965e93f915aso1890069766b.2
        for <linux-kernel@vger.kernel.org>; Sat, 13 May 2023 04:51:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683978674; x=1686570674;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5fXvNM1OOocy1c4XFoMHwhDURnFswe7IlygyhyjI324=;
        b=WiLE50IRzKyZ1nkD1ZUeB5nK+sPAwg4zi/s5nd5NmRpPqbgYgI46iWOFpZmaMUkB48
         egNGMh7jf6ZJ8fqBESaZ8ahKEDTfYjXo5giN/Uret9CZINcwndFoEu3PXLAyOHH/DINF
         xmh0TN1x0FVw+pfgmYpWnAsPsgdxIwbO1bc+rDLmpsHngWUsV0QpvP0aMqktCOuHsZ+Z
         biWTogXvPQm0/txhqrnVhc/n+cohuitx83L/sGhDr3WIiSzGTSS8FBxCmEKOnIJsjQfN
         XkkIZF6jNjkNf9VXhsmDqyTSbukcs+oxQqI9pSEzDAkE+zMS1BD3ErvmYY0YyIyCDf6S
         apAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683978674; x=1686570674;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5fXvNM1OOocy1c4XFoMHwhDURnFswe7IlygyhyjI324=;
        b=TQbAIkeko/e2dpU59dhOau+ua/9cUMsx7FLVXTaVXJJs9yGnY8GWjWW3aAUYfgavrw
         JZP+lsOfS8KZ42SNXjrx4lTn3XlX8KHyE4sQuRX0NU8w8pfFl7miUVYk1H3ZZMN67IWU
         3U+4rVS+pC6A6nYkc1tp/Nq6sR6hAFzUJF+EjCIKs1Y5XSPQjDK0/GP8VTYU/7Z9yMrm
         LLrj/WEPkC9kBirLazHjhK21RjIxUtptGPE0vQH5US9LNYjpn5jzWmF7XM8bG90xvvTo
         0dVnnc0VUyLEpnQiUNdAgkDBCC80h/VDSoSU4j4eRhIhkeN5Z+FVtk6HBEzZ0DQU8BPe
         SKWA==
X-Gm-Message-State: AC+VfDx4vpkMWU8GFnbrpO9nasMfUBsioP3/xn9b/EfDp6fYM6JG+3sK
        /mThmruuiJcVaWIToXMUwVnpuDg/nsBf0dN3Xb5kKw==
X-Google-Smtp-Source: ACHHUZ5Go78r5pIK8zVmwyH5Y/CpcDgbJebFBwMEwPIUCZD7ZcCeexhq23UboXp8TI3ng0+y5U9IyQ==
X-Received: by 2002:a17:907:1687:b0:958:cc8:bd55 with SMTP id hc7-20020a170907168700b009580cc8bd55mr27494260ejc.0.1683978674391;
        Sat, 13 May 2023 04:51:14 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:a3aa:fd4:f432:676b? ([2a02:810d:15c0:828:a3aa:fd4:f432:676b])
        by smtp.gmail.com with ESMTPSA id x4-20020a1709060a4400b0095ed3befbedsm6699963ejf.54.2023.05.13.04.51.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 13 May 2023 04:51:13 -0700 (PDT)
Message-ID: <06bba9db-25ff-a82b-803a-f9ae0519d293@linaro.org>
Date:   Sat, 13 May 2023 13:51:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] nfx: llcp: fix possible use of uninitialized variable in
 nfc_llcp_send_connect()
Content-Language: en-US
To:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Samuel Ortiz <sameo@linux.intel.com>,
        Thierry Escande <thierry.escande@collabora.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230513114938.179085-1-krzysztof.kozlowski@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230513114938.179085-1-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/05/2023 13:49, Krzysztof Kozlowski wrote:
> If sock->service_name is NULL, the local variable
> service_name_tlv_length will not be assigned by nfc_llcp_build_tlv(),
> later leading to using value frmo the stack.  Smatch warning:
> 
>   net/nfc/llcp_commands.c:442 nfc_llcp_send_connect() error: uninitialized symbol 'service_name_tlv_length'.

Eh, typo in subject prefix. V2 in shortly...


Best regards,
Krzysztof

