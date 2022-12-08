Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FF4664720C
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Dec 2022 15:42:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229680AbiLHOmw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Dec 2022 09:42:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbiLHOms (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Dec 2022 09:42:48 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA1FDD2EE;
        Thu,  8 Dec 2022 06:42:43 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 336C361F5B;
        Thu,  8 Dec 2022 14:42:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F4136C433C1;
        Thu,  8 Dec 2022 14:42:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670510562;
        bh=Sq0WTbblL+vKFIqBHvQtefseFpkzF/X/bvrnpqWEcA0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GGh5TwBVV+7FeQsldKlyHN0ohQX0v9IhbOwRPN6SOZEQmOHIT/+6kggzPoOaCn1GJ
         xpeuxwPJAmXmd5lpil/Y9DJkDpyIYpSpBomeUJs85WwVLxMaMEWwMXZSS916tolRfx
         RGkaFqNS3LORuHY+u853u6m1JAynRAH+OJBxwn8mqKWuX1G5FxBjnWI0iRykjn88Rk
         xcOJ5lLrzALEFZs1IkOHCT16Y4t1A0pXWEEkMtbCmDhJfUFMt1bhZ6ZYX+OWulafmU
         DmqXNAc2/nfBEi+HFzUcqtCEixcMIJ2c1b0QBWUD4ZP4aQzamtLj9jNt+jYHk8jTuY
         eYQUQZqNCH+QQ==
Date:   Thu, 8 Dec 2022 14:42:16 +0000
From:   Lee Jones <lee@kernel.org>
To:     Christoph Niedermaier <cniedermaier@dh-electronics.com>
Cc:     linux-kernel@vger.kernel.org,
        Support Opensource <support.opensource@diasemi.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Marek Vasut <marex@denx.de>, kernel@dh-electronics.com,
        devicetree@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: mfd: da9062: Correct file name for watchdog
Message-ID: <Y5H3yIeKEu1XkwBZ@google.com>
References: <20221130101426.5318-1-cniedermaier@dh-electronics.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221130101426.5318-1-cniedermaier@dh-electronics.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 30 Nov 2022, Christoph Niedermaier wrote:

> Replace the watchdog file name with the name currently in use.
> 
> Signed-off-by: Christoph Niedermaier <cniedermaier@dh-electronics.com>
> ---
> Cc: Support Opensource <support.opensource@diasemi.com>
> Cc: Lee Jones <lee@kernel.org>
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
> Cc: Marek Vasut <marex@denx.de>
> Cc: kernel@dh-electronics.com
> Cc: devicetree@vger.kernel.org
> To: linux-kernel@vger.kernel.org
> ---
>  Documentation/devicetree/bindings/mfd/da9062.txt | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied, thanks.

-- 
Lee Jones [李琼斯]
