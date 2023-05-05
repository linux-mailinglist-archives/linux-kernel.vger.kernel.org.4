Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 175356F7E39
	for <lists+linux-kernel@lfdr.de>; Fri,  5 May 2023 09:55:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231417AbjEEHzu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 May 2023 03:55:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230211AbjEEHzs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 May 2023 03:55:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 517D917DF1;
        Fri,  5 May 2023 00:55:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DD5B863C09;
        Fri,  5 May 2023 07:55:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F23DC433D2;
        Fri,  5 May 2023 07:55:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683273343;
        bh=C0NxPbnK07NPfnCGHwtR10e2LP53WWBmIi+P/DTZCUE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=j1mK3nKHO+Ac7/NW8Ugie16wfX1T5Rfbckz+i/6/1RsJl9jBmm2Ak4VOsieXsEoNT
         7OV4Yl/wkfeCdNMzEeQAB4KKnMU10Ntjz2SmA0CE+MNo3O5PbO1aTv6U0vBxrzRA5Q
         D/npfNIEpZy0CQ5fCuAi2QjYdvdO4dJvbvOMuvkU+YZ87A/UlWVwpce2GtA02WuD3g
         dRHcRf/jf073XJGlOl0fqvGY1Ewlj1wwH9RxE2U7PjUqOVM8uH8XRe9cckU97A0J+S
         asR6b5BU6HaF3pomhF4ZvEq1Dh3XYZVVVq3ckbjGmuIBO/tf8DtLH8GU1tuB0P1i2z
         7bVHV7Ix72h4g==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1puqIC-0006lu-UO; Fri, 05 May 2023 09:55:53 +0200
Date:   Fri, 5 May 2023 09:55:52 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Andrew Halaney <ahalaney@redhat.com>,
        Krishna Kurapati PSSNV <quic_kriskura@quicinc.com>
Cc:     Johan Hovold <johan+linaro@kernel.org>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        quic_pkondeti@quicinc.com, quic_ppratap@quicinc.com,
        quic_wcheng@quicinc.com, quic_jackp@quicinc.com,
        quic_harshq@quicinc.com, quic_shazhuss@quicinc.com
Subject: Re: [PATCH v6 6/8] arm64: dts: qcom: sc8280xp: Add multiport
 controller node for SC8280
Message-ID: <ZFS2iJOfhsM8gxK5@hovoldconsulting.com>
References: <20230405125759.4201-1-quic_kriskura@quicinc.com>
 <20230405125759.4201-7-quic_kriskura@quicinc.com>
 <20230414154527.vsjtgtfsd5kc7vww@halaney-x13s>
 <333ce700-8ca2-e230-3b5a-a95e4c021e45@quicinc.com>
 <28a58bf9-5ad8-4084-11d6-cd1b0d3a2998@quicinc.com>
 <20230425203328.hrz5dw7f2vsbbbgk@halaney-x13s>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230425203328.hrz5dw7f2vsbbbgk@halaney-x13s>
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 25, 2023 at 03:33:28PM -0500, Andrew Halaney wrote:
> On Sat, Apr 22, 2023 at 09:38:44PM +0530, Krishna Kurapati PSSNV wrote:

> > Hi Andrew, Johan,
> > 
> >   I was looking at the pwr_event_irq interrupts for Multiport controller and
> > see that there are two of them as per HW specs. All targets till date have
> > only 1 pwr_event_irq required.
> > 
> > The reason I thought I missed pwr_event_irq in my patches is because in
> > downstream this is a required IRQ for all targets, so I was under assumption
> > that we need it for upstream targets as well. But upstream qcom driver
> > doesn't have support for this IRQ yet. And this has been made a required one
> > only for SC8280 [1]/[2].
> > 
> > Probably we can proceed in one of the following ways:
> > 1. Remove pwr_event_irq in both bindings and DT as driver support is not
> > present currently.
> > 2. Update the bindings for SC8280 to include an optional secondary
> > pwr_event_irq for multiport controller.
> > 
> > I would prefer option-1 as removing them would be better because they are
> > not being used. Please let me know your thoughts on this.
> > 
> > [1]:
> > https://lore.kernel.org/all/20220713131340.29401-2-johan+linaro@kernel.org/
> > [2]:
> > https://lore.kernel.org/all/20220713131340.29401-6-johan+linaro@kernel.org/
> > 
> 
> Personally, I prefer option 2 since the IRQ does exist technically
> (although it isn't currently used), I like it being described... it
> makes the dt-binding a more complete description of the hardware.
> 
> I am unsure of the rules wrt dt-bindings and usage in drivers, but I
> always like to view it as "this is a description of the hardware", and
> the driver bit is just nice to have to ensure that whoever is adding the
> binding is actually describing things sufficiently.

As Andrew mentioned, the binding should reflect the hardware and not
what is currently supported in some version of software. 

It looks like you even had four of these pwr_event interrupt line
judging from your last iteration of this series.

Johan
