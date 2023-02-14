Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 033756955F5
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 02:29:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230290AbjBNB3T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 20:29:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229558AbjBNB3S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 20:29:18 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C07CECA16
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 17:29:17 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 728F3B81A2E
        for <linux-kernel@vger.kernel.org>; Tue, 14 Feb 2023 01:29:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F025BC433D2;
        Tue, 14 Feb 2023 01:29:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676338155;
        bh=4J95gcSM78Uk8dxMmBWbi4MqR7QMskw4R1zDgItsne4=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=jXu18eo8ZqciyaJj1xX7hikHszPjmHuZMXhzyTw7DD/fMEbI30tXMssU5EpsgSuzH
         CB5E9jU5TAdeMNCfBkFWJCnKQU2cOmrMlS8NwXhWsQ/xeQY42jttXOFlP6PUtykVbV
         a+zIAu3m1AJloxVzSeV5UqqNntA+0FOyXtOy4F1i+/OqNtMA/QrOrMraJi6iyvay4i
         mh1ZvYg/0Ot3+r4Q1xG6dNuW1WAHUR+bYTJfxJyVmtu+o5vTe+32trmxkNHcR8Z2wX
         kNctWwbA6CYWo03/ro3aSDDqNZtqbbsaxqlP4mjNkcgYg3YC7Zdaxs8NnmSIlKCujx
         Qz2maw1ss7YHQ==
Message-ID: <5fca2ac9-91d6-6a56-5817-ab54d7bcba90@kernel.org>
Date:   Tue, 14 Feb 2023 09:29:12 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.2
Subject: Re: [PATCH v3 2/2] f2fs: replace si->sbi w/ sbi in stat_show()
Content-Language: en-US
To:     Yangtao Li <frank.li@vivo.com>, jaegeuk@kernel.org
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
References: <20230213141825.22858-1-frank.li@vivo.com>
 <20230213141825.22858-2-frank.li@vivo.com>
From:   Chao Yu <chao@kernel.org>
In-Reply-To: <20230213141825.22858-2-frank.li@vivo.com>
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

On 2023/2/13 22:18, Yangtao Li wrote:
> For each loop add a local f2fs_sb_info pointer insted of looking it up.
> 
> Signed-off-by: Yangtao Li <frank.li@vivo.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,
