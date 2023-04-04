Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D7FB6D6002
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 14:19:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234430AbjDDMTj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 08:19:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234428AbjDDMTT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 08:19:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BA5F49C6
        for <linux-kernel@vger.kernel.org>; Tue,  4 Apr 2023 05:13:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2C0A7632A2
        for <linux-kernel@vger.kernel.org>; Tue,  4 Apr 2023 12:13:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AEA27C433EF;
        Tue,  4 Apr 2023 12:13:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680610428;
        bh=kBLWTzI4Ec3Tgm3PQcE9dHuMDi02IfmCduhDnazZ9YY=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=f/SzTtuPKL+FeY9p/qLiRDcrMowMa5080F1nb9Ne3bZZ8K2QKEvDbZAVp4CFMtwxi
         HJLL91Vm99Vm2leQ/VMOD8jAAnC0tbdltFotedxlnBUF99kKJ3JtRll9TD5V2xECJ4
         vchGtel3UyYejCJw7NS1FKgEKJLdt4/ASCN1OofD2Z8Cd/pwtlnRTgLVCRTHkp8Z42
         UpurcQzf/8UHtwCUXOZEem0LE6wseZMBy/QuPiNaXgFwKoBQmcIxUA81m/N/9aky7R
         SPjGv+zGKz2/SfqYQewaZJ5IJa1/fQ71d2UbjX3tbnOY0IWil5UMXmRFf5KUFoQ96h
         2koyJkcIBkuAw==
Message-ID: <ae922f41-63a0-baf3-c204-73d4e8d0fe08@kernel.org>
Date:   Tue, 4 Apr 2023 15:13:44 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v2 0/3] PHY-GMII-SEL: Add support for SGMII mode
Content-Language: en-US
To:     Siddharth Vadapalli <s-vadapalli@ti.com>, vkoul@kernel.org,
        kishon@kernel.org
Cc:     linux-phy@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, srk@ti.com
References: <20230309063514.398705-1-s-vadapalli@ti.com>
From:   Roger Quadros <rogerq@kernel.org>
In-Reply-To: <20230309063514.398705-1-s-vadapalli@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 09/03/2023 08:35, Siddharth Vadapalli wrote:
> Hello,
> 
> This series adds support to configure the CPSW MAC's PHY in SGMII mode.
> Also, SGMII mode is enabled for TI's J7200 and J721E SoCs.
> 
> Changes from v1:
> 1. Add "break" statement within "case PHY_INTERFACE_MODE_SGMII".
> 2. Add newline before "default" case.
> 3. Update commit message of patch 1/3 to follow the existing convention.
> 
> v1:
> https://lore.kernel.org/r/20230309062237.389444-1-s-vadapalli@ti.com/
> 
> Siddharth Vadapalli (3):
>   phy: ti: gmii-sel: Add support for SGMII mode
>   phy: ti: gmii-sel: Enable SGMII mode for J7200
>   phy: ti: gmii-sel: Enable SGMII mode for J721E
> 
>  drivers/phy/ti/phy-gmii-sel.c | 12 ++++++++++--
>  1 file changed, 10 insertions(+), 2 deletions(-)
> 

For the series:

Reviewed-by: Roger Quadros <rogerq@kernel.org>
