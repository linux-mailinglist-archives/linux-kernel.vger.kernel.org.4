Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A62D373410A
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Jun 2023 14:50:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234976AbjFQMuu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Jun 2023 08:50:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229635AbjFQMus (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Jun 2023 08:50:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB93D1707;
        Sat, 17 Jun 2023 05:50:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 77F1C61055;
        Sat, 17 Jun 2023 12:50:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C867CC433C0;
        Sat, 17 Jun 2023 12:50:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687006246;
        bh=EXM497fDRaiRUv3J6AdcNmZZNgmMVfbzseX3KjTIVgI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ZPDh48XxD9x1v7JyYsPdVdyMKvNXEVx36O2bZUfjsdESmmdZFh9BdfvHPe8T8Jyx5
         3nD7WsV2VCDif0r3sR5JmWM0iVvrxg2vADJF+RR29xmFzEzZmAEDKa/iYaB29X2wPx
         cJxWV1JJSVswtekQlUlw8P9LsOQLQ4IgO+sVtdikOB5grsDMP+WVfzBcgz5FMgabwB
         RWOmp+Y47FHqVerK5n2L9+uSZHCdXfbZ6H5kmdxywe0XB35zLVDqlsq9ZNih27EQpS
         03XVb82VN/PRz23HDVnhu0kuRnUbUmV6aODsrnbNUM4ZtnmY4o2mykFvJm4g19vyCn
         EmbaJohEk0SkA==
Date:   Sat, 17 Jun 2023 13:50:38 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Daniel Campello <campello@chromium.org>,
        Gwendal Grignou <gwendal@chromium.org>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Rob Herring <robh@kernel.org>
Subject: Re: [RESEND PATCH 1/2] dt-bindings: iio: semtech,sx9310: reference
 common schema for label
Message-ID: <20230617135038.61e54c7e@jic23-huawei>
In-Reply-To: <20230617103658.114453-1-krzysztof.kozlowski@linaro.org>
References: <20230617103658.114453-1-krzysztof.kozlowski@linaro.org>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 17 Jun 2023 12:36:57 +0200
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> wrote:

> Reference iio.yaml schema from dtschema to allow already used
> label property:
> 
>   sc7180-trogdor-homestar-r4.dtb: proximity@28: 'label' does not match any of the regexes: 'pinctrl-[0-9]+'
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Acked-by: Rob Herring <robh@kernel.org>

Applied to the togreg branch of iio.git and pushed out as testing.
Note that these are now material for 6.6 and I'll be rebasing that
tree on rc1 once available + not pushing it out for next to pick up until
after that.

Jonathan

> 
> ---
> 
> Resending with ack as dependency (dtschema patch) was applied.
> ---
>  .../devicetree/bindings/iio/proximity/semtech,sx9310.yaml    | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/iio/proximity/semtech,sx9310.yaml b/Documentation/devicetree/bindings/iio/proximity/semtech,sx9310.yaml
> index 5de0bb2180e6..775555d147bf 100644
> --- a/Documentation/devicetree/bindings/iio/proximity/semtech,sx9310.yaml
> +++ b/Documentation/devicetree/bindings/iio/proximity/semtech,sx9310.yaml
> @@ -15,6 +15,9 @@ description: |
>    Specifications about the devices can be found at:
>    https://www.semtech.com/products/smart-sensing/sar-sensors/sx9310
>  
> +allOf:
> +  - $ref: /schemas/iio/iio.yaml#
> +
>  properties:
>    compatible:
>      enum:
> @@ -102,7 +105,7 @@ required:
>    - reg
>    - "#io-channel-cells"
>  
> -additionalProperties: false
> +unevaluatedProperties: false
>  
>  examples:
>    - |

