Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B06D663FAC7
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 23:43:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230336AbiLAWnu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 17:43:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231520AbiLAWnX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 17:43:23 -0500
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F483C4CFE
        for <linux-kernel@vger.kernel.org>; Thu,  1 Dec 2022 14:43:19 -0800 (PST)
Received: by mail-ed1-x530.google.com with SMTP id a16so4246471edb.9
        for <linux-kernel@vger.kernel.org>; Thu, 01 Dec 2022 14:43:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=wdccEwoNUzYrqC6jNWDrT9rEAVvVXyiFMgGI7jA68lQ=;
        b=Wk8Iq4Zwruqwxl5xoc1ZTWIyOX5WMpQN1z38ssGVJLqjpltkZZKrGOViQ67FiKHWH/
         2l1ctyiArazBiuXAuq+mxWdCFSZ29k/TqxC6HR19sG73B9PcKOaNE3L/RzvFzdTqj9uJ
         MR81ZSyFpBqJ3451tqP7MPqhUZmq8OW1rbc9N8f0uAuDGKnSohLo/FHgcXxE01hx875T
         Pe1gIimImpVMscHQvsDGvTQK7dxHrFLBBxFL0M7vf0/kSPX0OPj9AmTGI14hW7DtRk+m
         /I+5KuK2jtuCqzqUJKHOC8ETyLKNuYHIaLgE0zpV2kHsQCcWb/VfAV2lFyqdHT9Dl029
         1lNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wdccEwoNUzYrqC6jNWDrT9rEAVvVXyiFMgGI7jA68lQ=;
        b=35wArZpitEzHbkR49LgiKzKaPZRWWEU8N4pzp01nhrX4c2HwLUctnhq3JmhfAFwyZk
         0X8he30Hf4XMFteHrw703V+5qB7czgrxrUf2IfYEiHtpCECBZBRazYB4lZeTbxQ4MVtY
         ErjMpcdNnVdCREbHxxypagh9V+DZI3zhAn51VhYeHRAhohV10v1m6J9zY+y/GBUZzr8E
         h2m+jHiddyjNuYZD49ISlbHHU5b+4Vx24tK+87MZsd2OlI4+bj+NI/HS7US56BiKm+mE
         V6vzgl584sS0/08YdRjp2HC3+TGhEOUYuNRnDwCnclnw1yHLtJTMf3ILYlG3IJPgd8Ps
         FRKg==
X-Gm-Message-State: ANoB5pkQOiuUp9+CKa6xSehUF+rq5gHQUVtA+ynxROyRE5Up4nrkZPL2
        ke6cLaWCLMNXl48tO7Tu0gEaEl/v+lXc/6jk2As=
X-Google-Smtp-Source: AA0mqf4EmcLVsqU7UbhglMRJS2t+F+vm+uCeB++oDgfvumT67E/omHA7fyQhH1O6Lipy+diU8tBHUJZMSGBvomoZELQ=
X-Received: by 2002:a05:6402:d6a:b0:467:6dbf:e3e8 with SMTP id
 ec42-20020a0564020d6a00b004676dbfe3e8mr23352735edb.291.1669934597635; Thu, 01
 Dec 2022 14:43:17 -0800 (PST)
MIME-Version: 1.0
References: <20221201103026.53234-1-tomeu.vizoso@collabora.com> <20221201103026.53234-4-tomeu.vizoso@collabora.com>
In-Reply-To: <20221201103026.53234-4-tomeu.vizoso@collabora.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Thu, 1 Dec 2022 23:43:06 +0100
Message-ID: <CAFBinCB1pZm0AaJq4_dsVksdp7RP+aTiXK04wFeLQ9vChbkYCQ@mail.gmail.com>
Subject: Re: [PATCH v5 3/7] soc: amlogic: meson-pwrc: Add NNA power domain for A311D
To:     Tomeu Vizoso <tomeu.vizoso@collabora.com>
Cc:     italonicola@collabora.com,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        "moderated list:ARM/Amlogic Meson SoC support" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:ARM/Amlogic Meson SoC support" 
        <linux-amlogic@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 1, 2022 at 11:30 AM Tomeu Vizoso <tomeu.vizoso@collabora.com> wrote:
>
> Based on power initialization sequence in downstream driver.
>
> Signed-off-by: Tomeu Vizoso <tomeu.vizoso@collabora.com>
> Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>

[...]
> +static struct meson_ee_pwrc_mem_domain g12a_pwrc_mem_nna[] = {
> +       { G12A_HHI_NANOQ_MEM_PD_REG0, GENMASK(31, 0) },
> +       { G12A_HHI_NANOQ_MEM_PD_REG1, GENMASK(23, 0) },
I noticed the discussion in v1 of this series where Neil noted that
you should change GENMASK(31, 0) to GENMASK(23, 0) (for
G12A_HHI_NANOQ_MEM_PD_REG1).
This is all a bit confusing because the S905D3 datasheet mentions that
the HHI_NANOQ_MEM_PD_REG1 register uses the full 32 bits.
I'm still fine with the way it is right now because the datasheets are
not always perfect.


Best regards,
Martin
