Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4D436CECA1
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 17:17:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230280AbjC2PRx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 11:17:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229909AbjC2PRw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 11:17:52 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0477B40D9;
        Wed, 29 Mar 2023 08:17:49 -0700 (PDT)
Received: from [IPv6:2a00:23c6:c311:3401:45a5:b946:dcd1:2820] (unknown [IPv6:2a00:23c6:c311:3401:45a5:b946:dcd1:2820])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: martyn)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 912096603174;
        Wed, 29 Mar 2023 16:17:47 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1680103068;
        bh=lUxaN6/cBfLC0t/5AbuRIdQgKf+oTBfey4Td+qKkUN0=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=Jnh0vW8tyXCF9MfFSULFf0rZHSJnR01+XLYDur0/CfuYyyvuRzdrhPmPz9k5ylAx5
         sUWKEIVO2oj8xeTmgNaBfCiXNmyokYM+eTqwnePgauD2D4IZ5kKIFWXumP4joOmFi7
         2PQz4iPFLr8tqGQcFAPZZ74MZjSl/lSwn3dgdOWs/Ug1tQ9k8i+b1NhCY1/00UZsS2
         4nm+NdvM7BMG9WMfP2lprbwrTOevvLDhUYycxnsfgrGEp229A6scXziQxekgSYAFdo
         U5YLb31qMAnzrUhHrW2QZfmfpBbTosMXMJxO3R7td7an398vlRtnarSZp2uNdAWEoh
         hoanaSMF0kpEw==
Message-ID: <ba19a5808b9e5c1b465e111ba698adbfb741dcc6.camel@collabora.com>
Subject: Re: [PATCH v7 00/13] CSI2RX support on J721E
From:   Martyn Welch <martyn.welch@collabora.com>
To:     Jai Luthra <j-luthra@ti.com>
Cc:     Vaishnav Achath <vaishnav.a@ti.com>, linux-media@vger.kernel.org,
        devicetree@vger.kernel.org, mripard@kernel.org, mchehab@kernel.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        laurent.pinchart@ideasonboard.com, sakari.ailus@linux.intel.com,
        tomi.valkeinen@ideasonboard.com, linux-kernel@vger.kernel.org,
        bparrot@ti.com, niklas.soderlund+renesas@ragnatech.se,
        devarsht@ti.com, praneeth@ti.com, u-kumar1@ti.com, vigneshr@ti.com,
        nm@ti.com
Date:   Wed, 29 Mar 2023 16:17:45 +0100
In-Reply-To: <vdjxsuaf4zoy4zzc7t2lif2jf2stdwn5ovq2eybdifnbbsknd2@cyotd7s37a3d>
References: <20230314115516.667-1-vaishnav.a@ti.com>
         <e184448c9db8df55e03e855f7c7338066f45025a.camel@collabora.com>
         <vdjxsuaf4zoy4zzc7t2lif2jf2stdwn5ovq2eybdifnbbsknd2@cyotd7s37a3d>
Organization: Collabora Ltd.
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-1 
MIME-Version: 1.0
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2023-03-28 at 11:31 +0530, Jai Luthra wrote:
> Hi Martyn,
>=20
> Thanks for the tests.
>=20
> On Mar 23, 2023 at 19:36:18 +0000, Martyn Welch wrote:
> > On Tue, 2023-03-14 at 17:25 +0530, Vaishnav Achath wrote:
> > > Hi,
> > >=20
> > > This series adds support for CSI2 capture on J721E. It includes
> > > some
> > > fixes to the Cadence CSI2RX driver, and adds the TI CSI2RX
> > > wrapper
> > > driver.
> > >=20
> > > This is a V7 of the below V6 series,
> > > https://lore.kernel.org/all/20220121142904.4091481-1-p.yadav@ti.com/
> > >=20
> > > Since Pratyush moved out of TI, I will be working on upstreaming
> > > the
> > > TI CSI2RX wrapper support.
> > >=20
> > > Tested on TI's J721E EVM with LI OV5640 sensor module.
> > > https://gist.github.com/vaishnavachath/f030a257d5b6569817bc9deab1c4fa=
77
> > >=20
> > > Also, Tested on TI AM62-SK with Pcam5C OV5640 module.
> > > https://gist.github.com/vaishnavachath/ff2605faa92f1a6ab5670426da28cc=
ee
> > >=20
> >=20
> > Hi Vaishnav,
> >=20
> > I assume I'm doing something wrong. I have a TI AM62-SK and the
> > Pcam5C
> > OV5640 module. I've been trying to test this with gstreamer using
> > the
> > following command:
> >=20
> > gst-launch-1.0 -v v4l2src device=3D/dev/video0 num-buffers=3D10 !
> > video/x-
> > raw, width=3D640, height=3D480, format=3DUYVY, framerate=3D30/1 ! jpege=
nc !
> > multifilesink location=3Dtest%d.jpg
> >=20
> > However I've not been able to get this working, failing with this
> > failure unless I patch in some changes I found in the TI BSP:
> >=20
> > [=C2=A0=C2=A0 28.083635] cdns-mipi-dphy-rx 30110000.phy: DPHY wait for =
lane
> > ready
> > timeout
> > [=C2=A0=C2=A0 28.090905] cdns-csi2rx 30101000.csi-bridge: Failed to con=
figure
> > external DPHY: -110
>=20
> That is expected as currently the DPHY driver does not release the SW
> reset which all SoCs since J721E SR1.0 expect. See the patch linked
> by=20
> Vaishnav below.
>=20

Ah! Sorry - somehow missed that...

Yep, with those changes it's working for me, thanks!

Tested-by: Martyn Welch <martyn.welch@collabora.com>

> >=20
> > The changes (and the device tree nodes I added, which might be
> > wrong...) can be found here:
> >=20
> > https://gitlab.collabora.com/martyn/linux/-/commits/am625-sk-ov5640
> >=20
> > Any ideas what I'm doing wrong?
> >=20
> > Martyn
> >=20
> > > For all newer TI platforms that TI J721E Silicon Revision 1.0,
> > > below
> > > update
> > > to DPHY RX driver is needed:
> > > https://lore.kernel.org/all/20230314073137.2153-1-vaishnav.a@ti.com/
>=20
> ^
>=20
> With that patch and this series on top of linux-next, I was able to
> get=20
> Pcam5C capturing with SK-AM62. Although I did face issues with the=20
> sensor framerate and had to revert a few recent sensor commits, not
> sure=20
> why exactly yet. But here is the working branch with all the changes:
> https://github.com/jailuthra/linux/commits/b4/csi_single
>=20
> Let us know if you face any other issues during your tests.
>=20
> > >=20
> > > Changes in v7:
> > > - For patch 10/13 ("Add CSI2RX upport for J721E"):
> > > - Fix incorrect value written in SHIM_PSI_CFG0_DST_TAG
> > > - Drop support for 2X8 formats.
> > > - Update maintainer to Vaishnav as Pratyush moved out of TI.
> > > - Address Sakari's review comments:
> > > - Update MAX_HEIGHT_LINES, MAX_WIDTH_BYTES to prevent overflow.
> > > - Assign dma_slave_config during declaration, drop memset().
> > > - dma_release_channel() on slave_config failure.
> > > - provide entity ops for the vdev entity with link_validate().
> > > - mutex_destroy() on ti_csi2rx_probe failure path.
> > > - Drop busy check in remove().
> > > - mutex_destroy() in ti_csi2rx_remove().
> > > - Address Laurent's review comments:
> > > - Update entries in Makefile in alphabetical order.
> > > - include headers in alphabetical order.
> > > - Drop redundant CSI DT defines and use from media/mipi-csi2.h.
> > > - Rename csi_df to csi_dt.
> > > - Drop v4l2_colorspace from ti_csi2rx_fmt and set default in
> > > =C2=A0 ti_csi2rx_v4l2_init()
> > > - Adjust field and not return EINVAL in
> > > ti_csi2rx_try_fmt_vid_cap().
> > > - inline ti_csi2rx_video_register().
> > > - start DMA before starting source subdev.
> > > - move buffer cleanup to separate function
> > > ti_csi2rx_cleanup_buffers()
> > > =C2=A0 to be used in ti_csi2rx_stop_streaming() and
> > > ti_csi2rx_start_streaming()
> > > =C2=A0 failure path.
> > > - Drop VB2_USERPTR, VB2_READ and V4L2_CAP_READWRITE.
> > > - For patch 4/13 ("media: cadence: csi2rx: Add external DPHY
> > > support"):
> > > - Fix multiplier and divider in v4l2_get_link_freq() which caused
> > > =C2=A0 failures during streaming.
> > >=20
> > > Changes in v6:
> > > - Move the lock around the dereference for framefmt in
> > > =C2=A0 csi2rx_{get,set}_fmt() instead of when we get the pointer.
> > > - Do not return an error when an unsupported format is set.
> > > Instead
> > > =C2=A0 adjust the code to the first format in the list.
> > > - Drop variable bpp and use fmt->bpp directly.
> > > - Drop variable got_pm. Call phy_pm_runtime_put() unconditionally
> > > since
> > > =C2=A0 it will just return an error if runtime PM is not enabled.
> > > - Drop transcoding from the commit message.
> > > - Make csi2rx_media_ops const.
> > >=20
> > > Changes in v5:
> > > - Cleanup notifier in csi2rx_parse_dt() after the call to
> > > =C2=A0 v4l2_async_nf_add_fwnode_remote().
> > > - Use YUV 1X16 formats instead of 2X8.
> > > - Only error out when phy_pm_runtime_get_sync() returns a
> > > negative
> > > =C2=A0 value. A positive value can be returned if the phy was already
> > > =C2=A0 resumed.
> > > - Do not query the source subdev for format. Use the newly added
> > > =C2=A0 internal format instead.
> > > - Make i unsigned.
> > > - Change %d to %u
> > > - Add dependency on PHY_CADENCE_DPHY_RX instead of
> > > PHY_CADENCE_DPHY
> > > =C2=A0 since the Rx mode DPHY now has a separate driver.
> > > - Drop ti_csi2rx_validate_pipeline(). Pipeline validation should
> > > be
> > > done
> > > =C2=A0 at media_pipeline_start().
> > > - Do not assign flags.
> > > - Fix error handling in ti_csi2rx_start_streaming(). Free up vb2
> > > buffers
> > > =C2=A0 when media_pipeline_start() fails.
> > > - Move clock description in comments under the clocks property.
> > > - Make ports required.
> > > - Add link validation to cdns-csi2rx driver.
> > >=20
> > > Changes in v4:
> > > - Drop the call to set PHY submode. It is now being done via
> > > compatible
> > > =C2=A0 on the DPHY side.
> > > - Acquire the media device's graph_mutex before starting the
> > > graph
> > > walk.
> > > - Call media_graph_walk_init() and media_graph_walk_cleanup()
> > > when
> > > =C2=A0 starting and ending the graph walk respectively.
> > > - Reduce max frame height and width in enum_framesizes. Currently
> > > they
> > > =C2=A0 are set to UINT_MAX but they must be a multiple of step_width,
> > > so
> > > they
> > > =C2=A0 need to be rounded down. Also, these values are absurdly large
> > > which
> > > =C2=A0 causes some userspace applications like gstreamer to trip up.
> > > While
> > > it
> > > =C2=A0 is not generally right to change the kernel for an application
> > > bug,
> > > it
> > > =C2=A0 is not such a big deal here. This change is replacing one set
> > > of
> > > =C2=A0 absurdly large arbitrary values with another set of smaller bu=
t
> > > still
> > > =C2=A0 absurdly large arbitrary values. Both limits are unlikely to b=
e
> > > hit
> > > in
> > > =C2=A0 practice.
> > > - Add power-domains property.
> > > - Drop maxItems from clock-names.
> > > - Drop the type for data-lanes.
> > > - Drop uniqueItems from data-lanes. Move it to video-
> > > interfaces.yaml
> > > =C2=A0 instead.
> > > - Drop OV5640 runtime pm patch. It seems to be a bit complicated
> > > and
> > > it
> > > =C2=A0 is not exactly necessary for this series. Any CSI-2 camera wil=
l
> > > work
> > > =C2=A0 just fine, OV5640 just happens to be the one I tested with. I
> > > don't
> > > =C2=A0 want it to block this series. I will submit it as a separate
> > > patch
> > > =C2=A0 later.
> > >=20
> > > Changes in v3:
> > > - Use v4l2_get_link_freq() to calculate pixel clock.
> > > - Move DMA related fields in struct ti_csi2rx_dma.
> > > - Protect DMA buffer queue with a spinlock to make sure the queue
> > > buffer
> > > =C2=A0 and DMA callback don't race on it.
> > > - Track the current DMA state. It might go idle because of a lack
> > > of
> > > =C2=A0 buffers. This state can be used to restart it if needed.
> > > - Do not include the current buffer in the pending queue. It is
> > > slightly
> > > =C2=A0 better modelling than leaving it at the head of the pending
> > > queue.
> > > - Use the buffer as the callback argument, and add a reference to
> > > csi
> > > in it.
> > > - If queueing a buffer to DMA fails, the buffer gets leaked and
> > > DMA
> > > gets
> > > =C2=A0 stalled with. Instead, report the error to vb2 and queue the
> > > next
> > > =C2=A0 buffer in the pending queue.
> > > - DMA gets stalled if we run out of buffers since the callback is
> > > the
> > > =C2=A0 only one that fires subsequent transfers and it is no longer
> > > being
> > > =C2=A0 called. Check for that when queueing buffers and restart DMA i=
f
> > > =C2=A0 needed.
> > > - Do not put of node until we are done using the fwnode.
> > > - Set inital format to UYVY 640x480.
> > > - Add compatible: contains: const: cdns,csi2rx to allow SoC
> > > specific
> > > =C2=A0 compatible.
> > > - Add more constraints for data-lanes property.
> > >=20
> > > Changes in v2:
> > > - Use phy_pm_runtime_get_sync() and phy_pm_runtime_put() before
> > > making
> > > =C2=A0 calls to set PHY mode, etc. to make sure it is ready.
> > > - Use dmaengine_get_dma_device() instead of directly accessing
> > > =C2=A0 dma->device->dev.
> > > - Do not set dst_addr_width when configuring slave DMA.
> > > - Move to a separate subdir and rename to j721e-csi2rx.c
> > > - Convert compatible to ti,j721e-csi2rx.
> > > - Move to use Media Controller centric APIs.
> > > - Improve cleanup in probe when one of the steps fails.
> > > - Add colorspace to formats database.
> > > - Set hw_revision on media_device.
> > > - Move video device initialization to probe time instead of
> > > register
> > > time.
> > > - Rename to ti,j721e-csi2rx.yaml
> > > - Add an entry in MAINTAINERS.
> > > - Add a description for the binding.
> > > - Change compatible to ti,j721e-csi2rx to make it SoC specific.
> > > - Remove description from dmas, reg, power-domains.
> > > - Remove a limit of 2 from #address-cells and #size-cells.
> > > - Fix add ^ to csi-bridge subnode regex.
> > > - Make ranges mandatory.
> > > - Add unit address in example.
> > > - Add a reference to cdns,csi2rx in csi-bridge subnode.
> > > - Expand the example to include the csi-bridge subnode as well.
> > > - Re-order subject prefixes.
> > > - Convert OV5640 to use runtime PM and drop Cadence CSI2RX
> > > s_power
> > > patch.
> > > - Drop subdev call wrappers from cdns-csi2rx.
> > > - Move VPE and CAL to a separate subdir.
> > > - Rename ti-csi2rx.c to j721e-csi2rx.c
> > >=20
> > > Pratyush Yadav (13):
> > > =C2=A0 media: cadence: csi2rx: Unregister v4l2 async notifier
> > > =C2=A0 media: cadence: csi2rx: Cleanup media entity properly
> > > =C2=A0 media: cadence: csi2rx: Add get_fmt and set_fmt pad ops
> > > =C2=A0 media: cadence: csi2rx: Add external DPHY support
> > > =C2=A0 media: cadence: csi2rx: Soft reset the streams before starting
> > > capture
> > > =C2=A0 media: cadence: csi2rx: Set the STOP bit when stopping a strea=
m
> > > =C2=A0 media: cadence: csi2rx: Fix stream data configuration
> > > =C2=A0 media: cadence: csi2rx: Populate subdev devnode
> > > =C2=A0 media: cadence: csi2rx: Add link validation
> > > =C2=A0 media: ti: Add CSI2RX support for J721E
> > > =C2=A0 media: dt-bindings: Make sure items in data-lanes are unique
> > > =C2=A0 media: dt-bindings: Add DT bindings for TI J721E CSI2RX driver
> > > =C2=A0 media: dt-bindings: Convert Cadence CSI2RX binding to YAML
> > >=20
> > > =C2=A0.../devicetree/bindings/media/cdns,csi2rx.txt |=C2=A0 100 --
> > > =C2=A0.../bindings/media/cdns,csi2rx.yaml=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 176 +++
> > > =C2=A0.../bindings/media/ti,j721e-csi2rx.yaml=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 |=C2=A0 101 ++
> > > =C2=A0.../bindings/media/video-interfaces.yaml=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 |=C2=A0=C2=A0=C2=A0 1 +
> > > =C2=A0MAINTAINERS=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 |=C2=A0=C2=A0=C2=A0 7 +
> > > =C2=A0drivers/media/platform/cadence/cdns-csi2rx.c=C2=A0 |=C2=A0 273 =
++++-
> > > =C2=A0drivers/media/platform/ti/Kconfig=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 12 +
> > > =C2=A0drivers/media/platform/ti/Makefile=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0 1 +
> > > =C2=A0.../media/platform/ti/j721e-csi2rx/Makefile=C2=A0=C2=A0 |=C2=A0=
=C2=A0=C2=A0 2 +
> > > =C2=A0.../platform/ti/j721e-csi2rx/j721e-csi2rx.c=C2=A0=C2=A0 | 1022
> > > +++++++++++++++++
> > > =C2=A010 files changed, 1580 insertions(+), 115 deletions(-)
> > > =C2=A0delete mode 100644
> > > Documentation/devicetree/bindings/media/cdns,csi2rx.txt
> > > =C2=A0create mode 100644
> > > Documentation/devicetree/bindings/media/cdns,csi2rx.yaml
> > > =C2=A0create mode 100644
> > > Documentation/devicetree/bindings/media/ti,j721e-
> > > csi2rx.yaml
> > > =C2=A0create mode 100644 drivers/media/platform/ti/j721e-
> > > csi2rx/Makefile
> > > =C2=A0create mode 100644 drivers/media/platform/ti/j721e-csi2rx/j721e=
-
> > > csi2rx.c
> > >=20
> >=20
>=20
> Thanks,
> Jai

