Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 971B372ADE2
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Jun 2023 19:50:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230368AbjFJRuY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Jun 2023 13:50:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjFJRuX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Jun 2023 13:50:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1F66359C;
        Sat, 10 Jun 2023 10:50:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4F01461354;
        Sat, 10 Jun 2023 17:50:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D12C0C433EF;
        Sat, 10 Jun 2023 17:50:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686419421;
        bh=FSPOFeVT3IRw3Feg5vYApY6ilOghMdiZedPc7qlgIEU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ilWdjSB7+9+/wZ27/SrjWL09QWUyFjeAnaPCyp3c9593bPlv7cMA97wzvOnduTzbJ
         UCQMgWjkAosmYPrUOEEhkZftuNadgPIaZxuYWErYaZ1up8SnKKgj1Wqz6AZcLASMzZ
         gtDpzb+D5jRuZCUJ7P7PBFOmg46naJ0jwhC/i6rqE5dKHC/5NZRUmnYFTd41gY+RqZ
         /qxLkvMYTYXwF4iE4J4YdwW8Nm/EbBPMy3kxLr0F6PUlsPa6F4lnYKtoQY/+5m02kA
         9IGP52umpLYx7QC19ZApYst7uVhHKDXb/vlpEeEEY2MbLtcUPJBLLQD3gamqwUj67m
         6wgBkxE9WYUFQ==
Date:   Sat, 10 Jun 2023 19:06:55 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Shreeya Patel <shreeya.patel@collabora.com>, lars@metafoo.de,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, heiko@sntech.de,
        sebastian.reichel@collabora.com, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel@collabora.com, gustavo.padovan@collabora.com,
        serge.broslavsky@collabora.com
Subject: Re: [PATCH v2] dt-bindings: iio: rockchip: Fix 'oneOf' condition
 failed warning
Message-ID: <20230610190655.5f3427a3@jic23-huawei>
In-Reply-To: <c5243179-9baf-59ce-b979-c596dcf6692b@linaro.org>
References: <20230610143601.173307-1-shreeya.patel@collabora.com>
        <c5243179-9baf-59ce-b979-c596dcf6692b@linaro.org>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 10 Jun 2023 18:30:57 +0200
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> wrote:

> On 10/06/2023 16:36, Shreeya Patel wrote:
> > rk3588-saradc isn't compatible with the rk3399-saradc variant,
> > hence, fix the following dtbs_check warning for 'oneOf' condition
> > failure.
> >   
> 
> Are you sure it isn't compatible? According to your driver it is and
> this change is not enough.

I'm not following.  the rk3588 has separate handling from the rk3399
Separate devices specific structure for instance
rk3588_saradc_data vs rk3399_saradc_data as provided as the match data for
the different compatibles..

Looks to be incompatible to me.

> 
> Best regards,
> Krzysztof
> 

