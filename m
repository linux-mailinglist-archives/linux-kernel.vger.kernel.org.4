Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E84A4694177
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 10:40:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230321AbjBMJkE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 04:40:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231197AbjBMJju (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 04:39:50 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2284D15CA0
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 01:39:15 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 277DCB80EF5
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 09:39:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C50FCC433D2;
        Mon, 13 Feb 2023 09:39:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676281151;
        bh=vVdpCrDoAhxSsJh4CeJNCQlwdKv2xGaZz7pGcBooUr8=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=p0k2wcYIDDjK/8DEl4rPxtFjtajjhCPxp71pZtf3dzqoaOrwh8XtMczL9NzideMzg
         XujGAHd3gKNdRltTpN6nvjTofqDxFZLVMS6x6Jh6LH9DAAOwZe0jBMEAXndlH+ezLM
         +CG5Q0tLfse9WXLoQ7zX4GSEvctzt49/ntOapkvCWL39003K0BwVhD6pbLnrHeaYkO
         bdMZCfEWtt+u94tdvpBjCVSQxywk7fJfYFa3NLK6tkB20kt3m14BJ0LFVVcNGngf98
         qT8EECRtJvcDCAPtNBU3C8UVJchlsFfcVOB2GoWBGwzbJhMZFdBx9bRamfkuP3cBln
         CZDdmk644iEfA==
Message-ID: <4e2d1d4a-208d-a7ca-51e4-10e1852e965c@kernel.org>
Date:   Mon, 13 Feb 2023 17:39:09 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.2
Subject: Re: [PATCH v2] f2fs: export ipu policy in debugfs
Content-Language: en-US
To:     Yangtao Li <frank.li@vivo.com>, jaegeuk@kernel.org
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
References: <20230210104215.64067-1-frank.li@vivo.com>
From:   Chao Yu <chao@kernel.org>
In-Reply-To: <20230210104215.64067-1-frank.li@vivo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/2/10 18:42, Yangtao Li wrote:
> Export ipu_policy as a string in debugfs for better readability and
> it can help us better understand some strategies of the file system.

Oh, I missed v2, how about making another patch to replace si->sbi w/ sbi?

Thanks,
