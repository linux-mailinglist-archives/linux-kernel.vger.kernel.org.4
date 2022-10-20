Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02FDE6066E7
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 19:18:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229739AbiJTRSW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 13:18:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229720AbiJTRSQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 13:18:16 -0400
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [85.215.255.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE54B1DEC06;
        Thu, 20 Oct 2022 10:18:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1666286291;
    s=strato-dkim-0002; d=gerhold.net;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=AHjeMo+ip+LW4qeiu8MeiHhu4CY0K3tFEnRf7ZV1uNA=;
    b=TtqW2jyQU9ez7vJZJjQjsPj239ZU08ZV5bpeVyYDG7C9zOY+7X5c2eH8sRgt+A9wVl
    GwIrjRQ4uX98fTUvUACGQuzfeDC79q8XL0bAT7xB0jlcV/u+kbv+nzWB6z0L9naPWVuB
    JRs6Bsn6HJtwc1c6Xt95S+Ku9yQGG8dZX93aE/yqRWp/pbv5MQ2R4slzCw92ASShEP9l
    Y2BiohhjpVifFIaja5et7XLTJZdgr3wnI49aO+9jFP/NiYLatMGpmLczxwHLK/zFpTMI
    g5RUEYX4FMrKspDyPDvcdG9lFEMLX+YXsfRLt1tlHr3+yPeVG2uf6S9N++rulZUPCkiC
    4UIA==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVOQ/OcYgojyw4j34+u261EJF5OxJAhd5WwPXI"
X-RZG-CLASS-ID: mo00
Received: from gerhold.net
    by smtp.strato.de (RZmta 48.2.0 DYNA|AUTH)
    with ESMTPSA id f6c614y9KHIBZLz
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Thu, 20 Oct 2022 19:18:11 +0200 (CEST)
Date:   Thu, 20 Oct 2022 19:18:00 +0200
From:   Stephan Gerhold <stephan@gerhold.net>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Melody Olvera <quic_molvera@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/3] arm64: dts: qcom: Add base QDU1000/QRU1000 DTSIs
Message-ID: <Y1GCs6uCz5o9az+v@gerhold.net>
References: <20221014221138.7552-1-quic_molvera@quicinc.com>
 <20221014221138.7552-3-quic_molvera@quicinc.com>
 <56af2a04-1b21-000d-e3f9-86b6ac74aaf2@linaro.org>
 <a0032338-482f-0de7-5952-c3c8b8423df6@quicinc.com>
 <50372a15-56ce-6ad6-f622-00624b909db8@linaro.org>
 <Y1FTJgloEi5ag2/j@gerhold.net>
 <9fbe1bf5-a84d-c56b-1c0e-6848ee3d30fe@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9fbe1bf5-a84d-c56b-1c0e-6848ee3d30fe@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 20, 2022 at 12:08:36PM -0400, Krzysztof Kozlowski wrote:
> On 20/10/2022 09:54, Stephan Gerhold wrote:
> > On Thu, Oct 20, 2022 at 08:41:15AM -0400, Krzysztof Kozlowski wrote:
> >> On 19/10/2022 16:21, Melody Olvera wrote:
> >>> On 10/15/2022 6:28 AM, Krzysztof Kozlowski wrote:
> >>>> On 14/10/2022 18:11, Melody Olvera wrote:
> >>>> [...]
> >>>>> +	clocks {
> >>>>> +		xo_board: xo-board {
> >>>>> +			compatible = "fixed-clock";
> >>>>> +			clock-frequency = <19200000>;
> >>>> Both clocks are not a property of a SoC. They are provided by the board,
> >>>> so they should either be defined by board DTS or at least their
> >>>> frequency must be provided by the board.
> >>> That doesn't seem in keeping with precedent.... the sm8* series all have the clocks in
> >>> the dtsi. These are common to the boards anyways.
> >>
> >> Because people do not pay attention what is part of SoC, what is part of
> >> board. DTSI is for the SoC and these are inputs to the SoC.
> >>
> > 
> > (Just chiming in because I had this thought already a few times when you
> >  suggested moving the XO "clock-frequency" to the board DTS:)
> > 
> > I understand your reasoning for moving components of the board to the
> > board DTS, but IMHO adding just the clock-frequency to the board DTS is
> > even more misleading: It suggests that there are functional board
> > designs where you would use a XO clock with a different clock-frequency.
> > Is that really realistic though?
> 
> Keeping it in DTSI also suggests you could have some different frequency.
> 

If the fixed-clock was listed in the SoC DTSI I would personally
consider it as fixed and would not try to modify it in the board DTS.
The way I see it is that the board DTS mostly _extends_ the SoC DTSI
(add peripherals/supplies/...) instead of _modifying_ it.

Anyway this is likely subjective and was not my main point/question. :)

> > 
> > There are assumptions about the XO clock frequency in a lot of places:
> > You would need to fully rewrite the gcc-<SoC>.c driver because it has
> > fixed multipliers/dividers for one specific XO frequency. All firmware
> > binaries would likely need changes. And does the hardware even support a
> > different XO clock frequency? The APQ8016E datasheet for example
> > strictly documents a XO clock input of 19.2 MHz and a sleep clock of
> > 32.768 kHz.
> 
> I know, the same with most of other platforms. Qualcomm is not special
> here. Maybe the difference is that some other platforms have few
> external clocks and not all of them are required.
> 
> > IMHO the only realistic variation of the XO clock setup would be to have
> > a physical "fixed-clock" with a higher frequency, followed by a
> > "fixed-factor-clock" that brings it back to the expected frequency. To
> > model that properly it is not enough to have just the "clock-frequency"
> > in the board DTS. In this case you need two clock nodes, and the
> > xo_board would be the "fixed-factor-clock".
> 
> It's not about whether you can change it or not. It's about describing
> hardware - SoC DTSI describes SoC. DTS describes the board (assuming
> there is no SoM or other DTSI files). This clock is not in DTSI.
> 
> > Therefore it should be all or nothing IMO: Either we move the full
> > xo-board node to the board DTS (which allows alternatively defining the
> > "fixed-factor-clock" or whatever).
> 
> You can move entire clock to boards.
> 
> > Or we assume that there will be
> > always an input clock signal with the fixed frequency and keep it fully
> > in the SoC .dtsi.
> > 
> > Having just the "clock-frequency" in the board DTS puts the attention on
> > the wrong detail, IMO. :)
> 
> No, it puts attention to the board designer that he needs to provide the
> clock in his design.
> 
> We had such talks about other platforms, although I do not have any
> recent bookmarks. Something older:
> 
> https://lore.kernel.org/all/3382034.5ADO0F7naY@wuerfel/
> 
> https://lore.kernel.org/linux-samsung-soc/53DAB0A6.9030700@gmail.com/
> 

If I understand you correctly your argument for having the clock in the
board DTS instead of the SoC DTSI is:

The SoC DTSI describes the components of the SoC, while the board DTS
describes the components of the board (built around the SoC). The clock
is part of the board (and not the SoC) and therefore belongs into the
board DTS and not the SoC DTSI. Having the SoC/board components clearly
separated ensures people writing new board DTS pay attention to
everything board-specific.

Correct? This sounds reasonable to me.

However, the main question of my previous mail was: Why do you
alternatively recommend to keep the clock defined in the SoC DTSI and to
just put the clock-frequency into the board DTS? This sounds like a
contradiction of the above to me: the clock is still (partially)
described as part of the SoC, even though it belongs to the board.

Someone writing a board DTS should not just put attention to the
clock-frequency, but also if they have a single fixed-clock or
maybe some kind of clock-fixed-factor setup, as I wrote.

Thanks,
Stephan
