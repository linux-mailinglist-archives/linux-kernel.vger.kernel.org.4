Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58ECB7110A1
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 18:14:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235690AbjEYQOj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 12:14:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234629AbjEYQOf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 12:14:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83724197;
        Thu, 25 May 2023 09:14:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2026A60B01;
        Thu, 25 May 2023 16:14:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2EFA0C433EF;
        Thu, 25 May 2023 16:14:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685031267;
        bh=Pay7zXnTH9PqGCRlQFGcYsvLrrwOtY59XBAuD/yITWU=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=naCMRFK9mnn8k6imfaNYQMAKxQFyo8rKPsRbQAN7KLviL6Yf9aFbHRNPEGgdP2U0T
         gFTQV2tLgHX+vretzWvrMLHmHdGxsFgsSDcVj07SC/lNx9Fw8m2rL4/g1aZ22c8FKt
         Znuul1BYYXbHcKaiAG8OiBdnAT+vfmgrkJqJyRR4fXQJ1ZnQYL6FjKxmy/LcgNAmG1
         RYEtK9WGylhwn6sjVIon+J8JCGjyjP8/KonStqTzYuK9FaDytS6ORarYzoxxRu91bc
         5usAHu2uZ7oOAMVg4cKez5pneUX8vNAD5VDFq3RhqhlJGnZUVMbafnE9wmbmqlTG80
         iRavCo7+LBZqA==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: wifi: rtw89: use flexible array member in rtw89_btc_btf_tlv
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20230523113241.2772811-1-arnd@kernel.org>
References: <20230523113241.2772811-1-arnd@kernel.org>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Ping-Ke Shih <pkshih@realtek.com>, Arnd Bergmann <arnd@arndb.de>,
        Ching-Te Ku <ku920601@realtek.com>,
        linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <168503126425.22756.6147214283956787608.kvalo@kernel.org>
Date:   Thu, 25 May 2023 16:14:25 +0000 (UTC)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Arnd Bergmann <arnd@kernel.org> wrote:

> From: Arnd Bergmann <arnd@arndb.de>
> 
> struct rtw89_btc_btf_tlv contains a one-byte member that is intended as a
> flexible array:
> 
> In function 'fortify_memcpy_chk',
>     inlined from '_append_tdma' at drivers/net/wireless/realtek/rtw89/coex.c:1579:3:
> include/linux/fortify-string.h:583:25: error: call to '__write_overflow_field' declared with attribute warning: detected write beyond size of field (1st parameter); maybe use struct_group()? [-Werror=attribute-warning]
>   583 |                         __write_overflow_field(p_size_field, size);
>       |                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> 
> Make this actually use a flexible array to let the compiler understand.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Reviewed-by: Ping-Ke Shih <pkshih@realtek.com>
> Reviewed-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Patch applied to wireless-next.git, thanks.

47e612268ea0 wifi: rtw89: use flexible array member in rtw89_btc_btf_tlv

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20230523113241.2772811-1-arnd@kernel.org/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

