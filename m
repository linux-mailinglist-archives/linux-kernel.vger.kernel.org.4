Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A56106CB17D
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 00:14:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230287AbjC0WOJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 18:14:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229534AbjC0WOH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 18:14:07 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2783710A;
        Mon, 27 Mar 2023 15:14:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=6Ng5vfFWPRK672V1V9mEH+5cYJAFAK0wLHLZvbZZU88=; b=vM62KkjXeWcZx2bTMrrlozyHAd
        LdP8IlWHJ8zF07UihwBDRaANHzf5lygmPj8Quuht3eABbAKF8eDHx7ENiRPj7s6GmPElBP9WOLB80
        R8M5/v+9vjazdVSPOyL5dEi4bqPnXhPgvrBGK3jhuwfl5JbtIHLwmLwmlXNDo+KtLrKp5IvGvfb5r
        1HU8F3pcBOP1+4yKF1dPGNeqdffjHo/eSDdnmRCEnKvoheX9C6HidV8ChA+Y5NfUL80dR8emlflbN
        5siwWfow/Q3Vm7Syl/GXhtZIWrWOa2jGbrzFSA4JmHhZRJQlzkawG2yWWbVDnQeHi/aLnmgPqpbsj
        0hEAfIlA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1pgv6L-00CVOM-2R;
        Mon, 27 Mar 2023 22:14:05 +0000
Date:   Mon, 27 Mar 2023 15:14:05 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Kent Overstreet <kent.overstreet@linux.dev>
Cc:     linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        willy@infradead.org, axboe@kernel.dk
Subject: Re: [PATCH 0/2] bio iter improvements
Message-ID: <ZCIVLQ6Klrps6k1g@infradead.org>
References: <20230327174402.1655365-1-kent.overstreet@linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230327174402.1655365-1-kent.overstreet@linux.dev>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 27, 2023 at 01:44:00PM -0400, Kent Overstreet wrote:
> Small patch series cleaning up/standardizing bio_for_each_segment_all(),
> which means we can use the same guts for bio_for_each_folio_all(),
> considerably simplifying that code.
> 
> The squashfs maintainer will want to look at and test those changes,
> that code was doing some slightly tricky things. The rest was a pretty
> mechanical conversion.

Can you post a code size comparism for the before and after cases?
