Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A23B5623AEE
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 05:16:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230472AbiKJEQO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 23:16:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229516AbiKJEQK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 23:16:10 -0500
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F3CD122;
        Wed,  9 Nov 2022 20:16:09 -0800 (PST)
Received: by mail-pg1-x533.google.com with SMTP id h193so602528pgc.10;
        Wed, 09 Nov 2022 20:16:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ibH+9/2oBv8UQhaAePpj6pNOE/HnnRoQrnoLynsSf08=;
        b=CDQH0w0HLWpmKQkHCzLAcKOi7i1d1fXXGcYSZ8ucdgpvVeKLrJdm3yGC7EpwYTzPae
         zMeA9DUR1sQbvLYN05T74ubb5FtHDm45QiamOsWyheeVaduvl6TXr5ZSDan4tlda64Rm
         WNGlmG+F6tSxrGUwvy14VNexs+hQLPWpyHEQgfBl16VPn/UtefVSnjWr/dHOZaZhyxMt
         c6FdEOFjcoHMaHGYNOL+nv1cNZScXK/dpQkNexuaBWqG1ooqRXyzNhfxNUVi6xOSdj5t
         RNVA3GjPf6/E9iNdXy5CoLPZTU1tf8w9TtC6JKtEa4yiqncILvQm5aTZIFqsOr1IKn6Q
         BQww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ibH+9/2oBv8UQhaAePpj6pNOE/HnnRoQrnoLynsSf08=;
        b=kUE/3ORdsLerlEOp9MjzPk+q7GDEbZjZSgBTVv6lj9aCxydLlzi9ZihWMHgVHXWP6C
         DPFCLdDJVNMlkaNxv0YCUfcGqTN2NwPSw+QKXf2rkima1Cj2yt053z+NKs1t05Zoc9aQ
         gHE+q93uN1hSdzfDw/BGpD+s46/bOiEnk38CRMHa05kJ7nbms9Kofa/H20JOrBLqDUCW
         /W7taLUvm00lf+dkN2HcejKSgmoDib2u2Pwm7Tv9bFZxWqmlMpxvUjmjQgzAVVAXVIfB
         LG3dUVkgyzCzCJdjqnplKmMXqUOihuPC8uXbftz7lw2NWKJ9XWwVQnlzLqncgg7QIgBu
         VN+g==
X-Gm-Message-State: ACrzQf2F+W8cUdHW7ukLhXaGCiIQ3grwHWsJuWYVMFJ+uXiNRP2+S2nb
        JEd70rSC04RJu2SXsxEBiGA=
X-Google-Smtp-Source: AMsMyM7hJthTt96ds7awLiIDlO9v0DT2cC7u4hjqbFNLxWoZPX8IfZFz7CSBGj9HuisE1Q3diTUBKQ==
X-Received: by 2002:a63:505d:0:b0:470:275b:aff3 with SMTP id q29-20020a63505d000000b00470275baff3mr1504945pgl.522.1668053768733;
        Wed, 09 Nov 2022 20:16:08 -0800 (PST)
Received: from debian.me (subs28-116-206-12-34.three.co.id. [116.206.12.34])
        by smtp.gmail.com with ESMTPSA id fr14-20020a17090ae2ce00b00214247989dfsm2077196pjb.13.2022.11.09.20.16.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Nov 2022 20:16:08 -0800 (PST)
Received: by debian.me (Postfix, from userid 1000)
        id 9D0FA1037F0; Thu, 10 Nov 2022 11:16:05 +0700 (WIB)
Date:   Thu, 10 Nov 2022 11:16:05 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Yicong Yang <yangyicong@huawei.com>
Cc:     Shaokun Zhang <zhangshaokun@hisilicon.com>, liuqi6124@gmail.com,
        Jonathan Corbet <corbet@lwn.net>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        John Garry <john.garry@huawei.com>,
        jonathan.cameron@huawei.com, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
        linuxarm@huawei.com, f.fangjian@huawei.com, prime.zeng@huawei.com
Subject: Re: [PATCH 3/3] drivers/perf: hisi: Add TLP filter support
Message-ID: <Y2x7Bfb12nwcCfL0@debian.me>
References: <20221025113242.58271-1-yangyicong@huawei.com>
 <20221025113242.58271-4-yangyicong@huawei.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="2p+HDPuYjcR8N+5y"
Content-Disposition: inline
In-Reply-To: <20221025113242.58271-4-yangyicong@huawei.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--2p+HDPuYjcR8N+5y
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 25, 2022 at 07:32:42PM +0800, Yicong Yang wrote:
> +4. TLP Length filter
> +When counting bandwidth, the data can be composed of certain parts of TLP
> +packets. You can specify it through "len_mode":
> +
> +- 2'b00: Reserved (Do not use this since the behaviour is undefined)
> +- 2'b01: Bandwidth of TLP payloads
> +- 2'b10: Bandwidth of TLP headers
> +- 2'b11: Bandwidth of both TLP payloads and headers
> +
> +For example, "len_mode=3D2" means only counting the bandwidth of TLP hea=
ders
> +and "len_mode=3D3" means the final bandwidth data is composed of both TLP
> +headers and payloads. You need to carefully using this to avoid losing
> +data. For example you're likely to get no counts by "len_mode=3D1" if th=
e TLPs
> +on the traffic has no payload. This config is optional, by default it'll
> +be 2'b11.
> +
> +Example usage of perf::
> +
> +  $# perf stat -e hisi_pcie0_core0/rx_mrd_flux,len_mode=3D0x1/ sleep 5

The indentation is rather ugly, so I have applied the fixup:

---- >8 ----

diff --git a/Documentation/admin-guide/perf/hisi-pcie-pmu.rst b/Documentati=
on/admin-guide/perf/hisi-pcie-pmu.rst
index 83a2ef11b1a08d..bae690dddbebfd 100644
--- a/Documentation/admin-guide/perf/hisi-pcie-pmu.rst
+++ b/Documentation/admin-guide/perf/hisi-pcie-pmu.rst
@@ -106,21 +106,22 @@ Example usage of perf::
   $# perf stat -e hisi_pcie0_core0/rx_mrd_flux,thr_len=3D0x4,thr_mode=3D1/=
 sleep 5
=20
 4. TLP Length filter
-When counting bandwidth, the data can be composed of certain parts of TLP
-packets. You can specify it through "len_mode":
=20
-- 2'b00: Reserved (Do not use this since the behaviour is undefined)
-- 2'b01: Bandwidth of TLP payloads
-- 2'b10: Bandwidth of TLP headers
-- 2'b11: Bandwidth of both TLP payloads and headers
+   When counting bandwidth, the data can be composed of certain parts of T=
LP
+   packets. You can specify it through "len_mode":
=20
-For example, "len_mode=3D2" means only counting the bandwidth of TLP heade=
rs
-and "len_mode=3D3" means the final bandwidth data is composed of both TLP
-headers and payloads. You need to carefully using this to avoid losing
-data. For example you're likely to get no counts by "len_mode=3D1" if the =
TLPs
-on the traffic has no payload. This config is optional, by default it'll
-be 2'b11.
+   - 2'b00: Reserved (Do not use this since the behaviour is undefined)
+   - 2'b01: Bandwidth of TLP payloads
+   - 2'b10: Bandwidth of TLP headers
+   - 2'b11: Bandwidth of both TLP payloads and headers
=20
-Example usage of perf::
+   For example, "len_mode=3D2" means only counting the bandwidth of TLP he=
aders
+   and "len_mode=3D3" means the final bandwidth data is composed of both T=
LP
+   headers and payloads. You need to carefully using this to avoid losing
+   data. For example you're likely to get no counts by "len_mode=3D1" if t=
he TLPs
+   on the traffic has no payload. This config is optional, by default it'll
+   be 2'b11.
=20
-  $# perf stat -e hisi_pcie0_core0/rx_mrd_flux,len_mode=3D0x1/ sleep 5
+   Example usage of perf::
+
+     $# perf stat -e hisi_pcie0_core0/rx_mrd_flux,len_mode=3D0x1/ sleep 5

Also, for formatting consistency, you need to pick up the fix for rest of
documentation (as separate patch in your series):

---- >8 ----

=46rom 5f286aceb959a7c70a56cb5c453d3ac0b844fb49 Mon Sep 17 00:00:00 2001
=46rom: Bagas Sanjaya <bagasdotme@gmail.com>
Date: Thu, 10 Nov 2022 11:03:08 +0700
Subject: [PATCH] Documentation: perf: Indent filter options list

The "Filter options" list have a rather ugly indentation. Also, the first
paragraph after list name is rendered without separator (as continuation
=66rom the name).

Align the list by indenting the list items and add a blank line
separator for each list name.

Fixes: c8602008e247f5 ("docs: perf: Add description for HiSilicon PCIe PMU =
driver")
Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
---
 .../admin-guide/perf/hisi-pcie-pmu.rst        | 80 ++++++++++---------
 1 file changed, 43 insertions(+), 37 deletions(-)

diff --git a/Documentation/admin-guide/perf/hisi-pcie-pmu.rst b/Documentati=
on/admin-guide/perf/hisi-pcie-pmu.rst
index bae690dddbebfd..54fab870a2aefb 100644
--- a/Documentation/admin-guide/perf/hisi-pcie-pmu.rst
+++ b/Documentation/admin-guide/perf/hisi-pcie-pmu.rst
@@ -48,62 +48,68 @@ Filter options
 --------------
=20
 1. Target filter
-PMU could only monitor the performance of traffic downstream target Root P=
orts
-or downstream target Endpoint. PCIe PMU driver support "port" and "bdf"
-interfaces for users, and these two interfaces aren't supported at the same
-time.
=20
--port
-"port" filter can be used in all PCIe PMU events, target Root Port can be
-selected by configuring the 16-bits-bitmap "port". Multi ports can be sele=
cted
-for AP-layer-events, and only one port can be selected for TL/DL-layer-eve=
nts.
+   PMU could only monitor the performance of traffic downstream target Root
+   Ports or downstream target Endpoint. PCIe PMU driver support "port" and
+   "bdf" interfaces for users, and these two interfaces aren't supported a=
t the
+   same time.
=20
-For example, if target Root Port is 0000:00:00.0 (x8 lanes), bit0 of bitmap
-should be set, port=3D0x1; if target Root Port is 0000:00:04.0 (x4 lanes),
-bit8 is set, port=3D0x100; if these two Root Ports are both monitored, por=
t=3D0x101.
+   - port
=20
-Example usage of perf::
+     "port" filter can be used in all PCIe PMU events, target Root Port ca=
n be
+     selected by configuring the 16-bits-bitmap "port". Multi ports can be
+     selected for AP-layer-events, and only one port can be selected for
+     TL/DL-layer-events.
=20
-  $# perf stat -e hisi_pcie0_core0/rx_mwr_latency,port=3D0x1/ sleep 5
+     For example, if target Root Port is 0000:00:00.0 (x8 lanes), bit0 of
+     bitmap should be set, port=3D0x1; if target Root Port is 0000:00:04.0=
 (x4
+     lanes), bit8 is set, port=3D0x100; if these two Root Ports are both
+     monitored, port=3D0x101.
=20
--bdf
+     Example usage of perf::
=20
-"bdf" filter can only be used in bandwidth events, target Endpoint is sele=
cted
-by configuring BDF to "bdf". Counter only counts the bandwidth of message
-requested by target Endpoint.
+       $# perf stat -e hisi_pcie0_core0/rx_mwr_latency,port=3D0x1/ sleep 5
=20
-For example, "bdf=3D0x3900" means BDF of target Endpoint is 0000:39:00.0.
+   - bdf
=20
-Example usage of perf::
+     "bdf" filter can only be used in bandwidth events, target Endpoint is
+     selected by configuring BDF to "bdf". Counter only counts the bandwid=
th of
+     message requested by target Endpoint.
=20
-  $# perf stat -e hisi_pcie0_core0/rx_mrd_flux,bdf=3D0x3900/ sleep 5
+     For example, "bdf=3D0x3900" means BDF of target Endpoint is 0000:39:0=
0.0.
+
+     Example usage of perf::
+
+       $# perf stat -e hisi_pcie0_core0/rx_mrd_flux,bdf=3D0x3900/ sleep 5
=20
 2. Trigger filter
-Event statistics start when the first time TLP length is greater/smaller
-than trigger condition. You can set the trigger condition by writing "trig=
_len",
-and set the trigger mode by writing "trig_mode". This filter can only be u=
sed
-in bandwidth events.
=20
-For example, "trig_len=3D4" means trigger condition is 2^4 DW, "trig_mode=
=3D0"
-means statistics start when TLP length > trigger condition, "trig_mode=3D1"
-means start when TLP length < condition.
+   Event statistics start when the first time TLP length is greater/smaller
+   than trigger condition. You can set the trigger condition by writing
+   "trig_len", and set the trigger mode by writing "trig_mode". This filte=
r can
+   only be used in bandwidth events.
=20
-Example usage of perf::
+   For example, "trig_len=3D4" means trigger condition is 2^4 DW, "trig_mo=
de=3D0"
+   means statistics start when TLP length > trigger condition, "trig_mode=
=3D1"
+   means start when TLP length < condition.
=20
-  $# perf stat -e hisi_pcie0_core0/rx_mrd_flux,trig_len=3D0x4,trig_mode=3D=
1/ sleep 5
+   Example usage of perf::
+
+     $# perf stat -e hisi_pcie0_core0/rx_mrd_flux,trig_len=3D0x4,trig_mode=
=3D1/ sleep 5
=20
 3. Threshold filter
-Counter counts when TLP length within the specified range. You can set the
-threshold by writing "thr_len", and set the threshold mode by writing
-"thr_mode". This filter can only be used in bandwidth events.
=20
-For example, "thr_len=3D4" means threshold is 2^4 DW, "thr_mode=3D0" means
-counter counts when TLP length >=3D threshold, and "thr_mode=3D1" means co=
unts
-when TLP length < threshold.
+   Counter counts when TLP length within the specified range. You can set =
the
+   threshold by writing "thr_len", and set the threshold mode by writing
+   "thr_mode". This filter can only be used in bandwidth events.
=20
-Example usage of perf::
+   For example, "thr_len=3D4" means threshold is 2^4 DW, "thr_mode=3D0" me=
ans
+   counter counts when TLP length >=3D threshold, and "thr_mode=3D1" means=
 counts
+   when TLP length < threshold.
=20
-  $# perf stat -e hisi_pcie0_core0/rx_mrd_flux,thr_len=3D0x4,thr_mode=3D1/=
 sleep 5
+   Example usage of perf::
+
+     $# perf stat -e hisi_pcie0_core0/rx_mrd_flux,thr_len=3D0x4,thr_mode=
=3D1/ sleep 5
=20
 4. TLP Length filter
=20
--=20
An old man doll... just what I always wanted! - Clara

Thanks.

--=20
An old man doll... just what I always wanted! - Clara

--2p+HDPuYjcR8N+5y
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCY2x7BQAKCRD2uYlJVVFO
o7GiAQCte9McVZRNU0b+HErtRh1Oqr0wZG5WlOJDwuYfBjz4JQD+NXo2dzMSVbxt
fy0JhHL/O0TRXMuHtOZ3eaDkn51cYQI=
=E+W+
-----END PGP SIGNATURE-----

--2p+HDPuYjcR8N+5y--
