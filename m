Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD7B26E09D6
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Apr 2023 11:13:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230027AbjDMJNj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Apr 2023 05:13:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229526AbjDMJNf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Apr 2023 05:13:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3616C6199;
        Thu, 13 Apr 2023 02:13:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C6A8461825;
        Thu, 13 Apr 2023 09:13:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ADBACC433EF;
        Thu, 13 Apr 2023 09:13:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1681377213;
        bh=/0jm/zvKCefTdoJAA1Anjky53K4/NZVCgn/OGFvcTWs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jh+WizkIoYhu9izs4/k9qn1GdL9CxuqXN+odydUnUXZZPJYqGo3Rmzgi2qpU7daft
         cgSPBN/wSmBJ/wnLks03l2ro6fWvBvNSABNg29WX4z0tY5VKDaBLfVgnM7VK2j8A8M
         XPjbayKfGyY29EO1GyuqUpeXYvPoCR/YNdbZTyuQ=
Date:   Thu, 13 Apr 2023 11:13:30 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Stanley Chang <stanley_chang@realtek.com>
Cc:     Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Felipe Balbi <balbi@kernel.org>, linux-usb@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/2] dt-bindings: usb: snps,dwc3: Add
 'snps,parkmode-disable-hs-quirk' quirk
Message-ID: <2023041346-shamrock-sterilize-9165@gregkh>
References: <20230413085351.26808-1-stanley_chang@realtek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230413085351.26808-1-stanley_chang@realtek.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 13, 2023 at 04:53:50PM +0800, Stanley Chang wrote:
> Add a new 'snps,parkmode-disable-hs-quirk' DT quirk to dwc3 core for
> disable the high-speed parkmode.
> 
> For some USB wifi devices, if enable this feature it will reduce the
> performance. Therefore, add an option for disabling HS park mode by
> device-tree.
> 
> In Synopsys's dwc3 data book:
> In a few high speed devices when an IN request is sent within 900ns of the
> ACK of the previous packet, these devices send a NAK. When connected to
> these devices, if required, the software can disable the park mode if you
> see performance drop in your system. When park mode is disabled,
> pipelining of multiple packet is disabled and instead one packet at a time
> is requested by the scheduler. This allows up to 12 NAKs in a micro-frame
> and improves performance of these slow devices.
> 
> Signed-off-by: Stanley Chang <stanley_chang@realtek.com>
> ---
> v2 to v3 change:
> 1. Add the comment message.
> 2. cc the right maintainers.

This is not properly threaded with patch 1/2 for some reason, so our
tools can not pick up the whole thread at once.  Please fix up your
sending script, or just use git send-email directly.

thanks,

greg k-h
