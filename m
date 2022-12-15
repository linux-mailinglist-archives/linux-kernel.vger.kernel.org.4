Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79E4764DC38
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Dec 2022 14:26:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229947AbiLON0d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Dec 2022 08:26:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229667AbiLON0a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Dec 2022 08:26:30 -0500
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C75B216487;
        Thu, 15 Dec 2022 05:26:28 -0800 (PST)
Received: by verein.lst.de (Postfix, from userid 2407)
        id F1E9E68AA6; Thu, 15 Dec 2022 14:26:22 +0100 (CET)
Date:   Thu, 15 Dec 2022 14:26:22 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Christoph Hellwig <hch@lst.de>, axboe@meta.com, sagi@grimberg.me,
        kbusch@kernel.org, linux-nvme@lists.infradead.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH] docs, nvme: add a feature and quirk policy document
Message-ID: <20221215132622.GA21083@lst.de>
References: <20221215125130.261098-1-hch@lst.de> <87zgboddb7.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87zgboddb7.fsf@meer.lwn.net>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 15, 2022 at 06:08:44AM -0700, Jonathan Corbet wrote:
> The document looks fine, but I do wonder if it wouldn't be better placed
> with the other maintainer entries in Documentation/maintainer?

Hmm, nothing in there looks very similar to me, while process
seems to have real policy documents.  But we can live with either
place.
