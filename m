Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FDAD628043
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 14:04:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237753AbiKNNE1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 08:04:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237750AbiKNNEY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 08:04:24 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C50727DDA;
        Mon, 14 Nov 2022 05:04:24 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 09A936117E;
        Mon, 14 Nov 2022 13:04:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CA3BC433C1;
        Mon, 14 Nov 2022 13:04:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668431063;
        bh=B8vw6qZp1pAdTc0xkFcFrwXOTcOIyVYrxMXbsKmlHSo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=iLyerZK1InQ8OyNqlEdaHZAmAzfxqIrN+EaSobimUtA3S5xPZA06hIatGXMCGJvAn
         3hLPt6LNZayKDMC6tLu05P/PtJ1RH7LiTHN+IjNAk2e3/H24n2UBcQgdxmg0506egE
         hl7LQmKcsKsll7LActV8R++9ndv2PZvCPdrgvxbGv8H1SlAyIzP9nigHw4jzyNZTOh
         4ryeEF/WSdauM1I8BMdZ62bZrgdTwmuHTrRCdt7dpZtXxF/6scgNP/PnXv8D6ylDFy
         t5EFVSIS28TUWR4ixRa38Ty6sGSW6Uo/NqH6jhmU9CLO123ZPTZDrjL75nxldHpD7I
         IKKWUNY5Ucaag==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1ouZ7v-0002Yl-Ig; Mon, 14 Nov 2022 14:03:51 +0100
Date:   Mon, 14 Nov 2022 14:03:51 +0100
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
Subject: Re: [PATCH 03/14] phy: qcom-qmp-combo: drop v4 reference-clock source
Message-ID: <Y3I8t6it7DN0Id1G@hovoldconsulting.com>
References: <20221111092457.10546-1-johan+linaro@kernel.org>
 <20221111092457.10546-4-johan+linaro@kernel.org>
 <14f01c33-dada-b66a-f81a-74b9028de18b@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <14f01c33-dada-b66a-f81a-74b9028de18b@linaro.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 12, 2022 at 02:43:38PM +0300, Dmitry Baryshkov wrote:
> On 11/11/2022 12:24, Johan Hovold wrote:
> > The source clock for the reference clock should not be described by the
> > devicetree and instead this relationship should be modelled in the clock
> > driver.
> 
> Do we have a fix for the gcc driver?

Bjorn is preparing one, but there's no need to wait for that to be
merged in this case (we have a ton of references on CXO, we need to get
the binding fixed in 6.2, and some other reasons which Bjorn may be able
to share soon).

Johan
