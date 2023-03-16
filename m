Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F8A66BD464
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 16:53:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230472AbjCPPxq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 11:53:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230015AbjCPPxo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 11:53:44 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB90DCA1D;
        Thu, 16 Mar 2023 08:53:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 28576B82272;
        Thu, 16 Mar 2023 15:53:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DAA5C433D2;
        Thu, 16 Mar 2023 15:53:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678982019;
        bh=Rj/V4HvM4lftSD7pR5Qhs+36gJgM/NfzJd5glSkQr/s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YIGG2QuV9M6wru4NUwa7EWkLGPBulz674i9mA5XOCE2CmTJ9uGsMePf+3NiFEKUof
         GKxNtKYUhHmtHzmLkjHnv2cFxHtSOyaHSM/HpxF3HfVYU6l1ZgceT4hRjDKcc1cMZX
         VCt70267hChSrXRbxqOvPKi75pPEcf2y1rgwCHZ81OIucGW56DqAL5zqMMF9OfQ3KP
         Be8pEZHxzFjGeq/heU9OwWJJhqPFEuMh3dyn9CcIs6tYLXnDe3bvp8hz4TX+t3R8JI
         nPmnIoub6qTFr45Q49rvmk/mypxAack4lCR7Fw4oAeJP2eDAoqN/MqPfX2plt/R0K8
         Upu0a5Emv/UMA==
Date:   Thu, 16 Mar 2023 15:53:33 +0000
From:   Lee Jones <lee@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        devicetree@vger.kernel.org, linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-amlogic@lists.infradead.org,
        linux-stm32@st-md-mailman.stormreply.com
Subject: Re: [PATCH] mfd: Use of_property_present() for testing DT property
 presence
Message-ID: <20230316155333.GL9667@google.com>
References: <20230310144712.1543379-1-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230310144712.1543379-1-robh@kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 10 Mar 2023, Rob Herring wrote:

> It is preferred to use typed property access functions (i.e.
> of_property_read_<type> functions) rather than low-level
> of_get_property/of_find_property functions for reading properties. As
> part of this, convert of_get_property/of_find_property calls to the
> recently added of_property_present() helper when we just want to test
> for presence of a property and nothing more.
>
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
>  drivers/mfd/bcm2835-pm.c | 2 +-
>  drivers/mfd/khadas-mcu.c | 2 +-
>  drivers/mfd/stmpe.c      | 2 +-
>  3 files changed, 3 insertions(+), 3 deletions(-)

Applied, thanks

--
Lee Jones [李琼斯]
