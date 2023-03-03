Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C949E6A970C
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Mar 2023 13:15:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229699AbjCCMP0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Mar 2023 07:15:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbjCCMPY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Mar 2023 07:15:24 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 388D71352E;
        Fri,  3 Mar 2023 04:15:23 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E7478B8161F;
        Fri,  3 Mar 2023 12:15:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75022C433D2;
        Fri,  3 Mar 2023 12:15:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677845720;
        bh=MGJW56nLDnMd5k0NW0HsNJE8KHlXr5SQSgLtMFdjvCM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=l4zchKwB66tXLgNdm/brXWFhhhgD2GyFZJHnN7nithWiBvj3gr9eFptLr7kner/G1
         F3CW4TSfGaC9BeFLVMS3MF9z3KWYW2NbWZXpnL7ut1H670rhllNfea92FmF6bEyiXU
         AsF7ERKdMupFJuvANZNmDvNuL6IDQMF91JY32d3mreMQl7PVM07izBtq3jG0WyD365
         SXq/yMDMA4M9/wZr0j8VP45KGlsYC8kHHlq+H/mF7Yl+fKvTwoymiKlxHzv8ICwqc1
         6D4cKFO804rrxqssNXShcXKpMwg2J2BLHlwuNk87z+C6xKv7lbJ17xyXUBQtb2Hvwd
         mSZlBF6e8xXPA==
Date:   Fri, 3 Mar 2023 12:15:15 +0000
From:   Lee Jones <lee@kernel.org>
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     jacek.anaszewski@gmail.com, pavel@ucw.cz, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org,
        thunder.leizhen@huawei.com, festevam@gmail.com
Subject: Re: [PATCH v5] dt-bindings: leds: Document commonly used LED triggers
Message-ID: <20230303121515.GM2420672@google.com>
References: <20230213070827.5085-1-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230213070827.5085-1-manivannan.sadhasivam@linaro.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 13 Feb 2023, Manivannan Sadhasivam wrote:

> Document the commonly used LED triggers by the SoCs. Not all triggers
> are documented as some of them are very application specific. Most of the
> triggers documented here are currently used in devicetrees of many SoCs.
> 
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> ---
> 
> Changes in v5:
> 
> * Rebased on top of v6.2-rc1
> 
> Changes in v4:
> 
> * Removed the sorting of triggers
> * Removed the "items" as they were not needed
> * Reworded the description
> * Dropped Zhen Lei's tested-by tag as the patch has changed
> * Added kbd-capslock trigger
> 
> Changes in v3:
> 
> * Rebased on top of v6.1-rc1
> * Added WLAN Rx trigger
> * Added tested tag from Zhen Lei
> 
> Changes in v2:
> 
> * Added more triggers, fixed the regex
> * Sorted triggers in ascending order
> 
>  .../devicetree/bindings/leds/common.yaml      | 35 +++++++++++++++++++
>  1 file changed, 35 insertions(+)

This version fails to apply, please rebase onto -next.

-- 
Lee Jones [李琼斯]
