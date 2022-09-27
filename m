Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 555165EC2BC
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 14:31:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231995AbiI0Mbl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 08:31:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230482AbiI0Mbg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 08:31:36 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFE5B6EF00
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 05:31:34 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id AFF0868AFE; Tue, 27 Sep 2022 14:31:30 +0200 (CEST)
Date:   Tue, 27 Sep 2022 14:31:30 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Liu Shixin <liushixin2@huawei.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        Seth Jennings <sjenning@redhat.com>,
        Dan Streetman <ddstreet@ieee.org>,
        Vitaly Wool <vitaly.wool@konsulko.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Nathan Chancellor <nathan@kernel.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Kefeng Wang <wangkefeng.wang@huawei.com>
Subject: Re: [PATCH v5 2/5] Revert "frontswap: simplify
 frontswap_register_ops"
Message-ID: <20220927123130.GA5549@lst.de>
References: <20220915035003.3347466-1-liushixin2@huawei.com> <20220915035003.3347466-3-liushixin2@huawei.com> <20220920121305.GA4237@lst.de> <2b469a5c-7960-ca6a-9360-c7d3aa26e8ae@huawei.com> <20220927072754.GB16710@lst.de> <986efc9f-0deb-f705-dff1-f4d5992c2b8d@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <986efc9f-0deb-f705-dff1-f4d5992c2b8d@huawei.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 27, 2022 at 07:12:58PM +0800, Liu Shixin wrote:
> If not do this, while some user enable swap device first and then enable zswap,
> zswap will not take effect. The user need to re-enable the swap device which is
> inconvenient.

So load the module before swapping on, just like you'd load any driver
before you expect to use it.
