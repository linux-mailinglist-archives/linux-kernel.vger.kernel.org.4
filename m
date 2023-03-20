Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED6E16C2028
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 19:41:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231316AbjCTSln (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 14:41:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231249AbjCTSlT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 14:41:19 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 785A23C790
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 11:33:20 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id c18so13463501ple.11
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 11:33:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1679337196;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:subject:cc:to:from:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=K4mu+bNehauaTgSBwCnPiSfzrVvCzsepaH3d15QbbN4=;
        b=ClQrVslAhJvgqbe8M3xHOKxNgniQIh/uBsT0fWFpMbXdu6MFA1Jpv9xYHkM3UDdd9u
         Q1KcpFDNhByvRzXb6AIGsWNhSajaD0ZFJIvDdVjfFDmky2eS8jQfTixhQBQg+aZpR/E6
         veAKsW9HkLBeX9ZAaVtQ1F3vihHnlFAw3UXa4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679337196;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:subject:cc:to:from:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=K4mu+bNehauaTgSBwCnPiSfzrVvCzsepaH3d15QbbN4=;
        b=HZ9XZ0PCgeWQyVLcuXNuXVM7sKKgR/3UA4S1WOoX6Q1x2uyLpG1eId6N3PWQuJvCPd
         Tcgt9NhY2WfNNZBLA3DjW8I8r1P8YLmfMDzXa7Inbb71GZ+5PQ4vqEFOEouz3iPXNrZO
         2NAb4JIbT8jnrqM4TwJ7iYWkBnfGMiwUH0Yn0d4STOXC021EV0ET339LLLu942dmzphk
         0kacp8pD57VlNwLM4mpgombqNn8YJAoR3JE1NrIoRzDZ2Bz53rhhiUuQSIPFM0gerHJ9
         W7UPH065HpBl+QDaNYEt/NkWbfFGHwUhzwKIG7W7LHnF5SAMHQkuKtz/SqAvT6041KkA
         +9Nw==
X-Gm-Message-State: AO0yUKVxoCBQl2Cgr0+0Kdu+1ckRFhXybH5w4ynWlQ1nwedMoTeRzaMn
        s00lmRuk5yVrMWoy63QMgCG6Lg==
X-Google-Smtp-Source: AK7set/pnmLIeD8BRH/9kRDtin7NNNPBnPbucuL8sJUzMrogrV26aMT63BiNpaTx4nZIFu8i2QAeRw==
X-Received: by 2002:a05:6a20:4c84:b0:cd:ed5c:513 with SMTP id fq4-20020a056a204c8400b000cded5c0513mr303189pzb.31.1679337196653;
        Mon, 20 Mar 2023 11:33:16 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id k2-20020aa792c2000000b006089fb79f1asm6608990pfa.208.2023.03.20.11.33.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Mar 2023 11:33:16 -0700 (PDT)
Message-ID: <6418a6ec.a70a0220.1f3d7.afc4@mx.google.com>
X-Google-Original-Message-ID: <202303201133.@keescook>
Date:   Mon, 20 Mar 2023 11:33:15 -0700
From:   Kees Cook <keescook@chromium.org>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     Bodo Stroesser <bostroesser@gmail.com>, linux-scsi@vger.kernel.org,
        target-devel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH][next] uapi: target: Replace fake flex-array with
 flexible-array member
References: <ZBSchMvTdl7VObKI@work>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZBSchMvTdl7VObKI@work>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 17, 2023 at 10:59:48AM -0600, Gustavo A. R. Silva wrote:
> Zero-length arrays as fake flexible arrays are deprecated and we are
> moving towards adopting C99 flexible-array members instead.
> 
> Address the following warning found with GCC-13 and
> -fstrict-flex-arrays=3 enabled:
>   CC      drivers/target/target_core_user.o
> drivers/target/target_core_user.c: In function ‘queue_cmd_ring’:
> drivers/target/target_core_user.c:1096:15: warning: array subscript 0 is outside array bounds of ‘struct iovec[0]’ [-Warray-bounds=]
>  1096 |         iov = &entry->req.iov[0];
>       |               ^~~~~~~~~~~~~~~~~~
> In file included from drivers/target/target_core_user.c:31:
> ./include/uapi/linux/target_core_user.h:122:38: note: while referencing ‘iov’
>   122 |                         struct iovec iov[0];
>       |                                      ^~~
> 
> This helps with the ongoing efforts to tighten the FORTIFY_SOURCE
> routines on memcpy() and help us make progress towards globally
> enabling -fstrict-flex-arrays=3 [1].
> 
> Link: https://github.com/KSPP/linux/issues/21
> Link: https://github.com/KSPP/linux/issues/270
> Link: https://gcc.gnu.org/pipermail/gcc-patches/2022-October/602902.html [1]
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
