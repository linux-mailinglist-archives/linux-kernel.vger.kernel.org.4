Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7F9C646B91
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Dec 2022 10:10:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230319AbiLHJKG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Dec 2022 04:10:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230043AbiLHJJl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Dec 2022 04:09:41 -0500
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33C6F115E;
        Thu,  8 Dec 2022 01:09:14 -0800 (PST)
Received: by mail-qk1-f169.google.com with SMTP id k3so389688qki.13;
        Thu, 08 Dec 2022 01:09:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GX7yoUJ5UVZ3SHZOJ/FiTU1z5/uRyGEiAnkth1oZIWc=;
        b=R32eRC3eN2Q/wcD8aDFGZpNNl001yhOpDRho97ztCblTGuFZgvJcn21SPykwg7fFwI
         Dyj2ClmsJFxY/0kn50rgGMhburszagOnwmIvHipbmD/vxoplFTKIkIz9zyIj4/iOYxaS
         vMhMMhhsIqSyx0EXFuisgBJ7KS5YFs3j8ZvMqnhbtfjKoHt7nHYKgR+zMePlsWLKJQGA
         EtGDW4lS3+7/vpg6eefFgk+uAtVGIBRsdZVE8yYw+zj6/ce4FOxRilxRT0dzytOGkS0S
         8ouk/C/08jFVbIbVFA/SQCg6rhq/mUatqRCNe8MlQjZrPhTDryO5YE3suBXF8VgXoGoj
         eZnA==
X-Gm-Message-State: ANoB5pk7kCv3sLWF/B18/goWCTWXNwBpr4aH34RdiPRqhTHsQXgFByp2
        eJYwDA1auAYHgCu/F0tdzQ0A1YpJJiRtSQ==
X-Google-Smtp-Source: AA0mqf5l+PK1CNxVV9iNxJPKT6GbAODSzpi9YxDLSJm9goYqz+8iYayk/3veYB2dHvHMItjwVnrl3A==
X-Received: by 2002:a05:620a:2190:b0:6fe:c24c:3b15 with SMTP id g16-20020a05620a219000b006fec24c3b15mr12149929qka.380.1670490553148;
        Thu, 08 Dec 2022 01:09:13 -0800 (PST)
Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com. [209.85.219.175])
        by smtp.gmail.com with ESMTPSA id s18-20020a05620a29d200b006f9ddaaf01esm19602731qkp.102.2022.12.08.01.09.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Dec 2022 01:09:12 -0800 (PST)
Received: by mail-yb1-f175.google.com with SMTP id s11so906582ybe.2;
        Thu, 08 Dec 2022 01:09:12 -0800 (PST)
X-Received: by 2002:a5b:24b:0:b0:6ca:3b11:8d76 with SMTP id
 g11-20020a5b024b000000b006ca3b118d76mr71131994ybp.202.1670490552413; Thu, 08
 Dec 2022 01:09:12 -0800 (PST)
MIME-Version: 1.0
References: <20221207162435.1001782-1-herve.codina@bootlin.com> <20221207162435.1001782-9-herve.codina@bootlin.com>
In-Reply-To: <20221207162435.1001782-9-herve.codina@bootlin.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 8 Dec 2022 10:09:01 +0100
X-Gmail-Original-Message-ID: <CAMuHMdWHVStUFx61oKWh=YiJ9wfXZaeWEnt2CSRgn3HQe3pQ6w@mail.gmail.com>
Message-ID: <CAMuHMdWHVStUFx61oKWh=YiJ9wfXZaeWEnt2CSRgn3HQe3pQ6w@mail.gmail.com>
Subject: Re: [PATCH v3 8/9] ARM: dts: r9a06g032: Add the USBF controller node
To:     Herve Codina <herve.codina@bootlin.com>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Magnus Damm <magnus.damm@gmail.com>,
        Gareth Williams <gareth.williams.jx@renesas.com>,
        linux-renesas-soc@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 7, 2022 at 5:25 PM Herve Codina <herve.codina@bootlin.com> wrote:
> Add the USBF controller available in the r9a06g032 SoC.
>
> Signed-off-by: Herve Codina <herve.codina@bootlin.com>

My
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
on v2 is still valid.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
