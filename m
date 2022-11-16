Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4887A62CDC1
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 23:35:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233785AbiKPWfV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 17:35:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234491AbiKPWfN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 17:35:13 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8F076AEF4
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 14:35:12 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 74C8362005
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 22:35:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96E4CC433D6;
        Wed, 16 Nov 2022 22:35:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1668638111;
        bh=6zDhB7wL4SPKZtbC2WEXqEMk7eAszkbEyIdhAeOwjx4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=gVxUM8M1xMfeMxKCX5rRWGYxdmYkvsccJxVPSaPAtqESKby12wTciX8a8V6zURGa5
         deLs3XUy9jU4aC4tVQbiTOmXCeNMEK+1chD6wNPsn/gMD2YYD/B9Izu9zKHpDl9NY6
         RtN93zZPfKOrfL5YzWw9F3irqBMxqh0BGhFUtvv0=
Date:   Wed, 16 Nov 2022 14:35:10 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Gautam Menghani <gautammenghani201@gmail.com>
Cc:     rostedt@goodmis.org, mhiramat@kernel.org, shy828301@gmail.com,
        zokeefe@google.com, david@redhat.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/khugepaged: Refactor mm_khugepaged_scan_file
 tracepoint to remove filename from function call
Message-Id: <20221116143510.3eeef9ea8dd4798ffb763812@linux-foundation.org>
In-Reply-To: <20221026044524.54793-1-gautammenghani201@gmail.com>
References: <20221026044524.54793-1-gautammenghani201@gmail.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 26 Oct 2022 10:15:24 +0530 Gautam Menghani <gautammenghani201@gmail.com> wrote:

> Refactor the mm_khugepaged_scan_file tracepoint to move filename
> dereference to the tracepoint definition, for maintaing consistency with
> other tracepoints[1].
> 
> [1]:lore.kernel.org/lkml/20221024111621.3ba17e2c@gandalf.local.home/
> 

I just discovered by accident that this fixed an issue in a patch which
we merged during this -rc cycle.  I'll move it from mm-unstable into
mm-hotfixes-unstable so this fix is also merged during this cycle.

Please do remember to flag such thnigs when perparing the changelogs. 
Preferably with a Fixes: tag.


