Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B749572DBFB
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 10:05:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240781AbjFMIFN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 04:05:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240817AbjFMIEq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 04:04:46 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAC0110F4
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 01:04:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0E97663263
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 08:04:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06638C4339B;
        Tue, 13 Jun 2023 08:04:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686643482;
        bh=KS6rqXDleiCm1WVeVLgOuqWvWP/3OLMJM5rvdCoc3Aw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=J4CTjDYpAnfJohsHH+IYyVSEKC7rJ9Tw+T8hxuxWCeXhMPX7uSJNr3pWjlqFHuXEP
         ypbiFTCCiCdX+yUhZXqgqeWxe1OIAPaoXPonfOM/Qr0n8KwZDN1ejx19Ev+UzwyLz4
         HiAqmfZzAPSZy4R/B2RFtfrMxdJl1e12DEXVmpOTjJuSFMgv9buE6YIb6erUSK0zdu
         /uUpv2Uqo2KTIbpO6KhwIfY6v2ve6fgLbE2QJgi4eGY2CJgpVYviAtQGihkD0Jtb4b
         kzE6d3g1OE+gyRTfFUcOflFWaRLyufFwXdVSVg3XC/c43t3HEtAW9O2cBAAhHswfnL
         90mY67xwmunLg==
Date:   Tue, 13 Jun 2023 10:04:38 +0200
From:   Andi Shyti <andi.shyti@kernel.org>
To:     Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-kernel@vger.kernel.org, kernel@pengutronix.de
Subject: Re: [PATCH] w1: ds2482: Switch back to use struct i2c_driver's
 .probe()
Message-ID: <20230613080438.b7bfgmbwyrza3rj6@intel.intel>
References: <20230612072807.839689-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230612072807.839689-1-u.kleine-koenig@pengutronix.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Uwe,

On Mon, Jun 12, 2023 at 09:28:07AM +0200, Uwe Kleine-König wrote:
> After commit b8a1a4cd5a98 ("i2c: Provide a temporary .probe_new()
> call-back type"), all drivers being converted to .probe_new() and then
> commit 03c835f498b5 ("i2c: Switch .probe() to not take an id parameter")
> convert back to (the new) .probe() to be able to eventually drop
> .probe_new() from struct i2c_driver.
> 
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>

if needed:

Reviewed-by: Andi Shyti <andi.shyti@kernel.org> 

Andi
