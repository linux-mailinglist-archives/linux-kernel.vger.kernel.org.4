Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54FE76E8AD6
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 09:00:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233925AbjDTHAK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Apr 2023 03:00:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229612AbjDTHAH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Apr 2023 03:00:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1957F2D42;
        Thu, 20 Apr 2023 00:00:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A837A63E60;
        Thu, 20 Apr 2023 07:00:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 945DAC433D2;
        Thu, 20 Apr 2023 07:00:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1681974006;
        bh=CYDe69o99BJbArEAYBxXJ1XD280Hw5mpUPEi5td2O8M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=vK5klg6NJH1GfMZgQxnOeuhjtQmBhSNMfp2WR83XyLUnvwlsxqBIZgxYCIVn8G6lS
         bW2X+4rm4RkeTk/uliZirVuauzbMSsPGIsAm0u5debbgTEVh+/KqgJ1vqOkbQZR4FW
         McS9pnbVf+L6old1HwquHm2CmlrCJRXaN2GMGCHA=
Date:   Thu, 20 Apr 2023 09:00:00 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Johan Hovold <johan@kernel.org>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] USB-serial updates for 6.4-rc1
Message-ID: <ZEDi8IUcJcnXLfjr@kroah.com>
References: <ZEDe4o98cD8y425T@hovoldconsulting.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZEDe4o98cD8y425T@hovoldconsulting.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 20, 2023 at 08:42:42AM +0200, Johan Hovold wrote:
> The following changes since commit 197b6b60ae7bc51dd0814953c562833143b292aa:
> 
>   Linux 6.3-rc4 (2023-03-26 14:40:20 -0700)
> 
> are available in the Git repository at:
> 
>   https://git.kernel.org/pub/scm/linux/kernel/git/johan/usb-serial.git tags/usb-serial-6.4-rc1

Pulled and pushed out, thanks.

greg k-h
