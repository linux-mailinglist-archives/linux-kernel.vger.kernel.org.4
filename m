Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7D666943E1
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 12:09:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230102AbjBMLJe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 06:09:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229950AbjBMLJc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 06:09:32 -0500
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7ACDCD52B
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 03:09:30 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id n13so8419216wmr.4
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 03:09:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=stm1hwTJBHKahRz6wNIWz7+qCvwXwKwxg5RRqSpWqIE=;
        b=mSMZkDKR+xQhi7r+4iEqCUCIhQMUUMRigRPviyBEnC69YKz0szmuo4DRIKlgVPBFiF
         g4cboWR5RzCpQgHgoYrSsVKvqhiKAn35V87F/3vUwad8fK4k3eifyfmNy3WCn/YwimlF
         rdqhAcEMuwcX0kuCraRv60Hr4IoQ3OXLogNkWtZfWIb3QQXI6M8FnFlRZxgRhREsaQzD
         ZHELmAdJ4fcoBzCXd42TY2WBGwCg/k84AbBN5c/NocwYmLBG0Kjt12j4s6vbarDmpH8R
         42WuJdGA1kRYIwEQe6KPRn2VU2m6A1wjodcE/YQzoIeQmBeAzQrMwvJONEuZ027W3SZO
         kz0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=stm1hwTJBHKahRz6wNIWz7+qCvwXwKwxg5RRqSpWqIE=;
        b=KhA/9vun8llsehyDNvyj7hwgyMSIPwrRBn1VA6sQBtKL25zgu3R6UpnEobPSwc6KVD
         ledViczbgKMJ2yffjD2FKQfnH50z9H4+uAUMhjTXpmIK0Vf2Os4Tp+u+vSYu3RhxjWwA
         ztIIaDKZTb11jm9RhgadKI0Iwf7Noe9hJDNr7cC65L7JrJFevzgSeJRUXwfH/8EHjnp4
         k1C5pTozvtrHlycLzM0nDGvcmQGiw3uJXlFmmjklPJZLmwMc241qTz0AT4LN+B7byqq3
         wgu933KWWhSP9u6ozHL4bT5jS8dU47w/BDtjHgW+UYAOmEFemY73aPhX0WpTWY07Z5K0
         oCZg==
X-Gm-Message-State: AO0yUKUNt6pGuCeNbs8ecVtrxqc5LyyZ7CxLQYIhYUf1LwVuHAvfAJmi
        bVVAZ0PZs9y0NAPSWUExElqfnA==
X-Google-Smtp-Source: AK7set/VcUTG0I5c6PpisQw5S6O+/8/FQNy9v5Q8D0yqR2nQXQ1uQn10DUmGu8yJRWzRaiTGKEGuqg==
X-Received: by 2002:a05:600c:1609:b0:3dc:53a2:2690 with SMTP id m9-20020a05600c160900b003dc53a22690mr18363598wmn.7.1676286569101;
        Mon, 13 Feb 2023 03:09:29 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id n2-20020a05600c3b8200b003dfe659f9b1sm25207857wms.3.2023.02.13.03.09.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Feb 2023 03:09:28 -0800 (PST)
Message-ID: <3287867a-456c-ddc3-adbf-90001950c926@linaro.org>
Date:   Mon, 13 Feb 2023 12:09:26 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH 01/17] dt-bindings: power: apple,pmgr-pwrstate: Add t8112
 compatible
Content-Language: en-US
To:     Janne Grunau <j@jannau.net>, Hector Martin <marcan@marcan.st>,
        Sven Peter <sven@svenpeter.dev>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Mark Kettenis <kettenis@openbsd.org>
Cc:     asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230202-asahi-t8112-dt-v1-0-cb5442d1c229@jannau.net>
 <20230202-asahi-t8112-dt-v1-1-cb5442d1c229@jannau.net>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230202-asahi-t8112-dt-v1-1-cb5442d1c229@jannau.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/02/2023 16:41, Janne Grunau wrote:
> From: Hector Martin <marcan@marcan.st>
> 
> Add the apple,t8112-pmgr-pwrstate compatible for the Apple M2 SoC.
> 
> This goes after t8103. The sort order logic here is having SoC numeric
> code families in release order, and SoCs within each family in release
> order:
> 
> - t8xxx (Apple HxxP/G series, "phone"/"tablet" chips)
>   - t8103 (Apple H13G/M1)
>   - t8112 (Apple H14G/M2)
> - t6xxx (Apple HxxJ series, "desktop" chips)
>   - t6000 (Apple H13J(S)/M1 Pro)
>   - t6001 (Apple H13J(C)/M1 Max)
>   - t6002 (Apple H13J(D)/M1 Ultra)
> 
> Note that t600[0-2] share the t6000 compatible where the hardware is
> 100% compatible, which is usually the case in this highly related set
> of SoCs.
> 
> Signed-off-by: Hector Martin <marcan@marcan.st>
> 

Missing SoB.


Best regards,
Krzysztof

