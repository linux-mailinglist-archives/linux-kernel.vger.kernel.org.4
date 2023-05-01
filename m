Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E01BE6F3357
	for <lists+linux-kernel@lfdr.de>; Mon,  1 May 2023 18:03:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232823AbjEAQDA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 May 2023 12:03:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232805AbjEAQC5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 May 2023 12:02:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 993EA1B3;
        Mon,  1 May 2023 09:02:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EEF6861DE1;
        Mon,  1 May 2023 16:02:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 521F4C433EF;
        Mon,  1 May 2023 16:02:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682956974;
        bh=rMUCnLZ9mRqYHwH8mqRSJhxDYUPWGMGPPxheRVOnYJk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=sqKaQgVVC02LztKrrC+R9KYAuoNOOqPigwCSNC1be4qiAh65apV+Ekh//HFHumMh6
         hE//qoUI/mBqVjb1HMV/CXZ2mG1vOJLUlXD8ImLqsRdOSVUS50XMmsvl0Quw2hiQya
         u//xAo+JA5xYIYSA6Z/D2Cj+Bh3Kzejhj1sCap43BLYWS6/GcbXO/wW2xIISWtDQSV
         npiFww8iNlFzNpNn7tHBphj8rUUC3jQODeYUsSY8csD1WdU4UbBYYRhzw0Nya6qKjC
         QBbuyrXzZvO8kc2GZhs5PC0ydyqrD85BYTLIfW3VmNGqDpUpG7G1kd8UI7rPrxIkzY
         cXBgRlTsAiv2w==
Date:   Mon, 1 May 2023 17:18:38 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Marijn Suijten <marijn.suijten@somainline.org>
Cc:     phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Martin Botka <martin.botka@somainline.org>,
        Jami Kettunen <jami.kettunen@somainline.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v4 5/5] dt-bindings: iio: adc: Require generic `channel`
 name for channel nodes
Message-ID: <20230501171838.461501b1@jic23-huawei>
In-Reply-To: <20230415174943.2b731203@jic23-huawei>
References: <20230410202917.247666-1-marijn.suijten@somainline.org>
        <20230410202917.247666-6-marijn.suijten@somainline.org>
        <20230412212756.0b4b69f3@jic23-huawei>
        <c653un4emxud34gpo5np7jtnhsym5thpivjwcgpm2vsft2q2qj@s66thxonibjc>
        <20230415174943.2b731203@jic23-huawei>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.37; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 15 Apr 2023 17:49:43 +0100
Jonathan Cameron <jic23@kernel.org> wrote:

> On Wed, 12 Apr 2023 22:31:46 +0200
> Marijn Suijten <marijn.suijten@somainline.org> wrote:
> 
> > On 2023-04-12 21:27:56, Jonathan Cameron wrote:  
> > > On Mon, 10 Apr 2023 22:29:17 +0200
> > > Marijn Suijten <marijn.suijten@somainline.org> wrote:
> > >     
> > > > As discussed in [1] it is more convenient to use a generic `channel`
> > > > node name for ADC channels while storing a friendly - board-specific
> > > > instead of PMIC-specific - name in the label, if/when desired to
> > > > overwrite the channel description already contained (but previously
> > > > unused) in the driver [2].
> > > > 
> > > > The same `channel` node name pattern has also been set in
> > > > iio/adc/adc.yaml, but this generic binding is not inherited as base for
> > > > qcom,spmi-vadc bindings due to not having any other generic elements in
> > > > common, besides the node name rule and reg property.
> > > > 
> > > > Replace the .* name pattern with the `channel` literal, but leave the
> > > > label property optional for bindings to choose to fall back a channel
> > > > label hardcoded in the driver [2] instead.
> > > > 
> > > > [1]: https://lore.kernel.org/linux-arm-msm/20221106193018.270106-1-marijn.suijten@somainline.org/T/#u
> > > > [2]: https://lore.kernel.org/linux-arm-msm/20230116220909.196926-4-marijn.suijten@somainline.org/
> > > > 
> > > > Signed-off-by: Marijn Suijten <marijn.suijten@somainline.org>    
> > > 
> > > There are various ways we could pick up this patch set...
> > > a) Binding changes via individual subsystem trees,
> > > b) All in on go.
> > > 
> > > I think it's late to guarantee to land the changes from (a) in the coming merge window
> > > so if someone else is willing to do (b) then
> > > 
> > > Acked-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > > 
> > > Otherwise we can do (a) early in next cycle.  Feel free to poke me if we are doing (b)
> > > and I seem to have forgotten to pick up this patch!    
> > 
> > Thanks!  I hope we don't get many conflicts (+ new bindings adhering to
> > the old(er) formats) otherwise I'll resend if we do (a).  Around what
> > time would be good, rc2?  
> 
> Sure. If rebase is needed send a v5 with that done.  If not, a simple
> reminder reply to this thread will probably work.

I've started queuing stuff for the next cycle as the relevant pull requests
are for the IIO tree for this cycle were picked up a few days ago.

Hence, applied to the togreg branch of iio.git and pushed out as testing for 0-day
to take a quick look at it.

Thanks,

Jonathan

> 
> Thanks,
> 
> Jonathan
> 
> > 
> > [..]
> > 
> > - Marijn  
> 

