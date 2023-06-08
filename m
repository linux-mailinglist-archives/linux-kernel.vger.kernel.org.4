Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFCF4727AAA
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 11:00:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235697AbjFHI7r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 04:59:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232125AbjFHI7n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 04:59:43 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51C8B1BF0
        for <linux-kernel@vger.kernel.org>; Thu,  8 Jun 2023 01:59:41 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id 5b1f17b1804b1-3f736e0c9a8so1902275e9.2
        for <linux-kernel@vger.kernel.org>; Thu, 08 Jun 2023 01:59:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20221208.gappssmtp.com; s=20221208; t=1686214780; x=1688806780;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:from:to:cc:subject:date:message-id:reply-to;
        bh=HtzbVfqW0SjuZKyPfBVRRJzNRxgu1Q7jWMIx+yfKlSY=;
        b=OwUHzZAfyLsLDi5eRkoShFrB0mdzg2SB/HuM0M9zJVRq1drRtWiHfoQVh7n7y9NpCW
         YOZTGpPhEoS6adlGyclhA5D9QlDJFO0wUFGVEd/exvjOuXJHjPzLDUGMDqRUTixOR4o2
         W6Cf3K6MbNOMKJdDEz48SxlnakQFHbbJF/eDuIunt9jAsTNIBResuP3RVw9Qu1oflCUD
         9d1cHXYHqK2x3oZUtoLqm8ElvlwvvW1D9qnKjprrpvxKerSxrqCbr6QHkYc3IF1cx3cZ
         sFhxK1Y1nLNGXORpNpG23ZEe3e27apENyuu0cMFc3VJY+7Qq4ezwC+S8eom3sLQR7Chw
         ZNww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686214780; x=1688806780;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HtzbVfqW0SjuZKyPfBVRRJzNRxgu1Q7jWMIx+yfKlSY=;
        b=gy3N2x8Ks0/7hcAunSmsoGL2DEe89UgeIkX3AK0/1LakSAqV5xz7K+0kx9Gx1sA8tx
         LMfQRaX2Pf+K4og4UKY2y/G4zbVy1oXHTaZ54pMVwgZP5iiizfpBenenbrXBbpj0JIb4
         kZn2Kw3sfMw1gLhmpGtPPV/A9VHKhGUHrVxet7DbZE4dKB8UgW9oAQTmv16H+xGod9Gn
         XSx+Jd2fI+CervJz5IZZgqSeAbBeR3e7j7p//kPtJdwfvrCChk4yLXZrudLNQvlZTMh8
         X8wJTBfrTisLTc/xmGFYF0yI0c9yU7TVd/qLEEQ9e5Ims2LeevwHqeYiEGRwgwEwLS9D
         L17A==
X-Gm-Message-State: AC+VfDx/O1LtAU2CaKYzJ72pPbsKXtdIt6qEtD0d9bxrTSHIiRy7CiUn
        bdYwHvth6oO5Rm+kinpu9LwPYw==
X-Google-Smtp-Source: ACHHUZ7AJ6r0vLW9SSK7hlu7p9NSBYgD9rpD8nNz7jKun8PAWYhsC9D2tlLPOuzTNzAhNm/64JH+7w==
X-Received: by 2002:adf:e6c8:0:b0:30a:e161:86c6 with SMTP id y8-20020adfe6c8000000b0030ae16186c6mr6060111wrm.51.1686214779694;
        Thu, 08 Jun 2023 01:59:39 -0700 (PDT)
Received: from localhost (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id c1-20020a5d5281000000b0030aded83385sm955693wrv.27.2023.06.08.01.59.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jun 2023 01:59:39 -0700 (PDT)
References: <20230517070215.28463-1-yu.tu@amlogic.com>
 <20230517070215.28463-4-yu.tu@amlogic.com>
 <1j5y804q7u.fsf@starbuckisacylon.baylibre.com>
 <73acf297-3f60-1ce1-2f05-af048aa37199@amlogic.com>
User-agent: mu4e 1.8.13; emacs 28.2
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Yu Tu <yu.tu@amlogic.com>, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     kelvin.zhang@amlogic.com, qi.duan@amlogic.com
Subject: Re: [PATCH V9 3/4] clk: meson: S4: add support for Amlogic S4 SoC
 PLL clock driver
Date:   Thu, 08 Jun 2023 10:53:31 +0200
In-reply-to: <73acf297-3f60-1ce1-2f05-af048aa37199@amlogic.com>
Message-ID: <1jttvi9vnq.fsf@starbuckisacylon.baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


>>> +
>>> +static struct clk_regmap s4_fclk_div4 = {
>>> +     .data = &(struct clk_regmap_gate_data){
>>> +             .offset = ANACTRL_FIXPLL_CTRL1,
>>> +             .bit_idx = 21,
>>> +     },
>>> +     .hw.init = &(struct clk_init_data){
>>> +             .name = "fclk_div4",
>>> +             /*
>>> +              * For more information, please refer to s4_fixed_pll_dco.
>>> +              */
>> While div2 and div3 got an explanation from previous SoCs, they others -
>> like div4/div7/etc ... - have been able to cope with rw ops so far.
>> Why is the S4 different for all these clocks ?
>
> The chip was changed fixed pll for security reasons.
>
> Fixed PLL registers are not writable in the kernel phase. Write of fixed
> PLL-related register will cause the system to crash.
>

That is definitely worth mentionning

>> Requiring RO ops (or fishy clock flags) is usually a sign that a clock
>> is used without an appropriate driver.
>>

Neil is currently dealing with the dt-bindings, please
* Adjust your patchset accordingly
* Wait for his v2 to land, you'll need it.

>>> +             .ops = &clk_regmap_gate_ro_ops,
>>> +             .parent_hws = (const struct clk_hw *[]) {
>>> +                     &s4_fclk_div4_div.hw
>>> +             },
>>> +             .num_parents = 1,
>>> +     },
>>> +};
>>> +
