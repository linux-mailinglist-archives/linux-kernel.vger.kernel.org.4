Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30D1E6C98A7
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 01:19:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229710AbjCZXTh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Mar 2023 19:19:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbjCZXTf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Mar 2023 19:19:35 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A884449F
        for <linux-kernel@vger.kernel.org>; Sun, 26 Mar 2023 16:19:34 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id A249268B05; Mon, 27 Mar 2023 01:19:31 +0200 (CEST)
Date:   Mon, 27 Mar 2023 01:19:31 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Liu Shixin <liushixin2@huawei.com>
Cc:     Seth Jennings <sjenning@redhat.com>,
        Dan Streetman <ddstreet@ieee.org>,
        Vitaly Wool <vitaly.wool@konsulko.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Christoph Hellwig <hch@lst.de>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH -next v7 1/4] mm/zswap: remove
 zswap_entry_cache_{create,destroy} helper function
Message-ID: <20230326231931.GA19631@lst.de>
References: <20230325071420.2246461-1-liushixin2@huawei.com> <20230325071420.2246461-2-liushixin2@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230325071420.2246461-2-liushixin2@huawei.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=0.0 required=5.0 tests=SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
