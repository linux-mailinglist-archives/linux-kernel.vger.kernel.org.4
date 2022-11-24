Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AD5A637B57
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Nov 2022 15:20:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229542AbiKXOU5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Nov 2022 09:20:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229803AbiKXOUn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Nov 2022 09:20:43 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D44D9B02
        for <linux-kernel@vger.kernel.org>; Thu, 24 Nov 2022 06:20:40 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5FB0F62169
        for <linux-kernel@vger.kernel.org>; Thu, 24 Nov 2022 14:20:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7D37C433C1;
        Thu, 24 Nov 2022 14:20:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669299639;
        bh=y6/6LAuFshGeZ0qLXCTwAJcGoMYAgHfKsQPtZ2Jy0qk=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=gqYCgwlFIId5oIl8xoQkCeI8rfJ7HREhKUcymKDux9rnWjrBnR1vKRb14WZR2zGd6
         SxaJE9emEQbpcrO1wDLJ8edDWjLQNTknI+Mc6/bAox3+DdOZ405gvp2WJ/O0L6pGPG
         CpQ70PyA1WuT65/sSOj97fdMYvEErhG6HF+XMgfkowl+q+KvZsffZ+Lh1OasuJOLg7
         UQfaiHbX8os9FZapiUDkSlHuA20orGsqYyJqMXsdZ1AnWh+UpfFZHT/nMDs/dCQCMJ
         QkRTl4mzSsXg/b6P3wcO9rePrhDp8j7exPnvm58MBCLFix0iH3c+HgIixeMFV1qDJ0
         QCg/CVOs4ICdA==
Message-ID: <0aeb33c2-8970-e9ef-7b18-7ba1197a5a0f@kernel.org>
Date:   Thu, 24 Nov 2022 22:20:36 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH] f2fs: init discard policy after thread wakeup
Content-Language: en-US
To:     Yangtao Li <frank.li@vivo.com>, jaegeuk@kernel.org
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
References: <20221118034600.59489-1-frank.li@vivo.com>
From:   Chao Yu <chao@kernel.org>
In-Reply-To: <20221118034600.59489-1-frank.li@vivo.com>
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

On 2022/11/18 11:46, Yangtao Li wrote:
> Under the current logic, after the discard thread wakes up, it will not
> run according to the expected policy, but will use the expected policy
> before sleep. Move the strategy selection to after the thread wakes up,
> so that the running state of the thread meets expectations.
> 
> Signed-off-by: Yangtao Li <frank.li@vivo.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,
