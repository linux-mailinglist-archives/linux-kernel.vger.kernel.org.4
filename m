Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1546F6447B4
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Dec 2022 16:12:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232825AbiLFPMV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Dec 2022 10:12:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235243AbiLFPLv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Dec 2022 10:11:51 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA70F2DA9F
        for <linux-kernel@vger.kernel.org>; Tue,  6 Dec 2022 07:08:43 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0F6D9B81A19
        for <linux-kernel@vger.kernel.org>; Tue,  6 Dec 2022 15:07:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12406C433C1;
        Tue,  6 Dec 2022 15:07:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670339271;
        bh=LGJtkj6tlGm0S+Vo3HnJFB6nv3mejW6xah3eFnKfR9s=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=maM0tSGEdV832IA6va9/TFSpx3eGgDMlq9rxHsTwKsR/lQQUDoXXPJVYk9KkgollR
         yvjJeXovP5/6H8gM1Uq0J5flUJz3WYd9YuIDZj1RvBHO/2ObKvHzgV06XVHra2aHcj
         MRImEjjlsA0YmGp4jdk8M8/Bj3+iJzY6YwQohPWETkc99Eqa6Q3cKbYbSmlrXA0JU8
         DH+En/2seBXCIX77fbMQOlE6kkC/9DVFCke72rScBx5aFHjX+f4+F/vE/tyK7fn9N+
         eqZXwoWYD47EBpgi29W9uLu/0mmnMNly9LTt6TGLNgeI0GjkPdJR8xrtDv/TFNLtEu
         Dv5UgTTuP2Bew==
Message-ID: <b188931a-decb-3476-f22c-d580fa4fc840@kernel.org>
Date:   Tue, 6 Dec 2022 23:07:49 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH 1/2] erofs: fix missing unmap if
 z_erofs_get_extent_compressedlen() fails
Content-Language: en-US
To:     Gao Xiang <hsiangkao@linux.alibaba.com>,
        linux-erofs@lists.ozlabs.org
Cc:     LKML <linux-kernel@vger.kernel.org>
References: <20221205150050.47784-1-hsiangkao@linux.alibaba.com>
From:   Chao Yu <chao@kernel.org>
In-Reply-To: <20221205150050.47784-1-hsiangkao@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/12/5 23:00, Gao Xiang wrote:
> Otherwise, meta buffers could be leaked.
> 
> Fixes: cec6e93beadf ("erofs: support parsing big pcluster compress indexes")
> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,
