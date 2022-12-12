Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A951B64A3BB
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Dec 2022 15:50:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232426AbiLLOuR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Dec 2022 09:50:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232290AbiLLOuK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Dec 2022 09:50:10 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A057013D17
        for <linux-kernel@vger.kernel.org>; Mon, 12 Dec 2022 06:50:09 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3DD626111E
        for <linux-kernel@vger.kernel.org>; Mon, 12 Dec 2022 14:50:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29BF4C433D2;
        Mon, 12 Dec 2022 14:50:08 +0000 (UTC)
Date:   Mon, 12 Dec 2022 09:50:06 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Yang Jihong <yangjihong1@huawei.com>
Cc:     <mhiramat@kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4] tracing: Fix infinite loop in tracing_read_pipe on
 overflowed print_trace_line
Message-ID: <20221212095006.52b6cce0@gandalf.local.home>
In-Reply-To: <46733774-295a-ade9-497d-6e73c6c468de@huawei.com>
References: <20221129113009.182425-1-yangjihong1@huawei.com>
        <46733774-295a-ade9-497d-6e73c6c468de@huawei.com>
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

On Mon, 12 Dec 2022 10:57:08 +0800
Yang Jihong <yangjihong1@huawei.com> wrote:

> Hello,
> 
> PING.
> 
> Are there any other problems with this patch?

Thanks for the ping, I'll take a look at it. It somehow got lost in the
noise of other patches :-/

-- Steve
