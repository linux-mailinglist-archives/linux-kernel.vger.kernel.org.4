Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AD656BD22D
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 15:17:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230267AbjCPORv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 10:17:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230134AbjCPORs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 10:17:48 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE053C0819
        for <linux-kernel@vger.kernel.org>; Thu, 16 Mar 2023 07:17:22 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id y4so8352732edo.2
        for <linux-kernel@vger.kernel.org>; Thu, 16 Mar 2023 07:17:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678976236;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WnioSOistesU8Od3zTrRwC15YKwRCBre9tYd9dyn/zw=;
        b=D1onYRdwVj5p6iDSAjnWLsPhJWIEh+3DmA0KDnlMdYQdtkIgkThRuNyRQvAlsRo9Wv
         MtZzpdekwOJb/xFgWe/YaQJ5g1uxpRuxInMenjpXcPJItMfRgLmdYIQGzVyym8DEPXM7
         /eSZR22rZA/znDs9EztUEW6vOanQhuw2DXD+bEMriPGktvUuKT7ySYyEVlw+OkGhMLZw
         /rApqKAjuV282uksPlswg4r02/UpXZlfj/9AU+ATvm4xIMcVYCNVFDk5qJXJ1MCBL1o0
         vAgmLIKhWtniUIBWeZA2UGjJhplaaGaJHviEZlQNKPJq0liIwDS5JrNX/UzQi0wfSUh/
         deFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678976236;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WnioSOistesU8Od3zTrRwC15YKwRCBre9tYd9dyn/zw=;
        b=KAQxJxqI93f3orJGJLcX22wwZV2D3EPVi4ArR12htCW1OhI2WFnCxQy8cXR54s5ptH
         /X0mbbfO5gDTYWnGXE99sTo7omEqSM0rQWgVUZr+/sread2bbZZ0mYqVK/refA46HqZ/
         cc8mxa1c8L/cEGUoK39cUZIOnh/O2f1nqKEsM+VDhOjZVWZgFzfphTCcAVkwb8/m09Zn
         HkNqzhGQC+LkFoI3PDWoZsvWk73SnyTOwzRLyIGiCOh/C07s4iGY0Cu3CeUwi9xkVGgy
         CyJWCnUrYCK7KMMImjRXtzADbQ98yxiyEdAGXDTBaMaJMedbQpgxNr8HeY9oCE7W+kbj
         LtxA==
X-Gm-Message-State: AO0yUKVEPDPWM9vNp3+/DUGeJL9fHrSm9puJUaP2Lm9oPHTfWQevZAOG
        8caCp2Hmjc511HYYBhLgZKV+rg==
X-Google-Smtp-Source: AK7set+CrzVj84Duo40QX6EehNjG8zTi3D9GG1+8A4KxLFVB/k6f3nJlxNHv81W7a86sgX6hpCZAcQ==
X-Received: by 2002:a17:906:14c9:b0:8ab:4c4:d0f6 with SMTP id y9-20020a17090614c900b008ab04c4d0f6mr10100131ejc.56.1678976236070;
        Thu, 16 Mar 2023 07:17:16 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:9827:5f65:8269:a95f? ([2a02:810d:15c0:828:9827:5f65:8269:a95f])
        by smtp.gmail.com with ESMTPSA id r23-20020a50aad7000000b004f9e6495f94sm3940881edc.50.2023.03.16.07.17.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Mar 2023 07:17:15 -0700 (PDT)
Message-ID: <c1bc0a26-bdd2-c946-df20-76d169d88c38@linaro.org>
Date:   Thu, 16 Mar 2023 15:17:14 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH 1/3] platform: olpc: mark SPI related data as maybe unused
Content-Language: en-US
To:     Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        Thadeu Lima de Souza Cascardo <cascardo@holoscopio.com>,
        Daniel Oliveira Nascimento <don@syst.com.br>,
        Mattia Dongili <malattia@linux.it>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Javier Martinez Canillas <javierm@redhat.com>
References: <20230312132624.352703-1-krzysztof.kozlowski@linaro.org>
 <63814b1b-1297-da4d-79fe-8f2e58e30482@redhat.com>
 <f9408067-ee3c-9f5b-d1b3-7017113c8026@linaro.org>
 <51d9b1de-5f22-2085-1d3e-6c29afb44120@redhat.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <51d9b1de-5f22-2085-1d3e-6c29afb44120@redhat.com>
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

On 16/03/2023 15:13, Hans de Goede wrote:
> 
> Looks like your right, the spi_uevent() code always emits "spi:xxxxxxx" style modalias even for dt/of enumerated devices:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/spi/spi.c#n398
> 
> So the table needs to stay.
> 
> Can you do a v2 (of just this patch) adding an id_table entry to olpc_xo175_ec_spi_driver rather then using __maybe_unused ?

Yes, sure.


Best regards,
Krzysztof

