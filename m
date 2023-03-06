Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 063AE6AC4FE
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 16:29:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229865AbjCFP3g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 10:29:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230110AbjCFP3b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 10:29:31 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C9DA34329
        for <linux-kernel@vger.kernel.org>; Mon,  6 Mar 2023 07:28:57 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8F189B80E60
        for <linux-kernel@vger.kernel.org>; Mon,  6 Mar 2023 15:28:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B43CC433EF;
        Mon,  6 Mar 2023 15:28:46 +0000 (UTC)
Date:   Mon, 6 Mar 2023 10:28:44 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Hillf Danton <hdanton@sina.com>
Cc:     John Stultz <jstultz@google.com>,
        LKML <linux-kernel@vger.kernel.org>, Wei Wang <wvw@google.com>,
        Midas Chien <midaschieh@google.com>,
        "Chunhui Li (=?UTF-8?B?5p2O5pil6L6J?=)" <chunhui.li@mediatek.com>,
        Kees Cook <keescook@chromium.org>,
        Anton Vorontsov <anton@enomsg.org>,
        "Guilherme G. Piccoli" <gpiccoli@igalia.com>,
        Tony Luck <tony.luck@intel.com>, linux-mm@kvack.org
Subject: Re: [PATCH v2] pstore: Revert pmsg_lock back to a normal mutex
Message-ID: <20230306102844.1293adfa@gandalf.local.home>
In-Reply-To: <20230306010323.2909-1-hdanton@sina.com>
References: <20230302062741.483079-1-jstultz@google.com>
        <20230304031029.3037914-1-jstultz@google.com>
        <20230306010323.2909-1-hdanton@sina.com>
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

On Mon,  6 Mar 2023 09:03:23 +0800
Hillf Danton <hdanton@sina.com> wrote:

> PS what sense made by spinning on owner until need_resched() with preempt
> disabled in the non-rt context?

Not sure what the question you have here is? If need_resched() is set, we
want to schedule out.

-- Steve
