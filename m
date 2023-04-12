Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A1216DFB7E
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 18:38:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229826AbjDLQiP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 12:38:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229775AbjDLQiM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 12:38:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE1731731;
        Wed, 12 Apr 2023 09:38:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8A2EB63723;
        Wed, 12 Apr 2023 16:38:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 612E7C433D2;
        Wed, 12 Apr 2023 16:38:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681317491;
        bh=DA9dZWpLkveydvaCYivnaEBGFsLFJHBYYfsYWozWMLI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kgw217cnaXLquBC3MNroJEenOaEumLqDLqJCn710iVsGHCPfX9dIQcy1/vDaXlJAF
         vKhAnMVqzo6bxnOzZkhIJ9MTukXhS1JOf1vybzrC3kxloGR4YVS7MgMstUffbIje0a
         v1/bpc8lanO5NKePdIb+HbveCJSqPJAJYpgn7wnCI5a9uyjvwGogbAAJGgvGh01TtQ
         UY1GT4Iwo5kZEGesHGhmk/hAwLmGAlhm09e5rJF0N2+QenegtFwdWu0iGne/L8KzUd
         qjOE0zm8ZzEsLUZx5Ow0+LHvLHvAzwwv2UnVbnyP/MKDHs0CJHudKVSDgt/oqhxTn4
         OyiDBBZkGUxoA==
Date:   Wed, 12 Apr 2023 22:08:07 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Siddharth Vadapalli <s-vadapalli@ti.com>
Cc:     kishon@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski@linaro.org, krzysztof.kozlowski+dt@linaro.org,
        linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        srk@ti.com
Subject: Re: [PATCH] dt-bindings: phy: ti: phy-gmii-sel: Add support for
 J784S4 CPSW9G
Message-ID: <ZDbeb/9+xWGzfAZ3@matsya>
References: <20230315092408.1722114-1-s-vadapalli@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230315092408.1722114-1-s-vadapalli@ti.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15-03-23, 14:54, Siddharth Vadapalli wrote:
> The CPSW9G instance of CPSW Ethernet Switch on TI's J784S4 SoC supports
> additional PHY modes like QSGMII. Add a compatible for it.
> 
> Enable the use of "ti,qsgmii-main-ports" property for J784S4 CPSW9G.

Applied, thanks

-- 
~Vinod
