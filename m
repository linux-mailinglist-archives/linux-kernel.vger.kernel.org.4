Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1563874589C
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jul 2023 11:43:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230489AbjGCJnX convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 3 Jul 2023 05:43:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229820AbjGCJnW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 05:43:22 -0400
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72512CD;
        Mon,  3 Jul 2023 02:43:21 -0700 (PDT)
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-5702415be17so45084507b3.2;
        Mon, 03 Jul 2023 02:43:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688377400; x=1690969400;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kxia0UfgqS/oGm4ifJU+grXMEUFur2Qpj0zc6W0DlDY=;
        b=WoAAnBr2ZuYQyBCL5/5BvkIPYG+GYZacfRjRAx+rPHEuNN9x3rFOuSgxWV6gX7nITz
         0WURke6hFyPhVLbGY4Qg2pbuRifrbwJkSIln5RI1SLWVkClDU0kJupnvfWO4JdDq7NoQ
         N72+9Dl68zvDngq9b3yhjTRgG9x5rZPDvWwRuLCvk4f9xASyyiRNpSucuO6rEDr4mvXO
         ffr93VbxcV5RHZgvels/ObBRCHEOk3V34wkwlHp0PBL5nrvxQYXc2dzgZ61rOFgFhyPv
         RndTHNO/Arb2srs+lpQ5UPk3tvkLa4lbcWZaWGVkdFo72QaWSbEwrWaz+BS9+1YOtiY9
         Mdwg==
X-Gm-Message-State: ABy/qLafTPn9Da5K0cxOhobhNw/0MWiRAUcgOWwu9TVRlOBmHhguTbmH
        Bon+pbBEI4kO0LwwaYlD12w7F3QN8kfuCg==
X-Google-Smtp-Source: APBJJlHr+Cr/g5/igmqZhM/FJRTBQd76vgobptKYG6Thi2FC+p8AfaVwf860ZAC/1zw4O4C0V6S5qQ==
X-Received: by 2002:a0d:d48e:0:b0:56d:3d83:15cb with SMTP id w136-20020a0dd48e000000b0056d3d8315cbmr9126597ywd.44.1688377400463;
        Mon, 03 Jul 2023 02:43:20 -0700 (PDT)
Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com. [209.85.219.169])
        by smtp.gmail.com with ESMTPSA id s4-20020a0dd004000000b0057399b3bd26sm5000509ywd.33.2023.07.03.02.43.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Jul 2023 02:43:20 -0700 (PDT)
Received: by mail-yb1-f169.google.com with SMTP id 3f1490d57ef6-bcb6dbc477eso3793395276.1;
        Mon, 03 Jul 2023 02:43:20 -0700 (PDT)
X-Received: by 2002:a25:7d06:0:b0:bac:f51c:b0ba with SMTP id
 y6-20020a257d06000000b00bacf51cb0bamr8618647ybc.0.1688377400127; Mon, 03 Jul
 2023 02:43:20 -0700 (PDT)
MIME-Version: 1.0
References: <20230622113341.657842-1-fabrizio.castro.jz@renesas.com> <20230622113341.657842-2-fabrizio.castro.jz@renesas.com>
In-Reply-To: <20230622113341.657842-2-fabrizio.castro.jz@renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 3 Jul 2023 11:43:08 +0200
X-Gmail-Original-Message-ID: <CAMuHMdXSn9UpW_negX5PYTtg17GitU9zXGy_JN=VucB4dWn7fg@mail.gmail.com>
Message-ID: <CAMuHMdXSn9UpW_negX5PYTtg17GitU9zXGy_JN=VucB4dWn7fg@mail.gmail.com>
Subject: Re: [PATCH v2 1/5] spi: dt-bindings: Add bindings for RZ/V2M CSI
To:     Fabrizio Castro <fabrizio.castro.jz@renesas.com>
Cc:     Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Biju Das <biju.das@bp.renesas.com>,
        Conor Dooley <conor.dooley@microchip.com>
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
> Add dt-bindings for the CSI IP found inside the RZ/V2M SoC.
>
> Signed-off-by: Fabrizio Castro <fabrizio.castro.jz@renesas.com>
> Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
> ---
>
> v2: no changes

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
