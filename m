Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3DEC68E025
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 19:36:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231980AbjBGSgM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Feb 2023 13:36:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232739AbjBGSgK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Feb 2023 13:36:10 -0500
Received: from mailrelay3-1.pub.mailoutpod2-cph3.one.com (mailrelay3-1.pub.mailoutpod2-cph3.one.com [IPv6:2a02:2350:5:402::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87D56114
        for <linux-kernel@vger.kernel.org>; Tue,  7 Feb 2023 10:36:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ravnborg.org; s=rsa2;
        h=in-reply-to:content-type:mime-version:references:message-id:subject:cc:to:
         from:date:from;
        bh=4GfeO/XZAAdUxo1fix4X+pe63hWI1TdtNYDToXtW6gs=;
        b=DwGgnC56M27GcJtqsSlyWtPzcBCL3k6aBLX6+g/5zUq0WTbscpVg/rvNKu6PqhxKVh24TT5MOA2Qh
         5S9OpcOzbaYO9wO/zTOFVepkWWPrbfSXP/32Ask4e5Y2dadNjw8xoiDMtxiNCH1jPUw4BiVPOJ7rZ6
         Z/Q/bLmnx2jYrBgGXYZ4S8iqcy0LIfAu/+B6YVLENS4ed7583vwVk78sMJ8LaWlaY6YkJ4AlJ7jRSs
         pTN0j9rqQNDC2mxnbYFwYGz89MwfHKy3lpSoATOi5fof0C3ndZisXzOxWmk2THtZuDs6YWy+PX/8Dn
         YnvrFG/PrTfR70Gc6ETFNaQBpaMg/ig==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed;
        d=ravnborg.org; s=ed2;
        h=in-reply-to:content-type:mime-version:references:message-id:subject:cc:to:
         from:date:from;
        bh=4GfeO/XZAAdUxo1fix4X+pe63hWI1TdtNYDToXtW6gs=;
        b=5l5sNo2fgYRGt6tnuy4JMfL4cjfxeKDxZwpAiIHQSsE3X3PpNrs7lg5Bln2CpKAFEu3ex6IdJ6Gfq
         Ci40VVDDQ==
X-HalOne-ID: 4421bf51-a716-11ed-b8d7-ede074c87fad
Received: from ravnborg.org (2-105-2-98-cable.dk.customer.tdc.net [2.105.2.98])
        by mailrelay3 (Halon) with ESMTPSA
        id 4421bf51-a716-11ed-b8d7-ede074c87fad;
        Tue, 07 Feb 2023 18:36:02 +0000 (UTC)
Date:   Tue, 7 Feb 2023 19:36:00 +0100
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Neil Armstrong <neil.armstrong@linaro.org>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: display: panel: visionox,vtdr6130: add
 missing reg property
Message-ID: <Y+KaEPO7he39Gmd5@ravnborg.org>
References: <20230207-topic-sm8550-upstream-vtdr6130-bindings-fix-v1-1-0ba2323420c5@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230207-topic-sm8550-upstream-vtdr6130-bindings-fix-v1-1-0ba2323420c5@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Neil.


On Tue, Feb 07, 2023 at 11:04:36AM +0100, Neil Armstrong wrote:
> Add missing reg property and update example to add dsi top node.
> 
> Fixes: ef85db911134 ("dt-bindings: display: panel: document the Visionox VTDR6130 AMOLED DSI Panel")
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> ---
>  .../bindings/display/panel/visionox,vtdr6130.yaml  | 34 ++++++++++++++--------
>  1 file changed, 22 insertions(+), 12 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/display/panel/visionox,vtdr6130.yaml b/Documentation/devicetree/bindings/display/panel/visionox,vtdr6130.yaml
> index 49e2fd4b4e99..84562a5b710a 100644
> --- a/Documentation/devicetree/bindings/display/panel/visionox,vtdr6130.yaml
> +++ b/Documentation/devicetree/bindings/display/panel/visionox,vtdr6130.yaml
> @@ -16,6 +16,10 @@ properties:
>    compatible:
>      const: visionox,vtdr6130
>  
> +  reg:
> +    maxItems: 1
> +    description: DSI virtual channel
> +
Other panels using dsi uses a simple
"	reg: true"

I think that would suffice here too.

	Sam
