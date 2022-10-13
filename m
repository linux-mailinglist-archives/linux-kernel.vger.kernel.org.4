Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2AE0C5FD623
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Oct 2022 10:24:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229845AbiJMIYh convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 13 Oct 2022 04:24:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229581AbiJMIYe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Oct 2022 04:24:34 -0400
Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C68D14D8C8;
        Thu, 13 Oct 2022 01:24:33 -0700 (PDT)
Received: by mail-qv1-f43.google.com with SMTP id mx8so831911qvb.8;
        Thu, 13 Oct 2022 01:24:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AHrcoHTOG18wn0ctQ+LHnoTD0YCldIXqLSZoUy0YBvk=;
        b=BSws7JbzAnjE9Zsp23WTmjSIobK36eppuJ/TncyuuZ5hB5xIJ15MAaB6zUlJEAwgbS
         iDBJBnFJphyL5d+dDE4xpPOZ3vMlqYZfaPMt6yR+z56fJyPw25RvwisRu9GDIh2WrhNL
         YCXSswaqHB16CwTftympaQVBxln2bJSOaUIl52KcK5zHA06Ovdasj2fmrJHAWPIF5psG
         zaEdk3iMPc1+lS4XBRyWY+/zul/sqBOXQF5UQkWBushdkLRbxbKfPgZ751HD8k/uqyUd
         Y9TKq3D8engSTOv8TgdceBrxtSiA6069bTr7VW94GFReBWs9CEN/d5sBCir+Ws38BGB7
         XoTQ==
X-Gm-Message-State: ACrzQf2gxTVYiivWyhQxCOzFHzpuYjvPGnjnZMmftRvq8fhFzltM8kE4
        SCUfzKOzpPFS4ThL95IzLGo1NaZRW9rDRA==
X-Google-Smtp-Source: AMsMyM5/PqVHxf0vfArnCHv6nt+YxXV1SPWUx4GXKlx0eusUvuwvGOso6Qgtf7Snh8mkfpBCg+iArQ==
X-Received: by 2002:ad4:5d68:0:b0:4af:af07:580b with SMTP id fn8-20020ad45d68000000b004afaf07580bmr25715527qvb.14.1665649472154;
        Thu, 13 Oct 2022 01:24:32 -0700 (PDT)
Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com. [209.85.219.172])
        by smtp.gmail.com with ESMTPSA id ay11-20020a05620a178b00b006bb78d095c5sm16891652qkb.79.2022.10.13.01.24.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Oct 2022 01:24:31 -0700 (PDT)
Received: by mail-yb1-f172.google.com with SMTP id e62so1208298yba.6;
        Thu, 13 Oct 2022 01:24:31 -0700 (PDT)
X-Received: by 2002:a25:687:0:b0:6c2:2b0c:26e with SMTP id 129-20020a250687000000b006c22b0c026emr5766529ybg.202.1665649471275;
 Thu, 13 Oct 2022 01:24:31 -0700 (PDT)
MIME-Version: 1.0
References: <c268cb4497cbe79773bb6568f36c37adc6fb5bbe.1665582645.git.geert+renesas@glider.be>
 <Y0cPpJin64ou4ivI@shikoro> <CAMuHMdUqp6J8PZOx57tGpKZKxQBY_bkU7b8Kiqu9DNjmj2vCGg@mail.gmail.com>
 <Y0fFhHYhKC4pbBnh@shikoro>
In-Reply-To: <Y0fFhHYhKC4pbBnh@shikoro>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 13 Oct 2022 10:24:18 +0200
X-Gmail-Original-Message-ID: <CAMuHMdXSxaaajm1SpcgrZo_sk0Ne-Tbx4hTSshNXQUoUCfdYxA@mail.gmail.com>
Message-ID: <CAMuHMdXSxaaajm1SpcgrZo_sk0Ne-Tbx4hTSshNXQUoUCfdYxA@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: memory: renesas,rpc-if: Document R-Car V4H support
To:     Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Sergei Shtylyov <sergei.shtylyov@gmail.com>,
        linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Hai Pham <hai.pham.ud@renesas.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Wolfram,

On Thu, Oct 13, 2022 at 10:00 AM Wolfram Sang
<wsa+renesas@sang-engineering.com> wrote:
> > I actually wrote such a patch a while back.
> > However, I didn't send it after discovering the R-Car V3U Series
> > User’s Manual Rev. 0.50 does not mention the fourth Strobe Timing
> > Adjustment bit (STRTIM) in the RPC-IF PHY Control Register (PHYCNT),
> > which is present on R-Car S4-8 and V4H, but not on R-Car Gen3.
>
> I see. Thanks for the heads up! Maybe this is worth a comment because it
> is an exception to the usual behaviour?

You mean an exception to the exception to the usual behaviour that
R-Car <foo>3 is part of the R-Car Gen3 family, making it the normal
rule? ;-)

We're actually not 100% sure the bit is present or not.  Rev. 0.50 is
still an early revision of the R-Car V3U documentation, so it might lack
some updates.  I tried changing all bits of the PHYCNT register, but
unfortunately all bits except for bit 31 stick on all SoCs I tried, so
we can't use this method to determine which bits exist and which don't.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
