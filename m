Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C7CE7337E4
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 20:05:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230260AbjFPSF1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 14:05:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229587AbjFPSFX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 14:05:23 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1B5726AF;
        Fri, 16 Jun 2023 11:05:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=SFt9m7D0aOrEp9zWqY8WFQChV1cfi8+zjeImQ/HHzdk=; b=K79+VZQEHSJbPIkITm1yRP3LvV
        8iINzZFOlLonNvSNQz3Mr5Kruj2fIEfFR0oAbC03iMfo6VKQ8brTUHwFTqeSHZ8kaUMj21ecTDDJM
        h3+x969sG+sVT6v6Q4RIsQJ/w+wy+yiyrd4K2kh+vl0NTBd7Yt6sH2eEs+5TfIib8zJWR4cGbGwae
        MyzHHFj9crU4wrPOOKMXYPIdbU7KXtvuqT+NsVGODpLKhd87bSmDNUAaVc+HHIE87sDNmSqgIBcFW
        P0EcmzGZNcfZIMIjr038JaDuIvS7bhh1WY25DRFcJnuI7kLkD7sALRgKp2z4n3hKM/apbJF1kgKxB
        b+SeGRYg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qADp0-009EgJ-8B; Fri, 16 Jun 2023 18:05:18 +0000
Date:   Fri, 16 Jun 2023 19:05:18 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Jordy Zomer <jordyzomer@google.com>
Cc:     linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        corbet@lwn.net, dave.hansen@linux.intel.com, daniel@iogearbox.net,
        tglx@linutronix.de, rdunlap@infradead.org,
        pawan.kumar.gupta@linux.intel.com
Subject: Re: [PATCH 1/1] nospec: Add documentation for array_index_nospec
Message-ID: <ZIykXq2U5XVZ4aB+@casper.infradead.org>
References: <20230616133735.351479-1-jordyzomer@google.com>
 <20230616133735.351479-2-jordyzomer@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230616133735.351479-2-jordyzomer@google.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 16, 2023 at 01:37:35PM +0000, Jordy Zomer wrote:
> +Please note that this function should only be used if the upper
> +boundary is a built-time constant, otherwise this could be
> +speculated on as well. If this is not the case please refer to
> +barrier_nospec().

"build time", not "built time".  Also, "Please note that" doesn't
really add any value.  You can just write:

This function should only be used if the upper boundary is a build-time
constant, otherwise this could be speculated on as well.  If it is not
a constant, use barrier_nospec() instead.

