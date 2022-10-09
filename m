Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 222685F8D13
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Oct 2022 20:18:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230229AbiJISSo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Oct 2022 14:18:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230285AbiJISSi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Oct 2022 14:18:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 697CD6175
        for <linux-kernel@vger.kernel.org>; Sun,  9 Oct 2022 11:18:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 06E9360C4B
        for <linux-kernel@vger.kernel.org>; Sun,  9 Oct 2022 18:18:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA36DC433D7;
        Sun,  9 Oct 2022 18:18:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1665339515;
        bh=MVjEC16KMFhYSc8vSL4ZVAZSk2tD1GmgL8X7YE0cSAY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fkv9Z3hD8gNtshzpbbDVBJ8sK1nJY4uY9a/qCitmmM66w+5utVarVmBXD5PuZ6+hW
         21ffHXaUmeJwbpLWCsGkAVyLuFUL1mtBKRFjAu29KS0D2OGzh8Kklp9H0q5Ya88Rfq
         aqfygMlbDZayWaktcK/7B0+2miyhhQy3BWYNVShY=
Date:   Sun, 9 Oct 2022 20:19:18 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Rui Li <me@lirui.org>
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] staging: rtl8192e: remove necessary braces for single
 statement blocks
Message-ID: <Y0MQpuVTqXB17tyJ@kroah.com>
References: <166532561205.8.1223417525390189864.67805880@lirui.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <166532561205.8.1223417525390189864.67805880@lirui.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 09, 2022 at 10:26:31PM +0800, Rui Li wrote:
> This commit cleans up checkpatch warning as follows:
> braces {} are not necessary for single statement blocks
> 
> Signed-off-by: Rui Li <me@lirui.org>
> ---
>  drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c |  3 +--
>  drivers/staging/rtl8192e/rtl8192e/r8192E_phy.c |  9 +++------
>  drivers/staging/rtl8192e/rtl8192e/rtl_dm.c     | 12 ++++--------
>  3 files changed, 8 insertions(+), 16 deletions(-)

Hi,

This is the friendly patch-bot of Greg Kroah-Hartman.  You have sent him
a patch that has triggered this response.  He used to manually respond
to these common problems, but in order to save his sanity (he kept
writing the same thing over and over, yet to different people), I was
created.  Hopefully you will not take offence and will fix the problem
in your patch and resubmit it so that it can be accepted into the Linux
kernel tree.

You are receiving this message because of the following common error(s)
as indicated below:

- This looks like a new version of a previously submitted patch, but you
  did not list below the --- line any changes from the previous version.
  Please read the section entitled "The canonical patch format" in the
  kernel file, Documentation/SubmittingPatches for what needs to be done
  here to properly describe this.

If you wish to discuss this problem further, or you have questions about
how to resolve this issue, please feel free to respond to this email and
Greg will reply once he has dug out from the pending patches received
from other developers.

thanks,

greg k-h's patch email bot
