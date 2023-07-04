Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38C0B746DDA
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jul 2023 11:43:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232000AbjGDJmw convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 4 Jul 2023 05:42:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231644AbjGDJmd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jul 2023 05:42:33 -0400
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2B9D10EA;
        Tue,  4 Jul 2023 02:41:22 -0700 (PDT)
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3649C0PC010277;
        Tue, 4 Jul 2023 05:40:59 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 3rjh250aa0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 04 Jul 2023 05:40:59 -0400
Received: from m0167089.ppops.net (m0167089.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3649eBSv022581;
        Tue, 4 Jul 2023 05:40:58 -0400
Received: from nwd2mta3.analog.com ([137.71.173.56])
        by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 3rjh250a9v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 04 Jul 2023 05:40:58 -0400
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
        by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 3649evxu027087
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 4 Jul 2023 05:40:57 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.14; Tue, 4 Jul 2023
 05:40:56 -0400
Received: from ASHBMBX8.ad.analog.com ([fe80::5480:da01:e8ae:ffda]) by
 ASHBMBX8.ad.analog.com ([fe80::5480:da01:e8ae:ffda%9]) with mapi id
 15.02.0986.014; Tue, 4 Jul 2023 05:40:56 -0400
From:   "Paller, Kim Seer" <KimSeer.Paller@analog.com>
To:     Jonathan Cameron <Jonathan.Cameron@Huawei.com>
CC:     "jic23@kernel.org" <jic23@kernel.org>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        "andy.shevchenko@gmail.com" <andy.shevchenko@gmail.com>,
        "robh@kernel.org" <robh@kernel.org>,
        "krzysztof.kozlowski@linaro.org" <krzysztof.kozlowski@linaro.org>,
        "conor+dt@kernel.org" <conor+dt@kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        kernel test robot <lkp@intel.com>
Subject: RE: [PATCH v8 2/2] iio: adc: max14001: New driver
Thread-Topic: [PATCH v8 2/2] iio: adc: max14001: New driver
Thread-Index: AQHZpRZy8xeK/o2rdEy704va5qsXxK+mkfeAgALYo9A=
Date:   Tue, 4 Jul 2023 09:40:56 +0000
Message-ID: <fcf6daf6afec48b096df14d8b5308db0@analog.com>
References: <20230622143227.30147-1-kimseer.paller@analog.com>
        <20230622143227.30147-2-kimseer.paller@analog.com>
 <20230702180315.00003dbe@Huawei.com>
In-Reply-To: <20230702180315.00003dbe@Huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: =?us-ascii?Q?PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNca3BhbGxlcjJc?=
 =?us-ascii?Q?YXBwZGF0YVxyb2FtaW5nXDA5ZDg0OWI2LTMyZDMtNGE0MC04NWVlLTZiODRi?=
 =?us-ascii?Q?YTI5ZTM1Ylxtc2dzXG1zZy1kZDlkNWEwMy0xYTRlLTExZWUtYWU4MC05OWVl?=
 =?us-ascii?Q?OWM2MGExOWVcYW1lLXRlc3RcZGQ5ZDVhMDUtMWE0ZS0xMWVlLWFlODAtOTll?=
 =?us-ascii?Q?ZTljNjBhMTllYm9keS50eHQiIHN6PSIxMzc4OCIgdD0iMTMzMzI5MzcyNTMz?=
 =?us-ascii?Q?MDk2ODkzIiBoPSJubEdqOWZqRTl4R1BxQnFEOGVhYVRZekdQUjg9IiBpZD0i?=
 =?us-ascii?Q?IiBibD0iMCIgYm89IjEiIGNpPSJjQUFBQUVSSFUxUlNSVUZOQ2dVQUFFb0NB?=
 =?us-ascii?Q?QUM5QWZhZlc2N1pBVWtQMy9OdUpYS0hTUS9mODI0bGNvY0RBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBSEFBQUFEYUFRQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBRUFBUUFCQUFBQXZkaGt4Z0FBQUFBQUFBQUFBQUFBQUo0QUFBQmhBR1FB?=
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
x-originating-ip: [10.116.18.29]
x-adiruleop-newscl: Rule Triggered
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-Proofpoint-ORIG-GUID: RBHZajU8QSgmFP2qIcM0INaBDJQujBXX
X-Proofpoint-GUID: waOhee5QLwmUmKRNroRRD_vnoZRuF-OW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-04_06,2023-06-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 impostorscore=0 mlxscore=0 adultscore=0 mlxlogscore=999 suspectscore=0
 malwarescore=0 bulkscore=0 phishscore=0 priorityscore=1501 clxscore=1015
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2307040079
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> -----Original Message-----
> From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
> Sent: Sunday, July 2, 2023 6:04 PM
> To: Paller, Kim Seer <KimSeer.Paller@analog.com>
> Cc: jic23@kernel.org; lars@metafoo.de; lgirdwood@gmail.com;
> broonie@kernel.org; Hennerich, Michael <Michael.Hennerich@analog.com>;
> andy.shevchenko@gmail.com; robh@kernel.org;
> krzysztof.kozlowski@linaro.org; conor+dt@kernel.org; linux-
> iio@vger.kernel.org; linux-kernel@vger.kernel.org; devicetree@vger.kernel.org;
> kernel test robot <lkp@intel.com>
> Subject: Re: [PATCH v8 2/2] iio: adc: max14001: New driver
> 
> [External]
> 
> On Thu, 22 Jun 2023 22:32:27 +0800
> Kim Seer Paller <kimseer.paller@analog.com> wrote:
> 
> > The MAX14001 is configurable, isolated 10-bit ADCs for multi-range
> > binary inputs.
> >
> > Signed-off-by: Kim Seer Paller <kimseer.paller@analog.com>
> > Reported-by: kernel test robot <lkp@intel.com>
> > Closes:
> > https://urldefense.com/v3/__https://lore.kernel.org/oe-kbuild-all/2023
> > 06211545.7b6CdqsL-
> lkp@intel.com/__;!!A3Ni8CS0y2Y!4npD8X6TpKmeLcUf8QqQW
> >
> yEFp_Z1ORKb2dZNpuqfj0ZK74NiCYKQLNWEfKzVmuKTHJO0RW8n01vdXURqBvc
> ueb3V1Sb
> > GQdI$
> 
> Hi,
> 
> Two outstanding comments that I think I raised in earlier reviews..
> 
> Jonathan
> 
> > diff --git a/drivers/iio/adc/max14001.c b/drivers/iio/adc/max14001.c
> > new file mode 100644 index 000000000000..a21ebcde71fa
> > --- /dev/null
> > +++ b/drivers/iio/adc/max14001.c
> 
> ...
> 
> > +static int max14001_read(void *context, unsigned int reg_addr, unsigned int
> *data)
> > +{
> > +	struct max14001_state *st = context;
> > +	int ret;
> > +
> > +	struct spi_transfer xfers[] = {
> > +		{
> > +			.tx_buf = &st->spi_tx_buffer,
> > +			.len = sizeof(st->spi_tx_buffer),
> > +			.cs_change = 1,
> > +		}, {
> > +			.rx_buf = &st->spi_rx_buffer,
> > +			.len = sizeof(st->spi_rx_buffer),
> > +		},
> > +	};
> > +
> > +	/*
> > +	 * Convert transmit buffer to big-endian format and reverse transmit
> > +	 * buffer to align with the LSB-first input on SDI port.
> > +	 */
> > +	st->spi_tx_buffer =
> cpu_to_be16(bitrev16(FIELD_PREP(MAX14001_ADDR_MASK,
> > +								reg_addr)));
> > +
> > +	ret = spi_sync_transfer(st->spi, xfers, ARRAY_SIZE(xfers));
> > +	if (ret)
> > +		return ret;
> > +
> > +	/*
> > +	 * Align received data from the receive buffer, reversing and reordering
> > +	 * it to match the expected MSB-first format.
> > +	 */
> > +	*data = (__force u16)(be16_to_cpu(bitrev16(st->spi_rx_buffer))) &
> > +
> 	MAX14001_DATA_MASK;
> > +
> These sequences still confuse me a lot because I'd expect the values in tx
> to have the opposite operations applied to those for rx and that's not the
> case.
> 
> Let's take a le system.
> tx = cpu_to_be16(bitrev16(x))
>    = cpu_to_be16((__bitrev8(x & 0xff) << 8) | __bitrev8(x >> 8));
>    = __bitrev8(x & 0xff) | (__bitrev8(x >> 8) << 8)
> or swap all the bits in each byte, but don't swap the bytes.
> 
> rx = cpu_to_be16(bitrev16(x))
>    = be16_to_cpu(((__bitrev8(x & 0xff) << 8) | __bitrev8(x >> 8)_
>    = __bitrev8(x & 0xff) | __bitrev(x >> 8)
> 
> also swap all the bits in each byte, but don't swap the bytes.
> 
> So it is the reverse because the bytes swaps unwind themselves somewhat.
> For a be system cpu_to_be16 etc are noop.
> tx = (__bitrev8(x & 0xff) << 8) | __bitrev8(x >> 8)
> rx = (__bitrev8(x & 0xff) << 8) | __bitrev8(x >> 8)
> 
> So in this case swap all 16 bits.
> 
> Now, given I'd expected them to be reversed for the tx vs rx case.
> E.g.
> tx = cpu_to_be16(bitrev16(x))
> As above.
> For rx, le host
> rx = bitrev16(be16_to_cpu(x))
>    = __bitrev8((x >> 8) & 0xff) << 8) |  __bitrev8((((x & 0xff) << 8) >> 8)
> same as above (if you swap the two terms I think.
> 
> For be the be16_to_cpu is a noop again, so it's just bitrev16(x) as expected.
> 
> Hence if I've understood this correctly you could reverse the terms so that
> it was 'obvious' you were doing the opposite for the tx term vs the rx one
> without making the slightest bit of difference....
> 
> hmm. Might be worth doing simply to avoid questions.

Thank you for your feedback. I have tested the modifications based on your 
suggestions, taking the le system into account, and it appears that the code is 
functioning correctly. Before sending the new patch version, I would like to 
confirm if this aligns with your comments.

static int max14001_read(void *context, unsigned int reg_addr, unsigned int *data)
{
	struct max14001_state *st = context;
	int ret;

	struct spi_transfer xfers[] = {
		{
			.tx_buf = &st->spi_tx_buffer,
			.len = sizeof(st->spi_tx_buffer),
			.cs_change = 1,
		}, {
			.rx_buf = &st->spi_rx_buffer,
			.len = sizeof(st->spi_rx_buffer),
		},
	};

	st->spi_tx_buffer = cpu_to_be16(bitrev16(FIELD_PREP(MAX14001_ADDR_MASK, reg_addr)));

	ret = spi_sync_transfer(st->spi, xfers, ARRAY_SIZE(xfers));
	if (ret)
		return ret;

	*data = cpu_to_be16(bitrev16(st->spi_rx_buffer));

	return 0;
}

static int max14001_write(void *context, unsigned int reg_addr, unsigned int data)
{
	struct max14001_state *st = context;

	st->spi_tx_buffer = cpu_to_be16(bitrev16(
				FIELD_PREP(MAX14001_ADDR_MASK, reg_addr) |
				FIELD_PREP(MAX14001_SET_WRITE_BIT, 1) |
				FIELD_PREP(MAX14001_DATA_MASK, data)));

	return spi_write(st->spi, &st->spi_tx_buffer, sizeof(st->spi_tx_buffer));
}
 
> > +	return 0;
> > +}
> > +static int max14001_reg_update(struct max14001_state *st,
> > +				unsigned int reg_addr,
> > +				unsigned int mask,
> > +				unsigned int val)
> > +{
> > +	int ret;
> > +	unsigned int reg_data;
> > +
> > +	/* Enable SPI Registers Write */
> > +	ret = max14001_write(st, MAX14001_WEN, MAX14001_WRITE_WEN);
> > +	if (ret)
> > +		return ret;
> > +
> > +	ret = max14001_read(st, reg_addr, &reg_data);
> > +	if (ret)
> > +		return ret;
> > +
> > +	reg_data |= FIELD_PREP(mask, val);
> 
> This is still a problem if the compiler happens to fail to figure out
> that mask is a compile time constant.  Given it only ever takes one value
> I'd suggest either calling the FIELD_PREP at the caller, or just
> pushing all this code inline so that you can put the definition
> inline.

I would like to confirm including the 'static inline' keyword for the 
max14001_reg_update function.

> > +
> > +	ret = max14001_write(st, reg_addr, reg_data);
> > +	if (ret)
> > +		return ret;
> > +
> > +	/* Write Verification Register */
> > +	ret = max14001_write_verification_reg(st, reg_addr);
> > +	if (ret)
> > +		return ret;
> > +
> > +	/* Disable SPI Registers Write */
> > +	return max14001_write(st, MAX14001_WEN, 0);
> > +}
> 

Best Regards,
Kim Seer Paller

