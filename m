Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57563619CD9
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 17:17:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231559AbiKDQQ6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Nov 2022 12:16:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231373AbiKDQQt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Nov 2022 12:16:49 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48A881A220
        for <linux-kernel@vger.kernel.org>; Fri,  4 Nov 2022 09:16:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 12521B82E8E
        for <linux-kernel@vger.kernel.org>; Fri,  4 Nov 2022 16:16:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E58EC433C1;
        Fri,  4 Nov 2022 16:16:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667578604;
        bh=HKflwwEniCq/loaI1mV8lGB9ZVJnmN100im8Q7UpeHY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=koORGyoQvIU7FD3Z9IMmkTRE8tIr1FR3FzaIrJcZ0cDwqk5j0eeXjlAs5ThtTNMFK
         8H9O8MxvBQ65yrYlzp76Jc4yjcJjU13+GCVjXWlsaaWWjCPjuqafD7pdjoA9xZh7xb
         oXOstao4BPI63x6hEu4C2hL6yb2hInh/SLL2VmajGWsERUnsQBkaqq9DFkr9BitATu
         mCJ+DU2FlFHPZhtGP8ErnYHsnQqotj7qBQ4+YqRLmL3ZpjOrtLdYVOYUqbK8IJ2NsO
         Cyhajns+JKA+61LB4iSTa5ElxkzN1rxI3sFjMnl0qGlURRz2jqe5yjtwqRynByS00r
         fJQgEDMqBij9w==
Date:   Fri, 4 Nov 2022 09:16:43 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Yang Li <yang.lee@linux.alibaba.com>
Cc:     fw@strlen.de, davem@davemloft.net, linux-kernel@vger.kernel.org,
        Abaci Robot <abaci@linux.alibaba.com>
Subject: Re: [PATCH -next] lib: Fix some kernel-doc comments
Message-ID: <20221104091643.69fa3a03@kernel.org>
In-Reply-To: <20221104063119.76502-1-yang.lee@linux.alibaba.com>
References: <20221104063119.76502-1-yang.lee@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri,  4 Nov 2022 14:31:19 +0800 Yang Li wrote:
> Make the description of @policy to @p in nla_policy_len()
> to clear the below warnings:
> 
> lib/nlattr.c:660: warning: Function parameter or member 'p' not described in 'nla_policy_len'
> lib/nlattr.c:660: warning: Excess function parameter 'policy' description in 'nla_policy_len'
> 
> Link: https://bugzilla.openanolis.cn/show_bug.cgi?id=2736
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>

Repost it and cc netdev@ please
