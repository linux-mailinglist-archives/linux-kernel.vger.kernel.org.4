Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E059649C04
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Dec 2022 11:24:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230506AbiLLKYD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Dec 2022 05:24:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231905AbiLLKX5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Dec 2022 05:23:57 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0086ECE1F
        for <linux-kernel@vger.kernel.org>; Mon, 12 Dec 2022 02:23:55 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8DC1260F3F
        for <linux-kernel@vger.kernel.org>; Mon, 12 Dec 2022 10:23:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C722AC433EF;
        Mon, 12 Dec 2022 10:23:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670840635;
        bh=QVh2FacIZw0QmY6waNMNoeqr2IOPISHIV0yA3SQCiHs=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=oWJU4bJtY7LAZR1dUBK/bUpJjV/aZWjAu5HXBTSzxSUDpkRvvrpDkuoum3q8tuxXa
         99F9kBA3RZkraB1ragitgbvoEgK4w9j20jV+j1bk6HXhzkcfyGpgegaKAL6RXSe/7v
         WQFfww3ihE9keWdRYuFoZmadgKgtEVQJvA88tc15fy43xUEzpTz3TL8YOPw+KzzKUJ
         h6FtXRolaAlQ16Jd1KaIH4fSGxr/tJZ+5bcLwCL0m50unuuegLSQSvdj+Ml/aK/K8A
         cyFF9QJQGW0U4ZhnRoGtEoB7VNa3sc4iv9kcQTJMRD2zHaU6Q9B+9640/tNHn4+BOr
         WwvhZ3YdPFwWA==
Message-ID: <c559c081-b9db-38dd-4c63-d22df4614c02@kernel.org>
Date:   Mon, 12 Dec 2022 18:23:52 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH v2] f2fs: reset wait_ms to default if any of the victims
 have been selected
Content-Language: en-US
To:     Yuwei Guan <ssawgyw@gmail.com>, jaegeuk@kernel.org
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Yuwei.Guan@zeekrlife.com
References: <20221211130841.113959-1-Yuwei.Guan@zeekrlife.com>
From:   Chao Yu <chao@kernel.org>
In-Reply-To: <20221211130841.113959-1-Yuwei.Guan@zeekrlife.com>
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

On 2022/12/11 21:08, Yuwei Guan wrote:
> In non-foreground gc mode, if no victim is selected, the gc process
> will wait for no_gc_sleep_time before waking up again. In this
> subsequent time, even though a victim will be selected, the gc process
> still waits for no_gc_sleep_time before waking up. The configuration
> of wait_ms is not reasonable.
> 
> After any of the victims have been selected, we need to reset wait_ms to
> default sleep time from no_gc_sleep_time.
> 
> Signed-off-by: Yuwei Guan <Yuwei.Guan@zeekrlife.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,
