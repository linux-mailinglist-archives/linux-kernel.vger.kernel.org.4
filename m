Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3AFB25B5969
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Sep 2022 13:39:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229790AbiILLjr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Sep 2022 07:39:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229610AbiILLjm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Sep 2022 07:39:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EC385F70;
        Mon, 12 Sep 2022 04:39:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0C3B3611D1;
        Mon, 12 Sep 2022 11:39:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 209FBC433D6;
        Mon, 12 Sep 2022 11:39:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662982780;
        bh=YVloGXKhM56QYWGpSw8QQeiGROxDfWLZpZwICrSsIAg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=t0Se/KfGFqagOtYwm/o8hI1IqCbIl8HIsFfaIcXFAAmOj2/jzd5gb80aGjnQ1+Ch9
         bYo9U682DtubhmpfMjJuJvAlhlHrXao1P+/5cB3zUueTH4kjOSLAEYY97T5l/iSKNx
         Em86vqrhfi9xbp7PKIzu7s1HQ27iMvHd2L5FlPEvjDFNCIyw1EkS4LtisBBfOYw7S6
         TATuCivyicc9JayzxW9bpAhD1k/yscBifcczfr7n0OkGcVTcuBfjIIgNXBsC6p5JxZ
         RkKISEQh5Qk1Irbfa2PRGX4GBkSTXenmWSZQc4j0yuhy40sD+y7vE/yxY+KTC8TCeg
         ayO5yvVQHk5TQ==
Date:   Mon, 12 Sep 2022 14:39:32 +0300
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Gaosheng Cui <cuigaosheng1@huawei.com>
Cc:     dhowells@redhat.com, paul@paul-moore.com, jmorris@namei.org,
        serge@hallyn.com, keyrings@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] security/keys: remove request_key_conswq and
 keyring_search_instkey() declarations
Message-ID: <Yx8adIc2FC0jdJuM@kernel.org>
References: <20220909060452.1121620-1-cuigaosheng1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220909060452.1121620-1-cuigaosheng1@huawei.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"KEYS: Remove orphan declarations from security/keys/internal.h"

On Fri, Sep 09, 2022 at 02:04:52PM +0800, Gaosheng Cui wrote:
> request_key_conswq has been removed since
> commit 76181c134f87 ("KEYS: Make request_key() and co fundamentally
> asynchronous").
> 
> keyring_search_instkey() has been removed since
> commit b5f545c880a2 ("[PATCH] keys: Permit running process to
> instantiate keys").
> 
> so remove the declare for them from header file.
> 
> Signed-off-by: Gaosheng Cui <cuigaosheng1@huawei.com>

"
Remove the following orphan declarations from security/keys/internal.h:

1. request_key_conswq()
2. keyring_search_instkey()
"

Then add two fixes tags after that.

BR, Jarkko

