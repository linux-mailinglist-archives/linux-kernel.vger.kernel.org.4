Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 508A4728036
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 14:40:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236251AbjFHMkF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 08:40:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236281AbjFHMjx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 08:39:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61CBCE62;
        Thu,  8 Jun 2023 05:39:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F2CEF64CEB;
        Thu,  8 Jun 2023 12:39:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B2CEC433D2;
        Thu,  8 Jun 2023 12:39:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686227991;
        bh=HEJCQXhlFU8K5G9MVGjIFc2v8j1rgUCTywnobuzpZVM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=L4Tmvmx4JVDuDKYU3b8VRkiVQQaqeMOvkQ9h4UBOhnsN8dwHK/mXxsrAaByh4P32S
         krRam9PmJqtxHU+dmOhx3eC2yHPCEKNX04pJ07DK5o4Tmj2TpzFH1xLGTpmFgBgMDJ
         ZzskwNwWRAn4x2e+tfliRLbTqB54jXnXtciRXCS/5Esf1GhwOlntLJU1fliIRyfDNR
         bW8wftX2cTn0Et36gVOIBdmMUA/pc7DtC7BzJbk9UVddevSQl2UXI3smuH8VnOUkUB
         5r2RM19H8czcGpOywrTEkWIZBKdyJ1fKRYBU3ZmdVrLyx1LuOIDFAhSRP0zWKFO5bt
         62vNW4yEWWMxA==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1q7Ew4-0006ep-0V; Thu, 08 Jun 2023 14:40:16 +0200
Date:   Thu, 8 Jun 2023 14:40:16 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     vkoul@kernel.org, andersson@kernel.org,
        yung-chuan.liao@linux.intel.com,
        pierre-louis.bossart@linux.intel.com, sanyog.r.kale@intel.com,
        linux-arm-msm@vger.kernel.org, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/4] soundwire: qcom: stablity fixes
Message-ID: <ZIHMMFtuDtvdpFAZ@hovoldconsulting.com>
References: <20230525133812.30841-1-srinivas.kandagatla@linaro.org>
 <ZH2l-UbMyLi5Uwph@hovoldconsulting.com>
 <5d6bcc6a-151e-ac21-2dd2-f72a91f562d5@linaro.org>
 <ZIGpYPrNYDlkRQIf@hovoldconsulting.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZIGpYPrNYDlkRQIf@hovoldconsulting.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 08, 2023 at 12:11:45PM +0200, Johan Hovold wrote:
> On Wed, Jun 07, 2023 at 10:36:40AM +0100, Srinivas Kandagatla wrote:

> No, not yet, but I just triggered the above once more after not having
> seen with my latest -rc5 branch for a while (e.g. 20 reboots?):
> 
> [   11.430131] qcom-soundwire 3210000.soundwire-controller: Qualcomm Soundwire controller v1.6.0 Registered
> [   11.431741] wcd938x_codec audio-codec: bound sdw:0:0217:010d:00:4 (ops wcd938x_sdw_component_ops [snd_soc_wcd938x_sdw])
> [   11.431933] wcd938x_codec audio-codec: bound sdw:0:0217:010d:00:3 (ops wcd938x_sdw_component_ops [snd_soc_wcd938x_sdw])
> [   11.435406] qcom-soundwire 3330000.soundwire-controller: Qualcomm Soundwire controller v1.6.0 Registered
> [   11.449286] qcom-soundwire 3250000.soundwire-controller: Qualcomm Soundwire controller v1.6.0 Registered
> [   11.450632] wsa883x-codec sdw:0:0217:0202:00:1: WSA883X Version 1_1, Variant: WSA8835_V2
> [   11.453155] wsa883x-codec sdw:0:0217:0202:00:1: WSA883X Version 1_1, Variant: WSA8835_V2
> [   11.456511] wsa883x-codec sdw:0:0217:0202:00:2: WSA883X Version 1_1, Variant: WSA8835_V2
> [   11.562623] q6apm-dai 3000000.remoteproc:glink-edge:gpr:service@1:dais: Adding to iommu group 23
> [   11.585766] snd-sc8280xp sound: ASoC: adding FE link failed
> [   11.585872] snd-sc8280xp sound: ASoC: topology: could not load header: -517
> [   11.586021] qcom-apm gprsvc:service:2:1: tplg component load failed-517
> [   11.586100] qcom-apm gprsvc:service:2:1: ASoC: error at snd_soc_component_probe on gprsvc:service:2:1: -22
> [   11.586530] snd-sc8280xp sound: ASoC: failed to instantiate card -22
> [   11.591831] snd-sc8280xp: probe of sound failed with error -22
> 
> I don't think I've ever seen it before dropping the runtime PM patch as
> you did in v2, and I hit it twice fairly quickly after dropping it. And
> now again.
> 
> I'm not saying that the runtime PM patch is necessarily correct, and
> perhaps it is just changes in timing that lead to the above, but we
> definitely have a bug here.

I searched my notes and realised that I have seen this once also with
the runtime pm patch. So the fact that happened to see it more often
after dropping it is likely due to changes in timing.

Looking at the above log it seems like we hit a probe deferral somewhere
as some resource is not available yet, and this is eventually turned
into a hard failure that breaks audio as the error is propagated up the
stack.

Johan
