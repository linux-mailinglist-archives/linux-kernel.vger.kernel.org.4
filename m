Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71A1E711199
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 19:04:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239475AbjEYREB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 13:04:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231451AbjEYRD7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 13:03:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 076D1189;
        Thu, 25 May 2023 10:03:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 78D1B61489;
        Thu, 25 May 2023 17:03:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD71EC433EF;
        Thu, 25 May 2023 17:03:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685034237;
        bh=TPlPKAj0p+zEqi9z0wS9kwH6FfheU3xhHZLDGA9HSMI=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=WulJw5conWhP1Dnf+r2lYH3dRz1hcS/L7rpxgSyv16nh8X3+iYKTxP70dPDmOzojR
         2GHX+1oVGYrIqKu1JFz07eKVxqPse+fqem4POSGVurzyMgcY0j8RhH/0utl01k7WDb
         +aSbKnhEELRwjJ7lOHvMHLjzthAUb17SjlVzSpLb1bpXx1oz7hE0/bB3Ty98OecFjP
         n4arCtcvZhXXxTtroxeDwI0jZBK36e3cBOUSzo/QnU/CJ8LAE08EG0vCmB/eSfFYUs
         OYzfPvUabl9HwQrJesUFxJZXqu8A5p26immo0He1XiaVrxx38rTxnCu7BNUzAotaa3
         8QqrRnsqcE1yw==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH][next] wifi: wil6210: wmi: Replace zero-length array with
 DECLARE_FLEX_ARRAY() helper
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <ZGKHM+MWFsuqzTjm@work>
References: <ZGKHM+MWFsuqzTjm@work>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        linux-hardening@vger.kernel.org
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <168503423402.19957.8400109691029717015.kvalo@kernel.org>
Date:   Thu, 25 May 2023 17:03:55 +0000 (UTC)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"Gustavo A. R. Silva" <gustavoars@kernel.org> wrote:

> Zero-length arrays are deprecated, and we are moving towards adopting
> C99 flexible-array members, instead. So, replace zero-length arrays
> declarations alone in structs with the new DECLARE_FLEX_ARRAY()
> helper macro.
> 
> This helper allows for flexible-array members alone in structs.
> 
> Link: https://github.com/KSPP/linux/issues/193
> Link: https://github.com/KSPP/linux/issues/288
> Link: https://gcc.gnu.org/onlinedocs/gcc/Zero-Length.html
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> Reviewed-by: Simon Horman <simon.horman@corigine.com>
> Reviewed-by: Kees Cook <keescook@chromium.org>
> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>

Patch applied to ath-next branch of ath.git, thanks.

27044b57f8a5 wifi: wil6210: wmi: Replace zero-length array with DECLARE_FLEX_ARRAY() helper

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/ZGKHM+MWFsuqzTjm@work/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

