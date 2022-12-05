Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F4C8643841
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 23:42:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233752AbiLEWmS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 17:42:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230235AbiLEWmQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 17:42:16 -0500
Received: from nautica.notk.org (nautica.notk.org [91.121.71.147])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2865FDEE;
        Mon,  5 Dec 2022 14:42:16 -0800 (PST)
Received: by nautica.notk.org (Postfix, from userid 108)
        id 77EB0C01B; Mon,  5 Dec 2022 23:42:24 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
        t=1670280144; bh=R/AMBoyyHa2hQLy+oRLOqypPkWT7gf7zzItJ5Gnn7rY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kzcP1SFaQ1LbJMT2De9D8nQsQthP1PSxDKCfbDuHe+ZBTeL5NT8TM2OqOeOl3I6mf
         jDuQLB3mhmcN2A5AnfySJk/qe9uodKQe+65DsEIRauq7t5qiwpfJE+dakdI7tscZMP
         6UqB04Mln3xO5LqptemZAlI2IkGQQcxZs57+Fk9KM6pOKX/uZ1l+yzVutGLUm31md6
         MJfWAc0Sxcy0W4YORDAlFUbACGUGrVNVDpiMJgdpNcVbtYnUzq2c2uZAuWCOsakdPr
         AJps69lPGsVTRNW4pI/nsmxZ+Xc89h+ll/nVMsjFu7eKgRFn/c4GbHDiPmPLFNDmw8
         e0YYx3o5Smr6w==
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
Received: from odin.codewreck.org (localhost [127.0.0.1])
        by nautica.notk.org (Postfix) with ESMTPS id C56E9C009;
        Mon,  5 Dec 2022 23:42:22 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
        t=1670280144; bh=R/AMBoyyHa2hQLy+oRLOqypPkWT7gf7zzItJ5Gnn7rY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kzcP1SFaQ1LbJMT2De9D8nQsQthP1PSxDKCfbDuHe+ZBTeL5NT8TM2OqOeOl3I6mf
         jDuQLB3mhmcN2A5AnfySJk/qe9uodKQe+65DsEIRauq7t5qiwpfJE+dakdI7tscZMP
         6UqB04Mln3xO5LqptemZAlI2IkGQQcxZs57+Fk9KM6pOKX/uZ1l+yzVutGLUm31md6
         MJfWAc0Sxcy0W4YORDAlFUbACGUGrVNVDpiMJgdpNcVbtYnUzq2c2uZAuWCOsakdPr
         AJps69lPGsVTRNW4pI/nsmxZ+Xc89h+ll/nVMsjFu7eKgRFn/c4GbHDiPmPLFNDmw8
         e0YYx3o5Smr6w==
Received: from localhost (odin.codewreck.org [local])
        by odin.codewreck.org (OpenSMTPD) with ESMTPA id 3795af09;
        Mon, 5 Dec 2022 22:42:10 +0000 (UTC)
Date:   Tue, 6 Dec 2022 07:41:55 +0900
From:   Dominique Martinet <asmadeus@codewreck.org>
To:     Christian Schoenebeck <linux_oss@crudebyte.com>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build failure after merge of the v9fs tree
Message-ID: <Y45zsz71RfXbySDq@codewreck.org>
References: <20221205150316.6fac25f2@canb.auug.org.au>
 <Y41vKkaH9tvRXCfv@codewreck.org>
 <46397336.ChKRcxMYMu@silver>
 <3823616.UlgstfPZBx@silver>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <3823616.UlgstfPZBx@silver>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Christian Schoenebeck wrote on Mon, Dec 05, 2022 at 09:40:06PM +0100:
> Dominique, looking at your 9p queue, I just realized what happened here: I 
> posted a v2 of these two patches, which got lost for some reason:
> 
> https://lore.kernel.org/all/cover.1669144861.git.linux_oss@crudebyte.com/
> 
> The currently queued 1st patch is still v1 as well.

Oh. Now how did I manage that one..
Thanks for the catch, and v2 had the valid printf modifier...

Sorry for all the trouble :(
-- 
Dominique
