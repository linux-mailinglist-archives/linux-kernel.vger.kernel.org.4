Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 993036C8CDA
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Mar 2023 10:00:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232183AbjCYJAm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Mar 2023 05:00:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232160AbjCYJAj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Mar 2023 05:00:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C27651043F;
        Sat, 25 Mar 2023 02:00:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 02E2860B33;
        Sat, 25 Mar 2023 09:00:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67CCBC4339E;
        Sat, 25 Mar 2023 09:00:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679734835;
        bh=diovcYAG+1R8b0IbgR4NHaYY7QnlU6uSK33p80MjVFo=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=dv6kYRGarOcyx33e08lIasDAKmbFx+s4QfdkKro+dmqYtIurepoVqyOD+pmclLLkf
         mlHGDJ+EJOB6LjCmVkvqAOoQu4l38fCbWFwOFtQQ1A3WzP0b9a314KsLgTh19may9Z
         gonLK0gQEiKhrIetVAU+73to1nazzy/2isUBr3Kqq9wIs8+FiAXJv4+yI1ia3YI/bs
         hv9vY36O6tfauBSeWwJ5YfgOv0cbZS2HKESKeyAyHj0SxgykkxvK+ejy4d+Ffo2wTw
         1SWyp0jbRNHnoqNmqU29cFqivCuqjY2hQOTu8WFC/wX0Qeq7SCTxD2p0gAE4yzwW+j
         95KefoM/GEcug==
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-17997ccf711so4232816fac.0;
        Sat, 25 Mar 2023 02:00:35 -0700 (PDT)
X-Gm-Message-State: AAQBX9fdRqZwZeGGIMk7PwqvtxK4CzfrMlq3F6a8+ahr9GLfLvVwonqM
        0cKiT+PYHIajMopAXkl21AieT+3hiPW6TBBtlEQ=
X-Google-Smtp-Source: AKy350YIdakARxKPAwU2yVosvG1zWlJXlgLiYOkr7wpL1yYFS9Powx2f1HT+Kkt3rrIZMEcNq3h7Yxl9wG3yRsvCyMQ=
X-Received: by 2002:a05:6871:440c:b0:16e:8993:9d7c with SMTP id
 nd12-20020a056871440c00b0016e89939d7cmr4103197oab.1.1679734834499; Sat, 25
 Mar 2023 02:00:34 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ac9:5713:0:b0:4c8:b94d:7a80 with HTTP; Sat, 25 Mar 2023
 02:00:34 -0700 (PDT)
In-Reply-To: <20230324173056.2652725-1-trix@redhat.com>
References: <20230324173056.2652725-1-trix@redhat.com>
From:   Namjae Jeon <linkinjeon@kernel.org>
Date:   Sat, 25 Mar 2023 18:00:34 +0900
X-Gmail-Original-Message-ID: <CAKYAXd9gtnrGY_h6PhGLgNaQaaTtbFWZg-37Ny=HMXWXS3GpFA@mail.gmail.com>
Message-ID: <CAKYAXd9gtnrGY_h6PhGLgNaQaaTtbFWZg-37Ny=HMXWXS3GpFA@mail.gmail.com>
Subject: Re: [PATCH] ksmbd: remove unused is_char_allowed function
To:     Tom Rix <trix@redhat.com>
Cc:     sfrench@samba.org, senozhatsky@chromium.org, tom@talpey.com,
        nathan@kernel.org, ndesaulniers@google.com,
        linux-cifs@vger.kernel.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,TVD_SUBJ_WIPE_DEBT autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2023-03-25 2:30 GMT+09:00, Tom Rix <trix@redhat.com>:
> clang with W=1 reports
> fs/ksmbd/unicode.c:122:19: error: unused function
>   'is_char_allowed' [-Werror,-Wunused-function]
> static inline int is_char_allowed(char *ch)
>                   ^
> This function is not used so remove it.
>
> Signed-off-by: Tom Rix <trix@redhat.com>
Acked-by: Namjae Jeon <linkinjeon@kernel.org>

Thanks!
