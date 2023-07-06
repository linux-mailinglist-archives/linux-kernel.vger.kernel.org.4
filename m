Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44BCF74A164
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jul 2023 17:48:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232351AbjGFPsU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jul 2023 11:48:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232688AbjGFPry (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jul 2023 11:47:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A06E61BFD
        for <linux-kernel@vger.kernel.org>; Thu,  6 Jul 2023 08:47:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EEADA60C1C
        for <linux-kernel@vger.kernel.org>; Thu,  6 Jul 2023 15:47:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 084B9C433C7;
        Thu,  6 Jul 2023 15:47:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688658450;
        bh=v4jGue9yUrQ15tRNs2k8or9Xz/JXP8QjRvYexu2gh3g=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=cFdOdI+kDlrfz/u27anBotvHcs3HvvpJyWKTZrGLgDFCUYqTdzogEV4KANa0HzJxI
         TZAzvr6KaGMHjFQEePPFmjEkdRJWwqLyK75eE11Qalmed0owGp6y+QhwydY0q8rVDy
         fb2mFsjWnJO6KvPATLz52ZMS64RtIMzg+shlHJL+nPzklP+E1+P67AkBqANJDOxmwG
         bwhwCszL+cMyIY2gR9bjJDyikYzzoe/gJAYHMlphy1kzM20R5UQ8NZthwagJen3k0r
         6sZ0s4nL9fCu4pat0y63mtoC5dkHD9FS6ZdUNNJE9OevRJDkP4Ta531rDUjNfU6cBb
         YYLIPgqE+VUdA==
Date:   Thu, 6 Jul 2023 08:47:29 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Wang Ming <machel@vivo.com>
Cc:     Jon Maloy <jmaloy@redhat.com>, Ying Xue <ying.xue@windriver.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
        tipc-discussion@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, opensource.kernel@vivo.com
Subject: Re: [PATCH v1] net:tipc:Remove repeated initialization
Message-ID: <20230706084729.12ed5725@kernel.org>
In-Reply-To: <20230706134226.9119-1-machel@vivo.com>
References: <20230706134226.9119-1-machel@vivo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu,  6 Jul 2023 21:42:09 +0800 Wang Ming wrote:
> The original code initializes 'tmp' twice,
> which causes duplicate initialization issue.
> To fix this, we remove the second initialization
> of 'tmp' and use 'parent' directly forsubsequent
> operations.
> 
> Signed-off-by: Wang Ming <machel@vivo.com>

Please stop sending the "remove repeated initialization" patches 
to networking, thanks.
