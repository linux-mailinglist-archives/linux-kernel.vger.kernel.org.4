Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B84465E764F
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Sep 2022 10:56:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231464AbiIWI4k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Sep 2022 04:56:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230035AbiIWI4e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Sep 2022 04:56:34 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1966812C6BC;
        Fri, 23 Sep 2022 01:56:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=SkqBatrA9DneO/UKQ0v5tMtiBd8FB0TJQs5jyjIjxvk=; b=0aKjtOPMYPRnmvlt7yGemeYy5A
        zF2Jjz7sYTNx0Cqn3rlVnsF487Xfhi/Na+iy2zzkh/4g/Zf8gAcB7ZhSzuPoGvpm18Ai3jjH9x7gv
        NPBycYy/hluSQU0hswWjgAJke1l7RcVUFc2dY+LU3hunt0oGaO7jG7/ldyGZqyEc+y320Kf5quwH/
        BeOtlgib4VVrcAfRCWOVLTNMVbe1nexHFf/RWf5oZq5JhK+68Yj+/qAmz/lyk6ZWthqQY94W8oD/d
        h3RyBdjgYR0U4yWZlK1eIX6YSmQyIMfVOgUPR+dpWpUcVXxJdHSl/TIkw5oG5RP5mlz/hURa/VgT6
        6acfMZcQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1obeU2-0036FW-Pe; Fri, 23 Sep 2022 08:56:30 +0000
Date:   Fri, 23 Sep 2022 01:56:30 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Yu Kuai <yukuai3@huawei.com>
Cc:     jack@suse.cz, paolo.valente@linaro.org, axboe@kernel.dk,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        yukuai1@huaweicloud.com, yi.zhang@huawei.com
Subject: Re: [PATCH v3 3/5] block, bfq: don't disable wbt if
 CONFIG_BFQ_GROUP_IOSCHED is disabled
Message-ID: <Yy10vjnxAvca8Ee1@infradead.org>
References: <20220922113558.1085314-1-yukuai3@huawei.com>
 <20220922113558.1085314-4-yukuai3@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220922113558.1085314-4-yukuai3@huawei.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 22, 2022 at 07:35:56PM +0800, Yu Kuai wrote:
> wbt and bfq should work just fine if CONFIG_BFQ_GROUP_IOSCHED is disabled.

Umm, wouldn't this be something decided at runtime, that is not
if CONFIG_BFQ_GROUP_IOSCHED is enable/disable in the kernel build
if the hierarchical cgroup based scheduling is actually used for a
given device?
