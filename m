Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F736628188
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 14:43:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236008AbiKNNnV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 08:43:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236830AbiKNNnU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 08:43:20 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 354C1222A7;
        Mon, 14 Nov 2022 05:43:19 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C1099611A1;
        Mon, 14 Nov 2022 13:43:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1566EC433C1;
        Mon, 14 Nov 2022 13:43:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668433398;
        bh=+rUAKU4F4KMfNm2lJiU2VhM2X6gLYie65kUp+/R1TbQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=femIr9S38iUEetX6LwA3OOiXRE4wEr2LkJbNJjOu5CgRqhcWL3//6Ug066qNGvCrM
         UuFce4rz4qu+hyphkB3lgKKVVvonIImst51Sxl/KDncVolApHMQ5DJPXEvOZ/O88hH
         zSZ7IjTo+AnGnEwjLcc5GlbNFaXbCMxI77cgEieYv/AlFz7sNIVxavbqofhKHExWs7
         3Hmr8xFIFqm9o0kbHLQnQ5wHiB71NC0AOseFG4wJQ+Kptg6EmAfSQercWrLWUwREKM
         gU8/UlMnZqSAaT/eUdeqIgKNfKp6wshgrANf15wEJGfolE7GSCdyRG66X3FJBtS8MQ
         HScypD5Z/PBkw==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1ouZjZ-000336-Tr; Mon, 14 Nov 2022 14:42:45 +0100
Date:   Mon, 14 Nov 2022 14:42:45 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Johan Hovold <johan+linaro@kernel.org>,
        Vinod Koul <vkoul@kernel.org>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 05/14] phy: qcom-qmp-combo: register clocks sooner
Message-ID: <Y3JF1Yb2cEe9CQCZ@hovoldconsulting.com>
References: <20221111092457.10546-1-johan+linaro@kernel.org>
 <20221111092457.10546-6-johan+linaro@kernel.org>
 <9c94f81c-963e-d1a3-6514-f803bb7e05fa@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9c94f81c-963e-d1a3-6514-f803bb7e05fa@linaro.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 12, 2022 at 02:15:04PM +0300, Dmitry Baryshkov wrote:
> On 11/11/2022 12:24, Johan Hovold wrote:
> > Runtime PM should be enabled before registering the PHYs, but there is
> > no reason that the clocks can not be registered before enabling runtime
> > PM.
> 
> This will have a side effect of DP and pipe clocks not using runtime PM 
> during the clocks operations (see the code handling rpm_enabled in 
> drivers/clk/clk.c). If this is an intended change, it should be 
> described in the commit message.

Good catch. I'll drop this one.

Johan
