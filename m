Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EDA26CCDA7
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 00:47:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229755AbjC1Wru (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 18:47:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229530AbjC1Wrt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 18:47:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BE422134;
        Tue, 28 Mar 2023 15:47:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EAE21619A2;
        Tue, 28 Mar 2023 22:47:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 065D0C433EF;
        Tue, 28 Mar 2023 22:47:45 +0000 (UTC)
Date:   Tue, 28 Mar 2023 18:47:43 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Ajay Kaher <akaher@vmware.com>
Cc:     mhiramat@kernel.org, linux-kernel@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org, chinglinyu@google.com,
        namit@vmware.com, srivatsab@vmware.com, srivatsa@csail.mit.edu,
        amakhalov@vmware.com, vsirnapalli@vmware.com, tkundu@vmware.com,
        er.ajay.kaher@gmail.com
Subject: Re: [PATCH 0/8] tracing: introducing eventfs
Message-ID: <20230328184743.7984463b@gandalf.local.home>
In-Reply-To: <1674407228-49109-9-git-send-email-akaher@vmware.com>
References: <1674407228-49109-1-git-send-email-akaher@vmware.com>
        <1674407228-49109-9-git-send-email-akaher@vmware.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 22 Jan 2023 22:37:08 +0530
Ajay Kaher <akaher@vmware.com> wrote:

> Events Tracing infrastructure contains lot of files, directories
> (internally in terms of inodes, dentries). And ends up by consuming
> memory in MBs. We can have multiple events of Events Tracing, which
> further requires more memory.
> 
> Instead of creating inodes/dentries, eventfs could keep meta-data and
> skip the creation of inodes/dentries. As and when require, eventfs will
> create the inodes/dentries only for required files/directories.
> Also eventfs would delete the inodes/dentries once no more requires
> but preserve the meta data.
> 

Hi Ajay,

Is there going to be any more work on this?

-- Steve

> Tracing events took ~9MB, with this approach it took ~4.5MB
> for ~10K files/dir.
> 
> [PATCH 1/8]: Introducing struct tracefs_inode
> [PATCH 2/8]: Adding eventfs-dir-add functions
> [PATCH 3/8]: Adding eventfs-file-add function
> [PATCH 4/8]: Adding eventfs-file-directory-remove function
> [PATCH 5/8]: Adding functions to create-eventfs-files
> [PATCH 6/8]: Adding eventfs lookup, read, open functions
> [PATCH 7/8]: Creating tracefs_inode_cache
> [PATCH 8/8]: Moving tracing events to eventfs

