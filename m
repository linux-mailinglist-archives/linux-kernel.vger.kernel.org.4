Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27AAB631A0B
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 08:13:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229612AbiKUHNL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 02:13:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbiKUHNJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 02:13:09 -0500
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2D0B120B9;
        Sun, 20 Nov 2022 23:13:08 -0800 (PST)
Received: by verein.lst.de (Postfix, from userid 2407)
        id BA23468AA6; Mon, 21 Nov 2022 08:13:05 +0100 (CET)
Date:   Mon, 21 Nov 2022 08:13:05 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Jinlong Chen <nickyc975@zju.edu.cn>
Cc:     axboe@kernel.dk, hch@lst.de, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 0/2] elevator: restore old io scheduler on failure
 in elevator_switch
Message-ID: <20221121071305.GB23882@lst.de>
References: <cover.1668772991.git.nickyc975@zju.edu.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1668772991.git.nickyc975@zju.edu.cn>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 18, 2022 at 08:09:52PM +0800, Jinlong Chen wrote:
> elevator_switch contains the fallback logic in sq era, but it was removed
> when moving to mq (commit: a1ce35fa49852db60fc6e268038530be533c5b15),
> leaving the document mismatched with the behavior. As far as I can see,
> restoring the old io scheduler is more reasonable than just leaving the
> scheduler none, hence there is the series.

What failure scenariou can you think off where switching to the intended
schedule fails, but switching back to the previous one will succeed?
