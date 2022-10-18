Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62CE7602E70
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 16:28:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231438AbiJRO2K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 10:28:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231404AbiJRO2I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 10:28:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CE20C09A0
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 07:28:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CDEA36153D
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 14:28:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 949A7C433D6;
        Tue, 18 Oct 2022 14:28:02 +0000 (UTC)
Date:   Tue, 18 Oct 2022 10:28:03 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
Cc:     Shuah Khan <shuah@kernel.org>, <linux-kernel@vger.kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Akanksha J N <akanksha@linux.vnet.ibm.com>
Subject: Re: [PATCH v2 1/2] selftests/ftrace: Add check for ping command for
 trigger tests
Message-ID: <20221018102803.6fac6883@gandalf.local.home>
In-Reply-To: <4ec67d1b5c5d4e693a4826a89c9fd4eca5343eb6.1666101523.git.naveen.n.rao@linux.vnet.ibm.com>
References: <cover.1666101523.git.naveen.n.rao@linux.vnet.ibm.com>
        <4ec67d1b5c5d4e693a4826a89c9fd4eca5343eb6.1666101523.git.naveen.n.rao@linux.vnet.ibm.com>
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

On Tue, 18 Oct 2022 19:33:40 +0530
"Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com> wrote:

> All these tests depend on the ping command and will fail if it is not
> found. Allow tests to specify dependencies on programs through the
> 'requires' field. Add dependency on 'ping' for some of the trigger
> tests.
> 

Perhaps include:

Link: https://lore.kernel.org/all/20221017104312.16af5467@gandalf.local.home/

Reviewed-by: Steven Rostedt (Google) <rostedt@goodmis.org>

-- Steve


> Reported-by: Akanksha J N <akanksha@linux.vnet.ibm.com>
> Suggested-by: Steven Rostedt <rostedt@goodmis.org>
> Signed-off-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
