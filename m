Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 905E5620741
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 04:06:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233280AbiKHDGt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 22:06:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229561AbiKHDGc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 22:06:32 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 836B5303E6
        for <linux-kernel@vger.kernel.org>; Mon,  7 Nov 2022 19:06:31 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C1314B8091C
        for <linux-kernel@vger.kernel.org>; Tue,  8 Nov 2022 03:06:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FBE1C433D6;
        Tue,  8 Nov 2022 03:06:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667876788;
        bh=QF78iOGcajcnk4Z9GZuE7IjkV7FmrSLX0pW9ceH+Kl8=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=acKb8tRhXB8nu+hrly0zCkR3DiQc2b3rI9oVBOwQ4FMxtJEgKciwbkKRbY9sE2A1t
         tY9A5NF5vey63bOrykf001ThaeMyLjXuJKRbF5dysP+j8t4OVZqM5yr+JxqSmTUvZ7
         WluwTKS0iJEAlINpIOyRVuIT7xFAw4L+x5WTKMosIBFdyVWGkMcwtuSL6lpoad2ZQW
         I55lCvkZDzrs/BlvIbPTbjBQ98fI4Ra5A2ibDaqUOyD/82dMHkJ5MoJi+UStjkYazl
         mD8iEEfkceGTh2hoR9c+CNQe24T4zqxqSI7fIGnwk54W+MY7dozCbJiT6hKdX1a1yi
         fOVmfYfwjbvNw==
Message-ID: <dd8c717a-28d7-f155-d5ee-24e8f28c4329@kernel.org>
Date:   Tue, 8 Nov 2022 11:06:24 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [PATCH v2] erofs: fix general protection fault when reading
 fragment
Content-Language: en-US
To:     Yue Hu <zbestahu@gmail.com>, xiang@kernel.org
Cc:     linux-erofs@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        syzbot+3faecbfd845a895c04cb@syzkaller.appspotmail.com,
        syzkaller-bugs@googlegroups.com, zhangwen@coolpad.com,
        Yue Hu <huyue2@coolpad.com>
References: <20221021085325.25788-1-zbestahu@gmail.com>
From:   Chao Yu <chao@kernel.org>
In-Reply-To: <20221021085325.25788-1-zbestahu@gmail.com>
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

On 2022/10/21 16:53, Yue Hu wrote:
> From: Yue Hu <huyue2@coolpad.com>
> 
> As syzbot reported [1], the fragment feature sb flag is not set, so
> packed_inode != NULL needs to be checked in z_erofs_read_fragment().
> 
> [1] https://lore.kernel.org/all/0000000000002e7a8905eb841ddd@google.com/
> 
> Reported-by: syzbot+3faecbfd845a895c04cb@syzkaller.appspotmail.com
> Fixes: 08a0c9ef3e7e ("erofs: support on-disk compressed fragments data")
> Signed-off-by: Yue Hu <huyue2@coolpad.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,
