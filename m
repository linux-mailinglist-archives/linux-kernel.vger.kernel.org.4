Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2099F6035DA
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 00:26:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229917AbiJRWZ7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 18:25:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229864AbiJRWZ5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 18:25:57 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A21C6525A;
        Tue, 18 Oct 2022 15:25:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 19F90B82177;
        Tue, 18 Oct 2022 22:25:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49C98C433C1;
        Tue, 18 Oct 2022 22:25:52 +0000 (UTC)
Date:   Tue, 18 Oct 2022 18:25:53 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Daniel Bristot de Oliveira <bristot@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-trace-devel@vger.kernel.org,
        kernel test robot <lkp@intel.com>
Subject: Re: [PATCH 1/2] rv/dot2c: Make automaton definition static
Message-ID: <20221018182553.06f13a50@gandalf.local.home>
In-Reply-To: <ffbb92010f643307766c9307fd42f416e5b85fa0.1661266564.git.bristot@kernel.org>
References: <ffbb92010f643307766c9307fd42f416e5b85fa0.1661266564.git.bristot@kernel.org>
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

On Tue, 23 Aug 2022 17:20:28 +0200
Daniel Bristot de Oliveira <bristot@kernel.org> wrote:

> Monitor's automata definition is only used locally, so make dot2c generate
> a static definition.
> 
> Link: https://lore.kernel.org/all/202208210332.gtHXje45-lkp@intel.com
> Link: https://lore.kernel.org/all/202208210358.6HH3OrVs-lkp@intel.com
> 

Somehow this fell through the cracks.

Daniel, is there any reason I shouldn't pull this in now?

-- Steve

> Cc: Steven Rostedt <rostedt@goodmis.org>
> Fixes: e3c9fc78f096 ("tools/rv: Add dot2c")
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Daniel Bristot de Oliveira <bristot@kernel.org>
> ---
>  tools/verification/dot2/dot2c.py | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/verification/dot2/dot2c.py b/tools/verification/dot2/dot2c.py
> index fa73353f7e56..be8a364a469b 100644
> --- a/tools/verification/dot2/dot2c.py
> +++ b/tools/verification/dot2/dot2c.py
> @@ -111,7 +111,7 @@ class Dot2c(Automata):
>  
>      def format_aut_init_header(self):
>          buff = []
> -        buff.append("struct %s %s = {" % (self.struct_automaton_def, self.var_automaton_def))
> +        buff.append("static struct %s %s = {" % (self.struct_automaton_def, self.var_automaton_def))
>          return buff
>  
>      def __get_string_vector_per_line_content(self, buff):

