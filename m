Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81FC45F84E1
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Oct 2022 13:09:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229712AbiJHLJB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Oct 2022 07:09:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229696AbiJHLI7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Oct 2022 07:08:59 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A7D649B78
        for <linux-kernel@vger.kernel.org>; Sat,  8 Oct 2022 04:08:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 28496B8068C
        for <linux-kernel@vger.kernel.org>; Sat,  8 Oct 2022 11:08:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EFCC5C433D6;
        Sat,  8 Oct 2022 11:08:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665227335;
        bh=dh/fo2iw1/H0NUTRsbJLhIHN44MSGBSSWcZtREgATcI=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=Acow74ggaXp3xm5nekh5GFQPItkbgaQiVP0hqgoUOzDYaZc8s+MAoD5Om9Bn+Qce5
         hjftUC3IcomOIKX8ua8wTMgqGKyBbpLng8XWI/UnN2wEnlAQNI7o4IIPmyctgpjB6I
         R8LgENjmsUp2g91sad/K6rP6QsE3vMLcZjJ73ZXUNvYhCj0s2X9eY308qXK9llg3Y5
         k1383UcCI9GYkCnYvRQkd2jtYyk+HfW4lhPrsgF7fkcQlbjF5p4Zee820oq5btdPVz
         mpy9pll3tAwZJh1Y3k/oNxGlLG6UaHj460xHIP5pReW5zBMIdjIN1PexaWU7bvSCM5
         ar25TZbJuT66w==
Message-ID: <6d45ea3a-5a71-b760-b60d-9e3e7dda3be4@kernel.org>
Date:   Sat, 8 Oct 2022 19:08:52 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [PATCH] f2fs: fix compile warning
Content-Language: en-US
To:     Jaegeuk Kim <jaegeuk@kernel.org>
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
References: <20221006151428.57561-1-chao@kernel.org>
 <Y0CDoWiaGKHkmnzQ@google.com>
From:   Chao Yu <chao@kernel.org>
In-Reply-To: <Y0CDoWiaGKHkmnzQ@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-10.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/10/8 3:53, Jaegeuk Kim wrote:
> Merged into the original patch.

Thanks, so it looks it's not too later to update commit id of original
patch since it's close to the end of merge window.

Thanks,

> 
> On 10/06, Chao Yu wrote:
>> fs/f2fs/super.c:3886:6: warning: no previous prototype for 'f2fs_record_stop_reason' [-Wmissing-prototypes]
>>
>> Signed-off-by: Chao Yu <chao@kernel.org>
>> ---
>>   fs/f2fs/super.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
>> index fad333881ea2..2908d41ed462 100644
>> --- a/fs/f2fs/super.c
>> +++ b/fs/f2fs/super.c
>> @@ -3884,7 +3884,7 @@ static void save_stop_reason(struct f2fs_sb_info *sbi, unsigned char reason)
>>   	spin_unlock(&sbi->error_lock);
>>   }
>>   
>> -void f2fs_record_stop_reason(struct f2fs_sb_info *sbi)
>> +static void f2fs_record_stop_reason(struct f2fs_sb_info *sbi)
>>   {
>>   	struct f2fs_super_block *raw_super = F2FS_RAW_SUPER(sbi);
>>   	int err;
>> -- 
>> 2.36.1
