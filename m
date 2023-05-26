Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03C1E71271B
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 14:57:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243454AbjEZM5C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 May 2023 08:57:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243446AbjEZM45 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 08:56:57 -0400
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [81.169.146.165])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43292E54;
        Fri, 26 May 2023 05:56:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1685105776; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=ecL/yX4ACBM0LoiZ16bdV3ydQYoiCYrkxktY56WRb5lnQJu19PzOoJ45TErSAWXks6
    lFSYVNmIEAiG2+R6QP3QkuLi7jmNTFAywCbG0Y9ZygwUau6WYQJu7hkJb9fmHZiiaZ4g
    MAlfdBhuI+QN6vwH932S8PDGBjoM2ZUsMxO9+VfVxIkR2VP8t9npmC51YIKqb/QRUbxo
    S85YOyWODE1jhvFbCYsN4Mb+CslSsT+hbPWtxa8QN6wjnY6Iq3BGAW8Cs4TX8zTw15iG
    FLg6xVWlhZ4K/lz+wfZyqpb/klwrSe9CGM7Hy52VYmZbbPgHoWhIdLVZAui1foyhaZmh
    Ju+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1685105776;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=DQwmMMMxe4xHLS95ZMRaVWsx8QFAdxS0MuuF8Lk0U/4=;
    b=le1+x/EDVncfHty+3X2zPjyOC3b/+MRDUbEiNtpTmxWKUIZSPihowxhFbBLUpPPF4y
    HO7jkVDgMf7Rm6iJBmhdW8XbTf8ZL18ol9x16nm757ATIz+68H9zK30BhB7RlQYtqXqq
    evM/QjUcUSVAGzCSJH8V0NTXTEli6nc0osXdbK9Diyn+Ryd6vz3CkNrJBv+qst8r/z2W
    DKTCd+U7Wf9rAjqWkUI5+31RKJt0Sc4Wst9noDv861CtK6n1zsivvy9dURmEkfuX4f6n
    mx/jO5X26sWz2pcxayolH6vta3gou6O5x+45lDmEgd4C681WPem/nC9uClpb+MNV6ICe
    +k2g==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1685105776;
    s=strato-dkim-0002; d=gerhold.net;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=DQwmMMMxe4xHLS95ZMRaVWsx8QFAdxS0MuuF8Lk0U/4=;
    b=THhVJ6kZHG3cNYJZU4e8XwjPTlZsnstmWqzIFirvFs7/A18HSFrd0i4RTMqtZvhLFm
    9rrwwajo8gOPuxTDbEPtJraxTFDhcG4PoWJyeehADMQtIfJ6QqNrtcu1CXYyFX3IHYLf
    XL70Z14m3W77cFZpjLyX1PuZozF6//d62/42QCby6ZM5g/mDlBeamVTjSPqIRHTbghVn
    VCGo+VhpwkU7Bgmr7h0AKNKp1tmjUUW/ukvAHmqfwO1owb6cX3OVc2CqkOZ5Zrqv8Tfw
    sxwElq1TXu53HyIXk5Pd76Bs40l0u7vLqnTt/EhWvllwMfVzqaHMAmibokhCllKfmqlZ
    EYbg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1685105776;
    s=strato-dkim-0003; d=gerhold.net;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=DQwmMMMxe4xHLS95ZMRaVWsx8QFAdxS0MuuF8Lk0U/4=;
    b=mof1MmHH21Ht8aPq/JeiWg3YRDolNLMTriPICUmGx31NfAzamUfqQ1+SyGvS2xm+ym
    d5SxuLHLOgg4LxBcK6Cw==
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVOQ/OcYgojyw4j34+u261EJF5OxJD4paA95nh"
Received: from gerhold.net
    by smtp.strato.de (RZmta 49.4.0 DYNA|AUTH)
    with ESMTPSA id j6420az4QCuFb9P
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Fri, 26 May 2023 14:56:15 +0200 (CEST)
Date:   Fri, 26 May 2023 14:55:56 +0200
From:   Stephan Gerhold <stephan@gerhold.net>
To:     Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, phone-devel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht
Subject: Re: [PATCH 8/8] arm64: dts: qcom: msm8916-pm8916: Mark always-on
 regulators
Message-ID: <ZHCsXKejQxuGH2ZP@gerhold.net>
References: <20230510-msm8916-regulators-v1-0-54d4960a05fc@gerhold.net>
 <20230510-msm8916-regulators-v1-8-54d4960a05fc@gerhold.net>
 <ea53525b-749b-25e2-6dde-662a8e273597@linaro.org>
 <ef7b7335-d20c-3ddc-52df-b2801fa40283@linaro.org>
 <ZHBTi-j657tW3jIu@gerhold.net>
 <41f5b7a9-d927-e468-d1ea-291ad35ba943@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41f5b7a9-d927-e468-d1ea-291ad35ba943@linaro.org>
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 26, 2023 at 10:50:53AM +0200, Konrad Dybcio wrote:
> On 26.05.2023 08:36, Stephan Gerhold wrote:
> > On Fri, May 26, 2023 at 02:28:52AM +0200, Konrad Dybcio wrote:
> >> On 26.05.2023 01:39, Konrad Dybcio wrote:
> >>> On 17.05.2023 20:48, Stephan Gerhold wrote:
> >>>> Some of the regulators must be always-on to ensure correct operation of
> >>>> the system, e.g. PM8916 L2 for the LPDDR RAM, L5 for most digital I/O
> >>>> and L7 for the CPU PLL (strictly speaking the CPU PLL might only need
> >>>> an active-only vote but this is not supported for regulators in
> >>>> mainline currently).
> >>> Would you be interested in implementing this?
> > 
> > At least on MSM8916 there is currently no advantage implementing this.
> > The "active-only" votes only have the CPU as limited use case. S1 (aka
> > MSM8916_VDDCX) and L3 (MSM8916_VDDMX) are both used via rpmpd/power
> > domains which already provides separate active-only variants. L7 (for
> > the CPU PLL) is the only other regulator used in "active-only" mode.
> > However, at least on MSM8916 L7 seems to stay always-on no matter what I
> > do, so having an active-only vote on L7 doesn't provide any advantage.
> In this case it may be more important that we tell RPM that we want it
> to be active-only, even if it ultimately makes a different decision.
> You probably played with this more, but my guess would be that not letting
> off of an a-s vote could confuse the algos
> 

I think in this case it does not make any difference. There is no
difference to downstream for the power consumption during VMIN suspend
(with these changes and my hack patches). In fact the power consumption
is so ridiculously low (about 0.008W / 0.096 A @ 12V) that my
measurement thing can barely measure it. :D

There are definitely more important things to work on right now that
will make a much larger difference. Perhaps one day when we have the
important things like cpuidle, bus scaling/interconnect etc we can look
again at this tiny little regulator that probably will never turn off
anyway. :D

> > 
> >> Actually, I think currently all votes are active-only votes and what
> >> we're missing is sleep-only (and active-sleep if we vote on both)
> > 
> > If you only send the "active" votes but no "sleep" votes for a resource
> > then the RPM firmware treats it as active+sleep, see [1].
> > The active/sleep separation only starts once a separate sleep vote has
> > been sent for a resource for the first time.
> > 
> > Therefore, all requests from the SMD regulator driver apply for both
> > active+sleep at the moment.
> > 
> > [1]: https://git.codelinaro.org/clo/la/kernel/msm-3.10/-/blob/LA.BR.1.2.9.1-02310-8x16.0/drivers/regulator/rpm-smd-regulator.c#L202-204
> /me *dies*
> 
> that's a design decision if i've ever seen one..
> 

:D

> > 
> >>>
> >>> Ancient downstream defines a second device (vregname_ao) and basically
> >>> seems to select QCOM_SMD_(ACTIVE/SLEEP)_STATE based on that..
> >>>
> >>> Looks like `struct regulator` stores voltage in an array that wouldn't
> >>> you know it, depends on the PM state. Perhaps that could be something
> >>> to explore!
> >>>
> > 
> > Don't get confused by the similar naming here. RPM sleep votes are
> > unrelated to the "system suspend" voltages the regulator framework
> > supports. :)
> > 
> > RPM sleep votes become active if the cpuidle reaches the deepest state
> > for the (cpu/)cluster(/CCI). This can happen anytime at runtime when the
> > system is idle long enough. On the other hand, the regulator suspend
> > voltages are meant to become active during system suspend (where all the
> > devices get suspended as well).
> Yes and pm_genpd tracks that very meticulously, at least in the case of PSCI.

Meh, having a proper PSCI implementation is luxury! I have to mess with
the good old way of poking the SPM/SAWs from Linux... :P

Thanks,
Stephan
