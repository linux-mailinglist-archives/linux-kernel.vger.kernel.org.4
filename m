Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78F4F70F582
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 13:42:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232316AbjEXLmS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 07:42:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230197AbjEXLmR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 07:42:17 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECE458F;
        Wed, 24 May 2023 04:42:15 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id d9443c01a7336-1ae54b623c2so1386285ad.3;
        Wed, 24 May 2023 04:42:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684928535; x=1687520535;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6t/BheQqzH7C1thiA7W22M56MvUugUWYCFOmf6TXyi8=;
        b=O8lF963QXa1rK3JIut29atBtSNYTj03rWg5RToTbICooU2WFfy2rBsu0vR1rNGbhFS
         YrHX6cA8XiDjYwgGBZbboMerOmFh3BcswJeqK4as7vnHd80/drVCj94BW3sUhMFdmWgu
         go+R4JDS8bXpDQAivwhpJ2rD6v4UZ6ceBorGw+yDoEKIWxBrdurX3ni1UUxADscs2PFj
         XQBseeg6jza77HVRmnWW7BrET5UDWOkPB6I9u4RdBoapY6XCzRrEEyT8nvdFA84ECPxV
         KPuS5UdAIx9ZA2cMQfu0nFKLk3FNQAdWg9KWNjWsghRmN00Bk+wt8hXmQ6eh6yXAYXbY
         i75Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684928535; x=1687520535;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6t/BheQqzH7C1thiA7W22M56MvUugUWYCFOmf6TXyi8=;
        b=T+5fOyZA/bWcsjDu9uMzNHG9XdfY1meRc3BPOzK3TOoatYF6q24+RkDnoc1Gbaarsg
         gZwjETnPvIT8wIP573C6XHhsGWiSwOu9gd4ZI4a/BHxm1L6W1wVryi/anRlh7FOfyVJD
         v47gcFpMYJx4EKPpfgYIATsyHGxoBhLLZiFAr0WCw9WeCCIs4LzbOLDS7hMrYXWp/fLa
         Atc7jrhjAf4r+V1sgW0D4c1cJhYkzMEthsXtVjk0ACKQYZMIIlu7WNiZ94KOOsmc01or
         cuEMdR83IEIUHGQC06DtEhWo2iCr1LU6bQvFk5/o3MGweygiCWcM1PXz9q9sQBJbTsp/
         ocYw==
X-Gm-Message-State: AC+VfDwoBrJtFKjvRaw1lxPY1poZG56sI8cpDXgRf3N6rJSbTizq9VGc
        rqOPFfWilS+Z8wdCcyrBOmDyqbg1jKAz4Wrk5i++9UxzEX2pVA==
X-Google-Smtp-Source: ACHHUZ4/LomLYl/ANxGiVFIZ7yz3yirbhchgDJXwFQC0wuMugNVhb5lNTnCy3udFOtbGYAc9uaHhI+B/s/6I5pWlsbU=
X-Received: by 2002:a17:902:7683:b0:1a6:82ac:f277 with SMTP id
 m3-20020a170902768300b001a682acf277mr15979064pll.14.1684928535303; Wed, 24
 May 2023 04:42:15 -0700 (PDT)
MIME-Version: 1.0
References: <20230524091948.41779-1-boerge.struempfel@gmail.com>
 <20230524091948.41779-3-boerge.struempfel@gmail.com> <8cc00e92-512a-f65e-ef4a-4ea859ee3e31@kontron.de>
In-Reply-To: <8cc00e92-512a-f65e-ef4a-4ea859ee3e31@kontron.de>
From:   =?UTF-8?B?QsO2cmdlIFN0csO8bXBmZWw=?= <boerge.struempfel@gmail.com>
Date:   Wed, 24 May 2023 13:42:04 +0200
Message-ID: <CAEktqctAZzMifTpba5cgFoAVF_r0LmG-9kNM0mM1PhA764R-ww@mail.gmail.com>
Subject: Re: [PATCH v6 2/5] spi: spi-imx: add support for SPI_MOSI_IDLE_LOW
 mode bit
To:     Frieder Schrempf <frieder.schrempf@kontron.de>
Cc:     bstruempfel@ultratronik.de, andy.shevchenko@gmail.com,
        festevam@gmail.com, amit.kumar-mahapatra@amd.com,
        broonie@kernel.org, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, gch981213@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Mi., 24. Mai 2023 um 11:47 Uhr schrieb Frieder Schrempf
<frieder.schrempf@kontron.de>:
>
> On 24.05.23 11:19, Boerge Struempfel wrote:
> > By default, the spi-imx controller pulls the mosi line high, whenever i=
t
> > is idle. This behaviour can be inverted per CS by setting the
> > corresponding DATA_CTL bit in the config register of the controller.
> >
> > Also, since the controller mode-bits have to be touched anyways, the
> > SPI_CPOL and SPI_CPHA are replaced by the combined SPI_MODE_X_MASK flag=
.
> >
> > Signed-off-by: Boerge Struempfel <boerge.struempfel@gmail.com>
>
> Thanks for working on this! We used a similar downstream patch for
> driving NeoPixels with i.MX. I'm happy to see a proper upstream solution.
>

Thanks for your reply. I'm glad to see that there is an interest for this
and I'm not the only one, who is working with this.

> I also have this Python module [1] around for using spidev to drive the
> LEDs. It would be nice to see support for SPI_MOSI_IDLE_LOW in py-spidev
> [2] so we could use it there. Though the latter looks a bit like it is
> not properly maintained anymore.

The python modules looks interesting.

FYI: there is already another patch by Chuanhong Guo on the mailing
list, which implements a proper driver for neopixel leds. It also allows
to add them via DT and access them via sys-fs. It might be an
interesting upstream alternative for your python module if it gets
accepted.

https://lore.kernel.org/lkml/20221212045558.69602-1-gch981213@gmail.com/

>
> [1] https://github.com/fschrempf/py-neopixel-spidev
> [2] https://github.com/doceme/py-spidev
>
> Reviewed-by: Frieder Schrempf <frieder.schrempf@kontron.de>

--
Kind Regards,
B=C3=B6rge Str=C3=BCmpfel
