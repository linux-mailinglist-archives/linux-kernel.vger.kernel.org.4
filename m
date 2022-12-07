Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 755196450D9
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Dec 2022 02:16:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229667AbiLGBQV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Dec 2022 20:16:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbiLGBQT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Dec 2022 20:16:19 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F365F4F181
        for <linux-kernel@vger.kernel.org>; Tue,  6 Dec 2022 17:16:18 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 93052B81BE2
        for <linux-kernel@vger.kernel.org>; Wed,  7 Dec 2022 01:16:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88FB9C433C1;
        Wed,  7 Dec 2022 01:16:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670375776;
        bh=WH+FA+a+dUqjdRUQuQwOTFdj1sDFoyO9Tuet5keAls8=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=E5YQAniWEyGQdXSVzeh7iVtnUoWwwsWywiQJ5nzWhte2HMdLFkVhthJb4OhWyIDas
         WoYm6l8+G8fv9YY778zjqgydBLH7A4YJZyTpyOHY4fBX85NLtOZZ46+GtPvW0LZ8e3
         j4AOnEHXWX06XKfi4tGOddoOoSEiJ5lcJcF2Ukg7K4gUl4is9kNpc6JlgTzKCUvI+t
         X/tSixFX5UZOYKR+J2KmkgdY6FGQIiJXkjDi1NLoiZBnoo1stCoaCIaQ4Ifl6jbRrD
         jd/lWFNHNqJvIDhKWUaNDeqCf6pCkDkhgnPUle+ck2lkrAzaCXmEmTaj1uOIF2U50J
         ya8A8u3Y13wog==
Message-ID: <11316961-1c94-61e0-6995-243c715adcbc@kernel.org>
Date:   Wed, 7 Dec 2022 09:16:16 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH v2] erofs: use kmap_local_page() only for erofs_bread()
Content-Language: en-US
To:     Gao Xiang <hsiangkao@linux.alibaba.com>,
        linux-erofs@lists.ozlabs.org
Cc:     LKML <linux-kernel@vger.kernel.org>
References: <20221018105313.4940-1-hsiangkao@linux.alibaba.com>
From:   Chao Yu <chao@kernel.org>
In-Reply-To: <20221018105313.4940-1-hsiangkao@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/10/18 18:53, Gao Xiang wrote:
> Convert all mapped erofs_bread() users to use kmap_local_page()
> instead of kmap() or kmap_atomic().
> 
> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,
