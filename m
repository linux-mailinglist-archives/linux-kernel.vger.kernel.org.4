Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2BDE646DC7
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Dec 2022 12:01:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230407AbiLHLBT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Dec 2022 06:01:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230076AbiLHLAb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Dec 2022 06:00:31 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 538CD167FC;
        Thu,  8 Dec 2022 02:56:29 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E34C461E4B;
        Thu,  8 Dec 2022 10:56:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AAF98C433C1;
        Thu,  8 Dec 2022 10:56:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670496988;
        bh=LgCQ94cHu+RiZY5PpQMKZKBiHmMbEj/hVZTRyFIgrDU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=eVTiBgTa2Tb2HlSi+lVEBi5TCCwx7o7LbkHLwxjr8QakMhQRaqYijapA/Usa/GI1b
         IssA8g0nqMjQ48MSVmW2kuPqh4mUjVEsdN9jxWeHzrC/3maEhbO+EydOHQjfX+TH+j
         NqXCbOB+lFuqYsvHUZuZrmzyxS4cz++1QglUpDA4bvjjh5fdZiLb8pomsiZ9dCaGsG
         slCDpnHRzP2KiH+pNambDD8Te5xm4w6JlLe199G635fNGh9wxO0y/SJeu60x3UcTqq
         BClMOX4Fej7tTE5Ym7jGCGwRK2KiJ4zPbZGThYqZnvGcKZ1GOGZKDJtDTYP9BKgycP
         qZXzz6/SblTRQ==
Date:   Thu, 8 Dec 2022 10:56:22 +0000
From:   Lee Jones <lee@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Pavel Machek <pavel@ucw.cz>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Yi Xin <Yixin.zhu@intel.com>,
        Mallikarjuna reddy <mallikarjunax.reddy@intel.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: Re: [PATCH 2/2] dt-bindings: leds: Add missing references to common
 LED schema
Message-ID: <Y5HC1v7qk5K1M7k0@google.com>
References: <20221207204327.2810001-1-robh@kernel.org>
 <20221207204327.2810001-2-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221207204327.2810001-2-robh@kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 07 Dec 2022, Rob Herring wrote:

> 'led' nodes should have a reference to LED common.yaml schema. Add it where
> missing and drop any duplicate properties.
> 
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
>  .../devicetree/bindings/leds/leds-lgm.yaml       |  3 ++-
>  .../devicetree/bindings/leds/leds-max77650.yaml  |  9 ++-------
>  .../bindings/leds/rohm,bd71828-leds.yaml         | 16 +++-------------
>  3 files changed, 7 insertions(+), 21 deletions(-)

Acked-by: Lee Jones <lee@kernel.org>

-- 
Lee Jones [李琼斯]
