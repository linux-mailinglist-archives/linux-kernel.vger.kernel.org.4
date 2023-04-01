Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EA386D3365
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Apr 2023 21:21:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229719AbjDATVA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 Apr 2023 15:21:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229536AbjDATU7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Apr 2023 15:20:59 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96AB81BF72
        for <linux-kernel@vger.kernel.org>; Sat,  1 Apr 2023 12:20:57 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id j18-20020a05600c1c1200b003ee5157346cso17408284wms.1
        for <linux-kernel@vger.kernel.org>; Sat, 01 Apr 2023 12:20:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680376856;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=plPDlN2Tr0cMrBksYqPMB4W1dFCVJlxtuYiCKzlM2kA=;
        b=N6vvvwWG1mKczUs527uyzx4sS1mfCeYM7WzUfumJeD4XxvsGUBAlw/aW7w2wfmjJ4S
         OGyk2kQDXfknoqu5Npe33VVhLFJGkMMKEEXg1nQ+PO02bWVIOUrmm6+I4iukkyT5auA2
         +fnCAM3UqLXnD2ukmZzHgnwbfIHtgCw6xgeli9RNXvQ2jl9ScXknb62I6Kp3nc0yY/m/
         2fN2jVISUssF8xCTn6uNSFhwFCe3IfJQ/PwbigyRHfaGmYQAxbwAGEIl/73VNLMLS6ug
         moACy/9G5Ai7hHnuYmcyfyi+0Y7odBtPz7HG4Hurlc4zfHlTIjUZ1r/YwJOiy+FuFRkf
         LqJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680376856;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=plPDlN2Tr0cMrBksYqPMB4W1dFCVJlxtuYiCKzlM2kA=;
        b=2TCX1SnCLTF7pfzZwl0d4ypFjk+GdM41IPJVEWZq5If0j8CXfWO5So2msKu+oWJFLD
         BjTctY+j0IVMYgeXTetcd6bm0XQsza14TWRwSihQa+D816mp8BHP9IAGdnEGhoBQwdJU
         a5HgTcK4MIMZ74Q3ETbFnmYf6A3KgZwTI4RUNVVBd489ed1+tVCBvcS7A8GBwJzrfoqP
         Oc+PPh7UGZPRJHsWwYM++3bF+qpsduLyfSv61WyszoB6qknkGlt+pqBRlMs073vYzfbJ
         NNQjyD121ETouTfuMAU8EK5Y2k9NA5rIFAbHSIXPHHaU5Z0kJsWvpfV/5i3dSlqQChVx
         5ylg==
X-Gm-Message-State: AO0yUKUBZJv+WOHOIk9rHE8VJDM9G/UOh7K5vscrSHK0hmd+BvpYtFTj
        sTss8TR+iiAC98ZP0vwhBSQnqQ==
X-Google-Smtp-Source: AK7set9n2bp1LQ5Oq1vYpwvsVHtNuSCeA80cHG3EPpiiO1khSV8FamfPvw/Dae78HiIAdi5xZH4U3A==
X-Received: by 2002:a05:600c:b55:b0:3ee:6d55:8b73 with SMTP id k21-20020a05600c0b5500b003ee6d558b73mr23092656wmr.29.1680376855933;
        Sat, 01 Apr 2023 12:20:55 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:b36a:1186:309c:1f9a? ([2a05:6e02:1041:c10:b36a:1186:309c:1f9a])
        by smtp.googlemail.com with ESMTPSA id n2-20020a05600c4f8200b003ef5e5f93f5sm14113747wmq.19.2023.04.01.12.20.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 01 Apr 2023 12:20:55 -0700 (PDT)
Message-ID: <0c26074c-a0dc-e0e4-899d-c3f4f10922af@linaro.org>
Date:   Sat, 1 Apr 2023 21:20:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH] dt-bindings: thermal: Drop unneeded quotes
Content-Language: en-US
To:     Rob Herring <robh@kernel.org>,
        Guillaume La Roque <glaroque@baylibre.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>
Cc:     linux-pm@vger.kernel.org, linux-amlogic@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <20230327170233.4109156-1-robh@kernel.org>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <20230327170233.4109156-1-robh@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/03/2023 19:02, Rob Herring wrote:
> Cleanup bindings dropping unneeded quotes. Once all these are fixed,
> checking for this can be enabled in yamllint.
> 
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---

Applied, thanks

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

