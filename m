Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFB8960CB3B
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 13:47:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230470AbiJYLru (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 07:47:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230075AbiJYLrs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 07:47:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 261BA7963B
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 04:47:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E885F618E8
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 11:47:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C58AAC433D6;
        Tue, 25 Oct 2022 11:47:43 +0000 (UTC)
Date:   Tue, 25 Oct 2022 07:47:54 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc:     Rafael Mendonca <rafaelmendsr@gmail.com>,
        Alexei Starovoitov <ast@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fprobe: Check rethook_alloc() return in rethook
 initialization
Message-ID: <20221025074754.0e66cd76@gandalf.local.home>
In-Reply-To: <20221025170346.2fbd0158e98882dd09812431@kernel.org>
References: <20221025031209.954836-1-rafaelmendsr@gmail.com>
        <20221025170346.2fbd0158e98882dd09812431@kernel.org>
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

On Tue, 25 Oct 2022 17:03:46 +0900
Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:

> On Tue, 25 Oct 2022 00:12:08 -0300
> Rafael Mendonca <rafaelmendsr@gmail.com> wrote:
> 
> > Check if fp->rethook succeeded to be allocated. Otherwise, if
> > rethook_alloc() fails, then we end up dereferencing a NULL pointer in
> > rethook_add_node().  
> 
> Good catch!
> 
> Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> 

Acked-by: Steven Rostedt (Google) <rostedt@goodmis.org>

Masami, feel free to pull this in.

-- Steve
