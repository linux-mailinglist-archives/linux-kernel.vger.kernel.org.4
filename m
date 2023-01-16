Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9823966C0C1
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Jan 2023 15:04:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231709AbjAPOEO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Jan 2023 09:04:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231743AbjAPODR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jan 2023 09:03:17 -0500
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D6C422A10
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jan 2023 06:02:48 -0800 (PST)
Received: by mail-yb1-xb31.google.com with SMTP id 203so30339719yby.10
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jan 2023 06:02:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=TQY8MHuSk9LBg4bjJGXRFvs4IYota2lxSV05jRoM7zo=;
        b=MjdVdubzz+i+2MVOHNGdAD8LZ924fWZQp6mx+qg4mbRaV3Tb8brgO/8j9miGVpeBPy
         IN+ytTjX6OQ/fEYgpRBMcZfbq3hheZSTaxcy2ByRQNDhGNj3gS61jYQtxwZi8VVCmjb2
         BacZDDbMR35CJCjjGtGXAWS8CdKdGWYJ776MPT3mGBmP8RK27ilMf9+/cE5Xca7oz8Wr
         35vn1URDpG9zdHH5HqXcOHMT3hQafEXjHqm8x1brEXaiYCNC7syCLNZfDbHKXXORkPz2
         v74fFlbV6rgySBSB6+AVcKxM4HWTfreAT9bTBHQQhfrEeL1U+qWP1/37/A4+fYA2wD4v
         Tmig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TQY8MHuSk9LBg4bjJGXRFvs4IYota2lxSV05jRoM7zo=;
        b=6JI0YYTfrdK3izay0gYG6tdO5/QHA5urT24CbN0Viz/sS9uqONf1qnKpUnwrrkkExx
         THwP/r1iznIPz/uGinw3y0P7X/tgJ7wU7XpVriygiIcens9pWphRJKiE7hizPPrSkEa2
         Konsw3ZzHox5ihca828J1iYa1Wezt8NKpd30YTLHYSfdaniMunwnyltcuy+xC+Trnfa9
         jjtYbP2vcWbajMf8AP0scUmj5ByNlvDGcx6UL9DuN5w4fAiolqek/T8ZfhyrvHg5wRxu
         N7Iv6grxTCIn46MV/0hz1PGpv/ZFz1L1+/jr7TZOUZKzBJmtVtaD+ZTqjWoR+qIikopW
         kQ9A==
X-Gm-Message-State: AFqh2koNv2QAyD/zeDarqBMddhp7pWDciQinQ0S2ESAHvC8YK/IJtYON
        F/OE0BHC7YoIJK3/8WdR1iFynjxfcsHZpDQI7OJ1wufoBe7YhA==
X-Google-Smtp-Source: AMrXdXtRxz9SmVvead1/eVkMbw6RrkJCIXk2BBeMIoI151jIqjC/5sT2uKdUWsYnn6jtYbpF546JBBYHEHI5GK0uT0E=
X-Received: by 2002:a25:6b0b:0:b0:7d2:8687:aea5 with SMTP id
 g11-20020a256b0b000000b007d28687aea5mr1265558ybc.210.1673877767930; Mon, 16
 Jan 2023 06:02:47 -0800 (PST)
MIME-Version: 1.0
References: <20230112184923.80442-1-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20230112184923.80442-1-andriy.shevchenko@linux.intel.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 16 Jan 2023 15:02:36 +0100
Message-ID: <CACRpkdZua44WU077yW9ZZAj0gV2-pCJQhMD7RC4y_fagPOwr5g@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] pinctrl: qcom: lpass-lpi: Remove duplicate
 assignment of of_gpio_n_cells
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>,
        linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 12, 2023 at 7:49 PM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:

> The of_gpio_n_cells default is 2 when ->of_xlate() callback is
> not defined. No need to assign it explicitly in the driver.
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Patch applied!

Yours,
Linus Walleij
