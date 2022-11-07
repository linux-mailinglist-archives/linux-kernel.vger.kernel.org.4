Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA01961EF27
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 10:35:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230263AbiKGJf5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 04:35:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230239AbiKGJfz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 04:35:55 -0500
Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13096C10;
        Mon,  7 Nov 2022 01:35:53 -0800 (PST)
Received: by mail-qv1-f52.google.com with SMTP id lf15so7268590qvb.9;
        Mon, 07 Nov 2022 01:35:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fi0NICzB6CQRFVjI8GHZ+Wi7PHRf6zbpoIi4V5fnIFk=;
        b=vM3+hdmTJg7BFHEq55F1ra9/J8fuDlEk6SsqOroXArcd7OIfbya/fBEdhlkvmRFlFH
         E4jE7fr+Knq85eHxGt75DPQx4KOtHdRSi/e1JH12YrxCQSsBaapE5slTOKXpFrdB85z9
         6J/XYKTart7nMxriCCOpIwpm5RNNjUVGXXawXgeDcsy4Tc9seRhCuaemOsho18BXc76r
         rwSv1iDC03hhMYMV65BFRNbEt8IH0ffZL5JAhJ2DStke1CPnzThUbg8X95ZjnuZ8drTJ
         5NVdwqtkC8GxWARkiiRlfm4C5kCLzlyMfAJGi4F2SF0pcfR+Sb4fKJ463OdMqjnVUSgb
         N08w==
X-Gm-Message-State: ACrzQf3dTeGoPFpphMGv4pe2yHmP89bT2cliacy7MHVaVIPGre3kaPMj
        4KohO0TMOyzqcYbbsOd3BSECF21NOukrUw19
X-Google-Smtp-Source: AMsMyM4jCSpy9AAI+xuEscgNL5kWAHLRhFYAkKoRyaf7G1hvhbeC56qXDbohueVWFL0k1dE1hGZ/qw==
X-Received: by 2002:ad4:5f4c:0:b0:4b8:ec94:68e with SMTP id p12-20020ad45f4c000000b004b8ec94068emr43215733qvg.38.1667813752048;
        Mon, 07 Nov 2022 01:35:52 -0800 (PST)
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com. [209.85.128.173])
        by smtp.gmail.com with ESMTPSA id f9-20020a05622a104900b0039cb59f00fcsm5792245qte.30.2022.11.07.01.35.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Nov 2022 01:35:51 -0800 (PST)
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-36a4b86a0abso98661197b3.7;
        Mon, 07 Nov 2022 01:35:51 -0800 (PST)
X-Received: by 2002:a0d:e301:0:b0:374:a8ba:99b0 with SMTP id
 m1-20020a0de301000000b00374a8ba99b0mr941336ywe.358.1667813751027; Mon, 07 Nov
 2022 01:35:51 -0800 (PST)
MIME-Version: 1.0
References: <20221104150642.4587-1-wsa+renesas@sang-engineering.com>
In-Reply-To: <20221104150642.4587-1-wsa+renesas@sang-engineering.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 7 Nov 2022 10:35:38 +0100
X-Gmail-Original-Message-ID: <CAMuHMdWwp421JC2E9cBViG55xi3TOzCpKAo99V6vfH14LVm6gw@mail.gmail.com>
Message-ID: <CAMuHMdWwp421JC2E9cBViG55xi3TOzCpKAo99V6vfH14LVm6gw@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: timer: renesas,cmt: Add r8a779g0 CMT support
To:     Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc:     linux-renesas-soc@vger.kernel.org,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 4, 2022 at 4:07 PM Wolfram Sang
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
