Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0EE26B6884
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Mar 2023 18:02:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229749AbjCLRCW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Mar 2023 13:02:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229704AbjCLRCS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Mar 2023 13:02:18 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE2DB39B98
        for <linux-kernel@vger.kernel.org>; Sun, 12 Mar 2023 10:02:16 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id y4so10280586edo.2
        for <linux-kernel@vger.kernel.org>; Sun, 12 Mar 2023 10:02:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678640535;
        h=content-transfer-encoding:in-reply-to:from:cc:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rgjKYDiNYipC88ZW3UHF+hA0Vhj0ajrnhG8vHIgnExQ=;
        b=DC85KbIoQ6u4AzDi2wON4NIiI1EyPel3SDkQPFDj3ZjLXViprPwd5FqrRjrYF+n1GA
         +Z9dEZNG8jUHm1il09//o99LfbprjXw79Bt8iDuVMWIJAclv3B1GBpmkunOXcs5mYcpN
         f1MwVYAflBrLfRLObdWD2lNl/BPm7aTiT0BU6INCJ1DwyCaRF6Pp4b0QoHy+dZ787UV3
         A9C1bSbXlruxDHzPczY9SJKuGhFHKjvpCHAdqjQhvwUVNYn6jaOz2F19lSLoUxtLKQK5
         GDBsII6vQRdGMgNCkPoAQkJZn4AlHGKNPb0IxEah+bY67dU9M/5HGa61p0d1oqfpg5TI
         QvPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678640535;
        h=content-transfer-encoding:in-reply-to:from:cc:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rgjKYDiNYipC88ZW3UHF+hA0Vhj0ajrnhG8vHIgnExQ=;
        b=ogmWRCH1FFNV3ke/CiVPQSJdfhmvq+a7g7x1K/re7/IQW0aw6Lmi2d47Gdicxo+P6i
         XzkkL0f81tpVqCgLi5G5Frw3Uahqs8JOco2SPEKUxOkSWil1IGPXMHj9fvhRUb6H9I/o
         mqdHPxytb9RCCQfwVTb4fqcN+/JDD3NXS9CUhkN+PA4rL8D/PEKVmplwlsiEJGUf++IH
         IbL4rcPuyfl1vtX8w2PBz/FJOQ8MLt9eyjkP//storK8+JgwVqBCTHuzIxdMGtOxmypx
         NK4+CweeiDZ2xYS20eVPbzk2fbNUtZN6QCrjvG+w6czmmSpBNnfi+IDL32KepjJTzNl4
         jcWA==
X-Gm-Message-State: AO0yUKWiyjQcMo00jE4FkG034VpFpnMPyNeKBJJtpblzhNZLnJQk64Pw
        hMzTXsSzPDdXCdQskTVTuVfkjw==
X-Google-Smtp-Source: AK7set+lN36krujxlh4jrXFjE3RNow/G9/atgSZRPgi5PODLMISibgYei+3YocU1q34Rps87czwjTA==
X-Received: by 2002:a17:906:885:b0:8af:5403:992d with SMTP id n5-20020a170906088500b008af5403992dmr32503532eje.28.1678640535354;
        Sun, 12 Mar 2023 10:02:15 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:d9f6:3e61:beeb:295a? ([2a02:810d:15c0:828:d9f6:3e61:beeb:295a])
        by smtp.gmail.com with ESMTPSA id wt6-20020a170906ee8600b008f89953b761sm2385570ejb.3.2023.03.12.10.02.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 12 Mar 2023 10:02:14 -0700 (PDT)
Message-ID: <67454eee-37af-ef38-7e06-23b4c1131468@linaro.org>
Date:   Sun, 12 Mar 2023 18:02:14 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v2 1/4] media: dt-bindings: samsung-fimc: drop simple-bus
Content-Language: en-US
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-media@vger.kernel.org
References: <20230207205834.673163-1-krzysztof.kozlowski@linaro.org>
Cc:     devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        linux-samsung-soc@vger.kernel.org,
        Alim Akhtar <alim.akhtar@samsung.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230207205834.673163-1-krzysztof.kozlowski@linaro.org>
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

On 07/02/2023 21:58, Krzysztof Kozlowski wrote:
> The FIMC camera node wrapper is not a bus, so using simple-bus fallback
> compatible just to instantiate its children nodes was never correct.
> Drop the simple-bus compatible and expect driver to explicitly populate
> children devices.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> ---
> 
> Changes since v1:
> 1. None
> ---

Mauro,

Any comments on the patchset? Can you pick it up?

Best regards,
Krzysztof

