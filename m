Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD28E6F0824
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Apr 2023 17:21:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244190AbjD0PVo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Apr 2023 11:21:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244125AbjD0PVl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Apr 2023 11:21:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A8854EEC;
        Thu, 27 Apr 2023 08:21:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C8FB363DF7;
        Thu, 27 Apr 2023 15:21:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E283C433D2;
        Thu, 27 Apr 2023 15:21:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682608889;
        bh=uCJP9+ifJpOSESe3KeXP+qDgJhS/W4xajP8uYYOrLAQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=og6iRwEO0QR7Rf70moNna279+eo8OY7/dAnh/SCMLdJd27wzv8oV2tHPd8TtC3XlD
         2DmRD0KRVrCi3CvR9VrUaqdK42hk/RePMJaKQqHwz8iMsmOq5hpfFfyBwDvwuEICeV
         okdRTAZV0t86Qt65DnpFBXEPRZ83+0lNo7E4Me9R/4t6S0FxCDa9vgjLP92PlnoLsY
         8aOXWakb0g0GXUsECm7cnrFl32WlTu091/g8eM2NsQztrg0kyj0T0zPa9NlWGtLmgM
         ST0OYsyGYCyC5DKYh9FLQCkNlhaWt4Q14rusAvHbJgEHgGoZHQAcWm3CIeTgVnSfzl
         xON/awndvUWCg==
Date:   Thu, 27 Apr 2023 16:21:24 +0100
From:   Lee Jones <lee@kernel.org>
To:     Maarten Zanders <maarten.zanders@mind.be>
Cc:     Pavel Machek <pavel@ucw.cz>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH v8 1/2] dt-bindings: leds-lp55xx: add ti,charge-pump-mode
Message-ID: <20230427152124.GX50521@google.com>
References: <20230421075305.37597-1-maarten.zanders@mind.be>
 <20230421075305.37597-2-maarten.zanders@mind.be>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230421075305.37597-2-maarten.zanders@mind.be>
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 21 Apr 2023, Maarten Zanders wrote:

> Add a binding to configure the internal charge pump for lp55xx.
> 
> Signed-off-by: Maarten Zanders <maarten.zanders@mind.be>
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
> Notes:
>     v1: implement as bool to disable charge pump
>     v2: rewrite to use string configuration, supporting all modes
>     v3: simplification by replacing string option by u8 constant,
>         removing previous Reviewed-by tags as it's a complete
>         rewrite of the patch.
>     v4: added notes
>     v5: dual license, change property type to u32
>     v6: change license type for leds-lp-55xx.h to preferred tag
>     v8: documentation: add default & maximum constraints
> 
>  .../devicetree/bindings/leds/leds-lp55xx.yaml          | 10 ++++++++++
>  include/dt-bindings/leds/leds-lp55xx.h                 | 10 ++++++++++
>  2 files changed, 20 insertions(+)
>  create mode 100644 include/dt-bindings/leds/leds-lp55xx.h

Applied, thanks

-- 
Lee Jones [李琼斯]
