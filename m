Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87FAD6DA6DF
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Apr 2023 03:21:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238433AbjDGBV0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 21:21:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231743AbjDGBVL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 21:21:11 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33FEBA27F
        for <linux-kernel@vger.kernel.org>; Thu,  6 Apr 2023 18:19:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BAB5264052
        for <linux-kernel@vger.kernel.org>; Fri,  7 Apr 2023 01:19:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38023C433D2;
        Fri,  7 Apr 2023 01:19:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680830366;
        bh=sWBOrgUvTwEAppSzsnslf21eHkkDl0tRxVxaz0TgKZA=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=MIoHW32RpbpDagzVhAkSyBjvx3IcOTgSA4rBAVmSk7KO0kGiqruv1DQFK0jpy9jBG
         +Nmh2bMocQNIjwtpiKbbT20t5AH0TXwzT6AR2VpOP9MaiaTHLshRlCbvqXJop4PVlE
         IfZI/9ZPpcK9tZdCLWNuLFwmrG6SVE0k+cw5sFlbVai96sFPFajXj/Cv0RAbZjz90T
         BEb+b2oq3BihHqTizSemOry7vGopuLmBtfLiaM505fjVDq/WXl+0q1ZyIwkHKJbsf1
         zx1ZWOeCPhtcZP1SBtO3bh8eKYNwA1dLemNYCheYlKOVaBY09xO42MWydsl+0iEjzb
         VwWukVBZXpQkQ==
Message-ID: <53fe1610-895b-04c6-48a2-61918b21aed7@kernel.org>
Date:   Fri, 7 Apr 2023 09:19:23 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH] f2fs: use common implementation of file type
Content-Language: en-US
To:     Weizhao Ouyang <o451686892@gmail.com>,
        Jaegeuk Kim <jaegeuk@kernel.org>
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
References: <20230404032844.3596879-1-o451686892@gmail.com>
From:   Chao Yu <chao@kernel.org>
In-Reply-To: <20230404032844.3596879-1-o451686892@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/4/4 11:28, Weizhao Ouyang wrote:
> Use common implementation of file type conversion helpers.
> 
> Signed-off-by: Weizhao Ouyang <o451686892@gmail.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,
