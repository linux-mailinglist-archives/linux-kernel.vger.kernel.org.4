Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6EF9611F7D
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Oct 2022 04:56:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229846AbiJ2C4e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 22:56:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229841AbiJ2C4b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 22:56:31 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 204821B2B8F
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 19:55:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C36A4B82E01
        for <linux-kernel@vger.kernel.org>; Sat, 29 Oct 2022 02:55:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 138A5C433D7;
        Sat, 29 Oct 2022 02:55:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667012140;
        bh=RxC13kMBfY3jA/I0va0EdOxfffvxi/dwXbNjcthKyJ4=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=a54Y++6FDUWWZJ7OppKBOT52neHOOlEhvVMmyL/H5nH2sWCp0XP8Yu54HZ7aa8l2b
         BK6V8MJmGr3Y8mz329xlhGTRO72da/r8N95iRMXJqy6B9e9K9FBiundZ1ZFyvysxv0
         zAN9jmBaCf5NcyDlegGD5ujLd4+NGAss37W4amgeqWMIEvQgQOqWfxsLV5K9Uk0F5v
         dw9cfCfHoLpgdNqAN3x22kJBPDQL0t8ZJLuhLgBzpo1SzveIv3/cBoQhMD8zU1UYdP
         TT2v/f4AuEP7Csy75UoCR1DgpeeckYRxx1Yso7uxbs08TNi6Q4vxkO/xHGKrKxoVHo
         FhcnIVe5IyfJA==
Message-ID: <4de69c67-b18f-0b1e-6a55-642120e8c675@kernel.org>
Date:   Sat, 29 Oct 2022 10:55:39 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH 2/2] f2fs: fix the msg data type
Content-Language: en-US
To:     Mukesh Ojha <quic_mojha@quicinc.com>, jaegeuk@kernel.org,
        mhiramat@kernel.org
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, quic_pkondeti@quicinc.com
References: <1666861961-12924-1-git-send-email-quic_mojha@quicinc.com>
 <1666861961-12924-2-git-send-email-quic_mojha@quicinc.com>
From:   Chao Yu <chao@kernel.org>
In-Reply-To: <1666861961-12924-2-git-send-email-quic_mojha@quicinc.com>
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

On 2022/10/27 17:12, Mukesh Ojha wrote:
> Data type of msg in f2fs_write_checkpoint trace should
> be const char * instead of char *.
> 
> Signed-off-by: Mukesh Ojha <quic_mojha@quicinc.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,
