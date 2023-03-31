Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEB2A6D238C
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 17:05:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232871AbjCaPFy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Mar 2023 11:05:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233148AbjCaPFn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Mar 2023 11:05:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D066921A8F;
        Fri, 31 Mar 2023 08:05:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 993D662A13;
        Fri, 31 Mar 2023 15:05:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53DB6C433EF;
        Fri, 31 Mar 2023 15:05:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680275110;
        bh=u2z6J3jRsS/j07wntF1hT4PjvQwSajS65sEvP62J69k=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=pBwakQG2gZXFi65zwBff9OaKVM7fzhh32/dePHg8fNOpOvJ0pCyVPAMr7KAFC1v07
         BotB1JWg40JhfmzGbsgXCZNvCQwWC0pnCWZgH6ypjLs2DIoTgHQWDVHRZ9NGk90ULz
         KBQI4oS+hoIFQnYOvRg7YPzlsKdRR8nfm9zkyKkfVgiWs9h5tpwRuboS0WU5SOpfR1
         JU4W6HeGlY+Lq0xyTULNqZcfxMg1Egq0fF0NvqoYvd94YUX0bhhtwWNVaESSIYLRrU
         1BuNRX6UPSWu3bv/GRgO/ij5SUs/eCqLS/YNgnagUz7GYbxJA+WvkfSrd6cZ/E/HgF
         NxGZroDgCAnRg==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] bcma: remove unused mips_read32 function
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20230324190647.2654293-1-trix@redhat.com>
References: <20230324190647.2654293-1-trix@redhat.com>
To:     Tom Rix <trix@redhat.com>
Cc:     zajec5@gmail.com, nathan@kernel.org, ndesaulniers@google.com,
        linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, Tom Rix <trix@redhat.com>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <168027510653.20708.5438883054982900442.kvalo@kernel.org>
Date:   Fri, 31 Mar 2023 15:05:08 +0000 (UTC)
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tom Rix <trix@redhat.com> wrote:

> clang with W=1 reports
> drivers/bcma/driver_mips.c:49:19: error: unused function
>   'mips_read32' [-Werror,-Wunused-function]
> static inline u32 mips_read32(struct bcma_drv_mips *mcore,
>                   ^
> This function is not used so remove it.
> 
> Signed-off-by: Tom Rix <trix@redhat.com>
> Reviewed-by: Simon Horman <simon.horman@corigine.com>

Patch applied to wireless-next.git, thanks.

21898a40b2f8 bcma: remove unused mips_read32 function

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20230324190647.2654293-1-trix@redhat.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

