Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35435646DC5
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Dec 2022 12:01:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230350AbiLHLBL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Dec 2022 06:01:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230018AbiLHLA2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Dec 2022 06:00:28 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48FC5FD25;
        Thu,  8 Dec 2022 02:56:09 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 058B1B81BF1;
        Thu,  8 Dec 2022 10:56:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5F1FC433D6;
        Thu,  8 Dec 2022 10:56:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670496966;
        bh=y2DJQyBDidiqFp+zv2zhifVo2qGAxFWcBUCKuQ1744g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=O15kn/dzJ3GxvoTtW3CMHT0jfR8S73c7CRbL15rkkKVZPMeArRyRbjM3lVc5z7bBc
         mq3kP16pCllyeyZDFbjFjuQEPTio4F6btHQiytYrFFfvkAhfK6gwOEeQFQs/xTF8AW
         YpixSJB/dnM5gCmyC6Qaw9GrmA8wJdef5c/UldrPKys+vBusQdUEYhFzXviPomo8fX
         NIyrnUqcibbkfUIe0vHApa/KEnpucfz5tiOCsJk7CP5DX+LARmbDWR/mQWx6OjZjit
         rtF7IuTP03QH+zqUHfvAzbngDsM/u9by3HGBJhYlbzE7kHCMgNGdn0z/r4hy8XMrrh
         VemtUlJhHq04g==
Date:   Thu, 8 Dec 2022 10:56:01 +0000
From:   Lee Jones <lee@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Pavel Machek <pavel@ucw.cz>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Yi Xin <Yixin.zhu@intel.com>,
        Mallikarjuna reddy <mallikarjunax.reddy@intel.com>,
        linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: leds: intel,lgm: Add missing
 'led-gpios' property
Message-ID: <Y5HCwWUIzYfa/FOS@google.com>
References: <20221207204327.2810001-1-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221207204327.2810001-1-robh@kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 07 Dec 2022, Rob Herring wrote:

> The example has 'led-gpio' properties, but that's not documented. As the
> 'gpio' form is deprecated, add 'led-gpios' to the schema and update the
> example.
> 
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
>  Documentation/devicetree/bindings/leds/leds-lgm.yaml | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)

Looks good.  Who usually takes these?

Acked-by: Lee Jones <lee@kernel.org>

-- 
Lee Jones [李琼斯]
