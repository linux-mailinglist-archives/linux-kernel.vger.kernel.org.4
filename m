Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8550B73B1F6
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 09:46:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231515AbjFWHp7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jun 2023 03:45:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230348AbjFWHpz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 03:45:55 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71D892696;
        Fri, 23 Jun 2023 00:45:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 368A560F4D;
        Fri, 23 Jun 2023 07:44:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 380E5C433C0;
        Fri, 23 Jun 2023 07:44:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1687506252;
        bh=qyYekPHKiEnI+XlepwYmUPZZkdkhLbIGRGb3mFtde7c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=iz5yD5KiY//gOCLRoo/c77z0Hos6ue+qkIpSTM6f+bfkgh4cWsaZPr0AzImaj0tHU
         K7uAh0xqbHD9WJvxg966zxaRW2Y59Ej48i3vsP7SBaPG45+e9j7Kmhck4fSFykbsD+
         xepKX0rnsxcHb01EgXclHUWEXxQfCDzeiIsDczJo=
Date:   Fri, 23 Jun 2023 09:44:01 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Johan Hovold <johan@kernel.org>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] USB-serial updates for 6.5-rc1
Message-ID: <2023062354-uncounted-automatic-5dd4@gregkh>
References: <ZJVF-Gq2HCkv49sH@hovoldconsulting.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZJVF-Gq2HCkv49sH@hovoldconsulting.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 23, 2023 at 09:12:56AM +0200, Johan Hovold wrote:
> The following changes since commit 9561de3a55bed6bdd44a12820ba81ec416e705a7:
> 
>   Linux 6.4-rc5 (2023-06-04 14:04:27 -0400)
> 
> are available in the Git repository at:
> 
>   https://git.kernel.org/pub/scm/linux/kernel/git/johan/usb-serial.git tags/usb-serial-6.5-rc1

Pulled and pushed out, thanks.

greg k-h
