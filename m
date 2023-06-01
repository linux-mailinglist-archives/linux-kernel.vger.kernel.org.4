Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E819671F58E
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 00:05:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232214AbjFAWFt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 18:05:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229800AbjFAWFq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 18:05:46 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1D32180;
        Thu,  1 Jun 2023 15:05:42 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id 98e67ed59e1d1-256e1d87998so1118210a91.3;
        Thu, 01 Jun 2023 15:05:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685657142; x=1688249142;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=r6m06uJZ1FcfQQQ+zQbt4FBMdkqZwEjZRMbiHdQiMhk=;
        b=MVRjfvzuQmigtaIpnBg868k8EJAvZXM6L0PhCAaZrPI8Yqi/CeUJlFgroYi+DdS3PB
         MLZGiK3HIgyG6uxdk0K7CafGbmBWwyCnwYJzBO6Mp2pfD6tgUFJq+J3DPvTyFnyxQaYl
         2aYbS9pPxD352nvrEboI7bMwf6wdOwWoelqQh1+m19Djq/glMR0pYoKXxXYcSFAZ716A
         UhlxfJ6IVGRHQel0p28pi5FxFGzbgK6gtpvJr4DAX3wJoOlDQ7aTiUvfd0trNr0upJs4
         H4UIerjjHqGWr0ColesVFer1vJO5kR+8IqZADcfGClvKuXiqwszWmMaBTzfmpJr/5XUx
         4Xhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685657142; x=1688249142;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=r6m06uJZ1FcfQQQ+zQbt4FBMdkqZwEjZRMbiHdQiMhk=;
        b=iWaYFBeX0fVnj1XtiKBX3brIpz2/0xa4lUdWiOaQYD6QVHZg3p2Ed2VtXqrK0FE7U9
         R0myr2O8PyVGwa62YdcjwXp31GRuNdHAsmdP/AaaQnCyjlF2YOpwzeAzrQWIP3Nr0qEh
         BTVG3zZBQnIp7rNoFchD22+sqo9+T5/RQOgUw73pwFG6e8zJ6ofoAxYTSXcDItXGh4B3
         WFMTJuqksokEuhIqV5EGmviRftFpw41aAmBpRJdkCz9ecigI1eRpxCnjRZquL1ahyPIc
         fwsogpSKgxbLu2qW0cjfbdhZECb0XTkS8TinWPr97LskytbVOXyloa6HY5Uv6+XwRi2O
         VYmQ==
X-Gm-Message-State: AC+VfDw+4PKp9xS/KSyYZ/KCBsQ1RScwhRxltDgcVsjZd5/JM7UQF5Gd
        pWRDD6laaFv1hyLxo6iRvRsxQjsLfTXXk9Uo/Ik=
X-Google-Smtp-Source: ACHHUZ4gT9Uz11PX2It9sJbwkqfOByKhOKQcVu6O4hJx58nfJehfCdmwKcEoYgo5RwTms1ghyvToylm8obOwqw9fgmU=
X-Received: by 2002:a17:90b:fc9:b0:24d:f59a:d331 with SMTP id
 gd9-20020a17090b0fc900b0024df59ad331mr611951pjb.26.1685657142032; Thu, 01 Jun
 2023 15:05:42 -0700 (PDT)
MIME-Version: 1.0
References: <20230601213416.3373599-1-arnd@kernel.org>
In-Reply-To: <20230601213416.3373599-1-arnd@kernel.org>
From:   Robert Marko <robimarko@gmail.com>
Date:   Fri, 2 Jun 2023 00:05:30 +0200
Message-ID: <CAOX2RU7mQgwVV=aNXxMQKd4Xrf6iHi8gBCzccE0gz-3_UwW6jQ@mail.gmail.com>
Subject: Re: [PATCH] clk: qcom: gcc-ipq6018: remove duplicate initializers
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Mantas Pucka <mantas@8devices.com>,
        Christian Marangi <ansuelsmth@gmail.com>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 1 Jun 2023 at 23:34, Arnd Bergmann <arnd@kernel.org> wrote:
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

Thanks for fixing my mess up.
Reviewed-by: Robert Marko <robimarko@gmail.com>

Regards,
Robert
> ---
>  drivers/clk/qcom/gcc-ipq6018.c | 2 --
>  1 file changed, 2 deletions(-)
>
> diff --git a/drivers/clk/qcom/gcc-ipq6018.c b/drivers/clk/qcom/gcc-ipq6018.c
> index 48f9bff7c80fb..86b43175b0422 100644
> --- a/drivers/clk/qcom/gcc-ipq6018.c
> +++ b/drivers/clk/qcom/gcc-ipq6018.c
> @@ -4150,8 +4150,6 @@ static struct clk_branch gcc_dcc_clk = {
>  static const struct alpha_pll_config ubi32_pll_config = {
>         .l = 0x3e,
>         .alpha = 0x6667,
> -       .config_ctl_val = 0x240d6aa8,
> -       .config_ctl_hi_val = 0x3c2,
>         .config_ctl_val = 0x240d4828,
>         .config_ctl_hi_val = 0x6,
>         .main_output_mask = BIT(0),
> --
> 2.39.2
>
