Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D75360FBF8
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 17:31:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235425AbiJ0PbJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 11:31:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234172AbiJ0PbH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 11:31:07 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2655BE09
        for <linux-kernel@vger.kernel.org>; Thu, 27 Oct 2022 08:31:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5BF31B826D6
        for <linux-kernel@vger.kernel.org>; Thu, 27 Oct 2022 15:31:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26408C433C1;
        Thu, 27 Oct 2022 15:31:02 +0000 (UTC)
Date:   Thu, 27 Oct 2022 11:31:16 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Corey Minyard <minyard@acm.org>
Cc:     linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Stephen Boyd <sboyd@kernel.org>,
        Guenter Roeck <linux@roeck-us.net>,
        openipmi-developer@lists.sourceforge.net
Subject: Re: [RFC][PATCH v2 10/31] timers: ipmi: Use del_timer_shutdown()
 before freeing timer
Message-ID: <20221027113116.0ef014a8@gandalf.local.home>
In-Reply-To: <Y1qiTjLWG8u2eDPh@minyard.net>
References: <20221027150525.753064657@goodmis.org>
        <20221027150926.969147187@goodmis.org>
        <Y1qhrqfF87gnyiCE@minyard.net>
        <Y1qiTjLWG8u2eDPh@minyard.net>
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

On Thu, 27 Oct 2022 10:22:54 -0500
Corey Minyard <minyard@acm.org> wrote:

> Well, del_timer_shutdown() isn't there yet, so I guess the Ack is what
> you need.

Yep :-)

I need Thomas and Linus's OK on that too, hence the RFC.

-- Steve
