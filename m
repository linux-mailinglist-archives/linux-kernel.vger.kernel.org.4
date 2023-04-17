Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E6426E4DE0
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Apr 2023 18:01:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230047AbjDQQBG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Apr 2023 12:01:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjDQQBE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 12:01:04 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 654B01991
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 09:01:02 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id vc20so10543506ejc.10
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 09:01:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681747261; x=1684339261;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LGfj7dhEzmUyz7+syDE2F39t7UKzS4afv7ZNVWEs8oE=;
        b=RKtmfhmf04iXYaQnoCUfBRfqrnHwSdKnaffoZSgvc1HJMmswfg3m8Oh7JQXi0h0Z3X
         zrRwu/cUTw2RbD+bpbhFgta2inCjd8JqjnTY2vdBd/nfExSBCMJshEaZKicjZ/62E5xm
         omM2dfAFfEh/AZmC1TgLpzZRaO1qO3PNfOhRh5IbTZNF59KQqgeAtulEZnnBzQAKhBYV
         sgjZLxi0g46qlIQrPcS5cmOLN9I2l4ovI5Y9xIWjWhvY/1dOCNHfWzN91SU+gtS2FhmB
         FFEpZZaQNOrgltQgknDXUd+54VdurJyhHqoI7BGiiLDNCWiHxXlGvaTgEfWHt3rBLaIj
         UP/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681747261; x=1684339261;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LGfj7dhEzmUyz7+syDE2F39t7UKzS4afv7ZNVWEs8oE=;
        b=Vj7fJklw0+k186ValOQ8NSrqu9uhP11d6j4R9mR70vFjC0k+l0gjrk2Gcr02f4tuwx
         sLlmGDYpaJWnG5zZXWtXdYOan7YPWoc7A3r7n8JZwLtDqU9MLzId6PrbqfCdH75L1HFZ
         T0F1B/mUTK8WCEc0PW3b8hVEW87gc6qdWMGYO0FJRxQHDEruRzgoAZzHLtc/ppJ+bBXY
         n2mThvKTtk01VEEUvQnmHLGPdPIILgserNMlcLDirUPqkqHm7LhPuLqbSV1HnvERkR9P
         Ct8VoCrZzKkZFv3U/Agf3/ypT6SfOlyuPZqMOrzcLAucZ+QKZILYpLO+o1KF8HkYiB3D
         t1/A==
X-Gm-Message-State: AAQBX9frgn1xVgkaXQfQmCCBLozqR99uuC1RQjG4IJf0PjcNvpFGsMYi
        OO45F9am9fMixQG7N+Kcnj9/cQ==
X-Google-Smtp-Source: AKy350bwoDbML000tkSfu3RK1XvtX3xs9Z47Frf6gU00ujf+0MhVCVn28uwpnRfUijyUrwaT8AClZg==
X-Received: by 2002:a17:907:a047:b0:8fa:b2b:9de with SMTP id gz7-20020a170907a04700b008fa0b2b09demr6941122ejc.25.1681747260869;
        Mon, 17 Apr 2023 09:01:00 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:96aa:60eb:e021:6511? ([2a02:810d:15c0:828:96aa:60eb:e021:6511])
        by smtp.gmail.com with ESMTPSA id k26-20020a17090666da00b0094a64196ed6sm6790426ejp.54.2023.04.17.09.00.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Apr 2023 09:01:00 -0700 (PDT)
Message-ID: <752c2dc1-65a9-a74a-d9ce-7db5ddbea5f8@linaro.org>
Date:   Mon, 17 Apr 2023 18:00:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 2/4] ASoC: codecs: wcd934x: Simplify with dev_err_probe
To:     Mark Brown <broonie@kernel.org>
Cc:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Banajit Goswami <bgoswami@quicinc.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
References: <20230417141453.919158-1-krzysztof.kozlowski@linaro.org>
 <20230417141453.919158-2-krzysztof.kozlowski@linaro.org>
 <20aa9662-9cbb-4fbe-b6ed-3a6ba33e820a@sirena.org.uk>
 <c294d672-c2fa-7468-f02d-18d5230a1d95@linaro.org>
 <5d753a8a-b979-43f6-a403-8a51f69bac29@sirena.org.uk>
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <5d753a8a-b979-43f6-a403-8a51f69bac29@sirena.org.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/04/2023 17:58, Mark Brown wrote:
> On Mon, Apr 17, 2023 at 05:43:03PM +0200, Krzysztof Kozlowski wrote:
>> On 17/04/2023 17:33, Mark Brown wrote:
>>> On Mon, Apr 17, 2023 at 04:14:51PM +0200, Krzysztof Kozlowski wrote:
> 
>>>> -	if (IS_ERR(wcd->if_regmap)) {
>>>> -		dev_err(dev, "Failed to allocate ifc register map\n");
>>>> -		return PTR_ERR(wcd->if_regmap);
>>>> -	}
>>>> +	if (IS_ERR(wcd->if_regmap))
>>>> +		return dev_err_probe(dev, PTR_ERR(wcd->if_regmap),
>>>> +				     "Failed to allocate ifc register map\n");
> 
>>> This is a functional change.
> 
>> Hmm... I don't see it. Return value is the same, same message is
>> printed, same condition. Did I make some copy-paste error?
> 
> You've replaced an unconditional dev_err() with dev_err_probe().

Which is the core of this change... so what is here surprising? Yes,
that's functional change and I never wrote that dev_err_probe is equal
dev_err. It is similar but offers benefits and one difference - does not
print DEFER. Which is in general exactly what we want.

Best regards,
Krzysztof

