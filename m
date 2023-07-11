Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F41D74E832
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 09:38:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231273AbjGKHiR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 03:38:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231124AbjGKHiO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 03:38:14 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A7801A8
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 00:38:13 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id a640c23a62f3a-986d8332f50so658020466b.0
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 00:38:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689061091; x=1691653091;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Rx8H9As3YW36H58C24CHOAt5gVbFUaVPwH/qkPeltgA=;
        b=Otb6Q+H12C1MG49c1/HOyW7wiMJN3PdzI8R2HXi0dC2zkhD+hwgITRq0B3rbrnBlHC
         aBguDm3mJMekGZR5U2fHR8L9oIy/FrejZFLiprGMiJimOuqgz7o5hxLzrWJ/NEg2TrVx
         T+UOFANp8SygESr+6KxyAi/j8Jg4TdCKZLvBZ2HmFuF4fcHsYicldL+agjgh8xw9M8D7
         qtwNsz+Ol/NtMPVER8P4T3FCvcnPW8BDSZlAbA1gLtFrXRUeEuZcqR/nHT04z+rJ7Vjg
         80RFfX1WC7zdNktLvePWMPfvGQ/dmNTWzNB4nvcI0uAOabloFWZpsUd/RX1iZWAskreD
         bTaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689061091; x=1691653091;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Rx8H9As3YW36H58C24CHOAt5gVbFUaVPwH/qkPeltgA=;
        b=jN5To1OdIiPlyGfe6EhA4KHqs7kLrNqf+81yPdRYu7BcSTnV3BlBrgxv8CRXAwdvS2
         iKvBj6+mZe4qgMCuK30TAzukVdv9BzaEOVjVgDY+ZCcoMAxznQo8nXPsI6Upsg7xMGFs
         +iSl7V8jY4nb0q4wVI2exuERDk3mfUK0gLhVHBLocl841YwIw9yBYSfPGUnRynp7AeBA
         sjWmwwFFHOWIQU7Hw0ecyXUtLb9C0n8Hd4CwwnAgExwASHN0/c+Oo8k5HB7LXfXC74TP
         /9eKOqOxiOv7EmhhHJp2XfcgP+GnfLmJjZWQhtha9Z3qhEbMGB4tGBJOp06Nno6UqNg2
         OJ0A==
X-Gm-Message-State: ABy/qLb4dZ5Ceca9vRmWz+xKcoQzaSUhYEvebWVEuwk66VlEI8oqNaAW
        lAuMm7PhbiYSqEoZM2rQYEhS3g==
X-Google-Smtp-Source: APBJJlHyHjzHC8e0SOfh0h8Lzjgp0m0GgKV0prF8oQ5UrvplNd05w6cHvPGuBAcUiYE9+jsR6bE1Hg==
X-Received: by 2002:a17:906:f2ca:b0:96f:d345:d0f7 with SMTP id gz10-20020a170906f2ca00b0096fd345d0f7mr12103193ejb.62.1689061091717;
        Tue, 11 Jul 2023 00:38:11 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.223.104])
        by smtp.gmail.com with ESMTPSA id ov4-20020a170906fc0400b00992b50fbbe9sm786810ejb.90.2023.07.11.00.38.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Jul 2023 00:38:11 -0700 (PDT)
Message-ID: <c3149d29-1ec2-0123-1784-f7da6c43a6c5@linaro.org>
Date:   Tue, 11 Jul 2023 09:38:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 11/18] soc: samsung: Move power-domain driver to the genpd
 dir
Content-Language: en-US
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>
Cc:     linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Alim Akhtar <alim.akhtar@samsung.com>,
        linux-samsung-soc@vger.kernel.org
References: <20230707140434.723349-1-ulf.hansson@linaro.org>
 <20230707140434.723349-12-ulf.hansson@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230707140434.723349-12-ulf.hansson@linaro.org>
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

On 07/07/2023 16:04, Ulf Hansson wrote:

You miss here some commit msg shortly explaining the rationale behind this.

> Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Cc: Alim Akhtar <alim.akhtar@samsung.com>
> Cc: <linux-samsung-soc@vger.kernel.org>
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Let me know if you prefer me to take it via Samsung SoC.

Best regards,
Krzysztof

