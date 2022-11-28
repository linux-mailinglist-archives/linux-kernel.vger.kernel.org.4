Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D84BF63B3B3
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 21:51:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234342AbiK1UvH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 15:51:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233300AbiK1UvF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 15:51:05 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDCBE6576;
        Mon, 28 Nov 2022 12:51:04 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CFF2F6140F;
        Mon, 28 Nov 2022 20:50:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F271C433C1;
        Mon, 28 Nov 2022 20:50:46 +0000 (UTC)
Date:   Mon, 28 Nov 2022 15:50:44 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Daniel Bristot de Oliveira <bristot@kernel.org>
Cc:     Bagas Sanjaya <bagasdotme@gmail.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        oe-kbuild-all@lists.linux.dev,
        Ammar Faizi <ammarfaizi2@gnuweeb.org>,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        kernel test robot <lkp@intel.com>
Subject: Re: [PATCH] Documentation/osnoise: escape underscore of NO_ prefix
Message-ID: <20221128155044.617f8416@gandalf.local.home>
In-Reply-To: <871bacc9-6c0b-9841-107e-da60a2c8e01e@kernel.org>
References: <202211240447.HxRNftE5-lkp@intel.com>
        <20221125034300.24168-1-bagasdotme@gmail.com>
        <871bacc9-6c0b-9841-107e-da60a2c8e01e@kernel.org>
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


Jon,

Care to take this?

Acked-by: Steven Rostedt (Google) <rostedt@goodmis.org>

Thanks,

-- Steve


On Fri, 25 Nov 2022 19:16:56 +0100
Daniel Bristot de Oliveira <bristot@kernel.org> wrote:

> On 11/25/22 04:43, Bagas Sanjaya wrote:
> > kernel test robot reported unknown target name warning:
> > 
> > Documentation/trace/osnoise-tracer.rst:112: WARNING: Unknown target name: "no".
> > 
> > The warning causes NO_ prefix to be rendered as link text instead, which
> > points to non-existent link target.
> > 
> > Escape the prefix underscore to fix the warning.
> > 
> > Link: https://lore.kernel.org/linux-doc/202211240447.HxRNftE5-lkp@intel.com/
> > Fixes: 67543cd6b8eee5 ("Documentation/osnoise: Add osnoise/options documentation")
> > Reported-by: kernel test robot <lkp@intel.com>
> > Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>  
> 
> Acked-by: Daniel Bristot de Oliveira <bristot@kernel.org>
> 
> Thanks!
> -- Daniel

