Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 480F072805B
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 14:46:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236412AbjFHMqf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 08:46:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233180AbjFHMqd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 08:46:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98F6B26B0;
        Thu,  8 Jun 2023 05:46:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2E05964D2E;
        Thu,  8 Jun 2023 12:46:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A510EC433EF;
        Thu,  8 Jun 2023 12:46:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686228391;
        bh=BVMYpn9deUNOxNer1oOxAtHoRObvC6n99auv5H7OZIE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FDIdw3oeQmfiqgKK+ydiuXt8an/7OYFdC8Fh4sX7+dVJfQ0289PGxtDzuhBKISQOh
         dv4j/+C6tVOcWUeDdySVTlwZ0O6pOHcasvwPI4stAMOPY7mN13OyyK9LSsEVbrLD69
         HEJEt0yzCEil/BZGytK01tqHtTF3BhLpu+cA8JbZD36IF23TYsi88P6yUaqWb+VUt9
         BdFDBwBMw/kbQ8S3aAgWJTGnSh+iZVJXlnD6+PjGQ+gxlz6+Sh51tMth/n5JlMdNoS
         MqnqAesVmfw3BFt+xKo/0JiBMRrulrm406OS2YlykojmmFzSmoVB78M2F9eWlu1bHV
         gJrwpYEt/LcPQ==
Date:   Thu, 8 Jun 2023 13:46:26 +0100
From:   Lee Jones <lee@kernel.org>
To:     Raymond Hackley <raymondhackley@protonmail.com>
Cc:     open list <linux-kernel@vger.kernel.org>,
        Pavel Machek <pavel@ucw.cz>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Luca Weiss <luca@z3ntu.xyz>,
        "open list : LED SUBSYSTEM" <linux-leds@vger.kernel.org>,
        "open list : OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, ~postmarketos/upstreaming@lists.sr.ht
Subject: Re: [RESEND PATCH 1/2] dt-bindings: leds: sgm3140: Document
 richtek,rt5033 compatible
Message-ID: <20230608124626.GI1930705@google.com>
References: <20230602133533.260502-1-raymondhackley@protonmail.com>
 <20230602133714.260556-1-raymondhackley@protonmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230602133714.260556-1-raymondhackley@protonmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I've not seen this because Protonmail has encoded your mail.

On Fri, 02 Jun 2023, Raymond Hackley wrote:

> Add devicetree binding for Richtek RT5033 Flash LED charge pump used for
> camera flash LEDs.
> 
> Signed-off-by: Raymond Hackley <raymondhackley@protonmail.com>
> ---
>  Documentation/devicetree/bindings/leds/leds-sgm3140.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/leds/leds-sgm3140.yaml b/Documentation/devicetree/bindings/leds/leds-sgm3140.yaml
> index 4d2ffe5fcfc7..37d2a93780ab 100644
> --- a/Documentation/devicetree/bindings/leds/leds-sgm3140.yaml
> +++ b/Documentation/devicetree/bindings/leds/leds-sgm3140.yaml
> @@ -20,6 +20,7 @@ properties:
>    compatible:
>      enum:
>        - ocs,ocp8110
> +      - richtek,rt5033-led
>        - sgmicro,sgm3140
>  
>    enable-gpios:
> -- 
> 2.30.2
> 
> 

-- 
Lee Jones [李琼斯]
