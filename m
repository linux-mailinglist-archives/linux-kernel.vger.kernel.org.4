Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 827456CB798
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 09:04:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230167AbjC1HEK convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 28 Mar 2023 03:04:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229631AbjC1HEI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 03:04:08 -0400
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 394B72727;
        Tue, 28 Mar 2023 00:04:06 -0700 (PDT)
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-5419d4c340aso212976547b3.11;
        Tue, 28 Mar 2023 00:04:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679987045;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tA2OPQVoM5D+veoK9RHz+5AIxyPDfPnVDqXxfUa0A94=;
        b=z/ZTeNrk97xCPzsUhR6Au/aog9nOeSRikMfOEJON3PsopzgZFR0odGQAH8vw3yvBJQ
         BuKW/OqYSijIAcCSadonu4WPG7wGF++cYckLa35pOIxB0PlBdPOngHAH6UTMcd2EslZo
         al3iaLyTX/pjYAM+QFKokDg/dVCl2d8rEHUPqn5la2vzaWNYisvvHxc5zaLT+GpvGuYs
         b5TMYwIHa2B41iHl4D9W31JNs0mQ/y2McPk4nAsMNWI06mJR4EgmR82Fnm16ED8C5ueH
         VU5qFx0Ej3/GxpotMXccCGdo6Tau/KZif6tmA28StGL3plldsThUoclYvF+ERJe3njWQ
         6HFQ==
X-Gm-Message-State: AAQBX9f5V2tQsIJYa1DM1bvClm4bPLPbafWh3FelZ4a50vHGDm9/1Hpk
        qNrHTjLSR860K0h5PFICN99XDBga/dF9Sw==
X-Google-Smtp-Source: AKy350aQmDMwSUUdZOz+HQVWtRo3jfUrMEZrJDcu721q5UVaJBcn8fx5ISI6JIimrODnc5Id0DI6dA==
X-Received: by 2002:a81:6803:0:b0:541:8ae4:e63e with SMTP id d3-20020a816803000000b005418ae4e63emr13614556ywc.16.1679987044878;
        Tue, 28 Mar 2023 00:04:04 -0700 (PDT)
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com. [209.85.128.182])
        by smtp.gmail.com with ESMTPSA id p184-20020a81b1c1000000b00545a08184bbsm2283332ywh.75.2023.03.28.00.04.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Mar 2023 00:04:04 -0700 (PDT)
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-5445009c26bso213170667b3.8;
        Tue, 28 Mar 2023 00:04:04 -0700 (PDT)
X-Received: by 2002:a81:b65f:0:b0:545:611c:8d19 with SMTP id
 h31-20020a81b65f000000b00545611c8d19mr6783358ywk.4.1679987044227; Tue, 28 Mar
 2023 00:04:04 -0700 (PDT)
MIME-Version: 1.0
References: <20230328033902.830269-1-nikita.yoush@cogentembedded.com>
In-Reply-To: <20230328033902.830269-1-nikita.yoush@cogentembedded.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 28 Mar 2023 09:03:52 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWOvycJEAOCGwzbgWAKbmEQ8JRKmG_cpSvwKvy6ThMkTw@mail.gmail.com>
Message-ID: <CAMuHMdWOvycJEAOCGwzbgWAKbmEQ8JRKmG_cpSvwKvy6ThMkTw@mail.gmail.com>
Subject: Re: [PATCH] clk: renesas: r8a77980: Add i2c5 clock
To:     Nikita Yushchenko <nikita.yoush@cogentembedded.com>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        linux-renesas-soc@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=0.5 required=5.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
        FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 28, 2023 at 5:39 AM Nikita Yushchenko
<nikita.yoush@cogentembedded.com> wrote:
> The MSSR clock definition for i2c5 was missing. Add it.
>
> Signed-off-by: Nikita Yushchenko <nikita.yoush@cogentembedded.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
i.e. will queue in renesas-clk-for-v6.4.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
