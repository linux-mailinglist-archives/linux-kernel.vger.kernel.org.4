Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC23C738CE8
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 19:19:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230256AbjFURTM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 13:19:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229502AbjFURTL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 13:19:11 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79EBB10C;
        Wed, 21 Jun 2023 10:19:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0EFAF61601;
        Wed, 21 Jun 2023 17:19:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4535DC433C8;
        Wed, 21 Jun 2023 17:19:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687367949;
        bh=ohs90axjGL2P+Qq4eDlVdKf2VcnUUb1Drl3OZZKM5rw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mo3yHvfUGXMmPm7yRXI9pIucRki7M1yHZyZQc5gQ+uaZ96t0LWOg8+/XnVmdiqQxI
         vCm9wkQw5xmBeNMAg4zIj9xwmieebtgET7eiwmdsWfY/3YMVF0ojERE1hUr+AlLwdb
         YXzM2wKoHkaD8ud+keYPNpBti7HFH/dZ0fjAFQJc+E0pG50G8scBMr+ZuOLmLoi1pO
         r1+KJGXglZRxFCENeax8jC7DkDYuQHy4EOlIdQlimmdIjddU85MEuLVwHczZTrf2k+
         +xjxNw8Ck2YeDaAJKYheb1YMXhECLrMFnB5J6SEowhlz3LWqjfBgVkwx3ZdhYloaOE
         j4U48zkCBANvg==
Date:   Wed, 21 Jun 2023 18:19:04 +0100
From:   Lee Jones <lee@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Jianhua Lu <lujianhua000@gmail.com>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>, Pavel Machek <pavel@ucw.cz>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        dri-devel@lists.freedesktop.org, linux-leds@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: backlight: kinetic,ktz8866: Add missing
 type for "current-num-sinks"
Message-ID: <20230621171904.GO10378@google.com>
References: <20230613201022.2823392-1-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230613201022.2823392-1-robh@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 13 Jun 2023, Rob Herring wrote:

> "current-num-sinks" is missing a type, add it.
> 
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
>  .../devicetree/bindings/leds/backlight/kinetic,ktz8866.yaml      | 1 +
>  1 file changed, 1 insertion(+)

Applied, thanks

-- 
Lee Jones [李琼斯]
