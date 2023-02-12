Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFBF569390B
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Feb 2023 18:20:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229604AbjBLRUH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Feb 2023 12:20:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbjBLRUF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Feb 2023 12:20:05 -0500
Received: from mo4-p02-ob.smtp.rzone.de (mo4-p02-ob.smtp.rzone.de [85.215.255.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95CDCEB69;
        Sun, 12 Feb 2023 09:20:03 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1676222400; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=PvAUXO3QzyJCOQJ00svX9YbISUYxh0uUNbfeM4weO9kbWP8DZlnopvGEgnwC+hfhRd
    ebaDet6DrMYn8k9zKR/O1IEpPJfDCZrfL/faHgSsdQpCMYiJHozW4Hre3gkaqsVZKSGx
    lzWoThpSLWtLAOqH1aCWlC2ewvqQpYFZO1kX4QUUIhu80AfswqHu/sSYZzj+eVl07bP1
    VV+ftiHty6raA/TK8uyJ8XmIw66DiyUq8RE8LJ7qvmrP2hANLnqcEpFQd/0KafvFaNpM
    Yipx3DLHk2sidgwlbWjqMHE6vM5OM5K1IG+//x7jiszHxMdQ5LdRDN/niGNzjuOfpfri
    jEXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1676222400;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=tpRq6A3b3gz2MzU44GplEArBEihWeWjcdtzeTXlz9gc=;
    b=lrcxNxtuOjvp0YUNQzwl3FVm1f/MqxBv7XUR3/ihB+7lXZUkh6zubs45Y4FC81wHbE
    hqOfnJ9lf4bvEKAtaCe4IdZNdpyXnlX/bOSv1AEn4iqOLQHf9RynnAQksafCAs+Mjvnt
    janBCqX+7Jxi/RbDU/yR3vq1FFlfvR0tmC8ILI7miOXfZ8cd1KRFnrD7xkOMmEcu/sH3
    OmTpBEDiby1iLOSKTlqmmaCUxfSCBwC4/KRZ0IFKfT9VZNt9fFgD6SwcoyZxS7yXo9fu
    B1ESjgmSJadpabuc1eO+Vtmckl+sfZrkKHlKgsOYo++nygJUyEnVGrE66KZSx3Xl781R
    fGrQ==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo02
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1676222400;
    s=strato-dkim-0002; d=gerhold.net;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=tpRq6A3b3gz2MzU44GplEArBEihWeWjcdtzeTXlz9gc=;
    b=QXDin2055ym64eDtAPjsqizstYMMdAiN+IApozKqv+cRqLdFXubRtcGOtwUA3DUWrK
    6vQpODzOnX7oIB2Qw/zcAvdrWGdr00aKhgPqfsks+76OeAIwxNvPTBFQrDj9IQKfx+Y1
    RMgBUiT0Eo8Zu2LHGtc87H6atpnJdmiQKTk4SejOPgTu/mCIQOPMwrkngVLFe2OJ+yIq
    WZeOuLoRHqXySdFtn2dmnhnJBhEzRCOnlu9XSSevmXXQeLHKv2Ua27iI2AFOEL7vp6eE
    7je43I+bKeVc26MQfmXAG7L5YekxMEsxqG8qYHLMhQoewXV02Oi9JFNcxvYe29gRYv0z
    Nehw==
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVOQ/OcYgojyw4j34+u267EpF+OQRc4obTF5+SwHE="
Received: from gerhold.net
    by smtp.strato.de (RZmta 49.3.0 DYNA|AUTH)
    with ESMTPSA id K7ac91z1CHJxHsI
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Sun, 12 Feb 2023 18:19:59 +0100 (CET)
Date:   Sun, 12 Feb 2023 18:19:52 +0100
From:   Stephan Gerhold <stephan@gerhold.net>
To:     Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Cc:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        djakov@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-arm-msm@vger.kernel.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, benl@squareup.com,
        shawn.guo@linaro.org, fabien.parent@linaro.org, leo.yan@linaro.org,
        dmitry.baryshkov@linaro.org, Jun Nie <jun.nie@linaro.org>,
        James Willcox <jwillcox@squareup.com>,
        Joseph Gates <jgates@squareup.com>,
        Max Chen <mchen@squareup.com>, Zac Crosby <zac@squareup.com>,
        Vincent Knecht <vincent.knecht@mailoo.org>
Subject: Re: [PATCH v5 2/5] arm64: dts: qcom: Add msm8939 SoC
Message-ID: <Y+kfuHDMZCu1vKsA@gerhold.net>
References: <20230206012336.2130341-1-bryan.odonoghue@linaro.org>
 <20230206012336.2130341-3-bryan.odonoghue@linaro.org>
 <Y+T5cF4d667RhrJp@gerhold.net>
 <2b6bc14b-20df-b61e-6464-61ebb11f24f0@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2b6bc14b-20df-b61e-6464-61ebb11f24f0@linaro.org>
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 12, 2023 at 04:49:25PM +0000, Bryan O'Donoghue wrote:
> On 09/02/2023 13:47, Stephan Gerhold wrote:
> > > +			frame@b021000 {
> > > +				reg = <0x0b021000 0x1000>,
> > > +				      <0x0b022000 0x1000>;
> > > +				interrupts = <GIC_SPI 8 IRQ_TYPE_LEVEL_HIGH>,
> > > +					     <GIC_SPI 7 IRQ_TYPE_LEVEL_HIGH>;
> > > +				frame-number = <0>;
> > > +			};
> > These timer interrupts are still wrong like mentioned in v3:
> > https://lore.kernel.org/linux-arm-msm/Y8fC%2FGCHfENQmBNC@gerhold.net/
> > 
> 
> Hmm.
> 
> This is a copy/paste error from 8916 which I guess we never see in our
> production system, since we use LPM to get to do idle
> 

Huh?

We had this discussion several times before and once you mentioned that
Shawn fixed this in your production kernel at some point. You just keep
forgetting to apply the same change to your upstream tree. ;)

You can either change the timer interrupt numbers or (more easily) just
fix the address to point to the timer of the other cluster (which has
the same interrupt numbers as on 8916):

On Mon, Sep 19, 2022 at 03:11:01PM +0100, Bryan O'Donoghue wrote:
> Yep Shawn found that on our internal tree.
>
> commit 91a842b81a713ede9ba76f3957e6fdd9067b5493
> Author: Shawn Guo <shawn.guo@linaro.org>
> Date:   Thu May 28 11:03:40 2020 +0800
>
>     arm64: dts: msm8939: fix base address of memory mapped timer
> 
>     The base address of memory mapped timer is changed from msm8916's
>     0xb020000 to 0xb120000 on msm8939.  Fix it, so that the timer can start
>     working as the broadcast device to wake up cpu from deep idle state.
>
>     Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
>
> diff --git a/arch/arm64/boot/dts/qcom/msm8939.dtsi
> b/arch/arm64/boot/dts/qcom/msm8939.dtsi
> index dde56c2197eb..907f076b9808 100644
> --- a/arch/arm64/boot/dts/qcom/msm8939.dtsi
> +++ b/arch/arm64/boot/dts/qcom/msm8939.dtsi
> @@ -1326,61 +1326,61 @@
>                         reg = <0x0b000000 0x1000>, <0x0b002000 0x1000>;
>                 };
> 
> -               timer@b020000 {
> +               timer@b120000 {
>                         #address-cells = <1>;
>                         #size-cells = <1>;
>                         ranges;
>                         compatible = "arm,armv7-timer-mem";
> -                       reg = <0xb020000 0x1000>;
> +                       reg = <0xb120000 0x1000>;
>                         clock-frequency = <19200000>;
>
> -                       frame@b021000 {
> +                       frame@b121000 {
> 
> but I see that didn't make it into my working tree

