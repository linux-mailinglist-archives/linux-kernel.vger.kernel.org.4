Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C6FD62B6C2
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 10:41:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238371AbiKPJlP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 04:41:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238779AbiKPJky (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 04:40:54 -0500
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 434E729CB9;
        Wed, 16 Nov 2022 01:40:53 -0800 (PST)
Received: by mail-pj1-x1032.google.com with SMTP id l6so16073475pjj.0;
        Wed, 16 Nov 2022 01:40:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=QBFvWuffqEuGiRvVaB/TgEwOz03VeaJHDGNeFo3hr5k=;
        b=ZTXEdHW5xMstAnEXubm5xp1Mgoi9iOTT6GlgX/DpZ5sxfBJ9esmRDrEys6eA8/Tn/W
         QcpWJ+cGE0t0AQihlL7iCkppEKqWVFyd0VaShXvJeoPLSfNmA7a13rIrKNZSA8+wbR5M
         3FERuA2Oy6rekCx6eluEnH+FBHIffcaIfAVlzjjPejEKW8jhfBgdxdQ2BL++2tuSFnFm
         ZlxAvGxTlLtGUIlhWmjr+xpGmEUVhVO89sfjQ6Mg8N981KaXrictBUz4zGhUTn5rd7lK
         dNaZc4GUC43zXS0ZccGu8vxV57xafR9varLShGGfaoF2sNlph3TDp7UJ1ZqXtFRHtXMh
         I4dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QBFvWuffqEuGiRvVaB/TgEwOz03VeaJHDGNeFo3hr5k=;
        b=gdPJNQcp2fe3P09vvT1xbvvMXrPiTouU/lmjqi3WFia6Ja5C6bvVlcRbRj6zfHPt4h
         8/52IqlSJQ8UMxHxOpfcIVhUTI/4NQ/TXqcOMieNb6UXqAedY4E9m9ksEGlZDoz/OJrB
         Jom2FoGDbd8yVIYKnmF0t/aabSiP/pDCQvM7bEUjVhB0Y+J0U45zyb/pjdpTOljFKbBB
         g6Z7yBEl4gjXM94mXFdR04cRouXp7Ixmt5za34+joY+bYWG1vFd9wq6r3bmZVTsA9Ex9
         ixEgT6Zqk+IpFoDdoSX3olwZeGRUTeeeC6ANfTMelgrkZ2yEaqtp6bdpeICKkSPhzjaH
         BP+A==
X-Gm-Message-State: ANoB5pl43UvDyld6kX+CWVUJbpj3A/7MdwRmIC0VjvNcE0WXPT5oCA9Y
        PKdihmjmwRHRwbHlbV+j//4=
X-Google-Smtp-Source: AA0mqf7Blk9HvZLjYuDW96yBveU2tzyI0IYy5b2uXSBPRX6nQHQ5/aQB9Sa9YQ8tBwVNOCU4U9UT5w==
X-Received: by 2002:a17:90a:5793:b0:212:c384:d386 with SMTP id g19-20020a17090a579300b00212c384d386mr2877140pji.79.1668591652668;
        Wed, 16 Nov 2022 01:40:52 -0800 (PST)
Received: from debian.me (subs02-180-214-232-81.three.co.id. [180.214.232.81])
        by smtp.gmail.com with ESMTPSA id f18-20020aa79d92000000b0056e5bce5b7asm10294650pfq.201.2022.11.16.01.40.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Nov 2022 01:40:52 -0800 (PST)
Received: by debian.me (Postfix, from userid 1000)
        id 2907F10417B; Wed, 16 Nov 2022 16:40:48 +0700 (WIB)
Date:   Wed, 16 Nov 2022 16:40:48 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Jiucheng Xu <jiucheng.xu@amlogic.com>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        Jonathan Corbet <corbet@lwn.net>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Shuai Xue <xueshuai@linux.alibaba.com>,
        John Garry <john.garry@huawei.com>,
        Wan Jiabing <wanjiabing@vivo.com>,
        Chris Healy <cphealy@gmail.com>,
        Jianxin Pan <jianxin.pan@amlogic.com>,
        Kelvin Zhang <kelvin.zhang@amlogic.com>,
        Chris Healy <healych@amazon.com>
Subject: Re: [PATCH v10 2/2] docs/perf: Add documentation for the Amlogic G12
 DDR PMU
Message-ID: <Y3SwIPnDvEOlL+Mz@debian.me>
References: <20221116003133.1049346-1-jiucheng.xu@amlogic.com>
 <20221116003133.1049346-2-jiucheng.xu@amlogic.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="SOugpbm6WXLm6VXW"
Content-Disposition: inline
In-Reply-To: <20221116003133.1049346-2-jiucheng.xu@amlogic.com>
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--SOugpbm6WXLm6VXW
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 16, 2022 at 08:31:33AM +0800, Jiucheng Xu wrote:
> diff --git a/Documentation/admin-guide/perf/meson-ddr-pmu.rst b/Documenta=
tion/admin-guide/perf/meson-ddr-pmu.rst
> new file mode 100644
> index 000000000000..15e93a751ced
> --- /dev/null
> +++ b/Documentation/admin-guide/perf/meson-ddr-pmu.rst
> @@ -0,0 +1,70 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +Amlogic SoC DDR Bandwidth Performance Monitoring Unit (PMU)
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +There is a bandwidth monitor inside the DRAM controller. The monitor inc=
ludes
> +4 channels which can count the read/write request of accessing DRAM indi=
vidually.
> +It can be helpful to show if the performance bottleneck is on DDR bandwi=
dth.
> +
> +Currently, this driver supports the following 5 Perf events:
> +
> ++ meson_ddr_bw/total_rw_bytes/
> ++ meson_ddr_bw/chan_1_rw_bytes/
> ++ meson_ddr_bw/chan_2_rw_bytes/
> ++ meson_ddr_bw/chan_3_rw_bytes/
> ++ meson_ddr_bw/chan_4_rw_bytes/
> +
> +meson_ddr_bw/chan_{1,2,3,4}_rw_bytes/ events are the channel related eve=
nts.
> +Each channel support using keywords as filter, which can let the channel
> +to monitor the individual IP module in SoC.
> +
> +The following keywords are the filter:
> +
> ++ arm             - DDR access request from CPU
> ++ vpu_read1       - DDR access request from OSD + VPP read
> ++ gpu             - DDR access request from 3D GPU
> ++ pcie            - DDR access request from PCIe controller
> ++ hdcp            - DDR access request from HDCP controller
> ++ hevc_front      - DDR access request from HEVC codec front end
> ++ usb3_0          - DDR access request from USB3.0 controller
> ++ hevc_back       - DDR access request from HEVC codec back end
> ++ h265enc         - DDR access request from HEVC encoder
> ++ vpu_read2       - DDR access request from DI read
> ++ vpu_write1      - DDR access request from VDIN write
> ++ vpu_write2      - DDR access request from di write
> ++ vdec            - DDR access request from legacy codec video decoder
> ++ hcodec          - DDR access request from H264 encoder
> ++ ge2d            - DDR access request from ge2d
> ++ spicc1          - DDR access request from SPI controller 1
> ++ usb0            - DDR access request from USB2.0 controller 0
> ++ dma             - DDR access request from system DMA controller 1
> ++ arb0            - DDR access request from arb0
> ++ sd_emmc_b       - DDR access request from SD eMMC b controller
> ++ usb1            - DDR access request from USB2.0 controller 1
> ++ audio           - DDR access request from Audio module
> ++ sd_emmc_c       - DDR access request from SD eMMC c controller
> ++ spicc2          - DDR access request from SPI controller 2
> ++ ethernet        - DDR access request from Ethernet controller
> +
> +
> +The following command is to show the total DDR bandwidth:
> +
> +  .. code-block:: bash
> +
> +      perf stat -a -e meson_ddr_bw/total_rw_bytes/ -I 1000 sleep 10
> +
> +This command will print the total DDR bandwidth per second.
> +
> +The following commands are to show how to use filter parameters:
> +
> +  .. code-block:: bash
> +
> +      perf stat -a -e meson_ddr_bw/chan_1_rw_bytes,arm=3D1/ -I 1000 slee=
p 10
> +      perf stat -a -e meson_ddr_bw/chan_2_rw_bytes,gpu=3D1/ -I 1000 slee=
p 10
> +      perf stat -a -e meson_ddr_bw/chan_3_rw_bytes,arm=3D1,gpu=3D1/ -I 1=
000 sleep 10
> +
> +The 1st command show how to use channel 1 to monitor the DDR bandwidth f=
rom ARM.
> +The 2nd command show using channel 2 to get the DDR bandwidth of GPU.
> +The 3rd command show using channel 3 to monitor the sum of ARM and GPU.

The wordings are rather weird, so I need to improve the doc:

---- >8 ----

diff --git a/Documentation/admin-guide/perf/meson-ddr-pmu.rst b/Documentati=
on/admin-guide/perf/meson-ddr-pmu.rst
index 15e93a751ced8a..4a1fdb5aba4b24 100644
--- a/Documentation/admin-guide/perf/meson-ddr-pmu.rst
+++ b/Documentation/admin-guide/perf/meson-ddr-pmu.rst
@@ -4,11 +4,12 @@
 Amlogic SoC DDR Bandwidth Performance Monitoring Unit (PMU)
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=20
-There is a bandwidth monitor inside the DRAM controller. The monitor inclu=
des
-4 channels which can count the read/write request of accessing DRAM indivi=
dually.
-It can be helpful to show if the performance bottleneck is on DDR bandwidt=
h.
+The Amlogic Meson G12 SoC contains a bandwidth monitor inside DRAM control=
ler.
+The monitor includes 4 channels which can count the read/write request of
+individual DRAM. It can be helpful to show if the performance bottleneck i=
s on
+DDR bandwidth.
=20
-Currently, this driver supports the following 5 Perf events:
+Currently, this driver supports the following 5 perf events:
=20
 + meson_ddr_bw/total_rw_bytes/
 + meson_ddr_bw/chan_1_rw_bytes/
@@ -16,55 +17,54 @@ Currently, this driver supports the following 5 Perf ev=
ents:
 + meson_ddr_bw/chan_3_rw_bytes/
 + meson_ddr_bw/chan_4_rw_bytes/
=20
-meson_ddr_bw/chan_{1,2,3,4}_rw_bytes/ events are the channel related event=
s.
-Each channel support using keywords as filter, which can let the channel
-to monitor the individual IP module in SoC.
+meson_ddr_bw/chan_{1,2,3,4}_rw_bytes/ events are channel-specific events.
+Each channel support filtering, which can let the channel to monitor
+individual IP module in SoC.
=20
-The following keywords are the filter:
+Below are DDR access request event filter keywords:
=20
-+ arm             - DDR access request from CPU
-+ vpu_read1       - DDR access request from OSD + VPP read
-+ gpu             - DDR access request from 3D GPU
-+ pcie            - DDR access request from PCIe controller
-+ hdcp            - DDR access request from HDCP controller
-+ hevc_front      - DDR access request from HEVC codec front end
-+ usb3_0          - DDR access request from USB3.0 controller
-+ hevc_back       - DDR access request from HEVC codec back end
-+ h265enc         - DDR access request from HEVC encoder
-+ vpu_read2       - DDR access request from DI read
-+ vpu_write1      - DDR access request from VDIN write
-+ vpu_write2      - DDR access request from di write
-+ vdec            - DDR access request from legacy codec video decoder
-+ hcodec          - DDR access request from H264 encoder
-+ ge2d            - DDR access request from ge2d
-+ spicc1          - DDR access request from SPI controller 1
-+ usb0            - DDR access request from USB2.0 controller 0
-+ dma             - DDR access request from system DMA controller 1
-+ arb0            - DDR access request from arb0
-+ sd_emmc_b       - DDR access request from SD eMMC b controller
-+ usb1            - DDR access request from USB2.0 controller 1
-+ audio           - DDR access request from Audio module
-+ sd_emmc_c       - DDR access request from SD eMMC c controller
-+ spicc2          - DDR access request from SPI controller 2
-+ ethernet        - DDR access request from Ethernet controller
++ arm             - from CPU
++ vpu_read1       - from OSD + VPP read
++ gpu             - from 3D GPU
++ pcie            - from PCIe controller
++ hdcp            - from HDCP controller
++ hevc_front      - from HEVC codec front end
++ usb3_0          - from USB3.0 controller
++ hevc_back       - from HEVC codec back end
++ h265enc         - from HEVC encoder
++ vpu_read2       - from DI read
++ vpu_write1      - from VDIN write
++ vpu_write2      - from di write
++ vdec            - from legacy codec video decoder
++ hcodec          - from H264 encoder
++ ge2d            - from ge2d
++ spicc1          - from SPI controller 1
++ usb0            - from USB2.0 controller 0
++ dma             - from system DMA controller 1
++ arb0            - from arb0
++ sd_emmc_b       - from SD eMMC b controller
++ usb1            - from USB2.0 controller 1
++ audio           - from Audio module
++ sd_emmc_c       - from SD eMMC c controller
++ spicc2          - from SPI controller 2
++ ethernet        - from Ethernet controller
=20
=20
-The following command is to show the total DDR bandwidth:
+Examples:
=20
-  .. code-block:: bash
+  + Show the total DDR bandwidth per seconds:
=20
-      perf stat -a -e meson_ddr_bw/total_rw_bytes/ -I 1000 sleep 10
+    .. code-block:: bash
=20
-This command will print the total DDR bandwidth per second.
+       perf stat -a -e meson_ddr_bw/total_rw_bytes/ -I 1000 sleep 10
=20
-The following commands are to show how to use filter parameters:
=20
-  .. code-block:: bash
+  + Show individual DDR bandwidth from CPU and GPU respectively, as well as
+    sum of them:
=20
-      perf stat -a -e meson_ddr_bw/chan_1_rw_bytes,arm=3D1/ -I 1000 sleep =
10
-      perf stat -a -e meson_ddr_bw/chan_2_rw_bytes,gpu=3D1/ -I 1000 sleep =
10
-      perf stat -a -e meson_ddr_bw/chan_3_rw_bytes,arm=3D1,gpu=3D1/ -I 100=
0 sleep 10
+    .. code-block:: bash
+
+       perf stat -a -e meson_ddr_bw/chan_1_rw_bytes,arm=3D1/ -I 1000 sleep=
 10
+       perf stat -a -e meson_ddr_bw/chan_2_rw_bytes,gpu=3D1/ -I 1000 sleep=
 10
+       perf stat -a -e meson_ddr_bw/chan_3_rw_bytes,arm=3D1,gpu=3D1/ -I 10=
00 sleep 10
=20
-The 1st command show how to use channel 1 to monitor the DDR bandwidth fro=
m ARM.
-The 2nd command show using channel 2 to get the DDR bandwidth of GPU.
-The 3rd command show using channel 3 to monitor the sum of ARM and GPU.

Thanks.

--=20
An old man doll... just what I always wanted! - Clara

--SOugpbm6WXLm6VXW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCY3SwHAAKCRD2uYlJVVFO
o+NZAPoDa0i2wxLCFwtRivr2QLNs82ReCmvxEh7SEZ0B1JevggD/d+aO0jPIOPxK
FXSmRUhZMKbnj0XdW1vUuhOb3Ga06w0=
=nHtJ
-----END PGP SIGNATURE-----

--SOugpbm6WXLm6VXW--
