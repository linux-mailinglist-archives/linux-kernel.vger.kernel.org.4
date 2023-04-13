Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86A636E0B41
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Apr 2023 12:16:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230271AbjDMKQt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Apr 2023 06:16:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230010AbjDMKQT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Apr 2023 06:16:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DAC4193;
        Thu, 13 Apr 2023 03:16:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 70C8463D52;
        Thu, 13 Apr 2023 10:16:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 587F4C433D2;
        Thu, 13 Apr 2023 10:16:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1681380974;
        bh=cXVnl5hOaV/x7gJrapC/qeYJvy+2MGnRu/FYRWzZsag=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hQ2hOjJwfwl5urUWZd0yPBvgYS+Mxzw8zjPulTyR0+K9FrOm06HaLi2sfh7uy4BAK
         h7SD6nVkZ2Cqpsl6DubH4CI64U0r+hEI56fRRgeNH0caR3Iw6RTHvvHHT6ncxCBl9Q
         ntvKAjotdXz6XuU2lL5WIwZa4bmnCadgvCfzXiLI=
Date:   Thu, 13 Apr 2023 12:16:12 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Stanley =?utf-8?B?Q2hhbmdb5piM6IKy5b63XQ==?= 
        <stanley_chang@realtek.com>
Cc:     Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Felipe Balbi <balbi@kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 2/2] dt-bindings: usb: snps,dwc3: Add
 'snps,parkmode-disable-hs-quirk' quirk
Message-ID: <2023041318-gnarly-unsubtle-e51f@gregkh>
References: <20230413085351.26808-1-stanley_chang@realtek.com>
 <2023041346-shamrock-sterilize-9165@gregkh>
 <6c2dae45c7ca490d889ddc7a0dab027f@realtek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6c2dae45c7ca490d889ddc7a0dab027f@realtek.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 13, 2023 at 09:36:58AM +0000, Stanley Chang[昌育德] wrote:
> > This is not properly threaded with patch 1/2 for some reason, so our tools can
> > not pick up the whole thread at once.  Please fix up your sending script, or
> > just use git send-email directly.
> > 
> > thanks,
> > 
> > greg k-h
> > 
> 
> I send the patch by git send-email.
> 
> git send-email --cc="Stanley Chang <stanley_chang@realtek.com>" --to="Thinh Nguyen <Thinh.Nguyen@synopsys.com>" --cc-cmd='./scripts/get_maintainer.pl -norolestats v3-0001-usb-dwc3-core-add-support-for-disabling-High-spee.patch' --annotate v3-0001-usb-dwc3-core-add-support-for-disabling-High-spee.patch
> 
> git send-email --cc="Stanley Chang <stanley_chang@realtek.com>" --to="Thinh Nguyen <Thinh.Nguyen@synopsys.com>" --cc-cmd='./scripts/get_maintainer.pl -norolesats v3-0002-dt-bindings-usb-snps-dwc3-Add-snps-parkmode-disab.patch' --annotate v3-0002-dt-bindings-usb-snps-dwc3-Add-snps-parkmode-disab.patch
> 
> I don't know why it can't thread with 2 patches?

Because the second invocation of git send-email knows nothing about the
first.  As Krzysztof said, send both patches on the same command line.

> Do I need to resend v4 patch?

Yes, I can not take these as-is for this reason.

thanks,

greg k-h
