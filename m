Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6D1D672124
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 16:24:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231386AbjARPYJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 10:24:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231332AbjARPXv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 10:23:51 -0500
Received: from relay05.th.seeweb.it (relay05.th.seeweb.it [5.144.164.166])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D626A1EFD5
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 07:21:25 -0800 (PST)
Received: from SoMainline.org (94-211-6-86.cable.dynamic.v4.ziggo.nl [94.211.6.86])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by m-r2.th.seeweb.it (Postfix) with ESMTPSA id BE9203F829;
        Wed, 18 Jan 2023 16:21:22 +0100 (CET)
Date:   Wed, 18 Jan 2023 16:21:21 +0100
From:   Marijn Suijten <marijn.suijten@somainline.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>,
        linux-arm-msm@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH v2 1/1] iio: adc: qcom-spmi-adc5: Fix the channel name
Message-ID: <20230118152121.blb74eplrqz5rww2@SoMainline.org>
References: <20230118100623.42255-1-andriy.shevchenko@linux.intel.com>
 <20230118123528.oaxtjbdier3ojd3m@SoMainline.org>
 <Y8fyonSp49QoAb8v@smile.fi.intel.com>
 <20230118140423.y4ogqdkyti7vcwaz@SoMainline.org>
 <Y8gCRECOja+FxRsf@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y8gCRECOja+FxRsf@smile.fi.intel.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-01-18 16:29:24, Andy Shevchenko wrote:
...
> The devm_kstrdup(fwnode_get_name()) is an open coded variant of the above.
> I don't think we need to open code and produce NIH even a single API. And
> no, there is no magic behind that. At least from the fwnode point of view.
> 
> You may very well say that > 1500 instances of "%pOF" is a magic...

Forgive me for not having a clear definition of "open coding" in mind
(showing a different way of implementing something, compared to the
"status quo" that I was not yet aware of?), nor knowing what NIH is
supposed to mean in this context.  We're in bike-shedding territory
anyway, guess I should just bookmark the page that details all the many
`%` format strings available.

...
> > I find the latter clearer as it doesn't require the reader to figure out
> > that name - name cancels itself out.  Alternatively we can write
> > strchrnul(name, '@')[0].
> 
> I don't like to have Pythonisms in the C code, really.
> 
> P.S. I guess this little patch already emptied my bandwidth, so I leave
> any further discussion to you and IIO maintainers. Thank you for the
> review!

Just soaking up kernel coding standards here :)

- Marijn
