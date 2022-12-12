Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A562649BFC
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Dec 2022 11:23:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231909AbiLLKXN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Dec 2022 05:23:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231819AbiLLKXJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Dec 2022 05:23:09 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEC6CDC7
        for <linux-kernel@vger.kernel.org>; Mon, 12 Dec 2022 02:23:07 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5EF5A60F92
        for <linux-kernel@vger.kernel.org>; Mon, 12 Dec 2022 10:23:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1EDAC433EF;
        Mon, 12 Dec 2022 10:23:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670840586;
        bh=eaA9Ecx2vK5nM7LogognJdRgdhZwRl/7vGOtUmN82A8=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=kU0gy2TKFN6jg5sLVps40wqHVutxGRXqfBqb/rLzTqgUHBOtXVqqnMpO+V55hJlSr
         ouAwqDsMgVDYVERAh4gJwKBLTcLnkVdt+4MnM/coe5p+s2y3JRZbqeCMCYYuBujDaJ
         P0GeeJqVfI2ogYRoOYtgGdQvxJ2tuPuV0JVRyh0015S4tcbUFw9mXqWdjaVmbEOWC/
         Gc0MtMQiKXOvDU1hE/QlQoI0EJSyntXHZGyK2pz70//F/TmrEPMF02nUBBpEu3y9aR
         pgK8RNKB0Hyr6C6osHJ3Xzcz7VfeAe4X0rSJKw32QBxBqMatjoppyrvxg0CmwQ8/0j
         l6cEXMIgFrWuA==
Message-ID: <5cc534fc-1192-887a-91e1-2f1c2283b212@kernel.org>
Date:   Mon, 12 Dec 2022 18:23:03 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH] f2fs: add iostat support for FS_DISCARD_IO
Content-Language: en-US
To:     Yangtao Li <frank.li@vivo.com>, jaegeuk@kernel.org
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
References: <20221212054706.65579-1-frank.li@vivo.com>
From:   Chao Yu <chao@kernel.org>
In-Reply-To: <20221212054706.65579-1-frank.li@vivo.com>
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

On 2022/12/12 13:47, Yangtao Li wrote:
> Just like other data we count uses the number of bytes as the basic
> unit, but discard uses the number of cmds as the statistical unit. In
> fact, the discard command contains the number of blocks. In order to
> avoid breaking its usage of application, let's keeping FS_DISCARD
> as it is, and add FS_DISCARD_IO to account discard bytes.
> 
> Suggested-by: Chao Yu <chao@kernel.org>
> Signed-off-by: Yangtao Li <frank.li@vivo.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,
