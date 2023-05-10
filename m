Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2B1C6FDE19
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 14:48:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236019AbjEJMss (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 08:48:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236697AbjEJMsm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 08:48:42 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2F4C30D4
        for <linux-kernel@vger.kernel.org>; Wed, 10 May 2023 05:48:41 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id 41be03b00d2f7-524db748169so1081613a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 10 May 2023 05:48:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20221208.gappssmtp.com; s=20221208; t=1683722921; x=1686314921;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+xXs0HtZHqu7tTCcsx3Q063YwdD+crlfQPAG+dHyu10=;
        b=UYUfSSBX3QGHV109YPLRewZmojsppjLaECSLSMqY7GGwscu/5VGGLgk8UjRYh7xAqK
         lZMp4nx15R2WWgpNkQWOTPDmAAOIlxiSyp7V5TUAGgaGiJh3iSJPTg/e+UI5Xn8D1vlY
         mJFQ2Fo+D3AiSaUb/NDmJGcJObolShzfJ0lOSgzbS+JCF+PeXHHIU5OUuEDVQKSDBSCU
         wg6Zh9p4ZruY1266EgHZRyWvuZMMjieD6LWUlqqRozk23LXAMeN+S7P9k14VAtLeoec5
         6RZRemknUaZu23oWQizu0qqTiZ4tX0JGyxNZUalzsYh4FSLgLk4vx/6lLHWUyJxVLVnN
         I4Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683722921; x=1686314921;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+xXs0HtZHqu7tTCcsx3Q063YwdD+crlfQPAG+dHyu10=;
        b=fxHIfmk5lQvnGzCgAWFFlzbiYKoIXYpXT6CIgcYBaVuRLAknT5Tn0mxF1jd31CqNml
         KdNW+f/7qmoKLmVl8GOrCtx2ZqCGh620IMfLo1uQ6ziTXhVVy0kvCAzasLEMHraeqjNJ
         4nLHp76BvDL8xo200+RdSyuyDdV2pAqHb2JDH52uIWoI4R5A3h8U/Xk+hF2Y76eZU5ZD
         Uuho4vq0zR86SgLy5RkHdrald9x5IhZZYW1yobvTkuMyuaV+cECJxtP6e4v4YEtKJrgK
         8iJzzZ5VgPCZYoZwHIG8ERR8JZDn+Yq3dOUY2iH35bmLTGYGLa/T3bYxQ9rLmRXYPfCO
         BzsQ==
X-Gm-Message-State: AC+VfDy4O9TIZ1BbQO5BpAaTNyGxuTohLyb+EQpXiPWmMNgAR4iGu+dV
        yMRqjR4WqHx8vSS6SN7C7b7YSOZ1EC/Uc4/B+1I=
X-Google-Smtp-Source: ACHHUZ4n3g3YZxN0Xv7bR5yHrpV7ihLYfxnP5uvoiaDzQnxPHkCez/Nuf+FvSmaVFBxDA9uCtbv4Bw==
X-Received: by 2002:a17:90b:1b0c:b0:250:d8e1:d326 with SMTP id nu12-20020a17090b1b0c00b00250d8e1d326mr1648076pjb.0.1683722921167;
        Wed, 10 May 2023 05:48:41 -0700 (PDT)
Received: from [192.168.1.136] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id om8-20020a17090b3a8800b002471deb13fcsm13697933pjb.6.2023.05.10.05.48.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 May 2023 05:48:40 -0700 (PDT)
Message-ID: <b5c0b1b9-9896-2637-458b-ca1003ba7d74@kernel.dk>
Date:   Wed, 10 May 2023 06:48:39 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: linux-next: manual merge of the block tree with the vfs-idmapping
 tree
Content-Language: en-US
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Christian Brauner <christian@brauner.io>,
        Seth Forshee <sforshee@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
References: <20230510105543.165f102b@canb.auug.org.au>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20230510105543.165f102b@canb.auug.org.au>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/9/23 6:55 PM, Stephen Rothwell wrote:
> Hi all,
> 
> Today's linux-next merge of the block tree got a conflict in:
> 
>   fs/pipe.c
> 
> between commit:
> 
>   2b10649c2316 ("pipe: enable handling of IOCB_NOWAIT")
> 
> from the vfs-idmapping tree and commit:
> 
>   3f6ded8dd89d ("pipe: check for IOCB_NOWAIT alongside O_NONBLOCK")
> 
> from the block tree.
> 
> The former added
> 
> 	const bool nonblock = iocb->ki_flags & IOCB_NOWAIT;
> 
> and then did
> 
> -		if (filp->f_flags & O_NONBLOCK) {
> +		if (filp->f_flags & O_NONBLOCK || nonblock) {
> 
> while the latter just did
> 
> -		if (filp->f_flags & O_NONBLOCK) {
> +		if (filp->f_flags & O_NONBLOCK || iocb->ki_flags & IOCB_NOWAIT) {
> 
> so I just used the former though I suspect that the former may be a
> previous version of these changes?).
> 
> I fixed it up (see above) and can carry the fix as necessary. This
> is now fixed as far as linux-next is concerned, but any non trivial
> conflicts should be mentioned to your upstream maintainer when your tree
> is submitted for merging.  You may also want to consider cooperating
> with the maintainer of the conflicting tree to minimise any particularly
> complex conflicts.

Yes, since Linus didn't like the original approach, it was redone
and that particular patch was originally forgotten and then redone
without the 'nonblock' variable. So you should just ignore the
old version, and Christian should just drop that branch from his
for-next tree as it's dead.

-- 
Jens Axboe


