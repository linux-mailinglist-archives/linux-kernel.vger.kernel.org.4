Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09D5C6CB677
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 08:01:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230514AbjC1GBm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 02:01:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjC1GBk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 02:01:40 -0400
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 025871BF6;
        Mon, 27 Mar 2023 23:01:37 -0700 (PDT)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 32S61D6s073625;
        Tue, 28 Mar 2023 01:01:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1679983273;
        bh=zXRPR0/LMqYUvH3KPAGu22WhsJJCxSMAtgRNXt6WQDU=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=E2cVj9hwoNCFEqRRzr0HQCj10yDNrkjh0fsVMllbd5YYTnhGayZrWVYMtFuuzf0De
         LTIBDQ2tdJZZo+YG92y+ldXqaD3mdT67vDVAGW04dUO/roePBJxxhjK1V2bqCfVa2K
         +fF1TaBpE9a5sEuQf/ep4MayE+sM8ekAr4w/iHUc=
Received: from DLEE111.ent.ti.com (dlee111.ent.ti.com [157.170.170.22])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 32S61DAD110393
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 28 Mar 2023 01:01:13 -0500
Received: from DLEE108.ent.ti.com (157.170.170.38) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16; Tue, 28
 Mar 2023 01:01:13 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16 via
 Frontend Transport; Tue, 28 Mar 2023 01:01:13 -0500
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 32S61CO1129343;
        Tue, 28 Mar 2023 01:01:12 -0500
Date:   Tue, 28 Mar 2023 11:31:12 +0530
From:   Jai Luthra <j-luthra@ti.com>
To:     Martyn Welch <martyn.welch@collabora.com>
CC:     Vaishnav Achath <vaishnav.a@ti.com>, <linux-media@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <mripard@kernel.org>,
        <mchehab@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>,
        <laurent.pinchart@ideasonboard.com>,
        <sakari.ailus@linux.intel.com>, <tomi.valkeinen@ideasonboard.com>,
        <linux-kernel@vger.kernel.org>, <bparrot@ti.com>,
        <niklas.soderlund+renesas@ragnatech.se>, <devarsht@ti.com>,
        <praneeth@ti.com>, <u-kumar1@ti.com>, <vigneshr@ti.com>,
        <nm@ti.com>
Subject: Re: [PATCH v7 00/13] CSI2RX support on J721E
Message-ID: <vdjxsuaf4zoy4zzc7t2lif2jf2stdwn5ovq2eybdifnbbsknd2@cyotd7s37a3d>
References: <20230314115516.667-1-vaishnav.a@ti.com>
 <e184448c9db8df55e03e855f7c7338066f45025a.camel@collabora.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="5frzlxni7pxdkqyf"
Content-Disposition: inline
In-Reply-To: <e184448c9db8df55e03e855f7c7338066f45025a.camel@collabora.com>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--5frzlxni7pxdkqyf
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Martyn,

Thanks for the tests.

On Mar 23, 2023 at 19:36:18 +0000, Martyn Welch wrote:
> On Tue, 2023-03-14 at 17:25 +0530, Vaishnav Achath wrote:
> > Hi,
> >=20
> > This series adds support for CSI2 capture on J721E. It includes some
> > fixes to the Cadence CSI2RX driver, and adds the TI CSI2RX wrapper
> > driver.
> >=20
> > This is a V7 of the below V6 series,
> > https://lore.kernel.org/all/20220121142904.4091481-1-p.yadav@ti.com/
> >=20
> > Since Pratyush moved out of TI, I will be working on upstreaming the
> > TI CSI2RX wrapper support.
> >=20
> > Tested on TI's J721E EVM with LI OV5640 sensor module.
> > https://gist.github.com/vaishnavachath/f030a257d5b6569817bc9deab1c4fa77
> >=20
> > Also, Tested on TI AM62-SK with Pcam5C OV5640 module.
> > https://gist.github.com/vaishnavachath/ff2605faa92f1a6ab5670426da28ccee
> >=20
>=20
> Hi Vaishnav,
>=20
> I assume I'm doing something wrong. I have a TI AM62-SK and the Pcam5C
> OV5640 module. I've been trying to test this with gstreamer using the
> following command:
>=20
> gst-launch-1.0 -v v4l2src device=3D/dev/video0 num-buffers=3D10 ! video/x-
> raw, width=3D640, height=3D480, format=3DUYVY, framerate=3D30/1 ! jpegenc=
 !
> multifilesink location=3Dtest%d.jpg
>=20
> However I've not been able to get this working, failing with this
> failure unless I patch in some changes I found in the TI BSP:
>=20
> [   28.083635] cdns-mipi-dphy-rx 30110000.phy: DPHY wait for lane ready
> timeout
> [   28.090905] cdns-csi2rx 30101000.csi-bridge: Failed to configure
> external DPHY: -110

That is expected as currently the DPHY driver does not release the SW=20
reset which all SoCs since J721E SR1.0 expect. See the patch linked by=20
Vaishnav below.

>=20
> The changes (and the device tree nodes I added, which might be
> wrong...) can be found here:
>=20
> https://gitlab.collabora.com/martyn/linux/-/commits/am625-sk-ov5640
>=20
> Any ideas what I'm doing wrong?
>=20
> Martyn
>=20
> > For all newer TI platforms that TI J721E Silicon Revision 1.0, below
> > update
> > to DPHY RX driver is needed:
> > https://lore.kernel.org/all/20230314073137.2153-1-vaishnav.a@ti.com/

^

With that patch and this series on top of linux-next, I was able to get=20
Pcam5C capturing with SK-AM62. Although I did face issues with the=20
sensor framerate and had to revert a few recent sensor commits, not sure=20
why exactly yet. But here is the working branch with all the changes:=20
https://github.com/jailuthra/linux/commits/b4/csi_single

Let us know if you face any other issues during your tests.

> >=20
> > Changes in v7:
> > - For patch 10/13 ("Add CSI2RX upport for J721E"):
> > - Fix incorrect value written in SHIM_PSI_CFG0_DST_TAG
> > - Drop support for 2X8 formats.
> > - Update maintainer to Vaishnav as Pratyush moved out of TI.
> > - Address Sakari's review comments:
> > - Update MAX_HEIGHT_LINES, MAX_WIDTH_BYTES to prevent overflow.
> > - Assign dma_slave_config during declaration, drop memset().
> > - dma_release_channel() on slave_config failure.
> > - provide entity ops for the vdev entity with link_validate().
> > - mutex_destroy() on ti_csi2rx_probe failure path.
> > - Drop busy check in remove().
> > - mutex_destroy() in ti_csi2rx_remove().
> > - Address Laurent's review comments:
> > - Update entries in Makefile in alphabetical order.
> > - include headers in alphabetical order.
> > - Drop redundant CSI DT defines and use from media/mipi-csi2.h.
> > - Rename csi_df to csi_dt.
> > - Drop v4l2_colorspace from ti_csi2rx_fmt and set default in
> > =A0 ti_csi2rx_v4l2_init()
> > - Adjust field and not return EINVAL in ti_csi2rx_try_fmt_vid_cap().
> > - inline ti_csi2rx_video_register().
> > - start DMA before starting source subdev.
> > - move buffer cleanup to separate function
> > ti_csi2rx_cleanup_buffers()
> > =A0 to be used in ti_csi2rx_stop_streaming() and
> > ti_csi2rx_start_streaming()
> > =A0 failure path.
> > - Drop VB2_USERPTR, VB2_READ and V4L2_CAP_READWRITE.
> > - For patch 4/13 ("media: cadence: csi2rx: Add external DPHY
> > support"):
> > - Fix multiplier and divider in v4l2_get_link_freq() which caused
> > =A0 failures during streaming.
> >=20
> > Changes in v6:
> > - Move the lock around the dereference for framefmt in
> > =A0 csi2rx_{get,set}_fmt() instead of when we get the pointer.
> > - Do not return an error when an unsupported format is set. Instead
> > =A0 adjust the code to the first format in the list.
> > - Drop variable bpp and use fmt->bpp directly.
> > - Drop variable got_pm. Call phy_pm_runtime_put() unconditionally
> > since
> > =A0 it will just return an error if runtime PM is not enabled.
> > - Drop transcoding from the commit message.
> > - Make csi2rx_media_ops const.
> >=20
> > Changes in v5:
> > - Cleanup notifier in csi2rx_parse_dt() after the call to
> > =A0 v4l2_async_nf_add_fwnode_remote().
> > - Use YUV 1X16 formats instead of 2X8.
> > - Only error out when phy_pm_runtime_get_sync() returns a negative
> > =A0 value. A positive value can be returned if the phy was already
> > =A0 resumed.
> > - Do not query the source subdev for format. Use the newly added
> > =A0 internal format instead.
> > - Make i unsigned.
> > - Change %d to %u
> > - Add dependency on PHY_CADENCE_DPHY_RX instead of PHY_CADENCE_DPHY
> > =A0 since the Rx mode DPHY now has a separate driver.
> > - Drop ti_csi2rx_validate_pipeline(). Pipeline validation should be
> > done
> > =A0 at media_pipeline_start().
> > - Do not assign flags.
> > - Fix error handling in ti_csi2rx_start_streaming(). Free up vb2
> > buffers
> > =A0 when media_pipeline_start() fails.
> > - Move clock description in comments under the clocks property.
> > - Make ports required.
> > - Add link validation to cdns-csi2rx driver.
> >=20
> > Changes in v4:
> > - Drop the call to set PHY submode. It is now being done via
> > compatible
> > =A0 on the DPHY side.
> > - Acquire the media device's graph_mutex before starting the graph
> > walk.
> > - Call media_graph_walk_init() and media_graph_walk_cleanup() when
> > =A0 starting and ending the graph walk respectively.
> > - Reduce max frame height and width in enum_framesizes. Currently
> > they
> > =A0 are set to UINT_MAX but they must be a multiple of step_width, so
> > they
> > =A0 need to be rounded down. Also, these values are absurdly large
> > which
> > =A0 causes some userspace applications like gstreamer to trip up. While
> > it
> > =A0 is not generally right to change the kernel for an application bug,
> > it
> > =A0 is not such a big deal here. This change is replacing one set of
> > =A0 absurdly large arbitrary values with another set of smaller but
> > still
> > =A0 absurdly large arbitrary values. Both limits are unlikely to be hit
> > in
> > =A0 practice.
> > - Add power-domains property.
> > - Drop maxItems from clock-names.
> > - Drop the type for data-lanes.
> > - Drop uniqueItems from data-lanes. Move it to video-interfaces.yaml
> > =A0 instead.
> > - Drop OV5640 runtime pm patch. It seems to be a bit complicated and
> > it
> > =A0 is not exactly necessary for this series. Any CSI-2 camera will
> > work
> > =A0 just fine, OV5640 just happens to be the one I tested with. I don't
> > =A0 want it to block this series. I will submit it as a separate patch
> > =A0 later.
> >=20
> > Changes in v3:
> > - Use v4l2_get_link_freq() to calculate pixel clock.
> > - Move DMA related fields in struct ti_csi2rx_dma.
> > - Protect DMA buffer queue with a spinlock to make sure the queue
> > buffer
> > =A0 and DMA callback don't race on it.
> > - Track the current DMA state. It might go idle because of a lack of
> > =A0 buffers. This state can be used to restart it if needed.
> > - Do not include the current buffer in the pending queue. It is
> > slightly
> > =A0 better modelling than leaving it at the head of the pending queue.
> > - Use the buffer as the callback argument, and add a reference to csi
> > in it.
> > - If queueing a buffer to DMA fails, the buffer gets leaked and DMA
> > gets
> > =A0 stalled with. Instead, report the error to vb2 and queue the next
> > =A0 buffer in the pending queue.
> > - DMA gets stalled if we run out of buffers since the callback is the
> > =A0 only one that fires subsequent transfers and it is no longer being
> > =A0 called. Check for that when queueing buffers and restart DMA if
> > =A0 needed.
> > - Do not put of node until we are done using the fwnode.
> > - Set inital format to UYVY 640x480.
> > - Add compatible: contains: const: cdns,csi2rx to allow SoC specific
> > =A0 compatible.
> > - Add more constraints for data-lanes property.
> >=20
> > Changes in v2:
> > - Use phy_pm_runtime_get_sync() and phy_pm_runtime_put() before
> > making
> > =A0 calls to set PHY mode, etc. to make sure it is ready.
> > - Use dmaengine_get_dma_device() instead of directly accessing
> > =A0 dma->device->dev.
> > - Do not set dst_addr_width when configuring slave DMA.
> > - Move to a separate subdir and rename to j721e-csi2rx.c
> > - Convert compatible to ti,j721e-csi2rx.
> > - Move to use Media Controller centric APIs.
> > - Improve cleanup in probe when one of the steps fails.
> > - Add colorspace to formats database.
> > - Set hw_revision on media_device.
> > - Move video device initialization to probe time instead of register
> > time.
> > - Rename to ti,j721e-csi2rx.yaml
> > - Add an entry in MAINTAINERS.
> > - Add a description for the binding.
> > - Change compatible to ti,j721e-csi2rx to make it SoC specific.
> > - Remove description from dmas, reg, power-domains.
> > - Remove a limit of 2 from #address-cells and #size-cells.
> > - Fix add ^ to csi-bridge subnode regex.
> > - Make ranges mandatory.
> > - Add unit address in example.
> > - Add a reference to cdns,csi2rx in csi-bridge subnode.
> > - Expand the example to include the csi-bridge subnode as well.
> > - Re-order subject prefixes.
> > - Convert OV5640 to use runtime PM and drop Cadence CSI2RX s_power
> > patch.
> > - Drop subdev call wrappers from cdns-csi2rx.
> > - Move VPE and CAL to a separate subdir.
> > - Rename ti-csi2rx.c to j721e-csi2rx.c
> >=20
> > Pratyush Yadav (13):
> > =A0 media: cadence: csi2rx: Unregister v4l2 async notifier
> > =A0 media: cadence: csi2rx: Cleanup media entity properly
> > =A0 media: cadence: csi2rx: Add get_fmt and set_fmt pad ops
> > =A0 media: cadence: csi2rx: Add external DPHY support
> > =A0 media: cadence: csi2rx: Soft reset the streams before starting
> > capture
> > =A0 media: cadence: csi2rx: Set the STOP bit when stopping a stream
> > =A0 media: cadence: csi2rx: Fix stream data configuration
> > =A0 media: cadence: csi2rx: Populate subdev devnode
> > =A0 media: cadence: csi2rx: Add link validation
> > =A0 media: ti: Add CSI2RX support for J721E
> > =A0 media: dt-bindings: Make sure items in data-lanes are unique
> > =A0 media: dt-bindings: Add DT bindings for TI J721E CSI2RX driver
> > =A0 media: dt-bindings: Convert Cadence CSI2RX binding to YAML
> >=20
> > =A0.../devicetree/bindings/media/cdns,csi2rx.txt |=A0 100 --
> > =A0.../bindings/media/cdns,csi2rx.yaml=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 |=
=A0 176 +++
> > =A0.../bindings/media/ti,j721e-csi2rx.yaml=A0=A0=A0=A0=A0=A0 |=A0 101 ++
> > =A0.../bindings/media/video-interfaces.yaml=A0=A0=A0=A0=A0 |=A0=A0=A0 1=
 +
> > =A0MAINTAINERS=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 |=A0=A0=A0 7 +
> > =A0drivers/media/platform/cadence/cdns-csi2rx.c=A0 |=A0 273 ++++-
> > =A0drivers/media/platform/ti/Kconfig=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0 |=A0=A0 12 +
> > =A0drivers/media/platform/ti/Makefile=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 =
|=A0=A0=A0 1 +
> > =A0.../media/platform/ti/j721e-csi2rx/Makefile=A0=A0 |=A0=A0=A0 2 +
> > =A0.../platform/ti/j721e-csi2rx/j721e-csi2rx.c=A0=A0 | 1022
> > +++++++++++++++++
> > =A010 files changed, 1580 insertions(+), 115 deletions(-)
> > =A0delete mode 100644
> > Documentation/devicetree/bindings/media/cdns,csi2rx.txt
> > =A0create mode 100644
> > Documentation/devicetree/bindings/media/cdns,csi2rx.yaml
> > =A0create mode 100644 Documentation/devicetree/bindings/media/ti,j721e-
> > csi2rx.yaml
> > =A0create mode 100644 drivers/media/platform/ti/j721e-csi2rx/Makefile
> > =A0create mode 100644 drivers/media/platform/ti/j721e-csi2rx/j721e-
> > csi2rx.c
> >=20
>=20

Thanks,
Jai

--5frzlxni7pxdkqyf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEETeDYGOXVdejUWq/FQ96R+SSacUUFAmQigqYACgkQQ96R+SSa
cUW4IxAAv/O/HmkE7L/2vf0rgmKUplhz2cBz0GJTef5PlI/gOWtzcRknYE4/HQg8
5TqmDNy1jbfa7ER1J+1wvXrjL2rvyKXJZ6SmlqLNMCl6b8tvquFrx9rWjVfbf0Lf
Nu2VmUEDTeVePrp+7ElM7WKvKihWeXCMgHKJhUeQUZJuyKVjLEw8BZIPnFNpp652
vr2/Zhjtf7nnQloy8r1OrIILqLJFyv9G/cKr3T3iwAtIN+aTOXrKgQsyuGTqTpLx
UksHACYpFtyTMNorSSZYrAvGC04NquPRg1Zy72DGZkLIBp0AByrmkUgndh0btFqg
WYkPRzJryIwbr5y6lInN5gzdz/Sj53LoJ3dNq6lqN6+FdYL7iPZEZZtkujomkEey
Uk5LDjrwD7Gdg15LbDKYbUbC6dNn7zNxXN/QW/Y35VUtteWvsgGaWvHDSC2ox8h3
fWdt0EcPLUDnbZlzSDMTP3UryUDSSllToZKh0z+sXSwlLoTSwNHOoy6/HsaK4kI7
VxkB2gyIOFuBsDGg2647Lep97MLgG0yQtFnlKNiPBk5RrxC7WIPO4M8HDewrQ3mD
8b6nfZv9XBpi7YgO4JaFTJ98rreVYNUM2vhmHeFMoaIg75p3WwV0+wLvRHeW98x1
6unZvQ6bTCyIya0cGMssgZTUWw0LrG18iHdbn2LIIQFOOcBV4W0=
=08as
-----END PGP SIGNATURE-----

--5frzlxni7pxdkqyf--
