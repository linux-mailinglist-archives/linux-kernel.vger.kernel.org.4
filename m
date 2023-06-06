Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA29372421E
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 14:30:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236266AbjFFMaG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 08:30:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237012AbjFFM3u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 08:29:50 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56B3C10C3
        for <linux-kernel@vger.kernel.org>; Tue,  6 Jun 2023 05:29:49 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id a640c23a62f3a-977e0fbd742so295207366b.2
        for <linux-kernel@vger.kernel.org>; Tue, 06 Jun 2023 05:29:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686054588; x=1688646588;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IWikzPZh1zj0Jzec8+iwxQzR4oRLa0VpL+JvaJGvhls=;
        b=IpNPSsZFEKJSvceLXdy306ddTKK0i9CHCuV0Ga9Z1pUmOuR1HClSLLk1gSLTRch0BA
         HB0toQBkGC8tYf5tr22ugA6iyZ8dC5ZUJby7XM92Pkj3Hx/jUqnWHapLmcQg7AEcJhx8
         ydELIzuXQqmqaOM3ZsSfF6t5ATY2uY8CKoYpTprBRZjHXdOIa/HLPPZtIgmsVxqA3meL
         ElohgLKkIsH77MWCI0VhbvwzY6lWIXWmYiuidArTQBwnvcN4S5euF6x14PtR9RB0YqSN
         ywKsWdqikwPUSYLGdUleMp7OZ5WuFTY3O6UnKWgJoczuD3q+BhSxWmNCdGQrnGAZVja2
         QuYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686054588; x=1688646588;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IWikzPZh1zj0Jzec8+iwxQzR4oRLa0VpL+JvaJGvhls=;
        b=ghagdt+GQ4q/PSDp0w8XTpA4jn61R9G8/ceYVEBSpsLDbcgIPbsu2+iks8ebt13eZu
         wrS2wqAFpWniNZs2Z3tZ7TJ5WHDrmMJzOa0zf8ABh5ZKH1HM0rArpNjgxV+9gmsNV3l1
         iV4mL+ZRm+kS5BjLFo4RrOOAPTKSHfB4cxnAwH4tUx9w3HQr8Qb3TL0vPJzEfAuNDLei
         5FeUr6nsYG+Teod3KCs0DOqkOwH979ARS2i7iT+v0i0C+1wuUh+LTMBqaKal08brQHYS
         pUTxh/B8S3OsU5kDcaNJQtzVKRZ+0zjznUQpUAOjJSF2oyWdLYTNGQnGBTlaf+h5DyKe
         e9tQ==
X-Gm-Message-State: AC+VfDzxMgoTtbruAc2ODgIaWCO994EKDjkaGIKxEI4DYe+Q7WE+NXJd
        QWC92oRnG4QWHf2MqsUB2EZsBw==
X-Google-Smtp-Source: ACHHUZ5zOg8bkEZM/LhbfO1EfpnR310YUUK4irlHnUHd29W7mmxUx2p7kOjYjbn0vsniaRz/2W3tQw==
X-Received: by 2002:a17:907:9688:b0:96f:2b3f:61 with SMTP id hd8-20020a170907968800b0096f2b3f0061mr2668594ejc.7.1686054587815;
        Tue, 06 Jun 2023 05:29:47 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.219.26])
        by smtp.gmail.com with ESMTPSA id h27-20020a1709062ddb00b00965cfc209d5sm5499841eji.8.2023.06.06.05.29.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Jun 2023 05:29:47 -0700 (PDT)
Message-ID: <ef6bc190-ca7e-485e-ae45-e03fddfd3f0c@linaro.org>
Date:   Tue, 6 Jun 2023 14:29:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH v2 2/3] ASoC: dt-bindings: document audio of graph port
 for cs42l51
Content-Language: en-US
To:     Olivier Moysan <olivier.moysan@foss.st.com>,
        James Schulman <james.schulman@cirrus.com>,
        David Rhodes <david.rhodes@cirrus.com>,
        Lucas Tanure <tanureal@opensource.cirrus.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     alsa-devel@alsa-project.org, patches@opensource.cirrus.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230606115605.1633595-1-olivier.moysan@foss.st.com>
 <20230606115605.1633595-3-olivier.moysan@foss.st.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230606115605.1633595-3-olivier.moysan@foss.st.com>
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

On 06/06/2023 13:56, Olivier Moysan wrote:
> When linking the CS42L51 to another DAI component, according
> to audio graph cards bindings, an OF graph port property is expected
> in the node. Document the port property.
> 
> Signed-off-by: Olivier Moysan <olivier.moysan@foss.st.com>
> ---


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

