Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2A82734BF4
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jun 2023 08:56:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230104AbjFSG4b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jun 2023 02:56:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230095AbjFSG42 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 02:56:28 -0400
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22AF913D
        for <linux-kernel@vger.kernel.org>; Sun, 18 Jun 2023 23:56:27 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id 38308e7fff4ca-2b46773e427so24042911fa.3
        for <linux-kernel@vger.kernel.org>; Sun, 18 Jun 2023 23:56:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687157785; x=1689749785;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qVQvPmZfMjyE4EriF44N+ZqOy+pXJULp7jhybIMTZRg=;
        b=Nz7oMq/2JerE/qSJ0p1lmM0Tc6F/T4n0tY/5puv07oURkxjNaE3hnag7QPHhBQjjtu
         pVxH+uT/izoeyx1d4ygzWZPMkHcF3kXs3BSobsB0Z/iATiWJ9slFaccqjZs+5nVaRg9l
         xaKTFpVuIW6y12JVg0ZeDuO+vLXn8SIDk8GUMppBI4UXBKFzuGKyX1xVaYDLDQjWsubT
         550gEcY9B6WXteuUHKUJk3DU3p4BUHhK3cLpmq4h93naDBxH8tvUzPG3dSwkmteTcnxE
         pIXu6PX7TznbjL37tyhAa4kt9fasvG4OKhMLYeiqIOMBjWBxam5eGAM8trzdor1oITs/
         yIEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687157785; x=1689749785;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qVQvPmZfMjyE4EriF44N+ZqOy+pXJULp7jhybIMTZRg=;
        b=JBD9tgsWht5WlezXOYGHGrgSqf6fd4RCv7YKCtNWAIxB2b8336WNUydbjQ8I5wVHjc
         UCXl7eHtKNAzisAo0kHsjLWGgROgDXGCWqkGQzsDaBjAezQjDMNYvp96O8HVLCn8G85F
         E7+vPLoPeOm7QcpbUGrREES/fwU1dzJtVQPWs+sXLPL2UYo7ogIz3mLKT61iEtjG/Ods
         SsolCMJwwWgpqpAIdbyWT55Tf+E7m1cWaOpXe6rnfLn9+ZvLdWJcbTBy6Di5BpPLn3Sc
         LXLUiWKiKLPHlQRpcMbN1qEFfUizyvQ6pTySr9OOZA1Kwq09CUj83jfxUD2dFdNNHqP2
         E6RA==
X-Gm-Message-State: AC+VfDzYLGMQiaFMIJooSX7tF2yYuz3kxoNsdqXd7gems1j3YyzFSnj4
        0YnYAtJ5MaTQEZiGrpxJVi+aPQ==
X-Google-Smtp-Source: ACHHUZ73QHeatxNWNXWGjtENaICZG2mDwLhCI1onbdo3FjYTjn3nlSLNYVQvlsMOir4Fl3iZo9lkMQ==
X-Received: by 2002:a2e:9a8f:0:b0:2b4:470e:8447 with SMTP id p15-20020a2e9a8f000000b002b4470e8447mr5553201lji.34.1687157785301;
        Sun, 18 Jun 2023 23:56:25 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.219.26])
        by smtp.gmail.com with ESMTPSA id o8-20020aa7d3c8000000b0051a575c76e6sm1172846edr.43.2023.06.18.23.56.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 18 Jun 2023 23:56:24 -0700 (PDT)
Message-ID: <2a9e503b-7a5b-3b1e-a912-5d54a23c1ca1@linaro.org>
Date:   Mon, 19 Jun 2023 08:56:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v5 1/2] dt-bindings: arm: aspeed: add Inventec
 starscream-bmc
Content-Language: en-US
To:     PJ Chen <chen.pj@inventec.com>, Arnd Bergmann <arnd@arndb.de>,
        Olof Johansson <olof@lixom.net>, soc@kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-aspeed@lists.ozlabs.org
Cc:     ye.vic@inventec.com, Huang.Alang@inventec.com
References: <20230619064249.3623-1-chen.pj@inventec.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230619064249.3623-1-chen.pj@inventec.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/06/2023 08:42, PJ Chen wrote:
> From: Chen PJ <Chen.pj@inventec.com>
> 
> Document the new compatibles used on Inventec starscream-bmc
> 
> Signed-off-by: Chen PJ <Chen.pj@inventec.com>

https://lore.kernel.org/all/3106c4a1-ce5b-a9c4-5cf4-6adead7fce80@linaro.org/

https://lore.kernel.org/all/2e06e7db-64f9-51f8-adf1-b240f30a2608@linaro.org/

What's unclear here? You did not care to respond to that (the second
part of that message).

Best regards,
Krzysztof

