Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98AB86027AC
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 10:58:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230023AbiJRI6h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 04:58:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229602AbiJRI6e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 04:58:34 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A41F3F333
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 01:58:32 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id 13so30598487ejn.3
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 01:58:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=UXGbEH0YjKxQ5lQbGaSZrNNxQW34vJDdcKfHy34rEps=;
        b=H2+AI+grzf76WPuzlXes0XqihWDAH3vvMJF5CKtRcfyepU8F35wE2UrjorcMHaqtPl
         RIKAHrdO+ksC0EciRSL24IrHAgV0dXhx9T6asZH59SkKOWlOinN4b0XeXR0XMd2RJgy+
         jC5P/rwikwlE2eZjiMyX6hfjTYeysxRhXZX3QR0PtTeec6zDJomf0nzz4CIhPqAKFys/
         19I+gRKhfrezZxaVQIYUIuQrTTIOGCau7Tpwy/6Y4omg9OGOaX1TZav+ou38jXRQRjda
         unE0MHZ00fCfe9hq0qyPxoM/wNDofxp7IASaMUIfICHJGfJMsiLWhQ/edTV9craTv8RI
         HFRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UXGbEH0YjKxQ5lQbGaSZrNNxQW34vJDdcKfHy34rEps=;
        b=BWf2uiT86Azb9HnKa9MoI2fvAzyea/dqBB5oLOMqZdwRLbngu0awGiPuOemddzvZpF
         aDlaxDnWD5os5AZmHxCeu8ZffjJ4inQ15onsgHA1LsAl5uSqO83fPOd+K+yRbkDV4Jco
         kisLWhEXtJ1oV8WSjjnVJ549wGrOydJX+rglGlJ7G4KMaLYVh1dzNb8WTvO2c5mOmjHT
         cSOlxtvh/d59hGyX0GtymSbr+rxl1f02IR6ZHfYWk405bHYAbK4uaZ5zr8UOybbbuIpB
         cQ2M6n8QkwFR90aQmZjaT9vjaTCz3awxZ0Snb7mbEXSqNY2vxJK7CAxvuSaYp14JJMiB
         nbUA==
X-Gm-Message-State: ACrzQf2iT7LsPSTENxZzkkDgQ5pTU8yPu+D+Vch+lJ3hV9OE8qma2HLJ
        d5OzCSv5lDS2cuFtnowkamUpmg/vC8v3KGvHjsrOKA==
X-Google-Smtp-Source: AMsMyM6PMLMnUO5jeMWNXYPGtfSpnb88qOBPovYY5AxWrZQtw9ZvIfxPsQm9uZxDdbMfximlGMNKMsWj3z03dRpHygk=
X-Received: by 2002:a17:907:a06b:b0:78d:d25f:b726 with SMTP id
 ia11-20020a170907a06b00b0078dd25fb726mr1522606ejc.203.1666083510941; Tue, 18
 Oct 2022 01:58:30 -0700 (PDT)
MIME-Version: 1.0
References: <20221013214640.31214-1-palmer@rivosinc.com>
In-Reply-To: <20221013214640.31214-1-palmer@rivosinc.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 18 Oct 2022 10:58:19 +0200
Message-ID: <CACRpkda4h1_VSYQP-7Wg006SNJYU4G1xUnvzhhom+iLRjNKd_w@mail.gmail.com>
Subject: Re: [PATCH] MAINTAINERS: git://github -> https://github.com for ulli-kroll
To:     Palmer Dabbelt <palmer@rivosinc.com>,
        Hans Ulli Kroll <ulli.kroll@googlemail.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Conor Dooley <conor.dooley@microchip.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 13, 2022 at 11:49 PM Palmer Dabbelt <palmer@rivosinc.com> wrote:

> Github deprecated the git:// links about a year ago, so let's move to
> the https:// URLs instead.
>
> Reported-by: Conor Dooley <conor.dooley@microchip.com>
> Link: https://github.blog/2021-09-01-improving-git-protocol-security-github/
> Signed-off-by: Palmer Dabbelt <palmer@rivosinc.com>
(...)
> -T:     git git://github.com/ulli-kroll/linux.git
> +T:     git https://github.com/ulli-kroll/linux.git

There is no gemini branch on Hans' tree, actually I haven't heard
from him in a long time, Hans are you there?

This tree has some gemini branches that are active:
https://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-nomadik.git/

Yours,
Linus Walleij

Yours,
Linus Walleij
