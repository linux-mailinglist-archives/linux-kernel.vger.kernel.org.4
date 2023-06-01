Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF29A7190F7
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 05:08:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231264AbjFADIp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 23:08:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231127AbjFADIW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 23:08:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D67EF10E0
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 20:07:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 695066409A
        for <linux-kernel@vger.kernel.org>; Thu,  1 Jun 2023 03:06:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0015C433EF;
        Thu,  1 Jun 2023 03:06:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685588766;
        bh=3+CY4AzK9WaVFBZweand5Oq2g+ea9okBFlyFMJDiaLU=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=GaIsRauGLXF6sYxTtt8HGSBvc2U3BSWUbi+gs/lM7Nfaynb2ruvI8UwoWft9Rc5TQ
         G6Y8wUK4fiCqdJCndRjju5eCJtZMZipYBxDMUjblyFNsZVpXp9wjMNJM6P38QRjaE9
         9vV7ih3N8C0/OkAf6tPMuBQfl4ZmXqB/vYU6pRLgHo+vh5GEqU8VEgkWydagM/eFBa
         hLBy7lzk7TvHS9lzPl0on0fm6Ic6LxLzL5zFgdnU8G84EXrMInuTIWtS6zP6h2dqCy
         Z14oGo6xYK469aOm/t7ck9FM8+ZyTs9dkmm3GvFs3ga46mHnqlH5RDIqd7cGw3ZA6y
         ZEZZ/HkhQ1crg==
Message-ID: <bfcb9d94-15a7-3dd7-7e1c-c041e3ee2769@kernel.org>
Date:   Thu, 1 Jun 2023 11:06:03 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v2] f2fs: add f2fs_ioc_[get|set]_extra_attr
Content-Language: en-US
To:     Sheng Yong <shengyong@oppo.com>, jaegeuk@kernel.org
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
References: <20230529013502.2230810-1-shengyong@oppo.com>
 <20230530063407.3305344-1-shengyong@oppo.com>
From:   Chao Yu <chao@kernel.org>
In-Reply-To: <20230530063407.3305344-1-shengyong@oppo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/5/30 14:34, Sheng Yong wrote:
> This patch introduces two ioctls:
>    * f2fs_ioc_get_extra_attr
>    * f2fs_ioc_set_extra_attr
> to get or modify values in extra attribute area.
> 
> The argument of these two ioctls is `struct f2fs_extra_attr', which has
> three members:
>    * field: indicates which field in extra attribute area is handled
>    * attr: value or userspace pointer
>    * attr_size: size of `attr'
> 
> The `field' member could help extend functionality of these two ioctls
> without modify or add new interfaces, if more fields are added into
> extra attributes ares in the feture.
> 
> Signed-off-by: Sheng Yong <shengyong@oppo.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,
