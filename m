Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5EDB711D71
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 04:08:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233344AbjEZCIS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 22:08:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229711AbjEZCIQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 22:08:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9599BE7;
        Thu, 25 May 2023 19:08:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2A70E64BE8;
        Fri, 26 May 2023 02:08:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB496C433EF;
        Fri, 26 May 2023 02:08:12 +0000 (UTC)
Date:   Thu, 25 May 2023 22:08:06 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Sebastian Reichel <sre@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Matti Vaittinen <mazziesaccount@gmail.com>,
        linux-pm@vger.kernel.org
Subject: Re: [BUG 6.4-rc3] BUG: kernel NULL pointer dereference in
 __dev_fwnode
Message-ID: <20230525220806.33e66caf@rorschach.local.home>
In-Reply-To: <20230525164248.wsmyzsv5iwwswntz@mercury.elektranox.org>
References: <20230524131200.0f6fb318@rorschach.local.home>
        <CAHk-=wiNagW7exChQ4YuiRpCDN=kxmUdY5u7ebFux1jgEoL2tg@mail.gmail.com>
        <20230525164248.wsmyzsv5iwwswntz@mercury.elektranox.org>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 25 May 2023 18:42:48 +0200
Sebastian Reichel <sre@kernel.org> wrote:

> I have a fix for that in my fixes branch, that I planned to send
> this week:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/sre/linux-power-supply.git/commit/?h=fixes&id=44c524b642996148a8e94f1a1b8751076edcf577

This appears to fix the bug I reported.

Tested-by: Steven Rostedt (Google) <rostedt@goodmis.org>

-- Steve
