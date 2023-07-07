Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E30D574AF9C
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jul 2023 13:23:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232211AbjGGLXR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jul 2023 07:23:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232394AbjGGLXQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jul 2023 07:23:16 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDB03210B;
        Fri,  7 Jul 2023 04:23:10 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id 2adb3069b0e04-4f9fdb0ef35so2837824e87.0;
        Fri, 07 Jul 2023 04:23:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688728989; x=1691320989;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=bC76BhDwvxGXnn22R6GjRzYzl+h/Q/u01ff105/sBgQ=;
        b=OvulJ2wp7kvjJsNqUZa5a4O8MHzJHoyIKMsRNRMVaUjWy17Vlw9NraoqlHX03+bvoi
         0LRIzaOURtJfjEXQA9DVQqGLz+z79SCppdgLUs73SpCN4h21QIRDdJeXK5R6V3SV8R6A
         LxhAm2bvZtSjN+Yrmi5Ar3hRVOXOk2EomC+94ShH8uyGA+X2NecLAQAfuOwZ+vtrL4qp
         DAvL7MqfVEUOWYR2i17ycfREhSTLONz9JWLyk2pl4j98PXq52YrXag8cN/eBZrW9Qy5t
         DQhozXF2qjX8mlprIqwF/3l5PRDRF8/9sd4S6IXZGwj8N/7jHfbC/ECERs7C0sSbVPvY
         pMPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688728989; x=1691320989;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bC76BhDwvxGXnn22R6GjRzYzl+h/Q/u01ff105/sBgQ=;
        b=Ta8S6o2oNxAn5RcU/rOnGa1GQsjzI36ku6KXTuGLmzNa4J0+SRFZ3A/pWB2QhUoLwH
         UPkas0VTaSC1qVX41SIAtONM+6MDo6JQ6kfk06e3vKsdUnqH6uZ1Bd9kBoWqkPAVKwDG
         i/VvqeM9nxLbivp3IAQeiiwDjPPDi4ZQQefuZxLcVSnaYxX/697VqB9CSqnMfRlc4mtg
         cTS3Ayt1q0zqFsJKH9Od79zeyHqoy3Ww0+w8Ekzfk3ad5fOCv6VeQ5s/6n0Q4ALVbuP5
         WuaDPx+uS3Ch1grRlk4WUVggh0+2iHCP/NKflUcPVMVdo+sZAwAT7iF5Tb9DrxaTyUYp
         0BhQ==
X-Gm-Message-State: ABy/qLbh7BXWilyh8z1tYiBAo1VMkTntAltg/VfD/nl0NFKDZR4c6gnC
        Ph8SZfAuc8coY0nqYCOcJLc=
X-Google-Smtp-Source: APBJJlEoDNEUdkTuiZsa4PG2xKEqULrUzoYCMVkzBXeymajyxcvxrgJk5wfVOPDKQ09Hzx29BGap1w==
X-Received: by 2002:a05:6512:36cb:b0:4f8:6560:6436 with SMTP id e11-20020a05651236cb00b004f865606436mr3369596lfs.9.1688728988606;
        Fri, 07 Jul 2023 04:23:08 -0700 (PDT)
Received: from dc78bmyyyyyyyyyyyyyyt-3.rev.dnainternet.fi (dc78bmyyyyyyyyyyyyyyt-3.rev.dnainternet.fi. [2001:14ba:16f8:1500::1])
        by smtp.gmail.com with ESMTPSA id t21-20020ac24c15000000b004f858249931sm646040lfq.93.2023.07.07.04.23.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jul 2023 04:23:07 -0700 (PDT)
Date:   Fri, 7 Jul 2023 14:23:03 +0300
From:   Matti Vaittinen <mazziesaccount@gmail.com>
To:     Matti Vaittinen <mazziesaccount@gmail.com>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Matti Vaittinen <mazziesaccount@gmail.com>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/3] iio: light: bu27008: add chip info
Message-ID: <b4cdb81ef9522e94150673b3b78a4cbae5fa67f2.1688723839.git.mazziesaccount@gmail.com>
References: <cover.1688723839.git.mazziesaccount@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="FOmLUoRwvszmiTLB"
Content-Disposition: inline
In-Reply-To: <cover.1688723839.git.mazziesaccount@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--FOmLUoRwvszmiTLB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The ROHM BU27010 RGB + flickering sensor is in many regards similar to
the BU27008. Prepare for adding support for BU27010 by allowing
chip-specific properties to be brought from the of_device_id data.

Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>

---
Revision history:
v1 =3D> v2:
 - Move all generic refactoring from next patch to this one so that the
   next one will only contain the BU27010 specific additions.
 - reorder bu27008 chip-data assignments to match the struct member
   placement
 - Cleanup
---
 drivers/iio/light/rohm-bu27008.c | 323 ++++++++++++++++++++-----------
 1 file changed, 208 insertions(+), 115 deletions(-)

diff --git a/drivers/iio/light/rohm-bu27008.c b/drivers/iio/light/rohm-bu27=
008.c
index b50bf8973d9a..08e2b1194bf4 100644
--- a/drivers/iio/light/rohm-bu27008.c
+++ b/drivers/iio/light/rohm-bu27008.c
@@ -211,7 +211,35 @@ static const struct iio_chan_spec bu27008_channels[] =
=3D {
 	IIO_CHAN_SOFT_TIMESTAMP(BU27008_NUM_CHANS),
 };
=20
+struct bu27008_data;
+
+struct bu27_chip_data {
+	const char *name;
+	int (*chip_init)(struct bu27008_data *data);
+	int (*get_gain_sel)(struct bu27008_data *data, int *sel);
+	int (*write_gain_sel)(struct bu27008_data *data, int sel);
+	const struct regmap_config *regmap_cfg;
+	const struct iio_gain_sel_pair *gains;
+	const struct iio_gain_sel_pair *gains_ir;
+	const struct iio_itime_sel_mul *itimes;
+	int num_gains;
+	int num_gains_ir;
+	int num_itimes;
+	int scale1x;
+
+	int drdy_en_reg;
+	int drdy_en_mask;
+	int meas_en_reg;
+	int meas_en_mask;
+	int valid_reg;
+	int chan_sel_reg;
+	int chan_sel_mask;
+	int int_time_mask;
+	u8 part_id;
+};
+
 struct bu27008_data {
+	const struct bu27_chip_data *cd;
 	struct regmap *regmap;
 	struct iio_trigger *trig;
 	struct device *dev;
@@ -282,51 +310,6 @@ static const struct regmap_config bu27008_regmap =3D {
 	.disable_locking =3D true,
 };
=20
-#define BU27008_MAX_VALID_RESULT_WAIT_US	50000
-#define BU27008_VALID_RESULT_WAIT_QUANTA_US	1000
-
-static int bu27008_chan_read_data(struct bu27008_data *data, int reg, int =
*val)
-{
-	int ret, valid;
-	__le16 tmp;
-
-	ret =3D regmap_read_poll_timeout(data->regmap, BU27008_REG_MODE_CONTROL3,
-				       valid, (valid & BU27008_MASK_VALID),
-				       BU27008_VALID_RESULT_WAIT_QUANTA_US,
-				       BU27008_MAX_VALID_RESULT_WAIT_US);
-	if (ret)
-		return ret;
-
-	ret =3D regmap_bulk_read(data->regmap, reg, &tmp, sizeof(tmp));
-	if (ret)
-		dev_err(data->dev, "Reading channel data failed\n");
-
-	*val =3D le16_to_cpu(tmp);
-
-	return ret;
-}
-
-static int bu27008_get_gain(struct bu27008_data *data, struct iio_gts *gts=
, int *gain)
-{
-	int ret, sel;
-
-	ret =3D regmap_read(data->regmap, BU27008_REG_MODE_CONTROL2, &sel);
-	if (ret)
-		return ret;
-
-	sel =3D FIELD_GET(BU27008_MASK_RGBC_GAIN, sel);
-
-	ret =3D iio_gts_find_gain_by_sel(gts, sel);
-	if (ret < 0) {
-		dev_err(data->dev, "unknown gain value 0x%x\n", sel);
-		return ret;
-	}
-
-	*gain =3D ret;
-
-	return 0;
-}
-
 static int bu27008_write_gain_sel(struct bu27008_data *data, int sel)
 {
 	int regval;
@@ -368,6 +351,123 @@ static int bu27008_write_gain_sel(struct bu27008_data=
 *data, int sel)
 				  BU27008_MASK_RGBC_GAIN, regval);
 }
=20
+static int bu27008_get_gain_sel(struct bu27008_data *data, int *sel)
+{
+	int ret;
+
+	/*
+	 * If we always "lock" the gain selectors for all channels to prevent
+	 * unsupported configs, then it does not matter which channel is used
+	 * we can just return selector from any of them.
+	 *
+	 * This, however is not true if we decide to support only 4X and 16X
+	 * and then individual gains for channels. Currently this is not the
+	 * case.
+	 *
+	 * If we some day decide to support individual gains, then we need to
+	 * have channel information here.
+	 */
+
+	ret =3D regmap_read(data->regmap, BU27008_REG_MODE_CONTROL2, sel);
+	if (ret)
+		return ret;
+
+	*sel =3D FIELD_GET(BU27008_MASK_RGBC_GAIN, *sel);
+
+	return 0;
+}
+
+static int bu27008_chip_init(struct bu27008_data *data)
+{
+	int ret;
+
+	ret =3D regmap_write_bits(data->regmap, BU27008_REG_SYSTEM_CONTROL,
+				BU27008_MASK_SW_RESET, BU27008_MASK_SW_RESET);
+	if (ret)
+		return dev_err_probe(data->dev, ret, "Sensor reset failed\n");
+
+	/*
+	 * The data-sheet does not tell how long performing the IC reset takes.
+	 * However, the data-sheet says the minimum time it takes the IC to be
+	 * able to take inputs after power is applied, is 100 uS. I'd assume
+	 * > 1 mS is enough.
+	 */
+	msleep(1);
+
+	ret =3D regmap_reinit_cache(data->regmap, data->cd->regmap_cfg);
+	if (ret)
+		dev_err(data->dev, "Failed to reinit reg cache\n");
+
+	return ret;
+}
+
+static const struct bu27_chip_data bu27008_chip =3D {
+	.name =3D "bu27008",
+	.chip_init =3D bu27008_chip_init,
+	.get_gain_sel =3D bu27008_get_gain_sel,
+	.write_gain_sel =3D bu27008_write_gain_sel,
+	.regmap_cfg =3D &bu27008_regmap,
+	.gains =3D &bu27008_gains[0],
+	.gains_ir =3D &bu27008_gains_ir[0],
+	.itimes =3D &bu27008_itimes[0],
+	.num_gains =3D ARRAY_SIZE(bu27008_gains),
+	.num_gains_ir =3D ARRAY_SIZE(bu27008_gains_ir),
+	.num_itimes =3D ARRAY_SIZE(bu27008_itimes),
+	.scale1x =3D BU27008_SCALE_1X,
+	.drdy_en_reg =3D BU27008_REG_MODE_CONTROL3,
+	.drdy_en_mask =3D BU27008_MASK_INT_EN,
+	.valid_reg =3D BU27008_REG_MODE_CONTROL3,
+	.meas_en_reg =3D BU27008_REG_MODE_CONTROL3,
+	.meas_en_mask =3D BU27008_MASK_MEAS_EN,
+	.chan_sel_reg =3D BU27008_REG_MODE_CONTROL3,
+	.chan_sel_mask =3D BU27008_MASK_CHAN_SEL,
+	.int_time_mask =3D BU27008_MASK_MEAS_MODE,
+	.part_id =3D BU27008_ID,
+};
+
+#define BU27008_MAX_VALID_RESULT_WAIT_US	50000
+#define BU27008_VALID_RESULT_WAIT_QUANTA_US	1000
+
+static int bu27008_chan_read_data(struct bu27008_data *data, int reg, int =
*val)
+{
+	int ret, valid;
+	__le16 tmp;
+
+	ret =3D regmap_read_poll_timeout(data->regmap, data->cd->valid_reg,
+				       valid, (valid & BU27008_MASK_VALID),
+				       BU27008_VALID_RESULT_WAIT_QUANTA_US,
+				       BU27008_MAX_VALID_RESULT_WAIT_US);
+	if (ret)
+		return ret;
+
+	ret =3D regmap_bulk_read(data->regmap, reg, &tmp, sizeof(tmp));
+	if (ret)
+		dev_err(data->dev, "Reading channel data failed\n");
+
+	*val =3D le16_to_cpu(tmp);
+
+	return ret;
+}
+
+static int bu27008_get_gain(struct bu27008_data *data, struct iio_gts *gts=
, int *gain)
+{
+	int ret, sel;
+
+	ret =3D data->cd->get_gain_sel(data, &sel);
+	if (ret)
+		return ret;
+
+	ret =3D iio_gts_find_gain_by_sel(gts, sel);
+	if (ret < 0) {
+		dev_err(data->dev, "unknown gain value 0x%x\n", sel);
+		return ret;
+	}
+
+	*gain =3D ret;
+
+	return 0;
+}
+
 static int bu27008_set_gain(struct bu27008_data *data, int gain)
 {
 	int ret;
@@ -376,7 +476,7 @@ static int bu27008_set_gain(struct bu27008_data *data, =
int gain)
 	if (ret < 0)
 		return ret;
=20
-	return bu27008_write_gain_sel(data, ret);
+	return data->cd->write_gain_sel(data, ret);
 }
=20
 static int bu27008_get_int_time_sel(struct bu27008_data *data, int *sel)
@@ -384,15 +484,23 @@ static int bu27008_get_int_time_sel(struct bu27008_da=
ta *data, int *sel)
 	int ret, val;
=20
 	ret =3D regmap_read(data->regmap, BU27008_REG_MODE_CONTROL1, &val);
-	*sel =3D FIELD_GET(BU27008_MASK_MEAS_MODE, val);
+	if (ret)
+		return ret;
=20
-	return ret;
+	val &=3D data->cd->int_time_mask;
+	val >>=3D ffs(data->cd->int_time_mask) - 1;
+
+	*sel =3D val;
+
+	return 0;
 }
=20
 static int bu27008_set_int_time_sel(struct bu27008_data *data, int sel)
 {
+	sel <<=3D ffs(data->cd->int_time_mask) - 1;
+
 	return regmap_update_bits(data->regmap, BU27008_REG_MODE_CONTROL1,
-				  BU27008_MASK_MEAS_MODE, sel);
+				  data->cd->int_time_mask, sel);
 }
=20
 static int bu27008_get_int_time_us(struct bu27008_data *data)
@@ -448,8 +556,7 @@ static int bu27008_set_int_time(struct bu27008_data *da=
ta, int time)
 	if (ret < 0)
 		return ret;
=20
-	return regmap_update_bits(data->regmap, BU27008_REG_MODE_CONTROL1,
-				  BU27008_MASK_MEAS_MODE, ret);
+	return bu27008_set_int_time_sel(data, ret);
 }
=20
 /* Try to change the time so that the scale is maintained */
@@ -527,10 +634,13 @@ static int bu27008_try_set_int_time(struct bu27008_da=
ta *data, int int_time_new)
 	return ret;
 }
=20
-static int bu27008_meas_set(struct bu27008_data *data, int state)
+static int bu27008_meas_set(struct bu27008_data *data, bool enable)
 {
-	return regmap_update_bits(data->regmap, BU27008_REG_MODE_CONTROL3,
-				  BU27008_MASK_MEAS_EN, state);
+	if (enable)
+		return regmap_set_bits(data->regmap, data->cd->meas_en_reg,
+				       data->cd->meas_en_mask);
+	return regmap_clear_bits(data->regmap, data->cd->meas_en_reg,
+				 data->cd->meas_en_mask);
 }
=20
 static int bu27008_chan_cfg(struct bu27008_data *data,
@@ -543,9 +653,15 @@ static int bu27008_chan_cfg(struct bu27008_data *data,
 	else
 		chan_sel =3D BU27008_CLEAR2_IR3;
=20
-	chan_sel =3D FIELD_PREP(BU27008_MASK_CHAN_SEL, chan_sel);
+	/*
+	 * prepare bitfield for channel sel. The FIELD_PREP works only when
+	 * mask is constant. In our case the mask is assigned based on the
+	 * chip type. Hence the open-coded FIELD_PREP here. We don't bother
+	 * zeroing the irrelevant bits though - update_bits takes care of that.
+	 */
+	chan_sel <<=3D ffs(data->cd->chan_sel_mask) - 1;
=20
-	return regmap_update_bits(data->regmap, BU27008_REG_MODE_CONTROL3,
+	return regmap_update_bits(data->regmap, data->cd->chan_sel_reg,
 				  BU27008_MASK_CHAN_SEL, chan_sel);
 }
=20
@@ -558,7 +674,7 @@ static int bu27008_read_one(struct bu27008_data *data, =
struct iio_dev *idev,
 	if (ret)
 		return ret;
=20
-	ret =3D bu27008_meas_set(data, BU27008_MEAS_EN);
+	ret =3D bu27008_meas_set(data, true);
 	if (ret)
 		return ret;
=20
@@ -574,7 +690,7 @@ static int bu27008_read_one(struct bu27008_data *data, =
struct iio_dev *idev,
 	if (!ret)
 		ret =3D IIO_VAL_INT;
=20
-	if (bu27008_meas_set(data, BU27008_MEAS_DIS))
+	if (bu27008_meas_set(data, false))
 		dev_warn(data->dev, "measurement disabling failed\n");
=20
 	return ret;
@@ -669,7 +785,7 @@ static int bu27008_set_scale(struct bu27008_data *data,
 			goto unlock_out;
=20
 	}
-	ret =3D bu27008_write_gain_sel(data, gain_sel);
+	ret =3D data->cd->write_gain_sel(data, gain_sel);
=20
 unlock_out:
 	mutex_unlock(&data->mutex);
@@ -762,10 +878,10 @@ static int bu27008_update_scan_mode(struct iio_dev *i=
dev,
 		chan_sel =3D BU27008_CLEAR2_IR3;
 	}
=20
-	chan_sel =3D FIELD_PREP(BU27008_MASK_CHAN_SEL, chan_sel);
+	chan_sel <<=3D ffs(data->cd->chan_sel_mask) - 1;
=20
-	return regmap_update_bits(data->regmap, BU27008_REG_MODE_CONTROL3,
-				 BU27008_MASK_CHAN_SEL, chan_sel);
+	return regmap_update_bits(data->regmap, data->cd->chan_sel_reg,
+				  data->cd->chan_sel_mask, chan_sel);
 }
=20
 static const struct iio_info bu27008_info =3D {
@@ -777,46 +893,18 @@ static const struct iio_info bu27008_info =3D {
 	.validate_trigger =3D iio_validate_own_trigger,
 };
=20
-static int bu27008_chip_init(struct bu27008_data *data)
-{
-	int ret;
-
-	ret =3D regmap_write_bits(data->regmap, BU27008_REG_SYSTEM_CONTROL,
-				BU27008_MASK_SW_RESET, BU27008_MASK_SW_RESET);
-	if (ret)
-		return dev_err_probe(data->dev, ret, "Sensor reset failed\n");
-
-	/*
-	 * The data-sheet does not tell how long performing the IC reset takes.
-	 * However, the data-sheet says the minimum time it takes the IC to be
-	 * able to take inputs after power is applied, is 100 uS. I'd assume
-	 * > 1 mS is enough.
-	 */
-	msleep(1);
-
-	ret =3D regmap_reinit_cache(data->regmap, &bu27008_regmap);
-	if (ret)
-		dev_err(data->dev, "Failed to reinit reg cache\n");
-
-	return ret;
-}
-
-static int bu27008_set_drdy_irq(struct bu27008_data *data, int state)
-{
-	return regmap_update_bits(data->regmap, BU27008_REG_MODE_CONTROL3,
-				 BU27008_MASK_INT_EN, state);
-}
-
-static int bu27008_trigger_set_state(struct iio_trigger *trig,
-				     bool state)
+static int bu27008_trigger_set_state(struct iio_trigger *trig, bool state)
 {
 	struct bu27008_data *data =3D iio_trigger_get_drvdata(trig);
 	int ret;
=20
+
 	if (state)
-		ret =3D bu27008_set_drdy_irq(data, BU27008_INT_EN);
+		ret =3D regmap_set_bits(data->regmap, data->cd->drdy_en_reg,
+				      data->cd->drdy_en_mask);
 	else
-		ret =3D bu27008_set_drdy_irq(data, BU27008_INT_DIS);
+		ret =3D regmap_clear_bits(data->regmap, data->cd->drdy_en_reg,
+					data->cd->drdy_en_mask);
 	if (ret)
 		dev_err(data->dev, "Failed to set trigger state\n");
=20
@@ -852,7 +940,7 @@ static irqreturn_t bu27008_trigger_handler(int irq, voi=
d *p)
 	 * After some measurements, it seems reading the
 	 * BU27008_REG_MODE_CONTROL3 debounces the IRQ line
 	 */
-	ret =3D regmap_read(data->regmap, BU27008_REG_MODE_CONTROL3, &dummy);
+	ret =3D regmap_read(data->regmap, data->cd->valid_reg, &dummy);
 	if (ret < 0)
 		goto err_read;
=20
@@ -872,14 +960,14 @@ static int bu27008_buffer_preenable(struct iio_dev *i=
dev)
 {
 	struct bu27008_data *data =3D iio_priv(idev);
=20
-	return bu27008_meas_set(data, BU27008_MEAS_EN);
+	return bu27008_meas_set(data, true);
 }
=20
 static int bu27008_buffer_postdisable(struct iio_dev *idev)
 {
 	struct bu27008_data *data =3D iio_priv(idev);
=20
-	return bu27008_meas_set(data, BU27008_MEAS_DIS);
+	return bu27008_meas_set(data, false);
 }
=20
 static const struct iio_buffer_setup_ops bu27008_buffer_ops =3D {
@@ -952,11 +1040,6 @@ static int bu27008_probe(struct i2c_client *i2c)
 	struct iio_dev *idev;
 	int ret;
=20
-	regmap =3D devm_regmap_init_i2c(i2c, &bu27008_regmap);
-	if (IS_ERR(regmap))
-		return dev_err_probe(dev, PTR_ERR(regmap),
-				     "Failed to initialize Regmap\n");
-
 	idev =3D devm_iio_device_alloc(dev, sizeof(*data));
 	if (!idev)
 		return -ENOMEM;
@@ -967,24 +1050,34 @@ static int bu27008_probe(struct i2c_client *i2c)
=20
 	data =3D iio_priv(idev);
=20
+	data->cd =3D device_get_match_data(&i2c->dev);
+	if (!data->cd)
+		return -ENODEV;
+
+	regmap =3D devm_regmap_init_i2c(i2c, data->cd->regmap_cfg);
+	if (IS_ERR(regmap))
+		return dev_err_probe(dev, PTR_ERR(regmap),
+				     "Failed to initialize Regmap\n");
+
+
 	ret =3D regmap_read(regmap, BU27008_REG_SYSTEM_CONTROL, &reg);
 	if (ret)
 		return dev_err_probe(dev, ret, "Failed to access sensor\n");
=20
 	part_id =3D FIELD_GET(BU27008_MASK_PART_ID, reg);
=20
-	if (part_id !=3D BU27008_ID)
+	if (part_id !=3D data->cd->part_id)
 		dev_warn(dev, "unknown device 0x%x\n", part_id);
=20
-	ret =3D devm_iio_init_iio_gts(dev, BU27008_SCALE_1X, 0, bu27008_gains,
-				    ARRAY_SIZE(bu27008_gains), bu27008_itimes,
-				    ARRAY_SIZE(bu27008_itimes), &data->gts);
+	ret =3D devm_iio_init_iio_gts(dev, data->cd->scale1x, 0, data->cd->gains,
+				    data->cd->num_gains, data->cd->itimes,
+				    data->cd->num_itimes, &data->gts);
 	if (ret)
 		return ret;
=20
-	ret =3D devm_iio_init_iio_gts(dev, BU27008_SCALE_1X, 0, bu27008_gains_ir,
-				    ARRAY_SIZE(bu27008_gains_ir), bu27008_itimes,
-				    ARRAY_SIZE(bu27008_itimes), &data->gts_ir);
+	ret =3D devm_iio_init_iio_gts(dev, data->cd->scale1x, 0, data->cd->gains_=
ir,
+				    data->cd->num_gains_ir, data->cd->itimes,
+				    data->cd->num_itimes, &data->gts_ir);
 	if (ret)
 		return ret;
=20
@@ -993,14 +1086,14 @@ static int bu27008_probe(struct i2c_client *i2c)
 	data->dev =3D dev;
 	data->irq =3D i2c->irq;
=20
-	idev->channels =3D bu27008_channels;
+	idev->channels =3D &bu27008_channels[0];
 	idev->num_channels =3D ARRAY_SIZE(bu27008_channels);
-	idev->name =3D "bu27008";
+	idev->name =3D data->cd->name;
 	idev->info =3D &bu27008_info;
 	idev->modes =3D INDIO_DIRECT_MODE;
 	idev->available_scan_masks =3D bu27008_scan_masks;
=20
-	ret =3D bu27008_chip_init(data);
+	ret =3D data->cd->chip_init(data);
 	if (ret)
 		return ret;
=20
@@ -1021,7 +1114,7 @@ static int bu27008_probe(struct i2c_client *i2c)
 }
=20
 static const struct of_device_id bu27008_of_match[] =3D {
-	{ .compatible =3D "rohm,bu27008" },
+	{ .compatible =3D "rohm,bu27008", .data =3D &bu27008_chip },
 	{ }
 };
 MODULE_DEVICE_TABLE(of, bu27008_of_match);
--=20
2.40.1


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

--FOmLUoRwvszmiTLB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmSn9ZcACgkQeFA3/03a
ocWLRAf/epOHDGahkFEdNvmNJ8ez+DMCGI7OFfhNHkUgOYdA2a9W9iLtOyiiIGFH
WvTMKp+w7qfc4dmFOSp1f1Xyqy94KBBJ1/qiVtsnicZhuvZUBpaMJHFC5eNoKy4a
1PnKCX6bobkn0HDcRZ8fdqiQ3CnzauJCfCecIdUnLaJTKA50OCMj3NYzcNb1D0dZ
HHL1p1nqDNXs7HsOOLWR5tobDSa+02tacheW8fF6lsufwZOBW8Kl9rtArtdstFmR
d+C9ZFKnU86Fi0TeGoguYEiVhtLzqvAT+of72I0KaP5X1q7otD2yndJ2hKcmVUXi
3nGRdZZfm7LEAOhlZ5elAZA5BvMkow==
=28xd
-----END PGP SIGNATURE-----

--FOmLUoRwvszmiTLB--
