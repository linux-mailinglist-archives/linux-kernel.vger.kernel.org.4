Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B8F862B089
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 02:27:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231703AbiKPB1j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 20:27:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230342AbiKPB1i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 20:27:38 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFFB62FFF5
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 17:27:37 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8490860C89
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 01:27:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1403C433B5;
        Wed, 16 Nov 2022 01:27:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668562056;
        bh=Ekbcnkxdb4B7+mE9GZIS2Cxv9nmRXw98wHjM6WoI6kk=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=hdL2lXuXu5rToZr/nj65BKvOPSRnCC8LwVsEmw4cmuSCplRb1ymDsHviEIzGMgmK7
         dOGNkjGDFKhB6+Dc/ws5nqB26f6lOw2RsWVdh7gqhJ83fESWV8sTkgVcF8f7XIde69
         91nfcqE4VmH0qJsetnJnkRbWJpxodUglknd+Bl30XdJm/V0KaVCCqVqc+JPujptTHk
         EmDnDPfEEI/6Rf59A1AMtzio7mjtH5cE2H2/PaHrr//96tX2cbgXOP6VHgIzA67wd8
         EW9VaiZZ1R0EZYlmCQvDUukaB2O0/SayJWAalwF+INg/m9IMaWHkwf+tB6m6p4GU6b
         Q1KfQtRtBMw2Q==
Message-ID: <538bd5c2-d287-8df1-1061-bca2d801b64d@kernel.org>
Date:   Wed, 16 Nov 2022 09:27:34 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [PATCH v2 3/3] f2fs: change type for 'sbi->readdir_ra'
Content-Language: en-US
To:     Yuwei Guan <ssawgyw@gmail.com>, jaegeuk@kernel.org
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Yuwei.Guan@zeekrlife.com
References: <20221115063537.59023-1-Yuwei.Guan@zeekrlife.com>
 <20221115063537.59023-4-Yuwei.Guan@zeekrlife.com>
From:   Chao Yu <chao@kernel.org>
In-Reply-To: <20221115063537.59023-4-Yuwei.Guan@zeekrlife.com>
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

On 2022/11/15 14:35, Yuwei Guan wrote:
> Before this patch, the varibale 'readdir_ra' takes effect if it's equal
> to '1' or not, so we can change type for it from 'int' to 'bool'.
> 
> Signed-off-by: Yuwei Guan <Yuwei.Guan@zeekrlife.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,
