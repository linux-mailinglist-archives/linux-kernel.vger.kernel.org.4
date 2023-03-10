Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41E7E6B4CA6
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 17:20:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230510AbjCJQUP convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 10 Mar 2023 11:20:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231426AbjCJQT1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 11:19:27 -0500
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 562B012A4D8;
        Fri, 10 Mar 2023 08:14:43 -0800 (PST)
Received: by mail-qt1-x830.google.com with SMTP id h19so6211110qtk.7;
        Fri, 10 Mar 2023 08:14:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678464822;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/6VRob8/fQLV06XBny84iEJyLShqBsknJt6xLcf5GB4=;
        b=NAbPPdQbyDUCAPPDMwgvZa3G0obTXAHWu7+L5ASMbUgsqPs7I+AZJzUMs/dtXwzpLI
         iJTDzUEdu4u3aAfw0CcpQU7UqZEiC8j+OGcSSRjPycNyGifkOlyPuPjDHjgbzn9LjtgS
         dFZqh/WR/hB5N1OnTb6ozwI6X2U5NcT5wwZcrEPy1MwagqfsYvtSDsNgGdB6lMjhkjRU
         LMi7dl3MgSuc5JAoaBG9UgkoSebCCpJCjT2Xe16xfYy14QvMW4seZluxK3l8UCPQIoxA
         aI9t3TgZPK8wEPOoRRdkT4kmBlo0K1w3Ku8Wg2H1KTGE1r0B30jx/PDO7UrsQ3DYzYUe
         bLaA==
X-Gm-Message-State: AO0yUKURJT+FWjmx7QWZ+uKd/g7sPXhD6p0Dwz6tf07VOCD8pvB7fqjF
        NZeJmKyNREgt33CY3a83SfxdWpZHx6mD/A==
X-Google-Smtp-Source: AK7set/mckn+eI7WfHTg2ENgQp1Tj8tCUf7tx/ZZg3qQ/dqREzvx2Y3gJX6EIMk39ae0WFk3iCE9Xw==
X-Received: by 2002:a05:622a:553:b0:3bf:bac6:9961 with SMTP id m19-20020a05622a055300b003bfbac69961mr10709383qtx.55.1678464822343;
        Fri, 10 Mar 2023 08:13:42 -0800 (PST)
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com. [209.85.128.171])
        by smtp.gmail.com with ESMTPSA id j6-20020ac86646000000b003bfb820f17csm52906qtp.63.2023.03.10.08.13.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Mar 2023 08:13:41 -0800 (PST)
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-536bf92b55cso106282207b3.12;
        Fri, 10 Mar 2023 08:13:41 -0800 (PST)
X-Received: by 2002:a81:b206:0:b0:52f:184a:da09 with SMTP id
 q6-20020a81b206000000b0052f184ada09mr2028227ywh.2.1678464821172; Fri, 10 Mar
 2023 08:13:41 -0800 (PST)
MIME-Version: 1.0
References: <20230307105645.5285-1-wsa+renesas@sang-engineering.com>
 <20230307105645.5285-2-wsa+renesas@sang-engineering.com> <CACRpkdZ5vNdakcGrhhOn=q-tXb7CyCCeMbhCMgrO0bD--KcU6Q@mail.gmail.com>
In-Reply-To: <CACRpkdZ5vNdakcGrhhOn=q-tXb7CyCCeMbhCMgrO0bD--KcU6Q@mail.gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 10 Mar 2023 17:13:29 +0100
X-Gmail-Original-Message-ID: <CAMuHMdUzvX3-O4d1XnirwRH37NwBmAmZfAwoGp=bRSQkuCX0TQ@mail.gmail.com>
Message-ID: <CAMuHMdUzvX3-O4d1XnirwRH37NwBmAmZfAwoGp=bRSQkuCX0TQ@mail.gmail.com>
Subject: Re: [PATCH 1/5] pinctrl: renesas: remove R-Car H3 ES1.* handling
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Wolfram Sang <wsa+renesas@sang-engineering.com>,
        linux-renesas-soc@vger.kernel.org,
        Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

On Thu, Mar 9, 2023 at 2:53 PM Linus Walleij <linus.walleij@linaro.org> wrote:
> On Tue, Mar 7, 2023 at 11:57 AM Wolfram Sang
> <wsa+renesas@sang-engineering.com> wrote:
>
> > R-Car H3 ES1.* was only available to an internal development group and
> > needed a lot of quirks and workarounds. These become a maintenance
> > burden now, so our development group decided to remove upstream support
> > and disable booting for this SoC. Public users only have ES2 onwards.
> >
> > Reviewed-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
> > Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> > Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
>
> Good bye ES1.*, I expect that Geert will queue the patches as usual.

At your service, queuing in renesas-pinctrl-for-v6.4.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
