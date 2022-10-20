Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D68E76063B6
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 17:00:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230224AbiJTPAR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 11:00:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229541AbiJTPAM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 11:00:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DDCCE09EB
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 08:00:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DBFFE61BD2
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 15:00:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA82FC433D6;
        Thu, 20 Oct 2022 15:00:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1666278008;
        bh=OFeNuLuhtNbSF5lAejx5iAH9B5SR/HHR8g8Rex0/S58=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=T/6TAO9OZLddLi7hzNQ47kbDUwdm7xxtYbNCQMheQOcTumx9B1KNEbCTaY/QEqGHN
         ibgfrsLxebQ4CatSanQ9Mw8rh3RCwa97hjO7N/b13PrfawzdL0EGo45RoPtH1ob665
         z9I/3d4e3DW9/5LwjVi7U3636RyVNjur3y+i5azM=
Date:   Thu, 20 Oct 2022 17:00:05 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Tanjuate Brunostar <tanjubrunostar0@gmail.com>
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        outreachy@lists.linux.dev
Subject: Re: [PATCH v3] staging: vt6655: Fix Lines should not end with a '('
Message-ID: <Y1FidbSpv6cxuqjg@kroah.com>
References: <Y1ExXEuhV3cJnTiD@elroy-temp-vm.gaiao0uenmiufjlowqgp5yxwdh.gvxx.internal.cloudapp.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y1ExXEuhV3cJnTiD@elroy-temp-vm.gaiao0uenmiufjlowqgp5yxwdh.gvxx.internal.cloudapp.net>
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 20, 2022 at 11:30:36AM +0000, Tanjuate Brunostar wrote:
> Code style warnings reported by checkpatch.
> Improve the layout of a function header:
> Put the first parameter immediately after the '(' and align the other
> parameters underneath it.
> 
> Signed-off-by: Tanjuate Brunostar <tanjubrunostar0@gmail.com>
> 
> ---
> v2: put static and void on the same line and adjusted the indentation as
> suggested by Greg KH
> ---
> v3: Reformat the code by inserting tabs and white space as recommended
> by Nam Cao and Julia Lawall

I see 2 "v3" patches sent to the list, yet they are different.  So I
don't know which one is correct :(

Please resend a v4 with the correct change.

thanks,

greg k-h
