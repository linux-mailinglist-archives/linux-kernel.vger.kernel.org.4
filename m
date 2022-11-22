Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E33F7633ABD
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 12:06:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232727AbiKVLGi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 06:06:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229628AbiKVLGh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 06:06:37 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A00AC167EA
        for <linux-kernel@vger.kernel.org>; Tue, 22 Nov 2022 03:06:34 -0800 (PST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 43767210E1;
        Tue, 22 Nov 2022 11:06:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1669115193; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=NlqwJjaZYrz/tZpdJmF1j348soOx9csoXyc+q8WwEis=;
        b=PwPSC7x4xMSYW8a7p4/17UFnIrbyzdK06Ttxg1Slf7JY30kmNlrTOBLYDPtlVuO5IHnSPO
        y8VBU71kHKehTY98xjvfo2oH4qhB9TL03mtGRzo+VvgB1bSOXRALPVkMnTu/Dc6h/SevJS
        jzGx3jZOBbAcWEL+hxNU1tnenLLQeEM=
Received: from suse.cz (unknown [10.100.201.202])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 973782C142;
        Tue, 22 Nov 2022 11:06:32 +0000 (UTC)
Date:   Tue, 22 Nov 2022 12:06:29 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org,
        Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [PATCH printk] printk: htmldocs: add missing description
Message-ID: <Y3ytNTzRGjvlD1fQ@alley>
References: <20221122181052.75618842@canb.auug.org.au>
 <87zgcjpdvo.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87zgcjpdvo.fsf@jogness.linutronix.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 2022-11-22 10:01:23, John Ogness wrote:
> Variable and return descriptions were missing from the SRCU read
> lock functions. Add them.
> 
> Signed-off-by: John Ogness <john.ogness@linutronix.de>

JFYI, the patch is comitted in printk/linux.git,
branch rework/console-list-lock.

Best Regards,
Petr
