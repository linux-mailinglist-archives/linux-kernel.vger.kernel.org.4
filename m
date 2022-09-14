Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEECE5B87BE
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Sep 2022 14:01:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229565AbiINMBN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Sep 2022 08:01:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230043AbiINMBG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Sep 2022 08:01:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9544D7D7BF;
        Wed, 14 Sep 2022 05:00:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C18A961CBE;
        Wed, 14 Sep 2022 12:00:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7541C433C1;
        Wed, 14 Sep 2022 12:00:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663156858;
        bh=oKRFavWenN+ytzY8AzXRM7VfgxqFkGOUkxfCZUfKgBg=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=o8nmeF529De22eXTKQaRKmKJsE7Bsv7cH3fuLKVz7WSV1Fyx0+lvGz0gbNX6S8lGN
         ie4eMBKADmJz5FD5xp4WNiPbk7K+lCBY0O7Pz7jwCNzyflHNupE28Bu1Ldxwr4QjiR
         dqJAJ9dVvfxlPV3HepIGKJPHBGtzDVKTct6zebdTxXuYRfRQm4NZ2xH0HfEAnS9e84
         cu0hwuyqjmqZZSWUfz8P6v9WL38xQ+4oMTjfEof2OFw9jP8M11uAw0NnDZvnSHCnfQ
         pCyBUO7UKYTq7r82+YjKjOVCyxppNgcbx9kvi2nDjn1Yk7T6Aobo/JY93cQMY3SHRg
         r1OT49LAe2/7w==
Message-ID: <8cf54dbe-46af-44ed-8f52-321074912a15@kernel.org>
Date:   Wed, 14 Sep 2022 20:00:52 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: build failure of next-20220914 due to 64c11570d64d ("f2fs: fix to
 do sanity check on summary info")
Content-Language: en-US
To:     "Sudip Mukherjee (Codethink)" <sudipm.mukherjee@gmail.com>,
        Jaegeuk Kim <jaegeuk@kernel.org>
Cc:     linux-next@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
References: <YyHBF99sC/vQdI3v@debian>
From:   Chao Yu <chao@kernel.org>
In-Reply-To: <YyHBF99sC/vQdI3v@debian>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/9/14 19:55, Sudip Mukherjee (Codethink) wrote:
> Hi All,
> 
> The builds of arm64 allmodconfig with clang have failed to build
> next-20220914 with the error:

My bad, I've fixed this issue in v2:

https://lore.kernel.org/linux-f2fs-devel/20220914115151.2994632-1-chao@kernel.org/T/#u

Thanks,
