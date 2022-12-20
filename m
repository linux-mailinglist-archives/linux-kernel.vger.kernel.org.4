Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D218651AD2
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Dec 2022 07:43:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229532AbiLTGnv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Dec 2022 01:43:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229690AbiLTGns (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Dec 2022 01:43:48 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D85D4633E;
        Mon, 19 Dec 2022 22:43:47 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 935E1B8119F;
        Tue, 20 Dec 2022 06:43:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7DF7C433D2;
        Tue, 20 Dec 2022 06:43:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1671518625;
        bh=UhLL8h5zs+hGvnfbkW1uimiuM1ZwwKGebV/hZnfz8Do=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=H0rgEDi4V0Aj+IFQtKDAfTQDjpTxIB0wtu0MGXtX/KRwPoSH0/k6nUhHm6B8yPiMd
         Jq/YCaUy9DFEc7UYtAbsIBWPxVDCrZagEeOu55eaJkhMRKZ/cnXvwo/nEvWYR3Hg4B
         xX7oLlTGTRaw9mVmqjODrDHZQgbrgHkDH9reb2io=
Date:   Tue, 20 Dec 2022 07:43:42 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Allen Webb <allenwebb@google.com>
Cc:     "linux-modules@vger.kernel.org" <linux-modules@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH v9 07/10] modpost: Add -b option for emitting built-in
 aliases
Message-ID: <Y6FZniRwpogJ0HaG@kroah.com>
References: <20221219191855.2010466-1-allenwebb@google.com>
 <20221219204619.2205248-1-allenwebb@google.com>
 <20221219204619.2205248-8-allenwebb@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221219204619.2205248-8-allenwebb@google.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 19, 2022 at 02:46:15PM -0600, Allen Webb wrote:
> This adds an unimplemented command line flag for writing the built-in
> aliases to a file.

If it is unimplemented, why add it?

And this needs a lot more description as to why you are changing this
here, as well as documentation for the flag you added, right?

thanks,

greg k-h
