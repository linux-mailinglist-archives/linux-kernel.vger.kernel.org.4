Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E5AB72D71B
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 03:48:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236781AbjFMBsL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 21:48:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229729AbjFMBsJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 21:48:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84D8A13E
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 18:48:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 214A061F73
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 01:48:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54A28C433D2;
        Tue, 13 Jun 2023 01:48:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686620887;
        bh=4PvqvZHTR3wNiiQv/YAPXFWmVcKgly99PAxW+i+I0eg=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=OLKWvjtLmTytejGId/lVuExXUdNM1OC/tT1eRxKo/XPj5XZzUxUwt5CFP0392y+f4
         HfGxdLQFP6VJmNBJt8/9XjXzR8FKk8WxOxn214cbs6MqCtwWYyLVQmkTw9P8lOofq6
         NZTF892dVNHXmRrgFOszUOy0qx1A/peSGOofzNb5ZPFJW9OG4HGWRolmiGyIt+ZVI9
         nS7H37CtS/O7PUBiBLbtaA+xbwOu/SXG2zhVvfRurCbjJufIQA77xUKvLTFhBgYP4W
         6uP+3NLik+IZ3lzdxyehE6uCBrweGgj7n4Cp7V9u+bMQchtFC9dr9MbaunYqdo1CwS
         Phm8lpxWXtLfQ==
Message-ID: <54dcf5f1-0560-14b4-a7e7-6b969b7650c7@kernel.org>
Date:   Tue, 13 Jun 2023 09:48:04 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH v4 1/6] f2fs: add helper to check compression level
Content-Language: en-US
To:     Jaegeuk Kim <jaegeuk@kernel.org>, Sheng Yong <shengyong@oppo.com>
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, ebiggers@kernel.org
References: <20230612030121.2393541-1-shengyong@oppo.com>
 <20230612030121.2393541-2-shengyong@oppo.com> <ZIeY0qNjXgx419NZ@google.com>
From:   Chao Yu <chao@kernel.org>
In-Reply-To: <ZIeY0qNjXgx419NZ@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/6/13 6:14, Jaegeuk Kim wrote:
> Could you please check this version?
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/jaegeuk/f2fs.git/commit/?h=dev-test&id=9c84aad379019a0d86655bb50bd7b4bc92683c4b
> 
> On 06/12, Sheng Yong wrote:
>> This patch adds a helper function to check if compression level is
>> valid.
>>
>> Signed-off-by: Sheng Yong <shengyong@oppo.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,
