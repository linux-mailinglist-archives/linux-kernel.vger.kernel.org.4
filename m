Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 314215BB18A
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Sep 2022 19:15:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229731AbiIPRPf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Sep 2022 13:15:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229697AbiIPRPa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Sep 2022 13:15:30 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2767C61DA5
        for <linux-kernel@vger.kernel.org>; Fri, 16 Sep 2022 10:15:28 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id y3so51003448ejc.1
        for <linux-kernel@vger.kernel.org>; Fri, 16 Sep 2022 10:15:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=UKj9UGbXYvEgM0CJerOBIFmYNI3OH+KXrWnGoYkjkbc=;
        b=JkWCKXbyMNHGdGJZpg3xwevNAHEElmCrtUwV0oTmQOerPQBVslZbRYD932oLcbhXC/
         Af/yZk6mE7xNlm/+jeLPbjRYQt0KeKUXX9A1YZgKq9FUizyvBit8uzSbWys9VPuIGTVH
         qSvCEGjTYtm0oRTWzEXh2F50X6GvfusYC/xUFpaeNk4btCeEH1YTHFHdQHr2vjKdYgGT
         9rDm3XN0Fcs/yhc2Ldeb+53NQr4bU3xGcY8rbDFh4BIkjnRhtUsEq/s2kUECcDn1MfrS
         G+tcUNsVOdhbFIgQHJdvYLGRUQWduPdColxMcPnQylVhxssGoj4v4ESu9CepZ32l/hOD
         aXUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=UKj9UGbXYvEgM0CJerOBIFmYNI3OH+KXrWnGoYkjkbc=;
        b=aWx2mvc5EW7rIttVSisCu+nQ3+YNi65TpwNu0MaClxUSQaGpwqv7iTojOqk8viEbfT
         rs6zqZ5NFuArhTXVjzF18/faOaUVPe3/D9W4j9FfOAB8I78YQitUKaArE9CkW7coBBf3
         mBxOeFqAbWW1qzOTXfjarkxYNFAHXhmerFaZ2bGIF+ZKUx+vPBbgpIDJgO80gLwFvARu
         OneTMbI1PLWr0lNm19Jr0Ah0jvZSBJd0bb7svQ/bRcOic0PgFmTh78lYuU11BfQS0XeY
         G4cXZNsF0LAW2sLtaoxd0WANQiwsMJ0N47+NfA1Cm2HO7ndn7qThRJD1oP1dc9l87sOj
         6Zvw==
X-Gm-Message-State: ACrzQf2liuuWPZXp2IF0UMO1V+/EfP+CF2UeRXUfjE/sDg3FeQVKR0c3
        5/NOEpeNL4HXkNaKjgsu6JFeYuTuvbAxAm4hhf8XDw==
X-Google-Smtp-Source: AMsMyM79jF/mQUjZkPBzBVS66n8GDckLQzu9iZ4Q2FgLNCzLYn6iwTiqqFodYM/inPq47dG72kAYJzNkRM/I3UtTlRs=
X-Received: by 2002:a17:907:1df1:b0:779:4f57:6bb2 with SMTP id
 og49-20020a1709071df100b007794f576bb2mr4327098ejc.407.1663348526555; Fri, 16
 Sep 2022 10:15:26 -0700 (PDT)
MIME-Version: 1.0
References: <20220829194247.GC2264818@p14s> <20220908111757.14633-1-tinghan.shen@mediatek.com>
 <CANLsYkx6kXk8u_ajFbnhdWTkZBLtrq_z02jryLBSVH0x--_ZFw@mail.gmail.com> <a5ecd1dd567ca58807b289f2488d933f27e087dd.camel@mediatek.com>
In-Reply-To: <a5ecd1dd567ca58807b289f2488d933f27e087dd.camel@mediatek.com>
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
Date:   Fri, 16 Sep 2022 11:15:14 -0600
Message-ID: <CANLsYkxPdWErZErgGukvsMWcaGSRDpoKEkMeukvFi=BVTdpm8A@mail.gmail.com>
Subject: Re: [PATCH v2 4/9] remoteproc: mediatek: Support probing for the 2nd
 core of dual-core SCP
To:     TingHan Shen <tinghan.shen@mediatek.com>
Cc:     Project_Global_Chrome_Upstream_Group@mediatek.com,
        bjorn.andersson@linaro.org, bleung@chromium.org,
        chrome-platform@lists.linux.dev, devicetree@vger.kernel.org,
        dnojiri@chromium.org, enric.balletbo@collabora.com,
        groeck@chromium.org, gustavoars@kernel.org, keescook@chromium.org,
        krzk+dt@kernel.org, lee.jones@linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org,
        linux-remoteproc@vger.kernel.org, matthias.bgg@gmail.com,
        pmalani@chromium.org, robh+dt@kernel.org,
        sebastian.reichel@collabora.com, weishunc@google.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 16 Sept 2022 at 06:00, TingHan Shen <tinghan.shen@mediatek.com> wrote:
>
> On Thu, 2022-09-08 at 14:58 -0600, Mathieu Poirier wrote:
> > On Thu, 8 Sept 2022 at 05:21, Tinghan Shen <tinghan.shen@mediatek.com>
> > wrote:
> >
> > > Hi Mathieu,
> > >
> > > > > The mtk_scp.c driver only supports the single core SCP and the
> > > > > 1st core of a dual-core SCP. This patch extends it for the 2nd core.
> > > > >
> > > > > MT8195 SCP is a dual-core MCU. Both cores are housed in the same
> > >
> > > subsys.
> > > >
> > > > s/subsys/subsystem
> > > >
> > > > > They have the same viewpoint of registers and memory.
> > > > >
> > > > > Core 1 of the SCP features its own set of core configuration registers,
> > > > > interrupt controller, timers, and DMAs. The rest of the peripherals
> > > > > in this subsystem are shared by core 0 and core 1.
> > > > >
> > > > > As for memory, core 1 has its own cache memory. the SCP SRAM is shared
> > > >
> > > > /the/The
> > > >
> > > > > by core 0 and core 1.
> > > > >
> > > > > Signed-off-by: Tinghan Shen <tinghan.shen@mediatek.com>
> > > > > ---
> > > > >  drivers/remoteproc/mtk_scp.c | 22 ++++++++++++++++++++--
> > > > >  1 file changed, 20 insertions(+), 2 deletions(-)
> > > > >
> > > > > diff --git a/drivers/remoteproc/mtk_scp.c
> > >
> > > b/drivers/remoteproc/mtk_scp.c
> > > > > index 3510c6d0bbc8..91b4aefde4ac 100644
> > > > > --- a/drivers/remoteproc/mtk_scp.c
> > > > > +++ b/drivers/remoteproc/mtk_scp.c
> > > > > @@ -23,6 +23,10 @@
> > > > >  #define MAX_CODE_SIZE 0x500000
> > > > >  #define SECTION_NAME_IPI_BUFFER ".ipi_buffer"
> > > > >
> > > > > +#define SCP_CORE_0 0
> > > > > +#define SCP_CORE_1 1
> > > > > +#define SCP_CORE_SINGLE 0xF
> > > > > +
> > > > >  /**
> > > > >   * scp_get() - get a reference to SCP.
> > > > >   *
> > > > > @@ -836,6 +840,7 @@ static int scp_probe(struct platform_device *pdev)
> > > > >     struct resource *res;
> > > > >     const char *fw_name = "scp.img";
> > > > >     int ret, i;
> > > > > +   u32 core_id = SCP_CORE_SINGLE;
> > > > >
> > > > >     ret = rproc_of_parse_firmware(dev, 0, &fw_name);
> > > > >     if (ret < 0 && ret != -EINVAL)
> > > > > @@ -851,8 +856,16 @@ static int scp_probe(struct platform_device *pdev)
> > > > >     scp->data = of_device_get_match_data(dev);
> > > > >     platform_set_drvdata(pdev, scp);
> > > > >
> > > > > +   ret = of_property_read_u32_index(dev->of_node,
> > >
> > > "mediatek,scp-core", 1, &core_id);
> > > > > +   if (ret == 0)
> > > > > +           dev_info(dev, "Boot SCP dual core %u\n", core_id);
> > > >
> > > > Why is the DT property "mediatek,scp-core" needed at all?  Since the
> > >
> > > compatible
> > > > "mediatek,mt8195-scp-dual" has already been defined previously in this
> > >
> > > patchset,
> > > > initialising the second core, if present, is a matter of looking at the
> > > > compatile string.
> > >
> > > This idea of identify cores by the compatible looks workable.
> > > I'll update this series at next version.
> > > Thanks!
> > >
> > > >
> > > > > +
> > > > >     res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "sram");
> > > > > -   scp->sram_base = devm_ioremap_resource(dev, res);
> > > > > +   if (core_id == SCP_CORE_1)
> > > > > +           scp->sram_base = devm_ioremap(dev, res->start,
> > >
> > > resource_size(res));
> > > > > +   else
> > > > > +           scp->sram_base = devm_ioremap_resource(dev, res);
> > > > > +
> > > >
> > > > This looks very broken...  For this to work you would need to have two DT
> > > > entries with the "mediatek,mt8195-scp-dual" compatible properly, one with
> > > > "mediatek,scp-core = <&scp_dual1 0>;" and another one with
> > >
> > > "mediatek,scp-core = <&scp_dual0 1>;".
> > > >
> > > > Which is also very broken...  Here you have a binding whose first
> > >
> > > argument is a
> > > > reference to the core sibling while the second argument is a
> > >
> > > characteristic of
> > > > the current core, which is highly confusing.
> > > >
> > > > I suggest what when you see the compatible binding
> > >
> > > "mediatek,mt8195-scp", a
> > > > single core is initialized.  If you see "mediatek,mt8195-scp-dual", both
> > >
> > > cores
> > > > are initialized as part of the _same_ probe.
> > > >
> > > > If the above analysis is not correct it means I misinterpreted your
> > > > work and if so, a serious amount of comments is needed _and_ a very
> > >
> > > detailed
> > > > example in "mtk,scp.yaml" that leaves no room for interpretation.
> > > >
> > > > I will stop reviewing this patchset until you have clarified how this
> > >
> > > works.
> > > >
> > > > Thanks,
> > > > Mathieu
> > >
> > > There's one problem of initializng the CORE1 using the same probe flow.
> > > The register space of CORE0 and CORE1 are overlapped in the device node.
> > > Both cores need to use the 'cfg' registers defined in scp yaml.
> > > The devm_ioremap_resource catches address overlapping and returns error
> > > when
> > > probing CORE1 driver.
> > >
> >
> > That is exactly why I suggest to initialise both cores within the same
> > probe() function.
> >
>
> Hi Mathieu,
>
> I'm thinking about how to initialise in the same probe() function.
> I'm wondering if this implies that using one scp driver to initialize 2 cores?
> If it is, I assume the dts descriptions for both cores should be contained in one node.
>
> When there's one node for both cores, it looks like that there is a problem of
> using dma_allocate_coherent(). Each core has its own reserved memory region.
> When there's only one device for both cores, it's not able to identify the memory region
> by the device parameter of dma_allocate_coherent().
>
> Is it acceptable to consider manually allocating core 1 device in the probe() when probing core 0?

Look at what Suman did for TI's K3 R5[1] and DSP[2] platforms.
Reviewing the bindings for both platforms will also give you a good
idea of how things work.

[1]. https://elixir.bootlin.com/linux/v6.0-rc5/source/drivers/remoteproc/ti_k3_r5_remoteproc.c#L1683
[2]. https://elixir.bootlin.com/linux/v6.0-rc5/source/drivers/remoteproc/ti_k3_dsp_remoteproc.c#L673

>
>
> Best regards,
> TingHan
>
>
>
>
>
>
>
>
