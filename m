Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CBE7641726
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Dec 2022 14:54:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229762AbiLCNy0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Dec 2022 08:54:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229730AbiLCNyU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Dec 2022 08:54:20 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D31C5113A;
        Sat,  3 Dec 2022 05:54:19 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 787A7B803F1;
        Sat,  3 Dec 2022 13:54:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1BCD3C433D6;
        Sat,  3 Dec 2022 13:54:16 +0000 (UTC)
Date:   Sat, 3 Dec 2022 08:54:13 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Daniel Bristot de Oliveira <bristot@kernel.org>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Masami Hiramatsu <mhiramat@kernel.org>,
        oe-kbuild-all@lists.linux.dev,
        Ammar Faizi <ammarfaizi2@gnuweeb.org>,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        kernel test robot <lkp@intel.com>
Subject: Re: [PATCH] Documentation/osnoise: escape underscore of NO_ prefix
Message-ID: <20221203085413.6556add4@gandalf.local.home>
In-Reply-To: <877cz8pyf8.fsf@meer.lwn.net>
References: <202211240447.HxRNftE5-lkp@intel.com>
        <20221125034300.24168-1-bagasdotme@gmail.com>
        <871bacc9-6c0b-9841-107e-da60a2c8e01e@kernel.org>
        <20221128155044.617f8416@gandalf.local.home>
        <877cz8pyf8.fsf@meer.lwn.net>
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

On Sat, 03 Dec 2022 03:35:39 -0700
Jonathan Corbet <corbet@lwn.net> wrote:

> Steven Rostedt <rostedt@goodmis.org> writes:
> 
> > Jon,
> >
> > Care to take this?
> >
> > Acked-by: Steven Rostedt (Google) <rostedt@goodmis.org>  
> 
> I was about to, but it doesn't apply here.  The problem being fixed
> seemingly came in through your tree and currently only exists in
> linux-next, so I think you need to apply it.

Thanks, I'll take it then.

-- Steve
