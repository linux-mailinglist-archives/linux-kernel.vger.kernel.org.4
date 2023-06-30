Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6255174340F
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jun 2023 07:23:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231961AbjF3FXN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jun 2023 01:23:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231927AbjF3FXJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jun 2023 01:23:09 -0400
Received: from mail-vk1-xa2f.google.com (mail-vk1-xa2f.google.com [IPv6:2607:f8b0:4864:20::a2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 573773A8F;
        Thu, 29 Jun 2023 22:23:01 -0700 (PDT)
Received: by mail-vk1-xa2f.google.com with SMTP id 71dfb90a1353d-47e106c3f56so341150e0c.2;
        Thu, 29 Jun 2023 22:23:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688102580; x=1690694580;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fQnxBPYUz6DhB+HUP9u0D77aRaSd00pdZJoM9Zs3S6k=;
        b=BscLjz0uFmo4B6L/6143bEZfEX1CIeOEdkWBPcIMZxw9FwpFf6YQesSAXq40caQ367
         lLDEMs2aHDjY33UqVA11a2+pFfEbpStqg2br6M9ee0oII2kp7bg9nsnUcneNs/vv8LpC
         222v6HM8Umd95zxRlibLVjL6CWMX0Ib+xp0/XMiSa4SgcgW/cFSh3bmDQ6qhdzKipk3f
         9pwni8V62Yu9UfrLwLCbDgTiZtEMxmmUIbLM8rn6S9r6Xme2DZoWl6YGTqn6pUgbjnTa
         Rz6Ow69XoTWjUVkQaB/K0akR80GAU6psx1jW5uePqq//I0YHD0zGpL8N7V4k07QbZPCD
         4YuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688102580; x=1690694580;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fQnxBPYUz6DhB+HUP9u0D77aRaSd00pdZJoM9Zs3S6k=;
        b=XodcrypqCvaAVMEqQyPYHt7SjORFSe+vldKDm9BUi/05JwAwF4EMungXTsV44seWgf
         KJN0SDpuOh/EC45yXW22QD2qcRVo7FwVGSbYaW9YZL+3V6a4yck9WOd7kgLRYgO6U26+
         /OzeS24p8JBceroNbH9tYb0Qdv+Xd17vbOMBYbT1yMEbglqXoOgIbfD2zVJfZA4NgjHl
         95HT6iVcn1EWtvL0GB86y5sgW3jvzL9rGXaajdMvgDcUR49B0f62jOlKZE2ywQsARKhI
         w498PpuLvEyUZxfaKVEBKnZ0ijN2SRF9arb0bKZI2qTshpjItJaLKXrmG9f+CQDA801w
         k62g==
X-Gm-Message-State: ABy/qLabQWTZLcRKMCBLUcRNZHGKrlSsnurldM87J1s/vJmj+cJ7qKW7
        LMhMGmq4D5y5ik8sC2p1AcwUtWvX6aiiWpcTV0A=
X-Google-Smtp-Source: APBJJlGirnPezZLI3yDm2sPoqL5eUuCqNLCZr3siHQd1iCvZnfFyor+xuxVB0m0jDbiT8asTX5h+2VoaEp3GxzjU/n8=
X-Received: by 2002:a05:6122:145:b0:47e:8a9:478c with SMTP id
 r5-20020a056122014500b0047e08a9478cmr1132557vko.16.1688102579931; Thu, 29 Jun
 2023 22:22:59 -0700 (PDT)
MIME-Version: 1.0
References: <20230629124055.7edf4493@canb.auug.org.au> <CANaxB-z0gLxOU-EVnag=pi3cC164stbOVOMmaGMwNs_g43z9_w@mail.gmail.com>
 <202306282258.219B185B@keescook>
In-Reply-To: <202306282258.219B185B@keescook>
From:   Andrei Vagin <avagin@gmail.com>
Date:   Thu, 29 Jun 2023 22:22:48 -0700
Message-ID: <CANaxB-zEUuyVrYc9akqW_gGdvKJqzYjcc9Y7=nAvSPRxKFwNTA@mail.gmail.com>
Subject: Re: linux-next: build failure after merge of the seccomp tree
To:     Kees Cook <keescook@chromium.org>
Cc:     Andrei Vagin <avagin@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 28, 2023 at 10:58=E2=80=AFPM Kees Cook <keescook@chromium.org> =
wrote:
>
> On Wed, Jun 28, 2023 at 10:27:09PM -0700, Andrei Vagin wrote:
> > Probably something went wrong when the patch was applied. I've checked
> > that the patch contains this file:
> >
> > https://patchew.org/linux/20230308073201.3102738-1-avagin@google.com/20=
230308073201.3102738-7-avagin@google.com/
> >
> > Kees, could you take a look at this?
>
> Hmm, it seems something else went wrong too, due to:
> 616b14b47a86 ("perf build: Conditionally define NDEBUG")
>
> I've added "#undef NDEBUG" to the file too.

I have sent the patch to address this problem:
https://lore.kernel.org/lkml/20230630051953.454638-1-avagin@gmail.com/T/#u

Thanks,
Andrei
