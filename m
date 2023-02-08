Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FDB268F1D5
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Feb 2023 16:18:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229663AbjBHPSw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 10:18:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231535AbjBHPJ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 10:09:27 -0500
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FAA024137
        for <linux-kernel@vger.kernel.org>; Wed,  8 Feb 2023 07:09:25 -0800 (PST)
Received: by mail-yb1-xb36.google.com with SMTP id a1so22401668ybj.9
        for <linux-kernel@vger.kernel.org>; Wed, 08 Feb 2023 07:09:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=jfUADXTr4/5qB/7AX2/OOU/7b3TSw99YAVZDZfGLs28=;
        b=s4D7gdSBqYfBjlFxV1qEk1gkpY7qyxe5rLV3gXrsNVkfjWWh+1Zv7fpxW7D39ydLY+
         NmAY4rqr1nJB+VliyPJI9Q4Z/mXcVI4TZHJB7VS+YYxQzB7vo0ayNDnZZSjKdHQHivWr
         3x3lkLOAu9+TgcdEoTOyoPrXtxd2n1VJmd6T3+cNIz1tgxYkR3uhIdaG370NWXu5gxF2
         152KqTOMq9OfY03/ftQBaEdJEQ7/IfHB9aynnLbOZKwPmWVT8nw8zMAfP58H8/FTQr7E
         E53HUbW4nd+WI19Wv/jaxI61fqMC6rZ95KQ1nw1Kd7DwN653uNjgpFsTkax9GUWR/T6S
         hgfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jfUADXTr4/5qB/7AX2/OOU/7b3TSw99YAVZDZfGLs28=;
        b=0MVtLCUw9iUcpJxS70kpLxLeP/Jc1+QQ46Vj8avIf40DRy58YhyTBXWp6JLddqXoiF
         tQoURYbaeusgLEaB/u7HM0QjJ0qr9STpoP6F7LF2mP5aaiczUDMBYd1K0SJlmo5q7kc9
         iwXyD0474jyx7XF4etiTofO1g6FTvdna81yLiqY9LdGSioc7j0f/zWyDXwu0JODF16zF
         83cGqa4AoNh2TuMqlBu+zBIpJei5yxen3VDEVBoRWdn+t076GL2KPHI4VWMZhL9HR6qx
         AiEpj3NehOG32CMp0nTc2fZLDe0bD+jY+5AXSdpvxoC/0KMm28vSr0vJ0S8XlRo6MLGv
         MqMg==
X-Gm-Message-State: AO0yUKWQWyUqMyDHjncKUgX0ORJMeW12ShdAdsB1DnmZj721hRV+Zsq7
        4D+hfy5a3nq9LT/J7HNFaKfaM+vtfF8twbYijbhRMA==
X-Google-Smtp-Source: AK7set9exvYqx5M9TtAwxqO8BUajjZJuRrDAqirglQG0w39AVOFmleTT7JbJ/NXtuLdWEyZfILZkOUC5QppqmdUd5rI=
X-Received: by 2002:a5b:1c4:0:b0:8c9:2650:4ece with SMTP id
 f4-20020a5b01c4000000b008c926504ecemr88448ybp.210.1675868964876; Wed, 08 Feb
 2023 07:09:24 -0800 (PST)
MIME-Version: 1.0
References: <20230207172759.448798-1-krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230207172759.448798-1-krzysztof.kozlowski@linaro.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 8 Feb 2023 16:09:13 +0100
Message-ID: <CACRpkdarkcX4pk_0cCLJcdW9jgvJxsvoVAywFW4yo4rZqqkEwQ@mail.gmail.com>
Subject: Re: [GIT PULL] pinctrl: dt-bindings: qcom: second round for v6.3
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, Krzysztof Kozlowski <krzk@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 7, 2023 at 6:28 PM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:

> On top of previous pull request - second round of DT cleanups.

Pulled into the pinctrl tree for v6.3, excellent work as always, thanks!

Yours,
Linus Walleij
