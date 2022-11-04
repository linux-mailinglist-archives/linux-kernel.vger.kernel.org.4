Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D81061A5C2
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Nov 2022 00:33:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229563AbiKDXcw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Nov 2022 19:32:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229548AbiKDXcp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Nov 2022 19:32:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15DC21F614
        for <linux-kernel@vger.kernel.org>; Fri,  4 Nov 2022 16:32:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B28E662395
        for <linux-kernel@vger.kernel.org>; Fri,  4 Nov 2022 23:32:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC93EC433D7;
        Fri,  4 Nov 2022 23:32:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1667604764;
        bh=El1VzbBmXEiO1hewni3vDdOVzSbWsTfZQABAOrh8Qko=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=qQuwCVbrylPdMQHS2SCn5r3Xavs2UN+76BJTr/2W3sN7GwpiM34OaTeBKX/+N532X
         KXv9eHuiBxTxTGSTDdcrB1n0ELkSMeaZuh/yWMp1NOcrtBSuZe42Zafurq4toX7Nav
         2mzX/I9GecFhSKALvgA+rYuFoleLIrZTkmEuz3/w=
Date:   Fri, 4 Nov 2022 16:32:43 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     "Gupta, Pankaj" <pankaj.gupta@amd.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        dan.j.williams@intel.com, thomas.lendacky@amd.com
Subject: Re: [PATCH] mm/memremap.c: map FS_DAX device memory as decrypted
Message-Id: <20221104163243.a4c69e538bbfe3ee620e49f5@linux-foundation.org>
In-Reply-To: <0cbbe205-4573-2dce-14bf-f07c117ac7af@amd.com>
References: <20221102160728.3184016-1-pankaj.gupta@amd.com>
        <20221102130536.96c487d341544b7482eed038@linux-foundation.org>
        <0cbbe205-4573-2dce-14bf-f07c117ac7af@amd.com>
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

On Thu, 3 Nov 2022 08:55:40 +0100 "Gupta, Pankaj" <pankaj.gupta@amd.com> wrote:

> > Should this be backported into earlier kernels?
> 
> Yes, kernel >= 5.10 for clean back-port as it contains the below commit.
> 
> > 
> > Is b7b3c01b19159 a suitable Fixes: target?
> 
> Not very sure. But seems like the right commit for fixes tag as the 
> target code is moved in this commit with multiple range support addition.
> 
> Should I send a v2 with fixes & stable kernel fixes tag?

That's OK thanks - I made those changes to my copy.
