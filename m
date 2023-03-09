Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F05E6B2245
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 12:06:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231259AbjCILG1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 06:06:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231175AbjCILFA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 06:05:00 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 738B5EBDB9;
        Thu,  9 Mar 2023 03:00:21 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A9D1061AF9;
        Thu,  9 Mar 2023 11:00:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82C6CC4339B;
        Thu,  9 Mar 2023 11:00:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1678359620;
        bh=04U3AJP9vp1UtDPX2lLc42jFVHnP70gnbwI48rebeNo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=an3FyH9Y36iLn5XxzO0uxeM/Db1L8txd5+ZntT0hpIDFnZdoKn2n7eof69mrls0rU
         N9LaxmyNYsUExw6yHvGzPGl6qkA6TgCh/j+YhKCDcqrb1du3eJ6ZP2Q2deplEQYWfO
         GsPokmki+LbjApEZlvoL7cPrHLBiBBFNmGKRd2jo=
Date:   Thu, 9 Mar 2023 12:00:09 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     neil.armstrong@linaro.org
Cc:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        linux-amlogic@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        jirislaby@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        robh+dt@kernel.org, Christian Hewitt <christianshewitt@gmail.com>
Subject: Re: [PATCH v3 3/3] arm64: dts: meson-g12-common: Use the G12A UART
 compatible string
Message-ID: <ZAm8OfpNWYKL1HwV@kroah.com>
References: <20230307222651.2106615-1-martin.blumenstingl@googlemail.com>
 <20230307222651.2106615-4-martin.blumenstingl@googlemail.com>
 <5325f790-50d8-56eb-b8ac-99840d5b3ad2@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5325f790-50d8-56eb-b8ac-99840d5b3ad2@linaro.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 08, 2023 at 01:21:21PM +0100, neil.armstrong@linaro.org wrote:
> On 07/03/2023 23:26, Martin Blumenstingl wrote:
> > Switch meson-12-common.dtsi to use the Meson G12A specific UART
> > compatible string. This enables the "divide XTAL by 2" divider which
> > improves support for UART attached Bluetooth modules (for example
> > RTL8822CS) running at a baud rate of 1500000. Without dividing XTAL
> > (24MHz) by 2 a baud rate of 1500000 cannot be generated cleanly and the
> > resulting jitter breaks communication with the module.
> > 
> > Tested-by: Christian Hewitt <christianshewitt@gmail.com>
> > Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> > ---
> > Greg, please don't take this through your tree. I included this patch
> > to show the overall goal of this series. If Neil won't take this as
> > part of another series then I'll send it separately.
> 
> Actually I'm ok if Greg takes the whole patchset, including this one, via
> the tty tree.

Ok, I'll take them all, thanks.

greg k-h
