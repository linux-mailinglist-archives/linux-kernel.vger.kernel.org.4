Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 028CF600C96
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 12:38:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230346AbiJQKiA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 06:38:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230196AbiJQKhz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 06:37:55 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C2685A2F7
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 03:37:54 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id e18so15380006edj.3
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 03:37:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=astfVBtSyKdKvd0fX3jHrBgZu0AnzDfSsMZqr5EJJDE=;
        b=KM4POit6QqElBFsIloDONBUeZOX6E1PExQRZ8zfvccQ3OU6r1EwiCdmbn/gEDK6GPr
         BgYGit1oxISahB9qFJk/Q6O5ARN8R+HgJQokxk4K3T9z95dB8v8IO9zarTv1QGnTdItS
         HeRRHHhoZYqnKzZB0x1FmLI1AVCSMTli4/jvAd3Ta7XOwVtub8aUD66WPI1vma4Qa38D
         OOWADfaIpngbV32+DL7wmfK/ltz+uS1vNSj+j4sqTiSkBElXGrCGv6uU1cG+ql0SIcKz
         0UzX2pnXBnVakm0xR/wdVtylpRAkIIDp1vaF4DwZhksMepDdaeKBQBuxZhel7I/arN9X
         45Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=astfVBtSyKdKvd0fX3jHrBgZu0AnzDfSsMZqr5EJJDE=;
        b=3iA2J6XC6u9ho1Rj3QRgQ18NjLS5Pn+2YhDtTz6XGkr4C+hyiL0ztReCBVPsHWnLK0
         2JS6lNrCeFOHtFmrFsyoS1jry3pzKjRdq3SV/Jo6lqGOfyw7DIpV90ApbpLzM4sDs9Mp
         Ynv65tmifHEQgAyCicumLH9RSiLDC6XrAnFefDThKp/wtr01Z+XyE9QM0YaAYSF3xaJU
         GZvj98kvlswXs9Z34EeWh4cbu4xB3TbNulYZIEZh13jObJIuzDLeNwfl8KFHnunxiOjb
         PxqkF27PPHZBKjHH3kKB2cI64CFKjy395NJ81mZqehYfZ0SylN2S39ze+GtV+C6EzuGk
         qexg==
X-Gm-Message-State: ACrzQf2F+H9m2e4stfLh4SofoXidEH7+AW7iTLtq1TKF59ioooesEC7u
        TFE2WDNk/zKT3Y21oURWg9KW/WGFW8EKYXls5ppeXw==
X-Google-Smtp-Source: AMsMyM59VzK7rtNlUbf5x+F09ZWS45bDB6OAcY3eDwpfVQgGBT551R2eyvVotDsWU6lwqI73+ETPSySEmtMnJqKQUyw=
X-Received: by 2002:a05:6402:d0b:b0:458:a244:4e99 with SMTP id
 eb11-20020a0564020d0b00b00458a2444e99mr9676438edb.46.1666003072753; Mon, 17
 Oct 2022 03:37:52 -0700 (PDT)
MIME-Version: 1.0
References: <20221011135849.2785834-1-robh@kernel.org>
In-Reply-To: <20221011135849.2785834-1-robh@kernel.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 17 Oct 2022 12:37:41 +0200
Message-ID: <CACRpkdakvkRN29beYoMrcRvQkoNfLL0iTaN51q6V7-tSMLj6ig@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: ata: Add 'ata-generic' binding
To:     Rob Herring <robh@kernel.org>,
        Serge Semin <Sergey.Semin@baikalelectronics.ru>
Cc:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Alexander Shiyan <shc_work@mail.ru>, linux-ide@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
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

On Tue, Oct 11, 2022 at 4:00 PM Rob Herring <robh@kernel.org> wrote:

> The 'ata-generic' binding has been around since 2008, but never
> documented.
>
> Cc: Alexander Shiyan <shc_work@mail.ru>
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
> AFAICT, the ata-generic,use16bit property has no effect in Linux. The
> 32-bit transfers fallback to 16-bit if ATA_PFLAG_PIO32 flag is not set
> which it doesn't appear to ever be set. Looking at the history, the
> driver always used 16-bit mode.
>
> Linus, Okay with being maintainer here?

Yeah one more or less :)
But ATA was never my strong card. What about Sergey Semin?
He surely seems to be on top of ATA stuff. Or add us both.

Yours,
Linus Walleij
