Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F7AF6A53CC
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Feb 2023 08:43:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230225AbjB1HnH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 02:43:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbjB1HnG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 02:43:06 -0500
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD5071205C
        for <linux-kernel@vger.kernel.org>; Mon, 27 Feb 2023 23:43:04 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id i34so36071263eda.7
        for <linux-kernel@vger.kernel.org>; Mon, 27 Feb 2023 23:43:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XJlE7dXPUAXu2XirlL8x9W6bjuZ6sP4aaLIyjHL5+B0=;
        b=RgzxJwdHYlGCkxmH72XOFdzqhbV6/4X6nv9h79yiQhfYtZrsIM8Om41p7z8hSzuyn5
         i94jnP1wJH00cSxSPVX89PfoRFO5EReddfmtm46j3dqIXnsIivWyLBO7gPXiIvXEFcRX
         niXKEMiJqXN2zYvCB/6UjO9cmkQaIHSh0FN2s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XJlE7dXPUAXu2XirlL8x9W6bjuZ6sP4aaLIyjHL5+B0=;
        b=PkFxZn5v8Prpf2gefVffgh8qxUQQRmyNnZxBpHuE4ynpSphmGyeJCXqBw0RgqsJQZG
         NBwUCev2YsVcPoFGx0pxnY6XF4aIHnQIE9flLfNPOlajNskaLUqbky8q9b7c7L+pH+uB
         4PGcPmUnDafY8yE/pv7On4SWHHTULvZDSe/AgnrExPaBKb6TALdL4gyZsuEZvLk+u454
         pCdN91/1xKXEFFt8CVVdWEVAZipGqV91PpAQlpx5jdOK9+EIl8sZP7e0w4xhxitef/7M
         wN3Q3tLQhjmT49ebO3sAsf2WnYacO/qPgH259fiOvyTLx+beYa1jg52dtnAPhBzZFKkS
         0C6g==
X-Gm-Message-State: AO0yUKXlwA4P8Biwjgca+fjxKVO20juH+Yia71w3gzg7WbHbmZ/hNtzg
        vhIytIsg6LK/odbexjL1dkn8F5AnXYkoCVtsOStL7A==
X-Google-Smtp-Source: AK7set83BnvrTN5jUTjTkZcRIHkZv19J1u4OGNmI3thQ/K38rvu4jnnFtK5VkTngNb8Y3pqZGEPbs07Aqa56AdKiABY=
X-Received: by 2002:a50:cc88:0:b0:4ae:e548:1c6 with SMTP id
 q8-20020a50cc88000000b004aee54801c6mr1272515edi.6.1677570183183; Mon, 27 Feb
 2023 23:43:03 -0800 (PST)
MIME-Version: 1.0
References: <CAOf5uwns3YZMY5xhM+o0rNvtTqEDwCbua5HuSy-LBwgZq_eWYg@mail.gmail.com>
 <DB7PR04MB4010D6ABA0D10AB826F468CC90C29@DB7PR04MB4010.eurprd04.prod.outlook.com>
 <CAOf5uwmaP0x3s7W6OZaCfLmJguSMtKtJtLCgKZ2nuDZ9VgpLVg@mail.gmail.com>
 <CAOf5uwnuFBXF52Tbe7EFXcjzjbr-oOhn-fDVw=p8uZ8Y_Z7v+Q@mail.gmail.com> <DB7PR04MB401000F6F54497A17D96475190AC9@DB7PR04MB4010.eurprd04.prod.outlook.com>
In-Reply-To: <DB7PR04MB401000F6F54497A17D96475190AC9@DB7PR04MB4010.eurprd04.prod.outlook.com>
From:   Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
Date:   Tue, 28 Feb 2023 08:42:51 +0100
Message-ID: <CAOf5uwmdJw3KErMMVyr=zSUqLX1gANT7KxKOUBzYXvUY3XS2Tg@mail.gmail.com>
Subject: Re: NXP imx6ull nonalignment buffer question
To:     Bough Chen <haibo.chen@nxp.com>
Cc:     Shawn Guo <shawnguo@kernel.org>,
        Fabio Estevam <festevam@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

On Tue, Feb 28, 2023 at 8:25=E2=80=AFAM Bough Chen <haibo.chen@nxp.com> wro=
te:
>
> > -----Original Message-----
> > From: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
> > Sent: 2023=E5=B9=B42=E6=9C=8827=E6=97=A5 19:22
> > To: Bough Chen <haibo.chen@nxp.com>
> > Cc: Shawn Guo <shawnguo@kernel.org>; Fabio Estevam
> > <festevam@gmail.com>; LKML <linux-kernel@vger.kernel.org>;
> > linux-arm-kernel <linux-arm-kernel@lists.infradead.org>;
> > linux-mmc@vger.kernel.org; Ulf Hansson <ulf.hansson@linaro.org>
> > Subject: Re: NXP imx6ull nonalignment buffer question
> >
> > Hi Bough
> >
> > On Fri, Jan 13, 2023 at 8:19=E2=80=AFAM Michael Nazzareno Trimarchi
> > <michael@amarulasolutions.com> wrote:
> > >
> > > Hi
> > >
> > > On Fri, Jan 13, 2023 at 4:30 AM Bough Chen <haibo.chen@nxp.com> wrote=
:
> > > >
> > > > > -----Original Message-----
> > > > > From: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
> > > > > Sent: 2023=E5=B9=B41=E6=9C=889=E6=97=A5 21:02
> > > > > To: Bough Chen <haibo.chen@nxp.com>; Shawn Guo
> > > > > <shawnguo@kernel.org>; Fabio Estevam <festevam@gmail.com>; LKML
> > > > > <linux-kernel@vger.kernel.org>
> > > > > Cc: linux-arm-kernel <linux-arm-kernel@lists.infradead.org>;
> > > > > linux-mmc@vger.kernel.org; Ulf Hansson <ulf.hansson@linaro.org>
> > > > > Subject: NXP imx6ull nonalignment buffer question
> > > > >
> > > > > Hi Haibo
> > > > >
> > > > > Working on imx6ulz design and found that if I send a sdio packet
> > > > > using the sdio_writesb the adma driver tries to handle it with tw=
o
> > > > > dma descriptors. The first one filled with the bytes up to 3 to
> > > > > cover the misalign and then another buffer descriptor
> > > > >
> > > > >   offset =3D (SDHCI_ADMA2_ALIGN - (addr & SDHCI_ADMA2_MASK)) &
> > > > >                          SDHCI_ADMA2_MASK;
> > > > >                 if (offset) {
> > > > >                         if (data->flags & MMC_DATA_WRITE) {
> > > > >                                 buffer =3D sdhci_kmap_atomic(sg);
> > > > >                                 memcpy(align, buffer, offset);
> > > > >                                 sdhci_kunmap_atomic(buffer);
> > > > >                         }
> > > > >
> > > > >                         /* tran, valid */
> > > > >                         __sdhci_adma_write_desc(host, &desc,
> > > > > align_addr,
> > > > >                                                 offset,
> > > > > ADMA2_TRAN_VALID);
> > > > >
> > > > >                         BUG_ON(offset > 65536);
> > > > >
> > > > >                         align +=3D SDHCI_ADMA2_ALIGN;
> > > > >                         align_addr +=3D SDHCI_ADMA2_ALIGN;
> > > > >
> > > > >                         addr +=3D offset;
> > > > >                         len -=3D offset;
> > > > >                 }
> > > > >
> > > > > In 48.7.4 Data Length Setting
> > > > > For either ADMA (ADMA1 or ADMA2) transfer, the data in the data
> > > > > buffer must be word aligned, so the data length set in the descri=
ptor must
> > be a multiple of 4.
> > > > > I have noticed that this code does not work as expected.
> > > >
> > > > Hi Michael,
> > > >
> > > > My understanding is: for the sentence " the data in the data buffer=
 must be
> > word aligned", this means the start address of the data must be word al=
igned,
> > but not limit the data length.
> > > >
> > >
> > > Ok. My specific problem is that this seems not working on imx6ulz, I
> > > found the problem working on a wifi chipset, if the request gets spli=
t
> > > for no-alignment of the data in two dma descriptors, the chipset does
> > > not reply to me.
> > > Anyway, I will retest it with the upstream kernel again. I will check
> > > better and I will follow up if any more question
> > >
> >
> > I have done some tests and I need this quirk SDHCI_QUIRK_32BIT_ADMA_SIZ=
E
> > on imx6ulz cpu and I think that it applies even on imx6ull.
> > Wifi can work only if the data on the sdio are aligned or we use interr=
upt mode
> > for no-alignment data. I did not find an errata and I can not add as a =
quirk
> > without a confirmation
> >
>
> Hi Michael,
>
> If use the quirk SDHCI_QUIRK_32BIT_ADMA_SIZE, for the length no-alignment=
 data, it will
> change to use PIO mode.
>
> Here, can you give some more details about this issue? When the dma descr=
iptor contain the
> no-alignment length of data, is there any register dump on the console? O=
r meet any timeout? Or there any
> ADMA length mismatch happen?

I don't have a logic analyzer or oscilloscope but from the point of
view of the wifi, the data does not arrive or
the transaction is not complete. Anyway I will check back again on 6.2

diff --git a/drivers/net/wireless/ti/wl18xx/wl18xx.h
b/drivers/net/wireless/ti/wl18xx/wl18xx.h
index b642e0c437bb..97cd41a75762 100644
--- a/drivers/net/wireless/ti/wl18xx/wl18xx.h
+++ b/drivers/net/wireless/ti/wl18xx/wl18xx.h
@@ -32,14 +32,14 @@
 #define WL18XX_MAX_LINKS 16

 struct wl18xx_priv {
-       /* buffer for sending commands to FW */
-       u8 cmd_buf[WL18XX_CMD_MAX_SIZE];
-
        struct wl18xx_priv_conf conf;

        /* Index of last released Tx desc in FW */
        u8 last_fw_rls_idx;

+       /* buffer for sending commands to FW */
+       u8 cmd_buf[WL18XX_CMD_MAX_SIZE];
+
        /* number of keys requiring extra spare mem-blocks */
        int extra_spare_key_count;
 };

One way to try on some wifi is to move this buffer. As the code is
done this section is kmalloc and data is copied to the buffer from cmd
side.
After I retest I will send an RFC patch

Michael


>
> Besides, did you try DMA mode instead of the ADMA mode? Can DMA mode work=
 for your case?
>
> Best Regards
> Haibo Chen
>
> > Michael



--
Michael Nazzareno Trimarchi
Co-Founder & Chief Executive Officer
M. +39 347 913 2170
michael@amarulasolutions.com
__________________________________

Amarula Solutions BV
Joop Geesinkweg 125, 1114 AB, Amsterdam, NL
T. +31 (0)85 111 9172
info@amarulasolutions.com
www.amarulasolutions.com
