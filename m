Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95D50725CE2
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 13:18:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239961AbjFGLSZ convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 7 Jun 2023 07:18:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240284AbjFGLSO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 07:18:14 -0400
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED93C1FEA;
        Wed,  7 Jun 2023 04:17:57 -0700 (PDT)
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3579wPgK008898;
        Wed, 7 Jun 2023 07:17:36 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 3r2a9dmu4p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 07 Jun 2023 07:17:36 -0400
Received: from m0167088.ppops.net (m0167088.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 357BHEDG022790;
        Wed, 7 Jun 2023 07:17:35 -0400
Received: from nwd2mta3.analog.com ([137.71.173.56])
        by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 3r2a9dmu4e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 07 Jun 2023 07:17:35 -0400
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
        by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 357BHYmN046634
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 7 Jun 2023 07:17:34 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.14; Wed, 7 Jun 2023
 07:17:33 -0400
Received: from ASHBMBX8.ad.analog.com ([fe80::30b9:230c:9621:902f]) by
 ASHBMBX8.ad.analog.com ([fe80::30b9:230c:9621:902f%9]) with mapi id
 15.02.0986.014; Wed, 7 Jun 2023 07:17:33 -0400
From:   "Paller, Kim Seer" <KimSeer.Paller@analog.com>
To:     Jonathan Cameron <Jonathan.Cameron@Huawei.com>
CC:     Jonathan Cameron <jic23@kernel.org>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "krzysztof.kozlowski@linaro.org" <krzysztof.kozlowski@linaro.org>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2 2/2] iio: adc: max14001: New driver
Thread-Topic: [PATCH v2 2/2] iio: adc: max14001: New driver
Thread-Index: AQHZl67Y+VuDoLqrgE+gZ2yoOVHpUq982k+AgAA5dsCAAMU+AIABVP+Q
Date:   Wed, 7 Jun 2023 11:17:33 +0000
Message-ID: <bdc11e51637e4249818be688e3cd7b59@analog.com>
References: <20230605130755.92642-1-kimseer.paller@analog.com>
        <20230605130755.92642-3-kimseer.paller@analog.com>
        <20230605202413.5eb0c0f3@jic23-huawei>
        <f62be66979db433eac86f32cc8587892@analog.com>
 <20230606113550.00003634@Huawei.com>
In-Reply-To: <20230606113550.00003634@Huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: =?us-ascii?Q?PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNca3BhbGxlcjJc?=
 =?us-ascii?Q?YXBwZGF0YVxyb2FtaW5nXDA5ZDg0OWI2LTMyZDMtNGE0MC04NWVlLTZiODRi?=
 =?us-ascii?Q?YTI5ZTM1Ylxtc2dzXG1zZy1lNDA5NjM4ZC0wNTI0LTExZWUtYWU3Yi1mOGNk?=
 =?us-ascii?Q?Yjg5MGJlNDdcYW1lLXRlc3RcZTQwOTYzOGYtMDUyNC0xMWVlLWFlN2ItZjhj?=
 =?us-ascii?Q?ZGI4OTBiZTQ3Ym9keS50eHQiIHN6PSI3MDI0IiB0PSIxMzMzMDYxMDI1MDc5?=
 =?us-ascii?Q?NjI5ODEiIGg9InVWaUt6R0prU0RBNzhHUEZ4VjE2L1FvZkdLWT0iIGlkPSIi?=
 =?us-ascii?Q?IGJsPSIwIiBibz0iMSIgY2k9ImNBQUFBRVJIVTFSU1JVRk5DZ1VBQUVvQ0FB?=
 =?us-ascii?Q?QmxBbUdtTVpuWkFZSGJsbDRLZzYzaGdkdVdYZ3FEcmVFREFBQUFBQUFBQUFB?=
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
x-originating-ip: [10.116.185.7]
x-adiruleop-newscl: Rule Triggered
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-Proofpoint-GUID: s54yFnXdL3v4SIg8fCDha6Go_9aI74qt
X-Proofpoint-ORIG-GUID: D4PDoTXc7nwNYboKWoSG1fSxoLfoqmBz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-07_06,2023-06-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 malwarescore=0
 priorityscore=1501 clxscore=1015 mlxscore=0 spamscore=0 lowpriorityscore=0
 phishscore=0 bulkscore=0 adultscore=0 impostorscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2305260000
 definitions=main-2306070092
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> -----Original Message-----
> From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
> Sent: Tuesday, June 6, 2023 6:36 PM
> To: Paller, Kim Seer <KimSeer.Paller@analog.com>
> Cc: Jonathan Cameron <jic23@kernel.org>; lars@metafoo.de;
> krzysztof.kozlowski@linaro.org; broonie@kernel.org; lgirdwood@gmail.com;
> linux-iio@vger.kernel.org; linux-kernel@vger.kernel.org
> Subject: Re: [PATCH v2 2/2] iio: adc: max14001: New driver
> 
> [External]
> 
> 
> 
> > >
> > > > +	struct mutex		lock;
> > > > +	struct regmap		*regmap;
> > > > +	int			vref_mv;
> > > > +	/*
> > > > +	 * DMA (thus cache coherency maintenance) requires the
> > > > +	 * transfer buffers to live in their own cache lines.
> > >
> > > You are looking at an old kernel I guess - we fixed all of these - and
> > > introduced IIO_DMA_MINALIGN for __aligned(IIO_DMA_MINALIGN) to
> > > make it easier to fix any such problems in future.
> > >
> > > Upshot is that ___cacheline_aligned aligns to the l1 cacheline length.
> > > Some fun systems (such as the big servers I use in my dayjob) have higher
> > > cacheline sizes for their larger / further from CPU caches.
> > > One group of SoCs out there is known to both do non coherent DMA and
> > > have a larger line size for the bit relevant to that than ___cacheline_aligned
> > > gives you. So on that rare platform this is currently broken.
> >
> > It's good to know. Given this information, is there anything specific that I
> > need to change in the code or implementation related to
> > the ___cacheline_aligned part?
> 
> Replace it with __aligned(IIO_DMA_MINALIGN) as has hopefully now been
> done
> in all upstream drivers.

When I attempted to implement this change, I encountered a checkpatch warning 
in the latest kernel version. The warning indicated that externs should be avoided 
in .c files and emphasized the need for an identifier name for the function 
definition argument 'IIO_DMA_MINALIGN'. I attempted to define a macro with an 
appropriate identifier name, but I still received the same checkpatch warning. 
It's possible that I may have overlooked something in my approach. I would 
appreciate your thoughts and insights on this matter. Thanks.

> 
> > >
> 
> > > > +}
> > > > +
> > > > +static int max14001_reg_update(struct max14001_state *st,
> > > > +				unsigned int reg_addr,
> > > > +				unsigned int mask,
> > > > +				unsigned int val)
> > > > +{
> > > > +	int ret;
> > > > +
> > > > +	/* Enable SPI Registers Write */
> > > > +	ret = max14001_write(st, MAX14001_WEN,
> > > MAX14001_WRITE_WEN);
> > >
> > > Mixing regmap and non regmap rather defeats the point of having a
> standard
> > > interface.  Use regmap_read and regmap_write throughout or not at all.
> >
> > I found it difficult to implement the regmap interface due to the timing
> diagram
> > requirements. The chip select needs to be changed between transfers, which,
> > as far as I know, does not work with regmap. Perhaps, I will consider sticking
> > to the non-regmap approach.
> 
> That may be sensible if there are odd requirements or just call regmap_write()
> which will call your max14001_write() anyway and opencode the timing
> requirements etc by multiple remap calls.  Obviously benefits of regmap
> reduced
> though so may not be worth bothering unless it is worth using the caching or
> similar.
> 
> Jonathan
> 
> 

