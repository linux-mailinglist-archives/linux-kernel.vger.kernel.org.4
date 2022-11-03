Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C7A76174EA
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 04:24:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231174AbiKCDYu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 23:24:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231140AbiKCDYp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 23:24:45 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C4A525EF;
        Wed,  2 Nov 2022 20:24:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 1852ECE2502;
        Thu,  3 Nov 2022 03:24:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29AFBC433D6;
        Thu,  3 Nov 2022 03:24:39 +0000 (UTC)
Date:   Wed, 2 Nov 2022 23:24:37 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Li Huafei <lihuafei1@huawei.com>
Cc:     <mhiramat@kernel.org>, <mark.rutland@arm.com>,
        <linux-kernel@vger.kernel.org>,
        <linux-trace-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] ftrace: Fix use-after-free for dynamic ftrace_ops
Message-ID: <20221102232437.6e2b1ebd@rorschach.local.home>
In-Reply-To: <20221102232334.0c1ae93b@rorschach.local.home>
References: <20221103031010.166498-1-lihuafei1@huawei.com>
        <20221102232334.0c1ae93b@rorschach.local.home>
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

On Wed, 2 Nov 2022 23:23:34 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> I think you misunderstood me. What I was suggesting was to get rid of
> the ftrace_enabled check. The DYNAMIC part is most definitely needed.
> 
> 	if (!command) {
> 		if (ops->flags & FTRACE_OPS_FL_DYNAMIC)
> 			goto out;
> 		return 0;
> 	}


Nevermind, I forgot that the out is before the DYNAMIC check.

   ;-)

-- Steve
