Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F07C6AC9A7
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 18:20:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230055AbjCFRUV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 12:20:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230083AbjCFRUN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 12:20:13 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC7B459D8
        for <linux-kernel@vger.kernel.org>; Mon,  6 Mar 2023 09:19:50 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1FA54B80FEF
        for <linux-kernel@vger.kernel.org>; Mon,  6 Mar 2023 17:10:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6489C433EF;
        Mon,  6 Mar 2023 17:10:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678122608;
        bh=dz5CyE3yXjvIolQRfz3Ul+YWATCmkUS4k4JFSEnWwfw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=K2yeJ73mYnQwNzeW4rqHF7Y+K12+AFhBxNkRMGiblVGDlf3mUdjz5EO53AiBB31LX
         Nv16PUlqC65cgm53mG0uXqgp8KA5y/4z7s4ae2bCePg5ImJtIaBiiX7IG1maahw5DX
         MoGCsjzzlQpxTTLzIAhJCzwhjlqSr4NHFG4LatWAlpDOn9cO4t0n9PvTAH9YUaSnax
         poLXQXabAQruPqshgXycp7sZVkEtM70S/WoeQ9SBj+yhyaOZ3qKc8X8RhbaB6ET3//
         g7GqrUiQ1iZMRGHgnE6pKI+VqmwC2s/bRk+LI/z8HEm6/6WAQToGl3DYuN2tYk3JRP
         MB+jxmIGZk7aA==
Date:   Mon, 6 Mar 2023 18:09:57 +0100
From:   Christian Brauner <brauner@kernel.org>
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     hughd@google.com, akpm@linux-foundation.org, willy@infradead.org,
        linux-mm@kvack.org, p.raghav@samsung.com, da.gomez@samsung.com,
        a.manzanares@samsung.com, dave@stgolabs.net, yosryahmed@google.com,
        keescook@chromium.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/6] tmpfs: add the option to disable swap
Message-ID: <20230306170957.tk6pbx2ma3kb4qi4@wittgenstein>
References: <20230302232758.888157-1-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230302232758.888157-1-mcgrof@kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 02, 2023 at 03:27:52PM -0800, Luis Chamberlain wrote:
> After a couple of RFCs I think this is ready for PATCH form. Review
> is appreciated. Below the changes I also list the series of tests
> I performed to verify correctness. In short you either create a fs
> with swap or without, but if you can't change that option later.
> If we really wanted to, we could work on accepting this change on
> reconfigure (remount) but its not clear yet that is desirable so
> for now keep things simple.
> 
> Changes since last RFCv2:
> 
>   o Added Christian Brauner'd Acked-by for the noswap patch (the only
>     change in that patch is just the new shmem_show_options() change I
>     describe below).

Sorry, didn't get around to the rest of the patches earlier. Not an mm
expert but even the mm changes look straightforward to me so,

Reviewed-by: Christian Brauner <brauner@kernel.org>
