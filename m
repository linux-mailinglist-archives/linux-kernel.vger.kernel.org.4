Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4169D611F7E
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Oct 2022 04:57:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229866AbiJ2C5E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 22:57:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229726AbiJ2C5B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 22:57:01 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0BB11863FD
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 19:56:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0D88FB82AA2
        for <linux-kernel@vger.kernel.org>; Sat, 29 Oct 2022 02:56:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC577C433D6;
        Sat, 29 Oct 2022 02:56:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667012179;
        bh=FE4pQKEIZlmevs+ZupCbUJ5veYZf1bpoqhRwXjXFKjg=;
        h=Date:Subject:To:References:From:In-Reply-To:From;
        b=AMxiismJPYdb46P+jKLp8h2AZVErGb9zG4MND7DQHEo3HdB8aUw3HZplIpzE/ku2a
         hAyARLG6fmMQus22Uw7lO1B/+fjouRmT7Lzt5kt35cz8vX/n5tco/4+nfs7jatVC24
         1EwKJepY1vkL6BYu6sF1EOzTGxUFT3iLBLSayN4ihDOpM9Est+kQV+xAEleZJ1ttEv
         PJevhRSq3zeSeja7jBEO4Gn7W4AGOYNlUoaLk1Q3ywA/rUu3syDqZY3pBnr1K7LAnv
         Ty1ebWx3s+B18E6hV/BtXz+jXDIxOi6tx8WMVZgF14qmpqsu6OiZL87b604XyLnR86
         PLt/sd5Slu+1g==
Message-ID: <6b069b19-fd33-9783-e497-9499b53668f0@kernel.org>
Date:   Sat, 29 Oct 2022 10:56:19 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [f2fs-dev] [PATCH] f2fs: Fix typo in comments
Content-Language: en-US
To:     keosung.park@samsung.com,
        "jaegeuk@kernel.org" <jaegeuk@kernel.org>,
        "linux-f2fs-devel@lists.sourceforge.net" 
        <linux-f2fs-devel@lists.sourceforge.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <CGME20221027110105epcms2p10a8cc7e0e7c3b2960a8db4efaa574ae3@epcms2p1>
 <20221027110105epcms2p10a8cc7e0e7c3b2960a8db4efaa574ae3@epcms2p1>
From:   Chao Yu <chao@kernel.org>
In-Reply-To: <20221027110105epcms2p10a8cc7e0e7c3b2960a8db4efaa574ae3@epcms2p1>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/10/27 19:01, Keoseong Park wrote:
> Change "truncateion" to "truncation".
> 
> Signed-off-by: Keoseong Park <keosung.park@samsung.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,
