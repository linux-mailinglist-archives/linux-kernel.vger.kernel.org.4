Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FB2F671302
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 06:10:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229608AbjARFJ5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 00:09:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbjARFJy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 00:09:54 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2E7511E93;
        Tue, 17 Jan 2023 21:09:52 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 555126157D;
        Wed, 18 Jan 2023 05:09:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F9D9C433D2;
        Wed, 18 Jan 2023 05:09:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674018591;
        bh=MVabULCSkNV421jVEsP7DjhYVzrIeoLvfIJ7eMv+LXA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SIQvrDQUUMEyIMpQ6bG2KNlRIB7auqTJG76u8rZ5OD9Iw2YB2an3cPlqQ8ajBjcbM
         rNO/PKVvm5X5x9U6VCBhE8kKM7qA47Salap0cVDwsh52I6d50VWR3IVe7ut3Kc2ZsO
         AhBJD8PF7NyzWv4cZBA75TP1gH9XJshTcqetx7clLPFonm6Ag6ex/y+vsvliFJr8U0
         8KKmcohtYsf97eLZDs4WrMrluN0UI1g7/CwryWZyZHH1sIjRqKbyOKXvBdljPMhlpw
         MdNan4VNUYZvASuI0gn3C3PTKwSPf5JzwJmycu5DGM1R3UnefFsZPXsH/gZLppfGHG
         qqDYARAx6eZtw==
Date:   Tue, 17 Jan 2023 23:09:48 -0600
From:   Bjorn Andersson <andersson@kernel.org>
To:     Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Cc:     agross@kernel.org, konrad.dybcio@linaro.org, djakov@kernel.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        benl@squareup.com, shawn.guo@linaro.org, fabien.parent@linaro.org,
        leo.yan@linaro.org, dmitry.baryshkov@linaro.org,
        Jun Nie <jun.nie@linaro.org>,
        James Willcox <jwillcox@squareup.com>,
        Joseph Gates <jgates@squareup.com>,
        Max Chen <mchen@squareup.com>, Zac Crosby <zac@squareup.com>,
        Vincent Knecht <vincent.knecht@mailoo.org>,
        Stephan Gerhold <stephan@gerhold.net>
Subject: Re: [PATCH v3 5/8] arm64: dts: qcom: Add msm8939 SoC
Message-ID: <20230118050948.bibhq26s6sgzullg@builder.lan>
References: <20230117024846.1367794-1-bryan.odonoghue@linaro.org>
 <20230117024846.1367794-6-bryan.odonoghue@linaro.org>
 <20230117205800.cqexxwxmtupapy7e@builder.lan>
 <28e1df7a-6577-bf39-9739-d0a047b36f12@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <28e1df7a-6577-bf39-9739-d0a047b36f12@linaro.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 17, 2023 at 10:48:37PM +0000, Bryan O'Donoghue wrote:
> On 17/01/2023 20:58, Bjorn Andersson wrote:
> > On Tue, Jan 17, 2023 at 02:48:43AM +0000, Bryan O'Donoghue wrote:
> > > Add msm8939 a derivative SoC of msm8916. This SoC contains a number of key
> > > differences to msm8916.
> > > 
> > > - big.LITTLE Octa Core - quad 1.5GHz + quad 1.0GHz
> > > - DRAM 1x800 LPDDR3
> > > - Camera 4+4 lane CSI
> > > - Venus @ 1080p60 HEVC
> > > - DSI x 2
> > > - Adreno A405
> > > - WiFi wcn3660/wcn3680b 802.11ac
> > > 
> > > Co-developed-by: Shawn Guo <shawn.guo@linaro.org>
> > > Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
> > > Co-developed-by: Jun Nie <jun.nie@linaro.org>
> > > Signed-off-by: Jun Nie <jun.nie@linaro.org>
> > > Co-developed-by: Benjamin Li <benl@squareup.com>
> > > Signed-off-by: Benjamin Li <benl@squareup.com>
> > > Co-developed-by: James Willcox <jwillcox@squareup.com>
> > > Signed-off-by: James Willcox <jwillcox@squareup.com>
> > > Co-developed-by: Leo Yan <leo.yan@linaro.org>
> > > Signed-off-by: Leo Yan <leo.yan@linaro.org>
> > > Co-developed-by: Joseph Gates <jgates@squareup.com>
> > > Signed-off-by: Joseph Gates <jgates@squareup.com>
> > > Co-developed-by: Max Chen <mchen@squareup.com>
> > > Signed-off-by: Max Chen <mchen@squareup.com>
> > > Co-developed-by: Zac Crosby <zac@squareup.com>
> > > Signed-off-by: Zac Crosby <zac@squareup.com>
> > > Co-developed-by: Vincent Knecht <vincent.knecht@mailoo.org>
> > > Signed-off-by: Vincent Knecht <vincent.knecht@mailoo.org>
> > > Co-developed-by: Stephan Gerhold <stephan@gerhold.net>
> > > Signed-off-by: Stephan Gerhold <stephan@gerhold.net>
> > > Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
> > 
> > Just to make sure when I get the question, you all co-developed this
> > patch, right?
> 
> A long list but a fair one.
> 
> > > ---
> > >   arch/arm64/boot/dts/qcom/msm8939.dtsi | 2393 +++++++++++++++++++++++++
> > >   1 file changed, 2393 insertions(+)
> > >   create mode 100644 arch/arm64/boot/dts/qcom/msm8939.dtsi
> > > 
> > > diff --git a/arch/arm64/boot/dts/qcom/msm8939.dtsi b/arch/arm64/boot/dts/qcom/msm8939.dtsi
> > > new file mode 100644
> > > index 0000000000000..8cd358a9fe623
> > > --- /dev/null
> > > +++ b/arch/arm64/boot/dts/qcom/msm8939.dtsi
> > > @@ -0,0 +1,2393 @@
> > > +// SPDX-License-Identifier: GPL-2.0-only
> > > +/*
> > > + * Copyright (c) 2013-2015, The Linux Foundation. All rights reserved.
> > > + * Copyright (c) 2020-2023, Linaro Limited
> > > + */
> > > +
> > > +#include <dt-bindings/clock/qcom,gcc-msm8939.h>
> > > +#include <dt-bindings/clock/qcom,rpmcc.h>
> > > +#include <dt-bindings/interconnect/qcom,msm8939.h>
> > > +#include <dt-bindings/interrupt-controller/arm-gic.h>
> > > +#include <dt-bindings/power/qcom-rpmpd.h>
> > > +#include <dt-bindings/reset/qcom,gcc-msm8939.h>
> > > +#include <dt-bindings/thermal/thermal.h>
> > > +
> > > +/ {
> > > +	interrupt-parent = <&intc>;
> > > +
> > > +	#address-cells = <2>;
> > > +	#size-cells = <2>;
> > 
> > Why do you use a default of 2? In particular since you reduce it to 1 in
> > /soc...
> 
> You asked that before, and I took a note of the answer but, then because I
> was away from the main machine when I sent V2, I didn't have the log.
> 
> Here's what I wrote down.
> 
> "  - address-cells/size-cells = 1 in /soc - Bjorn
>     I experimentally changed address/cell sizes to 2
>     I'm finding that lk chokes "
> 
> So AFAIR LK was unhappy about changing the top level address/size cells to
> <1> <1> and converting the /soc address/size cells to <2> <2> caused a
> number of breakages during boot.
> 
> To be honest, this pattern is copied from the msm8916.dtsi original.
> msm8953.dtsi has the same thing. msm8994 too, and 8998.
> 
> If you think it needs changing, then I'll have to see what can be done with
> soc@{} entries.
> 

Sounds like problems not worth pursuing further. How about leaving a
comment for the next person here about LK's expectation of these being
2?

Thanks,
Bjorn
