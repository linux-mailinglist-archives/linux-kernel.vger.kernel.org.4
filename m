Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF741603064
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 17:58:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231290AbiJRP6u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 11:58:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231310AbiJRP6k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 11:58:40 -0400
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A90FAC823F
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 08:58:30 -0700 (PDT)
Received: (Authenticated sender: joao@overdrivepizza.com)
        by mail.gandi.net (Postfix) with ESMTPA id 3802F20003;
        Tue, 18 Oct 2022 15:58:24 +0000 (UTC)
MIME-Version: 1.0
Date:   Tue, 18 Oct 2022 08:58:24 -0700
From:   Joao Moreira <joao@overdrivepizza.com>
To:     David Laight <David.Laight@aculab.com>
Cc:     'Peter Zijlstra' <peterz@infradead.org>, x86@kernel.org,
        Kees Cook <keescook@chromium.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        linux-kernel@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>
Subject: Re: [PATCH] x86/ibt: Implement FineIBT
In-Reply-To: <9bb036e48580454b81e6de7224c5f006@AcuMS.aculab.com>
References: <Y06rtoE9BsERG9uv@hirez.programming.kicks-ass.net>
 <9bb036e48580454b81e6de7224c5f006@AcuMS.aculab.com>
Message-ID: <3edb387ea335085dcb6dd49f1d9c9ce6@overdrivepizza.com>
X-Sender: joao@overdrivepizza.com
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Does the hash value for kCFI only depend on the function type?
> Or is there something like a attribute that can also be included?

Hi David -- does this sound like what you are asking about?

https://github.com/ClangBuiltLinux/linux/issues/1736

If yes, then it is something in our todo list :) I think Sami is 
handling it.
