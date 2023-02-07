Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E5A168D2CA
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 10:28:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231450AbjBGJ2J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Feb 2023 04:28:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229698AbjBGJ2H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Feb 2023 04:28:07 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEADC268A
        for <linux-kernel@vger.kernel.org>; Tue,  7 Feb 2023 01:28:05 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id bg26so10583213wmb.0
        for <linux-kernel@vger.kernel.org>; Tue, 07 Feb 2023 01:28:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:from:to:cc:subject:date:message-id:reply-to;
        bh=fcYMfFwrBDTiSgS1D5DQQyLqrqb91363x879A7vfPTI=;
        b=4wSdJscR7Zrk8CAATrkQ6roeRKQbEaEYZEEjsnESE9d7B7zDy6RoXwXDby6Q47+TKt
         +nX68CtmYqeCyNvEk26+QggvPF/niThLCzBwilyca0CQEEYXSgdRTTuuJnE8XXOFFJUD
         B7jH1Em2tmXHTkDoNcV44i3msTPv5oA+kwk+JCS9Ttxuc8rF7SD+0qVgnG1KAI6GBKUv
         hYR9eWe4LgEp/lqIJvrXaBFsPQV6/x3Ks9pM1jSxgr9yRjnVlWLwOQuBu3hnXnMzdo+x
         qhW4n/+a6Ms8E6Ts1CM6ziW9V3o8rc9zYj0uSfFv5awl7Gh8xEAIAfk/PCdaOZ5CeRjS
         cEdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fcYMfFwrBDTiSgS1D5DQQyLqrqb91363x879A7vfPTI=;
        b=tx0oe9AtUwVb9lHEnBZ9jGWvWn2nM0gkqLjxDV8vS9b4SIwCsp4WnAzw4YG+UJR/hC
         xhF2i9lK85xVgHVgMkDkHSoqle7AgaSXyNGYueZGZoD7T7Nl+WD9frRa3mr+F4RokmEs
         TEZ/uYFPASV5piWcNk/PNxPv0aym6K1ccm/s0T45WqDAmNQCEibQhObXHasC8o9RuvAO
         ddWTAyRBJjhrjH4G5jp2UWmT54cBAZN3IyYhvtsI9myVprXTrKIOdrqonTTiPsf3OEXK
         mJPhFVphCOxSsg6j5lksX+dElNBRleW7X3afG7jUd3AxKvb21yzGrNvTv2wY1zp3rZVm
         duVg==
X-Gm-Message-State: AO0yUKV3fRrDMAsBOAEKYR8fwyPKLU20vzGt9Taq/dF3yW9vTVFcVH0U
        NGAgZnD1tgRYNpv1RXA32fzPkQ==
X-Google-Smtp-Source: AK7set9zNVx+57hEOZgnPtvD4Q05Tfog3tybMA2WkK7+QAyedz8hiD09lLmb812r+ufxAVP4VvrZwA==
X-Received: by 2002:a05:600c:1894:b0:3de:1d31:1048 with SMTP id x20-20020a05600c189400b003de1d311048mr2489815wmp.29.1675762084495;
        Tue, 07 Feb 2023 01:28:04 -0800 (PST)
Received: from localhost (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id fc13-20020a05600c524d00b003db01178b62sm20449772wmb.40.2023.02.07.01.28.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Feb 2023 01:28:04 -0800 (PST)
References: <20230206153449.596326-1-jbrunet@baylibre.com>
 <20230206153449.596326-8-jbrunet@baylibre.com>
 <a711905e-dbfb-4258-62be-250a9549a9c4@linaro.org>
User-agent: mu4e 1.8.10; emacs 28.2
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org
Cc:     linux-amlogic@lists.infradead.org,
        Kevin Hilman <khilman@baylibre.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 7/7] ASoC: dt-bindings: meson: convert axg sound card
 control to schema
Date:   Tue, 07 Feb 2023 10:25:53 +0100
In-reply-to: <a711905e-dbfb-4258-62be-250a9549a9c4@linaro.org>
Message-ID: <1jbkm53jvg.fsf@starbuckisacylon.baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon 06 Feb 2023 at 20:21, Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> wrote:

>> +
>> +  audio-routing:
>> +    $ref: /schemas/types.yaml#/definitions/non-unique-string-array
>> +    description: |
>
> You still have everywhere | which should be removed. Here and in almost
> every other description when no special formatting is needed.

I'm sorry if I misunderstood your comment. I thought the problem was
with the '-' of '|-', which I removed here.

Should I use '>' for the YAML multiline format instead ?

>
>
>
> Best regards,
> Krzysztof

