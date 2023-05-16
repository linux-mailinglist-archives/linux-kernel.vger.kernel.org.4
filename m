Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7942704AB4
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 12:34:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232330AbjEPKeA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 06:34:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232197AbjEPKdp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 06:33:45 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42D2E6587
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 03:33:07 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id a640c23a62f3a-96622bca286so2254075366b.1
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 03:33:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1684233185; x=1686825185;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x37qfPv4F1ivF0FEc6v+EsmdjMxZQmhCoLQ4PfxHX24=;
        b=exJt95FT6D++7QGw38T8PESUYG9RwWgXQfPpVxa23dPBRK/SgUVv35cAnkwHT+sYoR
         d80g6jhqQQdWkBtsA4qxKsKR51gAgQMvar5nfZ7awHEOEu8whaCTDlefoGY7VDVcPfqe
         AunRo2jmCrBuko6E7qXhc77w4lcTsbTgyInIiRg9lDaxlDZ3B/myqdrAjFVqZzngd+xH
         qoew8hewgv+ry8ul5JS4Rrqo4jeX4DVjTRPPIN4wVUjJ6a31CWCblNozMP6yjc9UmpSg
         z2R1dqWiUR/aTxBo+eCjZcX5wGAoS7asplBVbV9LYcIcuBTn9aDocuhvfujy/XezXRnm
         A6xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684233185; x=1686825185;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=x37qfPv4F1ivF0FEc6v+EsmdjMxZQmhCoLQ4PfxHX24=;
        b=a095EnmGeDJJUGUr/fQvi7hONTUe/k5H7N8/36zhC1eFgyWwQjBDiTKqeHtchwqm1E
         LcHh8/aDTJwBG5s8b4JB2xLBDbUx1jiveF//5lTQ0DfCe6uJsZqUYf6MbdHM3Efu+tbk
         a22HoE4QsQevn3ol2B3U5JHsR5bmUYoV/vMcrJcmBLlLY3fpGBOKFCfFONlQd8M/lyiO
         l2ak7Ck39KsYJUZC4Y1QqbxAhO/8eFS3L4hgDtPownswM8iL2UZPbRSByGzcg8aoUXnG
         wY6ZNC80OIxoeplKrsRbfkUKFReKznyg6W2YAhsFQaAr9j0TfKkHg0k7Zhn0OXZQ3CpN
         HS4w==
X-Gm-Message-State: AC+VfDw4YX/01agti+hTF5zs5IDYFnqT3J7Z6f49a5XfOQJZwuFRII4L
        42iB/ed6LTEQtK4L8upS7R50fL5RlcH0ZuCsd/9Rng==
X-Google-Smtp-Source: ACHHUZ5wkoypuJRnRMJparFQO88WuE3PT6iRYXdcIjlVz2IAnp8nPT7iwGtUlaR7r7jiHaUaP+srqSLIp4nHn+Udv5U=
X-Received: by 2002:a17:907:7fa3:b0:965:6075:d100 with SMTP id
 qk35-20020a1709077fa300b009656075d100mr39974288ejc.39.1684233185585; Tue, 16
 May 2023 03:33:05 -0700 (PDT)
MIME-Version: 1.0
References: <20230515121521.30569-1-lmb@isovalent.com> <6b585a75-ae1a-1ad5-2756-bcce78fbd2fd@iogearbox.net>
In-Reply-To: <6b585a75-ae1a-1ad5-2756-bcce78fbd2fd@iogearbox.net>
From:   Lorenz Bauer <lmb@isovalent.com>
Date:   Tue, 16 May 2023 11:32:54 +0100
Message-ID: <CAN+4W8jXG2dNTtksYtQPYQgpfGMKgMqLhW_jHJSY=HhZ6G9PeA@mail.gmail.com>
Subject: Re: [PATCH bpf-next] bpf: btf: restore resolve_mode when popping the
 resolve stack
To:     Daniel Borkmann <daniel@iogearbox.net>
Cc:     Martin KaFai Lau <martin.lau@linux.dev>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 15, 2023 at 8:26=E2=80=AFPM Daniel Borkmann <daniel@iogearbox.n=
et> wrote:
>
> On 5/15/23 2:15 PM, Lorenz Bauer wrote:
> > In commit 9b459804ff99 ("btf: fix resolving BTF_KIND_VAR after ARRAY, S=
TRUCT, UNION, PTR")
> > I fixed a bug that occurred during resolving of a DATASEC by strategica=
lly resetting
> > resolve_mode. This fixes the immediate bug but leaves us open to future=
 bugs where
> > nested types have to be resolved.
>
> Lgtm, is there a way we could also craft a test case for this corner case=
?

There is a test for the datasec bug already, it went in with the
original patch. See commit dfdd608c3b36 ("selftests/bpf: check that
modifier resolves after pointer").

Not sure how to test this beyond that specific case.
