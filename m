Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5682613D3D
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Oct 2022 19:23:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229982AbiJaSXP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Oct 2022 14:23:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229781AbiJaSXN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Oct 2022 14:23:13 -0400
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFE48120B7;
        Mon, 31 Oct 2022 11:23:11 -0700 (PDT)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 29VIMsA5049177;
        Mon, 31 Oct 2022 13:22:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1667240574;
        bh=xoJ/VUXEd4r6VOHzjfDayb4vSbZyALZLwmCpIY5F/U8=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=RYkcPFkoat3AbA7VNFlnjyPy8x1FcKGjU/37UYMRkaaPh7vVs5t6AEnQszowuzVLP
         2fFL1a74obIn6Sv3rBvjcu2MRfW+bfb51rSjzq297WLQKZXdb9vErSa56ju83o5cJP
         ep/dfdmPdd61NJlhqDo0JhOrCqwFfMpLn7fVE+Qc=
Received: from DLEE113.ent.ti.com (dlee113.ent.ti.com [157.170.170.24])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 29VIMsvt119734
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 31 Oct 2022 13:22:54 -0500
Received: from DLEE112.ent.ti.com (157.170.170.23) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6; Mon, 31
 Oct 2022 13:22:53 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6 via
 Frontend Transport; Mon, 31 Oct 2022 13:22:53 -0500
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 29VIMq4K129219;
        Mon, 31 Oct 2022 13:22:53 -0500
Date:   Mon, 31 Oct 2022 23:52:52 +0530
From:   Prasanth Mantena <p-mantena@ti.com>
To:     Sebastian Fricke <sebastian.fricke@collabora.com>
CC:     <linux-media@vger.kernel.org>, <kernel@collabora.com>,
        <nas.chung@chipsnmedia.com>, <hverkuil@xs4all.nl>,
        <ezequiel@vanguardiasur.com.ar>, <linux-kernel@vger.kernel.org>,
        <nicolas.dufresne@collabora.com>, <p.zabel@pengutronix.de>,
        <dafna@fastmail.com>
Subject: Re: [PATCH v10 0/7] Wave5 codec driver
Message-ID: <20221031182251.lt34qthivjyxmrvq@uda0496754>
References: <20221022000506.221933-1-sebastian.fricke@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20221022000506.221933-1-sebastian.fricke@collabora.com>
User-Agent: NeoMutt/20171215
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02:04-20221022, Sebastian Fricke wrote:
> The Wave5 codec driver is a stateful encoder/decoder.
> It is found on the J721S2 SoC, JH7100 SoC, ssd202d SoC. Etc.
> But current test report is based on J721S2 SoC and pre-silicon FPGA.
> 
> The driver currently supports V4L2_PIX_FMT_HEVC, V4L2_PIX_FMT_H264.
> 
> This driver has so far been tested on J721S2 EVM board and pre-silicon
> FPGA.
> 
> Testing on J721S2 EVM board shows it working fine both decoder and
> encoder.
> The driver is successfully working with gstreamer v4l2 good-plugin
> without any modification.
> 
> # v4l2-compliance -d0
> Total for wave5-dec device /dev/video0: 44, Succeeded: 44, Failed: 0, Warnings: 0
> 
> # v4l2-compliance -d1
> Buffer ioctls:
> 		fail: ../../../v4l-utils-1.18.1/utils/v4l2-compliance/v4l2-test-buffers.cpp(610): q.reqbufs(node, 1)
> 	test VIDIOC_REQBUFS/CREATE_BUFS/QUERYBUF: FAIL
> 		fail: ../../../v4l-utils-1.18.1/utils/v4l2-compliance/v4l2-test-buffers.cpp(753): q.reqbufs(node, 2)
> 	test VIDIOC_EXPBUF: FAIL
> 	test Requests: OK (Not Supported)
> 
> Total for wave5-enc device /dev/video1: 44, Succeeded: 42, Failed: 2, Warnings: 2
> 
> changes since v9:
> 
> * Move from staging to the media directory
>   * Move coda driver to sub-directory
> 
> * Fixes:
>   * Use platform_get_irq instead of platform_get_resource to fetch the IRQ
> 
> * General cleanups:
>   * Add missing error messages to error conditions
>   * Improve messages/variable names/comments, align parameter names across the driver
>   * Use macros instead of magic numbers in multiple occassions
>   * Reduce code duplication in multiple places
>   * Fix whitespace, newline and tab alignment issues
>   * Remove unused struct fields & commented out code
>   * Convert signed integers to unsigned if signed is not necessary
>   * Convert int/unsigned int to s32/u32, when the variable is assigned to the
>     return of a register read or provided as a parameter for a register write
>     (and vice versa)
>   * Fix incorrect bitwise operators where logical operators are appropriate
>   * Multiple smaller changes
> 
> * Generalization:
>   * Add new helper file providing generalized routines for vpu-dec & vpu-enc
>   * Generalize luma & chroma table size calculation and stride calculation
> 
> * Resource cleanup and error handling:
>   * Add error handling to all calls with ignored return codes
>   * Handle DMA resource cleanup properly
>   * Fix insufficient instance cleanup while opening dec/enc
> 
> changes since v8:
> 
> * add 'wave5' to DEV_NAME
> * update to support Multi-stream
> * update to support loop test/dynamic resolution change
> * remove unnecessary memset, g_volatile, old version option
> 
> changes since v7:
> 
> * update v4l2-compliance test report
> * fix build error on linux-kernel 5.18.0-rc4
> 
> changes since v6:
> 
> * update TODO file
> * get sram info from device tree
> 
> changes since v5:
> 
> * support NV12/NV21 pixelformat for encoder and decoder
> * handle adnormal exit and EOS
> 
> changes since v4:
> 
> * refactor functions in wave5-hw and fix bug reported by Daniel Palmer
> * rename functions and variables to better names
> * change variable types such as replacing s32 with u32 and int with bool
> * as appropriate
> 
> changes since v3:
> 
> * Fixing all issues commented by Dan Carpenter
> * Change file names to have wave5- prefix
> * In wave5_vpu_probe, enable the clocks before reading registers, as
> * commented from Daniel Palmer
> * Add more to the TODO list,
> 
> changes since v2:
> 
> Main fixes includes:
> * change the yaml and dirver code to support up to 4 clks (instead of
> * one)
> * fix Kconfig format
> * remove unneeded cast,
> * change var types
> * change var names, func names
> * checkpatch fixes
> 
> changes since v1:
> 
> Fix changes due to comments from Ezequiel and Dan Carpenter. Main fixes
> inclueds:
> * move all files to one dir 'wave5'
> * replace private error codes with standard error codes
> * fix extra spaces
> * various checkpatch fixes
> * replace private 'DPRINTK' macro with standard 'dev_err/dbg ..'
> * fix error handling
> * add more possible fixes to the TODO file
>

We see issues with the patchset. The decoder output contains garbage
data randomly in the image. This is seen more for higher
resolutions(>=1080p).
The gstreamer pipeline for encoder fails with negotiation error as
stated below.

"vdec 4210000.video-codec: Invalid intra refresh mode: 0 (valid: 1-4)"


> Dafna Hirschfeld (1):
>   media: chips-media: wave5: Add the vdi layer
> 
> Nas Chung (3):
>   media: chips-media: wave5: Add vpuapi layer
>   media: chips-media: wave5: Add the v4l2 layer
>   media: chips-media: wave5: Add TODO file
> 
> Robert Beckett (2):
>   dt-bindings: media: wave5: add yaml devicetree bindings
>   media: chips-media: wave5: Add wave5 driver to maintainers file
> 
> Sebastian Fricke (1):
>   media: platform: chips-media: Move Coda to separate folder
> 
>  .../devicetree/bindings/media/wave5.yml       |   73 +
>  MAINTAINERS                                   |   11 +-
>  drivers/media/platform/chips-media/Kconfig    |   18 +-
>  drivers/media/platform/chips-media/Makefile   |    6 +-
>  .../media/platform/chips-media/coda/Kconfig   |   18 +
>  .../media/platform/chips-media/coda/Makefile  |    6 +
>  .../chips-media/{ => coda}/coda-bit.c         |    0
>  .../chips-media/{ => coda}/coda-common.c      |    0
>  .../chips-media/{ => coda}/coda-gdi.c         |    0
>  .../chips-media/{ => coda}/coda-h264.c        |    0
>  .../chips-media/{ => coda}/coda-jpeg.c        |    0
>  .../chips-media/{ => coda}/coda-mpeg2.c       |    0
>  .../chips-media/{ => coda}/coda-mpeg4.c       |    0
>  .../platform/chips-media/{ => coda}/coda.h    |    0
>  .../chips-media/{ => coda}/coda_regs.h        |    0
>  .../chips-media/{ => coda}/imx-vdoa.c         |    0
>  .../chips-media/{ => coda}/imx-vdoa.h         |    0
>  .../platform/chips-media/{ => coda}/trace.h   |    0
>  .../media/platform/chips-media/wave5/Kconfig  |   12 +
>  .../media/platform/chips-media/wave5/Makefile |   10 +
>  drivers/media/platform/chips-media/wave5/TODO |   25 +
>  .../platform/chips-media/wave5/wave5-helper.c |  175 +
>  .../platform/chips-media/wave5/wave5-helper.h |   28 +
>  .../platform/chips-media/wave5/wave5-hw.c     | 3459 +++++++++++++++++
>  .../chips-media/wave5/wave5-regdefine.h       |  654 ++++
>  .../platform/chips-media/wave5/wave5-vdi.c    |  261 ++
>  .../platform/chips-media/wave5/wave5-vdi.h    |   67 +
>  .../chips-media/wave5/wave5-vpu-dec.c         | 1399 +++++++
>  .../chips-media/wave5/wave5-vpu-enc.c         | 1454 +++++++
>  .../platform/chips-media/wave5/wave5-vpu.c    |  362 ++

io.h is needed for devm_ioremap to work.

>  .../platform/chips-media/wave5/wave5-vpu.h    |   72 +
>  .../platform/chips-media/wave5/wave5-vpuapi.c | 1115 ++++++
>  .../platform/chips-media/wave5/wave5-vpuapi.h | 1198 ++++++
>  .../chips-media/wave5/wave5-vpuconfig.h       |   90 +
>  .../chips-media/wave5/wave5-vpuerror.h        |  454 +++
>  .../media/platform/chips-media/wave5/wave5.h  |   94 +
>  36 files changed, 11040 insertions(+), 21 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/media/wave5.yml
>  create mode 100644 drivers/media/platform/chips-media/coda/Kconfig
>  create mode 100644 drivers/media/platform/chips-media/coda/Makefile
>  rename drivers/media/platform/chips-media/{ => coda}/coda-bit.c (100%)
>  rename drivers/media/platform/chips-media/{ => coda}/coda-common.c (100%)
>  rename drivers/media/platform/chips-media/{ => coda}/coda-gdi.c (100%)
>  rename drivers/media/platform/chips-media/{ => coda}/coda-h264.c (100%)
>  rename drivers/media/platform/chips-media/{ => coda}/coda-jpeg.c (100%)
>  rename drivers/media/platform/chips-media/{ => coda}/coda-mpeg2.c (100%)
>  rename drivers/media/platform/chips-media/{ => coda}/coda-mpeg4.c (100%)
>  rename drivers/media/platform/chips-media/{ => coda}/coda.h (100%)
>  rename drivers/media/platform/chips-media/{ => coda}/coda_regs.h (100%)
>  rename drivers/media/platform/chips-media/{ => coda}/imx-vdoa.c (100%)
>  rename drivers/media/platform/chips-media/{ => coda}/imx-vdoa.h (100%)
>  rename drivers/media/platform/chips-media/{ => coda}/trace.h (100%)
>  create mode 100644 drivers/media/platform/chips-media/wave5/Kconfig
>  create mode 100644 drivers/media/platform/chips-media/wave5/Makefile
>  create mode 100644 drivers/media/platform/chips-media/wave5/TODO
>  create mode 100644 drivers/media/platform/chips-media/wave5/wave5-helper.c
>  create mode 100644 drivers/media/platform/chips-media/wave5/wave5-helper.h
>  create mode 100644 drivers/media/platform/chips-media/wave5/wave5-hw.c
>  create mode 100644 drivers/media/platform/chips-media/wave5/wave5-regdefine.h
>  create mode 100644 drivers/media/platform/chips-media/wave5/wave5-vdi.c
>  create mode 100644 drivers/media/platform/chips-media/wave5/wave5-vdi.h
>  create mode 100644 drivers/media/platform/chips-media/wave5/wave5-vpu-dec.c
>  create mode 100644 drivers/media/platform/chips-media/wave5/wave5-vpu-enc.c
>  create mode 100644 drivers/media/platform/chips-media/wave5/wave5-vpu.c
>  create mode 100644 drivers/media/platform/chips-media/wave5/wave5-vpu.h
>  create mode 100644 drivers/media/platform/chips-media/wave5/wave5-vpuapi.c
>  create mode 100644 drivers/media/platform/chips-media/wave5/wave5-vpuapi.h
>  create mode 100644 drivers/media/platform/chips-media/wave5/wave5-vpuconfig.h
>  create mode 100644 drivers/media/platform/chips-media/wave5/wave5-vpuerror.h
>  create mode 100644 drivers/media/platform/chips-media/wave5/wave5.h
> 
> -- 
> 2.25.1
> 
