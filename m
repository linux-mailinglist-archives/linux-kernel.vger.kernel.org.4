Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 555D96E7A5C
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Apr 2023 15:13:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233360AbjDSNNe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Apr 2023 09:13:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232976AbjDSNNc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Apr 2023 09:13:32 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E6B6CC3A;
        Wed, 19 Apr 2023 06:13:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0976063A36;
        Wed, 19 Apr 2023 13:13:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16B95C433EF;
        Wed, 19 Apr 2023 13:13:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1681910010;
        bh=ZNNHYQW9RITA/JCRpVr8LXHZCHfLZxHZphc4AnU7FAc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tUGn84hvSl+SyKVBIN7bTAF31irVek91ZabWgwhVWBlUJ31XaGroEdQgVxnCJ0U9P
         48Hk/7fxIvHja1J/UHhtNzGG5inatvNvN3Z+PTmS/alxgG0UindqN16P4UTA0ljdHj
         +JOYaiPVVhcEighGmCdj91fvKDeb587dieDahyIo=
Date:   Wed, 19 Apr 2023 15:13:28 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Rajat Khandelwal <rajat.khandelwal@linux.intel.com>
Cc:     heikki.krogerus@linux.intel.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] usb: typec: intel_pmc_mux: Expose IOM port status to
 debugfs
Message-ID: <2023041928-step-salsa-3cba@gregkh>
References: <20230419130345.1689915-1-rajat.khandelwal@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230419130345.1689915-1-rajat.khandelwal@linux.intel.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 19, 2023 at 06:33:45PM +0530, Rajat Khandelwal wrote:
> IOM status has a crucial role during debugging to check the
> current state of the type-C port.
> There are ways to fetch the status, but all those require the
> IOM port status offset, which could change with platform.
> 
> Make a debugfs directory for intel_pmc_mux and expose the status
> under it per port basis.
> 
> Signed-off-by: Rajat Khandelwal <rajat.khandelwal@linux.intel.com>
> ---
> 
> v3: Allocate the debugfs directory name for the platform device with
> its ACPI dev name included

{sigh}   No, sorry, this is not correct.

Also, you did not properly follow the rules that all Intel kernel
developers are supposed to follow.  Please consult your local kernel
developer team and do so before sending any more kernel patches out.

greg k-h
