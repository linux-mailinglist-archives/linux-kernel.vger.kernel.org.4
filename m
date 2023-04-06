Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D94DF6D93F0
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 12:26:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236995AbjDFK0v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 06:26:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229798AbjDFK0t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 06:26:49 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C16110D5
        for <linux-kernel@vger.kernel.org>; Thu,  6 Apr 2023 03:26:48 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 17F72222C2;
        Thu,  6 Apr 2023 10:26:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1680776807; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=iHBkwLBZGwaLgGrr87Z0n9wG3D2/oks9VJLx3TNXe9I=;
        b=N4DKmVws4j4Jqslgem6VRlODHl5R7Wb2MD6zNeexXRBIzG9IPsicwH3QR7lubCFJJ9LtGT
        8RbO73/vjBXGQ29JD3RJ17e6aB8gg5AG2baVgg+VaSmAt9WWYl/5vhDxYp6RpGDqcBGymB
        BNmKBdzBKL8odi0D4mvT7p4HdzRyhEU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1680776807;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=iHBkwLBZGwaLgGrr87Z0n9wG3D2/oks9VJLx3TNXe9I=;
        b=LxPgleVbYK05hcjOotu9KyqbOEHs6LptbCcljzE6/R8032vFpRbxH4+oQE1/TjIhaH+pd3
        96FC+zsycRueD+DQ==
Received: from suse.de (unknown [10.163.43.106])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id AC46A2C141;
        Thu,  6 Apr 2023 10:26:45 +0000 (UTC)
Date:   Thu, 6 Apr 2023 11:26:43 +0100
From:   Mel Gorman <mgorman@suse.de>
To:     Qi Zheng <zhengqi.arch@bytedance.com>
Cc:     akpm@linux-foundation.org, willy@infradead.org, lstoakes@gmail.com,
        vbabka@suse.cz, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] mm: mlock: use folios_put() in mlock_folio_batch()
Message-ID: <20230406102643.rjotuba6mofxrs3o@suse.de>
References: <20230405161854.6931-1-zhengqi.arch@bytedance.com>
 <20230405161854.6931-2-zhengqi.arch@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20230405161854.6931-2-zhengqi.arch@bytedance.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 06, 2023 at 12:18:54AM +0800, Qi Zheng wrote:
> Since we have updated mlock to use folios, it's better
> to call folios_put() instead of calling release_pages()
> directly.
> 
> Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>

Acked-by: Mel Gorman <mgorman@suse.de>

-- 
Mel Gorman
SUSE Labs
