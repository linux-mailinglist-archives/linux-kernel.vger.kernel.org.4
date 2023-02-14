Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01D39696587
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 14:58:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232855AbjBNN6O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 08:58:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232603AbjBNN6M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 08:58:12 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 035AB298F4;
        Tue, 14 Feb 2023 05:57:44 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4B326B81D85;
        Tue, 14 Feb 2023 13:57:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 186AFC433EF;
        Tue, 14 Feb 2023 13:57:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676383058;
        bh=paS2uSTC3Y1cMzECXhLdYhnK8pqSvSQtR2m6B50tay8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ilO+2WdNOpmbVYUoJ9coNkhx/8X/p/H7yUfTgWyfLLZk7XjkvShOOrxtwFHcGJjcE
         3HR+6fmC2cJv9pIwVSjqV+8pm2zvNL82AgjoePB0EUr9wPHae81kvzTyby5CuIzeB2
         aTqqUFFlD2dVdwqyNpJPSnX+rUdQ64yWODX7vXCtKZOO64O89eK+RCIIBiUsa0cITQ
         RrQiIRsd4D3yA3AArIEs0xTUqD8ukcySnXe6xquei1EgCIeeeaT+KHslrWfcc+Ef2F
         pmqpgyXw+EBSZ6mQeyusrwF3wei3DiOcuLba/CEfOgoSUSi/GwNdhAfwIe8fp8vf9Y
         A8L+DMap+SNvQ==
Date:   Tue, 14 Feb 2023 19:27:33 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Neil Armstrong <neil.armstrong@linaro.org>
Cc:     Kishon Vijay Abraham I <kishon@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Rob Herring <robh@kernel.org>, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: phy: amlogic,g12a-usb3-pcie-phy: add
 missing optional phy-supply property
Message-ID: <Y+uTTcTM++F1gg09@matsya>
References: <20230207-b4-amlogic-amlogic-g12a-usb3-pcie-phy-fix-v1-1-3e437b759549@linaro.org>
 <Y+Z5xOlAeqO6JyIj@matsya>
 <f727dd7d-08a8-acdf-316c-d571e36a4b1e@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f727dd7d-08a8-acdf-316c-d571e36a4b1e@linaro.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11-02-23, 14:49, Neil Armstrong wrote:
> Le 10/02/2023 à 18:07, Vinod Koul a écrit :
> > On 07-02-23, 16:03, Neil Armstrong wrote:
> > > Add missing optional phy-supply property used to power up PHY regulators.
> > > 
> > > Fixes: 87a55485f2fc ("dt-bindings: phy: meson-g12a-usb3-pcie-phy: convert to yaml")
> > > Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> > > ---
> > >   .../devicetree/bindings/phy/amlogic,g12a-usb3-pcie-phy.yaml          | 5 +++++
> > 
> > I dont have this file in my tree, what was this based on?
> 
> It has been renamed in a previous patch by Heiner: https://lore.kernel.org/all/8d960029-e94d-224b-911f-03e5deb47ebc@gmail.com/

Thanks for letting me know, I have merged fixes which had above and
applied this

-- 
~Vinod
