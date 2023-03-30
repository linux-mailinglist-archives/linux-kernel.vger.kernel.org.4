Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB5C66CFCD0
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 09:32:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229966AbjC3Hcr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 03:32:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231234AbjC3Hc0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 03:32:26 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96BD26195
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 00:32:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7F09BB8264D
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 07:32:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3517C433EF;
        Thu, 30 Mar 2023 07:32:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1680161539;
        bh=Sm383971op+8aXgU67Qw1cdIzvtuoYSflVfmCep6zuo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pQGG89xxabNozJdPjpUD3N3S9lwVnRzs5uzdG1t2U4Cx2T0H7AHvHIK+27HYIHw1v
         l70XhLBvUAi4tUJRwmHzbw04yYk27Q/leAkJnseXhaa1Gbz4EjdWuB/UhBIjm2uSp3
         stVl0L6codrwL3SRbxQMky+idDpUGy7u2FPW02jI=
Date:   Thu, 30 Mar 2023 09:32:16 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Alexander Komrakov <alexander.komrakov@broadcom.com>
Cc:     linux-kernel@vger.kernel.org, giometti@enneenne.com
Subject: Re: [PATCH v5] [PATCH v5] pps: Add elapsed realtime timestamping
Message-ID: <ZCU7AMUTgWulj3N4@kroah.com>
References: <20230330072013.393245-1-alexander.komrakov@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230330072013.393245-1-alexander.komrakov@broadcom.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 30, 2023 at 12:20:13AM -0700, Alexander Komrakov wrote:
> Some applications like Android needs elapsed realtime timestamping
> to PPS pulse for its clock management. Add sysfs node for this.
> 
> Signed-off-by: Alexander Komrakov <alexander.komrakov@broadcom.com>
> ---
>  Documentation/ABI/testing/sysfs-pps | 27 +++++++++++++++++++++++
>  Documentation/driver-api/pps.rst    | 19 ++++++++++++++++
>  drivers/pps/kapi.c                  | 24 +++++++++++++++++---
>  drivers/pps/sysfs.c                 | 34 +++++++++++++++++++++++++++++
>  include/linux/pps_kernel.h          |  2 ++
>  5 files changed, 103 insertions(+), 3 deletions(-)
> 

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
  kernel file, Documentation/process/submitting-patches.rst for what
  needs to be done here to properly describe this.

If you wish to discuss this problem further, or you have questions about
how to resolve this issue, please feel free to respond to this email and
Greg will reply once he has dug out from the pending patches received
from other developers.

thanks,

greg k-h's patch email bot
