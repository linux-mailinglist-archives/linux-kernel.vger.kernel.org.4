Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66A1D6C949A
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Mar 2023 15:49:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231987AbjCZNtx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Mar 2023 09:49:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230399AbjCZNtu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Mar 2023 09:49:50 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CD6C76A3
        for <linux-kernel@vger.kernel.org>; Sun, 26 Mar 2023 06:49:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D28E4B80315
        for <linux-kernel@vger.kernel.org>; Sun, 26 Mar 2023 13:49:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8DE25C433EF;
        Sun, 26 Mar 2023 13:49:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679838586;
        bh=6fOgTWzVrss+rb+Gr+qQbntTVt0XT8KX+kHdAaZ3HtA=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=GzYRuNnqfoW++B4B/A0ZPhpUmdgvLw5ZhY0SbxrabINuECe6frEtW96QLgDaiUzyg
         Ocq/5SIw7PUrv/wdsWvkpjzisy4OXh7JUCecBDV0etbW87rGWA+YAEhJ2NoqWBCU3S
         7m/LDuyXbInDb7HZXAp40QksPSz+1peE2UCSRWE7k4Kqn1uPqabuUF0wFSDzrQLCrg
         r4un2ChuAZl4l9e2+iFQipLONsU2sMr6yzpGoMYFIUKIZhXGxqPBRElHN5XGS4aZYk
         v75TlMqD6ir+Y7m+PaX+WslflEcknBYfwIQm0bj8E5SYHU3SO2Ui7bQXw7qptkkP0S
         38ML2h2UtttnA==
Message-ID: <7cb351fa-1f93-6acc-a64d-1107d7e9f032@kernel.org>
Date:   Sun, 26 Mar 2023 21:49:44 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH] f2fs: remove else in f2fs_write_cache_pages()
Content-Language: en-US
To:     Yangtao Li <frank.li@vivo.com>, Jaegeuk Kim <jaegeuk@kernel.org>
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
References: <20230320173137.64413-1-frank.li@vivo.com>
From:   Chao Yu <chao@kernel.org>
In-Reply-To: <20230320173137.64413-1-frank.li@vivo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/3/21 1:31, Yangtao Li wrote:
> As Christoph Hellwig point out:
> 
> 	Please avoid the else by doing the goto in the branch.
> 
> Signed-off-by: Yangtao Li <frank.li@vivo.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,
