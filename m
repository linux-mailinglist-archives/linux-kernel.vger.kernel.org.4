Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4499B6591EA
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Dec 2022 22:02:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233994AbiL2VCD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Dec 2022 16:02:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229773AbiL2VB6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Dec 2022 16:01:58 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1735714085;
        Thu, 29 Dec 2022 13:01:57 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B19A96182E;
        Thu, 29 Dec 2022 21:01:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFCDCC433EF;
        Thu, 29 Dec 2022 21:01:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672347716;
        bh=aBwFnT250YVU/jh6JU0/iuLAGehjoULmLrg4gYVFCg8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Be9OZMULOY03UyOCYTmjr/JfxPAKDMY4qE7rMCbB8pBvmA/KX8sGtxWQI1RBsW30J
         oV/sSPfJcoG1cSDtwpYrDbz998RjvV/J3kxYirAzpcBZJHpT6fIadvCx++xaRZRg6b
         qiXToTcL0+eo2qcz9zxqy8c6CFPVMT9QRGIcF5wRg9XOOS5pJywEmnRWrEbvVn2G3g
         YyQUYgu/JhYTS+RlSHVzQBhz3NyxBJFz1gahbvjJnI+SMB4syoZL1zaUtPUh9xwAFr
         uDaakvT7ORyh/LpxqcQcSVES6J0CiuunSXkp6gODvCi+Zv9OQ5D8ruLAP39wYYHCJC
         BaNBAxe4onMpA==
Date:   Thu, 29 Dec 2022 13:01:54 -0800
From:   Eric Biggers <ebiggers@kernel.org>
To:     Vladis Dronov <vdronov@redhat.com>
Cc:     Herbert Xu <herbert@gondor.apana.org.au>,
        "David S . Miller" <davem@davemloft.net>,
        Nicolai Stange <nstange@suse.de>,
        Elliott Robert <elliott@hpe.com>,
        Stephan Mueller <smueller@chronox.de>,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 6/6] crypto: testmgr - allow ecdsa-nist-p256 and -p384
 in FIPS mode
Message-ID: <Y64AQg+W0SGsYUDY@sol.localdomain>
References: <20221229203708.13628-1-vdronov@redhat.com>
 <20221229203708.13628-7-vdronov@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221229203708.13628-7-vdronov@redhat.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 29, 2022 at 09:37:08PM +0100, Vladis Dronov wrote:
> From: Nicolai Stange <nstange@suse.de>
> 
> The kernel provides implementations of the NIST ECDSA signature
> verification primitives. For key sizes of 256 and 384 bits respectively
> they are approved and can be enabled in FIPS mode. Do so.
> 
> Signed-off-by: Nicolai Stange <nstange@suse.de>
> Signed-off-by: Vladis Dronov <vdronov@redhat.com>
> Reviewed-by: Eric Biggers <ebiggers@google.com>

Please don't add my Reviewed-by to patches I didn't review.  I only gave
Reviewed-by on "[PATCH 2/6] crypto: xts - drop xts_check_key()".  I didn't look
at the other patches in the series much, as I'm not very interested in them.

- Eric
