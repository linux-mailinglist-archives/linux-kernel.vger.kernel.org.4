Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7B54716D37
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 21:09:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232969AbjE3TJA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 15:09:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230104AbjE3TI6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 15:08:58 -0400
X-Greylist: delayed 177 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 30 May 2023 12:08:56 PDT
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [85.215.255.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECE108E;
        Tue, 30 May 2023 12:08:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1685473370; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=plssoWGxVp5BPYTx2+4C7urE+H41aEECJ2LdQps1jhkPqW1ez4mUuZjbOqBj1S07Lx
    hOH2dJFKlyCyN+JjEvnPFrf856NMl2MaLGYLFhzyYWLJ8ZKytEd5q2+tPRh+wsH7JS+f
    R97bfQpmv9vwvexplrNW1SWt3YvCZFeH6yt8Y0Z+2jXvyryUzzgvQzyz0ZfNg2xfwZ4U
    ehQ5iKvAWWrVq/YHntXz0T86+/0KyDHJ0TeMmdGOzCnOf9l6OPXgS2gSIp9xKvueugmj
    5sRyOtTempln229C+36uR1TNh0TYMZZJW4G4X34h7M+aaCWVRvJ5DAKLiRo/pQEtH+Zi
    mapQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1685473370;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=PBQJbM/1VwwL+Dwm7PX4+lP0VLh7Yt21pAuc2HfyKCA=;
    b=XHEMXZa9Yw6d5Uzm2a4kXHZLb8kA4PRaDrvuPNsku3vzl32xiu2e8sdcR9BUiq/jZL
    N5EjyLO4qceT/IDKiZz41qnsN5vKe/Z9gkL1YR3YXHAiReurPGzfOkNwOz/g/kZxy+Yf
    H74dJIJmGZFSHeyOdpEyCLIKDwyMvDt7LLVHeVLYGx+pQAMLdaUXc+Xv2ADIEGdKrccF
    zt5k1BR8AkKG25MJguVpQc5vKxCybYqfiwmR9MpSSV9Xsa/cAhr+5Q0DyCXts9WjkMG3
    pQFrRfV+tG/8gHByFjC4o9fVy3BjOzM2JMJpeWbgkc2I0NNhf67cGEOneDQFglF3NAj3
    d9YQ==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1685473370;
    s=strato-dkim-0002; d=gerhold.net;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=PBQJbM/1VwwL+Dwm7PX4+lP0VLh7Yt21pAuc2HfyKCA=;
    b=mUAfmPdGeTzBcVJckcuNUNHXly4Lg804KbJvST6kh1unODICF18xjD57kZpBBaS+yz
    uYZIqc8MQAknQfXxupFJtPFDKiNgfYxLBsaG0oTdTrXZTcZwOxx6r3uS6DFVoul80EpG
    WWS98bcXpoGPCQ1enl2neVlVWorrMEVTEUmwNXHzPna0M/SzlbQOp9NBhJ+3V18MeBkj
    t7jg13TVmODkCwSdjTLsdsIJzHIBZLVtiNUeGg4mDC3/q6gFGbldx2hRhC6Zgt86TXMS
    2X0xzbg4zs1EO4ZjqI7C38GxNAzZb2TpzzV81Mag1OsMuVl0P4c/tFXVFRUHsIYq7dnn
    MwrQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1685473370;
    s=strato-dkim-0003; d=gerhold.net;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=PBQJbM/1VwwL+Dwm7PX4+lP0VLh7Yt21pAuc2HfyKCA=;
    b=JAckuUGdbq4m5mJBc6CkK66c7uDrC5JXOFHgMaPEIVYxDf3SgRdl5c7afSdgJS7wcI
    eMzo5+kFfsXBi4hdw5Dg==
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVOQ/OcYgojyw4j34+u261EJF5OxJD4peA95nh"
Received: from gerhold.net
    by smtp.strato.de (RZmta 49.4.0 DYNA|AUTH)
    with ESMTPSA id j6420az4UJ2njmA
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Tue, 30 May 2023 21:02:49 +0200 (CEST)
Date:   Tue, 30 May 2023 21:02:44 +0200
From:   Stephan Gerhold <stephan@gerhold.net>
To:     Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Georgi Djakov <djakov@kernel.org>,
        Leo Yan <leo.yan@linaro.org>,
        Evan Green <evgreen@chromium.org>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH 20/20] interconnect: qcom: Divide clk rate by src node
 bus width
Message-ID: <ZHZIVJFd-HU_AO2F@gerhold.net>
References: <20230526-topic-smd_icc-v1-0-1bf8e6663c4e@linaro.org>
 <20230526-topic-smd_icc-v1-20-1bf8e6663c4e@linaro.org>
 <5a26e456-fe45-6def-27f9-26ec00c333e6@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5a26e456-fe45-6def-27f9-26ec00c333e6@linaro.org>
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

On Tue, May 30, 2023 at 06:32:04PM +0200, Konrad Dybcio wrote:
> On 30.05.2023 12:20, Konrad Dybcio wrote:
> > Ever since the introduction of SMD RPM ICC, we've been dividing the
> > clock rate by the wrong bus width. This has resulted in:
> > 
> > - setting wrong (mostly too low) rates, affecting performance
> >   - most often /2 or /4
> >   - things like DDR never hit their full potential
> >   - the rates were only correct if src bus width == dst bus width
> >     for all src, dst pairs on a given bus
> > 
> > - Qualcomm using the same wrong logic in their BSP driver in msm-5.x
> >   that ships in production devices today
> > 
> > - me losing my sanity trying to find this
> > 
> > Resolve it by using dst_qn, if it exists.
> > 
> > Fixes: 5e4e6c4d3ae0 ("interconnect: qcom: Add QCS404 interconnect provider driver")
> > Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> > ---
> The problem is deeper.
> 
> Chatting with Stephan (+CC), we tackled a few issues (that I will send
> fixes for in v2):
> 
> 1. qcom_icc_rpm_set() should take per-node (src_qn->sum_avg, dst_qn->sum_avg)
>    and NOT aggregated bw (unless you want ALL of your nodes on a given provider
>    to "go very fast")
> 
> 2. the aggregate bw/clk rate calculation should use the node-specific bus widths
>    and not only the bus width of the src/dst node, otherwise the average bw
>    values will be utterly meaningless
> 

The peak bandwidth / clock rate is wrong as well if you have two paths
with different buswidths on the same bus/NoC. (If someone is interested
in details I can post my specific example I had in the chat, it shows
this more clearly.)

> 3. thanks to (1) and (2) qcom_icc_bus_aggregate() can be remodeled to instead
>    calculate the clock rates for the two rpm contexts, which we can then max()
>    and pass on to the ratesetting call
> 

Sounds good.

> 
> ----8<---- Cutting off Stephan's seal of approval, this is my thinking ----
> 
> 4. I *think* Qualcomm really made a mistake in their msm-5.4 driver where they
>    took most of the logic from the current -next state and should have been
>    setting the rate based on the *DST* provider, or at least that's my
>    understanding trying to read the "known good" msm-4.19 driver
>    (which remembers msm-3.0 lol).. Or maybe we should keep src but ensure there's
>    also a final (dst, dst) vote cast:
> 
> provider->inter_set = false // current state upstream
> 
> setting apps_proc<->slv_bimc_snoc
> setting mas_bimc_snoc<->slv_snoc_cnoc
> setting mas_snoc_cnoc<->qhs_sdc2
> 
> 
> provider->inter_set = true // I don't think there's effectively a difference?
> 
> setting apps_proc<->slv_bimc_snoc
> setting slv_bimc_snoc<->mas_bimc_snoc
> setting mas_bimc_snoc<->slv_snoc_cnoc
> setting slv_snoc_cnoc<->mas_snoc_cnoc
> setting mas_snoc_cnoc<->qhs_sdc2
> 

I think with our proposed changes above it does no longer matter if a
node is passed as "src" or "dst". This means in your example above you
just waste additional time setting the bandwidth twice for
slv_bimc_snoc, mas_bimc_snoc, slv_snoc_cnoc and mas_snoc_cnoc.
The final outcome is the same with or without "inter_set".

Thanks,
Stephan
