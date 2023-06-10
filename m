Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E966372AD67
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Jun 2023 18:38:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229482AbjFJQid (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Jun 2023 12:38:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230047AbjFJQi3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Jun 2023 12:38:29 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A17235B6
        for <linux-kernel@vger.kernel.org>; Sat, 10 Jun 2023 09:38:26 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id 4fb4d7f45d1cf-5162d2373cdso5018132a12.3
        for <linux-kernel@vger.kernel.org>; Sat, 10 Jun 2023 09:38:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686415105; x=1689007105;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=o5Z8VlvkCStH7vxf1jFhlFENo/0pPXJ8U3fEycKzrWA=;
        b=PRoSKAG2RDvzzPUABOLOymit81bQYaB+0lNRFd6731dseHDZ5c8naeisILruqRSdA1
         ie+Q3Hbq9Wlvbb6x80oshl7FDG/DXYC1CIeUUugs49wKb4IFvS2KVkfMl4Nuw3jDnS8q
         CYHw+zfbxckF74Rz7FT716uIhU3f66A71BEbGTIBGunm68/5s6R9U9xq++RgkwRwIDqF
         tNREd/ZsLYzOZjKvoVuZ2WRKRKfhsCJH6l1Qhai8j8hoF+8Qkt1HtDUg6rYkOPGV0h5A
         JKljseim/7VvNNQ5N6SVBDR5Qw2oxcqpvgnGGKUQ6lWpGZCWvV+9BKM81dmanrqkYpSD
         65uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686415105; x=1689007105;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=o5Z8VlvkCStH7vxf1jFhlFENo/0pPXJ8U3fEycKzrWA=;
        b=RL+xTqvj8i9MrzisZdCrsSUmzbCWkfe6NTLpCqs15T+p8L5GDJu8z904sVd63E1qlY
         15vXJGswig8OsitXr2IPgVfqwVcmnwOs4+Jf0rGREMMaCWgZtlbVFcHkXbOAPu/yVK9/
         DkSLrQIxVZlfpB49B7uwxaNJixzlSKb0yXvLLMeqIuuZ45pj3h3ObEr1R5sJIyLn57kl
         8y6/xLqpgbsjhJ1MbjFFmqNSPNRkM248y1YW/vbxwypy/P71D/Kz05kLmj6ZFPeuMDKq
         0zbAWo4q3t11vVpYCHWSBuO4E0fNZp6XX9U2IiiyGAGSBGUcbSfcnHoDOajaEIy3+nXD
         fE6g==
X-Gm-Message-State: AC+VfDwwHTmzhtzHhl/2tPjj2wWtwIF+bexfjI+bpF82ATTSs9AulwTN
        nFVpLKAI2Aw4+JwrMN8W24Xdew==
X-Google-Smtp-Source: ACHHUZ506o3wBTlotTQVHg2X72UPSYjMikadLcES55vMuL13uBnezt6/6muniiigdJhpo1pXJ5vzLg==
X-Received: by 2002:a17:907:1b0b:b0:978:6a98:a019 with SMTP id mp11-20020a1709071b0b00b009786a98a019mr5275123ejc.33.1686415105087;
        Sat, 10 Jun 2023 09:38:25 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.219.26])
        by smtp.gmail.com with ESMTPSA id a18-20020a170906469200b00966265be7adsm2752005ejr.22.2023.06.10.09.38.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 10 Jun 2023 09:38:24 -0700 (PDT)
Message-ID: <e69cf560-4cd2-4b80-97c8-3f02a4118982@linaro.org>
Date:   Sat, 10 Jun 2023 18:38:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH 08/18] dt-bindings: clk: g12a-clks: expose all clock ids
Content-Language: en-US
To:     Neil Armstrong <neil.armstrong@linaro.org>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
References: <20230607-topic-amlogic-upstream-clkid-public-migration-v1-0-9676afa6b22c@linaro.org>
 <20230607-topic-amlogic-upstream-clkid-public-migration-v1-8-9676afa6b22c@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230607-topic-amlogic-upstream-clkid-public-migration-v1-8-9676afa6b22c@linaro.org>
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

On 07/06/2023 12:56, Neil Armstrong wrote:
> Due to a policy change in clock ID bindings handling, expose
> all the "private" clock IDs to the public clock dt-bindings
> to move out of the previous maintenance scheme.
> 
> This refers to a discussion at [1] & [2] with Krzysztof about
> the issue with the current maintenance.
> 
> It was decided to move every g12a-clkc ID to the public clock
> dt-bindings headers to be merged in a single tree so we
> can safely add new clocks without having merge issues.
> 


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

