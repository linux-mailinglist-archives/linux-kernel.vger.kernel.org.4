Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2F1264E584
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Dec 2022 02:04:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229837AbiLPBEP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Dec 2022 20:04:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbiLPBEN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Dec 2022 20:04:13 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26FB81DDDA
        for <linux-kernel@vger.kernel.org>; Thu, 15 Dec 2022 17:04:13 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B789B61FB7
        for <linux-kernel@vger.kernel.org>; Fri, 16 Dec 2022 01:04:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DDFAC433D2;
        Fri, 16 Dec 2022 01:04:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671152652;
        bh=nvkUZQB3nczQlExkyxmnbzlqOWSqUB3d8faxu0BP5Ao=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=rZ4XkhKssN7yrkLPvnWbdNzBqwg3kumeBZoNbOYLijf3eiz8p/oq6Hu03PU7xohLm
         GPEPdAgjculaWCx9KcCCa/erZyLgmbWPP1J6fKDEAzMlsED6NtChJ5Jvxd57533iO9
         DMApm1fdyDSP/vaT0YhThnr4XFiAzLHprpcxYmQsAT518BHjsnb7r+0xqDMuOyilKM
         M8WuzgJeEnrdf6kwVVmh1zdNAharrObY4+2sdwU7M7YyDEFEExVhCNf1R44s8OFFCZ
         Kmu90PZ/AtFaxkK3IdZFCN7e8iGiu1uLXME7gYLqnMcoOjqZqPbPyx2BvQ5u2L3mUU
         w5nkGYyhpDDfw==
Message-ID: <65a6b4e0-fe25-f341-0095-40c28d690eb1@kernel.org>
Date:   Fri, 16 Dec 2022 09:04:08 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH v2] f2fs: add support for counting time of submit discard
 cmd
Content-Language: en-US
To:     Jaegeuk Kim <jaegeuk@kernel.org>, Yangtao Li <frank.li@vivo.com>
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
References: <Y5jPyEiAtDPx7VSI@google.com>
 <20221214072830.32911-1-frank.li@vivo.com> <Y5pFmv4AUDxw9GI9@google.com>
From:   Chao Yu <chao@kernel.org>
In-Reply-To: <Y5pFmv4AUDxw9GI9@google.com>
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

On 2022/12/15 5:52, Jaegeuk Kim wrote:
>> https://korg.wiki.kernel.org/userdoc/patchwork#adding_patchwork-bot_integration
> 
> Good idea. I requested to add f2fs project there. :) Let's see.

The website is available now, cool... :)

https://patchwork.kernel.org/project/f2fs/

Jaegeuk, your email address is out-of-update in above link, it needs to
be updated.

Maintainer	Jaegeuk Kim <jaegeuk.kim@samsung.com>

Thanks,
