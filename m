Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69C85712022
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 08:37:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236000AbjEZGhQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 May 2023 02:37:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236168AbjEZGhN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 02:37:13 -0400
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [85.215.255.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04A3A12F;
        Thu, 25 May 2023 23:37:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1685083027; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=sOYCkzh74IzezBisb9hx7W1184exoAPd3LCsrHfWpsSc6IXf6iceRHLImevPNRYK/e
    uDiMVWCpf4VvSXfprXNV9LxUQDd2ibDo1D8wPU7I6J7WycnUXik3NrPy4vwBSiECiX2e
    XrxBfnT4mO01p/+0BS1ofYtc+XWM3tUlbz91cVLyptQByWO6d7N356OLoOrXm6IP0fBm
    1+OmTUCO1ZfXaiczsWyDXr55KRtNojTP+p9zYDBwhVNJwdW2q9lrvNZqMSpVq+2OHiok
    65nW0oS0c9rwKB8G/dkwg/XrZsjLpCl0jrZ2YDsiD/KD14r6xnM50Xd5guaDvXaNhS0x
    wLrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1685083027;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=KfNANOMCoK7SMpjZ/LaeUtfmlxbZC0YVqX755mC4yLI=;
    b=jDc7V9sPRHzCahMduX/HhK4ub4Rd1ikpQm3AHBqQzisoV3zN5gH96tH18+ndoNshfH
    3993ggvyQoRFcY4ZSgJ4/iTHMKxOhiWdJ50TAmGs7s6VRnXyUQWwdOCVhPlMX4hlWKkk
    qTsCl/rNHOnBh6YoeYkw7BEhBZb3C35MnEynbSckz0xZ/Ce55T2h+0q6cHaK5xu48qQc
    vT6FuPt5XlBu2ekZeeypGTslW9kQTYgmq6Aa5+dVELx6WhbuJ3zUMPIptT6eZdRxfNbT
    TexHPIfyaRriqXfyCQ+N51OQnEWpoGbLP6PkgEk5ZGzOyDoyQzW0XmnnDurbdc6HwczF
    2lmA==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1685083027;
    s=strato-dkim-0002; d=gerhold.net;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=KfNANOMCoK7SMpjZ/LaeUtfmlxbZC0YVqX755mC4yLI=;
    b=V/thZRWnHpWy0tZKcXZ4DN7Su2FPWL2+H79ynr59A1ej4DthEci+JwcBlrLDh5SUfb
    3VW9BII81TN48ZFYIsfFSyTSA6nVh0EWmPdyf5xsoKIggb3udDeaaltLYoPL+Idas6uc
    tJ/hBjFkgzxXQvG6iKpCZ7wZt+Ev9fCnnsORuyxi2BVAxQxvSPXXo+FKl0FTN/9gUbPT
    uECrXm55HRRBIopqLDPPgjrvtoghM1MK9mutg6o0cK1LybDpxje1pM2b7Q+eWL1OZP1c
    LdjsMbITOHSrnnNsPz/S0CfRLjkya4/5QjKJGk6HLBDHaIlFiSj/eNrixvCo37eNs775
    2oIQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1685083027;
    s=strato-dkim-0003; d=gerhold.net;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=KfNANOMCoK7SMpjZ/LaeUtfmlxbZC0YVqX755mC4yLI=;
    b=mZXaSwGzgu+Q2s4xwGLOAKCrXKM+sqdYTbeV8uc7eZcvw/+GQRitYl8jREO7bJd4KJ
    gv+R4/2zLYoP9YhAQrCw==
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVOQ/OcYgojyw4j34+u261EJF5OxJD4paA95nh"
Received: from gerhold.net
    by smtp.strato.de (RZmta 49.4.0 DYNA|AUTH)
    with ESMTPSA id j6420az4Q6b6ZDV
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Fri, 26 May 2023 08:37:06 +0200 (CEST)
Date:   Fri, 26 May 2023 08:36:59 +0200
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
Message-ID: <ZHBTi-j657tW3jIu@gerhold.net>
References: <20230510-msm8916-regulators-v1-0-54d4960a05fc@gerhold.net>
 <20230510-msm8916-regulators-v1-8-54d4960a05fc@gerhold.net>
 <ea53525b-749b-25e2-6dde-662a8e273597@linaro.org>
 <ef7b7335-d20c-3ddc-52df-b2801fa40283@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ef7b7335-d20c-3ddc-52df-b2801fa40283@linaro.org>
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 26, 2023 at 02:28:52AM +0200, Konrad Dybcio wrote:
> On 26.05.2023 01:39, Konrad Dybcio wrote:
> > On 17.05.2023 20:48, Stephan Gerhold wrote:
> >> Some of the regulators must be always-on to ensure correct operation of
> >> the system, e.g. PM8916 L2 for the LPDDR RAM, L5 for most digital I/O
> >> and L7 for the CPU PLL (strictly speaking the CPU PLL might only need
> >> an active-only vote but this is not supported for regulators in
> >> mainline currently).
> > Would you be interested in implementing this?

At least on MSM8916 there is currently no advantage implementing this.
The "active-only" votes only have the CPU as limited use case. S1 (aka
MSM8916_VDDCX) and L3 (MSM8916_VDDMX) are both used via rpmpd/power
domains which already provides separate active-only variants. L7 (for
the CPU PLL) is the only other regulator used in "active-only" mode.
However, at least on MSM8916 L7 seems to stay always-on no matter what I
do, so having an active-only vote on L7 doesn't provide any advantage.

> Actually, I think currently all votes are active-only votes and what
> we're missing is sleep-only (and active-sleep if we vote on both)

If you only send the "active" votes but no "sleep" votes for a resource
then the RPM firmware treats it as active+sleep, see [1].
The active/sleep separation only starts once a separate sleep vote has
been sent for a resource for the first time.

Therefore, all requests from the SMD regulator driver apply for both
active+sleep at the moment.

[1]: https://git.codelinaro.org/clo/la/kernel/msm-3.10/-/blob/LA.BR.1.2.9.1-02310-8x16.0/drivers/regulator/rpm-smd-regulator.c#L202-204

> > 
> > Ancient downstream defines a second device (vregname_ao) and basically
> > seems to select QCOM_SMD_(ACTIVE/SLEEP)_STATE based on that..
> > 
> > Looks like `struct regulator` stores voltage in an array that wouldn't
> > you know it, depends on the PM state. Perhaps that could be something
> > to explore!
> > 

Don't get confused by the similar naming here. RPM sleep votes are
unrelated to the "system suspend" voltages the regulator framework
supports. :)

RPM sleep votes become active if the cpuidle reaches the deepest state
for the (cpu/)cluster(/CCI). This can happen anytime at runtime when the
system is idle long enough. On the other hand, the regulator suspend
voltages are meant to become active during system suspend (where all the
devices get suspended as well).

Since we do have "active-only" support in rpmpd I think the question is
if it is worth bringing the feature also to regulators. Perhaps one
could simply treat all regulators that are needed by the CPU as power
domain.

For example, L7 on MSM8916 is fixed at 1.8V so while it doesn't have
corners the simple enable/disable votes could also be sent via rpmpd.
In some places in downstream L7 is also called VDDPX, similar to
VDDCX and VDDMX which are already in rpmpd.

Thanks,
Stephan
