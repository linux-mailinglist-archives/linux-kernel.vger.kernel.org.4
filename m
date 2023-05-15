Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 173E57024BE
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 08:32:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238522AbjEOGcT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 02:32:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239291AbjEOGcR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 02:32:17 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F121100
        for <linux-kernel@vger.kernel.org>; Sun, 14 May 2023 23:32:16 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id 4fb4d7f45d1cf-50bdd7b229cso22334126a12.0
        for <linux-kernel@vger.kernel.org>; Sun, 14 May 2023 23:32:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684132334; x=1686724334;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=A8a1pVM0DGaS6W157+gRqo4eM7NjJYx+JRCtEwK9RVc=;
        b=X95T5aNKRiJwuBsbVb8C0GoOMrInmKOp5JQPOcKq6pUuAIOUxsSvf7wS2Ve/SCuLYG
         FCFhplDCdm3cIshKUJ7Oc8xsJXrxT7zHF3wFKxAx8sQQSq1We2ikruwy0I6QTaN5a5Vx
         5MklXle+9kdlCHyDlpcjVkO4aWp7MrEzJgd8pd9a84Ie/DVbVPKGRzbee152l7CJKP4d
         c0aZ4lp4j2MKNBXXMqZTsCxXvgeY2IMIcQkcE9HqbHo6Wll4UX0dkkOlkzHiZENfUwU9
         Ilo/rXT4fnsKi9KGdurJqUXLZeNZF90LaFAcKfOQeS0026JDQrPdqF1A8P77SRaT6MpG
         KVnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684132334; x=1686724334;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=A8a1pVM0DGaS6W157+gRqo4eM7NjJYx+JRCtEwK9RVc=;
        b=HGpyArvUmTyj0Es7D7wpq9FhoUETdV9eaSg1WOSrmQw31+MwvmL2yqBp+o+haNnWyU
         KlhPQkUUh6Zm0sX7TigIyOKFcuPnga9Pj1AH55FzQa/0C+2LLGzi6LZVSBoukmatEQpS
         Tr/rUJaqyp5AOMyX4A9sDcgcYJrZkN8HB6/baF9diM+z24rNfxmm8J5L3eDPPHiIO8tH
         4w/ogS1T8yyKNzjxEYCl+HljdEJ8ajX/fWuwvIqOwRATKwuBdZpGK7mRsoMj2vTFwtHU
         ncuXxmawcJaAfLgHGhcdiEsRI/+fs2yTm1t3CmmERhclb1saD9KEgHmpjvfDtdaeBfIY
         eXDw==
X-Gm-Message-State: AC+VfDyk0dbq0i6ix67JeKrI0NOqi2gvVKkj1lqPmLDY38AU4mPBrA+z
        P6trqqj1KBaGAtP/AHlYOD+1BA==
X-Google-Smtp-Source: ACHHUZ6sKt1eBJkYlCxRQgz0lccW3BVyRVXju0DAlM9C3GIp+OCy5RuvfUTTAHCZJzcT/to3hYZalA==
X-Received: by 2002:aa7:d853:0:b0:4fc:725:e670 with SMTP id f19-20020aa7d853000000b004fc0725e670mr22863203eds.11.1684132334593;
        Sun, 14 May 2023 23:32:14 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:6470:25b8:7c2d:1992? ([2a02:810d:15c0:828:6470:25b8:7c2d:1992])
        by smtp.gmail.com with ESMTPSA id l1-20020a056402344100b0050504648fc4sm6870988edc.80.2023.05.14.23.32.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 14 May 2023 23:32:14 -0700 (PDT)
Message-ID: <590560c9-4da6-bbd4-6aac-de57ab5403ba@linaro.org>
Date:   Mon, 15 May 2023 08:32:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH V8 1/4] dt-bindings: clock: document Amlogic S4 SoC PLL
 clock controller
Content-Language: en-US
To:     Yu Tu <yu.tu@amlogic.com>, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     kelvin.zhang@amlogic.com, qi.duan@amlogic.com
References: <20230515031557.31143-1-yu.tu@amlogic.com>
 <20230515031557.31143-2-yu.tu@amlogic.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230515031557.31143-2-yu.tu@amlogic.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/05/2023 05:15, Yu Tu wrote:
> Add the S4 PLL clock controller dt-bindings in the s4 SoC family.
> 
> Signed-off-by: Yu Tu <yu.tu@amlogic.com>

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

