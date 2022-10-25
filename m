Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C297760C220
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 05:12:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230052AbiJYDMZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 23:12:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230440AbiJYDMT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 23:12:19 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2606B4361C
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 20:12:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 7C26ACE1AC0
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 03:12:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98884C433D7;
        Tue, 25 Oct 2022 03:12:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666667534;
        bh=F02ziIK/ROj0myXKwHePhpNh/0PVFgy/G6Wbc8jYZhI=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=D5AWFHfpSlMQgNTxXm50TjIsCmzWGh6sW9vEnk+WJbzVbJooKcrZ+JFuMolOeywpz
         aV+T1GVE8fmlNOkpT3GI+lUGf4Rl7AMjPrPdNtI/Jp5UPf+slm4x259IjkyfJVc5pX
         Rzu5XGTGZxUJS4XnmEkRJUH2Ftx0cnwQVQQKogXct0ntDsvnYjb6An8KdrGVAOMIfa
         Tpj66zQbzzeHOG9zE3/UFusvPCO5/xlu6IId5thaH2b58LPVsoeySwGyQb9rK9BN4e
         HIp3c5Ih8qX/Tey1MglmmbwHwc1wYWFzTZ4uVhUuF9F1Hkp1cWy4EIUM8RNtvaw4/0
         HQyNcStG5Rc5Q==
Message-ID: <3dbf0d43-9a7a-33c5-abc0-2c48ac69c948@kernel.org>
Date:   Tue, 25 Oct 2022 11:12:10 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [PATCH] f2fs: add barrier mount option
Content-Language: en-US
To:     Yangtao Li <frank.li@vivo.com>, jaegeuk@kernel.org
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
References: <20221024175401.18888-1-frank.li@vivo.com>
From:   Chao Yu <chao@kernel.org>
In-Reply-To: <20221024175401.18888-1-frank.li@vivo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/10/25 1:54, Yangtao Li wrote:
> This patch adds a mount option, barrier, in f2fs.
> The barrier option is the opposite of nobarrier.
> If this option is set, cache_flush commands are allowed to be issued.
> 
> Signed-off-by: Yangtao Li <frank.li@vivo.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,
