Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6396737B2C
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 08:25:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230121AbjFUGWp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 02:22:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230221AbjFUGWh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 02:22:37 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3DE410CE
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 23:22:35 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id a640c23a62f3a-98cd280cf94so23234966b.1
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 23:22:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687328554; x=1689920554;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nOnf1IwNAj9eWxqQ3NaJ61zegJDoEg9fxsPDNf+LrA8=;
        b=vLX1S8h70Y3uUmQ/uz4k+GVA5A6NGNFwW+5QH0qR0xEsqi6M4PO1VXFbQ0gOsZ1xeC
         s1ZHpq8nrTlMfUgVzIjTB6UVhgosmiQ137q9Nx7E7Br6oShSph0awERCcjxHb+KocMEJ
         8ySw5/qTmMP1MGC1oNVTl9LozTu6jWMHVEI9KMWKgdS8SYmf7xKExkglqOePbvq60sjq
         lWNYBbbznPB8J9mqve6iC1cITm2l0OVg8FS0xYrdtEGvvSzA5WBAuyyGe2NtXtdljxxI
         tCqYH6zER5FtIQO2hAW2Sr9o6LD5Men0ohhsbDSAbRPCiuzzyJnmF8YW5eyFNiIPufmv
         HSPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687328554; x=1689920554;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nOnf1IwNAj9eWxqQ3NaJ61zegJDoEg9fxsPDNf+LrA8=;
        b=R7NnVj1bnDlI6J3Lct/K5xcipjCZy/jsV9mXhfwKsZ28nbzK6hxJ6cYTjfDcNHTV7F
         QfQFm/scIMtqOQud+Y9zvaiXg+JJ/CFNsW0/wPdBw/l75ss0R1bLNA6MQ7TgzmoRlMGa
         vvwwoT7VNxpVx5U+Gal0rtO1pAxl7ijghdQaNLWwpT5Rf/OBkfS3b7te3MOi8NjYD2L6
         EJFXkn+16L5R2A0qLBaOvVytRHCoQQZBEUbx2YSrKPRHwrWIitCCgnacqyXJ5AMnsLW/
         3dyeREL1u6WZ8FUfbvGgfszUo7KINm7BHKNHGofYzBkclNaFmnJdVozZEaHce9jkmxAg
         FIjg==
X-Gm-Message-State: AC+VfDyth3+cc9EaHyJH+yVPWy0PQdg26lMSBzyw1bMUTNEvAiGCrNgF
        GEWEc4Rz26NcnpVUOBLYFKVzwA==
X-Google-Smtp-Source: ACHHUZ50+qrhepCQsuUeAYYv6aa5weBNKXA3yMmkFj+KS1yKcgIV10DK2KspkSILnaZUEwc3l7KYaA==
X-Received: by 2002:a17:906:9748:b0:989:d9d:d8f7 with SMTP id o8-20020a170906974800b009890d9dd8f7mr4458595ejy.5.1687328554140;
        Tue, 20 Jun 2023 23:22:34 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.219.26])
        by smtp.gmail.com with ESMTPSA id ju15-20020a17090798af00b009788554ad10sm2547201ejc.138.2023.06.20.23.22.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Jun 2023 23:22:33 -0700 (PDT)
Message-ID: <66d5a117-abc7-e147-f416-5366706b5f26@linaro.org>
Date:   Wed, 21 Jun 2023 08:22:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCHv4 1/2] dt-bindings: arm: rockchip: Add Firefly Station P2
Content-Language: en-US
To:     Furkan Kardame <f.kardame@manjaro.org>, robh+dt@kernel.org
Cc:     krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        heiko@sntech.de, broonie@kernel.org, deller@gmx.de,
        dsterba@suse.com, arnd@arndb.de, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20230620184746.55391-1-f.kardame@manjaro.org>
 <20230620184746.55391-2-f.kardame@manjaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230620184746.55391-2-f.kardame@manjaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/06/2023 20:47, Furkan Kardame wrote:
> Station P2 is a single board computer by firefly based
> on rk3568 soc
> 
> Signed-off-by: Furkan Kardame <f.kardame@manjaro.org>
> ---

This is a friendly reminder during the review process.

It looks like you received a tag and forgot to add it.

If you do not know the process, here is a short explanation:
Please add Acked-by/Reviewed-by/Tested-by tags when posting new
versions. However, there's no need to repost patches *only* to add the
tags. The upstream maintainer will do that for acks received on the
version they apply.

https://elixir.bootlin.com/linux/v5.17/source/Documentation/process/submitting-patches.rst#L540

If a tag was not added on purpose, please state why and what changed.

Best regards,
Krzysztof

