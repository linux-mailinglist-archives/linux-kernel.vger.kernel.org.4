Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D027D705D61
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 04:40:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232111AbjEQCkT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 22:40:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231432AbjEQCkS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 22:40:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6557B35A8
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 19:40:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E4E8C60FD9
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 02:40:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2495C433EF;
        Wed, 17 May 2023 02:40:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684291216;
        bh=NdrwmnejHdoL348J6WmccW3ZdlHY3rSkgi/6/8J/jcc=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=i8PH5HNXNqDJ4w+iqIxFtytlXJGS9XfvLYfHVXQG8mf6Xd4zUba616U2iUVpYnQK6
         h+VN2FU0ztxn/omhVl8Scc1WImm6E4BLmszILp8I52pfG3nYGM+7JvUAQxxs5UtdsM
         jEfvZDvF3qxSB6Bph8nWIsXrVMHoDaUTKFMVIdB+3Gv0yS2jC38pDD2k1eGpdE+0zI
         8WtNur9FAsMZAOKVtX3ItRsiIhvrJizJWhOows6raG2sli7QdfF7pEvyOj6qm7QmnB
         I39THNrhW6mUtcL9aVZUtzj3TostteHDfylp9WRgufK591ooBmADKBNgIb4A+5o4gK
         x0cj0tShqAMjg==
Message-ID: <a089749c-061a-f5b7-1d09-2fc0fce2f76a@kernel.org>
Date:   Wed, 17 May 2023 10:40:13 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v1] f2fs: Fix over-estimating free section during FG GC
Content-Language: en-US
To:     yonggil.song@samsung.com,
        "jaegeuk@kernel.org" <jaegeuk@kernel.org>,
        "linux-f2fs-devel@lists.sourceforge.net" 
        <linux-f2fs-devel@lists.sourceforge.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc:     Seokhwan Kim <sukka.kim@samsung.com>,
        Daejun Park <daejun7.park@samsung.com>,
        beomsu kim <beomsu7.kim@samsung.com>
References: <CGME20230512041610epcms2p506e7539079670524146ba6eeeb9dbd63@epcms2p5>
 <20230512041610epcms2p506e7539079670524146ba6eeeb9dbd63@epcms2p5>
From:   Chao Yu <chao@kernel.org>
In-Reply-To: <20230512041610epcms2p506e7539079670524146ba6eeeb9dbd63@epcms2p5>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-9.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/5/12 12:16, Yonggil Song wrote:
> There was a bug that finishing FG GC unconditionally because free sections
> are over-estimated after checkpoint in FG GC.
> This patch initializes sec_freed by every checkpoint in FG GC.
> 
> Signed-off-by: Yonggil Song <yonggil.song@samsung.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,
