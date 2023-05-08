Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A1996FA34B
	for <lists+linux-kernel@lfdr.de>; Mon,  8 May 2023 11:29:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233699AbjEHJ3C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 05:29:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233106AbjEHJ27 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 05:28:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACC07658D;
        Mon,  8 May 2023 02:28:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3F72261917;
        Mon,  8 May 2023 09:28:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0408C433EF;
        Mon,  8 May 2023 09:28:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683538137;
        bh=8lBJEPFLd8rGZOnaQctvrJVYutqCawzSYnnnQAGvxSs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GSb2zmtCXCp0A+sdRR3Q+bfyP1GydMwBlipKxhAnMp6hLgz+/bKXVgaA1Nw1GIiYY
         o3Il4yyFBZQhWPtwkQ5MN6pSMQLsTWAwmF7Ogb/WXPGFYxDqlkDRIXsT6b18Os8+rn
         4/ZTfjI1tIm7uM16QujVQGh6nZFcdw9dnM9tdCdbKWGDSP+QcEj0otffzSasJ5nMxS
         02hRIAbsyLpdIJ/8Xbqx/JQ8R5AhoN0pufNzF7kYjn99+WbBA1Rk5/GGlppzrprsfO
         1HPz1fo9SYhq4yKrIQrTTzkmAyuRLW5C006gqlgveqaRl5q+2gKj2tGlmyFIb7wJAe
         hi0T9Gv6mFD9g==
Date:   Mon, 8 May 2023 14:58:53 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Stanislav Jakubek <stano.jakubek@gmail.com>
Cc:     Kishon Vijay Abraham I <kishon@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com,
        linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: phy: brcm,kona-usb2-phy: convert to YAML
Message-ID: <ZFjA1T/qAKL1jet5@matsya>
References: <20230427190725.GA7730@standask-GA-A55M-S2HP>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230427190725.GA7730@standask-GA-A55M-S2HP>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27-04-23, 21:07, Stanislav Jakubek wrote:
> Convert Broadcom Kona family USB 2.0 PHY bindings to DT schema.

Applied, thanks

-- 
~Vinod
