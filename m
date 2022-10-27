Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A48CA60EFE8
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 08:11:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234241AbiJ0GLq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 02:11:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234230AbiJ0GLo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 02:11:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 333D314EC5A;
        Wed, 26 Oct 2022 23:11:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B3F4A62027;
        Thu, 27 Oct 2022 06:11:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B293DC433D6;
        Thu, 27 Oct 2022 06:11:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1666851102;
        bh=5cO6s6r/iuYynnAWAGW+ufQjRIVTuRpymCWiVvW2/r4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rZ6KSY93NneQEiiqvF5kb/cz8ZpLN2IQiOuXk+uQREWj648jLToZjD3oL9O0uO358
         1Q1CGTrjnbAhuSzgZ79dNWNr0AZGrHXRYtAtD2eb0RQQqn2Dn9ZyZSOBpBavL39G3a
         QuMB+gxKWaVV+F7Qh27rpcEEiUdyRqvIfZBbCLsM=
Date:   Thu, 27 Oct 2022 08:12:35 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Reka Norman <rekanorman@chromium.org>
Cc:     Mathias Nyman <mathias.nyman@intel.com>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Subject: Re: [PATCH] xhci: Apply XHCI_RESET_TO_DEFAULT quirk to ADL-N
Message-ID: <Y1ohUyZJItFh3xDs@kroah.com>
References: <20221027053407.421783-1-rekanorman@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221027053407.421783-1-rekanorman@chromium.org>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 27, 2022 at 04:34:07PM +1100, Reka Norman wrote:
> ADL-N systems have the same issue as ADL-P, where a large boot firmware
> delay is seen if USB ports are left in U3 at shutdown. So apply the
> XHCI_RESET_TO_DEFAULT quirk to ADL-N as well.
> 
> This patch depends on "xhci: Add quirk to reset host back to default
> state at shutdown".

What is the git commit id of that change?

And is this needed in stable kernels?  If so, how far back?

thanks,

greg k-h
