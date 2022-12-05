Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 585C86427E4
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 12:56:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230439AbiLEL4F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 06:56:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230000AbiLELz4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 06:55:56 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3202FF67;
        Mon,  5 Dec 2022 03:55:56 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CCB9A61030;
        Mon,  5 Dec 2022 11:55:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 239C0C433D6;
        Mon,  5 Dec 2022 11:55:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670241355;
        bh=hpUDB7E/tcmMY7Xhkghn2/PcoLFJKUt0sZ4ikT/iv5o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bkUR3HuwYkpKevxDhCFd/zEPJ6WwKIM88AI4Or8OycKE4mVQrZdQYHx68KddLUmeo
         KYZQREq2LKCwB1MaSN5QFdosqBcInbUystpld39JTdZWpWCwiRnqXXmKl6J9vDY+5R
         av9ETh/t76OxVNuwUGNbcmkkcLBN9kwhDtu/DNWrM4+D7oOeoW3P1+s7beTSDGgr9L
         igoHVVOpbAfAGkKvQAsQuHHr7q4Ee7LiIh2Ok15D8nOn9O/EGhj8HHvZXDkHBpRB/9
         veO8VgzF1C56mOLGFc+kVu/L/Upn9nvAXSQgNwjCKfogl/OHHlesyn/RI5ddrKrmcK
         HrexNAwxQB06Q==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1p2A4m-0008Op-8u; Mon, 05 Dec 2022 12:56:00 +0100
Date:   Mon, 5 Dec 2022 12:56:00 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Johan Hovold <johan+linaro@kernel.org>,
        Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 15/15] arm64: dts: qcom: sc8280xp: fix USB-DP PHY nodes
Message-ID: <Y43cUGf0qUOIXRgZ@hovoldconsulting.com>
References: <20221121085058.31213-1-johan+linaro@kernel.org>
 <20221121085058.31213-16-johan+linaro@kernel.org>
 <c91b13e2-ac74-153f-f19b-587ded948a75@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c91b13e2-ac74-153f-f19b-587ded948a75@linaro.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 01, 2022 at 03:12:13PM +0100, Krzysztof Kozlowski wrote:
> On 21/11/2022 09:50, Johan Hovold wrote:
> > Update the USB4-USB3-DP QMP PHY nodes to match the new binding which
> > specifically includes the missing register regions (e.g. DP_PHY) and
> > allows for supporting DisplayPort Alternate Mode.
> > 
> > Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> > Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> > ---

> Johan (and anyone also interested in this),
> 
> What are the next steps with this for older SoCs? Is there any plan to
> change the bindings and DTS for them in similar way?

Yeah, I think we should go ahead with that. Especially, as it seems 
some of the older platforms were never tested and the DTs were
incorrect to begin with.

I'll take a look at doing so when reviewing the latest revision of the
sm6350 series (which is moving to the new scheme).

Just have a couple of higher prio tasks to get out the door first.

Johan
