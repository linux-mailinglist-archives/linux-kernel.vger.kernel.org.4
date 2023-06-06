Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A58697235D3
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 05:40:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231258AbjFFDkH convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 5 Jun 2023 23:40:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233863AbjFFDkD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 23:40:03 -0400
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E33CC11D;
        Mon,  5 Jun 2023 20:40:01 -0700 (PDT)
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3561U8aT025628;
        Mon, 5 Jun 2023 23:39:46 -0400
Received: from nwd2mta4.analog.com ([137.71.173.58])
        by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 3r02e4eddh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 05 Jun 2023 23:39:45 -0400
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
        by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 3563diac057394
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 5 Jun 2023 23:39:44 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.14; Mon, 5 Jun 2023
 23:39:43 -0400
Received: from ASHBMBX8.ad.analog.com ([fe80::30b9:230c:9621:902f]) by
 ASHBMBX8.ad.analog.com ([fe80::30b9:230c:9621:902f%9]) with mapi id
 15.02.0986.014; Mon, 5 Jun 2023 23:39:43 -0400
From:   "Paller, Kim Seer" <KimSeer.Paller@analog.com>
To:     "andy.shevchenko@gmail.com" <andy.shevchenko@gmail.com>
CC:     "jic23@kernel.org" <jic23@kernel.org>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "krzysztof.kozlowski@linaro.org" <krzysztof.kozlowski@linaro.org>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2 2/2] iio: adc: max14001: New driver
Thread-Topic: [PATCH v2 2/2] iio: adc: max14001: New driver
Thread-Index: AQHZl67Y+VuDoLqrgE+gZ2yoOVHpUq99NPAA///oTSA=
Date:   Tue, 6 Jun 2023 03:39:43 +0000
Message-ID: <a38229ec97934d2fa0c5ab85c8edd325@analog.com>
References: <20230605130755.92642-1-kimseer.paller@analog.com>
 <20230605130755.92642-3-kimseer.paller@analog.com>
 <ZH6CZJCBTXrsUErm@surfacebook>
In-Reply-To: <ZH6CZJCBTXrsUErm@surfacebook>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: =?us-ascii?Q?PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNca3BhbGxlcjJc?=
 =?us-ascii?Q?YXBwZGF0YVxyb2FtaW5nXDA5ZDg0OWI2LTMyZDMtNGE0MC04NWVlLTZiODRi?=
 =?us-ascii?Q?YTI5ZTM1Ylxtc2dzXG1zZy1jNGNkYTM1Ny0wNDFiLTExZWUtYWU3Yi1mOGNk?=
 =?us-ascii?Q?Yjg5MGJlNDdcYW1lLXRlc3RcYzRjZGEzNTktMDQxYi0xMWVlLWFlN2ItZjhj?=
 =?us-ascii?Q?ZGI4OTBiZTQ3Ym9keS50eHQiIHN6PSI3MTYyIiB0PSIxMzMzMDQ5NjM4MTc2?=
 =?us-ascii?Q?NjcxODciIGg9IjEzNnQ0bGp0NExWbGgwT1JBcnprUElHM1NzZz0iIGlkPSIi?=
 =?us-ascii?Q?IGJsPSIwIiBibz0iMSIgY2k9ImNBQUFBRVJIVTFSU1JVRk5DZ1VBQUVvQ0FB?=
 =?us-ascii?Q?QnoraVdIS0pqWkFZbTlpWFRydHV6NmliMkpkT3UyN1BvREFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFIQUFBQURhQVFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFFQUFRQUJBQUFBU2pFWHh3QUFBQUFBQUFBQUFBQUFBSjRBQUFCaEFHUUFh?=
 =?us-ascii?Q?UUJmQUhNQVpRQmpBSFVBY2dCbEFGOEFjQUJ5QUc4QWFnQmxBR01BZEFCekFG?=
 =?us-ascii?Q?OEFaZ0JoQUd3QWN3QmxBRjhBWmdCdkFITUFhUUIwQUdrQWRnQmxBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUVBQUFBQUFBQUFBZ0FBQUFBQW5nQUFBR0VBWkFCcEFGOEFjd0JsQUdNQWRR?=
 =?us-ascii?Q?QnlBR1VBWHdCd0FISUFid0JxQUdVQVl3QjBBSE1BWHdCMEFHa0FaUUJ5QURF?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFRQUFBQUFBQUFBQ0FB?=
 =?us-ascii?Q?QUFBQUNlQUFBQVlRQmtBR2tBWHdCekFHVUFZd0IxQUhJQVpRQmZBSEFBY2dC?=
 =?us-ascii?Q?dkFHb0FaUUJqQUhRQWN3QmZBSFFBYVFCbEFISUFNZ0FBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFCQUFBQUFBQUFBQUlBQUFBQUFBPT0iLz48L21l?=
 =?us-ascii?Q?dGE+?=
x-dg-rorf: true
x-originating-ip: [10.116.242.24]
x-adiruleop-newscl: Rule Triggered
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-Proofpoint-ORIG-GUID: sYOn1QDTncZRPlNhYdXtDSWei8qFZv_G
X-Proofpoint-GUID: sYOn1QDTncZRPlNhYdXtDSWei8qFZv_G
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-06_01,2023-06-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 mlxlogscore=999
 adultscore=0 impostorscore=0 spamscore=0 priorityscore=1501 bulkscore=0
 lowpriorityscore=0 clxscore=1011 phishscore=0 malwarescore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2306060032
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> -----Original Message-----
> From: andy.shevchenko@gmail.com <andy.shevchenko@gmail.com>
> Sent: Tuesday, June 6, 2023 8:49 AM
> To: Paller, Kim Seer <KimSeer.Paller@analog.com>
> Cc: jic23@kernel.org; lars@metafoo.de; krzysztof.kozlowski@linaro.org;
> broonie@kernel.org; lgirdwood@gmail.com; linux-iio@vger.kernel.org; linux-
> kernel@vger.kernel.org
> Subject: Re: [PATCH v2 2/2] iio: adc: max14001: New driver
> 
> [External]
> 
> Mon, Jun 05, 2023 at 09:07:55PM +0800, Kim Seer Paller kirjoitti:
> > The MAX14001 is configurable, isolated 10-bit ADCs for multi-range
> > binary inputs.
> 
> First question, why don't you use regmap SPI?

I found it difficult to implement the regmap interface due to the timing diagram 
requirements. The chip select needs to be changed between transfers, which, as 
far as I know, does not work with regmap. Additionally, the regmap_config 
parameters, specifically reg_bits and val_bits, cannot be set to specific values. 
This limitation makes it challenging to accommodate specific configurations 
such as using 5 bits for register address and 10 bits for data.

> 
> ...
> 
> > +static int max14001_read(void *context, unsigned int reg_addr,
> > +					unsigned int *data)
> 
> Strange indentation.
> 
> > +{
> > +	struct max14001_state *st = context;
> > +	u16 tx = 0;
> 
> Redundant assignment.
> 
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
> 
> > +	st->spi_tx_buffer = bitrev16(cpu_to_be16(tx));
> 
> This is strange. Why this monsteur construct with bitrev16() is used?
> 
> According to the datasheet, the bit stream is LE16, where 10 LSB is data,
> 5 MSB is address and bit 11 is R/W.

I discovered that following the instructions in the application note made 
the implementation much easier. 
https://www.analog.com/media/en/technical-documentation/user-guides/guide-to-programming-the-max14001max14002-isolated-adcs--maxim-integrated.pdf

To ensure compatibility with the device, I changed the format to big 
endian and reversed the data before sending it to the device. 
This is why I used the "bitrev" function. I'm happy to report that 
this approach worked perfectly.

> 
> > +	ret = spi_sync_transfer(st->spi, xfers, ARRAY_SIZE(xfers));
> > +	if (ret)
> > +		return ret;
> 
> > +	*data = bitrev16(be16_to_cpu(st->spi_rx_buffer)) &
> > +MAX14001_DATA_MASK;
> 
> Ditto.
> 
> > +	return 0;
> > +}
> 
> > +static int max14001_write(void *context, unsigned int reg_addr,
> > +					unsigned int data)
> > +{
> > +	struct max14001_state *st = context;
> > +	u16 tx = 0;
> 
> Redundant assignment.
> 
> > +	tx = FIELD_PREP(MAX14001_ADDR_MASK, reg_addr);
> > +	tx |= FIELD_PREP(MAX14001_SET_WRITE_BIT, 1);
> > +	tx |= FIELD_PREP(MAX14001_DATA_MASK, data);
> > +
> > +	st->spi_tx_buffer = bitrev16(cpu_to_be16(tx));
> > +
> > +	return spi_write(st->spi, &st->spi_tx_buffer, 2);
> 
> sizeof() ?
> 
> > +}
> 
> ...
> 
> > +			return dev_err_probe(&spi->dev, PTR_ERR(vref),
> > +					     "Failed to get vref regulator");
> 
> With
> 
> 	struct device *dev = &spi->dev;
> 
> this and other calls in this function can be made neater.
> 
> --
> With Best Regards,
> Andy Shevchenko
> 

