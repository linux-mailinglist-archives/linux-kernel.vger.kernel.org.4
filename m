Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73B3460457E
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 14:38:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233245AbiJSMik (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 08:38:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231818AbiJSMiH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 08:38:07 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3BA11D0D46;
        Wed, 19 Oct 2022 05:18:38 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id cl1so16634322pjb.1;
        Wed, 19 Oct 2022 05:18:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=4UfKB24CuAxAVPOItr5Q5TcZjPxYaIsgbWsletLKpPk=;
        b=Glc3hntbf7+X4oSfg4Kt2hXTpwzHboRzXWIRZLJwz4UZOJFiv4lIYoTZGv1xIvZZvY
         vh0Uk4oXT88oCeBoN1bX6kcHeJ0o8SEPL89G/C0AdufsHZMkrWCybXu55IsjadpH7PHF
         8TpiG3HEun4eTaZu3OUvfy+1+ur0oiCCttNcZmtTRIKZ7hruHJPbeOs0oEBn6YhKiaiO
         P6rXlGULIid+5i8S/NUo/wg21QOA9URUvlqfLbPm56opXGxgkEX5tm0iDNcFJSgetw6q
         puRVpsliBuPPrc05ECqf3no2BfTIycsDovb8w5KAs6JR60t7z8xihzpgZiAfl4w6ixFw
         gJ4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4UfKB24CuAxAVPOItr5Q5TcZjPxYaIsgbWsletLKpPk=;
        b=kHhGeQQI2k/RqOFcUOYqSzGNvTBskGk8bVuuLbaPipNvqpdZeIb2mxCPgL5EjGVcD4
         +Ezs/SVNXMSq+yRY6aJReNnkmbYF+EWiwnEXe8XA2NFm5Rs2Q6axFmjnAd11+5Yc1eLx
         /5KEET05mOXp19S3t28udTiHZ56J7MRBJRr2KWlrmiXKzYg0Zitb5yJSmtbS50qmcDEA
         8G2XkPRU0qE/XTaTGHNHr56Er2tjYi/SC6ZozhowG7ffkg6gwnORxKFnJCZLOlRuDCpy
         D/ntde0y/8qkPc9PUdnPZJpVPRgWl010MOfYireUIm2ffnmg7kgz21JNngDcWbRwAOqP
         vLcg==
X-Gm-Message-State: ACrzQf1g8nkAkfS59RAHjb0Kx1BDs8Y5kCcROvSwQNpvDqysuuWmbrIl
        4jNBeHEnn6bfJDlQnHTic7g/X7vHBWj9XCU4xhc=
X-Google-Smtp-Source: AMsMyM6TKCzZvl3GD8vsawCX4Gt1qWFWL9hwNUxw9F0URCBmpYuIu/BTt25IwHFdfqFKzFZiI76GmTJ5ocEI69dvzFk=
X-Received: by 2002:a17:902:d2cf:b0:17f:7b65:862f with SMTP id
 n15-20020a170902d2cf00b0017f7b65862fmr8131289plc.168.1666181791980; Wed, 19
 Oct 2022 05:16:31 -0700 (PDT)
MIME-Version: 1.0
References: <20221019111714.1953262-1-andrej.picej@norik.com>
In-Reply-To: <20221019111714.1953262-1-andrej.picej@norik.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Wed, 19 Oct 2022 09:16:23 -0300
Message-ID: <CAOMZO5Detga+MSrzb4ZjkPsaoat-rD9bv9235V9A+OG1Fy+L8g@mail.gmail.com>
Subject: Re: [PATCH 0/3] Suspending i.MX watchdog in WAIT mode
To:     Andrej Picej <andrej.picej@norik.com>
Cc:     linux-watchdog@vger.kernel.org, shawnguo@kernel.org,
        linux@roeck-us.net, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-imx@nxp.com, kernel@pengutronix.de, s.hauer@pengutronix.de,
        wim@linux-watchdog.org, robh+dt@kernel.org
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

Hi Andrej,

On Wed, Oct 19, 2022 at 8:17 AM Andrej Picej <andrej.picej@norik.com> wrote:
>
> The i.MX6 watchdog can't be stopped once started. This means that
> special hardware suspend needs to be configured when the device enters
> low-power modes.
> Usually i.MX devices have two bits which deal with this:
> - WDZST bit disables the timer in "deeper" low power modes and
> - WDW bit disables the timer in "WAIT" mode which corresponds with
> Linux's "freeze" low-power mode.
>
> WDZST bit support is already in place since 1a9c5efa576e ("watchdog: imx2_wdt: disable watchdog timer during low power mode").
> WDW bit is not common for all imx2-wdt supported devices, therefore use
> a new device-tree property "fsl,suspend-in-wait" which suspends the
> watchdog in "WAIT" mode.
>
> Andrej Picej (3):
>   watchdog: imx2_wdg: suspend watchdog in WAIT mode
>   dt-bindings: watchdog: fsl-imx: document suspend in wait mode
>   ARM: dts: imx6ul/ull: suspend i.MX6UL watchdog in wait mode

For the series:

Reviewed-by: Fabio Estevam <festevam@gmail.com>
