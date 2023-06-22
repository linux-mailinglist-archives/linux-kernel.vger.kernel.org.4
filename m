Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA4C77398DA
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 10:00:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231131AbjFVIAT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 04:00:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231290AbjFVIAH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 04:00:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D088199F;
        Thu, 22 Jun 2023 01:00:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BA77161785;
        Thu, 22 Jun 2023 08:00:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB890C433C8;
        Thu, 22 Jun 2023 08:00:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687420805;
        bh=HmqN6QvJA/H4lniyDvO3oHZW73KNcg4jews9XetMmDk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lZeZJaDonMnRowBP3f3MC7Z9XowyEBjnknROJSQUowwjeA9NJGM8YMCc51vpkYRyh
         +ufrLJS5FvYUlemA3zDBZJOOPsPAHgRI6l4i9F9bhYJh2cRLKOHsLaoDNUHIgyzFiD
         kRZ0/Boip85a+JknNGEIHMqKzthYnAh+wO1FtDHJg/TT55AQqhavISa7Edegmj+z8R
         BJJpjqYF2nY9/CiEfi2i8Kz3u1EGraXNuXQDce5uNucFkGUgHGoFgjW6xlGjpX6Xx1
         lQQrf+7dW0rVm4pNWjkEM/rzA8IUGRRjIdDV5NTtSevc3xMPp9vgRsa5+U7NQuD9lm
         FwNTJjPqG2h2Q==
Date:   Thu, 22 Jun 2023 13:30:01 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Kishon Vijay Abraham I <kishon@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Al Cooper <alcooperx@gmail.com>, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: phy: brcm,brcmstb-usb-phy: Fix error in
 "compatible" conditional schema
Message-ID: <ZJP/geCiMQqj3fb1@matsya>
References: <20230621230958.3815818-1-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230621230958.3815818-1-robh@kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21-06-23, 17:09, Rob Herring wrote:
> The conditional if/then schema has an error as the "enum" values have
> "const" in them. Drop the "const".

Applied, thanks

-- 
~Vinod
