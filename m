Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24FDC719120
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 05:13:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230124AbjFADNt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 23:13:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230493AbjFADNl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 23:13:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D739A185
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 20:13:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 58064640BE
        for <linux-kernel@vger.kernel.org>; Thu,  1 Jun 2023 03:13:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1E49C433EF;
        Thu,  1 Jun 2023 03:13:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685589215;
        bh=lKySPhDaAFZidx0r5KCqZj3O3c6/3PILy5K6TsBjT04=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=sBiVpraafTY8EFRPOkJzwAet2B/XIou7Zl9My/WGnMkfZqLGK9UtR5T6XkYYXOfqT
         tpieVQzH6GjH45aMUYlg5Bis+RmOAmIxhYnb8HifLYEs6FuTvf338TIiR7GU8W/BRH
         ckJL4NEfhJhhkjBOnVQXs5Bhy/gesiUS+CWfhF7OQxTYV4rzy20NTGOjQQ8sl7DoXp
         P9X+lpDVeqLI9kdZEIlaLThq7rHRonvVtC9hc8LqmLC2kRZBvZsNTdTpBgmVXu2X+e
         f3rNfP5y3XLbkUpBLAJuUMm7mwxPbm1W7rTVBRsPciHauOEu9hm2hq0Pc4uVQYDBzQ
         HBZsSeBJUbLHQ==
Message-ID: <e49e9c41-19c7-7cc5-897e-136ebc027f3e@kernel.org>
Date:   Thu, 1 Jun 2023 11:13:32 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 1/2] f2fs_io: add [get|set_attr] to access inode extra
 attributes
Content-Language: en-US
To:     Sheng Yong <shengyong@oppo.com>, jaegeuk@kernel.org
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
References: <20230529013502.2230810-1-shengyong@oppo.com>
 <20230529013502.2230810-2-shengyong@oppo.com>
From:   Chao Yu <chao@kernel.org>
In-Reply-To: <20230529013502.2230810-2-shengyong@oppo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/5/29 9:35, Sheng Yong wrote:
> This patch adds get_attr and set_attr to access inode's extra
> attributes.

It needs to update f2fs_io(8) manual as well?

Thanks,
