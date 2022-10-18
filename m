Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26A6B6035E2
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 00:29:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229862AbiJRW3I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 18:29:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229902AbiJRW3E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 18:29:04 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BA65CAE61;
        Tue, 18 Oct 2022 15:29:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5D520B8218B;
        Tue, 18 Oct 2022 22:28:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A494C4347C;
        Tue, 18 Oct 2022 22:28:57 +0000 (UTC)
Date:   Tue, 18 Oct 2022 18:28:58 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Daniel Bristot de Oliveira <bristot@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-trace-devel@vger.kernel.org,
        kernel test robot <lkp@intel.com>
Subject: Re: [PATCH 1/2] rv/dot2c: Make automaton definition static
Message-ID: <20221018182858.67d8b76e@gandalf.local.home>
In-Reply-To: <20221018182553.06f13a50@gandalf.local.home>
References: <ffbb92010f643307766c9307fd42f416e5b85fa0.1661266564.git.bristot@kernel.org>
        <20221018182553.06f13a50@gandalf.local.home>
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

On Tue, 18 Oct 2022 18:25:53 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Tue, 23 Aug 2022 17:20:28 +0200
> Daniel Bristot de Oliveira <bristot@kernel.org> wrote:
> 
> > Monitor's automata definition is only used locally, so make dot2c generate
> > a static definition.
> > 
> > Link: https://lore.kernel.org/all/202208210332.gtHXje45-lkp@intel.com
> > Link: https://lore.kernel.org/all/202208210358.6HH3OrVs-lkp@intel.com
> >   
> 
> Somehow this fell through the cracks.
> 
> Daniel, is there any reason I shouldn't pull this in now?

I think when I applied:

  https://patchwork.kernel.org/project/linux-trace-devel/patch/a50e27c3738d6ef809f4201857229fed64799234.1661266564.git.bristot@kernel.org/

I mistook that to be a new version of this patch.

-- Steve
