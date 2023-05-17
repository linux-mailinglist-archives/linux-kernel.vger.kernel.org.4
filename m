Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 626A370637D
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 11:02:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231235AbjEQJCH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 05:02:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229893AbjEQJBm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 05:01:42 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEB966A54
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 02:01:22 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id 4fb4d7f45d1cf-510b56724caso7429431a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 02:01:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1684314081; x=1686906081;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8BFnzpFnEWHgBCYzwUlEu4io3XMBxiABg4u5t/U4XNM=;
        b=aQ35lN37DYUOGChsdqb0kqQN4HJT38nERHgvEjALuQ7BO+TAECKaybq6G/dAuMj6yq
         4hpn6i6zz4t1w2OsZKeN0ula9iZBr4x1Ai+ZD6WDHES5gfFjtfcFLmG40IkB903jVn7t
         IH8FOPBAudvgqXWRUc76iovKokS1OWF2iFFXtg+BOjLEFFBS9aWUj19ovGyM/Qc+QyFG
         mwAhDMpHLxDfuOE7s57Ph1ANVdGyBIU4yUABXC6NXn7mKmClX/e9egc0J3R8/uVZo5X3
         J/CJMZiyuVFxOEItgq4jUIvxnxFxHuNstZmOLGwz6bb1f73MqJCo4tNCGQGD7Gb7BRJl
         iU1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684314081; x=1686906081;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8BFnzpFnEWHgBCYzwUlEu4io3XMBxiABg4u5t/U4XNM=;
        b=FDi6ch9UwfrqGmx7hN7llhRzCEiwoAyTCiyta8Zday7KLW3VpWQuq6YEXOsXZJyYaq
         F+6nMxFz7Jgv/7hQXzSBjfYwzhtJvh241Gy8Uw97wqCYPjUrr56TxGVDRRcrrBgXSqRl
         gC0bZON8y+eRaUCKliVyVEWc6BPGLJ1GfxYoGw26wbAokdP6tvnbr+3IyRIUtCHhZWVR
         /FManMtj9hLxuKGdXPYoi20BS7f5/FYdMxee7xLOLoPBiTLZhpqflRgrwmrFvdrG76E2
         BDUl1O0JcnnvOYYSiK2wgakL/W+n8vSz6Nusv8ttPksdMjJa/ypMqjZEXEcNzCIUq6Z9
         ZdNQ==
X-Gm-Message-State: AC+VfDwadWsW0YiJx3WkrPbnowh4sMbHKysGRLEE3WscLu0fsGb88jxd
        PyVDzPFhvE4lj6IEpAbQQ0wqTggFQ90T5LaO4GGscw==
X-Google-Smtp-Source: ACHHUZ5P75xcx+CWtz+lJaC31PQ4IxYJSQC9FYvo3svbCkpxO/YbHVL4pxqH9BUbLvt4AL2mmI+w2gTcjJsFJ28Ci9I=
X-Received: by 2002:a17:907:a407:b0:965:6a32:451f with SMTP id
 sg7-20020a170907a40700b009656a32451fmr1326875ejc.6.1684314080855; Wed, 17 May
 2023 02:01:20 -0700 (PDT)
MIME-Version: 1.0
References: <20230515121521.30569-1-lmb@isovalent.com> <a29c604e-5a68-eed2-b581-0ad4687fda10@linux.dev>
In-Reply-To: <a29c604e-5a68-eed2-b581-0ad4687fda10@linux.dev>
From:   Lorenz Bauer <lmb@isovalent.com>
Date:   Wed, 17 May 2023 10:01:09 +0100
Message-ID: <CAN+4W8hixyHYOwYRh-3WedS-a0KTQk8VQ4JxqM8y-DQY-yjsNA@mail.gmail.com>
Subject: Re: [PATCH bpf-next] bpf: btf: restore resolve_mode when popping the
 resolve stack
To:     Martin KaFai Lau <martin.lau@linux.dev>
Cc:     bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 17, 2023 at 7:26=E2=80=AFAM Martin KaFai Lau <martin.lau@linux.=
dev> wrote:
>
> On 5/15/23 5:15 AM, Lorenz Bauer wrote:
> > In commit 9b459804ff99 ("btf: fix resolving BTF_KIND_VAR after ARRAY, S=
TRUCT, UNION, PTR")
> > I fixed a bug that occurred during resolving of a DATASEC by strategica=
lly resetting
> > resolve_mode. This fixes the immediate bug but leaves us open to future=
 bugs where
> > nested types have to be resolved.
>
> hmm... future bugs like when adding new BTF_KIND in the future?

It could just be refactoring of the codebase? What is the downside of
restoring the mode when popping the item? It also makes push and pop
symmetrical. Feel free to NACK if you don't want this change, not
going to push for it.
