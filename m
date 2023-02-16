Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC476699DC3
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 21:32:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229709AbjBPUck (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 15:32:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229653AbjBPUcj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 15:32:39 -0500
Received: from mailrelay3-1.pub.mailoutpod2-cph3.one.com (mailrelay3-1.pub.mailoutpod2-cph3.one.com [IPv6:2a02:2350:5:402::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3FFB196A9
        for <linux-kernel@vger.kernel.org>; Thu, 16 Feb 2023 12:32:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ravnborg.org; s=rsa2;
        h=in-reply-to:content-type:mime-version:references:message-id:subject:cc:to:
         from:date:from;
        bh=RwVo/ALcWIpGinZ1s9D75KZF+KPdKYR8FBxJdE2XfKk=;
        b=sU3kJzbeVFnT7Bi/tJrQIZDCfHjs/ACWr5eOtR1wuHwVP4vg9mBPCrz+oUxO7UwYCuoz9wOqDgOzP
         E6eE5ywF2lp0nPjZKvnYZFAXURdhz6fMIvBRYtlevw+PO6CnFsv6B8ANF12DV1LctdFYw7bzednVLD
         BvNQAuo5/CSMVApVVXe+cliHYTgbS74e1d1QLmkSNayCeOwadx0IDoq+7paIiPeoFv1GuvxUGbXOoa
         zZhEJ+tdZ0gZ1KP2lFeuLvuUL3TKzsqwhXFO/CSj/H1HKwq7dteUjWcRnMYTPUO7GXIW5iIv2+4EFS
         gAQx7AygFqPhHbJ/4CoAE4QmLB4+9mA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed;
        d=ravnborg.org; s=ed2;
        h=in-reply-to:content-type:mime-version:references:message-id:subject:cc:to:
         from:date:from;
        bh=RwVo/ALcWIpGinZ1s9D75KZF+KPdKYR8FBxJdE2XfKk=;
        b=pBKQRnGVJo45A/dO+VtmP6xrEVE31OJL10zrQFlkfQE9ivyYcu+FsRzv0R+goBoVAeyZSlTqwHmMw
         +fDu3VHAQ==
X-HalOne-ID: 0b10656d-ae39-11ed-be47-ede074c87fad
Received: from ravnborg.org (2-105-2-98-cable.dk.customer.tdc.net [2.105.2.98])
        by mailrelay3 (Halon) with ESMTPSA
        id 0b10656d-ae39-11ed-be47-ede074c87fad;
        Thu, 16 Feb 2023 20:32:35 +0000 (UTC)
Date:   Thu, 16 Feb 2023 21:32:34 +0100
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Daniel Vetter <daniel@ffwll.ch>
Cc:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-arm-msm@vger.kernel.org, andersson@kernel.org,
        agross@kernel.org, krzysztof.kozlowski@linaro.org,
        marijn.suijten@somainline.org,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        David Airlie <airlied@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 2/2] gpu/drm/panel: Add Sony TD4353 JDI panel driver
Message-ID: <Y+6S4o4nfG+XqAsF@ravnborg.org>
References: <20230119163201.580858-1-konrad.dybcio@linaro.org>
 <20230119163201.580858-2-konrad.dybcio@linaro.org>
 <725a5727-fdde-e3ae-a448-2679c5c4c7f4@linaro.org>
 <CAKMK7uFpc3Kg=Ym6ee_JTZo-0h2ig7Twtf2uwE7oV-1c6YRP=Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKMK7uFpc3Kg=Ym6ee_JTZo-0h2ig7Twtf2uwE7oV-1c6YRP=Q@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 16, 2023 at 01:32:22PM +0100, Daniel Vetter wrote:
> On Thu, 16 Feb 2023 at 12:59, Konrad Dybcio <konrad.dybcio@linaro.org> wrote:
> >
> >
> >
> > On 19.01.2023 17:32, Konrad Dybcio wrote:
> > > From: Konrad Dybcio <konrad.dybcio@somainline.org>
> > >
> > > Add support for the Sony TD4353 JDI 2160x1080 display panel used in
> > > some Sony Xperia XZ2 and XZ2 Compact smartphones. Due to the specifics
> > > of smartphone manufacturing, it is impossible to retrieve a better name
> > > for this panel.
> > >
> > > This revision adds support for the default 60 Hz configuration, however
> > > there could possibly be some room for expansion, as the display panels
> > > used on Sony devices have historically been capable of >2x refresh rate
> > > overclocking.
> > >
> > > Signed-off-by: Konrad Dybcio <konrad.dybcio@somainline.org>
> > > Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> > > Reviewed-by: Marijn Suijten <marijn.suijten@somainline.org>
> > > ---
> > Are there any outstanding issues with this driver, or perhaps I did
> > not CC some important list? It has gotten very little activity ever
> > since its initial submission around Sept'22..
> 
> Sam is usually picking up panel drivers these days, but maybe we need
> a bit more help in this area?
Time for Linux has been low for more than two years now.
Some life factors such as buying an older house and new responsibilities
at my $daytime job.
I may resurface and do something consistent one day, but consider me
unreliable. Sorry!

	Sam
