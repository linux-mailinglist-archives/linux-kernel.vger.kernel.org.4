Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF1C56FBA04
	for <lists+linux-kernel@lfdr.de>; Mon,  8 May 2023 23:38:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234265AbjEHViC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 17:38:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234277AbjEHVhp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 17:37:45 -0400
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com [IPv6:2607:f8b0:4864:20::f34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 749F4A5C9;
        Mon,  8 May 2023 14:37:10 -0700 (PDT)
Received: by mail-qv1-xf34.google.com with SMTP id 6a1803df08f44-61b40562054so25451346d6.2;
        Mon, 08 May 2023 14:37:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683581812; x=1686173812;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7JoKtYCVmfcJ2x1PIoAFAsChG5ditRfgwslrman0ALA=;
        b=lx69Viab1Lmo0Ftk62sb4Qz+moXVY618C/g1yTk7sV14vWJlbCqZuzxrsC0iLDldB3
         ODMM/H/Zl+xd4KiOktJlegLR14+L9SzVKkbIfqq4Oc9T7D/oZtU2IQGpm/4ScdHY0w+l
         gkaV0xfXIiLOxaahD/OpRCU0rffYXCHHLM0DZd7T+dBXj7M4xwtqjwEE0bqzgpLbxxLl
         JFUuzz2VepVqkeGRoDo7Zx6Df6LQptmlhmuqUXgV5UDNmhcsYUjYd8M8Ptd05QnFopfh
         KWfPRRUFhzkoboPngOPye04grF5tWqagTT5j2YtKCyAZAPqjJg5ozK3voQ//PU1Jp/H8
         C9qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683581812; x=1686173812;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7JoKtYCVmfcJ2x1PIoAFAsChG5ditRfgwslrman0ALA=;
        b=dL7OUf1hIxdLGmocJOveW+VuCHn/bJ5TWpBHrFIHeCOo/2XQ/hJmwZd6osg44Ru1hr
         d0Z458i5KKpSJdQK+qBgcTGCYtblhMCtDnRG53laYYdaa9Juq+YMp30qdK8rnt3x4fJq
         BFyZeMiVQhI0Wd+oKJM0RBhavT2DpyHhocYS4c99RwS/rHjgVfycXbGY8a5oYXf4c9yg
         XTV7jA3zNkyGTyQl1U1FVO4gKr4dYc0kjJukloYMsyZQIH+uQf1dWvG6w6EDGysFs6Sx
         GffBdZ20A33kpD+MoP5vrCwO1QxRO7O3n/1uNianzXmyso36wcC/CHDiWSYpzg2sKEi9
         kEYw==
X-Gm-Message-State: AC+VfDxa+JqR12AQUciq6lgmhu5ut+D4+kYXh+ztacQwZ9xSLvk0+Djp
        lkJvMmn5uG5y08JJZd2Y9/2rvo3sf1XmETNVNTreqZM1n7F6jQ==
X-Google-Smtp-Source: ACHHUZ77wpBdr1+25Zbh4JN7LtfOWhY8PJbp6BjxSEm3XOH8+DwnoddTK1EXyWe62ef6/48+Q/0h3jbyd2KTmvuEjEA=
X-Received: by 2002:a05:6214:5193:b0:5ef:7d5c:a76c with SMTP id
 kl19-20020a056214519300b005ef7d5ca76cmr17335372qvb.14.1683581812455; Mon, 08
 May 2023 14:36:52 -0700 (PDT)
MIME-Version: 1.0
References: <20230508111953.40f1e57f@canb.auug.org.au>
In-Reply-To: <20230508111953.40f1e57f@canb.auug.org.au>
From:   Nhat Pham <nphamcs@gmail.com>
Date:   Mon, 8 May 2023 14:36:41 -0700
Message-ID: <CAKEwX=MobJWsWZx-3aU0cUBwUnPKDcXzaSAu1vaDntFLGVWNqw@mail.gmail.com>
Subject: Re: linux-next: build warning after merge of the mm tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 7, 2023 at 6:19=E2=80=AFPM Stephen Rothwell <sfr@canb.auug.org.=
au> wrote:
>
> Hi all,
>
> After merging the mm tree, today's linux-next build (powerpc
> ppc64_defconfig) produced this warning:
>
> <stdin>:1567:2: warning: #warning syscall cachestat not implemented [-Wcp=
p]
>
> Introduced by commit
>
>   c36ee88cc47d ("cachestat: implement cachestat syscall")
>
> --
> Cheers,
> Stephen Rothwell

Hi Stephen,

Thanks for the report!
We're having a discussion on this in the following thread:

https://lore.kernel.org/lkml/CAMuHMdWUtb_A-uhXrBg6kC9L2zbC_q3m8oCZoq80ZSJvk=
6mUAA@mail.gmail.com/

Best,
Nhat
