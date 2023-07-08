Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8E9C74BDD0
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jul 2023 16:29:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230040AbjGHO3n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Jul 2023 10:29:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbjGHO3m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Jul 2023 10:29:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B1D2E56;
        Sat,  8 Jul 2023 07:29:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A0C8E60C22;
        Sat,  8 Jul 2023 14:29:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7483DC433C8;
        Sat,  8 Jul 2023 14:29:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688826580;
        bh=lRIo5x0eaBG/ux44ogzHUI7Uzv1haeHg5z1+mVOCog4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=fN6CauY2qOd+/3vlauXKncSmBmXRvK/HWvujm8xeEINp7/g34L2qjMDKh4Sb9XsrF
         F3UNOFqTffPRJnBENtN1qPKB2hcJ2ld7azEu8YE0fW+EaR5tBchrWcccYPOA+ofluR
         Hxs3rvYuCmj0wie1JLUqcIZo0lsXbedsbuSRWzYWwf17pBP4kXT1h23orsMOCbV5iu
         1IUoplssjLBtV0jmLJ+qYEYZhGSFJ9jzx32ohVAZ7zdp7KvTGCJtFJz/i5NvudLL9g
         /M5pyEWNZKoHw9sAgC4VNvXSH/tNNiI7KTpFeZ8ssJmgvmFr7d82US6INEdQ+rzCGK
         AKWvWDXH2zTqw==
Date:   Sat, 8 Jul 2023 15:29:31 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: adc: qcom-spmi-adc5: Add ADC5_GPIO2_100K_PU
Message-ID: <20230708152931.146c6944@jic23-huawei>
In-Reply-To: <e7c577c8-f42a-cdfa-3369-5a377f3914f1@linaro.org>
References: <20230627-topic-adc-v1-1-c61581abffa3@linaro.org>
        <e7c577c8-f42a-cdfa-3369-5a377f3914f1@linaro.org>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 27 Jun 2023 03:08:20 +0300
Dmitry Baryshkov <dmitry.baryshkov@linaro.org> wrote:

> On 27/06/2023 02:21, Konrad Dybcio wrote:
> > Even though it existed in bindings for the longest time,
> > ADC5_GPIO2_100K_PU was never assigned in the driver. Do so.
> > 
> > Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> > ---
> >   drivers/iio/adc/qcom-spmi-adc5.c | 2 ++
> >   1 file changed, 2 insertions(+)
> >   
> 
> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> 
I was a little unsure on this one. So far I've applied it as a 'feature'
so it's in the normal iio togreg branch, but perhaps it should be a fix?

For now applied to the togreg branch of iio.git but given I'll be rebasing
that on rc1, for now it's only visible as testing.  0-day can play with that
in the meantime and see if it can find any issues

Jonathan


