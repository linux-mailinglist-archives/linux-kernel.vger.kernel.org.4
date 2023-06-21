Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7FF8738894
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 17:14:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232181AbjFUPOm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 11:14:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233218AbjFUPOY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 11:14:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEF0E4C0B;
        Wed, 21 Jun 2023 08:10:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E49216125F;
        Wed, 21 Jun 2023 15:09:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CECBCC433C9;
        Wed, 21 Jun 2023 15:09:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687360184;
        bh=mh+c5UMuL5b1NTfaIBy/rmvu4Fvz360qptnoRyZTj8Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZMAZkPtAU8/Ay2qwh0rrdlbtf0o1OWxUx+Tq9GvgHO/VvHA75gmreAA30FYA/56J7
         UFeIyKEtFbZeWmDBH1UrQxi2PKOC3rpbtjUL8F72YxmNXPvSDweQoCV0E8zHS9oOFv
         fAFcvE8BMMv4fPi6nZO/U8bndRHcsSmThKh9RRIlI+eWz4FWkNauQ9awscpamA0Q8j
         Iei8djIhJW66d9E1kRi4T82f9YdPmu+SgZTT/gicwkRY4H6mVTJwLvKpOFudEOc20f
         tm1aT5hyHDscYX6FL3uXf4BaPovrJfZfROPAT7eEyOZYOykJ8ldcTnGjV4mdLGUI1u
         hH2zoiGle/XDg==
Date:   Wed, 21 Jun 2023 16:09:39 +0100
From:   Lee Jones <lee@kernel.org>
To:     Tim Harvey <tharvey@gateworks.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH RESEND v2] dt-bindings: mfd: gateworks-gsc: remove
 unnecessary fan-controller nodes
Message-ID: <20230621150939.GH10378@google.com>
References: <20230612162444.3936302-1-tharvey@gateworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230612162444.3936302-1-tharvey@gateworks.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 12 Jun 2023, Tim Harvey wrote:

> Remove the unnecessary #address-cells and #size-cells nodes from
> the fan-controller. These are not needed as the fan controller does not
> have any children.
> 
> Signed-off-by: Tim Harvey <tharvey@gateworks.com>
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
> v2:
>  - udpated commit log to explain why the nodes are unnessesary
>  - added Krzysztof's rb tag
> ---
>  .../devicetree/bindings/mfd/gateworks-gsc.yaml         | 10 ----------
>  1 file changed, 10 deletions(-)

Applied, thanks

-- 
Lee Jones [李琼斯]
