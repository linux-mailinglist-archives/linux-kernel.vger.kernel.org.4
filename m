Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FA406C60C8
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 08:31:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231161AbjCWHbF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 03:31:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229903AbjCWHbC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 03:31:02 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9BF62D16A
        for <linux-kernel@vger.kernel.org>; Thu, 23 Mar 2023 00:30:43 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id o12so82598589edb.9
        for <linux-kernel@vger.kernel.org>; Thu, 23 Mar 2023 00:30:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679556641;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kek16teXdLvu7dLTJUflPG5QCIq4J7BlyhkE4cbXZKE=;
        b=I8cwpoxv6YTUsd6ERdnQg6OVW1f0LD50VeDAPcBiQ+5rzFODIOEeQ540UR2wbPBYBn
         3eKaDih2WA30MZ2ndOt/29DowKZ7PCtJyooBJCF0WZmdSDBz3AOWoPFoIQeeHewg2bEK
         6xsrnfjUMH51tmh2cDddfIus/IwcXWkkzlpebpdafdnF7zDeueGePhjCwpLKqSrK90l2
         5hIJeQ3EGGxJsc9egwvbs1RWj7kOlxj8A5ApWhcp8Zqlx7/Q5AzI1/TFRTVdnfWLJN90
         kY6ijlGnCZpdZkCj6VMszJ6F+oiy2mAxRzmiZoFFHP9oblAsdXQ7e7f7JKX3aodN6KCA
         c1+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679556641;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kek16teXdLvu7dLTJUflPG5QCIq4J7BlyhkE4cbXZKE=;
        b=uafK0Z8K+AY7Bi6b4fOIwnPzLK/GB7J5FiAJ/u5U9J5t/KChZ9MywOWV8yxazOF38K
         RtjbL+lA6HRX9GzphzMuW+OLX5Glk2Lip8VLFjzBUSiIUWCysv7UxSaoK4XJBUXFYYa/
         EavJWORwa4jxc7MGSKHsurDKAE9fPBJD0BwlsaLTGRahPm1Qx99KBOJtdIu+jvZ5as/1
         ej0IDvcpb4ficeNgYXIx3D0kseTPhQ/NLn9X8hBaaZz97NruXIjCHTYma+KoC5Qh0q5V
         eF3Gc6K2bgblp4fYUTV5XSHGU+udjhD0kiyDzmTuKVfMcQ/pJhInhqUe0QWov8eGmyYH
         4GwA==
X-Gm-Message-State: AO0yUKXcbj2Sy0xLEy7pi23ErZVgKWquoqUwblVKal7rH+2+mY9WGkE3
        KabySfGzQ9IsE1wjvrvuF/vlDw==
X-Google-Smtp-Source: AK7set9uA8J9hPnS0vlnWcwMtRf84KkJwOekMNfol8X6Euuzn58Q7rv2E10do12tJ2sD8nehQPselQ==
X-Received: by 2002:a17:907:b9da:b0:920:254c:1e2d with SMTP id xa26-20020a170907b9da00b00920254c1e2dmr8972903ejc.39.1679556641524;
        Thu, 23 Mar 2023 00:30:41 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:a665:ed1e:3966:c991? ([2a02:810d:15c0:828:a665:ed1e:3966:c991])
        by smtp.gmail.com with ESMTPSA id hy16-20020a1709068a7000b00931d3509af1sm8156064ejc.222.2023.03.23.00.30.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Mar 2023 00:30:41 -0700 (PDT)
Message-ID: <551fe9b4-4c99-74b8-af44-9f431c488af8@linaro.org>
Date:   Thu, 23 Mar 2023 08:30:39 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v3 2/6] mfd: Add support for the Lantiq PEF2256 framer
Content-Language: en-US
To:     Herve Codina <herve.codina@bootlin.com>,
        Lee Jones <lee@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        alsa-devel@alsa-project.org,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
References: <20230322134654.219957-1-herve.codina@bootlin.com>
 <20230322134654.219957-3-herve.codina@bootlin.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230322134654.219957-3-herve.codina@bootlin.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/03/2023 14:46, Herve Codina wrote:
> The Lantiq PEF2256 is a framer and line interface component designed to
> fulfill all required interfacing between an analog E1/T1/J1 line and the
> digital PCM system highway/H.100 bus.
> 
> Signed-off-by: Herve Codina <herve.codina@bootlin.com>


> +static const struct of_device_id pef2256_id_table[] = {
> +	{ .compatible = "lantiq,pef2256" },
> +	{} /* sentinel */
> +};
> +MODULE_DEVICE_TABLE(of, pef2256_id_table);
> +
> +static struct platform_driver pef2256_driver = {
> +	.driver = {
> +		.name = "lantiq-pef2256",
> +		.of_match_table = of_match_ptr(pef2256_id_table),

Drop of_match_ptr. This will case warnings with W=1 and !OF.

Best regards,
Krzysztof

