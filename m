Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28D7B5E7B08
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Sep 2022 14:44:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231517AbiIWMn7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Sep 2022 08:43:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231398AbiIWMn5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Sep 2022 08:43:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56BBC132D76;
        Fri, 23 Sep 2022 05:43:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B05106225A;
        Fri, 23 Sep 2022 12:43:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A265DC433C1;
        Fri, 23 Sep 2022 12:43:52 +0000 (UTC)
References: <20220912085730.390555-1-piyush.mehta@amd.com>
User-agent: mu4e 1.8.9; emacs 28.2
From:   Felipe Balbi <felipe@balbi.sh>
To:     Piyush Mehta <piyush.mehta@amd.com>
Cc:     gregkh@linuxfoundation.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-usb@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        michal.simek@amd.com, siva.durga.prasad.paladugu@amd.com,
        Manish Narani <manish.narani@xilinx.com>
Subject: Re: [PATCH] dt-bindings: usb: dwc3: Add interrupt-names to include
 hibernation interrupt
Date:   Fri, 23 Sep 2022 15:43:23 +0300
In-reply-to: <20220912085730.390555-1-piyush.mehta@amd.com>
Message-ID: <87y1uab6re.fsf@balbi.sh>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

Piyush Mehta <piyush.mehta@amd.com> writes:
> From: Manish Narani <manish.narani@xilinx.com>
>
> The hibernation feature enabled for Xilinx ZynqMP SoC in DWC3 IP.
> Added the below interrupt-names in the binding schema for the same.
>
> dwc_usb3: dwc3 core interrupt-names
> otg: otg interrupt-names
> hiber: hibernation interrupt-names
>
> Signed-off-by: Manish Narani <manish.narani@xilinx.com>
> Signed-off-by: Piyush Mehta <piyush.mehta@amd.com>
> ---
>  Documentation/devicetree/bindings/usb/snps,dwc3.yaml | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/usb/snps,dwc3.yaml b/Documentation/devicetree/bindings/usb/snps,dwc3.yaml
> index 1779d08ba1c0..618fa7bd32be 100644
> --- a/Documentation/devicetree/bindings/usb/snps,dwc3.yaml
> +++ b/Documentation/devicetree/bindings/usb/snps,dwc3.yaml
> @@ -53,6 +53,8 @@ properties:
>        - const: dwc_usb3
>        - items:
>            enum: [host, peripheral, otg]
> +      - items:
> +          enum: [dwc_usb3, otg, hiber]

I would spell it out; i.e. `hibernation' instead of `hiber'.

-- 
balbi
