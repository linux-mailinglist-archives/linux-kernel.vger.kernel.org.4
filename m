Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C101623A5E
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 04:25:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232504AbiKJDZh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 22:25:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232450AbiKJDZf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 22:25:35 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5693A186EC;
        Wed,  9 Nov 2022 19:25:35 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EB6FD61D49;
        Thu, 10 Nov 2022 03:25:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D63E7C433D6;
        Thu, 10 Nov 2022 03:25:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668050734;
        bh=Fe/+mlw2GT+auwCFctSRJ7rue+T//tu/7QyWdoqsU8k=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=KgrTMmT5DEZa/jSJwgo+OVcuSILF5cfiijOXmDVGMDA1WO3rHKOnz5jwqDET9eNpr
         Y6JtDJqxvImb7YdMZUAsW82fU2kX/Mt/A1eBzWedX5UQFshq53ZG3JtHT2zYo1cRXl
         789WMm0knTN70viC3oAOvVwLeYky/Y2PwkHrsBrb103lBxQKLu4DAuXTKJ35l3EowW
         VJotD+gTEwCKVTYu/F6Iny/9ipAJ1yE04wPul68x7Z/70YxrUBxhr8JLmwY4inTwOq
         gxbWIeWWwBVoPvqK3IO/0+ifmQEYwwM8YofVP2v7omtVINI1FF85a4G+EIPJhuZVY0
         4noYnll4H+12g==
Date:   Wed, 9 Nov 2022 19:25:32 -0800
From:   Jakub Kicinski <kuba@kernel.org>
To:     Xiu Jianfeng <xiujianfeng@huawei.com>
Cc:     <kvalo@kernel.org>, <davem@davemloft.net>, <edumazet@google.com>,
        <pabeni@redhat.com>, <rmani@qti.qualcomm.com>,
        <ath10k@lists.infradead.org>, <linux-wireless@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] wifi: ath10k: Fix return value in ath10k_pci_init()
Message-ID: <20221109192532.259e4af3@kernel.org>
In-Reply-To: <20221110031228.247361-1-xiujianfeng@huawei.com>
References: <20221110031228.247361-1-xiujianfeng@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 10 Nov 2022 11:12:28 +0800 Xiu Jianfeng wrote:
> To: <kvalo@kernel.org>, <davem@davemloft.net>, <edumazet@google.com>,  <kuba@kernel.org>, <pabeni@redhat.com>, <rmani@qti.qualcomm.com>
> CC: <ath10k@lists.infradead.org>, <linux-wireless@vger.kernel.org>,  <linux-kernel@vger.kernel.org>

How did you come up with this CC list? If you're CCing netdev
maintainers you should also CC netdev@vger.kernel.org 
Somehow you managed to CC LMKL but not netdev :S
