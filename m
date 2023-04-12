Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 960726DEB9E
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 08:15:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229522AbjDLGPW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 02:15:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbjDLGPU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 02:15:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEAFD4EDA
        for <linux-kernel@vger.kernel.org>; Tue, 11 Apr 2023 23:15:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 683A862854
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 06:15:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F1BAC4339E;
        Wed, 12 Apr 2023 06:15:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1681280117;
        bh=vodfB6Adfbx67TsJOu4GHPUMgq/qgjuDNW8uRcos8as=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=COzprxQUBmHfN+DigTPq3Q9JjiS0od45j+O8hsn9uIlp1nBccq/7zrpXOX5qxtx+d
         F5j0pd55yAJWHCL5Y4Aj8RJJTLqsMEV1TfhMUErarS1GtSGOWQhhXLnEap9uDr+v7I
         5LqajFwxXKkJ/00cN+ca01hHUjMMjHjQGhU+94lk=
Date:   Wed, 12 Apr 2023 08:15:15 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     John Stultz <jstultz@google.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, Rob Herring <robh@kernel.org>,
        Amit Pundir <amit.pundir@linaro.org>, kernel-team@android.com
Subject: Re: [RFC][PATCH] kernel/configs: Drop Android config fragments
Message-ID: <2023041257-flatterer-dean-19a4@gregkh>
References: <20230411180409.1706067-1-jstultz@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230411180409.1706067-1-jstultz@google.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 11, 2023 at 06:04:09PM +0000, John Stultz wrote:
> In the old days where each device had a custom kernel, the
> android config fragments were useful to provide the required
> and reccomended options expected by userland.
> 
> However, these days devices are expected to use the GKI kernel,
> so these config fragments no longer needed, and out of date, so
> they seem to only cause confusion.
> 
> So lets drop them. If folks are curious what configs are
> expected by the Android environment, check out the gki_defconfig
> file in the latest android common kernel tree.
> 
> Cc: Rob Herring <robh@kernel.org>
> Cc: Amit Pundir <amit.pundir@linaro.org>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: kernel-team@android.com
> Signed-off-by: John Stultz <jstultz@google.com>
> ---
>  MAINTAINERS                               |   5 -
>  kernel/configs/android-base.config        | 159 ----------------------
>  kernel/configs/android-recommended.config | 127 -----------------
>  3 files changed, 291 deletions(-)
>  delete mode 100644 kernel/configs/android-base.config
>  delete mode 100644 kernel/configs/android-recommended.config

Yeah!

I'll be glad to take this if I can get some acks.

thanks for doing this.

greg k-h
