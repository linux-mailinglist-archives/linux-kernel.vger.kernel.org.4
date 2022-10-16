Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F83F600303
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Oct 2022 21:39:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229757AbiJPTjq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Oct 2022 15:39:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229727AbiJPTjo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Oct 2022 15:39:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDFDE65D0
        for <linux-kernel@vger.kernel.org>; Sun, 16 Oct 2022 12:39:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5121C60DFF
        for <linux-kernel@vger.kernel.org>; Sun, 16 Oct 2022 19:39:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56CC8C433D6;
        Sun, 16 Oct 2022 19:39:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1665949177;
        bh=ASIXwO67vjPplghSfd7GGGjwTL7nvEYN3+Y6upbs+Cc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YgoDqyviiugu12QCjEDuIGkYQS5C0MnJjlD5n9TwHXw55nO29v0OeWEJ+cY2Z6oFD
         01SHvS1q70KIIkZwhy70gIkAR048xcXqUHs5l7Ru0m6lhIZHpVG+F2QfIN3sC3/ilQ
         vvoSyHosECQGDRIGsu3FZ+7VzcHGG2Qf5eJw7y3c=
Date:   Sun, 16 Oct 2022 21:40:23 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Deepak R Varma <drv@mailo.com>
Cc:     linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev,
        kumarpraveen@linux.microsoft.com, saurabh.truth@gmail.com
Subject: Re: query on fixing checkpatch BUG() variants warning
Message-ID: <Y0xeJ/wMWiMHhr2q@kroah.com>
References: <Y0xOKFkL84jqTSj8@debian-BULLSEYE-live-builder-AMD64>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y0xOKFkL84jqTSj8@debian-BULLSEYE-live-builder-AMD64>
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 16, 2022 at 02:32:08PM -0400, Deepak R Varma wrote:
> Hello,
> I am participating in Outreachy program for Dec 2022. Could you please suggest
> if I should explore resolving following checkpatch warning reported by
> driver/stagning/most/*/*.c files?
> 
> Do not crash the kernel unless it is absolutely unavoidable--use WARN_ON_ONCE() plus recovery code (if feasible) instead of BUG() or variants
> 

Feel free to work on whatever you want, it's not up to us to tell you
what to do :)

Good luck!

greg k-h
