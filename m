Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D0336D208E
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 14:41:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232058AbjCaMlc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Mar 2023 08:41:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232025AbjCaMlJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Mar 2023 08:41:09 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FEAB1EFEB;
        Fri, 31 Mar 2023 05:40:45 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id 20so22899845lju.0;
        Fri, 31 Mar 2023 05:40:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680266443;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=RoNgMJS/WX2gsDrOzjtehYweXkN/xH7z2f4YUMb7ZG0=;
        b=DRkfl9roSnhg+bkb0mPXe3tSOmclBwFApJsooNjVOIcTMfFkExKkPEJ0yVpQwjS4bl
         ZugykKDKE8XT8+5xXroJJPZqRhQqs0eteAA4x0jyVijn6cBzAj2BMeKSIyAcxiLUznWb
         48ZBVacWx/NqoEGSzssNGuQFFxXIsVf4ZJ06Hkl91Um6tBcH+/tTzY536kjgGUQB6z10
         NzYZJSbxTqgD71p461bUNrTNKGURDHFVagNU5ViMyKhn2Va2mO+60g9hOBnnGNJw0L77
         boHXO63X3LoKneY7wXDXfUowqGJU+l+1k+UMO+fIDx/v7J/KD3pVejazOffS5vhQkSET
         8NFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680266443;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RoNgMJS/WX2gsDrOzjtehYweXkN/xH7z2f4YUMb7ZG0=;
        b=UOCakL/k4TLqTzCbQzxCfYFL6SLA9W28H2F1dxSc33m9qxF+Cwhd5EMGfZr489+juN
         FzMwt3cbpBMwS5OpLUXsjFpkj+yo4jrSD3br7xZu0wHA5Jqv/HNpWRHk22ns6UbN5Rkq
         RvKrze5+sfFyah2KDktHqMFZ1lZOpapZ5wcCfZZzxGMiakguj2uBknNehdG/Lb1FbvUf
         zZgKqzvxF8tZeTo3d5Qp38OtegSJb3P+PJHlh4W/53JcAyKZd8kY/8tDCrEZnX7+zz7B
         A8BsOzp7HMmJydmZDE/aVQGkhRDk8r7iYDPndGOYDOoa9KLSSpD++jXlVlN26sIZN3tk
         FfBw==
X-Gm-Message-State: AAQBX9eabfRlY4HbFSspuSLayJminYcCFByXZ/bqMDj7sZWaXiaMOgHV
        my3TuLY1ddFJtaUK8w9XbfE=
X-Google-Smtp-Source: AKy350bwu/CWVEF1ALCy/rfPHyLQd8lQyGrW1ScQlRcqajNhxBBlPAA7gpHREUumPuSc5J1fyGbfiw==
X-Received: by 2002:a2e:240b:0:b0:294:716d:8d5 with SMTP id k11-20020a2e240b000000b00294716d08d5mr7495749ljk.1.1680266442964;
        Fri, 31 Mar 2023 05:40:42 -0700 (PDT)
Received: from dc75zzyyyyyyyyyyyyyyt-3.rev.dnainternet.fi (dc75zzyyyyyyyyyyyyyyt-3.rev.dnainternet.fi. [2001:14ba:16f3:4a00::1])
        by smtp.gmail.com with ESMTPSA id x5-20020a2e8805000000b002934fe524d2sm347504ljh.83.2023.03.31.05.40.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Mar 2023 05:40:42 -0700 (PDT)
Date:   Fri, 31 Mar 2023 15:40:28 +0300
From:   Matti Vaittinen <mazziesaccount@gmail.com>
To:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Matti Vaittinen <mazziesaccount@gmail.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org
Subject: [PATCH v7 1/5] iio: light: Add gain-time-scale helpers
Message-ID: <268d418e7cffcdaa2ece6738478bbc57692c213e.1680263956.git.mazziesaccount@gmail.com>
References: <cover.1680263956.git.mazziesaccount@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="1ULOLCyZecIYIA0W"
Content-Disposition: inline
In-Reply-To: <cover.1680263956.git.mazziesaccount@gmail.com>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--1ULOLCyZecIYIA0W
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Some light sensors can adjust both the HW-gain and integration time.
There are cases where adjusting the integration time has similar impact
to the scale of the reported values as gain setting has.

IIO users do typically expect to handle scale by a single writable 'scale'
entry. Driver should then adjust the gain/time accordingly.

It however is difficult for a driver to know whether it should change
gain or integration time to meet the requested scale. Usually it is
preferred to have longer integration time which usually improves
accuracy, but there may be use-cases where long measurement times can be
an issue. Thus it can be preferable to allow also changing the
integration time - but mitigate the scale impact by also changing the gain
underneath. Eg, if integration time change doubles the measured values,
the driver can reduce the HW-gain to half.

The theory of the computations of gain-time-scale is simple. However,
some people (undersigned) got that implemented wrong for more than once.

Add some gain-time-scale helpers in order to not dublicate errors in all
drivers needing these computations.

Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>

---
Currently it is only BU27034 using these in this series. I am however worki=
ng
with drivers for RGB sensors BU27008 and BU27010 which have similar
[gain - integration time - scale] - relation. I hope sending those
follows soon after the BU27034 is done.

Changes:
v6 =3D> v7:
 - Allow caller to know whether the
   iio_gts_find_new_gain_sel_by_old_gain_time() and
   iio_gts_find_new_gain_by_old_gain_time() did manage to compute a new
   (unsupported) gain or if the operation failed altogether.
 - Minor styling

v5 =3D> v6:
- drop unnecessary comments about using validity tables after free

v4 =3D> v5:
- drop DEFAULT_SYMBOL_NAMESPACE again
- spellcheck
- always build availability tables
- combine table-build and gts-init. Drop no longer needed interfaces
- check for invalid values at init
- document limitations of gain, time, selector and multiplier values
- document all exported functions
- move and inline valid gain / valid time and related functions to header.
  NOTE: As a side-effect this makes the internal iteration functions
  public as well.
- drop unlikely() from "cold path"
- add iio_gts_find_new_gain_by_old_gain_time()

v3 =3D> v4:
- doc styling
- use memset to zero the helper struct at init
- drop unnecessary min calculation at iio_find_closest_gain_low()
- use namespace to all exports
- many minor stylings
- make available outside iio/light (move code to drivers/iio and move the
  header under include
- rename to look like other files under drivers/iio (s/iio/industrialio)
- drop unused functions
- don't export only internally used functions and make them static
  Note, I decided to keep iio_gts_total_gain_to_scale() exported as it is
  currently needed by the tests outside the helpers.

v2 =3D> v3: (mostly fixes based on review by Andy)
- Fix typos
- Styling fixes
- Use namespace for exported symbols
- Protect allocs against argument overflow
- Fix include protection name
- add types.h inclusion and struct device forward declaration

RFCv1 =3D> v2:
- fix include guardian
- Improve kernel doc for iio_init_iio_gts.
- Add iio_gts_scale_to_total_gain
- Add iio_gts_total_gain_to_scale
- Fix review comments from Jonathan
  - add documentation to few functions
  - replace 0xffffffffffffffffLLU by U64_MAX
  - some styling fixes
  - drop unnecessary NULL checks
  - order function arguments by  in / out purpose
  - drop GAIN_SCALE_ITIME_MS()
- Add helpers for available scales and times
- Rename to iio-gts-helpers
---
 drivers/iio/Kconfig                   |    3 +
 drivers/iio/Makefile                  |    1 +
 drivers/iio/industrialio-gts-helper.c | 1077 +++++++++++++++++++++++++
 include/linux/iio/iio-gts-helper.h    |  206 +++++
 4 files changed, 1287 insertions(+)
 create mode 100644 drivers/iio/industrialio-gts-helper.c
 create mode 100644 include/linux/iio/iio-gts-helper.h

diff --git a/drivers/iio/Kconfig b/drivers/iio/Kconfig
index b190846c3dc2..52eb46ef84c1 100644
--- a/drivers/iio/Kconfig
+++ b/drivers/iio/Kconfig
@@ -30,6 +30,9 @@ config IIO_CONFIGFS
 	  (e.g. software triggers). For more info see
 	  Documentation/iio/iio_configfs.rst.
=20
+config IIO_GTS_HELPER
+	tristate
+
 config IIO_TRIGGER
 	bool "Enable triggered sampling support"
 	help
diff --git a/drivers/iio/Makefile b/drivers/iio/Makefile
index 3be08cdadd7e..9622347a1c1b 100644
--- a/drivers/iio/Makefile
+++ b/drivers/iio/Makefile
@@ -9,6 +9,7 @@ industrialio-$(CONFIG_IIO_BUFFER) +=3D industrialio-buffer.o
 industrialio-$(CONFIG_IIO_TRIGGER) +=3D industrialio-trigger.o
=20
 obj-$(CONFIG_IIO_CONFIGFS) +=3D industrialio-configfs.o
+obj-$(CONFIG_IIO_GTS_HELPER) +=3D industrialio-gts-helper.o
 obj-$(CONFIG_IIO_SW_DEVICE) +=3D industrialio-sw-device.o
 obj-$(CONFIG_IIO_SW_TRIGGER) +=3D industrialio-sw-trigger.o
 obj-$(CONFIG_IIO_TRIGGERED_EVENT) +=3D industrialio-triggered-event.o
diff --git a/drivers/iio/industrialio-gts-helper.c b/drivers/iio/industrial=
io-gts-helper.c
new file mode 100644
index 000000000000..8bb68975b259
--- /dev/null
+++ b/drivers/iio/industrialio-gts-helper.c
@@ -0,0 +1,1077 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/* gain-time-scale conversion helpers for IIO light sensors
+ *
+ * Copyright (c) 2023 Matti Vaittinen <mazziesaccount@gmail.com>
+ */
+
+#include <linux/device.h>
+#include <linux/errno.h>
+#include <linux/export.h>
+#include <linux/minmax.h>
+#include <linux/module.h>
+#include <linux/overflow.h>
+#include <linux/slab.h>
+#include <linux/sort.h>
+#include <linux/types.h>
+#include <linux/units.h>
+
+#include <linux/iio/iio-gts-helper.h>
+#include <linux/iio/types.h>
+
+/**
+ * iio_gts_get_gain - Convert scale to total gain
+ *
+ * Internal helper for converting scale to total gain.
+ *
+ * @max:	Maximum linearized scale. As an example, when scale is created
+ *		in magnitude of NANOs and max scale is 64.1 - The linearized
+ *		scale is 64 100 000 000.
+ * @scale:	Linearized scale to compute the gain for.
+ *
+ * Return:	(floored) gain corresponding to the scale. -EINVAL if scale
+ *		is invalid.
+ */
+static int iio_gts_get_gain(const u64 max, const u64 scale)
+{
+	u64 full =3D max;
+	int tmp =3D 1;
+
+	if (scale > full || !scale)
+		return -EINVAL;
+
+	if (U64_MAX - full < scale) {
+		/* Risk of overflow */
+		if (full - scale < scale)
+			return 1;
+
+		full -=3D scale;
+		tmp++;
+	}
+
+	while (full > scale * (u64)tmp)
+		tmp++;
+
+	return tmp;
+}
+
+/**
+ * gain_get_scale_fraction - get the gain or time based on scale and known=
 one
+ *
+ * @max:	Maximum linearized scale. As an example, when scale is created
+ *		in magnitude of NANOs and max scale is 64.1 - The linearized
+ *		scale is 64 100 000 000.
+ * @scale:	Linearized scale to compute the gain/time for.
+ * @known:	Either integration time or gain depending on which one is known
+ * @unknown:	Pointer to variable where the computed gain/time is stored
+ *
+ * Internal helper for computing unknown fraction of total gain.
+ * Compute either gain or time based on scale and either the gain or time
+ * depending on which one is known.
+ *
+ * Return:	0 on success.
+ */
+static int gain_get_scale_fraction(const u64 max, u64 scale, int known,
+				   int *unknown)
+{
+	int tot_gain;
+
+	tot_gain =3D iio_gts_get_gain(max, scale);
+	if (tot_gain < 0)
+		return tot_gain;
+
+	*unknown =3D tot_gain / known;
+
+	/* We require total gain to be exact multiple of known * unknown */
+	if (!*unknown || *unknown * known !=3D tot_gain)
+		return -EINVAL;
+
+	return 0;
+}
+
+static int iio_gts_delinearize(u64 lin_scale, unsigned long scaler,
+			       int *scale_whole, int *scale_nano)
+{
+	int frac;
+
+	if (scaler > NANO)
+		return -EOVERFLOW;
+
+	if (!scaler)
+		return -EINVAL;
+
+	frac =3D do_div(lin_scale, scaler);
+
+	*scale_whole =3D lin_scale;
+	*scale_nano =3D frac * (NANO / scaler);
+
+	return 0;
+}
+
+static int iio_gts_linearize(int scale_whole, int scale_nano,
+			     unsigned long scaler, u64 *lin_scale)
+{
+	/*
+	 * Expect scale to be (mostly) NANO or MICRO. Divide divider instead of
+	 * multiplication followed by division to avoid overflow.
+	 */
+	if (scaler > NANO || !scaler)
+		return -EINVAL;
+
+	*lin_scale =3D (u64)scale_whole * (u64)scaler +
+		     (u64)(scale_nano / (NANO / scaler));
+
+	return 0;
+}
+
+/**
+ * iio_gts_total_gain_to_scale - convert gain to scale
+ * @gts:	Gain time scale descriptor
+ * @total_gain:	the gain to be converted
+ * @scale_int:	Pointer to integral part of the scale (typically val1)
+ * @scale_nano:	Pointer to fractional part of the scale (nano or ppb)
+ *
+ * Convert the total gain value to scale. NOTE: This does not separate gain
+ * generated by HW-gain or integration time. It is up to caller to decide =
what
+ * part of the total gain is due to integration time and what due to HW-ga=
in.
+ *
+ * Return: 0 on success. Negative errno on failure.
+ */
+int iio_gts_total_gain_to_scale(struct iio_gts *gts, int total_gain,
+				int *scale_int, int *scale_nano)
+{
+	u64 tmp;
+
+	tmp =3D gts->max_scale;
+
+	do_div(tmp, total_gain);
+
+	return iio_gts_delinearize(tmp, NANO, scale_int, scale_nano);
+}
+EXPORT_SYMBOL_NS_GPL(iio_gts_total_gain_to_scale, IIO_GTS_HELPER);
+
+/**
+ * iio_gts_purge_avail_scale_table - free-up the available scale tables
+ * @gts:	Gain time scale descriptor
+ *
+ * Free the space reserved by iio_gts_build_avail_scale_table().
+ */
+static void iio_gts_purge_avail_scale_table(struct iio_gts *gts)
+{
+	int i;
+
+	if (gts->per_time_avail_scale_tables) {
+		for (i =3D 0; i < gts->num_itime; i++)
+			kfree(gts->per_time_avail_scale_tables[i]);
+
+		kfree(gts->per_time_avail_scale_tables);
+		gts->per_time_avail_scale_tables =3D NULL;
+	}
+
+	kfree(gts->avail_all_scales_table);
+	gts->avail_all_scales_table =3D NULL;
+
+	gts->num_avail_all_scales =3D 0;
+}
+
+static int iio_gts_gain_cmp(const void *a, const void *b)
+{
+	return *(int *)a - *(int *)b;
+}
+
+static int gain_to_scaletables(struct iio_gts *gts, int **gains, int **sca=
les)
+{
+	int ret, i, j, new_idx, time_idx;
+	int *all_gains;
+	size_t gain_bytes;
+
+	for (i =3D 0; i < gts->num_itime; i++) {
+		/*
+		 * Sort the tables for nice output and for easier finding of
+		 * unique values.
+		 */
+		sort(gains[i], gts->num_hwgain, sizeof(int), iio_gts_gain_cmp,
+		     NULL);
+
+		/* Convert gains to scales */
+		for (j =3D 0; j < gts->num_hwgain; j++) {
+			ret =3D iio_gts_total_gain_to_scale(gts, gains[i][j],
+							  &scales[i][2 * j],
+							  &scales[i][2 * j + 1]);
+			if (ret)
+				return ret;
+		}
+	}
+
+	gain_bytes =3D array_size(gts->num_hwgain, sizeof(int));
+	all_gains =3D kcalloc(gts->num_itime, gain_bytes, GFP_KERNEL);
+	if (!all_gains)
+		return -ENOMEM;
+
+	/*
+	 * We assume all the gains for same integration time were unique.
+	 * It is likely the first time table had greatest time multiplier as
+	 * the times are in the order of preference and greater times are
+	 * usually preferred. Hence we start from the last table which is likely
+	 * to have the smallest total gains.
+	 */
+	time_idx =3D gts->num_itime - 1;
+	memcpy(all_gains, gains[time_idx], gain_bytes);
+	new_idx =3D gts->num_hwgain;
+
+	while (time_idx--) {
+		for (j =3D 0; j < gts->num_hwgain; j++) {
+			int candidate =3D gains[time_idx][j];
+			int chk;
+
+			if (candidate > all_gains[new_idx - 1]) {
+				all_gains[new_idx] =3D candidate;
+				new_idx++;
+
+				continue;
+			}
+			for (chk =3D 0; chk < new_idx; chk++)
+				if (candidate <=3D all_gains[chk])
+					break;
+
+			if (candidate =3D=3D all_gains[chk])
+				continue;
+
+			memmove(&all_gains[chk + 1], &all_gains[chk],
+				(new_idx - chk) * sizeof(int));
+			all_gains[chk] =3D candidate;
+			new_idx++;
+		}
+	}
+
+	gts->avail_all_scales_table =3D kcalloc(new_idx, 2 * sizeof(int),
+					      GFP_KERNEL);
+	if (!gts->avail_all_scales_table) {
+		ret =3D -ENOMEM;
+		goto free_out;
+	}
+	gts->num_avail_all_scales =3D new_idx;
+
+	for (i =3D 0; i < gts->num_avail_all_scales; i++) {
+		ret =3D iio_gts_total_gain_to_scale(gts, all_gains[i],
+					&gts->avail_all_scales_table[i * 2],
+					&gts->avail_all_scales_table[i * 2 + 1]);
+
+		if (ret) {
+			kfree(gts->avail_all_scales_table);
+			gts->num_avail_all_scales =3D 0;
+			goto free_out;
+		}
+	}
+
+free_out:
+	kfree(all_gains);
+
+	return ret;
+}
+
+/**
+ * iio_gts_build_avail_scale_table - create tables of available scales
+ * @gts:	Gain time scale descriptor
+ *
+ * Build the tables which can represent the available scales based on the
+ * originally given gain and time tables. When both time and gain tables a=
re
+ * given this results:
+ * 1. A set of tables representing available scales for each supported
+ *    integration time.
+ * 2. A single table listing all the unique scales that any combination of
+ *    supported gains and times can provide.
+ *
+ * NOTE: Space allocated for the tables must be freed using
+ * iio_gts_purge_avail_scale_table() when the tables are no longer needed.
+ *
+ * Return: 0 on success.
+ */
+static int iio_gts_build_avail_scale_table(struct iio_gts *gts)
+{
+	int **per_time_gains, **per_time_scales, i, j, ret =3D -ENOMEM;
+
+	per_time_gains =3D kcalloc(gts->num_itime, sizeof(*per_time_gains), GFP_K=
ERNEL);
+	if (!per_time_gains)
+		return ret;
+
+	per_time_scales =3D kcalloc(gts->num_itime, sizeof(*per_time_scales), GFP=
_KERNEL);
+	if (!per_time_scales)
+		goto free_gains;
+
+	for (i =3D 0; i < gts->num_itime; i++) {
+		per_time_scales[i] =3D kcalloc(gts->num_hwgain, 2 * sizeof(int),
+					     GFP_KERNEL);
+		if (!per_time_scales[i])
+			goto err_free_out;
+
+		per_time_gains[i] =3D kcalloc(gts->num_hwgain, sizeof(int),
+					    GFP_KERNEL);
+		if (!per_time_gains[i]) {
+			kfree(per_time_scales[i]);
+			goto err_free_out;
+		}
+
+		for (j =3D 0; j < gts->num_hwgain; j++)
+			per_time_gains[i][j] =3D gts->hwgain_table[j].gain *
+					       gts->itime_table[i].mul;
+	}
+
+	ret =3D gain_to_scaletables(gts, per_time_gains, per_time_scales);
+	if (ret)
+		goto err_free_out;
+
+	kfree(per_time_gains);
+	gts->per_time_avail_scale_tables =3D per_time_scales;
+
+	return 0;
+
+err_free_out:
+	for (i--; i; i--) {
+		kfree(per_time_scales[i]);
+		kfree(per_time_gains[i]);
+	}
+	kfree(per_time_scales);
+free_gains:
+	kfree(per_time_gains);
+
+	return ret;
+}
+
+/**
+ * iio_gts_build_avail_time_table - build table of available integration t=
imes
+ * @gts:	Gain time scale descriptor
+ *
+ * Build the table which can represent the available times to be returned
+ * to users using the read_avail-callback.
+ *
+ * NOTE: Space allocated for the tables must be freed using
+ * iio_gts_purge_avail_time_table() when the tables are no longer needed.
+ *
+ * Return: 0 on success.
+ */
+static int iio_gts_build_avail_time_table(struct iio_gts *gts)
+{
+	int *times, i, j, idx =3D 0;
+
+	if (!gts->num_itime)
+		return 0;
+
+	times =3D kcalloc(gts->num_itime, sizeof(int), GFP_KERNEL);
+	if (!times)
+		return -ENOMEM;
+
+	/* Sort times from all tables to one and remove duplicates */
+	for (i =3D gts->num_itime - 1; i >=3D 0; i--) {
+		int new =3D gts->itime_table[i].time_us;
+
+		if (times[idx] < new) {
+			times[idx++] =3D new;
+			continue;
+		}
+
+		for (j =3D 0; j <=3D idx; j++) {
+			if (times[j] > new) {
+				memmove(&times[j + 1], &times[j],
+					(idx - j) * sizeof(int));
+				times[j] =3D new;
+				idx++;
+			}
+		}
+	}
+	gts->avail_time_tables =3D times;
+	/*
+	 * This is just to survive a unlikely corner-case where times in the
+	 * given time table were not unique. Else we could just trust the
+	 * gts->num_itime.
+	 */
+	gts->num_avail_time_tables =3D idx;
+
+	return 0;
+}
+
+/**
+ * iio_gts_purge_avail_time_table - free-up the available integration time=
 table
+ * @gts:	Gain time scale descriptor
+ *
+ * Free the space reserved by iio_gts_build_avail_time_table().
+ */
+static void iio_gts_purge_avail_time_table(struct iio_gts *gts)
+{
+	if (gts->num_avail_time_tables) {
+		kfree(gts->avail_time_tables);
+		gts->avail_time_tables =3D NULL;
+		gts->num_avail_time_tables =3D 0;
+	}
+}
+
+/**
+ * iio_gts_build_avail_tables - create tables of available scales and int =
times
+ * @gts:	Gain time scale descriptor
+ *
+ * Build the tables which can represent the available scales and available
+ * integration times. Availability tables are built based on the originally
+ * given gain and given time tables.
+ *
+ * When both time and gain tables are
+ * given this results:
+ * 1. A set of sorted tables representing available scales for each suppor=
ted
+ *    integration time.
+ * 2. A single sorted table listing all the unique scales that any combina=
tion
+ *    of supported gains and times can provide.
+ * 3. A sorted table of supported integration times
+ *
+ * After these tables are built one can use the iio_gts_all_avail_scales(),
+ * iio_gts_avail_scales_for_time() and iio_gts_avail_times() helpers to
+ * implement the read_avail operations.
+ *
+ * NOTE: Space allocated for the tables must be freed using
+ * iio_gts_purge_avail_tables() when the tables are no longer needed.
+ *
+ * Return: 0 on success.
+ */
+static int iio_gts_build_avail_tables(struct iio_gts *gts)
+{
+	int ret;
+
+	ret =3D iio_gts_build_avail_scale_table(gts);
+	if (ret)
+		return ret;
+
+	ret =3D iio_gts_build_avail_time_table(gts);
+	if (ret)
+		iio_gts_purge_avail_scale_table(gts);
+
+	return ret;
+}
+
+/**
+ * iio_gts_purge_avail_tables - free-up the availability tables
+ * @gts:	Gain time scale descriptor
+ *
+ * Free the space reserved by iio_gts_build_avail_tables(). Frees both the
+ * integration time and scale tables.
+ */
+static void iio_gts_purge_avail_tables(struct iio_gts *gts)
+{
+	iio_gts_purge_avail_time_table(gts);
+	iio_gts_purge_avail_scale_table(gts);
+}
+
+static void devm_iio_gts_avail_all_drop(void *res)
+{
+	iio_gts_purge_avail_tables(res);
+}
+
+/**
+ * devm_iio_gts_build_avail_tables - manged add availability tables
+ * @dev:	Pointer to the device whose lifetime tables are bound
+ * @gts:	Gain time scale descriptor
+ *
+ * Build the tables which can represent the available scales and available
+ * integration times. Availability tables are built based on the originally
+ * given gain and given time tables.
+ *
+ * When both time and gain tables are given this results:
+ * 1. A set of sorted tables representing available scales for each suppor=
ted
+ *    integration time.
+ * 2. A single sorted table listing all the unique scales that any combina=
tion
+ *    of supported gains and times can provide.
+ * 3. A sorted table of supported integration times
+ *
+ * After these tables are built one can use the iio_gts_all_avail_scales(),
+ * iio_gts_avail_scales_for_time() and iio_gts_avail_times() helpers to
+ * implement the read_avail operations.
+ *
+ * The tables are automatically released upon device detach.
+ *
+ * Return: 0 on success.
+ */
+static int devm_iio_gts_build_avail_tables(struct device *dev,
+					   struct iio_gts *gts)
+{
+	int ret;
+
+	ret =3D iio_gts_build_avail_tables(gts);
+	if (ret)
+		return ret;
+
+	return devm_add_action_or_reset(dev, devm_iio_gts_avail_all_drop, gts);
+}
+
+static int sanity_check_time(const struct iio_itime_sel_mul *t)
+{
+	if (t->sel < 0 || t->time_us < 0 || t->mul <=3D 0)
+		return -EINVAL;
+
+	return 0;
+}
+
+static int sanity_check_gain(const struct iio_gain_sel_pair *g)
+{
+	if (g->sel < 0 || g->gain <=3D 0)
+		return -EINVAL;
+
+	return 0;
+}
+
+static int iio_gts_sanity_check(struct iio_gts *gts)
+{
+	int g, t, ret;
+
+	if (!gts->num_hwgain && !gts->num_itime)
+		return -EINVAL;
+
+	for (t =3D 0; t < gts->num_itime; t++) {
+		ret =3D sanity_check_time(&gts->itime_table[t]);
+		if (ret)
+			return ret;
+	}
+
+	for (g =3D 0; g < gts->num_hwgain; g++) {
+		ret =3D sanity_check_gain(&gts->hwgain_table[g]);
+		if (ret)
+			return ret;
+	}
+
+	for (g =3D 0; g < gts->num_hwgain; g++) {
+		for (t =3D 0; t < gts->num_itime; t++) {
+			int gain, mul, res;
+
+			gain =3D gts->hwgain_table[g].gain;
+			mul =3D gts->itime_table[t].mul;
+
+			if (check_mul_overflow(gain, mul, &res))
+				return -EOVERFLOW;
+		}
+	}
+
+	return 0;
+}
+
+static int iio_init_iio_gts(int max_scale_int, int max_scale_nano,
+			const struct iio_gain_sel_pair *gain_tbl, int num_gain,
+			const struct iio_itime_sel_mul *tim_tbl, int num_times,
+			struct iio_gts *gts)
+{
+	int ret;
+
+	memset(gts, 0, sizeof(*gts));
+
+	ret =3D iio_gts_linearize(max_scale_int, max_scale_nano, NANO,
+				   &gts->max_scale);
+	if (ret)
+		return ret;
+
+	gts->hwgain_table =3D gain_tbl;
+	gts->num_hwgain =3D num_gain;
+	gts->itime_table =3D tim_tbl;
+	gts->num_itime =3D num_times;
+
+	return iio_gts_sanity_check(gts);
+}
+
+/**
+ * devm_iio_init_iio_gts - Initialize the gain-time-scale helper
+ * @dev:		Pointer to the device whose lifetime gts resources are
+ *			bound
+ * @max_scale_int:	integer part of the maximum scale value
+ * @max_scale_nano:	fraction part of the maximum scale value
+ * @gain_tbl:		table describing supported gains
+ * @num_gain:		number of gains in the gain table
+ * @tim_tbl:		table describing supported integration times. Provide
+ *			the integration time table sorted so that the preferred
+ *			integration time is in the first array index. The search
+ *			functions like the
+ *			iio_gts_find_time_and_gain_sel_for_scale() start search
+ *			from first provided time.
+ * @num_times:		number of times in the time table
+ * @gts:		pointer to the helper struct
+ *
+ * Initialize the gain-time-scale helper for use. Note, gains, times, sele=
ctors
+ * and multipliers must be positive. Negative values are reserved for error
+ * checking. The total gain (maximum gain * maximum time multiplier) must =
not
+ * overflow int. The allocated resources will be released upon device deta=
ch.
+ *
+ * Return: 0 on success.
+ */
+int devm_iio_init_iio_gts(struct device *dev, int max_scale_int, int max_s=
cale_nano,
+			  const struct iio_gain_sel_pair *gain_tbl, int num_gain,
+			  const struct iio_itime_sel_mul *tim_tbl, int num_times,
+			  struct iio_gts *gts)
+{
+	int ret;
+
+	ret =3D iio_init_iio_gts(max_scale_int, max_scale_nano, gain_tbl,
+			       num_gain, tim_tbl, num_times, gts);
+	if (ret)
+		return ret;
+
+	return devm_iio_gts_build_avail_tables(dev, gts);
+}
+EXPORT_SYMBOL_NS_GPL(devm_iio_init_iio_gts, IIO_GTS_HELPER);
+
+/**
+ * iio_gts_all_avail_scales - helper for listing all available scales
+ * @gts:	Gain time scale descriptor
+ * @vals:	Returned array of supported scales
+ * @type:	Type of returned scale values
+ * @length:	Amount of returned values in array
+ *
+ * Return: a value suitable to be returned from read_avail or a negative e=
rror.
+ */
+int iio_gts_all_avail_scales(struct iio_gts *gts, const int **vals, int *t=
ype,
+			     int *length)
+{
+	if (!gts->num_avail_all_scales)
+		return -EINVAL;
+
+	*vals =3D gts->avail_all_scales_table;
+	*type =3D IIO_VAL_INT_PLUS_NANO;
+	*length =3D gts->num_avail_all_scales * 2;
+
+	return IIO_AVAIL_LIST;
+}
+EXPORT_SYMBOL_NS_GPL(iio_gts_all_avail_scales, IIO_GTS_HELPER);
+
+/**
+ * iio_gts_avail_scales_for_time - list scales for integration time
+ * @gts:	Gain time scale descriptor
+ * @time:	Integration time for which the scales are listed
+ * @vals:	Returned array of supported scales
+ * @type:	Type of returned scale values
+ * @length:	Amount of returned values in array
+ *
+ * Drivers which do not allow scale setting to change integration time can
+ * use this helper to list only the scales which are valid for given integ=
ration
+ * time.
+ *
+ * Return: a value suitable to be returned from read_avail or a negative e=
rror.
+ */
+int iio_gts_avail_scales_for_time(struct iio_gts *gts, int time,
+				  const int **vals, int *type, int *length)
+{
+	int i;
+
+	for (i =3D 0; i < gts->num_itime; i++)
+		if (gts->itime_table[i].time_us =3D=3D time)
+			break;
+
+	if (i =3D=3D gts->num_itime)
+		return -EINVAL;
+
+	*vals =3D gts->per_time_avail_scale_tables[i];
+	*type =3D IIO_VAL_INT_PLUS_NANO;
+	*length =3D gts->num_hwgain * 2;
+
+	return IIO_AVAIL_LIST;
+}
+EXPORT_SYMBOL_NS_GPL(iio_gts_avail_scales_for_time, IIO_GTS_HELPER);
+
+/**
+ * iio_gts_avail_times - helper for listing available integration times
+ * @gts:	Gain time scale descriptor
+ * @vals:	Returned array of supported times
+ * @type:	Type of returned scale values
+ * @length:	Amount of returned values in array
+ *
+ * Return: a value suitable to be returned from read_avail or a negative e=
rror.
+ */
+int iio_gts_avail_times(struct iio_gts *gts,  const int **vals, int *type,
+			int *length)
+{
+	if (!gts->num_avail_time_tables)
+		return -EINVAL;
+
+	*vals =3D gts->avail_time_tables;
+	*type =3D IIO_VAL_INT;
+	*length =3D gts->num_avail_time_tables;
+
+	return IIO_AVAIL_LIST;
+}
+EXPORT_SYMBOL_NS_GPL(iio_gts_avail_times, IIO_GTS_HELPER);
+
+/**
+ * iio_gts_find_sel_by_gain - find selector corresponding to a HW-gain
+ * @gts:	Gain time scale descriptor
+ * @gain:	HW-gain for which matching selector is searched for
+ *
+ * Return:	a selector matching given HW-gain or -EINVAL if selector was
+ *		not found.
+ */
+int iio_gts_find_sel_by_gain(struct iio_gts *gts, int gain)
+{
+	int i;
+
+	for (i =3D 0; i < gts->num_hwgain; i++)
+		if (gts->hwgain_table[i].gain =3D=3D gain)
+			return gts->hwgain_table[i].sel;
+
+	return -EINVAL;
+}
+EXPORT_SYMBOL_NS_GPL(iio_gts_find_sel_by_gain, IIO_GTS_HELPER);
+
+/**
+ * iio_gts_find_gain_by_sel - find HW-gain corresponding to a selector
+ * @gts:	Gain time scale descriptor
+ * @sel:	selector for which matching HW-gain is searched for
+ *
+ * Return:	a HW-gain matching given selector or -EINVAL if HW-gain was not
+ *		found.
+ */
+int iio_gts_find_gain_by_sel(struct iio_gts *gts, int sel)
+{
+	int i;
+
+	for (i =3D 0; i < gts->num_hwgain; i++)
+		if (gts->hwgain_table[i].sel =3D=3D sel)
+			return gts->hwgain_table[i].gain;
+
+	return -EINVAL;
+}
+EXPORT_SYMBOL_NS_GPL(iio_gts_find_gain_by_sel, IIO_GTS_HELPER);
+
+/**
+ * iio_gts_get_min_gain - find smallest valid HW-gain
+ * @gts:	Gain time scale descriptor
+ *
+ * Return:	The smallest HW-gain -EINVAL if no HW-gains were in the tables.
+ */
+int iio_gts_get_min_gain(struct iio_gts *gts)
+{
+	int i, min =3D -EINVAL;
+
+	for (i =3D 0; i < gts->num_hwgain; i++) {
+		int gain =3D gts->hwgain_table[i].gain;
+
+		if (min =3D=3D -EINVAL)
+			min =3D gain;
+		else
+			min =3D min(min, gain);
+	}
+
+	return min;
+}
+EXPORT_SYMBOL_NS_GPL(iio_gts_get_min_gain, IIO_GTS_HELPER);
+
+/**
+ * iio_find_closest_gain_low - Find the closest lower matching gain
+ * @gts:	Gain time scale descriptor
+ * @gain:	HW-gain for which the closest match is searched
+ * @in_range:	indicate if the @gain was actually in the range of
+ *		supported gains.
+ *
+ * Search for closest supported gain that is lower than or equal to the
+ * gain given as a parameter. This is usable for drivers which do not requ=
ire
+ * user to request exact matching gain but rather for rounding to a suppor=
ted
+ * gain value which is equal or lower (setting lower gain is typical for
+ * avoiding saturation)
+ *
+ * Return:	The closest matching supported gain or -EINVAL if @gain
+ *		was smaller than the smallest supported gain.
+ */
+int iio_find_closest_gain_low(struct iio_gts *gts, int gain, bool *in_rang=
e)
+{
+	int i, diff =3D 0;
+	int best =3D -1;
+
+	*in_range =3D false;
+
+	for (i =3D 0; i < gts->num_hwgain; i++) {
+		if (gain =3D=3D gts->hwgain_table[i].gain) {
+			*in_range =3D true;
+			return gain;
+		}
+
+		if (gain > gts->hwgain_table[i].gain) {
+			if (!diff) {
+				diff =3D gain - gts->hwgain_table[i].gain;
+				best =3D i;
+			} else {
+				int tmp =3D gain - gts->hwgain_table[i].gain;
+
+				if (tmp < diff) {
+					diff =3D tmp;
+					best =3D i;
+				}
+			}
+		} else {
+			/*
+			 * We found valid HW-gain which is greater than
+			 * reference. So, unless we return a failure below we
+			 * will have found an in-range gain
+			 */
+			*in_range =3D true;
+		}
+	}
+	/* The requested gain was smaller than anything we support */
+	if (!diff) {
+		*in_range =3D false;
+
+		return -EINVAL;
+	}
+
+	return gts->hwgain_table[best].gain;
+}
+EXPORT_SYMBOL_NS_GPL(iio_find_closest_gain_low, IIO_GTS_HELPER);
+
+static int iio_gts_get_int_time_gain_multiplier_by_sel(struct iio_gts *gts,
+						       int sel)
+{
+	const struct iio_itime_sel_mul *time;
+
+	time =3D iio_gts_find_itime_by_sel(gts, sel);
+	if (!time)
+		return -EINVAL;
+
+	return time->mul;
+}
+
+/**
+ * iio_gts_find_gain_for_scale_using_time - Find gain by time and scale
+ * @gts:	Gain time scale descriptor
+ * @time_sel:	Integration time selector corresponding to the time gain is
+ *		searched for
+ * @scale_int:	Integral part of the scale (typically val1)
+ * @scale_nano:	Fractional part of the scale (nano or ppb)
+ * @gain:	Pointer to value where gain is stored.
+ *
+ * In some cases the light sensors may want to find a gain setting which
+ * corresponds given scale and integration time. Sensors which fill the
+ * gain and time tables may use this helper to retrieve the gain.
+ *
+ * Return:	0 on success. -EINVAL if gain matching the parameters is not
+ *		found.
+ */
+static int iio_gts_find_gain_for_scale_using_time(struct iio_gts *gts, int=
 time_sel,
+						  int scale_int, int scale_nano,
+						  int *gain)
+{
+	u64 scale_linear;
+	int ret, mul;
+
+	ret =3D iio_gts_linearize(scale_int, scale_nano, NANO, &scale_linear);
+	if (ret)
+		return ret;
+
+	ret =3D iio_gts_get_int_time_gain_multiplier_by_sel(gts, time_sel);
+	if (ret < 0)
+		return ret;
+
+	mul =3D ret;
+
+	ret =3D gain_get_scale_fraction(gts->max_scale, scale_linear, mul, gain);
+	if (ret)
+		return ret;
+
+	if (!iio_gts_valid_gain(gts, *gain))
+		return -EINVAL;
+
+	return 0;
+}
+
+/**
+ * iio_gts_find_gain_sel_for_scale_using_time - Fetch gain selector.
+ * @gts:	Gain time scale descriptor
+ * @time_sel:	Integration time selector corresponding to the time gain is
+ *		searched for
+ * @scale_int:	Integral part of the scale (typically val1)
+ * @scale_nano:	Fractional part of the scale (nano or ppb)
+ * @gain_sel:	Pointer to value where gain selector is stored.
+ *
+ * See iio_gts_find_gain_for_scale_using_time() for more information
+ */
+int iio_gts_find_gain_sel_for_scale_using_time(struct iio_gts *gts, int ti=
me_sel,
+					       int scale_int, int scale_nano,
+					       int *gain_sel)
+{
+	int gain, ret;
+
+	ret =3D iio_gts_find_gain_for_scale_using_time(gts, time_sel, scale_int,
+						     scale_nano, &gain);
+	if (ret)
+		return ret;
+
+	ret =3D iio_gts_find_sel_by_gain(gts, gain);
+	if (ret < 0)
+		return ret;
+
+	*gain_sel =3D ret;
+
+	return 0;
+}
+EXPORT_SYMBOL_NS_GPL(iio_gts_find_gain_sel_for_scale_using_time, IIO_GTS_H=
ELPER);
+
+static int iio_gts_get_total_gain(struct iio_gts *gts, int gain, int time)
+{
+	const struct iio_itime_sel_mul *itime;
+
+	if (!iio_gts_valid_gain(gts, gain))
+		return -EINVAL;
+
+	if (!gts->num_itime)
+		return gain;
+
+	itime =3D iio_gts_find_itime_by_time(gts, time);
+	if (!itime)
+		return -EINVAL;
+
+	return gain * itime->mul;
+}
+
+static int iio_gts_get_scale_linear(struct iio_gts *gts, int gain, int tim=
e,
+				    u64 *scale)
+{
+	int total_gain;
+	u64 tmp;
+
+	total_gain =3D iio_gts_get_total_gain(gts, gain, time);
+	if (total_gain < 0)
+		return total_gain;
+
+	tmp =3D gts->max_scale;
+
+	do_div(tmp, total_gain);
+
+	*scale =3D tmp;
+
+	return 0;
+}
+
+/**
+ * iio_gts_get_scale - get scale based on integration time and HW-gain
+ * @gts:	Gain time scale descriptor
+ * @gain:	HW-gain for which the scale is computed
+ * @time:	Integration time for which the scale is computed
+ * @scale_int:	Integral part of the scale (typically val1)
+ * @scale_nano:	Fractional part of the scale (nano or ppb)
+ *
+ * Compute scale matching the integration time and HW-gain given as parame=
ter.
+ *
+ * Return: 0 on success.
+ */
+int iio_gts_get_scale(struct iio_gts *gts, int gain, int time, int *scale_=
int,
+		      int *scale_nano)
+{
+	u64 lin_scale;
+	int ret;
+
+	ret =3D iio_gts_get_scale_linear(gts, gain, time, &lin_scale);
+	if (ret)
+		return ret;
+
+	return iio_gts_delinearize(lin_scale, NANO, scale_int, scale_nano);
+}
+EXPORT_SYMBOL_NS_GPL(iio_gts_get_scale, IIO_GTS_HELPER);
+
+/**
+ * iio_gts_find_new_gain_sel_by_old_gain_time - compensate for time change
+ * @gts:		Gain time scale descriptor
+ * @old_gain:		Previously set gain
+ * @old_time_sel:	Selector corresponding previously set time
+ * @new_time_sel:	Selector corresponding new time to be set
+ * @new_gain:		Pointer to value where new gain is to be written
+ *
+ * We may want to mitigate the scale change caused by setting a new integr=
ation
+ * time (for a light sensor) by also updating the (HW)gain. This helper co=
mputes
+ * new gain value to maintain the scale with new integration time.
+ *
+ * Return: 0 if an exactly matching supported new gain was found. When a
+ * non-zero value is returned, the @new_gain will be set to a negative or
+ * positive value. The negative value means that no gain could be computed.
+ * Positive value will be the "best possible new gain there could be". The=
re
+ * can be two reasons why finding the "best possible" new gain is not deem=
ed
+ * successful. 1) This new value cannot be supported by the hardware. 2) T=
he new
+ * gain required to maintain the scale would not be an integer. In this ca=
se,
+ * the "best possible" new gain will be a floored optimal gain, which may =
or
+ * may not be supported by the hardware.
+ */
+int iio_gts_find_new_gain_sel_by_old_gain_time(struct iio_gts *gts,
+					       int old_gain, int old_time_sel,
+					       int new_time_sel, int *new_gain)
+{
+	const struct iio_itime_sel_mul *itime_old, *itime_new;
+	u64 scale;
+	int ret;
+
+	*new_gain =3D -1;
+
+	itime_old =3D iio_gts_find_itime_by_sel(gts, old_time_sel);
+	if (!itime_old)
+		return -EINVAL;
+
+	itime_new =3D iio_gts_find_itime_by_sel(gts, new_time_sel);
+	if (!itime_new)
+		return -EINVAL;
+
+	ret =3D iio_gts_get_scale_linear(gts, old_gain, itime_old->time_us,
+				       &scale);
+	if (ret)
+		return ret;
+
+	ret =3D gain_get_scale_fraction(gts->max_scale, scale, itime_new->mul,
+				      new_gain);
+	if (ret)
+		return ret;
+
+	if (!iio_gts_valid_gain(gts, *new_gain))
+		return -EINVAL;
+
+	return 0;
+}
+EXPORT_SYMBOL_NS_GPL(iio_gts_find_new_gain_sel_by_old_gain_time, IIO_GTS_H=
ELPER);
+
+/**
+ * iio_gts_find_new_gain_by_old_gain_time - compensate for time change
+ * @gts:		Gain time scale descriptor
+ * @old_gain:		Previously set gain
+ * @old_time:		Selector corresponding previously set time
+ * @new_time:		Selector corresponding new time to be set
+ * @new_gain:		Pointer to value where new gain is to be written
+ *
+ * We may want to mitigate the scale change caused by setting a new integr=
ation
+ * time (for a light sensor) by also updating the (HW)gain. This helper co=
mputes
+ * new gain value to maintain the scale with new integration time.
+ *
+ * Return: 0 if an exactly matching supported new gain was found. When a
+ * non-zero value is returned, the @new_gain will be set to a negative or
+ * positive value. The negative value means that no gain could be computed.
+ * Positive value will be the "best possible new gain there could be". The=
re
+ * can be two reasons why finding the "best possible" new gain is not deem=
ed
+ * successful. 1) This new value cannot be supported by the hardware. 2) T=
he new
+ * gain required to maintain the scale would not be an integer. In this ca=
se,
+ * the "best possible" new gain will be a floored optimal gain, which may =
or
+ * may not be supported by the hardware.
+ */
+int iio_gts_find_new_gain_by_old_gain_time(struct iio_gts *gts, int old_ga=
in,
+					   int old_time, int new_time,
+					   int *new_gain)
+{
+	const struct iio_itime_sel_mul *itime_new;
+	u64 scale;
+	int ret;
+
+	*new_gain =3D -1;
+
+	itime_new =3D iio_gts_find_itime_by_time(gts, new_time);
+	if (!itime_new)
+		return -EINVAL;
+
+	ret =3D iio_gts_get_scale_linear(gts, old_gain, old_time, &scale);
+	if (ret)
+		return ret;
+
+	ret =3D gain_get_scale_fraction(gts->max_scale, scale, itime_new->mul,
+				      new_gain);
+	if (ret)
+		return ret;
+
+	if (!iio_gts_valid_gain(gts, *new_gain))
+		return -EINVAL;
+
+	return 0;
+}
+EXPORT_SYMBOL_NS_GPL(iio_gts_find_new_gain_by_old_gain_time, IIO_GTS_HELPE=
R);
+
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Matti Vaittinen <mazziesaccount@gmail.com>");
+MODULE_DESCRIPTION("IIO light sensor gain-time-scale helpers");
diff --git a/include/linux/iio/iio-gts-helper.h b/include/linux/iio/iio-gts=
-helper.h
new file mode 100644
index 000000000000..dd64e544a3da
--- /dev/null
+++ b/include/linux/iio/iio-gts-helper.h
@@ -0,0 +1,206 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/* gain-time-scale conversion helpers for IIO light sensors
+ *
+ * Copyright (c) 2023 Matti Vaittinen <mazziesaccount@gmail.com>
+ */
+
+#ifndef __IIO_GTS_HELPER__
+#define __IIO_GTS_HELPER__
+
+#include <linux/types.h>
+
+struct device;
+
+/**
+ * struct iio_gain_sel_pair - gain - selector values
+ *
+ * In many cases devices like light sensors allow setting signal amplifica=
tion
+ * (gain) using a register interface. This structure describes amplificati=
on
+ * and corresponding selector (register value)
+ *
+ * @gain:	Gain (multiplication) value. Gain must be positive, negative
+ *		values are reserved for error handling.
+ * @sel:	Selector (usually register value) used to indicate this gain.
+ *		NOTE: Only selectors >=3D 0 supported.
+ */
+struct iio_gain_sel_pair {
+	int gain;
+	int sel;
+};
+
+/**
+ * struct iio_itime_sel_mul - integration time description
+ *
+ * In many cases devices like light sensors allow setting the duration of
+ * collecting data. Typically this duration has also an impact to the magn=
itude
+ * of measured values (gain). This structure describes the relation of
+ * integration time and amplification as well as corresponding selector
+ * (register value).
+ *
+ * An example could be a sensor allowing 50, 100, 200 and 400 mS times. The
+ * respective multiplication values could be 50 mS =3D> 1, 100 mS =3D> 2,
+ * 200 mS =3D> 4 and 400 mS =3D> 8 assuming the impact of integration time=
 would be
+ * linear in a way that when collecting data for 50 mS caused value X, dou=
bling
+ * the data collection time caused value 2X etc.
+ *
+ * @time_us:	Integration time in microseconds. Time values must be positiv=
e,
+ *		negative values are reserved for error handling.
+ * @sel:	Selector (usually register value) used to indicate this time
+ *		NOTE: Only selectors >=3D 0 supported.
+ * @mul:	Multiplication to the values caused by this time.
+ *		NOTE: Only multipliers > 0 supported.
+ */
+struct iio_itime_sel_mul {
+	int time_us;
+	int sel;
+	int mul;
+};
+
+struct iio_gts {
+	u64 max_scale;
+	const struct iio_gain_sel_pair *hwgain_table;
+	int num_hwgain;
+	const struct iio_itime_sel_mul *itime_table;
+	int num_itime;
+	int **per_time_avail_scale_tables;
+	int *avail_all_scales_table;
+	int num_avail_all_scales;
+	int *avail_time_tables;
+	int num_avail_time_tables;
+};
+
+#define GAIN_SCALE_GAIN(_gain, _sel)			\
+{							\
+	.gain =3D (_gain),				\
+	.sel =3D (_sel),					\
+}
+
+#define GAIN_SCALE_ITIME_US(_itime, _sel, _mul)		\
+{							\
+	.time_us =3D (_itime),				\
+	.sel =3D (_sel),					\
+	.mul =3D (_mul),					\
+}
+
+static inline const struct iio_itime_sel_mul *
+iio_gts_find_itime_by_time(struct iio_gts *gts, int time)
+{
+	int i;
+
+	if (!gts->num_itime)
+		return NULL;
+
+	for (i =3D 0; i < gts->num_itime; i++)
+		if (gts->itime_table[i].time_us =3D=3D time)
+			return &gts->itime_table[i];
+
+	return NULL;
+}
+
+static inline const struct iio_itime_sel_mul *
+iio_gts_find_itime_by_sel(struct iio_gts *gts, int sel)
+{
+	int i;
+
+	for (i =3D 0; i < gts->num_itime; i++)
+		if (gts->itime_table[i].sel =3D=3D sel)
+			return &gts->itime_table[i];
+
+	return NULL;
+}
+
+int devm_iio_init_iio_gts(struct device *dev, int max_scale_int, int max_s=
cale_nano,
+			  const struct iio_gain_sel_pair *gain_tbl, int num_gain,
+			  const struct iio_itime_sel_mul *tim_tbl, int num_times,
+			  struct iio_gts *gts);
+/**
+ * iio_gts_find_int_time_by_sel - find integration time matching a selector
+ * @gts:	Gain time scale descriptor
+ * @sel:	selector for which matching integration time is searched for
+ *
+ * Return:	integration time matching given selector or -EINVAL if
+ *		integration time was not found.
+ */
+static inline int iio_gts_find_int_time_by_sel(struct iio_gts *gts, int se=
l)
+{
+	const struct iio_itime_sel_mul *itime;
+
+	itime =3D iio_gts_find_itime_by_sel(gts, sel);
+	if (!itime)
+		return -EINVAL;
+
+	return itime->time_us;
+}
+
+/**
+ * iio_gts_find_sel_by_int_time - find selector matching integration time
+ * @gts:	Gain time scale descriptor
+ * @gain:	HW-gain for which matching selector is searched for
+ *
+ * Return:	a selector matching given integration time or -EINVAL if
+ *		selector was not found.
+ */
+static inline int iio_gts_find_sel_by_int_time(struct iio_gts *gts, int ti=
me)
+{
+	const struct iio_itime_sel_mul *itime;
+
+	itime =3D iio_gts_find_itime_by_time(gts, time);
+	if (!itime)
+		return -EINVAL;
+
+	return itime->sel;
+}
+
+/**
+ * iio_gts_valid_time - check if given integration time is valid
+ * @gts:	Gain time scale descriptor
+ * @time_us:	Integration time to check
+ *
+ * Return:	True if given time is supported by device. False if not.
+ */
+static inline bool iio_gts_valid_time(struct iio_gts *gts, int time_us)
+{
+	return iio_gts_find_itime_by_time(gts, time_us) !=3D NULL;
+}
+
+int iio_gts_find_sel_by_gain(struct iio_gts *gts, int gain);
+
+/**
+ * iio_gts_valid_gain - check if given HW-gain is valid
+ * @gts:	Gain time scale descriptor
+ * @gain:	HW-gain to check
+ *
+ * Return:	True if given time is supported by device. False if not.
+ */
+static inline bool iio_gts_valid_gain(struct iio_gts *gts, int gain)
+{
+	return iio_gts_find_sel_by_gain(gts, gain) >=3D 0;
+}
+
+int iio_find_closest_gain_low(struct iio_gts *gts, int gain, bool *in_rang=
e);
+int iio_gts_find_gain_by_sel(struct iio_gts *gts, int sel);
+int iio_gts_get_min_gain(struct iio_gts *gts);
+int iio_gts_find_int_time_by_sel(struct iio_gts *gts, int sel);
+int iio_gts_find_sel_by_int_time(struct iio_gts *gts, int time);
+
+int iio_gts_total_gain_to_scale(struct iio_gts *gts, int total_gain,
+				int *scale_int, int *scale_nano);
+int iio_gts_find_gain_sel_for_scale_using_time(struct iio_gts *gts, int ti=
me_sel,
+					       int scale_int, int scale_nano,
+					       int *gain_sel);
+int iio_gts_get_scale(struct iio_gts *gts, int gain, int time, int *scale_=
int,
+		      int *scale_nano);
+int iio_gts_find_new_gain_sel_by_old_gain_time(struct iio_gts *gts,
+					       int old_gain, int old_time_sel,
+					       int new_time_sel, int *new_gain);
+int iio_gts_find_new_gain_by_old_gain_time(struct iio_gts *gts, int old_ga=
in,
+					   int old_time, int new_time,
+					   int *new_gain);
+int iio_gts_avail_times(struct iio_gts *gts,  const int **vals, int *type,
+			int *length);
+int iio_gts_all_avail_scales(struct iio_gts *gts, const int **vals, int *t=
ype,
+			     int *length);
+int iio_gts_avail_scales_for_time(struct iio_gts *gts, int time,
+				  const int **vals, int *type, int *length);
+
+#endif
--=20
2.39.2


--=20
Matti Vaittinen, Linux device drivers
ROHM Semiconductors, Finland SWDC
Kiviharjunlenkki 1E
90220 OULU
FINLAND

~~~ "I don't think so," said Rene Descartes. Just then he vanished ~~~
Simon says - in Latin please.
~~~ "non cogito me" dixit Rene Descarte, deinde evanescavit ~~~
Thanks to Simon Glass for the translation =3D]=20

--1ULOLCyZecIYIA0W
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmQm1LwACgkQeFA3/03a
ocXFzgf/aidgctQPJirGixqTVlqh19kHoyv1pFuZm7bnJmRAI4l7WCp2z2CQk7su
G69QOfG8PATq905DYFuK5vm5kZjO9ig3h9NyumquqVcvpy47pi3Ga3TuOeHpYIFZ
WIKLj7lmSP56Oplipy+uygiCE48fkqbB1X7NV/iiywxOenFTeA5hCoWkO39VEtyw
UXzUAoOdwHbqEYWl53mXWeQziCY8LAq6TSq08sik0vUGtJx4d+tq+OCZ9uBhHZb9
NJdzTQEQZPhM5wp8s+W99k33nTt9UAhZgFvLuSJETyDMfDZwJjmMRAcaSDszTrzx
6wy9yAMbW2tqx3L6P08FK9B187lryg==
=woqy
-----END PGP SIGNATURE-----

--1ULOLCyZecIYIA0W--
