Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DFD762425C
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 13:28:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229678AbiKJM2D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 07:28:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229530AbiKJM2A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 07:28:00 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CB71247
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 04:28:00 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EE15F615D8
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 12:27:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A60EC433D6;
        Thu, 10 Nov 2022 12:27:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668083279;
        bh=dJPsCX8eDjFVUPGpFaJpV7q3H2UfKOX6bWrgqDkxFRU=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=ah91qz/t7Pr9oogamLx9Z+Sz4m74YBlfTeqhAkiBhTlAHNysTFkNkgjmHYw7mNuIf
         MT26yqBMJ9BuvlUd1iCkNc2Rok726R16Ceoaq0fXNpeixgxp1iKvzUz/OtjcQVCRZX
         28F64D7pDL/BGBNJMay3aLzFTMtA+Q+5SBgWYcqfAzAcZtRwLyIUGraYK7Xl9Ry+hG
         mjMIMGJHhDkeD01dD7RkoIL7ov9wOf/nvlLW9WqZN1fYW3MKSpWSVMZK5301dFBUDm
         TtxA+0NVe3C2cy3+pj0KesU08PESR47HL8t8GeVwxOw1kC72GjQIXfD69514KNrmua
         30tmwoto6ia5A==
Message-ID: <11eed25c-d72a-f3d5-2864-ad795bd32968@kernel.org>
Date:   Thu, 10 Nov 2022 20:27:57 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: [f2fs-dev] [PATCH v6 1/2] f2fs: correct i_size change for atomic
 writes
Content-Language: en-US
To:     Daeho Jeong <daeho43@gmail.com>, linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com
Cc:     Daeho Jeong <daehojeong@google.com>
References: <20221031192416.32917-1-daeho43@gmail.com>
From:   Chao Yu <chao@kernel.org>
In-Reply-To: <20221031192416.32917-1-daeho43@gmail.com>
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

On 2022/11/1 3:24, Daeho Jeong wrote:
> From: Daeho Jeong <daehojeong@google.com>
> 
> We need to make sure i_size doesn't change until atomic write commit is
> successful and restore it when commit is failed.
> 
> Signed-off-by: Daeho Jeong <daehojeong@google.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,
