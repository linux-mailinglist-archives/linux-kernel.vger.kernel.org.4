Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30E6E6E328C
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Apr 2023 18:49:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229894AbjDOQts (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Apr 2023 12:49:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbjDOQtq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Apr 2023 12:49:46 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52245E1;
        Sat, 15 Apr 2023 09:49:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E14D86118B;
        Sat, 15 Apr 2023 16:49:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22A85C433EF;
        Sat, 15 Apr 2023 16:49:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681577384;
        bh=HzfT7C9pxZUKfBOzD0bn0wIBd5ovSSU49etyxQMRn4s=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=aBYgLqucsTTarCKTBL3wdnwg6i8sqBa804UW2EET+CKcXHntwF3129XIKFpOEhB74
         5bj5xri8We8v9A+D08305ckbNN91Rtfm/Gr4W4awR6XD0C8iqS7/HvhON+nfc80uYB
         Y9ykEn/YDDdsiwALjAy4XMLfafRnUV6reZ8hliEb1BeCr7M+sHsS4C2R6Yf+jpOGVX
         1AcI3IbBksAxbLurcRqzVEeLm0z9G7JHmwE5q536S1/xasJpntZaTWZKzEnDRR4EVC
         YjIrBDvqauhSg5VPr2ahuQM9ByvNSG34ccFZMG+Ts6vgDM34WH4eXx29T5ZTT9jOVk
         XRmheW/YpuW5A==
Date:   Sat, 15 Apr 2023 17:49:43 +0100
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
Message-ID: <20230415174943.2b731203@jic23-huawei>
In-Reply-To: <c653un4emxud34gpo5np7jtnhsym5thpivjwcgpm2vsft2q2qj@s66thxonibjc>
References: <20230410202917.247666-1-marijn.suijten@somainline.org>
        <20230410202917.247666-6-marijn.suijten@somainline.org>
        <20230412212756.0b4b69f3@jic23-huawei>
        <c653un4emxud34gpo5np7jtnhsym5thpivjwcgpm2vsft2q2qj@s66thxonibjc>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.37; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 12 Apr 2023 22:31:46 +0200
Marijn Suijten <marijn.suijten@somainline.org> wrote:

> On 2023-04-12 21:27:56, Jonathan Cameron wrote:
> > On Mon, 10 Apr 2023 22:29:17 +0200
> > Marijn Suijten <marijn.suijten@somainline.org> wrote:
> >   
> > > As discussed in [1] it is more convenient to use a generic `channel`
> > > node name for ADC channels while storing a friendly - board-specific
> > > instead of PMIC-specific - name in the label, if/when desired to
> > > overwrite the channel description already contained (but previously
> > > unused) in the driver [2].
> > > 
> > > The same `channel` node name pattern has also been set in
> > > iio/adc/adc.yaml, but this generic binding is not inherited as base for
> > > qcom,spmi-vadc bindings due to not having any other generic elements in
> > > common, besides the node name rule and reg property.
> > > 
> > > Replace the .* name pattern with the `channel` literal, but leave the
> > > label property optional for bindings to choose to fall back a channel
> > > label hardcoded in the driver [2] instead.
> > > 
> > > [1]: https://lore.kernel.org/linux-arm-msm/20221106193018.270106-1-marijn.suijten@somainline.org/T/#u
> > > [2]: https://lore.kernel.org/linux-arm-msm/20230116220909.196926-4-marijn.suijten@somainline.org/
> > > 
> > > Signed-off-by: Marijn Suijten <marijn.suijten@somainline.org>  
> > 
> > There are various ways we could pick up this patch set...
> > a) Binding changes via individual subsystem trees,
> > b) All in on go.
> > 
> > I think it's late to guarantee to land the changes from (a) in the coming merge window
> > so if someone else is willing to do (b) then
> > 
> > Acked-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > 
> > Otherwise we can do (a) early in next cycle.  Feel free to poke me if we are doing (b)
> > and I seem to have forgotten to pick up this patch!  
> 
> Thanks!  I hope we don't get many conflicts (+ new bindings adhering to
> the old(er) formats) otherwise I'll resend if we do (a).  Around what
> time would be good, rc2?

Sure. If rebase is needed send a v5 with that done.  If not, a simple
reminder reply to this thread will probably work.

Thanks,

Jonathan

> 
> [..]
> 
> - Marijn

