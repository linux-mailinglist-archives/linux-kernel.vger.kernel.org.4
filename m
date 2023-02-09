Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 145F9690462
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 11:03:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229780AbjBIKDF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Feb 2023 05:03:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229520AbjBIKDE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Feb 2023 05:03:04 -0500
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com [IPv6:2607:f8b0:4864:20::b2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AD402CFF6
        for <linux-kernel@vger.kernel.org>; Thu,  9 Feb 2023 02:03:03 -0800 (PST)
Received: by mail-yb1-xb2c.google.com with SMTP id 139so266694ybe.3
        for <linux-kernel@vger.kernel.org>; Thu, 09 Feb 2023 02:03:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=jfTJJaEXRrDUHNq1LPkYpgcCmJkDp+MZ1+rtAQNLDEA=;
        b=Akj02ADt1meSifvrJN+3ql+L1JzvhQpJAw0Cs7xBbWyUaMzEMG0iruJs8JBvXFx21E
         NwvF66wDTO63jZ0+JRS2ikgrikcCDxv7qyKwneftUFFhJP/Q0dNfrELqbiVJk7uQL2aX
         nprWc835CQH9Jd7qMFkrmhabAUkutAYpZiXPqDiArfB1ibZfyOcAQo/tqw9N8TxrHF1a
         qj4JN7CgmlsDgho4tBTgY0AjWY2SoDKhIp5FD2Katz7CfnokCCGUUO2sfzRzsvkQXxqz
         Xr0nbM4xXS5VbMhCLVkSpgQn5kZQCUAplinHpKZHXoCdh7FTRaDUxbcSdTJ+lG7DMjg1
         fGUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jfTJJaEXRrDUHNq1LPkYpgcCmJkDp+MZ1+rtAQNLDEA=;
        b=hxf5lZnKmV52wnu+8lEcUOLwIROupQ5I9Le1bUsKcvyDp6dJEIdhzoglkksOaKNHJ2
         2xXtKswFB8lqaklgW2Id7kavoVYijYDcdQvR9/z3brSGUc60YJmvu/ExdNELrHWUq0CP
         dxRgJdNu0ed0pqBjBpWAssum3ti9tMyLiXl8Na89ZHjiMargS+9PClONHmy4ctJYNeVW
         G+eKW4S1fExWvABNH9p5iUzzZ3w9ew1LoEDkU7mwAnTNdGFpAV9UDf0onY5MXXS6HwBj
         rOb8FstbupihJkhlqFnacZahnhIsIglvNbGy6THlnNKxiMe6/TOD/qFeAackJecqn+KY
         zx7A==
X-Gm-Message-State: AO0yUKW08weiznoDqs9WiBtI9B2uKBxGgasVtxe5aXuub5sCTrKk1K8j
        WpGv2c5GyWBlvJgBu14GSznxZB6ufcHcTZ196RdJiT0Yr4Aajg==
X-Google-Smtp-Source: AK7set8Fe9KIIUPsV6Xrmn+GKlIZQdVpLw/AJdHbShK8UH36xu69E35pCLvKrrO6Qnkk6sfvNdBFfCqyDBmK9QuSIJU=
X-Received: by 2002:a05:6902:4c4:b0:8d6:6829:503c with SMTP id
 v4-20020a05690204c400b008d66829503cmr190205ybs.650.1675936982327; Thu, 09 Feb
 2023 02:03:02 -0800 (PST)
MIME-Version: 1.0
References: <20230209150457.401837e0@canb.auug.org.au>
In-Reply-To: <20230209150457.401837e0@canb.auug.org.au>
From:   Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Date:   Thu, 9 Feb 2023 11:02:51 +0100
Message-ID: <CACMJSesBRy_x6JOj2jOHjayxxgdp8QyZ36iCOPinj-kGVr5ozQ@mail.gmail.com>
Subject: Re: linux-next: Fixes tag needs some work in the qcom tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Bjorn Andersson <andersson@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 9 Feb 2023 at 05:05, Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>
> Hi all,
>
> In commit
>
>   e710abbb1740 ("clk: qcom: gcc-sa8775p: remove unused variables")
>
> Fixes tag
>
>   Fixes: ed432b1ed00a ("clk: qcom: add the GCC driver for sa8775p")
>
> has these problem(s):
>
>   - Target SHA1 does not exist
>
> Maybe you meant
>
> Fixes: 08c51ceb12f7 ("clk: qcom: add the GCC driver for sa8775p")
>

Yes, that is correct. Bjorn: Can you fix it in your tree?

Bartosz
