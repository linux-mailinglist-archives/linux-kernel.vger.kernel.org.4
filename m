Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B9C668D6CB
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 13:33:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231786AbjBGMdJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Feb 2023 07:33:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231605AbjBGMdI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Feb 2023 07:33:08 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96040EB51
        for <linux-kernel@vger.kernel.org>; Tue,  7 Feb 2023 04:33:07 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CE8A061353
        for <linux-kernel@vger.kernel.org>; Tue,  7 Feb 2023 12:33:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 281D5C433D2;
        Tue,  7 Feb 2023 12:33:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675773186;
        bh=lxtpEZQCr/9+yjn4NeG+g6IGGfXIaIO2s0hoN4efRZM=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=MWOORpJRmaqihEK/BCMhJ0M7Vhm/C+DNkfmbfpjIACd5rxxeSAKVjDZv5bcyCHPFP
         k/dWwCMbygVXZOPtxBfQQrIMD9csXYfonaQ04m3QPgvf6qjebHgNfrYofeqwF65UaN
         ekKT3lYlZftbUbkfW4wpIN47S5xjxDlex30zMnGuCrgrDuSdEFcEga3JaMhXe5XuGW
         QXQ8skJxO5QYVaXW6LfxKl9PYZQixd+RG+Qw12pfxjmU2vlBtPpH0485H7jzpJ3nKd
         brBfOL4F0nwBp+xRyWbADxQMiBeYmHOr0YFMOQgWKDr6Jqm5lv94uxFKBqc/Z9nYEt
         0w71jbVoSqG2A==
Message-ID: <ca2d2f96-b951-84b6-171f-683a4c7c68da@kernel.org>
Date:   Tue, 7 Feb 2023 20:33:02 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH 1/3] f2fs: clean up __update_extent_tree_range()
Content-Language: en-US
To:     Jaegeuk Kim <jaegeuk@kernel.org>
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
References: <20230131144701.34418-1-chao@kernel.org>
 <Y9lkeVCMRA9goN2E@google.com>
 <a27b1135-757f-9609-1511-7c6738887472@kernel.org>
 <Y+B21EAHfuw2vyJ6@google.com>
From:   Chao Yu <chao@kernel.org>
In-Reply-To: <Y+B21EAHfuw2vyJ6@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/2/6 11:41, Jaegeuk Kim wrote:
> On 02/01, Chao Yu wrote:
>> On 2023/2/1 2:56, Jaegeuk Kim wrote:
>>> I wanted to avoid a deep if/else statement.
>>
>> So how about this:
> 
> Nothing impressive.

Oops...

Thanks,
