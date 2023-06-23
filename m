Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DC9473B202
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 09:47:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231623AbjFWHrH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jun 2023 03:47:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231518AbjFWHrF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 03:47:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 012EE1BD2;
        Fri, 23 Jun 2023 00:46:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 92DD461993;
        Fri, 23 Jun 2023 07:46:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56C19C433C8;
        Fri, 23 Jun 2023 07:46:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1687506403;
        bh=a0pOrEs6Dye9TJ7HD+Kc6XKMTmSR8btj5brihc5L7wE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Jd+2cdgsxLgHWPrn0sTd4IFIohuKY/kWJrmOVT+qvY334jH5/DwcsMoAgadIaP0kH
         yZ9ws0dQ8t749qDMVtG4fI/9BYDubrGKdZfsgiC4NVgp8mTVlLzV3qEggGNQfrif0F
         CgDD4ydQLYamWEosgzyv68qZ/+fSsdPvUpJTjDkY=
Date:   Fri, 23 Jun 2023 09:46:41 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Benjamin Bara <bbara93@gmail.com>
Cc:     Matthias Kaehlcke <mka@chromium.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Benjamin Bara <benjamin.bara@skidata.com>,
        Alexander Stein <alexander.stein@ew.tq-group.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v7 0/3] usb: misc: onboard_usb_hub: add support for
 Cypress HX3 USB 3.0 family
Message-ID: <2023062339-cold-turret-dacf@gregkh>
References: <20230620-hx3-v7-0-f79b4b22a1bf@skidata.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230620-hx3-v7-0-f79b4b22a1bf@skidata.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 23, 2023 at 09:28:11AM +0200, Benjamin Bara wrote:
> Hi!
> 
> This series adds support for the Cypress HX3 USB 3.0 family (2/3). For
> now, it just contains the USB-related aspects and ignores the option to
> connect it via i2c (3/3).
> 
> As the HX3 family operates with two power supplies, multiple power
> supply support is implemented (1/3).
> 
> Thanks & best regards,
> Benjamin
> 
> ---
> Changes in v7:
> - 1/3: %ld -> %zu (thanks to lkp)
> - Link to v6: https://lore.kernel.org/r/20230620-hx3-v6-0-6a1d6f8ce689@skidata.com

Wow, that's a lot of respins so quickly, please relax and take your time
and wait a few days before resending patch series as it causes
cross-reviews of old versions, which has happened many times here
already.

I'll wait for 6.5-rc1 to come out before looking at this again to give
everything some time to settle down.

thanks,

greg k-h
