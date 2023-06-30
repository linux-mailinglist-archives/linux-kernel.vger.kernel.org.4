Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B98C7442FB
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jun 2023 21:55:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232367AbjF3Ty6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jun 2023 15:54:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232180AbjF3Ty4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jun 2023 15:54:56 -0400
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com [IPv6:2607:f8b0:4864:20::b2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11385107
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jun 2023 12:54:55 -0700 (PDT)
Received: by mail-yb1-xb2f.google.com with SMTP id 3f1490d57ef6-bd744ffc263so2220475276.3
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jun 2023 12:54:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1688154893; x=1690746893;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qwJVEajk6sjD7pKhMJ8nLrUS9jcG5+GhwtGSJo7hXhE=;
        b=tMKxA1rvuVOfttdgJoZv6MaLRnwVg8j+/TriQO8mdTDOazSNrNi+WwUi/Gc1aPop/Q
         U5lyBwHF2Pk0gd/bvRv9zHYMvRDFntewjNDT1HtD4ZzrqkZMDoIyRWK/obI/N2yKBfmN
         lJpSYB7jO6SRcGocpniDZqWmTKW4Ztx5SXeoLT60DQcH82IfKlOxlFt7ntLGgi6/3856
         G+2R/94O+RPc8LvSRFH7hymsPvDQbs+sYiTuTBzPR5gMz5VTJN8uhHDfIRGRyGqkPfgv
         3MTlbtcKL+5CdJgViSLzkPHkLbXjOJkwyUUHaNvp2xegLtSvJY8YjXt3PdY9Rk6tm1FK
         nKZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688154893; x=1690746893;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qwJVEajk6sjD7pKhMJ8nLrUS9jcG5+GhwtGSJo7hXhE=;
        b=i9QUkvvNJVLRmkvUAKeaJ+V9+VXAoj1iHtCDtZC6TUm+4V+m2GTLXyUgSUulZS8JEm
         N1Fz5ZkI+UaLl4O3ZylwTfzgMIOMhNZ6EEe4otsWQ1Yb0rDDnZ7JK86JifPYwdPHUCPS
         +BTFhxmm/HE+5VPtm83/k3vpHZIuDlhEDPOhpTNqSRmUDcYtxlF4x/RrRLLelnPjbpQz
         EiERbQs05aMxJYHcAVbn+2IOZH4r+JTBk0KYcYuLCZhJfrHrNnHb6YtqngcQPajtGoUp
         kP8DWvplhUotvDSzDDfsQeGlor2B4tpunJHV+M6R/bdE6VJGVBFWEUKSAFpVjL4il6zi
         Z08Q==
X-Gm-Message-State: ABy/qLYKOuwhyZJ5qFoBkVMRGpOztiMQxqoq4f4KZK8YA6iAF447OEx5
        BAaQz07o+LGT3y5ooiJ+Dr0QLGXjBUr/9lBAKnAUvw==
X-Google-Smtp-Source: APBJJlEQ1nYLUOhJ/Uuqs45GkvzI1ma7uVmZgBTHXjG9xRnpwZWNf4CfnE8yBJ7BW9uSQfZJSO3GHFjEeUi7rjPlsK4=
X-Received: by 2002:a25:add0:0:b0:c01:55d:91d with SMTP id d16-20020a25add0000000b00c01055d091dmr3427876ybe.45.1688154892929;
 Fri, 30 Jun 2023 12:54:52 -0700 (PDT)
MIME-Version: 1.0
References: <20230630162111.3051783-1-jstultz@google.com>
In-Reply-To: <20230630162111.3051783-1-jstultz@google.com>
From:   "T.J. Mercier" <tjmercier@google.com>
Date:   Fri, 30 Jun 2023 12:54:42 -0700
Message-ID: <CABdmKX1qpMTaT=NaG5B+43gaWtoNK=jR5yysKNXMyeyYW10uDQ@mail.gmail.com>
Subject: Re: [PATCH] MAINTAINERS: Remove Laura Abbott from DMA-BUF HEAPS FRAMEWORK
To:     John Stultz <jstultz@google.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Laura Abbott <labbott@kernel.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>,
        Brian Starkey <Brian.Starkey@arm.com>,
        linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linaro-mm-sig@lists.linaro.org, kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 30, 2023 at 9:21=E2=80=AFAM John Stultz <jstultz@google.com> wr=
ote:
>
> Laura's email address has not been valid for quite awhile now,
> so wanted to clean up the reviewer list here.
>
> I reached out to Laura who said it made sense to drop her from
> the list, so this patch does that.
>
> I do want to recognize Laura's long time contribution to this
> area and her previous ION maintainership, as this couldn't
> have gone upstream without her prior efforts. Many thanks!
>
> Cc: Laura Abbott <labbott@kernel.org>
> Cc: T.J. Mercier <tjmercier@google.com>
> Cc: Sumit Semwal <sumit.semwal@linaro.org>
> Cc: Benjamin Gaignard <benjamin.gaignard@collabora.com>
> Cc: Brian Starkey <Brian.Starkey@arm.com>
> Cc: John Stultz <jstultz@google.com>
> Cc: linux-media@vger.kernel.org
> Cc: dri-devel@lists.freedesktop.org
> Cc: linaro-mm-sig@lists.linaro.org
> Cc: kernel-team@android.com
> Acked-by: Laura Abbott <labbott@kernel.org>
> Signed-off-by: John Stultz <jstultz@google.com>

Reviewed-by: T.J. Mercier <tjmercier@google.com>
