Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 795BB6CB17B
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 00:13:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230220AbjC0WN1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 18:13:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229534AbjC0WN0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 18:13:26 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77BD210A;
        Mon, 27 Mar 2023 15:13:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=iolzSzHh8n1CsNhfREBZRStuKpd7zD3j7lH/ZUf3b3Y=; b=CWo/KRbJQSthmOofYomyRE0UwP
        x+RmdqNsxioFiDK/MRIt3GxbDBwkssa2X1j3WPqTxG1qjFm40Z5moeM62HPrnP5YUvYkOuHZM5sXM
        L27qh5RgvZn/IlIY9dz/7V5CB+qwuZd1CJ5THt/B1xnH+WmmTnrsphNBWE9+f+uGZ5geqiF8rGIE8
        1jTlv+4d4qU8WdM9wQH8W7tQx+UaQGQVVbI6sQyLmJbNuimBw2zGbmuaPo41C6OGmGK5MD8UY9RGD
        6KsUl6QQN4BB28m6u718DW3pynpsjKWiJGqLagJzGmD6jJVdHGOF7o0SvG9UAP7zE/ujQjX7D0FW9
        ML/M3uSQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1pgv5g-00CVFQ-0t;
        Mon, 27 Mar 2023 22:13:24 +0000
Date:   Mon, 27 Mar 2023 15:13:24 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Akinobu Mita <akinobu.mita@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        akpm@linux-foundation.org, axboe@kernel.dk
Subject: Re: [PATCH 0/2] block: null_blk: make fault-injection configurable
 via configfs
Message-ID: <ZCIVBNjrmLqvcGBi@infradead.org>
References: <20230327143733.14599-1-akinobu.mita@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230327143733.14599-1-akinobu.mita@gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 27, 2023 at 11:37:31PM +0900, Akinobu Mita wrote:
> This patch set makes null_blk driver-specific fault-injection dynamically
> configurable per device via configfs.
> 
> Since the null_blk driver supports configuration such as device creation
> via configfs, it is natural to configure fault-injection via configfs as
> well.
> 
> Currently, only the debugfs interface is provided for dynamically
> configuring fault-injection, so this introduces a compatible interface via
> configfs.

Oh, nice.  Can you also update blktests to take advantage of this and
not require built-in null_blk for fault injection tests?
