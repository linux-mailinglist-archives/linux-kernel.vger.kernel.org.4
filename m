Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 722AE67155D
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 08:48:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229728AbjARHsE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 02:48:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229803AbjARHpW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 02:45:22 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E402470A5;
        Tue, 17 Jan 2023 23:10:08 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 219BE61695;
        Wed, 18 Jan 2023 07:10:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74B8DC433D2;
        Wed, 18 Jan 2023 07:10:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1674025807;
        bh=BCfaXPQmIG2sz8cafQRVmTDjDG1OMgz3v5RBgJB8s34=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=xqwrTM9kz9E7Pk8xrunu7rlFhC8o9mfC96cFfWosakLwIVgB/NqgzmxVhtyFzOgGo
         dVzUJXFeZJKinqsI2e1fS5QoAbw7OkyyROIcw4AFzp+CyaW/UgDWuC1Q3mCQgVB1B/
         q3TpqRs5HEodaTKuMsIjTAE+Q3GYrT+90YrSIZqg=
Date:   Wed, 18 Jan 2023 08:10:03 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Fabian Vogt <fabian@ritter-vogt.de>
Subject: Re: [PATCH 0/7] usb: fotg210: Various improvements
Message-ID: <Y8ebS2lMvXs6LSZl@kroah.com>
References: <20230103-gemini-fotg210-usb-v1-0-f2670cb4a492@linaro.org>
 <CACRpkdaE+b_=6mecuWe4EUfYP9C3j5cXZXMO0s2t7Bf3eMtV_A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACRpkdaE+b_=6mecuWe4EUfYP9C3j5cXZXMO0s2t7Bf3eMtV_A@mail.gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 18, 2023 at 08:03:59AM +0100, Linus Walleij wrote:
> On Wed, Jan 4, 2023 at 12:35 AM Linus Walleij <linus.walleij@linaro.org> wrote:
> 
> > This is some gradual improvements to the FOTG210 dual-mode
> > USB host/gadget driver.
> 
> Been two weeks, something I should change or are these good to
> go?

I dropped the series from my review queue due to this comment:
	https://lore.kernel.org/r/9bbd5343-30bc-1146-3296-2c3a43b9a91b@linaro.org

so I was expecting a new series, is that not the case?

thanks,

greg k-h
