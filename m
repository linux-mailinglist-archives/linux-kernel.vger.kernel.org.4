Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBDBC6281AD
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 14:52:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236427AbiKNNws convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 14 Nov 2022 08:52:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235984AbiKNNwq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 08:52:46 -0500
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 409DF22BE0;
        Mon, 14 Nov 2022 05:52:45 -0800 (PST)
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2AECVxM9008761;
        Mon, 14 Nov 2022 08:52:29 -0500
Received: from nwd2mta3.analog.com ([137.71.173.56])
        by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 3ku76yn5j1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 14 Nov 2022 08:52:29 -0500
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
        by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 2AEDqSPE025093
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 14 Nov 2022 08:52:28 -0500
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.14; Mon, 14 Nov
 2022 08:52:27 -0500
Received: from ASHBMBX9.ad.analog.com ([fe80::c1f2:f121:22ef:29db]) by
 ASHBMBX9.ad.analog.com ([fe80::c1f2:f121:22ef:29db%20]) with mapi id
 15.02.0986.014; Mon, 14 Nov 2022 08:52:27 -0500
From:   "Tanislav, Cosmin" <Cosmin.Tanislav@analog.com>
To:     Jonathan Cameron <jic23@kernel.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
CC:     Lars-Peter Clausen <lars@metafoo.de>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 5/5] iio: addac: ad74413r: add support for reset-gpio
Thread-Topic: [PATCH 5/5] iio: addac: ad74413r: add support for reset-gpio
Thread-Index: AQHY9reALFIOJ45fGkOdEYqpsVzwNK4+cXWA
Date:   Mon, 14 Nov 2022 13:52:26 +0000
Message-ID: <095a454b55cf497392a621649f24e067@analog.com>
References: <20221111143921.742194-1-linux@rasmusvillemoes.dk>
        <20221111143921.742194-6-linux@rasmusvillemoes.dk>
 <20221112170705.7efe1673@jic23-huawei>
In-Reply-To: <20221112170705.7efe1673@jic23-huawei>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: =?us-ascii?Q?PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcY3RhbmlzbGFc?=
 =?us-ascii?Q?YXBwZGF0YVxyb2FtaW5nXDA5ZDg0OWI2LTMyZDMtNGE0MC04NWVlLTZiODRi?=
 =?us-ascii?Q?YTI5ZTM1Ylxtc2dzXG1zZy05MWM0YmM1MS02NDIzLTExZWQtYjcyNy00MTU2?=
 =?us-ascii?Q?NDUwMDAwMzBcYW1lLXRlc3RcOTFjNGJjNTMtNjQyMy0xMWVkLWI3MjctNDE1?=
 =?us-ascii?Q?NjQ1MDAwMDMwYm9keS50eHQiIHN6PSIzNjE4IiB0PSIxMzMxMjkwNzU0NjEw?=
 =?us-ascii?Q?MjE5OTYiIGg9Iit2VXNrVTRXNWo4aHF5MVVrZ1hCL3F4TWVnMD0iIGlkPSIi?=
 =?us-ascii?Q?IGJsPSIwIiBibz0iMSIgY2k9ImNBQUFBRVJIVTFSU1JVRk5DZ1VBQUVvQ0FB?=
 =?us-ascii?Q?QXNZU0ZVTVBqWUFjc3d6Q2l3WGltMXl6RE1LTEJlS2JVREFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFIQUFBQURhQVFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFFQUFRQUJBQUFBSnJqSklRQUFBQUFBQUFBQUFBQUFBSjRBQUFCaEFHUUFh?=
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
x-originating-ip: [10.32.224.42]
x-adiruleop-newscl: Rule Triggered
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-Proofpoint-GUID: qir8QAEG-MWFkEc3ZemqDaFniSX2X3dx
X-Proofpoint-ORIG-GUID: qir8QAEG-MWFkEc3ZemqDaFniSX2X3dx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-14_12,2022-11-11_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 clxscore=1011 phishscore=0 bulkscore=0 lowpriorityscore=0
 mlxlogscore=999 suspectscore=0 mlxscore=0 spamscore=0 impostorscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2211140098
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Jonathan Cameron <jic23@kernel.org>
> Sent: Saturday, November 12, 2022 7:07 PM
> To: Rasmus Villemoes <linux@rasmusvillemoes.dk>
> Cc: Tanislav, Cosmin <Cosmin.Tanislav@analog.com>; Lars-Peter Clausen
> <lars@metafoo.de>; Hennerich, Michael <Michael.Hennerich@analog.com>;
> devicetree@vger.kernel.org; Rob Herring <robh+dt@kernel.org>; linux-
> iio@vger.kernel.org; linux-kernel@vger.kernel.org
> Subject: Re: [PATCH 5/5] iio: addac: ad74413r: add support for reset-gpio
> 
> [External]
> 
> On Fri, 11 Nov 2022 15:39:21 +0100
> Rasmus Villemoes <linux@rasmusvillemoes.dk> wrote:
> 
> > We have a board where the reset pin of the ad74412 is connected to a
> > gpio, but also pulled low by default. Hence to get the chip out of
> > reset, the driver needs to know about that gpio and set it high before
> > attempting to communicate with it.
> 
> I'm a little confused on polarity here.  The pin is a !reset so
> we need to drive it low briefly to trigger a reset.
> I'm guessing for your board the pin is set to active low? (an example
> in the dt would have made that clearer) Hence the pulse
> in here to 1 is actually briefly driving it low before restoring to high?
> 
> For a pin documented as !reset that seems backwards though you have
> called it reset so that is fine, but this description doesn't make that
> celar.

My opinion is that the driver shouldn't exactly know the polarity of the reset,
and just assume that setting the reset GPIO to 1 means putting it in reset,
and setting it to 0 means bringing out of reset.

> 
> Perhaps just add some more description here to make it clear the GPIO
> is active low, and then refer to setting it to true and false to avoid
> the confusing high / low terminology which are inverted...
> 
> >
> > When a reset-gpio is given in device tree, use that instead of the
> > software reset. According to the data sheet, the two methods are
> > functionally equivalent.
> >
> > Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
> > ---
> >  drivers/iio/addac/ad74413r.c | 12 ++++++++++++
> >  1 file changed, 12 insertions(+)
> >
> > diff --git a/drivers/iio/addac/ad74413r.c b/drivers/iio/addac/ad74413r.c
> > index 9f77d2f514de..af09d43f921c 100644
> > --- a/drivers/iio/addac/ad74413r.c
> > +++ b/drivers/iio/addac/ad74413r.c
> > @@ -71,6 +71,7 @@ struct ad74413r_state {
> >  	struct regmap			*regmap;
> >  	struct device			*dev;
> >  	struct iio_trigger		*trig;
> > +	struct gpio_desc		*reset_gpio;
> >
> >  	size_t			adc_active_channels;
> >  	struct spi_message	adc_samples_msg;
> > @@ -393,6 +394,13 @@ static int ad74413r_reset(struct ad74413r_state
> *st)
> >  {
> >  	int ret;
> >
> > +	if (st->reset_gpio) {
> > +		gpiod_set_value_cansleep(st->reset_gpio, 1);
> > +		fsleep(50);
> > +		gpiod_set_value_cansleep(st->reset_gpio, 0);
> > +		return 0;
> > +	}
> > +
> >  	ret = regmap_write(st->regmap, AD74413R_REG_CMD_KEY,
> >  			   AD74413R_CMD_KEY_RESET1);
> >  	if (ret)
> > @@ -1316,6 +1324,10 @@ static int ad74413r_probe(struct spi_device *spi)
> >  	if (IS_ERR(st->regmap))
> >  		return PTR_ERR(st->regmap);
> >
> > +	st->reset_gpio = devm_gpiod_get_optional(st->dev, "reset",
> GPIOD_OUT_LOW);
> > +	if (IS_ERR(st->reset_gpio))
> > +		return PTR_ERR(st->reset_gpio);
> > +
> >  	st->refin_reg = devm_regulator_get_optional(st->dev, "refin");
> >  	if (IS_ERR(st->refin_reg)) {
> >  		ret = PTR_ERR(st->refin_reg);

