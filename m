Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EFCE72ECE4
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 22:27:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232360AbjFMU1K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 16:27:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232290AbjFMU1G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 16:27:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F8FA1BE4;
        Tue, 13 Jun 2023 13:27:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 04FEC63AB4;
        Tue, 13 Jun 2023 20:27:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B8F0C433C0;
        Tue, 13 Jun 2023 20:27:03 +0000 (UTC)
Date:   Tue, 13 Jun 2023 16:27:01 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Daniel Bristot de Oliveira <bristot@kernel.org>
Cc:     "Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
        linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, Juri Lelli <juri.lelli@redhat.com>,
        William White <chwhite@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>
Subject: Re: [PATCH V3 02/11] rtla: Add --house-keeping option
Message-ID: <20230613162701.3730af5d@gandalf.local.home>
In-Reply-To: <8cbfa5c1-bc6b-741e-3739-f251edeecfbf@kernel.org>
References: <cover.1686066600.git.bristot@kernel.org>
        <6a6c78a579a96ba8b02ae67ee1e0ba2cb5e03c4a.1686066600.git.bristot@kernel.org>
        <20230612230600.7e009782e8365cd5f1bce444@kernel.org>
        <8cbfa5c1-bc6b-741e-3739-f251edeecfbf@kernel.org>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 12 Jun 2023 16:21:35 +0200
Daniel Bristot de Oliveira <bristot@kernel.org> wrote:

> On 6/12/23 16:06, Masami Hiramatsu (Google) wrote:
> > On Tue,  6 Jun 2023 18:12:16 +0200
> > Daniel Bristot de Oliveira <bristot@kernel.org> wrote:
> >   
> >> To avoid having rtla interfering with the measurement threads, add an
> >> option for the user to set the CPUs in which rtla should run. For
> >> instance:
> >>
> >>   # rtla timerlat top -H 0 -C 1-7  
> > Isn't it '-c 1-7' instead of '-C', because -C is for cgroup name?  
> 
> Ooops, you are right.
> 

Unless something else comes up, I updated the change log here.

-- Steve

