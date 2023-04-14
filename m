Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 145756E1B96
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Apr 2023 07:19:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229553AbjDNFTQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Apr 2023 01:19:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229636AbjDNFTP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Apr 2023 01:19:15 -0400
Received: from mail-oa1-x32.google.com (mail-oa1-x32.google.com [IPv6:2001:4860:4864:20::32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A4A61FD2;
        Thu, 13 Apr 2023 22:19:10 -0700 (PDT)
Received: by mail-oa1-x32.google.com with SMTP id 586e51a60fabf-18779252f7fso8467430fac.12;
        Thu, 13 Apr 2023 22:19:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681449549; x=1684041549;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V99wgKb499+9VrSvxbUr6s15Psglq894fCu8CZq/rEU=;
        b=WqKAAp1l5pn4CHAIORc/ME3DhmRJPzTL5tDeqPvveDFoafEWulN/voiYR+d+Xo1xfg
         qLdcg/NgoMMgZU45ER4cMCVQlUboDz83vyLgTP4dKoQ8d5BzJyVE2aVxsnlrOLuBmQBz
         LOc6tFbv3x+d7pRQ1P8ml4jY5LriVr9zjwWP9IrR+xjeVoqDTq1GrJE9+C0ptquOgtc4
         PoymooWoSG2zOLu7WySxweEMUgO701ODcbWjXapsQhmGLv10bS0Fe+ec5bMDv9XJu2y6
         ufuGIjLE+QJJzGs3+wzs+mumdVeBcSzerjm/ZJSmKJ0BAL1qSWdNG83OLNkTm7Q8eJ/W
         8EsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681449549; x=1684041549;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=V99wgKb499+9VrSvxbUr6s15Psglq894fCu8CZq/rEU=;
        b=DxJebhu1nCRiXpgNwMCoZdNxYOqIDHM6WoEzVYaqsHx75MiHj+dGFbcXOkgNEoCwzJ
         YWQHC+sbzb8KMclYbXl6yx37KQoSihOfHQeE3q0hrSTwNpsd8FzEdFt9dgyTbV0osx8W
         9t+mj8igmp7TbQnCnrqvQKZQ32ZxwRCH+WSvMjMVu/6KrLvH3s0XPa1v5afRtIXW9YCU
         EsL7EK/PZA509766UJvMmRJFkcifsUrdS/9gZ5VqN+Sx20L6D+jWCN1ThlugvcNYOiEs
         FAhvsOaeqRQ6Qj6x6hQyexzX7QdukwyCkDuY1YQH3dpXjYhgNpaVcc0gAcTkXHkA18o8
         wm5g==
X-Gm-Message-State: AAQBX9ewtxT2i1RPelAMrWYOQuVLKt5Zq73GtnGz4KBrkyzbnkAZa1h5
        4aVPgtUHpwSrs6oK2dV/qXjMje1jPHOPFHmTkRjCx7L/ByU=
X-Google-Smtp-Source: AKy350YhFKBqyd5LScqou206ROnoHlD0S94N0EvVsdQvoyPVyih2qSotfVh+hMqqvnyqnB46Z4LPjnWW+M09FqSEOJc=
X-Received: by 2002:a05:6870:e9aa:b0:187:7f01:7e74 with SMTP id
 r42-20020a056870e9aa00b001877f017e74mr2428531oao.0.1681449549348; Thu, 13 Apr
 2023 22:19:09 -0700 (PDT)
MIME-Version: 1.0
References: <20230321050034.1431379-1-sergio.paracuellos@gmail.com>
 <CAMhs-H-0Upz--k0tkm7BFCTd0b0Gso-c_uPyzeAjOigZowbK1Q@mail.gmail.com> <d20a8910675be9acab3b2f4ac123fbf3.sboyd@kernel.org>
In-Reply-To: <d20a8910675be9acab3b2f4ac123fbf3.sboyd@kernel.org>
From:   Sergio Paracuellos <sergio.paracuellos@gmail.com>
Date:   Fri, 14 Apr 2023 07:18:57 +0200
Message-ID: <CAMhs-H-BfZb3mD8E=LeJ4vT22uibQ1DnaZsfTrtRxSiv=8L5RA@mail.gmail.com>
Subject: Re: [PATCH v2 0/9] mips: ralink: add complete clock and reset driver
 for mtmips SoCs
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     linux-clk@vger.kernel.org, linux-mips@vger.kernel.org,
        tsbogend@alpha.franken.de, john@phrozen.org,
        linux-kernel@vger.kernel.org, p.zabel@pengutronix.de,
        mturquette@baylibre.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, matthias.bgg@gmail.com,
        devicetree@vger.kernel.org, arinc.unal@arinc9.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 13, 2023 at 8:56=E2=80=AFPM Stephen Boyd <sboyd@kernel.org> wro=
te:
>
> Quoting Sergio Paracuellos (2023-04-13 01:44:56)
> >
> > Gentle ping on this series :-)
>
> Please trim replies. I had marked the whole series as superseded because
> of the first patch discussions. I reviewed the clk driver now. In
> general, use the fixed rate and fixed factor basic clk types. Don't
> change hardware in recalc_rate().

Thanks, Stephen. I was expecting an answer in my request of
Reviewed-by of the bindings after the discussion about the first patch
between Arinc and Rob before resending anything [0].

I will reply to your review comments shortly.

Thanks,
    Sergio Paracuellos

[0]: https://lore.kernel.org/linux-mips/d20a8910675be9acab3b2f4ac123fbf3.sb=
oyd@kernel.org/T/#m6ae224c084b5b482ccfe0cfd0d936fb9ce1354b0
