Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17739676C54
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Jan 2023 12:27:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229981AbjAVL1v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Jan 2023 06:27:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229943AbjAVL1t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Jan 2023 06:27:49 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56F54113FF;
        Sun, 22 Jan 2023 03:27:48 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E78DC60BB8;
        Sun, 22 Jan 2023 11:27:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 205B1C433D2;
        Sun, 22 Jan 2023 11:27:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674386867;
        bh=YPbGv6jCUJUOwlc558M2Wix/B31YpEVlGKXxi2ZJjqg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fSy4OptWjygAXzwavPA2V4L43axty41xhU5/vcF8zn3fv5lNTCSfCu00gxWHZeqIs
         B1n3C0sNySIXxQY8zjQvcHdL0t7u3aMDYtsFfZwKkIKMFAnJAGjaXnSyMu0z2lt6+W
         5V2JzwF8Bvp6HkG2BUihdns0hKx0fC4q+HPtM2wblsGsOt3Wv031SSwJd2TkPyD4nv
         Wwxq5Vg7sjkJl48SPs1JGe+zbI7pV6uRm6GxIKyQK65DK0w/9/qW93rh0m1yISbD2Z
         l50KktaO9VT1iHGl4kiUrRkVuBtMoK12lQ7lzBkCc39PbWOlx3XRgglsENjOA1EA+f
         6QhCN70bI6r6A==
Received: by pali.im (Postfix)
        id A4B9E93D; Sun, 22 Jan 2023 12:27:44 +0100 (CET)
Date:   Sun, 22 Jan 2023 12:27:44 +0100
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Sebastian Reichel <sre@kernel.org>
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/3] dt-bindings: reset: syscon-reboot: Add priority
 property
Message-ID: <20230122112744.vdfho4mzpgm6oucm@pali>
References: <20220820102925.29476-1-pali@kernel.org>
 <20221226114513.4569-1-pali@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221226114513.4569-1-pali@kernel.org>
User-Agent: NeoMutt/20180716
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reminder: Any plan how to handle these patches?

On Monday 26 December 2022 12:45:11 Pali Rohár wrote:
> This new optional priority property allows to specify custom priority level
> of reset device. Prior this change priority level was hardcoded to 192 and
> not possible to specify or change. Specifying other value is needed for
> some boards. Default level when not specified stays at 192 as before.
> 
> Signed-off-by: Pali Rohár <pali@kernel.org>
> 
> ---
> Changes in v4:
> * Use restart-handler.yaml
> 
> Changes in v3:
> * Add explanation into commit message
> 
> Changes in v2:
> * Change sint32 to int32
> * Add default
> ---
>  .../devicetree/bindings/power/reset/syscon-reboot.yaml      | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/power/reset/syscon-reboot.yaml b/Documentation/devicetree/bindings/power/reset/syscon-reboot.yaml
> index da2509724812..f721bdf63a98 100644
> --- a/Documentation/devicetree/bindings/power/reset/syscon-reboot.yaml
> +++ b/Documentation/devicetree/bindings/power/reset/syscon-reboot.yaml
> @@ -19,6 +19,9 @@ description: |+
>    sub-node of a "syscon", "simple-mfd" node. Though the regmap property
>    pointing to the system controller node is also supported.
>  
> +allOf:
> +  - $ref: restart-handler.yaml#
> +
>  properties:
>    compatible:
>      const: syscon-reboot
> @@ -42,6 +45,9 @@ properties:
>      $ref: /schemas/types.yaml#/definitions/uint32
>      description: The reset value written to the reboot register (32 bit access).
>  
> +  priority:
> +    default: 192
> +
>  required:
>    - compatible
>    - offset
> -- 
> 2.20.1
> 
