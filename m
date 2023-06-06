Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF37E723C27
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 10:48:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237264AbjFFIsx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 04:48:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237258AbjFFIsv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 04:48:51 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D857100
        for <linux-kernel@vger.kernel.org>; Tue,  6 Jun 2023 01:48:49 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id 4fb4d7f45d1cf-51458187be1so8906640a12.2
        for <linux-kernel@vger.kernel.org>; Tue, 06 Jun 2023 01:48:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686041328; x=1688633328;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hEQ4HPULxJqLeCH0M0TT69ZvT5utSd01v7nSaj1PvbU=;
        b=A9gNWmcYIIRYaDF807Oc872JCxo8NSUJuIf4qlKishgVQMwiQuZ4iRC0aq7QqO6b3k
         sP2IwTl6dmvYZQqpEOpHJxjKJ8B81I7rmi064X5aoWTYnpFmiIUQLYcFwJFoXlByTcpr
         Ha8eZaxcilxZtJb7NOWtvf0AgHCHYtHbuSlj3VN7Lbe+ShKekdgPznj62a2sF3Fwliox
         3H9xrV5WwQz6dYWCrGWFRcXmUcNDCQ/aI70zTMITc0hbNLZwoBgglp7MRlske0JhD7XQ
         ahtMLwHaw+z1e7gTCt0tkOhcJGRHa4vFFPYWo1s+Qv1YB6x7QY2fl5HfarICQ6/Qa5zO
         DrBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686041328; x=1688633328;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hEQ4HPULxJqLeCH0M0TT69ZvT5utSd01v7nSaj1PvbU=;
        b=dZaO54Hg0JhEgUnjcWLHeeJb5tfrRoD4bA5nE3sqVwiOPk8Ts0dYOfRuBZ9A7sgmHY
         9tWKSoV7vUbtPjnsWLJH/uQ9rd8WVIekBYP+NmGT57IV7JQY7Uwdk36+95fOzvoTxQU8
         b2HL07aTphuagaE1yVRUQEtFXWZOTrYCj9lnXIkIQQWIcTL407LhpfAmCOBWVJWU3AUX
         xUheAMJXK/rHVgQvs8Izm+HS8qb7BpFGq/IT2qq7kogmPpLErWap3C8kirXwkxLPR9m1
         +9n6JaErS++v+vvgEzEWBoVdxWipVNiZ2EU8UpMdSpUwXrlWVVHJP2NKk8sMlyJEZynA
         pCHw==
X-Gm-Message-State: AC+VfDyN6ewFtUeyclJG/2I/NiPpdr+D7Tu+p7hAP5wvbjJEGBqrVnw6
        zOyMqpNZlzm0UqU8IcHekNrMGFzza4lNj1h7I8zpKQ==
X-Google-Smtp-Source: ACHHUZ6EgOGCiNQhxd/unjp+HDUP7doEpWuo3o4zdAJNkkBfLrPpOX9anpQ0M/lpmLuAEHlh/YUhkw==
X-Received: by 2002:a17:907:6d04:b0:973:946d:36b2 with SMTP id sa4-20020a1709076d0400b00973946d36b2mr1483816ejc.56.1686041328098;
        Tue, 06 Jun 2023 01:48:48 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.219.26])
        by smtp.gmail.com with ESMTPSA id l14-20020a1709060e0e00b009745eddf997sm5307905eji.198.2023.06.06.01.48.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Jun 2023 01:48:47 -0700 (PDT)
Message-ID: <859da276-959d-b1e8-52e2-45e02f65c3ce@linaro.org>
Date:   Tue, 6 Jun 2023 10:48:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH v4 1/2] dt-bindings: clock: fixed-clock: Add nvmem support
Content-Language: en-US
To:     Mike Looijmans <mike.looijmans@topic.nl>,
        devicetree@vger.kernel.org, linux-clk@vger.kernel.org
Cc:     Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>, linux-kernel@vger.kernel.org
References: <1b153bce-a66a-45ee-a5c6-963ea6fb1c82.949ef384-8293-46b8-903f-40a477c056ae.2d27bfea-4746-444c-89f4-e5d35cb7de66@emailsignatures365.codetwo.com>
 <20230605140149.16841-1-mike.looijmans@topic.nl>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230605140149.16841-1-mike.looijmans@topic.nl>
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

On 05/06/2023 16:01, Mike Looijmans wrote:
> Add bindings for a fixed-rate clock that retrieves its rate from an
> NVMEM provider. This allows to store clock settings in EEPROM or EFUSE
> or similar device.
> 
> Component shortages lead to boards being shipped with different clock
> crystals, based on what was available at the time. The clock frequency
> was written to EEPROM at production time. Systems can adapt to a wide
> range of input frequencies using the clock framework, but this required
> us to patch the devicetree at runtime or use some custom driver. This
> provides a more generic solution.
> 
> Signed-off-by: Mike Looijmans <mike.looijmans@topic.nl>
> 

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

