Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6A9772E54D
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 16:10:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242710AbjFMOJm convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 13 Jun 2023 10:09:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242760AbjFMOJg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 10:09:36 -0400
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3F58171D;
        Tue, 13 Jun 2023 07:09:10 -0700 (PDT)
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35DDKQVF013107;
        Tue, 13 Jun 2023 10:08:23 -0400
Received: from nwd2mta4.analog.com ([137.71.173.58])
        by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 3r4p351dqr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 13 Jun 2023 10:08:17 -0400
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
        by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 35DE7eIM009159
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 13 Jun 2023 10:07:40 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.14; Tue, 13 Jun
 2023 10:07:39 -0400
Received: from ASHBMBX8.ad.analog.com ([fe80::30b9:230c:9621:902f]) by
 ASHBMBX8.ad.analog.com ([fe80::30b9:230c:9621:902f%9]) with mapi id
 15.02.0986.014; Tue, 13 Jun 2023 10:07:39 -0400
From:   "Paller, Kim Seer" <KimSeer.Paller@analog.com>
To:     Rob Herring <robh@kernel.org>
CC:     "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski@linaro.org>,
        "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "andy.shevchenko@gmail.com" <andy.shevchenko@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "conor+dt@kernel.org" <conor+dt@kernel.org>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "jic23@kernel.org" <jic23@kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: RE: [PATCH v5 1/2] dt-bindings: iio: adc: add max14001
Thread-Topic: [PATCH v5 1/2] dt-bindings: iio: adc: add max14001
Thread-Index: AQHZndo3coUyYXBv2Eq2tUVubImF6a+IyEuA///7LzA=
Date:   Tue, 13 Jun 2023 14:07:39 +0000
Message-ID: <8998c3d3f3ca4f44a5c99594dcb24cbe@analog.com>
References: <20230613093346.60781-1-kimseer.paller@analog.com>
 <168665154072.1311520.12958978545814613109.robh@kernel.org>
In-Reply-To: <168665154072.1311520.12958978545814613109.robh@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: =?us-ascii?Q?PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNca3BhbGxlcjJc?=
 =?us-ascii?Q?YXBwZGF0YVxyb2FtaW5nXDA5ZDg0OWI2LTMyZDMtNGE0MC04NWVlLTZiODRi?=
 =?us-ascii?Q?YTI5ZTM1Ylxtc2dzXG1zZy1hNTkzZTI2Yi0wOWYzLTExZWUtYWU3ZC1mOGNi?=
 =?us-ascii?Q?Njc0OWVhN2JcYW1lLXRlc3RcYTU5M2UyNmQtMDlmMy0xMWVlLWFlN2QtZjhj?=
 =?us-ascii?Q?YjY3NDllYTdiYm9keS50eHQiIHN6PSI1MTQ0IiB0PSIxMzMzMTEzODg1NjQ5?=
 =?us-ascii?Q?MzQ3OTgiIGg9ImJMb29YTXVtSlJZb0VSeklqUUM1TXY0ZitIaz0iIGlkPSIi?=
 =?us-ascii?Q?IGJsPSIwIiBibz0iMSIgY2k9ImNBQUFBRVJIVTFSU1JVRk5DZ1VBQUVvQ0FB?=
 =?us-ascii?Q?Q09VTzFuQUo3WkFUMVlWYldwUER1dFBWaFZ0YWs4TzYwREFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFIQUFBQURhQVFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFFQUFRQUJBQUFBUjZsVExBQUFBQUFBQUFBQUFBQUFBSjRBQUFCaEFHUUFh?=
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
X-Proofpoint-GUID: Xwf0LSjlfOPZiiSN3aacIDFlteynL5h1
X-Proofpoint-ORIG-GUID: Xwf0LSjlfOPZiiSN3aacIDFlteynL5h1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-13_04,2023-06-12_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 priorityscore=1501 suspectscore=0 spamscore=0 clxscore=1015
 impostorscore=0 lowpriorityscore=0 phishscore=0 mlxlogscore=999
 bulkscore=0 mlxscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2305260000 definitions=main-2306130124
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> -----Original Message-----
> From: Rob Herring <robh@kernel.org>
> Sent: Tuesday, June 13, 2023 6:19 PM
> To: Paller, Kim Seer <KimSeer.Paller@analog.com>
> Cc: devicetree@vger.kernel.org; Krzysztof Kozlowski
> <krzysztof.kozlowski@linaro.org>; lgirdwood@gmail.com; broonie@kernel.org;
> andy.shevchenko@gmail.com; linux-kernel@vger.kernel.org;
> conor+dt@kernel.org; Hennerich, Michael <Michael.Hennerich@analog.com>;
> robh+dt@kernel.org; krzysztof.kozlowski+dt@linaro.org; lars@metafoo.de;
> jic23@kernel.org; linux-iio@vger.kernel.org
> Subject: Re: [PATCH v5 1/2] dt-bindings: iio: adc: add max14001
> 
> [External]
> 
> 
> On Tue, 13 Jun 2023 17:33:45 +0800, Kim Seer Paller wrote:
> > The MAX14001 is a configurable, isolated 10-bit ADC for multi-range
> > binary inputs.
> >
> > Signed-off-by: Kim Seer Paller <kimseer.paller@analog.com>
> > Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> > Reported-by: Rob Herring <robh@kernel.org>
> > Closes:
> > https://urldefense.com/v3/__https://lore.kernel.org/all/168663709022.6
> >
> 52608.11756645774505315189.robh@kernel.org/__;!!A3Ni8CS0y2Y!5MOlRh
> mYJL
> >
> qPmhR7QmgutQNBKIuJTk_FlMbFGnFd4R9dVxnXWk8rY0woqzhv5YcF58DvBLTrc
> xVK5KdS
> > $
> > ---
> > V3 -> V5: Added spaces between prefixes in subject. Fixed MAINTAINERS
> reference.
> >
> >  .../bindings/iio/adc/adi,max14001.yaml        | 54 +++++++++++++++++++
> >  MAINTAINERS                                   |  7 +++
> >  2 files changed, 61 insertions(+)
> >  create mode 100644
> > Documentation/devicetree/bindings/iio/adc/adi,max14001.yaml
> >
> 
> My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
> on your patch (DT_CHECKER_FLAGS is new in v5.13):
> 
> yamllint warnings/errors:
> 
> dtschema/dtc warnings/errors:
> /builds/robherring/dt-review-
> ci/linux/Documentation/devicetree/bindings/pinctrl/qcom,pmic-mpp.yaml:
> $defs:qcom-pmic-mpp-state:properties:qcom,paired: [{'description': 'Indicates
> that the pin should be operating in paired mode.'}] is not of type 'object',
> 'boolean'
> 	from schema $id:
> https://urldefense.com/v3/__http://devicetree.org/meta-
> schemas/core.yaml*__;Iw!!A3Ni8CS0y2Y!5MOlRhmYJLqPmhR7QmgutQNBKIuJ
> Tk_FlMbFGnFd4R9dVxnXWk8rY0woqzhv5YcF58DvBLTrc0FLIB-v$
> 
> doc reference errors (make refcheckdocs):

Could the doc reference error also be ignored? I cannot reproduce the same error on my side.

Best regards,
Kim

