Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5941A68AFE6
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Feb 2023 14:16:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229623AbjBENQP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Feb 2023 08:16:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbjBENQN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Feb 2023 08:16:13 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40BB01E5FE
        for <linux-kernel@vger.kernel.org>; Sun,  5 Feb 2023 05:16:12 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CA40060BA5
        for <linux-kernel@vger.kernel.org>; Sun,  5 Feb 2023 13:16:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C817C433D2;
        Sun,  5 Feb 2023 13:16:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1675602971;
        bh=GAoViPlV0DElkM/IIZUXBqHgjdhbnm/i6oHg5gCEOBM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YujcZpKQMKvRihl79OF1uXyJLnMzVFZgtUc0FK/yGOCIaXSxR7OeYhqptmbpqqzZN
         wRjw7qBr/1WCsO3xGA8dwJKWsV/kOcNfmg+vY+G02vTNa435Kvuw84D48U2bxCo1HG
         m6Perjx3BjK0Lalr7g8b9G9I9xyfcS4l9+s1N8+4=
Date:   Sun, 5 Feb 2023 14:16:07 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Guru Mehar Rachaputi <gurumeharrachaputi@gmail.com>
Cc:     Forest Bond <forest@alittletooquiet.net>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] staging: vt6655: Macro with braces issue change to
 inline function
Message-ID: <Y9+sFw0rviTAJNMf@kroah.com>
References: <Y9+qMqYD2zGWRurD@combine-ThinkPad-S1-Yoga>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y9+qMqYD2zGWRurD@combine-ThinkPad-S1-Yoga>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 05, 2023 at 02:08:02PM +0100, Guru Mehar Rachaputi wrote:
> This patch is to fix checkpatch warning: "Macro argument 'iobase' may be better
> as '(iobase)' to avoid precedence issues"
> 
> ---
> Changes in v3:
> 	- Whitespace error from checkpatch fixed
> 
> Changes in v2:
> 	- Macros with one statement that is to call 'iowrite8' function changed
> 	to inline function as reviewed by gregkh@linuxfoundation.org.
> 	In relation to this, names of the callers of macro are also modified
> 	to call this function.
> 
> Signed-off-by: Guru Mehar Rachaputi <gurumeharrachaputi@gmail.com>

Try to take this patch and apply it to a tree, and see that everything
below the --- line is thrown away, including your signed-off-by: line :(

