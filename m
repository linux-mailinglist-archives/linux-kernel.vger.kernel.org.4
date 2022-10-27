Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 615B460F00A
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 08:22:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234533AbiJ0GWF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 02:22:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233865AbiJ0GWD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 02:22:03 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C112E52E6A;
        Wed, 26 Oct 2022 23:22:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id A91ABCE250D;
        Thu, 27 Oct 2022 06:21:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F093C433D6;
        Thu, 27 Oct 2022 06:21:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1666851716;
        bh=mSWLwbIyeNkkB2KiYO02fj1iA2DWV8YpJhykkrwvnJM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Dx+CX3Mg9RQWljNqtgGI8lpQytHeEfCtoHAK6Y/yCU12tm3cDJqku9c5nSSo+BNIs
         tux+XzjIzOBDPma6Cig661NXrpbyUGxvMU5CQh6m4+9eG8IxVTfW+c78sZ8CEfT8F9
         7SnWlM9hgjJf8vcfkWDpY3LK+t6U+GVpAUJUZ7XQ=
Date:   Thu, 27 Oct 2022 08:22:49 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Albert Wang <albertccwang@google.com>
Cc:     mathias.nyman@intel.com, badhri@google.com, howardyen@google.com,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Subject: Re: [PATCH 3/3] usb: host: add the xhci offload hooks implementations
Message-ID: <Y1ojue+vPJyyK9Uc@kroah.com>
References: <20221027004050.4192111-1-albertccwang@google.com>
 <20221027004050.4192111-4-albertccwang@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221027004050.4192111-4-albertccwang@google.com>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 27, 2022 at 08:40:50AM +0800, Albert Wang wrote:
> Add the offload hooks implementations and call to co-processor for
> offload operations.

You forgot to submit the user for all of these hooks at the same time.

For obvious reasons (and this was raised every time this patch series
has been submitted), we can not take hooks or apis that do not have a
real user of them at the same time.

And you don't want us to do that either, right?  How would you maintain
a chunk of code that has calls to other code that is not even in the
same repo and that you can never seee?  Would you be able to do that?

Again, please read the comments that came up when this was submitted
last time, and work to resolve them before submitting this series again.

I do not see any changes here from the last submission.  If that is
incorrect, then you need to document what changed, as our kernel
documentation asks you to do.

thanks,

greg k-h
