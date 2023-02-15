Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44A9F698221
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Feb 2023 18:33:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230097AbjBORdM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Feb 2023 12:33:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229602AbjBORdK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Feb 2023 12:33:10 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E6673A85E;
        Wed, 15 Feb 2023 09:32:41 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5F7DA61CED;
        Wed, 15 Feb 2023 17:32:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1879C433D2;
        Wed, 15 Feb 2023 17:32:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676482360;
        bh=btHN4KPeGDnP6GeQ9Z4p/qE9+1w96seQZaYeYz1UuNM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qebiRtbolcZkB6GqgWSUxjyB5o1EZPO0kOeNVFRFNCiA5AKDbf4fd2jKj6izRWh0K
         OInfG5Baz/pCYNS/lVDVNk0AExvZLCDhQvisk/yFTo/D/uZ/6dyzzUhUI6bN67OqoZ
         OYE5AKeWF4rk6VKd/DWVUHsnxTM+5OuyUtviRIBBFKYEZmNU0DZBQg5gX/m5OHq8oI
         Yvk7uT8Z72EMCCADQQeS74Ws65UT+Qd11FG9+isLKOoriT1pFgZHWlthIxga0W430N
         C/aki0rb3aJ+sgGGjXQ4ets9sf/WnZaljR2Z25+5KBj58S49GJf16VX0KQ0XGsJm1m
         dDOP5FdDeXoHA==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1pSLez-0002wN-SO; Wed, 15 Feb 2023 18:33:37 +0100
Date:   Wed, 15 Feb 2023 18:33:37 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Johan Hovold <johan+linaro@kernel.org>
Cc:     Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] arm64: dts: sc8280xp-crd: fix external display
 'data-lanes'
Message-ID: <Y+0XcU3xZA2w06o4@hovoldconsulting.com>
References: <20230215164524.1335-1-johan+linaro@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230215164524.1335-1-johan+linaro@kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 15, 2023 at 05:45:23PM +0100, Johan Hovold wrote:
> The 'data-lanes' property belongs in the controller node but was
> erroneously moved to the endpoint nodes in the last revision of the
> external display series:
> 
> 	[drm] Invalid property "data-lanes", default max DP lanes = 4
> 
> Fixes: bc9a747ae91f ("arm64: dts: qcom: sc8280xp-crd: Introduce pmic_glink")
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> ---

Please disregard these patches which are only needed for 6.2 backports
of the above mentioned series.

Sorry about the noise.

Johan
