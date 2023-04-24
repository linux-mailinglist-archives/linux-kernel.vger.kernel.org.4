Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3317E6ECBE8
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Apr 2023 14:16:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231156AbjDXMQb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Apr 2023 08:16:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbjDXMQ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Apr 2023 08:16:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D63F710F7;
        Mon, 24 Apr 2023 05:16:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7711F6212A;
        Mon, 24 Apr 2023 12:16:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB278C433D2;
        Mon, 24 Apr 2023 12:16:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682338587;
        bh=bbpREEP7jCWuZ/XOSK68CL0Pc9DKr0jWgLXLoTlyIK8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FBpmDjNw9NZIUoR5aOtkyWJKK/EZrcPvECCwOnV3Kw0bjzyzUTIJpTOJl0TuLf1oj
         oR9cvvPvbOgH27g4WknwryhqfW1WbPMzgAQA6Eav1GKAzlWoHH91Vj/HIicURrGIDO
         L4h4obiSEbqsI1D1ZxHbIWrdZbAPvKPv+bB70F4V9u3TTU763GpvwgfF7cuUZN7/aD
         14fSoqTid9tdl2SKjMfBJFSYLFH8tPpXytPiyYNx65S4SWBqb4lipEjAAGnVVuPJca
         6bpLYyuG+AXaRfUWdyxpGDI7cJX97RP7eBOsrQjP/51QR244zpBTWYsGR2LjSoZUnl
         ICzpqgacPO/mA==
Date:   Mon, 24 Apr 2023 13:16:22 +0100
From:   Lee Jones <lee@kernel.org>
To:     Shengyu Qu <wiagn233@outlook.com>
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        wens@csie.org, lgirdwood@gmail.com, broonie@kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/4] mfd: axp20x: Add support for AXP15060 PMIC
Message-ID: <20230424121622.GB50521@google.com>
References: <20230417090537.6052-1-wiagn233@outlook.com>
 <TY3P286MB261126058D704A3CDE91CE6D989C9@TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <TY3P286MB261126058D704A3CDE91CE6D989C9@TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM>
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 17 Apr 2023, Shengyu Qu wrote:

> The AXP15060 is a PMIC chip produced by X-Powers, and could be connected
> via an I2C bus.
> 
> Describe the regmap and the MFD bits, along with the registers exposed
> via I2C. Eventually advertise the device using a new compatible string
> and add support for power off the system.
> 
> The driver would disable PEK function if IRQ is not configured in device
> tree, since some boards (For example, Starfive Visionfive 2) didn't
> connect IRQ line of PMIC to SOC.
> 
> GPIO function isn't enabled in this commit, since its configuration
> operation is different from any existing AXP PMICs and needs
> logic modification on existing driver. GPIO support might come in later
> patches.
> 
> Signed-off-by: Shengyu Qu <wiagn233@outlook.com>
> ---
>  drivers/mfd/axp20x-i2c.c   |  2 +
>  drivers/mfd/axp20x.c       | 90 ++++++++++++++++++++++++++++++++++++++
>  include/linux/mfd/axp20x.h | 85 +++++++++++++++++++++++++++++++++++
>  3 files changed, 177 insertions(+)

Doesn't apply.  Please rebase and resend with this applied:

Reviewed-by: Lee Jones <lee@kernel.org>

-- 
Lee Jones [李琼斯]
