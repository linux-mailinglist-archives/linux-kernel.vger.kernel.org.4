Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A8EB71F527
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 23:57:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232852AbjFAV5z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 17:57:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229724AbjFAV5x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 17:57:53 -0400
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com [IPv6:2607:f8b0:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C264718D
        for <linux-kernel@vger.kernel.org>; Thu,  1 Jun 2023 14:57:52 -0700 (PDT)
Received: by mail-oi1-x232.google.com with SMTP id 5614622812f47-38ede2e0e69so921854b6e.2
        for <linux-kernel@vger.kernel.org>; Thu, 01 Jun 2023 14:57:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685656672; x=1688248672;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ruzONHVQNNLn5cbL5oGqVupApwre43YqM07fYPN5vjI=;
        b=xJ3xHiRVsz8R7jMctT41qJPcKiBMuq002UN7r9mY5OoIHL4nk4TNU9bO882krVSeYl
         F+LcWIkkh8dut/CrRkIeYQNJv6Ztxuc0L2yqyg4BJkzX/oLWAjHj8uUVy2NMG38qcZHc
         gC/em/1iWrZyeWApUBNlPAkCo7rQzXVHwMr/25D/rcQHwBuJfqUlvl4MeK/Hpv3W5dRW
         70yYkXlrOJMMOozJJKV0N9A775LDDzO0Gx7E/gUu6vBu7eExVkS/OZkNP5tdatwIjnaY
         ZHjT+b0sxqybeL48s/zonqK9gyu1fGwFq+/ETOHCM407OJwxK06Qr+TFUBzsrmmQNnRj
         EfKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685656672; x=1688248672;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ruzONHVQNNLn5cbL5oGqVupApwre43YqM07fYPN5vjI=;
        b=Qb5f7Lg5NsS5eApM7bdxxbalbHc5IR3jt5QdLNGDt2bzE7CI6AmlTrP43MGnRqIxbe
         rZfkMs7fAceT2YZQizmMrBGa+QcAAIhzMd2an16y7jTmDGLajMf7/4Lpumfrir1QCCjd
         SncZFynOiIbOgX93Jo0czvlrXUmTtb2Rx1v3cIzddDba/vKxqGxYJ8D0meHiL+4J9ZO/
         nI1UiBDjdyRwoEr7j9S1Gg9PCj8ogQKae8fKdulhAdSfB2TGsJWG6Lrq2zj5cQui54qP
         CTB4k62J6sG2dNsUhhkcAj3FJco9nVmAkbfcCC22XNMd/UaEEovZozPoN8zcJpjLj4ye
         P5pw==
X-Gm-Message-State: AC+VfDzxRVEa8lc8a0k4DbfrurCE0aTmIh/YHD/bAPRBv6K1xPCX/bcm
        mJgjvksH3nNMmYxnx4Tu14v8+Tv8Bh7mV9k78+05WQ==
X-Google-Smtp-Source: ACHHUZ56tRKln5Zko0KXJAcfvYlxi6GxnyaGVCrS/sW2jiWiCLzSvzQWu0NgIDvAnsayfumJnSDtE29yp2/8bVVKkD8=
X-Received: by 2002:a05:6358:3408:b0:123:896:851e with SMTP id
 h8-20020a056358340800b001230896851emr4756088rwd.12.1685656671940; Thu, 01 Jun
 2023 14:57:51 -0700 (PDT)
MIME-Version: 1.0
References: <20230601213416.3373599-1-arnd@kernel.org>
In-Reply-To: <20230601213416.3373599-1-arnd@kernel.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Fri, 2 Jun 2023 00:57:40 +0300
Message-ID: <CAA8EJpqRUf2bp1SxyvKg9t+1AM9gqd_6JHq8LAp=6Dd32+h2rA@mail.gmail.com>
Subject: Re: [PATCH] clk: qcom: gcc-ipq6018: remove duplicate initializers
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Robert Marko <robimarko@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Mantas Pucka <mantas@8devices.com>,
        Christian Marangi <ansuelsmth@gmail.com>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2 Jun 2023 at 00:34, Arnd Bergmann <arnd@kernel.org> wrote:
>
> From: Arnd Bergmann <arnd@arndb.de>
>
> A recent change added new initializers for .config_ctl_val and
> .config_ctl_hi_val but left the old values in place:
>
> drivers/clk/qcom/gcc-ipq6018.c:4155:27: error: initialized field overwritten [-Werror=override-init]
>  4155 |         .config_ctl_val = 0x240d4828,
>       |                           ^~~~~~~~~~
> drivers/clk/qcom/gcc-ipq6018.c:4156:30: error: initialized field overwritten [-Werror=override-init]
>  4156 |         .config_ctl_hi_val = 0x6,
>       |                              ^~~
>
> Remove the unused ones now to avoid confusion.
>
> Fixes: f4f0c8acee0e4 ("clk: qcom: gcc-ipq6018: update UBI32 PLL")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/clk/qcom/gcc-ipq6018.c | 2 --
>  1 file changed, 2 deletions(-)

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry
