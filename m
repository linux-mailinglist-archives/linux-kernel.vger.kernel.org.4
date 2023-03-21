Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0661E6C2B2B
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 08:15:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229939AbjCUHPS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 03:15:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230145AbjCUHPP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 03:15:15 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21EAD1CF6D
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 00:14:50 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id b20so22954381edd.1
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 00:14:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679382888;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=M4t1T5XRRC5ZHCGScnYtpQMNl2moM1EjSya2/Yva1+0=;
        b=MgN+DnFwOslAm2H1VG6SjHf4DBvn5KCqyour0bu1fZCPnoMRBLjuhRxBaxsFNLuhlH
         7iHJz1miWAe5AkSzP0XmRzK/9hHZd5sT5D+9tapwi7hbXiigkYfgK8UkJqfgLPMpGCv7
         KUECoqnkv5OWUMpQNnFvQEB5IT0uDxMzf61TFm/9mKBkF19ARzpQjxNtgk0am86YIrKu
         hosOYh+KyLxAgku3gLeAzKIajdR546bPB5byVrJkqIYLChTkx2z6XSTldPInOYQ3xtoc
         NgUZn6ioybF9hUaohwflZ4XAzp9wBCgaGXiVpzt3BlPcRPMXIKoipWxTfZmreaipD+lQ
         oNKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679382888;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=M4t1T5XRRC5ZHCGScnYtpQMNl2moM1EjSya2/Yva1+0=;
        b=UxezWdzJDc/3D/ezx9TC6D/sT4dQVBqfwJWljiKjECcafpClAsyaVARvzpo6BlWvpT
         kjTxAIH0nKq7CnUGUYN0wj/WdMYHM+wknLyAkYUlPXp/D1XseyRnCG/RsW4e2Mqa34iO
         Uv65dcVmA+F8eswEBDo7x8GklRYOdvHtQGoTptGik4UNqhTdLxBmd3yDyMzUCWaMTeLR
         N8zfBjNXTj66WCid3l31uT7WBm7v/iMsTAiyttvw+EUN+hAyeVGYFe3x+//ygW/NlShy
         D71Npdhw4TWAj7pIA4I2c1jdditHRAZg4TnAGN4J+Bv5YllSEr5L092EN5k+eO9Frakv
         ps8Q==
X-Gm-Message-State: AO0yUKVZZYGsIy2scagf6QPWtzYrqYoxECzLvn28se3PA4/SGk02PwAR
        Yqil9dsoesjqbkHmbTwB1FmrBtk5/biRxtq11pQ=
X-Google-Smtp-Source: AK7set8HSDMH20FHlDwabgpM+fmKvPpTNXYH+/3GNac5eCufpUbxhwTEFZVA70HNYCg42ZQCeBVdvw==
X-Received: by 2002:a17:906:6948:b0:932:8cd:1021 with SMTP id c8-20020a170906694800b0093208cd1021mr1694382ejs.33.1679382888760;
        Tue, 21 Mar 2023 00:14:48 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:2142:d8da:5ae4:d817? ([2a02:810d:15c0:828:2142:d8da:5ae4:d817])
        by smtp.gmail.com with ESMTPSA id h19-20020a1709070b1300b008ec4333fd65sm5368877ejl.188.2023.03.21.00.14.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Mar 2023 00:14:48 -0700 (PDT)
Message-ID: <6ae0362c-a029-debe-6daa-cfe900756682@linaro.org>
Date:   Tue, 21 Mar 2023 08:14:47 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH 1/4] dt-bindings: net: dsa: b53: add more 63xx SoCs
Content-Language: en-US
To:     =?UTF-8?Q?=c3=81lvaro_Fern=c3=a1ndez_Rojas?= <noltari@gmail.com>,
        f.fainelli@gmail.com, andrew@lunn.ch, olteanv@gmail.com,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, netdev@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230320155024.164523-1-noltari@gmail.com>
 <20230320155024.164523-2-noltari@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230320155024.164523-2-noltari@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/03/2023 16:50, Álvaro Fernández Rojas wrote:
> BCM6318, BCM6362 and BCM63268 are SoCs with a B53 MMAP switch.
> 
> Signed-off-by: Álvaro Fernández Rojas <noltari@gmail.com>
> ---

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

