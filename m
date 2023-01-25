Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E870F67B0B0
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jan 2023 12:09:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235177AbjAYLJg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Jan 2023 06:09:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235263AbjAYLJJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jan 2023 06:09:09 -0500
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1ADA54B740;
        Wed, 25 Jan 2023 03:09:05 -0800 (PST)
Received: by mail-qt1-f173.google.com with SMTP id d3so886528qte.8;
        Wed, 25 Jan 2023 03:09:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hytH7Ayjy2lSXxgse9Hs7i/6L/ka4Pba77DRcwMleL0=;
        b=BIQV3l+pE0ELpyGFQY1nrcl0CqJ4Rw1hZ4zkWdMXkKZr6YTJdo1rO6G/Ikbk9skHSK
         Ur9HC6kzjjCPCvOVSPgTJVcRxiujphdNrItSrGT1bZcY9Ct5exTTzlEQTf6HRe7fcetg
         0sbk1Wk7U+UNUoONUdFWoowwcNPpHLJsGkipc/DnU4WIlXsdAdj+bmEweJAeCKYEQ4nn
         KEvYKHek6UwehtqIOB2NZUzI/399Jh42mT+ggMjAavj/Y79KcEgJ4NRgM9G52Gt0ZeH7
         gFucus14lBWacJfZSjOqUDBnIUmQQxy129fqOqezBDPaozeg/1gt8LxtAFnDsYrnepJO
         1RcQ==
X-Gm-Message-State: AFqh2koq9NKP/jRqEMgP+bqUqp4cZWpnkNFCes7itGJ0WckwSoVW19aw
        JjfG03G5x2t7MyYh1Ox9EyCx6IaUJQoGeA==
X-Google-Smtp-Source: AMrXdXtDSnoslcx9l7iRN+ZGb6XVPWM/e8vWVLBHlAQ9dkHmE9IUkxrIrra2XGxn+Fb2PO+yhEgQSQ==
X-Received: by 2002:a05:622a:a09:b0:3b6:309e:dfdb with SMTP id bv9-20020a05622a0a0900b003b6309edfdbmr50291880qtb.22.1674644943971;
        Wed, 25 Jan 2023 03:09:03 -0800 (PST)
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com. [209.85.128.175])
        by smtp.gmail.com with ESMTPSA id e1-20020ac84141000000b003b63c08a888sm3221025qtm.4.2023.01.25.03.09.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Jan 2023 03:09:03 -0800 (PST)
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-4ff1fa82bbbso211669727b3.10;
        Wed, 25 Jan 2023 03:09:03 -0800 (PST)
X-Received: by 2002:a05:690c:c89:b0:4dd:7a8e:1cf3 with SMTP id
 cm9-20020a05690c0c8900b004dd7a8e1cf3mr3348364ywb.384.1674644942927; Wed, 25
 Jan 2023 03:09:02 -0800 (PST)
MIME-Version: 1.0
References: <20230118135259.19249-1-fabrizio.castro.jz@renesas.com>
In-Reply-To: <20230118135259.19249-1-fabrizio.castro.jz@renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 25 Jan 2023 12:08:51 +0100
X-Gmail-Original-Message-ID: <CAMuHMdX2x=AFUCCC86UuQych4mN2v6NgWdwXnEogpDmgMrdoMg@mail.gmail.com>
Message-ID: <CAMuHMdX2x=AFUCCC86UuQych4mN2v6NgWdwXnEogpDmgMrdoMg@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: renesas: r9a09g011: Reword ethernet status
To:     Fabrizio Castro <fabrizio.castro.jz@renesas.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Magnus Damm <magnus.damm@gmail.com>,
        linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Biju Das <biju.das@bp.renesas.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Jacopo Mondi <jacopo@jmondi.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 18, 2023 at 2:53 PM Fabrizio Castro
<fabrizio.castro.jz@renesas.com> wrote:
> Although of_fdt_device_is_available returns true when the DT
> property "status" is assigned "ok" or "okay", and false for every
> other value, it's become common practice to assign "disabled"
> when we want of_fdt_device_is_available to return false.
> For some reason, the status property of the ethernet node was
> assigned "disable" when originally added to the kernel. Change
> it to "disabled" for consistency.
>
> Signed-off-by: Fabrizio Castro <fabrizio.castro.jz@renesas.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
i.e. will queue in renesas-devel for v6.3.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
