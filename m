Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A22B9619330
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 10:12:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230473AbiKDJLz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Nov 2022 05:11:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229756AbiKDJLx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Nov 2022 05:11:53 -0400
Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 997EA2649B;
        Fri,  4 Nov 2022 02:11:52 -0700 (PDT)
Received: by mail-qk1-f172.google.com with SMTP id v8so2672355qkg.12;
        Fri, 04 Nov 2022 02:11:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PzX6rG/B8kF4TsRKaQtz2IqEe2ECE0qbVhkf+p2vZis=;
        b=ShBkKVrL4x1hOajlN9Nl08tL1RhHbVNZ9RBYcixQCIOqhhjo6/gFRNqd4EbxFgyrvI
         at+PEM//geVMShjUaox5WMX1Chy4WLMnNNAMNN9pXxjrK+LS7bOrWY7LXu1VEwjg3S2a
         JzLfqmVjjofh/J2DXn1N+lVJC3C2+McAwStWrvZ/iDg/A24s3KdbZ1/xQn1zrmxPEITm
         zzLy9SDNDJ8W8D3wQ+ceUnc8IW+y0SuoLh0THjCID9uOCNHRh3F9jYFF/0sihrZJKrit
         8d/pTAnH52rzjk+ckffw4Z82/iA82J7KsZ1JlIEheays96mP9Fv7HYEkXcsYP3IS8d1J
         SE+g==
X-Gm-Message-State: ACrzQf26sFOT2dmKEPNg4v6qc6H3q4kGemzPjMxZk8gHTjo639M4j/X5
        h9lgpxKi74SvwgVqDLSPzgOj/YE0ISy7mg==
X-Google-Smtp-Source: AMsMyM6BnIBgAPsBg3UyFAICL+ZejYZSTIKRLZFfWRdI5AHysgOvO/cayId/SvqoV5cP70bnVfMR5w==
X-Received: by 2002:a05:620a:16b4:b0:6fa:207d:ff5e with SMTP id s20-20020a05620a16b400b006fa207dff5emr21795360qkj.59.1667553111691;
        Fri, 04 Nov 2022 02:11:51 -0700 (PDT)
Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com. [209.85.219.179])
        by smtp.gmail.com with ESMTPSA id q14-20020a05620a0d8e00b006e8f8ca8287sm2603014qkl.120.2022.11.04.02.11.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Nov 2022 02:11:51 -0700 (PDT)
Received: by mail-yb1-f179.google.com with SMTP id j2so5109567ybb.6;
        Fri, 04 Nov 2022 02:11:50 -0700 (PDT)
X-Received: by 2002:a25:6b07:0:b0:6cd:3a43:bfe5 with SMTP id
 g7-20020a256b07000000b006cd3a43bfe5mr21279423ybc.89.1667553110629; Fri, 04
 Nov 2022 02:11:50 -0700 (PDT)
MIME-Version: 1.0
References: <20221103204859.24667-1-wsa+renesas@sang-engineering.com>
In-Reply-To: <20221103204859.24667-1-wsa+renesas@sang-engineering.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 4 Nov 2022 10:11:38 +0100
X-Gmail-Original-Message-ID: <CAMuHMdV4P39zLO4MBFj9ZHaLkrpJAeQ-+TPN+i92PHXbhEc8aA@mail.gmail.com>
Message-ID: <CAMuHMdV4P39zLO4MBFj9ZHaLkrpJAeQ-+TPN+i92PHXbhEc8aA@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: timer: renesas,tmu: Add r8a779g0 support
To:     Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc:     linux-renesas-soc@vger.kernel.org,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 3, 2022 at 9:49 PM Wolfram Sang
<wsa+renesas@sang-engineering.com> wrote:
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
