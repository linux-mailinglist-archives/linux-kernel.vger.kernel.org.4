Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F12F60F38B
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 11:20:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234605AbiJ0JUg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 05:20:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235040AbiJ0JUY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 05:20:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA0DC248DE
        for <linux-kernel@vger.kernel.org>; Thu, 27 Oct 2022 02:20:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9FE75608D3
        for <linux-kernel@vger.kernel.org>; Thu, 27 Oct 2022 09:20:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2B99C433D6;
        Thu, 27 Oct 2022 09:20:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1666862415;
        bh=BUkmMerT0m9lDsqxhnQGqs2cLDVxsJ8rEEZ7XvQzo6Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OeeiAb9mFGC2ZA184rtTWuam9WPVnHzf+lJLnuINyGEijCJ12YzpaXkZy0aOZjRxY
         nEmbzcjGM81i9xEiVRfci+IztEpiBy3HLQBWeP/UkMuBoCy81/NdmT/cEm3hPH7RQV
         fwWcIlytqi3+1bWtmKnmoc2XijoiKTZoAuJxZNoM=
Date:   Thu, 27 Oct 2022 11:20:12 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Tanjuate Brunostar <tanjubrunostar0@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev,
        outreachy@lists.linux.dev
Subject: Re: [PATCH v5 1/6] staging: vt6655: fix lines ending in a '('
Message-ID: <Y1pNTMTjUKnmHia3@kroah.com>
References: <cover.1666849707.git.tanjubrunostar0@gmail.com>
 <6742e42999e05ddf09318a0a3bda9ce23b6ae562.1666849707.git.tanjubrunostar0@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6742e42999e05ddf09318a0a3bda9ce23b6ae562.1666849707.git.tanjubrunostar0@gmail.com>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 27, 2022 at 08:59:03AM +0000, Tanjuate Brunostar wrote:
> fix serveral checkpatch errors related to lines ending with a '(' by
> refactoring the code lines

Moving line endings is not "refactoring".  "refactoring" is changing
actual code, sorry.

greg k-h
