Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0240B7154BE
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 07:10:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229673AbjE3FKi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 01:10:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbjE3FKe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 01:10:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACF8FEA;
        Mon, 29 May 2023 22:10:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2C5E661F75;
        Tue, 30 May 2023 05:10:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 409D0C433EF;
        Tue, 30 May 2023 05:10:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685423432;
        bh=YIE1jbD6qv3fPbOdGRC2Fp/dwDArDOqdaDS7Knw2oEM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=YaSau9Vf5FlS/qU3sIjys5dBZWiD2xUDdbIHlcu5uNNUGQx/D7posF7krJ9Ywdnnw
         XAJI+ITfzO6e81D7LwdtaW1mtNENDPOE1GUcT4RNgw8wjie4hM4rvJa+TlKWLmkMiX
         oFbuM0fyN1pCzBwT/TpRwkEm+7Y7YdpwdM9d2s8v3Gluck+wDnjXT1r+qVjR6dm4XC
         m0Yx5ibajYwkFdjzl1mKuIsK8ubutsnVZkU0xHpdboJVj9PuK/rizn2SfbzNYInTPp
         RteUsuAuSr0zE9tV+AUcot1L+TK3wc/rATEczd/mi0VRBw1xyvSkSQQiZdzI6UsCR0
         5ycShPv0VK5iw==
Date:   Mon, 29 May 2023 22:10:31 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Bert Karwatzki <spasswolf@web.de>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>, elder@linaro.org,
        netdev@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] net: ipa: Use the correct value for IPA_STATUS_SIZE
Message-ID: <20230529221031.1a0a1a75@kernel.org>
In-Reply-To: <7ae8af63b1254ab51d45c870e7942f0e3dc15b1e.camel@web.de>
References: <7ae8af63b1254ab51d45c870e7942f0e3dc15b1e.camel@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 27 May 2023 22:46:25 +0200 Bert Karwatzki wrote:
> commit b8dc7d0eea5a7709bb534f1b3ca70d2d7de0b42c introduced
> IPA_STATUS_SIZE as a replacement for the size of the removed struct
> ipa_status. sizeof(struct ipa_status) was sizeof(__le32[8]), use this
> as IPA_STATUS_SIZE.
> 
> From 0623148733819bb5d3648b1ed404d57c8b6b31d8 Mon Sep 17 00:00:00 2001
> From: Bert Karwatzki <spasswolf@web.de>
> Date: Sat, 27 May 2023 22:16:52 +0200
> Subject: [PATCH] Use the correct value for IPA_STATUS_SIZE.
> IPA_STATUS_SIZE
>  was introduced in commit b8dc7d0eea5a7709bb534f1b3ca70d2d7de0b42c as a
>  replacment for the size of the removed struct ipa_status which had
> size =
>  sizeof(__le32[8]).

The posting looks damage, could you try sending again (with git
send-email maybe?)

Before you do:
 - please make sure the change applies to:
https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git/
 - add a correct fixes tag
 - fix issues pointed out by checkpatch --strict
-- 
pw-bot: cr
