Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1854F5B7888
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Sep 2022 19:45:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232967AbiIMRpI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Sep 2022 13:45:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232628AbiIMRog (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Sep 2022 13:44:36 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3FF76CF52;
        Tue, 13 Sep 2022 09:40:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5CB17B80F99;
        Tue, 13 Sep 2022 16:40:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 392EEC433D6;
        Tue, 13 Sep 2022 16:40:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663087229;
        bh=17nYRkN+WVyY1egLu4yVqEs+LBH8XTKYou3v4m8WEZ8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JmpFHTuyhL0iu3WJjmz3e1ysHilkG++Ot37ccDwzzGclOS7JPRD9Jpp1XwCZdWdla
         BE9+YzA0u7p5w9KfCuGnh5B4gQRGOzXloaRplZEbQQb5o+gBEwrELjlQNKg8fEw/WP
         jj42Uc/43MF7QSVWDUGUOk+4Y2P+kx1RwzI1KQKmIb3vEpIvu0hTwNLAhcRDXCrLNl
         IteOOZ7bE4DzzigVPTpYWzrATmBAjnzLrVnibA9xZ/5wFnhfXqdl366AC64oS+vsQG
         7JktLgs7/UP014N7rKpkkLlIYO2mqNXdf3ws6p+yvbRAh0uQktvpHnOMdIuNpodO5j
         BesGDdC2uREhQ==
Date:   Tue, 13 Sep 2022 22:10:24 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Colin Foster <colin.foster@in-advantage.com>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-phy@lists.infradead.org, linux-mips@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        UNGLinuxDriver@microchip.com,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: Re: [PATCH v2 1/1] dt-bindings: phy: ocelot-serdes: convert to YAML
Message-ID: <YyCyeNq7kxx6C3sE@matsya>
References: <20220911163715.4036144-1-colin.foster@in-advantage.com>
 <20220911163715.4036144-2-colin.foster@in-advantage.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220911163715.4036144-2-colin.foster@in-advantage.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11-09-22, 09:37, Colin Foster wrote:
> Convert the phy-ocelot-serdes device tree binding to the new YAML format.
> 
> Additionally, add the file to MAINTAINERS since the original file didn't
> exist.

Applied, thanks

-- 
~Vinod
