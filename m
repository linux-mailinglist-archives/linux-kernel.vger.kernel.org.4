Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E17D06ACE06
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 20:28:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229614AbjCFT2P convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 6 Mar 2023 14:28:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229964AbjCFT2M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 14:28:12 -0500
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0C5325282;
        Mon,  6 Mar 2023 11:28:09 -0800 (PST)
Received: by mail-qt1-f175.google.com with SMTP id s12so11798965qtq.11;
        Mon, 06 Mar 2023 11:28:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678130888;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wIliL5pk797sRHXuHIbuPDrs1lXukqwBx7MVQm6ie68=;
        b=1CqK+4NIxeEB3l1iTmv4gD1rzH2MuOk6CvRNq37/X5bywihBiqno+kD8XtkRdldaXH
         UGHxE7aZUlDne0/TlkAEYdLKrQxNXuXe+fucLCRCVT8YcgZxfXOFAjzxAkKv8CJNSZm5
         Jd5+5qN3gASII6il7NyDAM0gSjGIszf9Rw/+qwxBimdOOPbO0CdAlHDyLYodOQgmgvM9
         uexpWW+KGNjWJ9YBmjaDYN3+C0BnKDSyN92kiGTvhFmm4z5J7fpNv1miG+v/U2QILWpF
         7odgezp2dE/BY9QdSdrSM7tlVfcSHXJzXcVUJ9uSuSBrYj7Jz0wCbhccevyHpyl4UuTI
         LrDQ==
X-Gm-Message-State: AO0yUKUTrbyjWgV4irIcdkJL3aoUbkyAnvUkLkKcWwnq9wzF2ERMMp8l
        Bzq7EB6yoaF+vdYntOcyK15tCZmVr2P0Ig==
X-Google-Smtp-Source: AK7set8WC774Vf1goplZxpEtW17xgCfhpGYrA3czdBr05AX+risiH4Iw9Qdeju6ppuhCmLXHBcOSmw==
X-Received: by 2002:ac8:5814:0:b0:3b8:6a92:c8d6 with SMTP id g20-20020ac85814000000b003b86a92c8d6mr19750130qtg.60.1678130888654;
        Mon, 06 Mar 2023 11:28:08 -0800 (PST)
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com. [209.85.128.181])
        by smtp.gmail.com with ESMTPSA id y18-20020ac85f52000000b003b7e8c04d2esm8176082qta.64.2023.03.06.11.28.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Mar 2023 11:28:08 -0800 (PST)
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-53852143afcso203347697b3.3;
        Mon, 06 Mar 2023 11:28:08 -0800 (PST)
X-Received: by 2002:a81:b61d:0:b0:52e:f66d:b70f with SMTP id
 u29-20020a81b61d000000b0052ef66db70fmr7170565ywh.5.1678130887951; Mon, 06 Mar
 2023 11:28:07 -0800 (PST)
MIME-Version: 1.0
References: <20230216175347.99778-1-prabhakar.mahadev-lad.rj@bp.renesas.com> <20230216175347.99778-4-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20230216175347.99778-4-prabhakar.mahadev-lad.rj@bp.renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 6 Mar 2023 20:27:57 +0100
X-Gmail-Original-Message-ID: <CAMuHMdV=eYz2goQHneSXUNjFFacavNAtDHJdtePMsYTO2BAfkQ@mail.gmail.com>
Message-ID: <CAMuHMdV=eYz2goQHneSXUNjFFacavNAtDHJdtePMsYTO2BAfkQ@mail.gmail.com>
Subject: Re: [PATCH 3/3] arm64: dts: renesas: rzg2l-smarc: Enable CRU and CSI nodes
To:     Prabhakar <prabhakar.csengg@gmail.com>
Cc:     Magnus Damm <magnus.damm@gmail.com>,
        Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
        =?UTF-8?Q?Niklas_S=C3=B6derlund?= 
        <niklas.soderlund+renesas@ragnatech.se>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
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

On Thu, Feb 16, 2023 at 6:54 PM Prabhakar <prabhakar.csengg@gmail.com> wrote:
> From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
>
> Enable CRU and CSI nodes and tie the CSI remote endpoint with
> OV5645 endpoint.
>
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
