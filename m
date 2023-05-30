Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09DDD716A12
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 18:52:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232812AbjE3Qwg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 12:52:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230171AbjE3Qwe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 12:52:34 -0400
Received: from todd.t-8ch.de (todd.t-8ch.de [IPv6:2a01:4f8:c010:41de::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AF7E98;
        Tue, 30 May 2023 09:52:33 -0700 (PDT)
Date:   Tue, 30 May 2023 18:52:30 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=t-8ch.de; s=mail;
        t=1685465551; bh=f6eldl2pZLUUZwcEnDp5SdxtieGtAhMzeCd64+CweYY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JZ+nk7AIWzsA6QWWt/1O8TpPjc4K24cY/9LIpla1V/Xyl1rSwCLbcmdArE4s2d1Ek
         l5N8+Wa85JYhzeoNGf9TBHCxg2YVHtdf/UWIKmzb5JWG4a128iA9ZlNRxsaMRMEvs0
         zz+xTuom8tDdcpyuQbnf2LC2ZkIP5WdPKn1ov0eQ=
From:   Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas@t-8ch.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel test robot <lkp@intel.com>
Subject: Re: [PATCH v2 0/4] block: constify some structures of
 partitions/core.c
Message-ID: <5aeb26f6-aeca-4f77-8328-a753f9a5141b@t-8ch.de>
References: <20230419-const-partition-v2-0-817b58f85cd1@weissschuh.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230419-const-partition-v2-0-817b58f85cd1@weissschuh.net>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jens,

could you take a look at this?

Thanks,
Thomas

On 2023-04-19 15:22:52+0200, Thomas Weißschuh wrote:
> A few structures containing function pointers that could and should be
> const are not. Change that.
> 
> Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
> ---
> Changes in v2:
> - Use correct syntax for const array of function pointers.
>   Reported by LKP bot.
> - Link to v1: https://lore.kernel.org/r/20230419-const-partition-v1-0-2d66f2d83873@weissschuh.net
> 
> ---
> Thomas Weißschuh (4):
>       block: constify partition prober array
>       block: constify struct part_type part_type
>       block: constify struct part_attr_group
>       block: constify the whole_disk device_attribute
> 
>  block/partitions/core.c | 8 ++++----
>  include/linux/blkdev.h  | 2 +-
>  2 files changed, 5 insertions(+), 5 deletions(-)
> ---
> base-commit: af67688dca57999fd848f051eeea1d375ba546b2
> change-id: 20230419-const-partition-a06b9f76b2f3
> 
> Best regards,
> -- 
> Thomas Weißschuh <linux@weissschuh.net>
> 
