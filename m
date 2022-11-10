Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87FFD62420E
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 13:14:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230322AbiKJMOS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 07:14:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230055AbiKJMOQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 07:14:16 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3AA8646B
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 04:14:15 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 85A43B8219B
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 12:14:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 982AFC433C1;
        Thu, 10 Nov 2022 12:14:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668082453;
        bh=B22pu69Nba3mL3bh+uHOYfeSCh+5ORe8ehgV90spvS8=;
        h=Date:Subject:To:References:From:In-Reply-To:From;
        b=Pe6d8PvNJ9WEf5Cs6pnSBdOT2VA3oZE3XfgN9soS/kpLedvfIfav48SsMLbd1L80V
         ezFwc+MUzf9VwkFHHSBcI/MRsPDrJ2KQu9eijEgwkdxNvoferHhVzqcwIbRSqKg7gA
         aWX2wT8SJwKMYyuE9WV1JCCnngxKMg/XKWGhK37+Jw2Czb+D8xi9MG4eYSqcex29Em
         jx8O6rHrhoSMkCcscvSduPznpvDBaIXC3LRR77xO3lSvhlUq07BPOEk5srJllzHWGo
         9LeGJGhMLe8FH7Ukf7YHl63l7OoT+ylLCo3PBbuCGITkM1IS+VrOyxL8AMVwkj8n7j
         TR3TKu0jQqhhw==
Message-ID: <79264aa9-c78d-5768-bfd2-91be34f78ad8@kernel.org>
Date:   Thu, 10 Nov 2022 20:14:11 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: [f2fs-dev] [PATCH v2] f2fs: allow to read node block after
 shutdown
Content-Language: en-US
To:     Jaegeuk Kim <jaegeuk@kernel.org>, linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
References: <20221109020917.4121067-1-jaegeuk@kernel.org>
 <Y2sMWrKXJtGSmUz7@google.com>
From:   Chao Yu <chao@kernel.org>
In-Reply-To: <Y2sMWrKXJtGSmUz7@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/11/9 10:11, Jaegeuk Kim wrote:
> If block address is still alive, we should give a valid node block even after
> shutdown. Otherwise, we can see zero data when reading out a file.
> 
> Cc: stable@vger.kernel.org
> Fixes: 83a3bfdb5a8 ("f2fs: indicate shutdown f2fs to allow unmount successfully")
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,
