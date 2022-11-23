Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D9176363FC
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 16:38:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238802AbiKWPh6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 10:37:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238785AbiKWPho (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 10:37:44 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05B871CFC7
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 07:37:30 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6F2C2B82108
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 15:37:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CE54C433D6;
        Wed, 23 Nov 2022 15:37:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669217848;
        bh=WtG/nCMmHFjaiF9yiTnMEGa5dsGUrNmb98PkLsNAl88=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=dWGhMqwUJk+AbyPMelvRGJERNUWBRm/iwdfVlBMce2s9DpWnU6tK+1bEnQmxSX9WL
         wRDKKPlVTTBBbCh8y1fi4mJd+JXPhO2UrzWMAIwX+qzWnJJ1TSQ51kITPkvHmr7h31
         CgYkV0zo22JhPI47ogAgrqJVGpdR+YQOvbGE86WfEol3Fowc4Xlp/Npio1deb+hxn+
         jw+q4LA5y1SK7+sLUHOR1CP4ZbsU9ciwv0cXh/X1r2VBQZ5XlJinTRhRBps70V6yEP
         zx6kRNBq/37vsmWMADN7I2xiyF+Cu7NcLqPVogC8c+5UGSjLr6w1d+Dd9IAgHbR2fZ
         jYqiz8Lkic6BA==
Message-ID: <1bba50dd-99a3-76c8-3469-ab096bd23c38@kernel.org>
Date:   Wed, 23 Nov 2022 23:37:25 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH] f2fs: fix description about discard_granularity node
Content-Language: en-US
To:     Yangtao Li <frank.li@vivo.com>, jaegeuk@kernel.org
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
References: <20221118174028.63702-1-frank.li@vivo.com>
From:   Chao Yu <chao@kernel.org>
In-Reply-To: <20221118174028.63702-1-frank.li@vivo.com>
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

On 2022/11/19 1:40, Yangtao Li wrote:
> Let's fix the inconsistency in the text description.
> Default discard granularity is 16. For small devices,
> default value is 1.
> 
> Signed-off-by: Yangtao Li <frank.li@vivo.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,
