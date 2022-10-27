Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30AB060F939
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 15:37:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236197AbiJ0Nh0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 09:37:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236189AbiJ0NhY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 09:37:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0B6E181488
        for <linux-kernel@vger.kernel.org>; Thu, 27 Oct 2022 06:37:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9014162301
        for <linux-kernel@vger.kernel.org>; Thu, 27 Oct 2022 13:37:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9C06C4347C;
        Thu, 27 Oct 2022 13:37:21 +0000 (UTC)
Date:   Thu, 27 Oct 2022 09:37:36 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Takashi Iwai <tiwai@suse.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Guenter Roeck <linux@roeck-us.net>,
        Stephen Boyd <sboyd@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org
Subject: Re: [PATCH] ALSA: Use del_timer_sync() before freeing timer
Message-ID: <20221027093736.1e8cc9b9@gandalf.local.home>
In-Reply-To: <87pmedojfv.wl-tiwai@suse.de>
References: <20221026231236.6834b551@gandalf.local.home>
        <87pmedojfv.wl-tiwai@suse.de>
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

On Thu, 27 Oct 2022 08:43:32 +0200
Takashi Iwai <tiwai@suse.de> wrote:

> Applied now with the fix of unused variable warning.

Thanks Takashi!

-- Steve
