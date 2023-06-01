Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77C7E719D94
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 15:24:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233708AbjFANY1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 09:24:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233680AbjFANYV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 09:24:21 -0400
Received: from mo4-p02-ob.smtp.rzone.de (mo4-p02-ob.smtp.rzone.de [85.215.255.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4295B18B;
        Thu,  1 Jun 2023 06:24:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1685625842; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=OvrQi6xwiSOl51UAj0sbpstp1aMeFXizgR+AcOnA05xRkANONwggZPWSD7DUP7t1U8
    hytku5gpOOHQYF6GG8kV7mW2s2g/R6MyK/3w47dFdFgzLPi5gSYkKOfUnXqpkBX9gYVM
    jVQYecFxocDTsuwaAKFbvSkgUEjDTgNHBpBBSJM9hP2b6NZeQ2Sh7wCpmJrl+eyNtdFf
    UHpybc3TlWVM/A6qDMkZA9i/6sHsqNN25eeNPl90yNgufL+/iVFLw8axXtTSN3LE2eyt
    z13m983xmRN5Rozh+NMyfXnlIqgfM5UvdNG0rLjHwjxRRHGvoRFDGGlNU8+bQDIr5swL
    XW7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1685625842;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=kNUc3S3XogQ0VF7HcUekoP34KC4EmtP6xFRyzWbSzyo=;
    b=Fp3z14ReQ3lydE3PgGdQFkbHsSYIaOsku/rOW07JmWkVnSkP8H8cXpFt/1QmdghFcY
    yrpmXi0m8bwRtf+A3LDtIRj77pUaM9AbMjEoDqHOb2O+ieb/lmhDK/mxQiI0SxT30UK6
    aCgFVHai4QG3P/mXpULOzgevgFFd+PkfFa0cRwlakfBN9tjBVYAOBJRaK4h9KpD4lOOg
    guglHTmYqxFidZcrSX1VW+aIFRrTesLov7N4YDK3KoBech+A59Fq5JyiHIQ4mw7SNBgH
    Rz+8WXOFN1BIXC3gEMRonOD3stXpE817fv8ncxMY7SUrA3X6VMOz8KyrvuKhjGOkWrzn
    lj0A==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo02
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1685625842;
    s=strato-dkim-0002; d=gerhold.net;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=kNUc3S3XogQ0VF7HcUekoP34KC4EmtP6xFRyzWbSzyo=;
    b=UmSov0H3w2G+wCgZM8WM14amuLFFSWwKMVVGWzxZeywK7cviCCjRjQSQp+snYbTUjk
    5abMlscAvbLmzCIn1jsWcp0nTFwusjYHAvAjPNzB5m6yHUGcQ5s0ZIDGD0iTYz8lE9GW
    p2BU5iwvx88hgA6HwRPWtjb0vFlWiBzhZYzjhISTfwhTZhqiKSFvwdPibWVhWKM+9a7b
    AnZ5c3E1fceLuHZqLBMKIrvfcWG/qnoTN3/9rXLzrIhGBrsq6aK7skvIIynCLUrGj1US
    cmlI4NV46AsvsOQbLHTp+DC82alSCSJhSuozDlpzmPJojHOJJ/LvmcfWZHUc88yTwPU7
    YQxg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1685625842;
    s=strato-dkim-0003; d=gerhold.net;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=kNUc3S3XogQ0VF7HcUekoP34KC4EmtP6xFRyzWbSzyo=;
    b=mbPYcGyWeROON/dOydGssnXGvKZni4lYihEn5cJ9ECPs+LX++5FcVd1uZoVXg8COW6
    jhv6Udg2/3GISdavb5BQ==
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVOQ/OcYgojyw4j34+u261EJF5OxJD4peA9J/h"
Received: from gerhold.net
    by smtp.strato.de (RZmta 49.4.0 DYNA|AUTH)
    with ESMTPSA id j6420az51DO1rCh
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Thu, 1 Jun 2023 15:24:01 +0200 (CEST)
Date:   Thu, 1 Jun 2023 15:23:55 +0200
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
Message-ID: <ZHib62imkvHds-9a@gerhold.net>
References: <20230526-topic-smd_icc-v1-0-1bf8e6663c4e@linaro.org>
 <20230526-topic-smd_icc-v1-20-1bf8e6663c4e@linaro.org>
 <5a26e456-fe45-6def-27f9-26ec00c333e6@linaro.org>
 <ZHZIVJFd-HU_AO2F@gerhold.net>
 <4943572a-3456-ae33-387f-db476ff382e4@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4943572a-3456-ae33-387f-db476ff382e4@linaro.org>
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 01, 2023 at 02:43:50PM +0200, Konrad Dybcio wrote:
> On 30.05.2023 21:02, Stephan Gerhold wrote:
> > On Tue, May 30, 2023 at 06:32:04PM +0200, Konrad Dybcio wrote:
> >> On 30.05.2023 12:20, Konrad Dybcio wrote:
> >>> Ever since the introduction of SMD RPM ICC, we've been dividing the
> >>> clock rate by the wrong bus width. This has resulted in:
> >>>
> >>> - setting wrong (mostly too low) rates, affecting performance
> >>>   - most often /2 or /4
> >>>   - things like DDR never hit their full potential
> >>>   - the rates were only correct if src bus width == dst bus width
> >>>     for all src, dst pairs on a given bus
> >>>
> >>> - Qualcomm using the same wrong logic in their BSP driver in msm-5.x
> >>>   that ships in production devices today
> >>>
> >>> - me losing my sanity trying to find this
> >>>
> >>> Resolve it by using dst_qn, if it exists.
> >>>
> >>> Fixes: 5e4e6c4d3ae0 ("interconnect: qcom: Add QCS404 interconnect provider driver")
> >>> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> >>> ---
> >> The problem is deeper.
> >>
> >> Chatting with Stephan (+CC), we tackled a few issues (that I will send
> >> fixes for in v2):
> >>
> >> 1. qcom_icc_rpm_set() should take per-node (src_qn->sum_avg, dst_qn->sum_avg)
> >>    and NOT aggregated bw (unless you want ALL of your nodes on a given provider
> >>    to "go very fast")
> >>
> >> 2. the aggregate bw/clk rate calculation should use the node-specific bus widths
> >>    and not only the bus width of the src/dst node, otherwise the average bw
> >>    values will be utterly meaningless
> >>
> > 
> > The peak bandwidth / clock rate is wrong as well if you have two paths
> > with different buswidths on the same bus/NoC. (If someone is interested
> > in details I can post my specific example I had in the chat, it shows
> > this more clearly.)
> agg_peak takes care of that, I believe..
> 

I was just nitpicking on your description here, I think the solution
you/we had in mind was already correct. :)

> 
> > 
> >> 3. thanks to (1) and (2) qcom_icc_bus_aggregate() can be remodeled to instead
> >>    calculate the clock rates for the two rpm contexts, which we can then max()
> >>    and pass on to the ratesetting call
> >>
> > 
> > Sounds good.
> > 
> >>
> >> ----8<---- Cutting off Stephan's seal of approval, this is my thinking ----
> >>
> >> 4. I *think* Qualcomm really made a mistake in their msm-5.4 driver where they
> >>    took most of the logic from the current -next state and should have been
> >>    setting the rate based on the *DST* provider, or at least that's my
> >>    understanding trying to read the "known good" msm-4.19 driver
> >>    (which remembers msm-3.0 lol).. Or maybe we should keep src but ensure there's
> >>    also a final (dst, dst) vote cast:
> >>
> >> provider->inter_set = false // current state upstream
> >>
> >> setting apps_proc<->slv_bimc_snoc
> >> setting mas_bimc_snoc<->slv_snoc_cnoc
> >> setting mas_snoc_cnoc<->qhs_sdc2
> >>
> >>
> >> provider->inter_set = true // I don't think there's effectively a difference?
> >>
> >> setting apps_proc<->slv_bimc_snoc
> >> setting slv_bimc_snoc<->mas_bimc_snoc
> >> setting mas_bimc_snoc<->slv_snoc_cnoc
> >> setting slv_snoc_cnoc<->mas_snoc_cnoc
> >> setting mas_snoc_cnoc<->qhs_sdc2
> >>
> > 
> > I think with our proposed changes above it does no longer matter if a
> > node is passed as "src" or "dst". This means in your example above you
> > just waste additional time setting the bandwidth twice for
> > slv_bimc_snoc, mas_bimc_snoc, slv_snoc_cnoc and mas_snoc_cnoc.
> > The final outcome is the same with or without "inter_set".
> Yeah I guess due to the fact that two "real" nodes are always
> connected by a set of "gateway" nodes, the rate will be applied..
> 
> I am however not sure if we're supposed to set the bandwidth
> (via qcom_icc_rpm_set()) on all of them..
> 

I think so? The nodes RPM doesn't care about shouldn't have
a slv/mas_rpm_id.
