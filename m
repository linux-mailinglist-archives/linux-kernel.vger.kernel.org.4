Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE28C6A986F
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Mar 2023 14:33:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229922AbjCCNdg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Mar 2023 08:33:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229754AbjCCNdO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Mar 2023 08:33:14 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4917ED51C;
        Fri,  3 Mar 2023 05:33:13 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id EFC67B818CB;
        Fri,  3 Mar 2023 13:33:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 578F0C433D2;
        Fri,  3 Mar 2023 13:33:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677850390;
        bh=Q2NS0cGewK0rfbrE7gpf9lkmsbOHAIggPXrqMIDYmpM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bFoMrPhvowhOZZ4pJLBr1wrxgyBeMj+CN763Geq8AUoaZTwgnsjQNli/998U/Xs3V
         IhWqJ2rqQ//twyCkEM6nabsodZuqXI7xKDc/yWE9iFLOhpolCyoBZfM28gld3ITJeV
         REoZnFcrXpfM36TjnIJ4ZF503JDP+WXi9MiUmpie/40efQBjjkkwymgwgDfW9df3+l
         LtXmxxWQgPg+yfRv9ClBdpfoVZqU8oAqFetBVVuAwJ733ZcbSAcZippCVOWfPSyHDA
         OB5Apw3niAjiPOGFUS6sHVxKogM7vBNItEy3siE6QrOSNE8W2yw5Y64WmncUKKUugC
         /XI8kmANYh+Sw==
Date:   Fri, 3 Mar 2023 13:33:05 +0000
From:   Lee Jones <lee@kernel.org>
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     jacek.anaszewski@gmail.com, pavel@ucw.cz, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org,
        thunder.leizhen@huawei.com, festevam@gmail.com,
        Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v7] dt-bindings: leds: Document commonly used LED triggers
Message-ID: <20230303133305.GO2420672@google.com>
References: <20230303122925.6610-1-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230303122925.6610-1-manivannan.sadhasivam@linaro.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 03 Mar 2023, Manivannan Sadhasivam wrote:

> Document the commonly used LED triggers by the SoCs. Not all triggers
> are documented as some of them are very application specific. Most of the
> triggers documented here are currently used in devicetrees of many SoCs.
> 
> While at it, add missing comments and also place the comment above the
> triggers (hci, mmc, wlan) to match the rest of the binding.
> 
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> Reviewed-by: Rob Herring <robh@kernel.org>
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

You signed it off twice, but I fixed that.

> ---
> 
> Changes in v7:
> 
> * Rebased on top of next/master
> 
> Changes in v6:
> 
> * Rebased on top of lee/for-leds-next branch
> * Fixed the comment location for few triggers
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
>  .../devicetree/bindings/leds/common.yaml      | 33 +++++++++++++++++--
>  1 file changed, 30 insertions(+), 3 deletions(-)

Applied, thanks

-- 
Lee Jones [李琼斯]
