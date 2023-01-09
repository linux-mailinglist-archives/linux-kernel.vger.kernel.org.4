Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DA2B662720
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 14:33:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237161AbjAINdU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 08:33:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234878AbjAINce (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 08:32:34 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E247D1EC70
        for <linux-kernel@vger.kernel.org>; Mon,  9 Jan 2023 05:32:33 -0800 (PST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 81FEF37AA9;
        Mon,  9 Jan 2023 13:32:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1673271152; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=qbzCTP/85nBnKBy0yf1vX2YlertLo+PVxhrAA9r4K5Y=;
        b=R1hxL4WlPmXizZECfhFZlMKkVD2vns6tfcllj3Zm4u5y7z4dax4IT03niszeM84SuWMhM3
        Iy8NODcIlHIdGgmP79EFHx5x5nO8yqx3+ktH0IPxRTuDvdUf/GUBxELxQaUlTy0WNIeUfG
        nRcHtp7vnaZ4QjcpCKYDP810d/nAeFc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1673271152;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=qbzCTP/85nBnKBy0yf1vX2YlertLo+PVxhrAA9r4K5Y=;
        b=84EcQo+VuxFOHB8Z1zu0r1J2M+dN8ngaoeesFMG1DmtB66AjCO3jh7hajUeDZMsG4Fe3wq
        08VtH1QShSMGWcBA==
Received: from suse.de (unknown [10.163.43.106])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 3AE312C141;
        Mon,  9 Jan 2023 13:32:32 +0000 (UTC)
Date:   Mon, 9 Jan 2023 13:32:26 +0000
From:   Mel Gorman <mgorman@suse.de>
To:     Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     linux-mm@kvack.org, rppt@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/page_alloc: Repalce with deferred_pages_enabled()
 wherever applicable
Message-ID: <20230109133226.76ekjhtjfhzdyau7@suse.de>
References: <20230105082506.241529-1-anshuman.khandual@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20230105082506.241529-1-anshuman.khandual@arm.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 05, 2023 at 01:55:06PM +0530, Anshuman Khandual wrote:
> Instead of directly accessing static deferred_pages, replace such instances
> with the helper deferred_pages_enabled(). No functional change is intended.
> 
> Cc; Andrew Morton <akpm@linux-foundation.org>
> Cc: linux-mm@kvack.org
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>

Acked-by: Mel Gorman <mgorman@suse.de>

-- 
Mel Gorman
SUSE Labs
