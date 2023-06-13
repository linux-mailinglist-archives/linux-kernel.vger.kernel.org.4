Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44B5972D731
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 03:53:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238388AbjFMBxw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 21:53:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233225AbjFMBxn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 21:53:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DE54198E
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 18:53:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 14ED462E70
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 01:53:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B671C433EF;
        Tue, 13 Jun 2023 01:53:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686621205;
        bh=jQzl78vkH5imr/uqQKm1VRitSbjPqMq6WBF+qTjykec=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=jn1pnVU/PvqrfI1AGEbtHw8WRiIFsSEssYI1F1NOOMDt/CbVaPHRLYjLN2mE2IhLU
         E8eQushd3ZIrdexw2g9+7fHhnzCZbWcq/2xuAr3rznStrivmKzyE3wfWPFUvlvsFE7
         ufnRdQdZuTff9j0gt/mhqyAPaL53qIjAr3vbSzW4tUZFjRyxpbPyIyFRdSe+zQpOGJ
         /fmw7IR2jMawg1h86mcD0QM7iL0BA2yUE7Y6PuS4CNfNRyxnE1rn9s+x+NCtZ41dcJ
         GzkDOMaXs0GIIGGauzOLrHQrh+uRDP7de/jM0vvsShpFWxqvVz67rOnmzZNVBqeCS9
         6hG72jfkIrTqw==
Message-ID: <ebac8472-2119-d1bc-73af-642caf129e3c@kernel.org>
Date:   Tue, 13 Jun 2023 09:53:22 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH v4 4/6] f2fs: add f2fs_ioc_get_compress_blocks
Content-Language: en-US
To:     Sheng Yong <shengyong@oppo.com>, jaegeuk@kernel.org
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, ebiggers@kernel.org
References: <20230612030121.2393541-1-shengyong@oppo.com>
 <20230612030121.2393541-5-shengyong@oppo.com>
From:   Chao Yu <chao@kernel.org>
In-Reply-To: <20230612030121.2393541-5-shengyong@oppo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/6/12 11:01, Sheng Yong wrote:
> This patch adds f2fs_ioc_get_compress_blocks() to provide a common
> f2fs_get_compress_blocks().
> 
> Signed-off-by: Sheng Yong <shengyong@oppo.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,
