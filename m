Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37B17628615
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 17:54:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235675AbiKNQyQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 11:54:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237409AbiKNQyF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 11:54:05 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C63DDDF5C;
        Mon, 14 Nov 2022 08:54:04 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 62056612F0;
        Mon, 14 Nov 2022 16:54:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B69FEC433D6;
        Mon, 14 Nov 2022 16:54:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668444843;
        bh=XXjdo254kFi84g2UiUO6+gdpm1EHkbVBYoKzVnLnrAg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=D6NEQPVRltTt8BTRjtVYUDZlCmgFdteA5eiWY/is3pUOV/tYGl8mdCsIPQU10aq58
         su0BLPfzS2J1UfG2WVgpdPmk0sMNl1h5R/XnNBzZKNXHiQX6BCTZxfpIv05K8dH7hB
         f9+8g87nE7tiilTDnYYtpMhxS4UJd280x/3OrF/KxOyGEQr1asmqKqaSzlEkl/afPL
         IzlTaMhGFJMGmVIh70SS6gJzZXia2mUvdjmpDX0cxFSJ+ROBtQDtfysyYjhDYL6VjX
         0aMyupdHAAzz9+N9D96rH7oqvgyUOnqSGDD8AxlJjuFoNPE3RwSYMwptfM3X5YhY7d
         zEinuZgqGSZNA==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1ouciB-0005Hx-Vc; Mon, 14 Nov 2022 17:53:32 +0100
Date:   Mon, 14 Nov 2022 17:53:31 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Johan Hovold <johan+linaro@kernel.org>,
        Vinod Koul <vkoul@kernel.org>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 02/14] dt-bindings: phy: qcom,qmp-usb3-dp: fix sc8280xp
 bindings
Message-ID: <Y3Jyi+PdKOSlTGi1@hovoldconsulting.com>
References: <20221111092457.10546-3-johan+linaro@kernel.org>
 <a22888cd-34cb-3453-0dc2-096da208564c@linaro.org>
 <Y3JCVzJ74YsfcDz4@hovoldconsulting.com>
 <de3a426a-03e8-ed15-a9a1-bb300e776e5f@linaro.org>
 <Y3JOO0kNnaNhnW3K@hovoldconsulting.com>
 <78cda6f8-849c-219a-8dbb-966c283c1a92@linaro.org>
 <Y3Jg/qmMW3rC5Okc@hovoldconsulting.com>
 <bcc327b6-c38b-86a9-34cb-440ad33df210@linaro.org>
 <Y3Jv4ePkPiKiG8wj@hovoldconsulting.com>
 <5920660e-34e4-8a6b-7d99-ba0511e2c86a@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5920660e-34e4-8a6b-7d99-ba0511e2c86a@linaro.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 14, 2022 at 07:51:31PM +0300, Dmitry Baryshkov wrote:
> On 14/11/2022 19:42, Johan Hovold wrote:
> > On Mon, Nov 14, 2022 at 07:14:48PM +0300, Dmitry Baryshkov wrote:

> >> Ugh. Please, no. We have symbol clocks for UFS PHY, USB+DP clocks for
> >> USB+DP PHY, but let's not go for the unified clocks index definition.
> > 
> > Yeah, this is the kind of issues I wanted to avoid by not using a per
> > SoC header for three clocks which will almost always use the same
> > indexes.
> > 
> > Because how can you be sure that your unified per-PHY type defines will
> > never have to be amended? Or some index left out?
> > 
> > The only way then is to have per-SoC defines which is a pain to
> > maintain (just consider that driver mapping table when some odd SoC
> > shows up).
> 
> My vote is definitely against a per-SoC defines.

Simply stating that doesn't address the problem I was trying to
describe.

Johan
