Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 328A172B8E5
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 09:42:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235041AbjFLHmQ convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 12 Jun 2023 03:42:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235008AbjFLHlz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 03:41:55 -0400
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26ACA10E2;
        Mon, 12 Jun 2023 00:41:27 -0700 (PDT)
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-652426346bbso3121796b3a.3;
        Mon, 12 Jun 2023 00:41:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686555587; x=1689147587;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZfTmhYwHEf0iCvCy8Z+q4+p065tZoTThjF1daF8hM/E=;
        b=QyLyR5sD7YwiMHRHSyaXnt7Rzl3Iy/1x6wTRKBpMrqI4JJ6EJTLUcEu1bStfDJsply
         MHvKf0CRAmyFhyXBaRvktIl+KnTOomE+ITnZ5dP2x+YJyESKBkDJY5YjL5r/S3FUW/ZH
         EUaDCdBKSf+6mrHg4UV1QEdslZgeGtnKKHoQ1C7kXqq0is/dIjJQGT7e4yAR0UUTeZS/
         EbCS9S2ia6Qq02mLVzDwSJ2bF2KuCDKgBYEueW1hZWIuVi+K2xZ0qrlwjVS7+IZwYUdH
         oXexxP00KjFZU5fpedhWpMgik2PPRFvQ0n4FNmX5APsW4DdeQGtkKQQEVxCnX9hng9/V
         QVDQ==
X-Gm-Message-State: AC+VfDyqSWMiQULeoc1p63TZQLjiTx3RbLQQcLCPloFCXp4cecW0lQC6
        R48VIUk4fpC6L3LFaXIQwVXukOk7DP6hoA==
X-Google-Smtp-Source: ACHHUZ4g/vbbLvaXeKajjx3XjtFZMUz34s9HLzOzCHg8y4Ox8ijBPZZzJ5ocvu8SJzMvPt5pzO35LQ==
X-Received: by 2002:a1f:ed83:0:b0:464:2bdd:ab1e with SMTP id l125-20020a1fed83000000b004642bddab1emr3649039vkh.5.1686554968250;
        Mon, 12 Jun 2023 00:29:28 -0700 (PDT)
Received: from mail-vs1-f45.google.com (mail-vs1-f45.google.com. [209.85.217.45])
        by smtp.gmail.com with ESMTPSA id 77-20020a1f1950000000b0046142c6abfbsm1301601vkz.25.2023.06.12.00.29.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Jun 2023 00:29:27 -0700 (PDT)
Received: by mail-vs1-f45.google.com with SMTP id ada2fe7eead31-43b4056391dso1000170137.1;
        Mon, 12 Jun 2023 00:29:27 -0700 (PDT)
X-Received: by 2002:a05:6102:3659:b0:43c:15b1:6661 with SMTP id
 s25-20020a056102365900b0043c15b16661mr2721069vsu.2.1686554967247; Mon, 12 Jun
 2023 00:29:27 -0700 (PDT)
MIME-Version: 1.0
References: <20230609221136.7431-1-chris.paterson2@renesas.com>
In-Reply-To: <20230609221136.7431-1-chris.paterson2@renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 12 Jun 2023 09:29:15 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWV6nBN=W4s2c+xhKu8rwg7JtE1qX=GgO+HbiyOUsV=TA@mail.gmail.com>
Message-ID: <CAMuHMdWV6nBN=W4s2c+xhKu8rwg7JtE1qX=GgO+HbiyOUsV=TA@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: renesas: Fix txdv-skew-psec typo in RZ/G2L
 family smarc-som.dtsi files
To:     Chris Paterson <chris.paterson2@renesas.com>
Cc:     Magnus Damm <magnus.damm@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Biju Das <biju.das@bp.renesas.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Tomohiro Komagata <tomohiro.komagata.aj@renesas.com>
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

On Sat, Jun 10, 2023 at 12:11 AM Chris Paterson
<chris.paterson2@renesas.com> wrote:
> It looks like txdv-skew-psec is a typo from a copy+paste. txdv-skew-psec
> is not present in the PHY bindings nor is it in the driver.
>
> Correct to txen-skew-psec which is clearly what it was meant to be.
>
> Given that the default for txen-skew-psec is 0, and the device tree is
> only trying to set it to 0 anyway, there should not be any functional
> change from this fix.
>
> Fixes: 361b0dcbd7f9 ("arm64: dts: renesas: rzg2l-smarc-som: Enable Ethernet")
> Fixes: 6494e4f90503 ("arm64: dts: renesas: rzg2ul-smarc-som: Enable Ethernet on SMARC platform")
> Fixes: ce0c63b6a5ef ("arm64: dts: renesas: Add initial device tree for RZ/G2LC SMARC EVK")
> Cc: stable@vger.kernel.org # 6.1.y
> Reported-by: Tomohiro Komagata <tomohiro.komagata.aj@renesas.com>
> Signed-off-by: Chris Paterson <chris.paterson2@renesas.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
i.e. will queue in renesas-devel for v6.6.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
