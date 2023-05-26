Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F09CA71206D
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 08:47:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242306AbjEZGre (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 May 2023 02:47:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236735AbjEZGrc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 02:47:32 -0400
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [81.169.146.165])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20A63125;
        Thu, 25 May 2023 23:47:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1685083643; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=cGFNG/Ocgdc+dGc7sNDnP7vWTbWW3rY57OYtVrFvT90iVgYGWtGgs6F56DuvWeDEFP
    GrDEqUfrGRFBsplVwgx3g2/i3ITfRE4hjqNrbBwyIhRsQOHpyC9RsMtD5wyvEHzU6s2P
    wHqBp7xgXhoIZ8uOfC89rlCelJsmZWifn1MPJiqU+oTmkilGx0S+w/BRJZOf69E3Ggs4
    BWIvi/6VWdDxFOUM5Z3E7aPVJ+P/sg8mC1Niz3fZIU5i6wVkDyBO5wcawyT7nfig0Wt8
    zV2/ENx0cMZb4ksIQexTZl/khgh5s55jEXuVYkG/AZCSdEojqPOX/Hc4UCr5EKPN3xzU
    9HZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1685083643;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=7/3hdjTLdwnUD4fcMlMWezGKin7mL9oy2oTZnbl8DKw=;
    b=splIQfVuoDoN411bUPZ520MEKWVQazFwDJZsv29u0LeP32Z6p199s/II9/1WQSVXe0
    ehOB4e8g6vVm1RKbOgFv0EE2aOhAO4UHZoVs9XPg5SVPLai2qIyXzxpuwnGH6ReP3wHQ
    4eTWMdcxvlfaWycfImhYubLVOH58jMY3TgFT04queyUNAWT5Mqp1hg8XPQh5QEVtI3ij
    FuoaZp9hWGi/HLpQxjFLt7TKkB0JgAu1np0CaY0dx8swYFVpSd04jrMAt8E+t5P/5a6j
    SzMl6WvsXcTneQsJOe7KXfqRPSuRZ6880BFEfDxnDxJtwCGkqccvVunXrTLiolQQvB/C
    Xpbg==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1685083643;
    s=strato-dkim-0002; d=gerhold.net;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=7/3hdjTLdwnUD4fcMlMWezGKin7mL9oy2oTZnbl8DKw=;
    b=DYc4nd6QHcrkspgh7v3YsOExpph17K2jV78DX5o1wVCQScVGnj5zaxkdK3USiUQL92
    PFSVI0+780XvcMctRH5C4784ikj2AOglKtcJtT2d1DCkvouKDgKD0gzBc4A6fDHYo754
    Ea30yzL6O/wICVtBgz0TlWT9FlcHHMRqufzpHBBsyeDsL7cLUUWLRf+E10i4yPVjlexG
    SsEL48gYeUnxbPHR07PQdvXp+ZGS1cRPYSAeJnJk5fnKGzr6uNVdnn1pAri0Y3+1xD7k
    O/ouBIBNQqDvhW4VP+hS7M2et0WnZXsCzTp9I1NAVeDdWS8zTYcE0c8NaruNhPxZjour
    lLCA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1685083643;
    s=strato-dkim-0003; d=gerhold.net;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=7/3hdjTLdwnUD4fcMlMWezGKin7mL9oy2oTZnbl8DKw=;
    b=VvYzGK5yvvo0GEomb2DLIj5qSBTDxEsg1uPBtcOpUAHKC4gmODToKrqZIxTuy0nkVh
    tPbRLbdo0hE4pBdXxrAg==
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVOQ/OcYgojyw4j34+u261EJF5OxJD4paA95nh"
Received: from gerhold.net
    by smtp.strato.de (RZmta 49.4.0 DYNA|AUTH)
    with ESMTPSA id j6420az4Q6lNZGK
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Fri, 26 May 2023 08:47:23 +0200 (CEST)
Date:   Fri, 26 May 2023 08:47:22 +0200
From:   Stephan Gerhold <stephan@gerhold.net>
To:     Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, phone-devel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht
Subject: Re: [PATCH 7/8] arm64: dts: qcom: msm8916: Define regulator
 constraints next to usage
Message-ID: <ZHBV-mBPhoqy8yvs@gerhold.net>
References: <20230510-msm8916-regulators-v1-0-54d4960a05fc@gerhold.net>
 <20230510-msm8916-regulators-v1-7-54d4960a05fc@gerhold.net>
 <9f474fe8-523c-3668-540a-a8fc04ed64a6@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9f474fe8-523c-3668-540a-a8fc04ed64a6@linaro.org>
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

On Fri, May 26, 2023 at 01:35:06AM +0200, Konrad Dybcio wrote:
> On 17.05.2023 20:48, Stephan Gerhold wrote:
> > Right now each MSM8916 device has a huge block of regulator constraints
> > with allowed voltages for each regulator. For lack of better
> > documentation these voltages are often copied as-is from the vendor
> > device tree, without much extra thought.
> > 
> > Unfortunately, the voltages in the vendor device trees are often
> > misleading or even wrong, e.g. because:
> > 
> >  - There is a large voltage range allowed and the actual voltage is
> >    only set somewhere hidden in some messy vendor driver. This is often
> >    the case for pm8916_{l14,l15,l16} because they have a broad range of
> >    1.8-3.3V by default.
> > 
> >  - The voltage is actually wrong but thanks to the voltage constraints
> >    in the RPM firmware it still ends up applying the correct voltage.
> > 
> > To have proper regulator constraints it is important to review them in
> > context of the usage. The current setup in the MSM8916 device trees
> > makes this quite hard because each device duplicates the standard
> > voltages for components of the SoC and mixes those with minor
> > device-specific additions and dummy voltages for completely unused
> > regulators.
> > 
> > The actual usage of the regulators for the SoC components is in
> > msm8916-pm8916.dtsi, so it can and should also define the related
> > voltage constraints. These are not board-specific but defined in the
> > APQ8016E/PM8916 Device Specification. The board DT can then focus on
> > describing the actual board-specific regulators, which makes it much
> > easier to review and spot potential mistakes there.
> > 
> > Note that this commit does not make any functional change. All used
> > regulators still have the same regulator constraints as before. Unused
> > regulators do not have regulator constraints anymore because most of
> > these were too broad or even entirely wrong. They should be added back
> > with proper voltage constraints when there is an actual usage.
> > 
> > Signed-off-by: Stephan Gerhold <stephan@gerhold.net>
> > ---
> I'm a bit torn between saying "this is very nice already" and "we should
> probably override each regulator individually" like so:
> 
> &pm8916_l17 {
> 	[...]
> }
> 
> to minimize mistakes..
> 
> Not sure what to make of it, I see Bjorn already applied this, so I guess
> I'm just leaving some potential ideas for the future here.
> 

Sorry, could you elaborate a bit on what changes you would make exactly?

The way it works in this patch is that regulators that are used by the
SoC are defined in msm8916-pm8916.dtsi. All other (board-specific)
regulators must be defined together with proper voltages in the board DT.

What kind of mistake are you thinking of?

Thanks,
Stephan
