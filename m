Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 015DE696764
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 15:53:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231714AbjBNOxA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 09:53:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231781AbjBNOw6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 09:52:58 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75CB12A141
        for <linux-kernel@vger.kernel.org>; Tue, 14 Feb 2023 06:52:34 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0B14C61726
        for <linux-kernel@vger.kernel.org>; Tue, 14 Feb 2023 14:52:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 502A0C433D2;
        Tue, 14 Feb 2023 14:52:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676386353;
        bh=4d+yolNgm6gYxCCCSu0j7YFzhUwU4Xv/oNwq06e3tIw=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=oo7LG6n8qvuXPhFRAM+V081AchrG1re+64lqH4SKsEAnDFcLHnYX/gDpXzJPOaXOI
         u71TICug8FNzXUKkAmCkm4q24m2QLCSqrmB41azHo73YqKGMcrPLOu18eHcJ/u0S8C
         0H2XfedlzETDeImK0LYx2Lr78iiWV7Zt0fKQ3VH/TrrQvxWfVswcnSBBSGiHYhGPXC
         67drY5/jbExRfQ6AL8W/NWaeNxTJT3u037yBYD2uQ1dZoF9DgOWmbxe72igaCHQ2HA
         UEdHpGKZVyybu3Yo/+hhWbIYjurnQxAlWn/65U+rDzLIRFjfkE/VslzbDYUMZUWovK
         ACJMy8P/EpJMQ==
Message-ID: <6761e375-8109-13ab-36b1-eda14a041cbe@kernel.org>
Date:   Tue, 14 Feb 2023 22:52:30 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH] MAINTAINERS: erofs: Add
 Documentation/ABI/testing/sysfs-fs-erofs
Content-Language: en-US
To:     Yangtao Li <frank.li@vivo.com>, xiang@kernel.org,
        huyue2@coolpad.com, jefflexu@linux.alibaba.com
Cc:     linux-erofs@lists.ozlabs.org, linux-kernel@vger.kernel.org
References: <20230209052013.34952-1-frank.li@vivo.com>
From:   Chao Yu <chao@kernel.org>
In-Reply-To: <20230209052013.34952-1-frank.li@vivo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/2/9 13:20, Yangtao Li wrote:
> Add this doc to the erofs maintainers entry.
> 
> Signed-off-by: Yangtao Li <frank.li@vivo.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,

