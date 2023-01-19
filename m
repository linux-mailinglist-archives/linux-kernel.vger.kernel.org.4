Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E16A674AD7
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 05:37:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230263AbjATEhI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 23:37:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230153AbjATEgK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 23:36:10 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08089BCE29;
        Thu, 19 Jan 2023 20:34:08 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id CA621B81FB6;
        Thu, 19 Jan 2023 03:23:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84EB1C433D2;
        Thu, 19 Jan 2023 03:23:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674098615;
        bh=B/Vil+BCvMES2VBIHniyfyXIHaKVa/JH2c0YEFAqOSs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Cs4vxPysHQ87a5wrly5UBMChJxApTBL8QzHfPRxPwptnf12QHNxrAdHftc/ICREB+
         nzSbgnywnEpx3uqre/J/10LoixZddo7OuHGrk4p00Az4B6K3EYGRqlyIyhfAMIJspM
         KLEZYa3V0vZTyZNJe7UKYWgWgnt6HCgnxna9LZcIsCjnjXrP+MBrOBM6W1PLeFUwrP
         L7d2HIxUPjF7cbhDBN5lU4iEE+MuPwAsFxcc6dJuvuyckTlCmLDpoqdMY0tI4I6DMi
         pu2NwpQTd0mgeHh6oYTpjT0a3EL2JgQm8s2pu4NMx2vGDwJJbNwscrpH5LPXLSUow7
         Lz5mCOHEa54uA==
Date:   Wed, 18 Jan 2023 21:23:32 -0600
From:   Bjorn Andersson <andersson@kernel.org>
To:     Bhupesh Sharma <bhupesh.sharma@linaro.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        agross@kernel.org, konrad.dybcio@linaro.org,
        linux-kernel@vger.kernel.org, bhupesh.linux@gmail.com,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org
Subject: Re: [PATCH] dt-bindings: qcom: geni-se: Fix '#address-cells' &
 '#size-cells' related dt-binding error
Message-ID: <20230119032332.w5in5zmoyavi2s45@builder.lan>
References: <20230113201038.267449-1-bhupesh.sharma@linaro.org>
 <aef753a5-e8b1-5b7b-1b9e-e92a84de15bd@linaro.org>
 <CAH=2Ntx5rLWu4jzXV8DwKj+yweHPRqb4+Rv8uZpDn_brWDxyJg@mail.gmail.com>
 <b9aa6d30-5fe8-57a9-e478-c99bca70d185@linaro.org>
 <CAH=2Nty2gUL3DufowzHavhUNdeht2dcX4EU7ooM+xzax2vP7uQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAH=2Nty2gUL3DufowzHavhUNdeht2dcX4EU7ooM+xzax2vP7uQ@mail.gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 16, 2023 at 09:13:12PM +0530, Bhupesh Sharma wrote:
> On Mon, 16 Jan 2023 at 13:23, Krzysztof Kozlowski
> <krzysztof.kozlowski@linaro.org> wrote:
> >
> > On 15/01/2023 22:33, Bhupesh Sharma wrote:
> > > On Sun, 15 Jan 2023 at 20:57, Krzysztof Kozlowski
> > > <krzysztof.kozlowski@linaro.org> wrote:
> > >>
> > >> On 13/01/2023 21:10, Bhupesh Sharma wrote:
> > >>> Fix the following '#address-cells' & '#size-cells' related
> > >>> dt-binding error:
> > >>>
> > >>>    $ make dtbs_check
> > >>>
> > >>>    From schema: Documentation/devicetree/bindings/soc/qcom/qcom,geni-se.yaml
> > >>>         arch/arm64/boot/dts/qcom/sm4250-oneplus-billie2.dtb: geniqup@4ac0000:
> > >>>               #address-cells:0:0: 2 was expected
> > >>>       From schema: Documentation/devicetree/bindings/soc/qcom/qcom,geni-se.yaml
> > >>
> > >> Don't we want rather to unify the soc address range?
> > >
> > > Well, the assumption in the original dt-bindings was that every reg
> > > variable is 4 * u32 wide (as most new qcom SoCs set #address- and
> > > #size-cells to <2>). However, that is not the case for all of the
> > > SoCs.
> >
> > Hm, which device of that SoC cannot be used with address/size cells 2?
> 
> As noted in the git log already the geniqup on sm6115 / sm4250 cannot
> be used with address/size cells 2 (See:
> https://github.com/torvalds/linux/blob/master/arch/arm64/boot/dts/qcom/sm6115.dtsi#L795)
> 

I'm not able to find the reasoning you're referring to. We do have cells
of 2 for these nodes on all other platforms.  If there is a specific
problem, that can be documented and you can probably use ranges to
reduce keep the cells of 1 in the geni wrappers.


The reason why we have cells = 2 on most platforms is because the SMMU
reports that it's capable of more address bits than the buses will
handle. So without cells = 2, we can't describe dma-ranges appropriately
and you get page faults due to truncated addresses on the bus when the
iommu iova has been picking addresses for you.

Regards,
Bjorn

> > > So, ideally we shouldn't set the  "#address-cells" and  "#size-cells":
> > > as const: 2 in the bindings.
> > >
> > > See as an example:
> > > https://www.kernel.org/doc/Documentation/devicetree/bindings/usb/usb-device.yaml
> >
> >
> > How USB device - so entirely different device, not MMIO! - is related here?
> >
> > Best regards,
> > Krzysztof
> >
