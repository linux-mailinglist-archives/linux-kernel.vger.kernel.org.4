Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 824AA7127AE
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 15:37:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243755AbjEZNhQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 May 2023 09:37:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237082AbjEZNhO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 09:37:14 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18041D8
        for <linux-kernel@vger.kernel.org>; Fri, 26 May 2023 06:37:13 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 5E61F6732A; Fri, 26 May 2023 15:37:10 +0200 (CEST)
Date:   Fri, 26 May 2023 15:37:10 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Vincent Whitchurch <vincent.whitchurch@axis.com>
Cc:     Phillip Lougher <phillip@squashfs.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>, hch@lst.de,
        linux-kernel@vger.kernel.org, kernel@axis.com
Subject: Re: [PATCH mm-nonmm-unstable 2/2] squashfs: fix page indices
Message-ID: <20230526133710.GC8803@lst.de>
References: <20230526-squashfs-cache-fixup-v1-0-d54a7fa23e7b@axis.com> <20230526-squashfs-cache-fixup-v1-2-d54a7fa23e7b@axis.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230526-squashfs-cache-fixup-v1-2-d54a7fa23e7b@axis.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 26, 2023 at 03:25:46PM +0200, Vincent Whitchurch wrote:
> The page cache functions want the page index as an argument but we're
> currently passing in the byte address.

Can you avoid the overly long lines by movning the GFP_NOFS parameters
to the following lines?

The rest look good.
