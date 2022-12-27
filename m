Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96124656D50
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Dec 2022 18:10:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231652AbiL0RKT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Dec 2022 12:10:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231966AbiL0RKK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Dec 2022 12:10:10 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B032B485
        for <linux-kernel@vger.kernel.org>; Tue, 27 Dec 2022 09:10:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=+Vpv87sg+/5qiZS3pOHNbdoWVr1LHyG34wJFi6NlKqY=; b=vQWLjwSpZwpZyvDw/Yec+DCAJq
        IllPu/c5h7Tl5gtwiggcgUQv5LxEUG8y3tMIL2qnhUGc+dXczb2BtSM9bFHIf73Uo5uYwRuauo24j
        9A04uwIWqmJDrOg+N9X3PY8yYZ5INs2Txe6dqqQmAixHPjmQfnjUhk6+cv9L0RLSjH7dyUZlq1wB4
        LM4udSulxGKlh3kyR6YiuDb1oNUdD7aT1+3/+ByPPA2elaZdq1zqFjY48SD+9Pd3KmRb7n3XhOMRW
        pnD0hI3DdSTdkGyVlKl52aaX1I6Ygmh8ZwG7zZ4d3IlmLrT5JKi1MD+aHUGOsw8dW7Xijg1z6YEE1
        COgSpuGA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pADSp-00En8A-KV; Tue, 27 Dec 2022 17:10:07 +0000
Date:   Tue, 27 Dec 2022 09:10:07 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Mike Leach <mike.leach@linaro.org>
Cc:     linux-arm-kernel@lists.infradead.org, coresight@lists.linaro.org,
        linux-kernel@vger.kernel.org, mathieu.poirier@linaro.org,
        suzuki.poulose@arm.com, acme@kernel.org, james.clark@arm.com
Subject: Re: [PATCH v5 4/6] coresight: configfs: Modify config files to allow
 userspace use
Message-ID: <Y6sm74wfjenzA0v9@infradead.org>
References: <20221219234638.3661-1-mike.leach@linaro.org>
 <20221219234638.3661-5-mike.leach@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221219234638.3661-5-mike.leach@linaro.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 19, 2022 at 11:46:36PM +0000, Mike Leach wrote:
> Update coresight-config.h and the coresight-config-file.c & .h
> to allow use in userspace programs.
> 
> Use __KERNEL__ defines to filter out driver only structures and
> elements so that user space programs can use the descriptor structures.
> 
> Abstract memory allocation in coresight-config-file.c to allow read
> file functions to be run in userspace and kernel drivers.

That's now how kernel code is written.
