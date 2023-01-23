Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D477D678272
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 18:01:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232256AbjAWRB2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 12:01:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230109AbjAWRB0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 12:01:26 -0500
Received: from m-r2.th.seeweb.it (m-r2.th.seeweb.it [5.144.164.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEDA6C0;
        Mon, 23 Jan 2023 09:01:24 -0800 (PST)
Received: from SoMainline.org (unknown [89.205.227.59])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by m-r2.th.seeweb.it (Postfix) with ESMTPSA id 46BB840B25;
        Mon, 23 Jan 2023 18:01:20 +0100 (CET)
Date:   Mon, 23 Jan 2023 18:01:18 +0100
From:   Marijn Suijten <marijn.suijten@somainline.org>
To:     Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>,
        linux-arm-msm@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Douglas Anderson <dianders@chromium.org>
Subject: Re: [PATCH v2 1/1] iio: adc: qcom-spmi-adc5: Fix the channel name
Message-ID: <20230123170118.2q5b5rmmkyoi7zpk@SoMainline.org>
References: <20230118100623.42255-1-andriy.shevchenko@linux.intel.com>
 <20230122172441.4f8d75f5@jic23-huawei>
 <22fa80f5-0cf0-85bd-03a4-e1eb80272420@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <22fa80f5-0cf0-85bd-03a4-e1eb80272420@linaro.org>
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-01-23 17:35:34, Konrad Dybcio wrote:
> On 22.01.2023 18:24, Jonathan Cameron wrote:
> > On Wed, 18 Jan 2023 12:06:23 +0200
> > Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:
> > 
> >> The node name can contain an address part which is unused
> >> by the driver. Moreover, this string is propagated into
> >> the userspace label, sysfs filenames *and breaking ABI*.
> >>
> >> Cut the address part out before assigning the channel name.
> >>
> >> Fixes: 4f47a236a23d ("iio: adc: qcom-spmi-adc5: convert to device properties")
> >> Reported-by: Marijn Suijten <marijn.suijten@somainline.org>
> >> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > 
> > LGTM, but given it will have ABI impact, I'd like to hear from 
> > Andy, Bjorn or Konrad as maintainers and /or Dmitry as someone
> > who has touched this driver fairly recently.
> + Doug
> 
> Unless the Chromium folks relied on the old names (they're the
> only ones I can think of that actually could have tapped into
> this), I say green light!

Can you clarify "old names"?  The ABI-broken ones after Nuno's patch
with @xx suffix, or the orignal names (without @xx) before that, which
this patch from Andy reverts back to?

- Marijn
