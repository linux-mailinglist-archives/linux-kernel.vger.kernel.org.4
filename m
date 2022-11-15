Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9201C629829
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 13:08:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232816AbiKOMI1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 07:08:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230036AbiKOMIY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 07:08:24 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3D30334;
        Tue, 15 Nov 2022 04:08:22 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 66794B816D6;
        Tue, 15 Nov 2022 12:08:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38644C433D6;
        Tue, 15 Nov 2022 12:08:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668514100;
        bh=R61j7XvFsjKOIGH8lnB32pQtEXr+vA8qj1O0QUXEaRc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Hx/O2XaWQYMEROQxzdBxuKSHYCYl34im56uhTkwbkT21OFS9IwoWQRYp1PmJY5HkB
         YR7MiU/850/8oDiOu9aVDg5JYBDly1HQIP9h/BTy4exS3wfQA1lZ3kEIQ/hVFCJMl5
         wyxkt6zwCd4D0d5biedQF78/hMGeYjESNsfD/Tn7rx6rbmudi60ALNz/U3NRMKenU6
         9cBHCsQJ5oqRYWWm2xQnEe2gTgPTNdM/jyOfggZgCmEgBwhBd3E/KGLnE+1SbhylOC
         MpiB1tPiI3u4JWe9N+A9Dpsn4hkaciDWC2fuMOnAegvb3VWbhI0khGYwa2GqEypvxK
         2zGJgQZfo1mRg==
Date:   Tue, 15 Nov 2022 12:08:13 +0000
From:   Will Deacon <will@kernel.org>
To:     Jiucheng Xu <jiucheng.xu@amlogic.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, devicetree@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Chris Healy <cphealy@gmail.com>,
        Jianxin Pan <jianxin.pan@amlogic.com>,
        Kelvin Zhang <kelvin.zhang@amlogic.com>,
        Chris Healy <healych@amzon.com>
Subject: Re: [PATCH v9 1/4] perf/amlogic: Add support for Amlogic meson G12
 SoC DDR PMU driver
Message-ID: <20221115120812.GF32523@willie-the-truck>
References: <20221109015818.194927-1-jiucheng.xu@amlogic.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221109015818.194927-1-jiucheng.xu@amlogic.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 09, 2022 at 09:58:15AM +0800, Jiucheng Xu wrote:
> This patch adds support Amlogic meson G12 series SoC
> DDR bandwidth PMU driver framework and interfaces.
> 
> The PMU not only can monitor the total DDR bandwidth,
> but also the bandwidth which is from individual IP module.

This doesn't apply on top of 6.1-rc4.

Please can you send a rebased version for me to pick up, excluding the
final .dts changes as they'll need to go via the respective SoC tree.

Cheers,

Will
