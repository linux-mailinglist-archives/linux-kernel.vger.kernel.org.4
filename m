Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AB6A6530DB
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Dec 2022 13:34:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231700AbiLUMe3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Dec 2022 07:34:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231618AbiLUMeZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Dec 2022 07:34:25 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4ECC312744
        for <linux-kernel@vger.kernel.org>; Wed, 21 Dec 2022 04:34:21 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0BF63B81B67
        for <linux-kernel@vger.kernel.org>; Wed, 21 Dec 2022 12:34:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B0A2C433D2;
        Wed, 21 Dec 2022 12:34:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671626058;
        bh=S/O6ux2v6aPfNcNVslK998HVTz/7pVCS2/8Ewlu4WHM=;
        h=Date:To:Cc:References:From:Subject:In-Reply-To:From;
        b=VMuwgOYr4JUNQEiz784JqTKrMgf9DQlsvwACaQi4uMCVO9t8lZFQYSCcxDiUu7YkI
         lWNfB+2J/FydC9dPf+X2wMNcMgfdaTmeoUEnsqkzDlTFjqkxIlEAmsREXuHT9aL83K
         YcatceSjgBBmaN7ibI0DnrAN9eXS8miXOos+JxBnQ6LWCNFyfCG3I/kl34cj1Uvfl3
         sc8cP2FyyPbnQAoenb/B9HK/nIl5ijTlrFwnBqUd3YEUXa6zv2YcN7IaASBfiEiUnx
         vwD7EURTyPbKmsxWZZ5CQLKwnKFvtcBmCcy8RnythY1FoUtKkvw0q4cL6v6wD+/Bcm
         0E9eXivW0h3DA==
Message-ID: <c532ee2b-66bb-9227-ebd7-a070599fe3ae@kernel.org>
Date:   Wed, 21 Dec 2022 20:34:13 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Content-Language: en-US
To:     Yangtao Li <frank.li@vivo.com>, s.shtylyov@omp.ru
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, jaegeuk@kernel.org
References: <20221221033021.36615-1-frank.li@vivo.com>
From:   Chao Yu <chao@kernel.org>
Subject: Re: [PATCH REPOST] f2fs: file: drop useless initializer in
 expand_inode_data()
In-Reply-To: <20221221033021.36615-1-frank.li@vivo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

On 2022/12/21 11:30, Yangtao Li wrote:
> Hi Sergey,
> 
>> In expand_inode_data(), the 'new_size' local variable is initialized to
>> the result of i_size_read(), however this value isn't ever used,  so we
>> can drop this initializer...
>>
>> Found by Linux Verification Center (linuxtesting.org) with the SVACE static
>> analysis tool.
>>
>> Signed-off-by: Sergey Shtylyov <s.shtylyov@omp.ru>
>>
>> ---
>> This patch is against the 'dev' branch of Jaegeuk Kim's F2FS repo...
>> Reposting with ISP RAS mailing lists CC'ed now...
> 
> Why do you repeatedly send a patch that cannot be applied, and this does not have

The format is weired, but still I can apply this into my git repo...

> a CC on linux-kernel.vger.kernel.org.

I guess linux-kernel.vger.kernel.org is not mandatory, feel free
to Cc this mailing list.

Thanks,

> 
> Otherwise, code modification looks good to me.
> 
> Thx,
> Yangtao
