Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D927D6D0674
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 15:23:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231318AbjC3NXa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 09:23:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230015AbjC3NX1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 09:23:27 -0400
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com [IPv6:2607:f8b0:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 694A6B2
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 06:23:24 -0700 (PDT)
Received: by mail-ot1-x334.google.com with SMTP id o25-20020a9d4119000000b006a11eb19f8eso8789101ote.5
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 06:23:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680182603; x=1682774603;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=a6p4S+OFwxXEt9jpAp/SFRwoGNDlMGGRe6syLDcLJyQ=;
        b=istmsy1ZyFqBqT6CNaXjUsKT6KAO67oRzxSNQtpzGbwHH3zoOSxW1iIMJijz06A+32
         v/74NA9k5O26GyOWDGC/n80Nr336O+5C//8nshppV1pzOx8/VvzUIY1UgDuE+tuZjJ6N
         FGIRTjGWL/D25wTiiKXDUOFzpksZmo2qzuw6JJG5+7jV6zAotKe/2He/GNvE76pLKojz
         9vD/CuJ1+oGKt7KGanTRssOlB2fz4lprnYhw131MXI2KdmtkH8AQg6YuCG+wqnb1asME
         7uNyznItk3KeuCcfXDRQb4cYip1DENwEIQppLCRdxJ/9KCT/9IOrw/fR+AssU5O5/+sV
         /NKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680182603; x=1682774603;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=a6p4S+OFwxXEt9jpAp/SFRwoGNDlMGGRe6syLDcLJyQ=;
        b=XGfWck19Y25Rgb63+NfR1rQJLTbII3uFaTIKr0c4h7ztJLhgGq5BUjobRgtfUM6/MI
         mqTxzSctOBPzl6aru1arnU+1mJZbMs9paT8i9GTY8/lE10sKSB8L9oi6nW6JgoLVEjCS
         TNF3jN+nCOi7srTy9dAGXWFQrB6+X/bySZGxGPdBStqWNa+AaG6fP9iJ40Ru3EQL9JTM
         L30hSwdOg/USRbau1XB5rAbm8Uruvkr2Fne2gBK2USpaSJpu94M1UykvcU5US+duYUni
         K4czf+vih0aPoAyGSWZgB2rqD78ppvY93FT3UrDF9g8lHit8jxs3gxTlPW1i7uhEXEwu
         Bqbw==
X-Gm-Message-State: AAQBX9d4CYAU3It1vc2Ge/cobeuMrsXS4pj3gA0hCJzR32pCUHsb8VRm
        NDlmP10PPCPiR4dUC6u+T0OXRMjyRtFivhritD3oS4P/39pH2vud
X-Google-Smtp-Source: AKy350amzRxvS4xLqnegzflwIzQQwykCGpH7NvTW7w2m6QY0h0ywhz7LQ56ZxDaxK0t3brC6WqCdJkL5tr8nZf4VdS0=
X-Received: by 2002:a05:6830:39d7:b0:6a1:3fd6:5a0b with SMTP id
 bt23-20020a05683039d700b006a13fd65a0bmr4682887otb.2.1680182603640; Thu, 30
 Mar 2023 06:23:23 -0700 (PDT)
MIME-Version: 1.0
References: <20230320152319.665592-1-loic.poulain@linaro.org>
 <20230330114242.GC434339@google.com> <242a5400-b5e6-4707-af88-1d695e114f78@app.fastmail.com>
In-Reply-To: <242a5400-b5e6-4707-af88-1d695e114f78@app.fastmail.com>
From:   Loic Poulain <loic.poulain@linaro.org>
Date:   Thu, 30 Mar 2023 15:22:47 +0200
Message-ID: <CAMZdPi8ZMfLTHaEn2LbXvuen=Rb68KrWJmgbq9Miou_RDi=Btg@mail.gmail.com>
Subject: Re: [PATCH] mfd: syscon: Use of_io_request_and_map() for IO mapping
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Lee Jones <lee@kernel.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnd,

On Thu, 30 Mar 2023 at 14:45, Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Thu, Mar 30, 2023, at 13:42, Lee Jones wrote:
> > On Mon, 20 Mar 2023, Loic Poulain wrote:
> >
> >> Use of_io_request_and_map() instead of of_iomap() so that the
> >> region is reserved and protected, i.e reported in /proc/iomem
> >> and not accessible from user side (CONFIG_IO_STRICT_DEVMEM).
> >>
> >> Signed-off-by: Loic Poulain <loic.poulain@linaro.org>
> >> ---
> >>  drivers/mfd/syscon.c | 2 +-
> >>  1 file changed, 1 insertion(+), 1 deletion(-)
> >>
> >> diff --git a/drivers/mfd/syscon.c b/drivers/mfd/syscon.c
> >> index bdb2ce7ff03b..7e6d4edda118 100644
> >> --- a/drivers/mfd/syscon.c
> >> +++ b/drivers/mfd/syscon.c
> >> @@ -60,7 +60,7 @@ static struct syscon *of_syscon_register(struct device_node *np, bool check_clk)
> >>              goto err_map;
> >>      }
> >>
> >> -    base = of_iomap(np, 0);
> >> +    base = of_io_request_and_map(np, 0, NULL);
> >>      if (!base) {
> >>              ret = -ENOMEM;
> >>              goto err_map;
> >
> > Looks sane though.
> >
> > Arnd, do you have an opinion?
>
> Thanks for pinging me. I would indeed expect this to cause
> problems, as syscon mappings are likely to be used in a way
> that is not entirely clean, with other devices defining
> overlapping ranges.

Isn't syscon exactly here to address that collision/overlapping issue?
From a syscon perspective, it seems to be handled correctly at least
since the mapping is only setup once, with the first user device (in
syscon_node_to_regmap). Or are you thinking about non syscon devices
overlapping the syscon area?




>
> For any other driver, the change makes a lot of sense after
> checking the DT file, but for syscon in particular I don't
> think it's even realistic to check all users.
>
>      Arnd
