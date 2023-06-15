Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E756E731BE5
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 16:56:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241660AbjFOOzo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 10:55:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241574AbjFOOzf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 10:55:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 325C310D8;
        Thu, 15 Jun 2023 07:55:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C399D6235D;
        Thu, 15 Jun 2023 14:55:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39E24C433C0;
        Thu, 15 Jun 2023 14:55:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686840933;
        bh=bUL58XYoK6yPyhLBsa6BWypAniON+5g+bccvn2i9aC8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bQD6RuCrnVVHIbWa3jaqi3jVPzgpE1xv6KS0vmB9DW1UYwAksZ6IejbHo6CBkxceh
         /IaoTvK17kr+ER7Z6OBmW9CPAilQYOi8ajUvjbfjvtRGzNzZKSiaujl+7K08hy56UO
         RJtu7jf1jxn04/qp3d1h9epp/OYLnPEtVUOGH27YCJOCJXqBJYATw8mfpQ25rzq2A5
         guQhXx+rRQDOTwhh3NfAVWQQjxL3KCPGOIFZtEJSr8JxfbB3bjgW42TnLBUUEBSAN9
         UL9ztrmpcaDpf7/uinYRwzvdpsI0xUiZNTOH12gnA1IDyk6/FgjFltmp6H4UqCLTMu
         Pris7uNfyYVKg==
Date:   Thu, 15 Jun 2023 15:55:28 +0100
From:   Lee Jones <lee@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        =?iso-8859-1?Q?Fern=E1ndez?= Rojas <noltari@gmail.com>,
        Jonas Gorski <jonas.gorski@gmail.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: mfd: brcm: drop unneeded quotes and use
 absolute /schemas path
Message-ID: <20230615145528.GJ3635807@google.com>
References: <20230609140747.65074-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230609140747.65074-1-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 09 Jun 2023, Krzysztof Kozlowski wrote:

> Cleanup bindings dropping unneeded quotes. Once all these are fixed,
> checking for this can be enabled in yamllint.  Also absolute path
> starting with /schemas is preferred.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  .../devicetree/bindings/mfd/brcm,bcm6318-gpio-sysctl.yaml     | 4 ++--
>  .../devicetree/bindings/mfd/brcm,bcm63268-gpio-sysctl.yaml    | 4 ++--
>  .../devicetree/bindings/mfd/brcm,bcm6328-gpio-sysctl.yaml     | 4 ++--
>  .../devicetree/bindings/mfd/brcm,bcm6358-gpio-sysctl.yaml     | 4 ++--
>  .../devicetree/bindings/mfd/brcm,bcm6362-gpio-sysctl.yaml     | 4 ++--
>  .../devicetree/bindings/mfd/brcm,bcm6368-gpio-sysctl.yaml     | 4 ++--
>  6 files changed, 12 insertions(+), 12 deletions(-)

Doesn't apply.  Please rebase and resubmit.

-- 
Lee Jones [李琼斯]
