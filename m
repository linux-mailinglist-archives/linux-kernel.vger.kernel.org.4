Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F01E06643BA
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 15:55:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238765AbjAJOyb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 09:54:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238844AbjAJOyP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 09:54:15 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F62958FA7;
        Tue, 10 Jan 2023 06:53:56 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1DB8CB8169C;
        Tue, 10 Jan 2023 14:53:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC944C433F2;
        Tue, 10 Jan 2023 14:53:48 +0000 (UTC)
Date:   Tue, 10 Jan 2023 09:53:47 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Daniel Wagner <dwagner@suse.de>
Cc:     Daniel Bristot de Oliveira <bristot@kernel.org>,
        linux-trace-devel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tools/rtla: Explicitly list libtraceevent dependency
Message-ID: <20230110095347.3662c3ba@gandalf.local.home>
In-Reply-To: <20230110095137.18168c29@gandalf.local.home>
References: <20230110131805.16242-1-dwagner@suse.de>
        <42d1e999-79a6-94dc-cc88-77520ddce068@kernel.org>
        <20230110140814.2yz4if2e2fasnu7t@carbon.lan>
        <94fd6fb5-c87a-b02e-40bc-b2e2c99529d5@kernel.org>
        <20230110144536.knepnpxsp4mw67no@carbon.lan>
        <20230110095137.18168c29@gandalf.local.home>
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

On Tue, 10 Jan 2023 09:51:37 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

> There's many interfaces that require the libtraceevent header files to work
> with libtracefs. Anything that uses libtracefs must also use libtraceevent,
> as libtracefs is really just an extension of libtraceevent.

Although, I will say, since I hate the libtraceevent interface so much, I
may like to hide it via a fully functional libtracefs interface that hides
it :-)  In which case, this would be correct!

-- Steve
