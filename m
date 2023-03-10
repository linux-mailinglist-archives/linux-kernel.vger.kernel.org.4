Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69D856B5496
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 23:38:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231236AbjCJWiZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 17:38:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230447AbjCJWiT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 17:38:19 -0500
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com [IPv6:2607:f8b0:4864:20::b32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C00D67726
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 14:38:16 -0800 (PST)
Received: by mail-yb1-xb32.google.com with SMTP id i6so6794401ybu.8
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 14:38:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678487896;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2Wt3Nia7B2dzyTN8m1DPD7xnZtjPkirSlGfwTlnIzeY=;
        b=OSWtxzZ09KnkwhrS5kJ+EcwMTFEfKV2BCGIakarjHWGhpKOj7AdjvyGxH69XymwRk3
         jggJbRdTa9yeX+/vx/7ddAekCfYM8rQlO6w6VPFzy+bTvQCgfufK6lAYFvL85Riotq3Y
         AcHkA9Z+1q2wxeWMI8eNW16WEYlUviSiA0723SPO1nLDFQdNkVgz5YlNri8vIqstUnfp
         zMPhsD37N5PWpqxxniB6tN0Vo42lsCIVE+tOgEUAmM6JCzPOO94NB69GSEyFsvQwOyT+
         /0/osvwBeTfxgTUtzd7c2mRg5qegCR/w5Mfx1ZdfFHp02hdNVW75q4BN2rLkuC6Lxluu
         ZtUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678487896;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2Wt3Nia7B2dzyTN8m1DPD7xnZtjPkirSlGfwTlnIzeY=;
        b=M0A87ZC0QbvLwBuGhRS7TXtI9Dk2Mo0kUJJw2getCBSkfwH4jKKZWl1b40O4UbNqFS
         iNUmW/oCmyfEjlzyPfWlSKqHGo9itnyEkDpEVv9LjlABKKuzGvaloT5jKXjr3ACf1uWA
         9XI0SuPyqMbQtSvSBiGVcbfrF7RLVLZPeb/chRlF493qsHmQy+auZ2t1PbUiXUfJblUI
         TUsO2Cheamkoa1495hnz5zF4+4ikxMoCVshvnXE6ebxkTVgDQmcl1Rm+rduIqZXh68rD
         Hpw1ImKJ7KqFeNaBOlQa13BGRBi8WV/qWyqQUg3D+sqZy/4JfQy1NyjDaqbV2vu2qnM1
         ZSXw==
X-Gm-Message-State: AO0yUKXfJFT3rknctB5ybUok3idBnXPNe72Kkb3nhPxo03YsHZRUEB9t
        JCBK1ysaNMiBI129LH5w04v5LwP0R407cEvWojuNVw==
X-Google-Smtp-Source: AK7set8bSrxAvSIXD50argaqtJjUHzV9QGoSn2jp1Uxlri6KPaaW8uMmyLxShrOaXYPe03vRQhS5cOUbddu1AAztgRQ=
X-Received: by 2002:a05:6902:4f4:b0:a06:5ef5:3a82 with SMTP id
 w20-20020a05690204f400b00a065ef53a82mr13473653ybs.5.1678487895927; Fri, 10
 Mar 2023 14:38:15 -0800 (PST)
MIME-Version: 1.0
References: <20220928122539.15116-1-pali@kernel.org>
In-Reply-To: <20220928122539.15116-1-pali@kernel.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 10 Mar 2023 23:38:04 +0100
Message-ID: <CACRpkdZgFLsq2bCVwsv=BrgmcH7sjPmQb01DE7e2KtU9sAz+eA@mail.gmail.com>
Subject: Re: [PATCH] PCI: ixp4xx: Use PCI_CONF1_ADDRESS() macro
To:     =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali@kernel.org>
Cc:     Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 28, 2022 at 2:25=E2=80=AFPM Pali Roh=C3=A1r <pali@kernel.org> w=
rote:

> Simplify pci-ixp4xx.c driver code and use new PCI_CONF1_ADDRESS() macro f=
or
> accessing PCI config space.
>
> Signed-off-by: Pali Roh=C3=A1r <pali@kernel.org>

This does not compile right off (on kernel v6.3-rc1), I had to add this:

diff --git a/drivers/pci/controller/pci-ixp4xx.c
b/drivers/pci/controller/pci-ixp4xx.c
index c83b5ae0b017..e44252db6085 100644
--- a/drivers/pci/controller/pci-ixp4xx.c
+++ b/drivers/pci/controller/pci-ixp4xx.c
@@ -26,6 +26,7 @@
 #include <linux/platform_device.h>
 #include <linux/slab.h>
 #include <linux/bits.h>
+#include "../pci.h"

 /* Register offsets */
 #define IXP4XX_PCI_NP_AD               0x00

After this it compiles, boots and mounts root on a PCI-USB-connected
rootfs, so it seems to work fine!
Tested-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
