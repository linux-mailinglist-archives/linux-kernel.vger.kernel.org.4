Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2484D741DC3
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jun 2023 03:50:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231848AbjF2BnZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 21:43:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231834AbjF2BnP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 21:43:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 576EE2693
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jun 2023 18:43:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CBFF9614A6
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jun 2023 01:43:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3118EC433C8;
        Thu, 29 Jun 2023 01:43:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688002993;
        bh=8lXDUlC1LfL5SFeDCw6MuzX/zk9IThAIgYw2rl3SSo0=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=u/i5Pufb4PXrl/5+H/foMee0m54nD31tAXIClLk4oFEsbCQNCh3Y4ZerR5dHOLHpD
         os9jQYUKOWGzF48hZtgxuLYBRsJb2VdK/zOz0V2ah/JxxT5C3Bmn/TBWrwHp0D9LBK
         8LKKbY5Dxfz82Cb/gE2zYra+m+MUv8IIu/xnXlR+kCss1hXeftNLNpGVtmGs4hmtWD
         MuWg4tKFoUCpYJcqXho19Hsb/mUDLtmk48oFmT6//cGlHlFYQOl9FWtH4SZEM7jrBw
         EeSqfnQn2YGoWHn6CurPjqXdqtzaUywVz6BKLnX4lk9735w5nZ6QeCDPmfNr/e6fCE
         PJOlYF03o9AUw==
Message-ID: <a21d1848-9813-124f-0486-906b02bc8b2c@kernel.org>
Date:   Thu, 29 Jun 2023 09:43:08 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH RFC] f2fs: only set release for file that has compressed
 data
Content-Language: en-US
To:     Sheng Yong <shengyong@oppo.com>, jaegeuk@kernel.org
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
References: <20230627122153.1557656-1-shengyong@oppo.com>
From:   Chao Yu <chao@kernel.org>
In-Reply-To: <20230627122153.1557656-1-shengyong@oppo.com>
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

On 2023/6/27 20:21, Sheng Yong wrote:
> If a file is not comprssed yet or does not have compressed data,
> for example, its data has a very low compression ratio, do not
> set FI_COMPRESS_RELEASED flag.
> 
> Signed-off-by: Sheng Yong <shengyong@oppo.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,
