Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BABD6696759
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 15:51:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232947AbjBNOvz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 09:51:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbjBNOvy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 09:51:54 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 868CE101
        for <linux-kernel@vger.kernel.org>; Tue, 14 Feb 2023 06:51:53 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 32BA2B81DE8
        for <linux-kernel@vger.kernel.org>; Tue, 14 Feb 2023 14:51:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB7ACC4339B;
        Tue, 14 Feb 2023 14:51:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676386311;
        bh=pd/T1je5R3F3V13CYoaSCUsHQT+gasg5eBG4RSQYtHk=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=WpYy9LVIe0k2Tw+QYbhwnKWTRGG5w2ph080OvbaFX5l7gR5sl7RHUWWtbtWEHbapR
         UPL90R+BSpfsGKokeVP6Fnzn5y5wLxhRwRu2bRZgZxDlMhClBeDdrhEOv6evMdFbd9
         jQ/O1GQtJH4doPgk2LiAUCtWpEq/ID8UAXbT5Z5PHAoE7uEJ3vK0rt5cvBwI7xF3nr
         8hMX4NgP6vM6IurLcuoJNHmXq0DsvcjlwwiB7OF3FGSDxPzSZaSKcxFQ7HPLzKOB1w
         KYx5QcaAASN3S3sxj+j7YZLkGbVzWFCgNpEWZlbSZgvgrLNiF+KRqGYADbBUOig3vg
         7AD1UdwRXpJDQ==
Message-ID: <9557c372-6d49-f39e-3ea4-fdf2f33b1bf5@kernel.org>
Date:   Tue, 14 Feb 2023 22:51:47 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH] Documentation/ABI: sysfs-fs-erofs: update supported
 features
Content-Language: en-US
To:     Yue Hu <zbestahu@gmail.com>, xiang@kernel.org,
        linux-erofs@lists.ozlabs.org
Cc:     linux-kernel@vger.kernel.org, huyue2@coolpad.com,
        zhangwen@coolpad.com
References: <20230209051128.10571-1-zbestahu@gmail.com>
From:   Chao Yu <chao@kernel.org>
In-Reply-To: <20230209051128.10571-1-zbestahu@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/2/9 13:11, Yue Hu wrote:
> From: Yue Hu <huyue2@coolpad.com>
> 
> Add missing feaures for sysfs-fs-erofs feature doc.
> 
> Signed-off-by: Yue Hu <huyue2@coolpad.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,

