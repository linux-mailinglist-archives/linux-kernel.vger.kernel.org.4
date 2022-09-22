Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A19EB5E6445
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 15:53:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231641AbiIVNxF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 09:53:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231875AbiIVNw6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 09:52:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59766DE0D7;
        Thu, 22 Sep 2022 06:52:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D3D7B6349E;
        Thu, 22 Sep 2022 13:52:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8740C433C1;
        Thu, 22 Sep 2022 13:52:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1663854771;
        bh=EXFw8APFB2TGEMNzh7PpyOxkeuxYM6y1awGndA0jKP8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GrqYDwn26ZI/9m/tp82oC0VTPVCfxqf0wcZO8KwRdafBm7gFk1Suu+g++nKzufyOn
         h5uYw32rVWerp8oUYXRV61MmQGwyvg0TnHI7SKzGDJb4tgPWZxXcUb4rVDhhaLcVvC
         l+S88/t0QQInmE/rQoSM0C7dF7g4kz6UCTvPS2rA=
Date:   Thu, 22 Sep 2022 15:52:13 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Johan Hovold <johan@kernel.org>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] USB-serial updates for 6.1-rc1
Message-ID: <YyxojRDiGg+ZAkwQ@kroah.com>
References: <YyxnVZCqZekklv8V@hovoldconsulting.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YyxnVZCqZekklv8V@hovoldconsulting.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 22, 2022 at 03:47:01PM +0200, Johan Hovold wrote:
> Hi Greg,
> 
> As Stephen reported the other day, there's a trivial conflict with a change in
> the TTY tree that made one of the set_termios parameters const:
> 
> 	https://lore.kernel.org/lkml/20220921151109.174cad24@canb.auug.org.au/

Yeah, I'll watch out for that, thanks.

now pulled and pushed out.

greg k-h
