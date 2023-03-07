Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09DB56AE029
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 14:17:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230478AbjCGNRn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 08:17:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230195AbjCGNRY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 08:17:24 -0500
Received: from mail-yw1-x112e.google.com (mail-yw1-x112e.google.com [IPv6:2607:f8b0:4864:20::112e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B09076F45
        for <linux-kernel@vger.kernel.org>; Tue,  7 Mar 2023 05:16:16 -0800 (PST)
Received: by mail-yw1-x112e.google.com with SMTP id 00721157ae682-536c02c9dfbso243431137b3.11
        for <linux-kernel@vger.kernel.org>; Tue, 07 Mar 2023 05:16:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678194970;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=5Uxn0cNzKg3IdpeIXpX8JLumKXlXJ+TqZJT/uzTVj7Q=;
        b=Vg/2SyndYUUT1/bizpNJJuIOKVKS9UaiSMtPseK47JrBVp8tAmAveZkiH70JMqp8OR
         /zbu8hnz5blblx4AWGY+tNhHdrHmXDCZgKUNX+hJvn2s/v8ZBzgQM1d0AXwL7xvmEf3E
         yzHia0kDg1A7z0I+toBIUS40yOBSNK4k29yZOlq6oRDtvmw/0V0i1UbMv+mXge6ZaYG6
         t8n1YcR/NAhSTe8V8cWdwKN5gUpaHjKUV+6+Cs9ZDU7PUG1XRFBv6XttlbnWN6o0XL97
         MsnxAF3RCIv82JGTSArPvcpwyf7DzvW7LrhtkDuKfcMT2+MsdJevD1jYaTChT/hJyPHz
         sjug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678194970;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5Uxn0cNzKg3IdpeIXpX8JLumKXlXJ+TqZJT/uzTVj7Q=;
        b=BlgNV8jfGs3EntsYtBaB2jyCVLirFcG/ZFNkyHTWuPqmPjxO0c583LF2QAJrWyeuRY
         f3o+O65XzuX8aE1UC/iLj7kH6V72lWlrx9HDsqHXNhVlJWOaQXWunWEPQAf9fll6qoaX
         BLLD/0913TPV8IwZavLjIU2aunTUTnxLgzmKhAxpP0G4FrSQszpEf/JFqle/t4O1JA5M
         T2s/vQucclwV0m4nGL/O8utowqo0/8Uqyx7c8uEJMDdaPo3eGQJoYYvRTKlpDhhWjV4S
         XejKz15tux59u6uUwDqw0x6WpcJ83EUCtJb/ITDACBOEilEvdDaYIbqvTrCGcnKE5SQF
         u+Sw==
X-Gm-Message-State: AO0yUKVCg8c1spM1fkI+epIjAWL+6lIvtrPolDOAZref6eKbctDTe+Vr
        MHEwHzmaCtAx5jW1Q5V+DNlgpPaQnZEQizFcLS+5Xg==
X-Google-Smtp-Source: AK7set86eepmm0vjiIV7tN+3hkZpHUYxpw5AFKmEZJiJUhm/4yr6PFBGWQOo6BwwZH8chr3EYo0rp7wLQ0742szdGnA=
X-Received: by 2002:a81:431e:0:b0:533:8080:16ee with SMTP id
 q30-20020a81431e000000b00533808016eemr9280837ywa.10.1678194970675; Tue, 07
 Mar 2023 05:16:10 -0800 (PST)
MIME-Version: 1.0
References: <20230302072132.1051590-1-linux@rasmusvillemoes.dk>
In-Reply-To: <20230302072132.1051590-1-linux@rasmusvillemoes.dk>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 7 Mar 2023 14:15:59 +0100
Message-ID: <CACRpkdZyTkQ1-WpU2c2ZRDxdGZhAdu5266k167WDuiE8YOLTqA@mail.gmail.com>
Subject: Re: [PATCH] pinctrl: freescale: remove generic pin config core support
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     Dong Aisheng <aisheng.dong@nxp.com>,
        Fabio Estevam <festevam@gmail.com>,
        Shawn Guo <shawnguo@kernel.org>, Jacky Bai <ping.bai@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 2, 2023 at 8:21 AM Rasmus Villemoes
<linux@rasmusvillemoes.dk> wrote:

> No instance of "struct imx_pinctrl_soc_info" sets '.generic_pinconf =
> true', so all of this is effectively dead code.
>
> To make it easier to understand the actual code, remove all the unused
> cruft. This effectively reverts a5cadbbb081c ("pinctrl: imx: add
> generic pin config core support").
>
> It was only in use by a single SOC (imx7ulp) for a few releases, and
> the commit message of dbffda08f0e9 ("pinctrl: fsl: imx7ulp: change to
> use imx legacy binding") suggests that it won't be used in the
> future. Certainly no new user has appeared in 20+ releases, and should
> the need arise, this can be dug out of git history again.
>
> Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>

Patch applied.

Yours,
Linus Walleij
