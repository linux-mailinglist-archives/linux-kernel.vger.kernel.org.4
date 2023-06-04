Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7436C72171D
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Jun 2023 14:57:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231704AbjFDM5Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Jun 2023 08:57:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231598AbjFDM5W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Jun 2023 08:57:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B99F9B8;
        Sun,  4 Jun 2023 05:57:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4B7BB60C22;
        Sun,  4 Jun 2023 12:57:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA263C433D2;
        Sun,  4 Jun 2023 12:57:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685883439;
        bh=uC6GAzAxk+Ilg7FO0DtR2P2d62jjDvP1VcAoUbRcWl4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=C9RG7kCvi3rPq0OYmXS6BDfF2khfVMngctFP8BaRkrGW9EtJIdkTbQ9HPmp7HMj0I
         /cxOMqwX1HyOTdA7ljfTEGaBcqzHfR8L/cWAJWIxQsdD9JmMbWu5ua3BMGE7jCGnYo
         curKIXczDfc722S1tLWIInlzuJqh/lBdYHrUGQzzOQLvT7eOg7yFn5zWaf+1rsU9TJ
         3O8+wC2U5DW5/B04b1qyESbY+hVD+3Av1EDGPxWkeRPSj1VCXWFwo6qxX91P6j/Khb
         GL7Kc435pUaJsC8Vv8nAeKBbBj4dGenSrA+xEZM3sKpC/IQ5daATAZJi7bPybShFrT
         KiDVVWizLcDQQ==
Date:   Sun, 4 Jun 2023 13:57:15 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     andy.shevchenko@gmail.com
Cc:     Herve Codina <herve.codina@bootlin.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH v4 2/3] iio: potentiometer: Add support for the Renesas
 X9250 potentiometers
Message-ID: <20230604135715.45d5b9e2@jic23-huawei>
In-Reply-To: <ZHTLeYnX2hm1G79W@surfacebook>
References: <20230509160852.158101-1-herve.codina@bootlin.com>
        <20230509160852.158101-3-herve.codina@bootlin.com>
        <20230513193525.43a4475f@jic23-huawei>
        <20230514163233.0c048256@bootlin.com>
        <20230514181912.314ef781@jic23-huawei>
        <20230515084416.399f47c8@bootlin.com>
        <20230520173057.372355e8@jic23-huawei>
        <ZHTLeYnX2hm1G79W@surfacebook>
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

On Mon, 29 May 2023 18:57:45 +0300
andy.shevchenko@gmail.com wrote:

> Sat, May 20, 2023 at 05:30:57PM +0100, Jonathan Cameron kirjoitti:
> 
> ...
> 
> > Done  
> 
> Not sure if my comments can be addressed.
> 
Hi Andy,

I've pushed it out as togreg (which is more or less non rebasing - except
when something goes horribly wrong) now so I'd rather handle your suggestions
as a follow up cleanup patch / series.

Thanks,

Jonathan

