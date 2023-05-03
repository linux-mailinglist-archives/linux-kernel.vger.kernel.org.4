Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50B096F51F7
	for <lists+linux-kernel@lfdr.de>; Wed,  3 May 2023 09:41:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229803AbjECHlT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 May 2023 03:41:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229732AbjECHlO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 May 2023 03:41:14 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04FA44691
        for <linux-kernel@vger.kernel.org>; Wed,  3 May 2023 00:40:50 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id 4fb4d7f45d1cf-50bd2d7ba74so3782766a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 03 May 2023 00:40:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683099649; x=1685691649;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8NQY68XqbO7JS+e1p1la5AoDcZK31JRYis4uxgq0QfA=;
        b=HPYY7y8kbHnPGIJIdzxcTYsIMaDy5akIZtzSPbLXs1Jkb1sIg4pWJdCW4JvKlqe1g7
         caIngIygk9zGEzFKr7RuZfLLLW9ga5ja+DoG1Y/RFrzQ2FSyb6c6R5gX/Eurk43Cy0Vn
         MU4tr/PWk5cT3P22UQ08NeS1k4Uf1WzJGURkpn/QRDseUAtOxrUsMXU7HugtPw+Vgkvn
         4C2uamePFJHN+ZVpMS+oRbJ+8/AXMQfntKg5GPakHkXUgVAze3fFlpMU24fgYat9oJbN
         3DSjdah3i08YWpeqivthjY49wwEsD8OHccbp8wY9MLTbTQfYJE+ZWPtKcORLuy049T6P
         JuMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683099649; x=1685691649;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8NQY68XqbO7JS+e1p1la5AoDcZK31JRYis4uxgq0QfA=;
        b=ct8seZHEd2XKaK17yaZiNFsnrRyaKukMgeR+SB5iwUDBIyTyMQQloda+f798t240oN
         Xx2Dy+N6AHilDP2leuZqmz4UVxrI3EbSaUG7TbpiiAgqpNXfbAY4Mo7DG3KvmoSNe9Pn
         nRZcLEA6xjPL3UY0Ofxco8000o1N/zDgvBRi5nG2oK2bP+3Th7Z3GOUS2PttpOB6pD2z
         5O2RX4hno2Zu/8tl7wvw10TE/JpEtvxg3RSwoSrxZXmD4/BLKBPvr3jtzPveirWJNrpD
         kKGsNvFxt/uvtwodqbNwxwCkvwZNJXD3wQz02x8z8n7WqLm1IO7H274LIDKWOAF3z/oM
         gy1w==
X-Gm-Message-State: AC+VfDzmVyMPIY+QBp4B3+HDndLAg054gpI9mwtwe+18ABqaxhxZCUZU
        YG2iXdg/j8L/aUvWF5QEmxapvw==
X-Google-Smtp-Source: ACHHUZ4Xi2yajxejcFfscwDLAhoe1bPX3XUYKiQXJGEVOJg+sOyaBu++hKVSesCglij+YlxIzfoDCQ==
X-Received: by 2002:a17:907:d1f:b0:961:8fcd:53b2 with SMTP id gn31-20020a1709070d1f00b009618fcd53b2mr1021658ejc.33.1683099649246;
        Wed, 03 May 2023 00:40:49 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:a40b:9d8:1fa0:ecc5? ([2a02:810d:15c0:828:a40b:9d8:1fa0:ecc5])
        by smtp.gmail.com with ESMTPSA id tl18-20020a170907c31200b0095ed3befbedsm9915775ejc.54.2023.05.03.00.40.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 May 2023 00:40:48 -0700 (PDT)
Message-ID: <38599073-0ef4-727d-b372-724526d5904a@linaro.org>
Date:   Wed, 3 May 2023 09:40:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH v2 1/2] dt-bindings: arm: xilinx: Change zc1275 board name
 to zcu1275
Content-Language: en-US
To:     Michal Simek <michal.simek@amd.com>, linux-kernel@vger.kernel.org,
        monstr@monstr.eu, michal.simek@xilinx.com, git@xilinx.com
Cc:     Andrew Lunn <andrew@lunn.ch>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <4ba0eb85629ec5f07902a93fb75d13fff9697eb8.1683099606.git.michal.simek@amd.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <4ba0eb85629ec5f07902a93fb75d13fff9697eb8.1683099606.git.michal.simek@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/05/2023 09:40, Michal Simek wrote:
> Internal board zc1275 was released also to public which ends up with adding
> missing 'u' to board name. Reflect this change by renaming DT files.
> 
> Signed-off-by: Michal Simek <michal.simek@amd.com>
> ---
> 


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

