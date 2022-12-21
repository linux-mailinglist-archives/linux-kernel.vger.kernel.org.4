Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D6436530A6
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Dec 2022 13:16:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230082AbiLUMQo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Dec 2022 07:16:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229774AbiLUMQm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Dec 2022 07:16:42 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC66F220DD
        for <linux-kernel@vger.kernel.org>; Wed, 21 Dec 2022 04:16:41 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6A289616CD
        for <linux-kernel@vger.kernel.org>; Wed, 21 Dec 2022 12:16:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4605C433D2;
        Wed, 21 Dec 2022 12:16:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671625000;
        bh=7IM2aHE5t1+x4/OQ3TByOnA+TDFUo5eLGDBp/nA9VB0=;
        h=Date:To:Cc:References:From:Subject:In-Reply-To:From;
        b=oel60HDJEypHqq7AJ/RutVm98b22o3dB4VyhDep4t5DOAxPKY2q8bzHHkxtvmuqsm
         WCjoozbmePffEA1/6C02H4rOz5CkSeJ94w+IeQARUupcfDGz7jp1mlEItffC8HU5YW
         J8qQ+23sJM9PPB4yAhtyvMKhp6JYhwg0/khRwVx6QOd9Do0Pg3QEzWPLijnic1M+SK
         rRiaiw1t65f5FV15SXz0pgMHAahkygMh01m4fRgiVz1envThdg8dRfzWqu2oJopPTO
         uEQfVEZi/x0r+4zl77bQINMxUjKc5dSWbbwgImyN60ys/yPPsZcqEH8FlnIznM0QgR
         X0A/fJrGuyxrA==
Message-ID: <32ae9221-0b5c-f12e-4795-5fe1f725cb2c@kernel.org>
Date:   Wed, 21 Dec 2022 20:16:36 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
To:     Yangtao Li <frank.li@vivo.com>, jaegeuk@kernel.org
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
References: <20221220115602.6715-1-chao@kernel.org>
 <20221221035931.41027-1-frank.li@vivo.com>
Content-Language: en-US
From:   Chao Yu <chao@kernel.org>
Subject: Re: [PATCH] f2fs: remove unused PAGE_PRIVATE_ATOMIC_WRITE
In-Reply-To: <20221221035931.41027-1-frank.li@vivo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/12/21 11:59, Yangtao Li wrote:
>>   PAGE_PRIVATE_GET_FUNC(reference, REF_RESOURCE);
>   
>>   PAGE_PRIVATE_CLEAR_FUNC(reference, REF_RESOURCE);
> 
> Delete those two too?

Oh, thank for checking PAGE_PRIVATE_REF_RESOURCE's usage, I found we
need clear_page_private_reference(), see “[PATCH] f2fs: fix to call
clear_page_private_reference in .{release,invalid}_folio”

Thanks,

> 
> Otherwise, looks good to me.
> 
> Thx,
> Yangtao
