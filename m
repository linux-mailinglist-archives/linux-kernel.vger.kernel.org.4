Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D3865BAD7E
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Sep 2022 14:33:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230099AbiIPMdQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Sep 2022 08:33:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230516AbiIPMdM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Sep 2022 08:33:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 249DB69F66;
        Fri, 16 Sep 2022 05:33:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B0CA862B5C;
        Fri, 16 Sep 2022 12:33:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18064C433C1;
        Fri, 16 Sep 2022 12:33:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663331591;
        bh=AT8VkjZ1VGWdOKuwt9QtngZWlA97OpwjmY1v0iuej4o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nyD4CXjudmPaibcIlDJcd8Hcpc1NTq+tu1fZnRZ/5RrxG8gz1dRUoQFKHQCxOsxsa
         TfwKL0lOnBT5kjkN3RMn8z8vKqwcb4kUZAbhUtaJsr716Og9+QJwevYBG1nXJjwSqY
         jXE2vHlP0wefv9hdTylm9GnuSJHexz/yV4x7BxLSo4cf4OYkWWEcEHmacEIuOr7hJg
         6GQYMvlmZwADW3fGCH1qNGKcoXUF7JOwO+mdzbW6G29Rvfl7B7ZuGjeRz00phr25CY
         Oi0LAvLXyWuf+Yry7/4rHw24emp3wp5j2Yp/wMv7tH4nyjxGK9op+aVJxv4ovCS03T
         AkZsPisyEW0RA==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1oZAWy-00023Z-89; Fri, 16 Sep 2022 14:33:16 +0200
Date:   Fri, 16 Sep 2022 14:33:16 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Bjorn Andersson <andersson@kernel.org>,
        linux-arm-msm@vger.kernel.org,
        Wesley Cheng <quic_wcheng@quicinc.com>,
        linux-usb@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/6] dt-bindings: usb: qcom,dwc3: Add SC8180x binding
Message-ID: <YyRtDFqSsfPCWWGo@hovoldconsulting.com>
References: <20220916121204.3880182-1-vkoul@kernel.org>
 <20220916121204.3880182-4-vkoul@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220916121204.3880182-4-vkoul@kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 16, 2022 at 05:42:01PM +0530, Vinod Koul wrote:
> Document the USB dwc3 controller for SC8180x SoC
> 
> Signed-off-by: Vinod Koul <vkoul@kernel.org>
> ---
>  Documentation/devicetree/bindings/usb/qcom,dwc3.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/usb/qcom,dwc3.yaml b/Documentation/devicetree/bindings/usb/qcom,dwc3.yaml
> index fea3e7092ace..f33735f3702d 100644
> --- a/Documentation/devicetree/bindings/usb/qcom,dwc3.yaml
> +++ b/Documentation/devicetree/bindings/usb/qcom,dwc3.yaml
> @@ -24,6 +24,7 @@ properties:
>            - qcom,qcs404-dwc3
>            - qcom,sc7180-dwc3
>            - qcom,sc7280-dwc3
> +          - qcom,sc8180x-dwc3
>            - qcom,sc8280xp-dwc3
>            - qcom,sdm660-dwc3
>            - qcom,sdm845-dwc3

You need to also describe the clocks and interrupts required by this
platform in the platform-specific sections further down in this file.

Johan
