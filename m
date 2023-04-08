Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47DF16DB7E5
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Apr 2023 03:00:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229502AbjDHBAt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Apr 2023 21:00:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjDHBAs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Apr 2023 21:00:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A27AEE1BB
        for <linux-kernel@vger.kernel.org>; Fri,  7 Apr 2023 18:00:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3ACEB64AC5
        for <linux-kernel@vger.kernel.org>; Sat,  8 Apr 2023 01:00:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B849EC4339B;
        Sat,  8 Apr 2023 01:00:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680915646;
        bh=9vLXjx0bZMseT0zJHK4962YmSv0A40msCDS1GhEa2Is=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=crKpCvLiEj8G/fazCQZ0aBerTQL1NSg1GQ9TRDij22IMuf1qnprdhxHJ01FsIAUbC
         x9JsdSJzHUdaj8dERqn1/bYDIQyyml7OHk7KPNWgikcQz1UZPPl70dL4e+xqQG3GId
         k+9xXdSk3tpbrV4OTP84HVJyvA3qxdBetfi297jFav+WhB6G6r/qLv7BWKVTon6lfs
         TmYsEoYEqviaAolI88R5wFiLK3urw9kD+MNfIM04LX92H6S9Z8bblO1V99SbuoxdYv
         kiwIsm7z2vpuCGP4eDRmQ0nvDhil4sUqiw2cZ+WwXF/6kjNHxvYG0S1k/S8ww1YLT9
         sSkRZ97b8IjFw==
Message-ID: <35d38e44-fcac-f19a-7ac0-ad3232bc8e5c@kernel.org>
Date:   Sat, 8 Apr 2023 09:00:43 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v7] f2fs: support errors=remount-ro|continue|panic
 mountoption
Content-Language: en-US
To:     Jaegeuk Kim <jaegeuk@kernel.org>
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Yangtao Li <frank.li@vivo.com>
References: <20230326062128.1423340-1-chao@kernel.org>
 <ZDCCkJiVhvLec9c4@google.com>
From:   Chao Yu <chao@kernel.org>
In-Reply-To: <ZDCCkJiVhvLec9c4@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/4/8 4:52, Jaegeuk Kim wrote:
>> +		if (irq_context)
> 
> 		if (irq_context && !shutdown)?

Yes, let me update in v8.

Thanks,
