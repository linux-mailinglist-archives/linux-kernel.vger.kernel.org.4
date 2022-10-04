Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E0005F46DD
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Oct 2022 17:43:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229661AbiJDPnV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Oct 2022 11:43:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbiJDPnS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 11:43:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B6164E617;
        Tue,  4 Oct 2022 08:43:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A6BD4614C2;
        Tue,  4 Oct 2022 15:43:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0BB52C433C1;
        Tue,  4 Oct 2022 15:43:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664898196;
        bh=U2O60j6He/sEtxkTg/pc2RUdeKrZgNPr8GmnSXcVjpc=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=YJK0uXIA48/3+m4FpB503xW0BRolVhOp+O6En1YVcupkiHqr1fozqu9fJZjm2lNYI
         uCula0RnHqTJJRRfqsZIKQpobcYl6RrojD0uTjPSIKV7dDbWykWHrlBSZ/fJUpySp3
         t+NRLGPCjyGn9h/GlvjhXTXznXwJKuvQ9/jjQUW4CJnpd1bY8Ub+3+cPXpotwlimMC
         YKbT7GuRcdbvbmmTDnuExQjDStNoeu9r2Zv36+x9SMdtFxgTlwPRqghYvPlpyyI1rI
         kO/i/0wSj8Vx2CDz3BoKd2ah3Uciqdwiza0o8Sqmx4uWDNkwqhZiXEC0l+OMzq55bM
         f6EzyPVFrznQQ==
Received: by mail-vk1-f178.google.com with SMTP id n5so3002931vke.12;
        Tue, 04 Oct 2022 08:43:15 -0700 (PDT)
X-Gm-Message-State: ACrzQf0AI2tpm3egK7InR+4x9byNo1fAJUF2ew/iDxWjosYZ8PtEmncM
        OZjInDPyvJS9l7Xf+KfbzYweIac6DAtbE3FtEA==
X-Google-Smtp-Source: AMsMyM52y1ai9U24ODhDkBQO22dd37N5gJM6JrMe7fLZoeFCJP2r7l1LCfAUUFY6JOorsGnC8MKpSQ575X4CRjgX3Q4=
X-Received: by 2002:a1f:16c4:0:b0:3aa:58a9:5d33 with SMTP id
 187-20020a1f16c4000000b003aa58a95d33mr4834165vkw.35.1664898195002; Tue, 04
 Oct 2022 08:43:15 -0700 (PDT)
MIME-Version: 1.0
References: <20220921135044.917140-1-arnaud.pouliquen@foss.st.com>
 <20220921135044.917140-5-arnaud.pouliquen@foss.st.com> <20221004143954.GA1479221-robh@kernel.org>
 <fa229aa5-5fb7-eb18-3b8a-59d8a98ccaba@foss.st.com>
In-Reply-To: <fa229aa5-5fb7-eb18-3b8a-59d8a98ccaba@foss.st.com>
From:   Rob Herring <robh@kernel.org>
Date:   Tue, 4 Oct 2022 10:43:04 -0500
X-Gmail-Original-Message-ID: <CAL_JsqLnm7+YQAiSeCk5Db1oNcg=rwJd4Fnve4j+-ssC-dZOHQ@mail.gmail.com>
Message-ID: <CAL_JsqLnm7+YQAiSeCk5Db1oNcg=rwJd4Fnve4j+-ssC-dZOHQ@mail.gmail.com>
Subject: Re: [PATCH v9 4/4] remoteproc: virtio: Create platform device for the remoteproc_virtio
To:     Arnaud POULIQUEN <arnaud.pouliquen@foss.st.com>
Cc:     Bjorn Andersson <andersson@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        Christoph Hellwig <hch@lst.de>,
        Stefano Stabellini <stefanos@xilinx.com>,
        Bruce Ashfield <bruce.ashfield@xilinx.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 4, 2022 at 10:18 AM Arnaud POULIQUEN
<arnaud.pouliquen@foss.st.com> wrote:
>
> Hello Rob,
>
> On 10/4/22 16:39, Rob Herring wrote:
> > On Wed, Sep 21, 2022 at 03:50:44PM +0200, Arnaud Pouliquen wrote:
> >> Define a platform driver to manage the remoteproc virtio device as
> >> a platform devices.
> >>
> >> The platform device allows to pass rproc_vdev_data platform data to
> >> specify properties that are stored in the rproc_vdev structure.
> >>
> >> Such approach will allow to preserve legacy remoteproc virtio device
> >> creation but also to probe the device using device tree mechanism.
> >>
> >> remoteproc_virtio.c update:
> >>   - Add rproc_virtio_driver platform driver. The probe ops replaces
> >>     the rproc_rvdev_add_device function.
> >>   - All reference to the rvdev->dev has been updated to rvdev-pdev->dev.
> >>   - rproc_rvdev_release is removed as associated to the rvdev device.
> >>   - The use of rvdev->kref counter is replaced by get/put_device on the
> >>     remoteproc virtio platform device.
> >>   - The vdev device no longer increments rproc device counter.
> >>     increment/decrement is done in rproc_virtio_probe/rproc_virtio_remove
> >>     function in charge of the vrings allocation/free.
> >>
> >> remoteproc_core.c update:
> >>   Migrate from the rvdev device to the rvdev platform device.
> >>   From this patch, when a vdev resource is found in the resource table
> >>   the remoteproc core register a platform device.
> >>
> >> Signed-off-by: Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>
> >> Reviewed-by: Mathieu Poirier <mathieu.poirier@linaro.org>
> >> ---
> >>  drivers/remoteproc/remoteproc_core.c     |  12 +-
> >>  drivers/remoteproc/remoteproc_internal.h |   2 -
> >>  drivers/remoteproc/remoteproc_virtio.c   | 143 ++++++++++++-----------
> >>  include/linux/remoteproc.h               |   6 +-
> >>  4 files changed, 82 insertions(+), 81 deletions(-)
> >
> > [...]
> >
> >> +/* Platform driver */
> >> +static const struct of_device_id rproc_virtio_match[] = {
> >> +    { .compatible = "virtio,rproc" },
> >
> > This is not documented. Add a binding schema if you need DT support.
>
>
> Mathieu also pointed this out to me in V8, you can see the discussion here [1]
>
> Here is an extract:
> "Yes I saw the warning, but for this first series it is not possible to declare
> the associated "rproc-virtio" device in device tree.
> So at this step it seems not make senses to create the devicetree bindings file.
> More than that I don't know how I could justify the properties in bindings if
> there is not driver code associated.
>
> So i would be in favor of not adding the bindings in this series but to define
> bindings in the first patch of my "step 2" series; as done on my github:
> https://github.com/arnopo/linux/commit/9616d89a4f478cf78865a244efcde108d900f69f
> "

Okay, since I only just started checking this (in a more reliable way
than checkpatch does).

But why do you need the DT match entry if it is not usable yet? You
could just add that in later when the binding is defined. Review of
the binding could say that 'virtio,rproc' should be something else and
you'd have to change it.

Rob
