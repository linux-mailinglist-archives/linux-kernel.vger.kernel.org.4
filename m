Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF5A76DC52F
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Apr 2023 11:38:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229725AbjDJJiq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Apr 2023 05:38:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229585AbjDJJio (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Apr 2023 05:38:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CE5C2D58;
        Mon, 10 Apr 2023 02:38:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 25D1561A18;
        Mon, 10 Apr 2023 09:38:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 864CAC4339B;
        Mon, 10 Apr 2023 09:38:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681119522;
        bh=qlSY3C4ywF9Gj/r7+eIroa9G/QmBWQuSA1VpiVe+Gs4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=mgnTPPa8eVeZLpCWnQDwwrBlZwmwPW2Acl76oKIreHo3WYbkWjo1yAVCyfCiqrQU+
         yNeBJfV8kpcRqq7oR23HxVW5tgn0s3s948I4QwSJx/zEXKa5ysmWHDlpUzgfPa+226
         Dqfb4+4hKEFLwyFgP3rXGOmWs+tsXi92OKYQrqdE3VeVHcWevaYmUOfZkpjyhya6on
         DhkOfNNWoon7DPKP9fJNB7Kfa+r9tNrMtJMupHU/cTxxZyRXzLhg1IDCzjXD05sKwg
         QW6ZKZFEy9uhg4wx6fvAQFuJRPaKYNxhhUCWqSWynHD+lR15Z2ECerpCxk3ak4xqiH
         YQeC7XnTG6jaA==
Received: by mail-ot1-f51.google.com with SMTP id f67-20020a9d03c9000000b0069faa923e7eso2003668otf.10;
        Mon, 10 Apr 2023 02:38:42 -0700 (PDT)
X-Gm-Message-State: AAQBX9dG5xTcS4V8K0CXF+7zKDEOceKfHu50x49kbPMagBwyZLqaKyVj
        f46DlrVb+LOArziPcPis0EuPRS3KMZFhYVaIPTc=
X-Google-Smtp-Source: AKy350aVyMVzYSjsnFmTbxVsfwT/I+5fhw6NJNCBY/4vmYZL4c5RBAVBUigAkHXJBb63KRlsuswuc6LjJ8+adPYV0EU=
X-Received: by 2002:a05:6830:130a:b0:69f:8da4:48d with SMTP id
 p10-20020a056830130a00b0069f8da4048dmr2575069otq.1.1681119521803; Mon, 10 Apr
 2023 02:38:41 -0700 (PDT)
MIME-Version: 1.0
References: <20230308115243.82592-1-masahiroy@kernel.org> <20230308115243.82592-2-masahiroy@kernel.org>
 <CAKwvOdk+7ODHh=fC+=1bky+XEZH=idAsCkymn8Ex0TN8sC7SVQ@mail.gmail.com>
In-Reply-To: <CAKwvOdk+7ODHh=fC+=1bky+XEZH=idAsCkymn8Ex0TN8sC7SVQ@mail.gmail.com>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Mon, 10 Apr 2023 18:38:05 +0900
X-Gmail-Original-Message-ID: <CAK7LNARa7m==1Kocd0G5Nrjt1xzAg9YSGPMnzY93Us+re1Ae3Q@mail.gmail.com>
Message-ID: <CAK7LNARa7m==1Kocd0G5Nrjt1xzAg9YSGPMnzY93Us+re1Ae3Q@mail.gmail.com>
Subject: Re: [PATCH 2/8] scripts/mksysmap: remove comments described in nm(1)
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        Zhen Lei <thunder.leizhen@huawei.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Nathan Chancellor <nathan@kernel.org>,
        Nicolas Schier <nicolas@fjasle.eu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 8, 2023 at 3:46=E2=80=AFAM Nick Desaulniers <ndesaulniers@googl=
e.com> wrote:
>
> On Wed, Mar 8, 2023 at 3:52=E2=80=AFAM Masahiro Yamada <masahiroy@kernel.=
org> wrote:
> >
> > I do not think we need to repeat what is written in 'man nm'.
>
> I agree, but the paragraphs following the one you removed refer to a,
> U, N, w, T, t, and W now with no context that those are the nm
> formats.
>
> I'm ok with this patch, but please consider adding a sentence along
> the lines of:
>
> The following refers to the symbol type as per nm(1).


OK, I will fold this comment locally.

Thanks.




--
Best Regards
Masahiro Yamada
