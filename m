Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BEF46F0FDB
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Apr 2023 03:01:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344424AbjD1BBP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Apr 2023 21:01:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229965AbjD1BBN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Apr 2023 21:01:13 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A87812703;
        Thu, 27 Apr 2023 18:01:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4AA7A640A4;
        Fri, 28 Apr 2023 01:01:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59A3BC433EF;
        Fri, 28 Apr 2023 01:01:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682643671;
        bh=Ze7Rmxv3LKtkH1ANVKux+0dOMHgCVGFP+y01bt0LlkU=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=I6rWayZl6SuHVCf/8UBr11n1a1asSocPamkSOaGi6vbj06tj8muEqTW404vkSnR3+
         TsdZQ5VpiOkBMAWX6jtwTdbcX5p1jKctK+QC6fn2c1gHpr85U2511koywBTjOidwHE
         /Ie8UdGjW9VynvGZrVkg9wJRa3yMJDhtShIAH0CEVxB0117CRDdXT6Y5pQiLlIEeKn
         P6BOJjMKmEV4+C5zxFDgyALRpGMYux6cUE8Vg8pNnUJ0qXxV+JKngDVkUE4vIDuLIg
         RJ4SNU3Y5Jzba7bMjtwNTRue43/yScFebLfH9tf3BYxeAFUjKdugRhAVv79iHe8vPg
         8j+LAdk1NMw3w==
Message-ID: <ed6409e8-1ae9-e567-9117-4e9ac7cd7d69@kernel.org>
Date:   Fri, 28 Apr 2023 09:01:08 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH] f2fs: remove some dead code
Content-Language: en-US
To:     Jaegeuk Kim <jaegeuk@kernel.org>, Dan Carpenter <error27@gmail.com>
Cc:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
References: <523ec4b037d064e92e19203e3ab9a161e3d9aa71.1681764681.git.christophe.jaillet@wanadoo.fr>
 <2867d5b3-c6cb-49fa-854a-0f58f9a5adb5@kili.mountain>
 <ZEqikAnNmjMxuSoU@google.com>
From:   Chao Yu <chao@kernel.org>
In-Reply-To: <ZEqikAnNmjMxuSoU@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/4/28 0:28, Jaegeuk Kim wrote:
> On 04/18, Dan Carpenter wrote:
>> On Mon, Apr 17, 2023 at 10:51:46PM +0200, Christophe JAILLET wrote:
>>>   
>>> -	ret2 = filemap_check_errors(NODE_MAPPING(sbi));
>>> -	if (!ret)
>>> -		ret = ret2;
>>> +	ret = filemap_check_errors(NODE_MAPPING(sbi));
>>>   
>>>   	return ret;
>>
>> Let's get rid of "ret" as well:
>>
>> 	return filemap_check_errors(NODE_MAPPING(sbi));
> 
> Applied with this modification. Thanks.

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,

> 
>>
>> regards,
>> dan carpenter
