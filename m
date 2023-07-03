Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 544E0745B84
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jul 2023 13:48:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231328AbjGCLsE convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 3 Jul 2023 07:48:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231401AbjGCLsA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 07:48:00 -0400
Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com [209.85.219.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 585C0E8;
        Mon,  3 Jul 2023 04:47:59 -0700 (PDT)
Received: by mail-yb1-f171.google.com with SMTP id 3f1490d57ef6-c581c758ad8so462454276.1;
        Mon, 03 Jul 2023 04:47:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688384878; x=1690976878;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uD1lL3AqZw/En4NSEtQUIk0MJ/LF3aM3VljhUrwO4vc=;
        b=Ff4nKiI7X+aipZ2NYKbJGJxt9kSyAAnHy0+Yg9Tp+nLLzVHEgpqaDHhYrFzCkV0s9V
         PFGYkVbAfYudPcJnPJjNO2Rxt5KYeoBoeZbuTDuS3knCVlLwQjz4EcDocD//lxNpTw91
         RZGd0JbpLAgdXSxHHfBJ7+Yxk7pDTw3AHixr+P6xb0BH9GclhI+WO1zLXLYkvJsFStvD
         7BcV1WafUVa38c4aLTmmly13EMa479wWgWo1oeyUwQWI1qikHLyNPUQBj1gXxlwiA0Om
         xzvudNUOVH72m//cFBjrvo5lejtrcqs/MNsuMkl9VVKqD34hRJby1JvCKrnmUSr99mt9
         +bSQ==
X-Gm-Message-State: ABy/qLZOgIH3LMYxI7o81xn2FdAlrOhK91wM0BOo/TN3/YQBnWYQBjol
        AtduZm+vjcZ/StcAo6OpD3y2E8EBkepCkw==
X-Google-Smtp-Source: APBJJlGFWI1JcRTOQW+ynB1DvGK1KlIBWnJYCxAaHXBBOIVpFD5TCvLn/iHkeZAKee1nfP2vuTLvqA==
X-Received: by 2002:a5b:44a:0:b0:c21:1a86:d2b7 with SMTP id s10-20020a5b044a000000b00c211a86d2b7mr8292929ybp.55.1688384878388;
        Mon, 03 Jul 2023 04:47:58 -0700 (PDT)
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com. [209.85.128.174])
        by smtp.gmail.com with ESMTPSA id 4-20020a250704000000b00c3a96009bdfsm2265366ybh.35.2023.07.03.04.47.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Jul 2023 04:47:58 -0700 (PDT)
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-579dd20b1c8so25056017b3.1;
        Mon, 03 Jul 2023 04:47:58 -0700 (PDT)
X-Received: by 2002:a25:26cb:0:b0:c39:db28:6a50 with SMTP id
 m194-20020a2526cb000000b00c39db286a50mr8508785ybm.36.1688384878017; Mon, 03
 Jul 2023 04:47:58 -0700 (PDT)
MIME-Version: 1.0
References: <20230622113341.657842-1-fabrizio.castro.jz@renesas.com> <20230622113341.657842-5-fabrizio.castro.jz@renesas.com>
In-Reply-To: <20230622113341.657842-5-fabrizio.castro.jz@renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 3 Jul 2023 13:47:46 +0200
X-Gmail-Original-Message-ID: <CAMuHMdXW9Vrk8y+UOAHaRdAkEwy6gXNGgdRAawPLrEqDHB+cvQ@mail.gmail.com>
Message-ID: <CAMuHMdXW9Vrk8y+UOAHaRdAkEwy6gXNGgdRAawPLrEqDHB+cvQ@mail.gmail.com>
Subject: Re: [PATCH v2 4/5] arm64: dts: renesas: r9a09g011: Add CSI nodes
To:     Fabrizio Castro <fabrizio.castro.jz@renesas.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Magnus Damm <magnus.damm@gmail.com>,
        linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Biju Das <biju.das@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 22, 2023 at 1:34 PM Fabrizio Castro
<fabrizio.castro.jz@renesas.com> wrote:
> The Renesas RZ/V2M comes with 6 Clocked Serial Interface (CSI)
> IPs (CSI0, CSI1, CSI2, CSI3, CSI4, CSI5), but Linux is only
> allowed access to CSI0 and CSI4.
>
> This commit adds SoC specific device tree support for CSI0 and
> CSI4.
>
> Signed-off-by: Fabrizio Castro <fabrizio.castro.jz@renesas.com>
> ---
>
> v2: no changes

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
i.e. will queue in renesas-devel for v6.6.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
