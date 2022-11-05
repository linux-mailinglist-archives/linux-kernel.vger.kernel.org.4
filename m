Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B1D061DB02
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Nov 2022 15:36:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229693AbiKEOgm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Nov 2022 10:36:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbiKEOgk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Nov 2022 10:36:40 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75C34DF88;
        Sat,  5 Nov 2022 07:36:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1FDEAB8016A;
        Sat,  5 Nov 2022 14:36:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D78FBC433D6;
        Sat,  5 Nov 2022 14:36:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667658996;
        bh=52TKqIbhnS62Q/72czcmLXuVPsKn8wYMZw9uC8i06Ks=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JlLT3q1RETlC0q1kSaJZlmL0yRjHKpzr4uMdnW3YBisdDg4apo+yn8oDhbFsjFnr+
         8e+SZh/2UNV5qFXhfnLskoJ9IA/8R6h98bNPbWo7NiTOBTCx7UaBiBfAu4cdnBGyQE
         zvRQVJBZDAD3Is6NOuc7jDJio1+Kxh4NWKzPXyYukgWy9neXi8Ou/np0MmVldmbG+j
         uWwtOxkExRZP+vwrzFttDbBcNSy3BK1Zd+/chOA7TdHIa8aCWPflH9GfALI2Q5oDxf
         VVy12aQwEun5liImB0oAHOiM+LheKziyXZsFZwd/lGrD7Mq3YooUJnrUk9A5lILVlG
         tkcAwoFaoylRA==
Date:   Sat, 5 Nov 2022 20:06:32 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Siddharth Vadapalli <s-vadapalli@ti.com>
Cc:     robh+dt@kernel.org, lee@kernel.org, krzysztof.kozlowski@linaro.org,
        krzysztof.kozlowski+dt@linaro.org, kishon@kernel.org,
        dan.carpenter@oracle.com, rogerq@kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-phy@lists.infradead.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v3 0/3] Add support to PHY GMII SEL for J721e CPSW9G
 QSGMII
Message-ID: <Y2Z08OqiY2aYmgbN@matsya>
References: <20221026074532.109220-1-s-vadapalli@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221026074532.109220-1-s-vadapalli@ti.com>
X-Spam-Status: No, score=-8.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26-10-22, 13:15, Siddharth Vadapalli wrote:
> Add compatible for J721e CPSW9G, which contains 8 external ports and 1
> internal host port.
> 
> Update existing approach of using compatible to differentiate between
> devices that support QSGMII mode and those that don't. The new
> approach involves storing the number of qsgmii main ports for the device
> in the num_qsgmii_main_ports member of the "struct phy_gmii_sel_soc_data".
> This approach makes it scalable for newer devices.

Applied, thanks

-- 
~Vinod
