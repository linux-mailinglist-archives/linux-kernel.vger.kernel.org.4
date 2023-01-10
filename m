Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A0DD664B97
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 19:51:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239645AbjAJSvT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 13:51:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239726AbjAJSua (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 13:50:30 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15AE050E59
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 10:44:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=nHD/v9Shv+QvxSLMYS5kWGQ7KCCJ43qEeGTst2B4xYI=; b=puLcHQBd34dwwf97Y3CsAujXWo
        9ayx8BPpcPdeDBwGiEVbOlkWh0xkFdzgj1OfOJWLfeLWDv1J6l3lgaj/2WnfKdHlG0K75Ye67qXlZ
        1UOAIkEXhBvMuB0czhoS4DFcHV32O5rn27ERcmhm9zMRw8ogTIYWar/Ecpd2WcXf24srEdyvMYn2R
        PuavNW71R9SxkAiJ1etqW69s2EElgnsBnkwlccQAzYD3Wn8Ntymulx/wM1YDHRjZhZ85TsieYRi0g
        YwB5UD5lA2+DjOuahNOmMTOMM/ewXYYur1T9x0vobWKYpl7SxbPCl9ajbYSRax9V9AsdwfT1XhByC
        nxBOjKTQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pFJbn-003S8J-SO; Tue, 10 Jan 2023 18:44:27 +0000
Date:   Tue, 10 Jan 2023 18:44:27 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Vernon Yang <vernon2gm@gmail.com>
Cc:     Liam.Howlett@oracle.com, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/mmap: fix comment of unmapped_area{_topdown}
Message-ID: <Y72yC04t03AOHQNI@casper.infradead.org>
References: <20230110150320.1676299-1-vernon2gm@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230110150320.1676299-1-vernon2gm@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 10, 2023 at 11:03:20PM +0800, Vernon Yang wrote:
> - * @info: The unmapped area information including the range (low_limit -
> + * @info: The unmapped area information including the range [low_limit -
>   * hight_limit), the alignment offset and mask.

s/hight_limit/high_limit/

> - * @info: The unmapped area information including the range (low_limit -
> + * @info: The unmapped area information including the range [low_limit -
>   * hight_limit), the alignment offset and mask.

ditto
