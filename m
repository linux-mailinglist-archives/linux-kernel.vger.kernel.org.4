Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7ED446AE465
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 16:19:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230419AbjCGPTc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 10:19:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231163AbjCGPS4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 10:18:56 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDD606EA2
        for <linux-kernel@vger.kernel.org>; Tue,  7 Mar 2023 07:16:53 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7A7A861456
        for <linux-kernel@vger.kernel.org>; Tue,  7 Mar 2023 15:16:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4593C4339B;
        Tue,  7 Mar 2023 15:16:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678202212;
        bh=r5UlYGnLJQR3K3EgnBj+BtpeV/TXq8sAAb2GWHNtr1s=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=MwQm30pP8tYFJXLYp9KJTB+wjdOpFUU8NAz9yJ2Oz4247tPiD5B2Jh1ttiI7UZozl
         UzrqeUUEPP2wmVMPAjU51BATX/Zk4/7YVWHet3j19SAgPJR38OMfwcUem1uF/W6mXN
         Z50s5CIq4+NL8xiOToWMAbluGM/DeQewr9AuQCKb160MZviZZoOETn1WOyNV3FtzeP
         Hfk5Is+qpC1qRIcpMefcx/9A5CSt//+1gPc/h/BF2hwckck5bhl0/0GFbjY9doOujl
         D+eXIq+uX59l7vmEj5iK2WqJbnLsxYggRZx9BA/i8hr7CGKit5d4itxsHfoDj6j4wz
         0OwtNp3uCG4JQ==
Message-ID: <1eafcd1d-50e9-e515-fd84-fca25139304e@kernel.org>
Date:   Tue, 7 Mar 2023 23:16:48 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v2, RESEND] f2fs: export compress_percent and
 compress_watermark entries
Content-Language: en-US
To:     Yangtao Li <frank.li@vivo.com>, jaegeuk@kernel.org
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
References: <20230216140935.20447-1-frank.li@vivo.com>
From:   Chao Yu <chao@kernel.org>
In-Reply-To: <20230216140935.20447-1-frank.li@vivo.com>
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

On 2023/2/16 22:09, Yangtao Li wrote:
> This patch export below sysfs entries for better control cached
> compress page count.
> 
> /sys/fs/f2fs/<disk>/compress_watermark
> /sys/fs/f2fs/<disk>/compress_percent
> 
> Signed-off-by: Yangtao Li <frank.li@vivo.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,
