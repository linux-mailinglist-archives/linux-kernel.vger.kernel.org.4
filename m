Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 902BF738436
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 15:00:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230449AbjFUNAP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 09:00:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230108AbjFUNAN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 09:00:13 -0400
Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3358B1AC;
        Wed, 21 Jun 2023 06:00:12 -0700 (PDT)
Content-Type: text/plain; charset=utf-8; format=flowed
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
        t=1687352410;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=t4MW0GvBawLQtktDB4ATGKjd0pHPqZSaP4yASsVpW/s=;
        b=ml1R80Q1Pym5yMPXk0q9o2l3NPk4lQqYzZlZYLBJGxr5WvEF1raRg8vq4AJ/8EvPoF5sbW
        y9i219H6i9fWYiwCDW+pYWotG+j8GfMdHslwR3AKGuCf6Sm2VZpAxdncOlyYlcW/hPJFcE
        ACyeIjK97TGsFUADw1ojYSv6sEIONU95ENyYTefULn6BEkplOspN3e5z1rmHUUYKcBwTAu
        WsBiPT3efLRihgM7D0TT4sninBjelsXukNE/tWKQU8qiu2vYPH1KVut/FCSS9eKUjA03q8
        42WdymLr5ZkZyKWEywPiHtseS++sRoQn6uCLMFyn9rVg6MeeTz//2TJ1eDTiNw==
Message-Id: <1687352320815.1257416493.3087155415@manjaro.org>
From:   Furkan Kardame <f.kardame@manjaro.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        robh+dt@kernel.org
Cc:     krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        heiko@sntech.de, broonie@kernel.org, deller@gmx.de,
        dsterba@suse.com, arnd@arndb.de, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCHv4 1/2] dt-bindings: arm: rockchip: Add Firefly Station
 P2
Date:   Wed, 21 Jun 2023 13:00:05 +0000
In-Reply-To: <66d5a117-abc7-e147-f416-5366706b5f26@linaro.org>
References: <66d5a117-abc7-e147-f416-5366706b5f26@linaro.org>
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
Authentication-Results: ORIGINATING;
        auth=pass smtp.auth=f.kardame@manjaro.org smtp.mailfrom=f.kardame@manjaro.org
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org




On Wednesday 21 June 2023 09:22:31 (+03:00), Krzysztof Kozlowski wrote:

 > On 20/06/2023 20:47, Furkan Kardame wrote:
 > > Station P2 is a single board computer by firefly based
 > > on rk3568 soc
 > > 
 > > Signed-off-by: Furkan Kardame 
 > > ---
 > 
 > This is a friendly reminder during the review process.
 > 
 > It looks like you received a tag and forgot to add it.
 > 
 > If you do not know the process, here is a short explanation:
 > Please add Acked-by/Reviewed-by/Tested-by tags when posting new
 > versions. However, there's no need to repost patches *only* to add the
 > tags. The upstream maintainer will do that for acks received on the
 > version they apply.
 > 
Noted, will take care of this in the future. 

 > 
https://elixir.bootlin.com/linux/v5.17/source/Documentation/process/submitting-patches.rst#L540
 
> 
 > If a tag was not added on purpose, please state why and what changed.
 > 
 > Best regards,
 > Krzysztof
 > 
 > 

-- 
-- 
With best regards
Furkan Kardame
