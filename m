Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF1FE7235BB
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 05:22:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234567AbjFFDWT convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 5 Jun 2023 23:22:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234521AbjFFDWN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 23:22:13 -0400
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B2FC127;
        Mon,  5 Jun 2023 20:22:10 -0700 (PDT)
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3561U8W2025628;
        Mon, 5 Jun 2023 23:21:53 -0400
Received: from nwd2mta4.analog.com ([137.71.173.58])
        by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 3r02e4eap3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 05 Jun 2023 23:21:53 -0400
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
        by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 3563LpbH056728
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 5 Jun 2023 23:21:51 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.14; Mon, 5 Jun 2023
 23:21:50 -0400
Received: from ASHBMBX8.ad.analog.com ([fe80::30b9:230c:9621:902f]) by
 ASHBMBX8.ad.analog.com ([fe80::30b9:230c:9621:902f%9]) with mapi id
 15.02.0986.014; Mon, 5 Jun 2023 23:21:50 -0400
From:   "Paller, Kim Seer" <KimSeer.Paller@analog.com>
To:     Jonathan Cameron <jic23@kernel.org>
CC:     "lars@metafoo.de" <lars@metafoo.de>,
        "krzysztof.kozlowski@linaro.org" <krzysztof.kozlowski@linaro.org>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2 2/2] iio: adc: max14001: New driver
Thread-Topic: [PATCH v2 2/2] iio: adc: max14001: New driver
Thread-Index: AQHZl67Y+VuDoLqrgE+gZ2yoOVHpUq982k+AgAA5dsA=
Date:   Tue, 6 Jun 2023 03:21:50 +0000
Message-ID: <f62be66979db433eac86f32cc8587892@analog.com>
References: <20230605130755.92642-1-kimseer.paller@analog.com>
        <20230605130755.92642-3-kimseer.paller@analog.com>
 <20230605202413.5eb0c0f3@jic23-huawei>
In-Reply-To: <20230605202413.5eb0c0f3@jic23-huawei>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: =?us-ascii?Q?PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNca3BhbGxlcjJc?=
 =?us-ascii?Q?YXBwZGF0YVxyb2FtaW5nXDA5ZDg0OWI2LTMyZDMtNGE0MC04NWVlLTZiODRi?=
 =?us-ascii?Q?YTI5ZTM1Ylxtc2dzXG1zZy00MGRiYjNiOC0wNDE5LTExZWUtYWU3Yi1mOGNk?=
 =?us-ascii?Q?Yjg5MGJlNDdcYW1lLXRlc3RcNDBkYmIzYmEtMDQxOS0xMWVlLWFlN2ItZjhj?=
 =?us-ascii?Q?ZGI4OTBiZTQ3Ym9keS50eHQiIHN6PSIxODY1MCIgdD0iMTMzMzA0OTUzMDkw?=
 =?us-ascii?Q?OTY1OTY4IiBoPSI2eVVnREpkbjlOZjJBdUx0Y3ltN0NUTEZaRms9IiBpZD0i?=
 =?us-ascii?Q?IiBibD0iMCIgYm89IjEiIGNpPSJjQUFBQUVSSFUxUlNSVUZOQ2dVQUFFb0NB?=
 =?us-ascii?Q?QURRZ2NrSEpwalpBU3AySUswMXdSUVhLbllnclRYQkZCY0RBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBSEFBQUFEYUFRQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBRUFBUUFCQUFBQVNqRVh4d0FBQUFBQUFBQUFBQUFBQUo0QUFBQmhBR1FB?=
 =?us-ascii?Q?YVFCZkFITUFaUUJqQUhVQWNnQmxBRjhBY0FCeUFHOEFhZ0JsQUdNQWRBQnpB?=
 =?us-ascii?Q?RjhBWmdCaEFHd0Fjd0JsQUY4QVpnQnZBSE1BYVFCMEFHa0FkZ0JsQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFFQUFBQUFBQUFBQWdBQUFBQUFuZ0FBQUdFQVpBQnBBRjhBY3dCbEFHTUFk?=
 =?us-ascii?Q?UUJ5QUdVQVh3QndBSElBYndCcUFHVUFZd0IwQUhNQVh3QjBBR2tBWlFCeUFE?=
 =?us-ascii?Q?RUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBUUFBQUFBQUFBQUNB?=
 =?us-ascii?Q?QUFBQUFDZUFBQUFZUUJrQUdrQVh3QnpBR1VBWXdCMUFISUFaUUJmQUhBQWNn?=
 =?us-ascii?Q?QnZBR29BWlFCakFIUUFjd0JmQUhRQWFRQmxBSElBTWdBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQkFBQUFBQUFBQUFJQUFBQUFBQT09Ii8+PC9t?=
 =?us-ascii?Q?ZXRhPg=3D=3D?=
x-dg-rorf: true
x-originating-ip: [10.116.242.24]
x-adiruleop-newscl: Rule Triggered
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-Proofpoint-ORIG-GUID: zjRzMez9RocrTC_vVv5ygMfTBk-VH21r
X-Proofpoint-GUID: zjRzMez9RocrTC_vVv5ygMfTBk-VH21r
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-05_35,2023-06-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 mlxlogscore=999
 adultscore=0 impostorscore=0 spamscore=0 priorityscore=1501 bulkscore=0
 lowpriorityscore=0 clxscore=1015 phishscore=0 malwarescore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2306060029
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> -----Original Message-----
> From: Jonathan Cameron <jic23@kernel.org>
> Sent: Tuesday, June 6, 2023 3:24 AM
> To: Paller, Kim Seer <KimSeer.Paller@analog.com>
> Cc: lars@metafoo.de; krzysztof.kozlowski@linaro.org; broonie@kernel.org;
> lgirdwood@gmail.com; linux-iio@vger.kernel.org; linux-
> kernel@vger.kernel.org
> Subject: Re: [PATCH v2 2/2] iio: adc: max14001: New driver
> 
> [External]
> 
> On Mon, 5 Jun 2023 21:07:55 +0800
> Kim Seer Paller <kimseer.paller@analog.com> wrote:
> 
> > The MAX14001 is configurable, isolated 10-bit ADCs for multi-range
> > binary inputs.
> >
> > Signed-off-by: Kim Seer Paller <kimseer.paller@analog.com>
> > ---
> ...
> 
> Hi Kim,
> 
> A few comments inline.
> 
> > diff --git a/drivers/iio/adc/max14001.c b/drivers/iio/adc/max14001.c
> > new file mode 100644 index 000000000..7c5272756
> > --- /dev/null
> > +++ b/drivers/iio/adc/max14001.c
> > @@ -0,0 +1,333 @@
> > +// SPDX-License-Identifier: (GPL-2.0-only OR BSD-3-Clause)
> > +/*
> > + * Analog Devices MAX14001 ADC driver
> > + *
> > + * Copyright 2023 Analog Devices Inc.
> > + */
> > +
> > +#include <linux/bitfield.h>
> > +#include <linux/bitrev.h>
> > +#include <linux/device.h>
> > +#include <linux/iio/iio.h>
> > +#include <linux/kernel.h>
> > +#include <linux/module.h>
> > +#include <linux/mod_devicetable.h>
> > +#include <linux/property.h>
> > +#include <linux/regmap.h>
> > +#include <linux/regulator/consumer.h> #include <linux/spi/spi.h>
> > +#include <linux/slab.h> #include <linux/types.h>
> > +
> > +#include <asm/unaligned.h>
> > +
> > +/* MAX14001 Registers Address */
> > +#define MAX14001_ADC			0x00
> > +#define MAX14001_FADC			0x01
> > +#define MAX14001_FLAGS			0x02
> > +#define MAX14001_FLTEN			0x03
> > +#define MAX14001_THL			0x04
> > +#define MAX14001_THU			0x05
> > +#define MAX14001_INRR			0x06
> > +#define MAX14001_INRT			0x07
> > +#define MAX14001_INRP			0x08
> > +#define MAX14001_CFG			0x09
> > +#define MAX14001_ENBL			0x0A
> > +#define MAX14001_ACT			0x0B
> > +#define MAX14001_WEN			0x0C
> > +
> > +#define MAX14001_VERIFICATION_REG(x)	((x) + 0x10)
> > +
> > +#define MAX14001_CFG_EXRF		BIT(5)
> > +
> > +#define MAX14001_ADDR_MASK		GENMASK(15, 11)
> > +#define MAX14001_DATA_MASK		GENMASK(9, 0)
> > +#define MAX14001_FILTER_MASK		GENMASK(3, 2)
> > +
> > +#define MAX14001_SET_WRITE_BIT		BIT(10)
> > +#define MAX14001_WRITE_WEN		0x294
> > +
> > +struct max14001_state {
> > +	struct spi_device	*spi;
> > +	/* lock protect agains multiple concurrent accesses */
> 
> To what?  Here I suspect it's RMW sequence on device and perhaps more
> importantly the buffers below.
> 
> > +	struct mutex		lock;
> > +	struct regmap		*regmap;
> > +	int			vref_mv;
> > +	/*
> > +	 * DMA (thus cache coherency maintenance) requires the
> > +	 * transfer buffers to live in their own cache lines.
> 
> You are looking at an old kernel I guess - we fixed all of these - and
> introduced IIO_DMA_MINALIGN for __aligned(IIO_DMA_MINALIGN) to
> make it easier to fix any such problems in future.
> 
> Upshot is that ___cacheline_aligned aligns to the l1 cacheline length.
> Some fun systems (such as the big servers I use in my dayjob) have higher
> cacheline sizes for their larger / further from CPU caches.
> One group of SoCs out there is known to both do non coherent DMA and
> have a larger line size for the bit relevant to that than ___cacheline_aligned
> gives you. So on that rare platform this is currently broken.

It's good to know. Given this information, is there anything specific that I 
need to change in the code or implementation related to 
the ___cacheline_aligned part?
> 
> > +	 */
> > +	__be16			spi_tx_buffer ____cacheline_aligned;
> > +	__be16			spi_rx_buffer;
> > +};
> > +
> > +static int max14001_read(void *context, unsigned int reg_addr,
> > +					unsigned int *data)
> > +{
> > +	struct max14001_state *st = context;
> > +	u16 tx = 0;
> > +	int ret;
> > +
> > +	struct spi_transfer xfers[] = {
> > +		{
> > +			.tx_buf = &st->spi_tx_buffer,
> > +			.len = 2,
> > +			.cs_change = 1,
> > +		}, {
> > +			.rx_buf = &st->spi_rx_buffer,
> > +			.len = 2,
> > +		},
> > +	};
> > +
> > +	tx = FIELD_PREP(MAX14001_ADDR_MASK, reg_addr);
> > +	st->spi_tx_buffer = bitrev16(cpu_to_be16(tx));
> > +
> > +	ret = spi_sync_transfer(st->spi, xfers, ARRAY_SIZE(xfers));
> > +	if (ret)
> > +		return ret;
> > +
> > +	*data = bitrev16(be16_to_cpu(st->spi_rx_buffer)) &
> > +MAX14001_DATA_MASK;
> > +
> > +	return 0;
> > +}
> > +
> > +static int max14001_write(void *context, unsigned int reg_addr,
> > +					unsigned int data)
> > +{
> > +	struct max14001_state *st = context;
> > +	u16 tx = 0;
> > +
> > +	tx = FIELD_PREP(MAX14001_ADDR_MASK, reg_addr);
> > +	tx |= FIELD_PREP(MAX14001_SET_WRITE_BIT, 1);
> > +	tx |= FIELD_PREP(MAX14001_DATA_MASK, data);
> > +
> > +	st->spi_tx_buffer = bitrev16(cpu_to_be16(tx));
> > +
> > +	return spi_write(st->spi, &st->spi_tx_buffer, 2); }
> > +
> > +static int max14001_write_verification_reg(struct max14001_state *st,
> > +				     unsigned int reg_addr)
> > +{
> > +	unsigned int reg_data;
> > +	int ret;
> > +
> > +	ret = max14001_read(st, reg_addr, &reg_data);
> > +	if (ret)
> > +		return ret;
> > +
> > +	return max14001_write(st,
> MAX14001_VERIFICATION_REG(reg_addr),
> > +				reg_data);
> 
> Even though this is a bit unusual, I'd still expect this to use the regmap_read /
> regmap_write interfaces not directly use the callbacks.
> 
> > +}
> > +
> > +static int max14001_reg_update(struct max14001_state *st,
> > +				unsigned int reg_addr,
> > +				unsigned int mask,
> > +				unsigned int val)
> > +{
> > +	int ret;
> > +
> > +	/* Enable SPI Registers Write */
> > +	ret = max14001_write(st, MAX14001_WEN,
> MAX14001_WRITE_WEN);
> 
> Mixing regmap and non regmap rather defeats the point of having a standard
> interface.  Use regmap_read and regmap_write throughout or not at all.

I found it difficult to implement the regmap interface due to the timing diagram 
requirements. The chip select needs to be changed between transfers, which, 
as far as I know, does not work with regmap. Perhaps, I will consider sticking 
to the non-regmap approach.

> 
> > +	if (ret)
> > +		return ret;
> > +
> > +	ret = regmap_update_bits(st->regmap, reg_addr, mask, val);
> > +	if (ret)
> > +		return ret;
> > +
> > +	ret = max14001_write_verification_reg(st, reg_addr);
> > +	if (ret)
> > +		return ret;
> > +
> > +	/* Disable SPI Registers Write */
> > +	return max14001_write(st, MAX14001_WEN, 0); }
> > +
> > +static int max14001_read_raw(struct iio_dev *indio_dev,
> > +			     struct iio_chan_spec const *chan,
> > +			     int *val, int *val2, long mask) {
> > +	struct max14001_state *st = iio_priv(indio_dev);
> > +	unsigned int data;
> > +	int ret;
> > +
> > +	switch (mask) {
> > +	case IIO_CHAN_INFO_RAW:
> > +		mutex_lock(&st->lock);
> > +		ret = max14001_read(st, MAX14001_ADC, &data);
> > +		mutex_unlock(&st->lock);
> > +		if (ret < 0)
> > +			return ret;
> > +
> > +		*val = data;
> > +
> > +		return IIO_VAL_INT;
> > +
> > +	case IIO_CHAN_INFO_SCALE:
> > +		*val = st->vref_mv;
> > +		*val2 = 10;
> > +
> > +		return IIO_VAL_FRACTIONAL_LOG2;
> > +
> > +	default:
> > +		return -EINVAL;
> > +	}
> > +}
> > +
> > +static const struct regmap_config max14001_regmap_config = {
> > +	.reg_read = max14001_read,
> > +	.reg_write = max14001_write,
> 
> I'd keep this up by the callbacks, so all the regmap setup stuff is in one place.
> 
> > +};
> > +
> > +static const struct iio_info max14001_info = {
> > +	.read_raw = max14001_read_raw,
> > +};
> > +
> 
> ...
> 
> > +static int max14001_probe(struct spi_device *spi) {
> 
> ...
> 
> > +
> > +	vref = devm_regulator_get_optional(&spi->dev, "vref");
> > +	if (IS_ERR(vref)) {
> > +		if (PTR_ERR(vref) != -ENODEV)
> > +			return dev_err_probe(&spi->dev, PTR_ERR(vref),
> > +					     "Failed to get vref regulator");
> > +
> > +		/* internal reference */
> > +		st->vref_mv = 1250;
> > +	} else {
> > +		ret = regulator_enable(vref);
> > +		if (ret)
> > +			return dev_err_probe(&spi->dev, ret,
> > +					"Failed to enable vref regulators\n");
> > +
> > +		ret = devm_add_action_or_reset(&spi->dev,
> > +					       max14001_regulator_disable,
> > +					       vref);
> > +		if (ret)
> > +			return ret;
> > +
> > +		/* enable external voltage reference */
> 
> use external voltage reference?
> 
> It's enabled by the regulator_enable() above, not this line.

What I meant was to enable the CFG register to utilize the external voltage 
source within the ADC. I've missed to specify the comment on this one.

> 
> > +		ret = max14001_reg_update(st, MAX14001_CFG,
> > +					  MAX14001_CFG_EXRF, 1);
> > +
> > +		ret = regulator_get_voltage(vref);
> > +		if (ret < 0)
> > +			return dev_err_probe(&spi->dev, ret,
> > +					     "Failed to get vref\n");
> > +
> > +		st->vref_mv = ret / 1000;
> > +	}
> > +
> > +	mutex_init(&st->lock);
> > +
> > +	return devm_iio_device_register(&spi->dev, indio_dev); }

