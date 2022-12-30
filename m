Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1EE7659C86
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Dec 2022 22:37:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235457AbiL3Vhc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Dec 2022 16:37:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbiL3Vha (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Dec 2022 16:37:30 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22C26183B1
        for <linux-kernel@vger.kernel.org>; Fri, 30 Dec 2022 13:37:29 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B460E61A04
        for <linux-kernel@vger.kernel.org>; Fri, 30 Dec 2022 21:37:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9109C433EF;
        Fri, 30 Dec 2022 21:37:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1672436248;
        bh=RZWdt4XB8oEYqOJ7TLXEfy6u/9vVjgHGC22vojYrKuU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=RGUPm78EnqTjCsNChvzK/JAJLkKHy/pRjs2cDdrWEYOCcRMiT+bxuyebdvT5v2H1B
         Ucreh0yjL2j9LcCuoTQyKje3u4cvxCg9M2BRFt99vYpnVPl2QpvsRhwTLq9T/dH1Aj
         bZ5+NJ9xelnti/PLqfPQmzxYCRWc8GwbloqVhF6k=
Date:   Fri, 30 Dec 2022 13:37:26 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Dmitrii Bundin <dmitrii.bundin.a@gmail.com>
Cc:     jan.kiszka@siemens.com, kbingham@kernel.org,
        gregkh@linuxfoundation.org, mingo@redhat.com, x86@kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org, vbabka@suse.cz
Subject: Re: [PATCH] scripts/gdb: add mm introspection utils
Message-Id: <20221230133726.4c2e7e148a8a6627cd621e0f@linux-foundation.org>
In-Reply-To: <20221230163512.23736-1-dmitrii.bundin.a@gmail.com>
References: <20221230163512.23736-1-dmitrii.bundin.a@gmail.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 30 Dec 2022 19:35:12 +0300 Dmitrii Bundin <dmitrii.bundin.a@gmail.com> wrote:

> This command provides a way to traverse the entire page hierarchy by a
> given virtual address. In addition to qemu's commands info tlb/info mem
> it provides the complete information about the paging structure for an
> arbitrary virtual address. It supports 4Kb/2MB/1GB and 5 level paging.

Seems neat.  Should it have a check that it's being run on the supported
architecture?  Or do we just rely on non-x86_64 users learning not to
do that.
