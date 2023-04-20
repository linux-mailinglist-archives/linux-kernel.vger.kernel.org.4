Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B95A96E8BED
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 09:56:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234216AbjDTH4z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Apr 2023 03:56:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234145AbjDTH4u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Apr 2023 03:56:50 -0400
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [85.215.255.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 463F99F;
        Thu, 20 Apr 2023 00:56:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1681977402; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=Hbag0RAoEZRHvnf+y2hVaDNPqbwgAHBK4tdVDOoGA0slfcyetg5zGA4jeL2WLZ71SD
    so+3sLWUqkPgLEmMh/yb1KqRuUbKUgQHr7Kwwo+S6IbmY8xiPtrK0G8L5dYotFREQlWN
    w58BGe5/rHxHBr+zI6ShQZkZxvjYt4pbcfrbnd0WC7g8jFzoBAJblzQeTUbe/ty+73G5
    qQq8kzTEBdtMnnGzneyfzviyABpZOlFWr3ypox+p/p5+I846Xo0FRQD4aRZSyOcPVfIY
    9lltigyX9U0JTMy62/a6FrThU2Q7eP4B9BreIoW3P/S++o4l/+hms9PQ8AyOCUBpW3Y/
    TPew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1681977402;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=E1r58knnZcTJfyLKMrluT0Wkf1/93vrtGp+3WtvroyE=;
    b=TgnIIVsur2yWffR0YyQYZj0dH0+oLsJahupuiEtbyD/fMTChXVB4i8lVma4KNkyz6G
    kcElOEuWrCn4U0f0c4iJt5X/UkpknyakhdpO1oNLaS/gnbvNBseqzyheiKf0TB++Tb8P
    rmgzUevhWznIpH4E1UZrXMGj8/3MaYt3VWUIuzJbPgK68JKbd86a8UCBBag68hK05dA9
    AHvxE5gwu4bSDT32b7M4ukDvYJ7Ngwf/E/Yr2jH4uY5/aM81IXIA2Qt4eMTUVjHalzqQ
    buQ2LNgeGiP8aM9nUubkzfaldbBd0uEPlgk2km7viSEoK52hIcipvmtPa4wcHieKpd8l
    vnvw==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1681977402;
    s=strato-dkim-0002; d=gerhold.net;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=E1r58knnZcTJfyLKMrluT0Wkf1/93vrtGp+3WtvroyE=;
    b=kmkJymG7M1pR1/W+ZvItc9JkLDGphnDLxf32ZKdW2UPNX+djr8nykW4cBDMrlpw7PF
    MKAjT7b61tpGpfiVRZ1HGDi3dGHjHfgbjuQpOJEpYQjv5OoDFVGaXK4X2aFWGNZWTqF5
    S19GxdGyChBD3JAtjP56TL+HJY8IVf88YHFNEVl+QjQ3XDOe7ih2Zljs3k0xEY+CI84z
    /XYF4b7haOncpuAwglqJtHC8t5/KYr2eQvSCaTvtHo4BfwOcMW7VD/t5Cp9KZwU9xetX
    KPOcZ9PnvP++Kwb4K/E6/iPs6FkjpgyWPxzMW5cflWiQly1irrvcrFzEYL/HO4+U1kmv
    Hgow==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1681977402;
    s=strato-dkim-0003; d=gerhold.net;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=E1r58knnZcTJfyLKMrluT0Wkf1/93vrtGp+3WtvroyE=;
    b=tL3qDVz3v5OOC6iwNpXe+7eoR9pUkKDRIPDY6qK6pQmJKfYiSFeuRXbmDIHu2E7kHx
    SlRBOSHzhS8/PRBiRaAQ==
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVOQ/OcYgojyw4j34+u261EJF5OxJD4paA8Z2F1A=="
Received: from gerhold.net
    by smtp.strato.de (RZmta 49.4.0 DYNA|AUTH)
    with ESMTPSA id j6420az3K7ugnHn
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Thu, 20 Apr 2023 09:56:42 +0200 (CEST)
Date:   Thu, 20 Apr 2023 09:56:36 +0200
From:   Stephan Gerhold <stephan@gerhold.net>
To:     Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        devicetree@vger.kernel.org, Shawn Guo <shawn.guo@linaro.org>,
        Taniya Das <quic_tdas@quicinc.com>
Subject: Re: [PATCH RFT v2 00/14] SMD RPMCC sleep preparations
Message-ID: <ZEDwLB3RwT6mHIu4@gerhold.net>
References: <20230303-topic-rpmcc_sleep-v2-0-ae80a325fe94@linaro.org>
 <66c41caf-bf21-61af-c6e4-52b34b69c1ce@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <66c41caf-bf21-61af-c6e4-52b34b69c1ce@linaro.org>
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

On Thu, Apr 20, 2023 at 03:50:16AM +0200, Konrad Dybcio wrote:
> On 8.03.2023 22:35, Konrad Dybcio wrote:
> > Keepalive clocks for other platforms were gathered by digging in old
> > downstream kernels, please give them a test.
> I have an implementation of rpmcc-within-icc ready(ish) locally. Turns out
> some SoCs need a keepalive (19.2MHz, active-only) vote on clocks that
> are NOT governed by interconnect.. So before we can disable clocks,
> both will need to be implemented.. ugh... I was hoping we could avoid
> having it in rpmcc..
> 

Can you give an example? Which clocks are affected on which SoC?

Thanks,
Stephan
