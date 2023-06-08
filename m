Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19916727C66
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 12:12:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235434AbjFHKME (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 06:12:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235419AbjFHKMB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 06:12:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD7C21FE6
        for <linux-kernel@vger.kernel.org>; Thu,  8 Jun 2023 03:12:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7268D61EF7
        for <linux-kernel@vger.kernel.org>; Thu,  8 Jun 2023 10:12:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4236C433D2;
        Thu,  8 Jun 2023 10:11:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686219119;
        bh=O7H8bNFpm2s9CtD+sRPpMy+feLf/EJEH6ZI7LjHujr0=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=IBvYAI2CqeDaE06Z7QBTcl22qDFy/UZtWs5ACJLtzp4gGck5OpamsXAufhiys1Tlc
         b7Q9P5pEd2ksOe0bOFtoOuF4ordItjiBRsYcIl2ziy6b0RhXBquTeB0vzBcY2L+4v2
         ner70azGNZ1Wo6vxsyhIevFwIE5AlKH4fa9xCfmoyd9KPrnKT39B7GVnjAswNBmthy
         WTYdV/hHk7fu3pN8cG3eh1bO4A2gUu88IHn5xb8tOQFcUc57/XD0XkThaL2P95RbD7
         FXYW+0Xi8OuGIl4UcyaxkypAvZLGWmursjMhU/fyO2wr/VNKDQpJmcZpVcrtPOI6Gv
         bCORgcSXo0qhg==
Message-ID: <36678490-ee03-4ce0-a5b1-5292e9d92b8b@kernel.org>
Date:   Thu, 8 Jun 2023 18:11:56 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [f2fs-dev] [PATCH] f2fs-tools: fix wrong write pointer check for
 non-zoned areas
Content-Language: en-US
To:     Daeho Jeong <daeho43@gmail.com>, linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com
Cc:     Daeho Jeong <daehojeong@google.com>
References: <20230606173948.3390215-1-daeho43@gmail.com>
From:   Chao Yu <chao@kernel.org>
In-Reply-To: <20230606173948.3390215-1-daeho43@gmail.com>
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

On 2023/6/7 1:39, Daeho Jeong wrote:
> From: Daeho Jeong <daehojeong@google.com>
> 
> Do not check F2FS_ZONED_HM for the whole device. We need to do this for
> each area of devices.
> 
> Signed-off-by: Daeho Jeong <daehojeong@google.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,
