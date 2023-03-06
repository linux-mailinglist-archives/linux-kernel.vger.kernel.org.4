Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C8BE6AB4F5
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 04:11:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229715AbjCFDLO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Mar 2023 22:11:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229705AbjCFDLM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Mar 2023 22:11:12 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F148F764;
        Sun,  5 Mar 2023 19:11:10 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2CC8CB80B18;
        Mon,  6 Mar 2023 03:11:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00850C433D2;
        Mon,  6 Mar 2023 03:11:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678072267;
        bh=AK43SQyKJZUihUt0Xy3vFkqCXBiD2WrokES4O8k/UeE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mxvfaEXInsnU8yD8gCDVev1RahBCGC83N2qN8otUooLXY0geqTInl9rb4zj6Br7RH
         KL/fj4VkQ5IAjR/aJBgScFNaWkc0euXJrXqobPw0VMcbfQFwFQelGii7W9lixLVtjk
         Hif5GeHy55H06xAfEqGn8nAxQZn13rn6GjxO4fEYH3obP23l2ju6ojPG5YM7URjKAn
         /tuLZu9VA3Ot4zMSPQ3Rg/iT/0A7sP3ZcVXrbgJrvYuCulLHUy7XL2N29gBbGEAJDb
         XifYBMrbk8BnC97BTvo+nQoQarju4DJ/jeUIVX3GBuAVgI0fhay0fgDWJj2ocza0AT
         H8DlDjyBBY/gg==
Date:   Mon, 6 Mar 2023 11:10:54 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Michael Walle <michael@walle.cc>
Cc:     Li Yang <leoyang.li@nxp.com>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Revert "arm64: dts: ls1028a: sl28: get MAC addresses
 from VPD"
Message-ID: <20230306031054.GG143566@dragon>
References: <20230207131020.2458027-1-michael@walle.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230207131020.2458027-1-michael@walle.cc>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 07, 2023 at 02:10:20PM +0100, Michael Walle wrote:
> With commit b203e6f1e833 ("arm64: dts: ls1028a: sl28: get MAC addresses
> from VPD"), the network adapter now depends on the nvmem device to be
> present, which isn't the case and thus breaks networking on this board.
> Revert it.
> 
> Fixes: b203e6f1e833 ("arm64: dts: ls1028a: sl28: get MAC addresses from VPD")
> Signed-off-by: Michael Walle <michael@walle.cc>

Applied!

> ---
> Shawn, unfortunately, the driver was NAKed, so this will break our
> KernelCI setup. Alternatively, the original commit can just be dropped
> from your tree, if that's how you do things like this. I've learned that
> the correct way is to get the driver in and then in the next release enable
> the driver and add it to the dts. Next time :)

Yes, please follow the correct way!

Shawn
