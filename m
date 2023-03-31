Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FDAD6D1892
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 09:28:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230012AbjCaH2j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Mar 2023 03:28:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230288AbjCaH2h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Mar 2023 03:28:37 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73E4EB450;
        Fri, 31 Mar 2023 00:28:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EAFC062375;
        Fri, 31 Mar 2023 07:28:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6E63C433EF;
        Fri, 31 Mar 2023 07:28:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1680247714;
        bh=oftBLgWKJBXTdb4c81SkLFzg6HEj/qk/cqR1DBuTBVI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WthOhZGUzYlVvSPS/UgNtuINge5aYdo7w4zJ+JoHBXvDiHW6ndHAJLDFlSg69l6Ek
         VO46+3U6zYc1b4kCRoVG3K/kFhZ02MXdxJJm9n6MVXsxhCMMkABACnnTHWC9xL8ckn
         8rOmsebVf2+AAXhOB427t5XHnxtBj0MjzVQsvHyA=
Date:   Fri, 31 Mar 2023 09:28:31 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Johan Hovold <johan@kernel.org>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] USB-serial fixes for 6.3-rc5
Message-ID: <ZCaLn6NpEskVD7s8@kroah.com>
References: <ZCaJHdTl6HwpzOBd@hovoldconsulting.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZCaJHdTl6HwpzOBd@hovoldconsulting.com>
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 31, 2023 at 09:17:49AM +0200, Johan Hovold wrote:
> The following changes since commit eeac8ede17557680855031c6f305ece2378af326:
> 
>   Linux 6.3-rc2 (2023-03-12 16:36:44 -0700)
> 
> are available in the Git repository at:
> 
>   https://git.kernel.org/pub/scm/linux/kernel/git/johan/usb-serial.git tags/usb-serial-6.3-rc5
> 

Pulled and pushed out, thanks.

greg k-h
