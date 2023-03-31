Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92F2D6D25E7
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 18:43:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230193AbjCaQnp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Mar 2023 12:43:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231818AbjCaQn0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Mar 2023 12:43:26 -0400
Received: from netrider.rowland.org (netrider.rowland.org [192.131.102.5])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id 153EB76A6
        for <linux-kernel@vger.kernel.org>; Fri, 31 Mar 2023 09:41:25 -0700 (PDT)
Received: (qmail 241997 invoked by uid 1000); 31 Mar 2023 12:41:24 -0400
Date:   Fri, 31 Mar 2023 12:41:24 -0400
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Sebastian Reichel <sebastian.reichel@collabora.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel@collabora.com
Subject: Re: [PATCHv1 0/2] generic-ohci: increase allowed clocks
Message-ID: <cc3a91de-c716-48de-b1b1-b3f242156c71@rowland.harvard.edu>
References: <20230331163148.5863-1-sebastian.reichel@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230331163148.5863-1-sebastian.reichel@collabora.com>
X-Spam-Status: No, score=0.2 required=5.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
        SPF_HELO_PASS,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 31, 2023 at 06:31:46PM +0200, Sebastian Reichel wrote:
> Hi,
> 
> This increases the max. allowed clocks for generic-ohci from 3 to 4.
> On RK3588 a total of 4 clocks is required to access the OHCI registers.
> Note, that EHCI already supports 4 clocks.
> 
> -- Sebastian
> 
> Sebastian Reichel (2):
>   dt-bindings: usb: generic-ohci: increase allowed clocks
>   usb: host: ohci-platform: increase max clock number to 4
> 
>  Documentation/devicetree/bindings/usb/generic-ohci.yaml | 2 +-
>  drivers/usb/host/ohci-platform.c                        | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)

Acked-by: Alan Stern <stern@rowland.harvard.edu>
