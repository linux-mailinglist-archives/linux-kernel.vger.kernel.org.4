Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E7106EF088
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Apr 2023 10:56:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239639AbjDZI4I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Apr 2023 04:56:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239416AbjDZI4G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Apr 2023 04:56:06 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FFFB30D6
        for <linux-kernel@vger.kernel.org>; Wed, 26 Apr 2023 01:56:00 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id ABBCE218F1;
        Wed, 26 Apr 2023 08:55:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1682499359; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=IkkF/0ISX24WjWON+Uxi9qOnOMbfpN9X9WeVxe0A//0=;
        b=kkQNZ75CDHKQ3or4uEmQFBQbo94EEllSbJHdZouw56uaj70AGvfR/bByymXwRGw3Otrbi3
        pfJXs2X4OqngTFpSh1FNAcYxGpWdRV3Sj0XA5MgKSXibHquIUBOCL+ILBMfbjRVHDMSFYu
        3f0817y4cVEjC9BnlS43uVoEX+MzAK0=
Received: from suse.cz (unknown [10.100.201.202])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 338182C141;
        Wed, 26 Apr 2023 08:55:59 +0000 (UTC)
Date:   Wed, 26 Apr 2023 10:55:58 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Chris Down <chris@chrisdown.name>
Cc:     linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        John Ogness <john.ogness@linutronix.de>,
        Geert Uytterhoeven <geert@linux-m68k.org>, kernel-team@fb.com
Subject: Re: [PATCH v5 1/2] printk: Do not delay messages which aren't
 solicited by any console
Message-ID: <ZEjnHjBWM0YwS0t5@alley>
References: <cover.1682427812.git.chris@chrisdown.name>
 <d2bc3639839e232a841bc06c3ca7e8b4d502e412.1682427812.git.chris@chrisdown.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d2bc3639839e232a841bc06c3ca7e8b4d502e412.1682427812.git.chris@chrisdown.name>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,T_SPF_HELO_TEMPERROR,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 2023-04-25 14:06:22, Chris Down wrote:
> Boot-delayed printk messages already have this checked up front, and
> it's odd that we don't do the same check for global printk delays, since
> there's no reason to delay if we are not going to emit anything.
> 
> Signed-off-by: Chris Down <chris@chrisdown.name>

Great catch!

Reviewed-by: Petr Mladek <pmladek@suse.com>

Best Regards,
Petr
