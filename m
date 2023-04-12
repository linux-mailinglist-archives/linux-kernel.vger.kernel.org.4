Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBF216DEC16
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 08:49:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229754AbjDLGtt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 02:49:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbjDLGts (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 02:49:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F935199;
        Tue, 11 Apr 2023 23:49:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BC52062E93;
        Wed, 12 Apr 2023 06:49:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F9BCC433D2;
        Wed, 12 Apr 2023 06:49:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681282186;
        bh=FI6luPqi9WmXR5nNQLmqp2fp++H9K/zl4E+074hTFQE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=iMKPj63ds0rG/v6oXAUq+yfZf6oHmpzNAZ4DV5NEoNaSneXwJ9V/nNKF2twXO28+a
         Lv30UvfMTIY7bjfQ37JPx9VhKPlzr3346+Jj2OM9z19/7tVWeyLGMsMf6AL+TDRfXX
         PZbk8nHsr1Iebo7BsDo2r0dKtnDs59HvAj4oCD932l6k2Bt+7DsdcN9Wqxzz83mu8/
         DDK3mu/pGrjvsC5tb9wwe18uLMtUue211qQhlwd/hh14Hol04xZT9DbNYX8xGKpOly
         RgVjdwpk3PeUf0REb39jpFYrgqoFVeWJEBLgSzRXQxv0TdfIQFLqyoCmk7l4CuYwTV
         ao+E4OjYvhgaw==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1pmUIb-0003XJ-RZ; Wed, 12 Apr 2023 08:49:45 +0200
Date:   Wed, 12 Apr 2023 08:49:45 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: qcom: sc8280xp-lenovo-thinkpad: correct pin
 drive-strength
Message-ID: <ZDZUiW+74rhhRAfS@hovoldconsulting.com>
References: <20230407180710.128815-1-krzysztof.kozlowski@linaro.org>
 <ZDVtXkCON8DFUDjh@hovoldconsulting.com>
 <887eb9f6-9882-37c6-4332-ddae7a354187@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <887eb9f6-9882-37c6-4332-ddae7a354187@linaro.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 11, 2023 at 06:58:33PM +0200, Krzysztof Kozlowski wrote:
> On 11/04/2023 16:23, Johan Hovold wrote:
> > On Fri, Apr 07, 2023 at 08:07:10PM +0200, Krzysztof Kozlowski wrote:
> >> Fix typo in drive-strength property name.
> > 
> > In the future, please try to use the established commit-summary prefix.
> > In this case:
> > 
> > 	arm64: dts: qcom: sc8280xp-x13s:
> 
> Sure.
> 
> commit ca1ce7207e53cfe69aee5002eb3795069668da53
> Author: Johan Hovold <johan+linaro@kernel.org>
> Date:   Fri Aug 5 11:23:17 2022 +0200
> 
>     arm64: dts: qcom: sc8280xp-lenovo-thinkpad-x13s: add alternate touchpad

Yeah, we initially used a longer prefix (including "x13s" which was
missing in the Subject of this patch), but quite soon decided on using
the shorter

	arm64: dts: qcom: sc8280xp-x13s:

instead.

Johan
