Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CB1C5B8842
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Sep 2022 14:29:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229773AbiINM3k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Sep 2022 08:29:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229665AbiINM3g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Sep 2022 08:29:36 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EB4125EC
        for <linux-kernel@vger.kernel.org>; Wed, 14 Sep 2022 05:29:34 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id z21so21993716edi.1
        for <linux-kernel@vger.kernel.org>; Wed, 14 Sep 2022 05:29:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=jnespCOi4e5ijlHSzwftjeKRd5VFy0oZTyj9OtokYu0=;
        b=X65zrtpZYLz0qwP7r/w7k46Z/L+4PRmMlM86s+IJawVos+vRyzZy/HhnPpOqTcEanS
         kThtxLFsMy26r1O2ipy9cCDOmyJJpeyfQBJI1Q4sDUGBQ1E+1hxvNfWhv1cGQnd8VZDS
         yO6MBHNNs0KDD/mmuF8BStsYzCGW/Gvx5fJUkWql4K/Xo6NJzUJAR/uLLpyUSm8+D7nC
         hXRnmqONRW+kGiGYALDS8Xtj1foeHBXw7xF1VTtFjfzMupYDHhwkqwZrYjHcue3Up7f7
         yqxQoBpurRVeYSNHy+4jhj62vYN4cl5YZeLRcSifS2raNA0sdPumRq1u1o+mO1cgOAVW
         ceaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=jnespCOi4e5ijlHSzwftjeKRd5VFy0oZTyj9OtokYu0=;
        b=b1cldJ9yXFNcAilejgTrvfv6s1BrYdlcZSr6unkNLB18+gL/42N9ue+sYynAsCpboj
         lknUYiwxtmZoNgiY2NsH8KFDTfifLxU20styrpKDOOQ4HIUt1dhvHwDaeH9JmxPhLZEE
         HILQJzc4Y4ZnZtu+bhgplRRwZAYULMC1u5KfUVUIelKODPosvWXUgYlO0wpz9rAoSxxT
         GVcL3MJnlP+Gp8WFNjZc8P7qVz4OL2bp4zCXFT0b5uPNU+2qSJ9nQ7nhY3GKuTOM6iES
         iV0z4QY1BI/DwBOpQoXrZmc12YRSdCLAfzPYYQnQuVcq6sFc0572QjBYA68GpKqwx1IA
         ALpw==
X-Gm-Message-State: ACgBeo2Xw/TTi3lJT6X4NIrJv6L7jtsaKpV8nd/h4ksgsDl4ISXllC+M
        oI8+g361ES17K3I475DcDO6y71VUmzWVQst2LOVl6Q==
X-Google-Smtp-Source: AA6agR4+OibO8oFqsH94aYVpYZC3BLluNjZox/hh9hbWSFFI35QRbaPyjMKRRVrrbe4qdJsihkrSnqPSAYSL+OgeRSU=
X-Received: by 2002:a05:6402:2690:b0:452:3a85:8b28 with SMTP id
 w16-20020a056402269000b004523a858b28mr8306834edd.158.1663158572974; Wed, 14
 Sep 2022 05:29:32 -0700 (PDT)
MIME-Version: 1.0
References: <20220909151605.821685-1-krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220909151605.821685-1-krzysztof.kozlowski@linaro.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 14 Sep 2022 14:29:21 +0200
Message-ID: <CACRpkdb83rHkkUGSUs0=FAkSs8DNWeQYqvSQCf=MttYHhxJVGg@mail.gmail.com>
Subject: Re: [GIT PULL] pinctrl: samsung: for v6.1
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Tomasz Figa <tomasz.figa@gmail.com>,
        Sylwester Nawrocki <snawrocki@kernel.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org, Krzysztof Kozlowski <krzk@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 9, 2022 at 5:16 PM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:

> The following changes since commit 568035b01cfb107af8d2e4bd2fb9aea22cf5b868:
>
>   Linux 6.0-rc1 (2022-08-14 15:50:18 -0700)
>
> are available in the Git repository at:
>
>   https://git.kernel.org/pub/scm/linux/kernel/git/pinctrl/samsung.git tags/samsung-pinctrl-6.1
>
> for you to fetch changes up to 9d9292576810d0b36897718c24dfbc1a2835314b:
>
>   dt-bindings: pinctrl: samsung: deprecate header with register constants (2022-08-19 16:54:10 +0300)

Pulled into my "devel" branch, thanks!

Yours,
Linus Walleij
