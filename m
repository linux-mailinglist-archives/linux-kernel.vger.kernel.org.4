Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 800CD5E541F
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Sep 2022 22:04:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230103AbiIUUER (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Sep 2022 16:04:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229745AbiIUUEP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Sep 2022 16:04:15 -0400
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BE6D86898;
        Wed, 21 Sep 2022 13:04:14 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:281:8300:73::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id E5BB82B0;
        Wed, 21 Sep 2022 20:04:13 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net E5BB82B0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1663790654; bh=ZXfnpjWDlX3KQSHO3WoZdVME2upfsgqm8E4qpRArojY=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=tJs+BGuJCnJXpNsSB2i5gyyBgxtCCmNKEiIm2nr+F1baBdHtTGHTtVdibZFRUtWci
         xRlHfSen+QITXpoHL1/hM9FHOuLkTYpLi1GHOu5pvNWYRZNdl2gispqXOUJ9qXAO/f
         ju4z6os/qNHDYFFJn+pkSH+rY/wPVLZJxn0gJnQy4H0MywTA5+F4WYewv68/sSRs8B
         8pTcDdF+Vy3UGDW632QaGiPsqhpFsDAtcvTfS0EyawqXDXOgQg7M6tsYQz1JaUXEGz
         s8LCjppyMDEOMKZHrhCDoIIdOLP6Zok9kswIB5fjRNO7UaiNy7el7JkDVc0pku3Mwz
         3qkkIYnx5jjdQ==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Shuah Khan <skhan@linuxfoundation.org>, gregkh@linuxfoundation.org
Cc:     Shuah Khan <skhan@linuxfoundation.org>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, joanna.lee@gesmer.com
Subject: Re: [PATCH] docs: update mediator information in CoC docs
In-Reply-To: <20220901212319.56644-1-skhan@linuxfoundation.org>
References: <20220901212319.56644-1-skhan@linuxfoundation.org>
Date:   Wed, 21 Sep 2022 14:04:13 -0600
Message-ID: <87tu50v6iq.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Shuah Khan <skhan@linuxfoundation.org> writes:

> Update mediator information in the CoC interpretation document.
>
> Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>
> ---
>  Documentation/process/code-of-conduct-interpretation.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/Documentation/process/code-of-conduct-interpretation.rst b/Documentation/process/code-of-conduct-interpretation.rst
> index e899f14a4ba2..4f8a06b00f60 100644
> --- a/Documentation/process/code-of-conduct-interpretation.rst
> +++ b/Documentation/process/code-of-conduct-interpretation.rst
> @@ -51,7 +51,7 @@ the Technical Advisory Board (TAB) or other maintainers if you're
>  uncertain how to handle situations that come up.  It will not be
>  considered a violation report unless you want it to be.  If you are
>  uncertain about approaching the TAB or any other maintainers, please
> -reach out to our conflict mediator, Mishi Choudhary <mishi@linux.com>.
> +reach out to our conflict mediator, Joanna Lee <joanna.lee@gesmer.com>.
>  
>  In the end, "be kind to each other" is really what the end goal is for
>  everybody.  We know everyone is human and we all fail at times, but the

Applied (finally), thanks.

I stuck a Cc: stable on there, it seems this should be updated in all of
the distributed kernels.

Thanks,

jon
