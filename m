Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5431E662717
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 14:32:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233264AbjAINbn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 08:31:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234464AbjAINbg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 08:31:36 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D680111A30
        for <linux-kernel@vger.kernel.org>; Mon,  9 Jan 2023 05:31:35 -0800 (PST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 87D8F33CF4;
        Mon,  9 Jan 2023 13:31:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1673271094; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=q11OBrOHITPIlsyO/Dq+3gpMzEg2KWi7ZEM9FefLb9Q=;
        b=i037iJL/djQ5mmpq0Q9xQf6PRPaCBIYb7zVuc2oztZXnOV2RmbV7DOkwId9U2R7I3PGuGC
        OvfaLRiAtDJp3WpTgLbu+Q8wguH0DNKN0p/Xv5r/EB1ZDlQOqaMjOEwd4Fqxtte0LtlcyS
        p7S5xx3FBlx6+HMHSvLz/VFY5ZnVT+o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1673271094;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=q11OBrOHITPIlsyO/Dq+3gpMzEg2KWi7ZEM9FefLb9Q=;
        b=5yuFLTXK7G4DDQECNyPI7XU+ziLqdoDRSOKOLUh9nA1YsZFWaQhC2wg9ZT8RFCt+yzkuWs
        IfFe8IgfH47XxaCw==
Received: from suse.de (unknown [10.163.43.106])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 13E082C141;
        Mon,  9 Jan 2023 13:31:34 +0000 (UTC)
Date:   Mon, 9 Jan 2023 13:31:31 +0000
From:   Mel Gorman <mgorman@suse.de>
To:     Mike Rapoport <rppt@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/page_alloc: invert logic for early page
 initialisation checks
Message-ID: <20230109133131.ayebr4g2jaw3vpfy@suse.de>
References: <20230104191805.2535864-1-rppt@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20230104191805.2535864-1-rppt@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 04, 2023 at 09:18:05PM +0200, Mike Rapoport wrote:
> From: "Mike Rapoport (IBM)" <rppt@kernel.org>
> 
> Rename early_page_uninitialised() to early_page_initialised() and invert
> its logic to make the code more readable.
> 
> Signed-off-by: Mike Rapoport (IBM) <rppt@kernel.org>

Acked-by: Mel Gorman <mgorman@suse.de>

-- 
Mel Gorman
SUSE Labs
