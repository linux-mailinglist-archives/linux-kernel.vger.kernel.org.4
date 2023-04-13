Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8A926E0B4B
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Apr 2023 12:18:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230502AbjDMKRw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Apr 2023 06:17:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230153AbjDMKRf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Apr 2023 06:17:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E30B9004
        for <linux-kernel@vger.kernel.org>; Thu, 13 Apr 2023 03:17:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 936EB63BF0
        for <linux-kernel@vger.kernel.org>; Thu, 13 Apr 2023 10:17:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77312C433D2;
        Thu, 13 Apr 2023 10:17:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1681381048;
        bh=8fiaQqlHp6vGBy60Or+G4VAsffLp1a8Nn+RofsmWQv8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pdzqXB8rJTqVOnTrS3OLgfVmdWh7q2wqgdRXL/BBdqDyum58D9NjLxtXxV+ktKJxb
         k8jxDHfFvcYK9qStaJ7T+2f7CUBuRa3+MUl+g2WKXqsDosSk7G6lgArcSr1VUkq7Gv
         FJQ08bNM38JMh0Z+DkOkR/lnczxxTnP29ZDDFGRw=
Date:   Thu, 13 Apr 2023 12:17:25 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Chuang Zhang <zhangchuang1909@gmail.com>
Cc:     arve@android.com, tkjos@android.com, maco@android.com,
        joel@joelfernandes.org, brauner@kernel.org, cmllamas@google.com,
        surenb@google.com, linux-kernel@vger.kernel.org,
        zhangchuang3 <zhangchuang3@xiaomi.com>
Subject: Re: [PATCH] Binder: Add timestamp and async from pid/tid to
 transaction record
Message-ID: <2023041338-survey-broker-ba63@gregkh>
References: <20230413093805.385284-1-zhangchuang1909@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230413093805.385284-1-zhangchuang1909@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 13, 2023 at 05:38:05PM +0800, Chuang Zhang wrote:
> From: zhangchuang3 <zhangchuang3@xiaomi.com>
> 
> This patch adds a timestamp field to the binder_transaction
> structure to track the time consumed during transmission
> when reading binder_transaction records.
> Additionally, it records the from pid and tid of asynchronous
> binder. This information is printed when reading binderfs
> related nodes to assist with debugging.
> 
> Signed-off-by: zhangchuang3 <zhangchuang3@xiaomi.com>

As I said before, use your hame, not your email alias.

And do NOT send the patch from a gmail account, otherwise I have no way
to verify that you really are a developer at xiaomi.com, right?

thanks,

greg k-h
