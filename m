Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D34BB63B0EE
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 19:17:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232003AbiK1SRY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 13:17:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234226AbiK1SQz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 13:16:55 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE09121812
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 10:00:43 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9F425B80E81
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 18:00:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE0F9C43151;
        Mon, 28 Nov 2022 18:00:40 +0000 (UTC)
Date:   Mon, 28 Nov 2022 13:00:38 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     <zhang.songyi@zte.com.cn>
Cc:     <mhiramat@kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH linux-next] ring_buffer: remove redundant ret variables
Message-ID: <20221128130038.4e038f1b@gandalf.local.home>
In-Reply-To: <202211282110006083500@zte.com.cn>
References: <202211282110006083500@zte.com.cn>
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

On Mon, 28 Nov 2022 21:10:00 +0800 (CST)
<zhang.songyi@zte.com.cn> wrote:

> From: zhang songyi <zhang.songyi@zte.com.cn>
> 
> Return values from ring_buffer_bytes_cpu(), ring_buffer_overrun_cpu(),
> ring_buffer_commit_overrun_cpu(), ring_buffer_dropped_events_cpu()
> directly instead of taking this in another redundant variable.
> 
> Signed-off-by: zhang songyi <zhang.songyi@zte.com.cn>
> ---

Fine, I may add this, as it looks like leftovers from 8aabee573dff
("ring-buffer: remove unneeded get_online_cpus"). But they make no real
difference staying as is.

-- Steve
