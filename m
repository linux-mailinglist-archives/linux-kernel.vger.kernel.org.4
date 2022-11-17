Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E633762D12A
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 03:37:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234662AbiKQChF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 21:37:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232521AbiKQChD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 21:37:03 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7305F2ED51
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 18:37:02 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 08FFE62072
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 02:37:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7F06C433D6;
        Thu, 17 Nov 2022 02:37:00 +0000 (UTC)
Date:   Wed, 16 Nov 2022 21:36:59 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc:     wangyufen <wangyufen@huawei.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] tracing: fix memory leak in tracing_read_pipe
Message-ID: <20221116213659.3d9265d1@gandalf.local.home>
In-Reply-To: <20221107221710.23d90a4cf74043a9b5f7d6fc@kernel.org>
References: <1667819090-4643-1-git-send-email-wangyufen@huawei.com>
        <a5a79265-be08-0375-ad50-fbe568c7a769@huawei.com>
        <20221107221710.23d90a4cf74043a9b5f7d6fc@kernel.org>
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

On Mon, 7 Nov 2022 22:17:10 +0900
Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:

> Oops, good catch!
> 
> Cc: stable@vger.kernel.org
> 
> Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Queued, thanks Wang and Masami!

-- Steve
