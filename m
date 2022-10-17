Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4836360111A
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 16:29:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230076AbiJQO3o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 10:29:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229989AbiJQO3m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 10:29:42 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FD51E026
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 07:29:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 87344B818B8
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 14:29:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A55FC433D6;
        Mon, 17 Oct 2022 14:29:36 +0000 (UTC)
Date:   Mon, 17 Oct 2022 10:30:00 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     linux-kernel@vger.kernel.org, mhiramat@kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>,
        Shuah Khan <shuah@kernel.org>
Subject: Re: [PATCH] tracing: fix dynevent test requirements
Message-ID: <20221017103000.7d0fa449@gandalf.local.home>
In-Reply-To: <20221017090741.2881918-1-mark.rutland@arm.com>
References: <20221017090741.2881918-1-mark.rutland@arm.com>
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

On Mon, 17 Oct 2022 10:07:41 +0100
Mark Rutland <mark.rutland@arm.com> wrote:

> Currently a couple of dynevent tests will always report UNSUPPORTED and
> not run, even when support is actually present.
> 
> In commit:
> 
>   95c104c378dc7d4c ("tracing: Auto generate event name when creating a group of events")
> 
> The README text for synthetic events was changed from:
> 
>   "e[:[<group>/]<event>] <attached-group>.<attached-event> [<args>]\n"
> 
> To:

This was already fixed here:

 https://lore.kernel.org/all/20221010074207.714077-1-svens@linux.ibm.com/

Shuah, can you take Sven's patch through your tree?

Thanks,

-- Steve

