Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0586A665CC3
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 14:40:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239278AbjAKNkE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 08:40:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239354AbjAKNjm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 08:39:42 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C3F11CFFE
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 05:37:19 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 57242B81BDB
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 13:37:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D58CFC433F0;
        Wed, 11 Jan 2023 13:37:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673444237;
        bh=FUoxN2QD+ZOvE+dYb+cCMYOTxaRlpUEgW1gFBA0KI04=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=q14kiXpxdOpYgzAzVmHJdYQbDBOa+NB4z4mbNj+5u+9lRy5rAOZQtvbtUKw5RncI2
         P/GmrWKXkFy8V3OVpd5o/8FqfpX2Cm9ZDvvggDgnVmUjwotoiRKbCwvrgfMuciqq7k
         lb9rYGtK1AQYcM6W0DpbVIuc8VGxqj+/jqzDyAe3hFru0sXU/1d905q0WWjyssrBg8
         u7hXtOJByQMTG43F9IGrXxdwB017tSy1FsUlJFYiiNo/Qi3t3Yfv2nJR5hlSufJYoV
         qOYLIN+Xjuto0RlsQqR8pUMQLMTELwg+Nhya0sXrSgZ04hGKq/+Mytwc545YtILebG
         Wpgnn11Af4v+w==
Message-ID: <732e4696-5349-fb3b-87e5-8f0ecf368571@kernel.org>
Date:   Wed, 11 Jan 2023 21:37:14 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH] f2fs: convert discard_wake and gc_wake to bool type
Content-Language: en-US
To:     Yangtao Li <frank.li@vivo.com>, jaegeuk@kernel.org
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
References: <20221212133644.1503-1-frank.li@vivo.com>
From:   Chao Yu <chao@kernel.org>
In-Reply-To: <20221212133644.1503-1-frank.li@vivo.com>
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

On 2022/12/12 21:36, Yangtao Li wrote:
> discard_wake and gc_wake have only two values, 0 or 1.
> So there is no need to use int type to store them.
> 
> BTW, move discard_wake to the end of the
> discard_cmd_control structure.
> 
> Before:
> 
>    - sizeof(struct discard_cmd_control): 8392
> 
> After move:
> 
>    - sizeof(struct discard_cmd_control): 8384
> 
> Signed-off-by: Yangtao Li <frank.li@vivo.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,
