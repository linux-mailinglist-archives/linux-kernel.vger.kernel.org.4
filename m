Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0EB6738DE5
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 19:57:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231357AbjFUR5e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 13:57:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231735AbjFUR5T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 13:57:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 010902708;
        Wed, 21 Jun 2023 10:56:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1BE15615DC;
        Wed, 21 Jun 2023 17:56:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 140CEC433C9;
        Wed, 21 Jun 2023 17:56:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687370165;
        bh=wJPOrVNIgTywFQepJZTNQ+QlyeGFs0MkGE1Cz6G2XTQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FNr6TbArDHSoi3xmVTBdDyYTb16ATq5PrGIWD5FsMFgYJivOYG1r/Z2Mt2EfVaqug
         tu9+Yjr4mQsUbwGsSQDL6XTt4LilJFK35UOfESsESJpNQDlQ4NJNR5AlauAX+W/Wha
         AcnpDOk8zQUG51OVRNqykbZJgvMBbfEsy/Nbq8eghb8IjJCGLltD3RJ9qG5gxA5vA+
         74IQiBD6zogFk2ln6Np598zBBzOUTFWN97opNlzyzSgUCBx9oJyuxDXca2a0mw2wad
         I1xlYkRllUqsPM2QXvUz2rnoAza5I5zF5aTtcLt3vwlHU8/s1wMt4PQxy++znE/KW7
         9cW/rsLkLWvIQ==
Date:   Wed, 21 Jun 2023 18:56:01 +0100
From:   Lee Jones <lee@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: mfd: samsung,s5m8767: Simplify excluding
 properties
Message-ID: <20230621175601.GQ10378@google.com>
References: <20230619101424.25897-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230619101424.25897-1-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 19 Jun 2023, Krzysztof Kozlowski wrote:

> Mutually exclusive s5m8767,pmic-buck[234]-uses-gpio-dvs properties can
> be written simpler, with half of the lines of code.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  .../bindings/mfd/samsung,s5m8767.yaml         | 25 ++++++-------------
>  1 file changed, 7 insertions(+), 18 deletions(-)

Applied, thanks

-- 
Lee Jones [李琼斯]
