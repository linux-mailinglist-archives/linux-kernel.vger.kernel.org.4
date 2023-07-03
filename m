Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 012D4745B8C
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jul 2023 13:49:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231371AbjGCLtn convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 3 Jul 2023 07:49:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229504AbjGCLtl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 07:49:41 -0400
Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com [209.85.219.169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2595910E;
        Mon,  3 Jul 2023 04:49:40 -0700 (PDT)
Received: by mail-yb1-f169.google.com with SMTP id 3f1490d57ef6-c581c758ad8so464395276.1;
        Mon, 03 Jul 2023 04:49:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688384979; x=1690976979;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=P4/+ijC8ulIilId4/4aWiJo6sUOIg4T/2au1tamaqkM=;
        b=Eqdhh2pYLRYVzvxhWswWn14n4OSUefQfZlAmztQnO5YC3g2WHPaAPSgHl8XtaCGUHk
         0XZFa7qPl+ikLmuPODq+/K767SozOuNgPD1w5wRpJuEoHYgkYgzStEXJ0yGwN+rpASZV
         xeGiC/7S62QIu+S9CTlduWIFmbIBuyZOGUat7YvrCzTy3h3Fl4A0e7AvZfV2rQKLNDmp
         MHJiKFy3JrhK4CEyfp+jkEhv1ilEBq6Ex6yvlQjEpAP7/DRul1mPXpFa3W35eWGjBNZ3
         h34Sy4GO+2LUbdDA3ZNGNHulvR9fQZq7SYfcPE+c94PrAlWoVTX74uzPGj7oDoBt5La/
         cq+A==
X-Gm-Message-State: ABy/qLaDIBVvqXIjclQMIAijGgev8Ltu4WztJBBxXXzwxdWrrJjOPkUx
        BdNtEVoddFWDUFycxUYzHPUHnTooBBiZvQ==
X-Google-Smtp-Source: APBJJlHxjtuPRK3X98XwAKDaWlFDQ1ONdvROkwR297HH2ssQ0lNcYS4pgb9FILLcgqihXp3Jbe8vUA==
X-Received: by 2002:a25:f204:0:b0:c4c:ec2c:3c9a with SMTP id i4-20020a25f204000000b00c4cec2c3c9amr4240270ybe.16.1688384979088;
        Mon, 03 Jul 2023 04:49:39 -0700 (PDT)
Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com. [209.85.219.179])
        by smtp.gmail.com with ESMTPSA id v70-20020a252f49000000b00c4d485120d5sm955866ybv.31.2023.07.03.04.49.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Jul 2023 04:49:38 -0700 (PDT)
Received: by mail-yb1-f179.google.com with SMTP id 3f1490d57ef6-be49ca27e1fso4819101276.3;
        Mon, 03 Jul 2023 04:49:37 -0700 (PDT)
X-Received: by 2002:a25:ae26:0:b0:c3c:b8fb:524e with SMTP id
 a38-20020a25ae26000000b00c3cb8fb524emr8785588ybj.64.1688384977235; Mon, 03
 Jul 2023 04:49:37 -0700 (PDT)
MIME-Version: 1.0
References: <20230622113341.657842-1-fabrizio.castro.jz@renesas.com> <20230622113341.657842-6-fabrizio.castro.jz@renesas.com>
In-Reply-To: <20230622113341.657842-6-fabrizio.castro.jz@renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 3 Jul 2023 13:49:26 +0200
X-Gmail-Original-Message-ID: <CAMuHMdXH_ipqCYY35bQd6BM5ZkkimHRfd8mg34mTqbPnyBM+4g@mail.gmail.com>
Message-ID: <CAMuHMdXH_ipqCYY35bQd6BM5ZkkimHRfd8mg34mTqbPnyBM+4g@mail.gmail.com>
Subject: Re: [PATCH v2 5/5] arm64: defconfig: Enable Renesas RZ/V2M CSI driver
To:     Fabrizio Castro <fabrizio.castro.jz@renesas.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Bjorn Andersson <quic_bjorande@quicinc.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        =?UTF-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?= 
        <nfraprado@collabora.com>,
        =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Biju Das <biju.das@bp.renesas.com>,
        linux-renesas-soc@vger.kernel.org
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
> Enable CSI driver support for Renesas RZ/V2M based platforms.
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
