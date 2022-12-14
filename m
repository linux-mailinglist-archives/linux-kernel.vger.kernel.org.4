Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9F6E64C106
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Dec 2022 01:07:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237378AbiLNAHS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Dec 2022 19:07:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237293AbiLNAHC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Dec 2022 19:07:02 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BF5523140
        for <linux-kernel@vger.kernel.org>; Tue, 13 Dec 2022 16:07:01 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4C240B81612
        for <linux-kernel@vger.kernel.org>; Wed, 14 Dec 2022 00:07:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F884C433EF;
        Wed, 14 Dec 2022 00:06:58 +0000 (UTC)
Date:   Tue, 13 Dec 2022 19:06:56 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     "Guilherme G. Piccoli" <gpiccoli@igalia.com>
Cc:     kexec@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V3 06/11] tracing: Improve panic/die notifiers
Message-ID: <20221213190656.3c229b73@gandalf.local.home>
In-Reply-To: <f29935e3-e3b6-2d4e-7fc1-267e1ef0925b@igalia.com>
References: <20220819221731.480795-1-gpiccoli@igalia.com>
        <20220819221731.480795-7-gpiccoli@igalia.com>
        <20221020172908.25c6e3a5@gandalf.local.home>
        <f29935e3-e3b6-2d4e-7fc1-267e1ef0925b@igalia.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 13 Dec 2022 20:51:07 -0300
"Guilherme G. Piccoli" <gpiccoli@igalia.com> wrote:

> > Acked-by: Steven Rostedt (Google) <rostedt@goodmis.org>
> > 
> > -- Steve  
> 
> Hi Steve, since you were so kind in the other patch...decided to ping in
> this one as well heheh

Heh, yeah, I forgot about this one too.

> 
> So, do you think it's possible to pick it for 6.2? No dependency here,
> it's a standalone patch.

I can pull it in.

> 
> Thanks again and sorry for the annoyance!

No, sorry for missing these.

-- Steve
