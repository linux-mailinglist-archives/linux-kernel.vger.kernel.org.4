Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9694C64B7D3
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Dec 2022 15:52:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236018AbiLMOwj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Dec 2022 09:52:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236031AbiLMOwb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Dec 2022 09:52:31 -0500
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB82F21262
        for <linux-kernel@vger.kernel.org>; Tue, 13 Dec 2022 06:52:29 -0800 (PST)
Received: by mail-lf1-x132.google.com with SMTP id z26so5287389lfu.8
        for <linux-kernel@vger.kernel.org>; Tue, 13 Dec 2022 06:52:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cGMhMQrQiXZn5bMZv7WtiYkgLBm7HHDkDSanbJDw8zE=;
        b=jx9HQoapS7V6+P+efomOEzPXf055ul4AUK37H+AM6RajX2iwCc6XLGDxH51jNTWywO
         WIoiwjhMzYUb3Py4T0+SaUJvBQheUSkLNGJdwZ/x9qZxbJrSKRFwSWGhxfq5FDin0V3M
         7i7yWCa4LodmzP0ZwejDxVrYdL4LZ/5uHqSnfiVaAnooXJ4XQS6ivmsZirDVxkJbo80M
         Taj0IjZYQwMBYXlHadTu9oIwVucAowXoB1s0reHT4H7/Tj32DHj6zwsc66cuqSnbc6rV
         oVF8qIol57A7rdsUMwINXwu47voP98TGxCTGU/a1/DvqkAwUnR6ATOuwpjL5pkwOFphi
         v1sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cGMhMQrQiXZn5bMZv7WtiYkgLBm7HHDkDSanbJDw8zE=;
        b=UOXXp1VpA7srPlbMRCa3m3QJWn9oB8ADp+7U5LKqKLQ4CHskIVf0S2EP7cmFRQdIxJ
         gwuIzdkLnjRd7fqzpVAHnEAh8uYPGa5RDCXYF+86r4k48h3/ZJTQgwNyikTUc6gSZ0Hs
         VkcqBKdvPFiIGZdRJ0FpUEWx+cWxX3dGt6hfnNMJr/RurQb67u8+DF9dqBuUx8SbJaWC
         eC5ODmAPye63DmTGMrgxFJbVuS3lMraNIe7CeW3gh2/p97TBz2a69hWdg8H/GnlUIsBZ
         C7IVOygsH/Jz+SWDKVAG7xnzTrjW6J5aRKLJ88TG3yQY2+VixVzGjweGhay0wAYhZbJo
         u68Q==
X-Gm-Message-State: ANoB5pkyxvTX7h9ELg1AkhmQbnYtEW4NtrYgPUrVUve+51F9Wva0iVCD
        thtGtCmNk4O3c1dN31Z94IkX1Q==
X-Google-Smtp-Source: AA0mqf6/4HGX4iQzT86Nl0eOxLd+DZmxb9gP+I/R5kcIU4qIfGJfOU6fqe6yxGIjvsmOrKjeCz+e3A==
X-Received: by 2002:a05:6512:3e17:b0:4a4:7be4:9baf with SMTP id i23-20020a0565123e1700b004a47be49bafmr7503566lfv.59.1670943148353;
        Tue, 13 Dec 2022 06:52:28 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id v19-20020a197413000000b0049313f77755sm391502lfe.213.2022.12.13.06.52.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Dec 2022 06:52:27 -0800 (PST)
Message-ID: <3409c38b-8994-8b56-f677-10f7d79ab4ed@linaro.org>
Date:   Tue, 13 Dec 2022 15:52:27 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH v3 04/17] dt-bindings: regulator: Fix node descriptions in
 uniphier-regulator example
Content-Language: en-US
To:     Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20221213082449.2721-1-hayashi.kunihiko@socionext.com>
 <20221213082449.2721-5-hayashi.kunihiko@socionext.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221213082449.2721-5-hayashi.kunihiko@socionext.com>
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

On 13/12/2022 09:24, Kunihiko Hayashi wrote:
> Drop a parent node of the regulator as it is not directly necessary.
> 
> Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
> ---


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

