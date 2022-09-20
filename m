Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85AF25BEEC3
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 22:52:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230133AbiITUv4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 16:51:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229799AbiITUvy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 16:51:54 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E784A52E5F
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 13:51:52 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id fv3so4410083pjb.0
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 13:51:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=5u2iMU/JGarNiptPXM/IL4AC+lCxrHJBFMcfmmfjd6w=;
        b=nWQ6NtlJjsYBiMqYEjSkMurJHKpsu+zvseu/dT/EfS8N0W9da6MaX3IZWRAGwICs/K
         7WgvNrLRBLZPeB3whHKIIIweqFkpnSS+ZIf0gxX+t3OfUdhDEcTUJWpfpxa5Lb82SghU
         Eq2huN+6wdG/Br7rnJK003/WogD+qNgTPrn7P4JbnHujfzx1XyoeS4aL0M7kBD6S24q7
         qWiJAOCsNotbQ7y4XTg/hN35ZZUjZqBBxmb2VFOw3+2YGtKnLTaS5EKn9930IgsGIDk5
         Zciey4Sz5JjCMLU2A36fiTYZSaZwcJZT6HIe7PBZZrEgx8yM6GHyKjOiJMriJxHSlqHE
         nwVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=5u2iMU/JGarNiptPXM/IL4AC+lCxrHJBFMcfmmfjd6w=;
        b=iUrEHGceKrElYL4sPfLR7DjBGUC0KZitUHTbZRIlA38+c/X1atZckocmxYFECrJdX1
         M3YVARhFVI+EsMOn9WM3aCfkfHa4K/AMf9ZmxEb0zYfAIn0opRxIHPSVPkIL3OEQIqbB
         FsatGQmLyATH7rmEaqR14W1AaB7DyzW4hseOS/UOgsA2pFyIuNMVs8Lg94UwqIwTA1jd
         fZTpYcAVenoP17PFM1HTM+ls0FMr+dsb1yEEASAR8SYLw208ij+FmeDmQZLP0MIIgVnq
         A51NBc2WlVXWFm+R1D+97aubVylB1tqGaDeKh53sRkML0azON+RDj88bm7GKsqcNChIR
         1/Eg==
X-Gm-Message-State: ACrzQf0L2UIEnCiWfgeYXYmdyoMuWeVBKYm5ibdtRl1L8V7jx7Nk5T9I
        y7+ESQ+5ptSltCrssgP1O6iXch4RgwlA7w==
X-Google-Smtp-Source: AMsMyM5kxKuk2J9L0YLqX34Q0J+fyFTNXsuTMivC71B9HmjaaTZGQHddO5UuQiOSmrfXitZsdB8DSw==
X-Received: by 2002:a17:90b:3c6:b0:202:c01b:feb4 with SMTP id go6-20020a17090b03c600b00202c01bfeb4mr5981091pjb.28.1663707112443;
        Tue, 20 Sep 2022 13:51:52 -0700 (PDT)
Received: from p14s (S0106889e681aac74.cg.shawcable.net. [68.147.0.187])
        by smtp.gmail.com with ESMTPSA id l9-20020a17090a3f0900b001efa9e83927sm304764pjc.51.2022.09.20.13.51.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Sep 2022 13:51:50 -0700 (PDT)
Date:   Tue, 20 Sep 2022 14:51:47 -0600
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Arnaud POULIQUEN <arnaud.pouliquen@foss.st.com>,
        andersson@kernel.org
Cc:     linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        Rob Herring <robh@kernel.org>, Christoph Hellwig <hch@lst.de>,
        Stefano Stabellini <stefanos@xilinx.com>,
        Bruce Ashfield <bruce.ashfield@xilinx.com>
Subject: Re: [PATCH v8 0/4] remoteproc: restructure the remoteproc VirtIO
 device
Message-ID: <20220920205147.GC1042164@p14s>
References: <20220826115232.2163130-1-arnaud.pouliquen@foss.st.com>
 <20220919223027.GG759648@p14s>
 <66e27df5-7697-446d-df7c-eb50e6d06f46@foss.st.com>
 <20220920202201.GB1042164@p14s>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220920202201.GB1042164@p14s>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 20, 2022 at 02:22:01PM -0600, Mathieu Poirier wrote:
> On Tue, Sep 20, 2022 at 03:44:18PM +0200, Arnaud POULIQUEN wrote:
> > Hi Mathieu,
> > 
> > On 9/20/22 00:30, Mathieu Poirier wrote:
> > > Hi,
> > > 
> > > On Fri, Aug 26, 2022 at 01:52:28PM +0200, Arnaud Pouliquen wrote:
> > >> 1) Update from V7 [1]:
> > >>
> > >> - rebase on rproc-next branch [2], commit 729c16326b7f ("remoteproc: imx_dsp_rproc: fix argument 2 of rproc_mem_entry_init")
> > >>   The updates take into account the integration of the
> > >>   commit 1404acbb7f68 ("remoteproc: Fix dma_mem leak after rproc_shutdown")
> > >> - add Reviewed-by: Mathieu Poirier <mathieu.poirier@linaro.org> according to reviews on V7
> > >>
> > >>
> > >> [1] https://lkml.org/lkml/2022/7/13/663
> > >> [2] https://git.kernel.org/pub/scm/linux/kernel/git/remoteproc/linux.git/log/?h=for-next
> > >>
> > >> 2) Patchset description:
> > >>
> > >> This series is a part of the work initiated a long time ago in 
> > >> the series "remoteproc: Decorelate virtio from core"[3]
> > >>
> > >> Objective of the work:
> > >> - Update the remoteproc VirtIO device creation (use platform device)
> > >> - Allow to declare remoteproc VirtIO device in DT
> > >>     - declare resources associated to a remote proc VirtIO
> > >>     - declare a list of VirtIO supported by the platform.
> > >> - Prepare the enhancement to more VirtIO devices (e.g I2C, audio, video, ...).
> > >>   For instance be able to declare a I2C device in a virtio-i2C node.
> > >> - Keep the legacy working!
> > >> - Try to improve the picture about concerns reported by Christoph Hellwing [4][5]
> > >>
> > >> [3] https://lkml.org/lkml/2020/4/16/1817
> > >> [4] https://lkml.org/lkml/2021/6/23/607
> > >> [5] https://patchwork.kernel.org/project/linux-remoteproc/patch/AOKowLclCbOCKxyiJ71WeNyuAAj2q8EUtxrXbyky5E@cp7-web-042.plabs.ch/
> > >>
> > >> In term of device tree this would result in such hierarchy (stm32mp1 example with 2 virtio RPMSG):
> > >>
> > >> 	m4_rproc: m4@10000000 {
> > >> 		compatible = "st,stm32mp1-m4";
> > >> 		reg = <0x10000000 0x40000>,
> > >> 		      <0x30000000 0x40000>,
> > >> 		      <0x38000000 0x10000>;
> > >>         memory-region = <&retram>, <&mcuram>,<&mcuram2>;
> > >>         mboxes = <&ipcc 2>, <&ipcc 3>;
> > >>         mbox-names = "shutdown", "detach";
> > >>         status = "okay";
> > >>
> > >>         #address-cells = <1>;
> > >>         #size-cells = <0>;
> > >>         
> > >>         vdev@0 {
> > >> 		compatible = "rproc-virtio";
> > >> 		reg = <0>;
> > >> 		virtio,id = <7>;  /* RPMSG */
> > >> 		memory-region = <&vdev0vring0>, <&vdev0vring1>, <&vdev0buffer>;
> > >> 		mboxes = <&ipcc 0>, <&ipcc 1>;
> > >> 		mbox-names = "vq0", "vq1";
> > >> 		status = "okay";
> > >>         };
> > >>
> > >>         vdev@1 {
> > >> 		compatible = "rproc-virtio";
> > >> 		reg = <1>;
> > >> 		virtio,id = <7>;  /*RPMSG */
> > >> 		memory-region = <&vdev1vring0>, <&vdev1vring1>, <&vdev1buffer>;
> > >> 		mboxes = <&ipcc 4>, <&ipcc 5>;
> > >> 		mbox-names = "vq0", "vq1";
> > >> 		status = "okay";
> > >>         };
> > >> };
> > > 
> > > I was in the process of applying this set when the last patch gave me a
> > > checkpatch warning about "virtio,rproc" not being documented.
> > > 
> > > I suggest to introduce a new "virtio-rproc.yaml" based on this work[1], with the
> > > above in the example sections.
> > 
> > Yes I saw the warning, but for this first series it is not possible to declare
> > the associated "rproc-virtio" device  in device tree.
> 
> I understand and agree with your position.
> 
> I am going ahead and merging this set in order for it to get some exposure in
> linux-next.  That said be on the ready to address potential problems it may
> cause.

I am getting conflicts because of the patches previously applied to rproc-next.
Please resent a series that applies to "7d7f8fe4e399" and I'll move forward with
the merge.

> 
> > So at this step it seems not make senses to create the devicetree bindings file.
> > More than that I don't know how I could justify the properties in bindings if
> > there is not driver code associated.
> > 
> > So i would be in favor of not adding the bindings in this series but to define
> > bindings in the first patch of my "step 2" series; as done on my github:
> > https://github.com/arnopo/linux/commit/9616d89a4f478cf78865a244efcde108d900f69f
> > 
> > Please let me know your preference.
> > 
> > Regards,
> > Arnaud
> > 
> > 
> > > 
> > > Thanks,
> > > Mathieu
> > > 
> > > [1]. https://elixir.bootlin.com/linux/v6.0-rc6/source/Documentation/devicetree/bindings/virtio/virtio-device.yaml
> > > 
> > > 
> > >>
> > >> I have divided the work in 4 steps to simplify the review, This series implements only
> > >> the step 1:
> > >> step 1: Redefine the remoteproc VirtIO device as a platform device
> > >>   - migrate rvdev management in remoteproc virtio.c,
> > >>   - create a remotproc virtio config ( can be disabled for platform that not use VirtIO IPC.
> > >> step 2: Add possibility to declare and probe a VirtIO sub node
> > >>   - VirtIO bindings declaration,
> > >>   - multi DT VirtIO devices support,
> > >>   - introduction of a remote proc virtio bind device mechanism ,
> > >> => https://github.com/arnopo/linux/commits/step2-virtio-in-DT
> > >> step 3: Add memory declaration in VirtIO subnode
> > >> => https://github.com/arnopo/linux/commits/step3-virtio-memories
> > >> step 4: Add mailbox declaration in VirtIO subnode
> > >> => https://github.com/arnopo/linux/commits/step4-virtio-mailboxes
> > >>
> > >> Arnaud Pouliquen (4):
> > >>   remoteproc: core: Introduce rproc_rvdev_add_device function
> > >>   remoteproc: core: Introduce rproc_add_rvdev function
> > >>   remoteproc: Move rproc_vdev management to remoteproc_virtio.c
> > >>   remoteproc: virtio: Create platform device for the remoteproc_virtio
> > >>
> > >>  drivers/remoteproc/remoteproc_core.c     | 154 +++---------------
> > >>  drivers/remoteproc/remoteproc_internal.h |  23 ++-
> > >>  drivers/remoteproc/remoteproc_virtio.c   | 189 ++++++++++++++++++++---
> > >>  include/linux/remoteproc.h               |   6 +-
> > >>  4 files changed, 210 insertions(+), 162 deletions(-)
> > >>
> > >> -- 
> > >> 2.24.3
> > >>
