Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A348B70B308
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 04:08:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231558AbjEVCH5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 May 2023 22:07:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229922AbjEVCH4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 May 2023 22:07:56 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 904ABB7;
        Sun, 21 May 2023 19:07:55 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id 4fb4d7f45d1cf-510d92184faso9071618a12.1;
        Sun, 21 May 2023 19:07:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684721274; x=1687313274;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Sz0Spj8dzzse1twdFWxs7Pr1GkJdyy1KzKMZwqhjwYw=;
        b=Z5mVGUMcyUthgWsbJz4jMz783W9DnClIAhVXFPkO3Sl1PZ84kkTS+St3Nm+j37fulr
         sX3mOzNAPu0+dKIhT/h8nzaEofGKN0yqBGudut32cHrc+E3dvf2d7wx578LjgttU8t4s
         O7EwM4brfMFhEMTdmaD5MyMs6SHBMdFND9VEzZa0pHOUqoirMERGER/wGBo1KoN53BCY
         T+iMnMZ036ZPnRQFAqeaotfKFAlx8nP7Elw06lTsg6bnJjq5C1f9CPAf/He3V1HuWKVt
         I2rKlbUzVCasktWwlPlOWr8Zj4b89yC0EVwhecTwlzbZwO909AtW1rPq6CaKmfACWwfE
         8THw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684721274; x=1687313274;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Sz0Spj8dzzse1twdFWxs7Pr1GkJdyy1KzKMZwqhjwYw=;
        b=FSfwtzGOxHK2XjVYZP06Q4c8RopfWhIBk43JwZXwsPzSmHdGmhgRB+eUqJiMGBAtnx
         cufK2N8rmDt2B2tqxFzjePkfxQE4SQhtO9jZKaBWHlVCZDDe4TDlAp5BpMeXpe+UX8D/
         YQXooLySIJAbuq5YJ53BlMbWQ6ucn783j9KydYHiqRbc9ENclPQQvrG4tXNSnrFMimud
         wMXUWEtMh3/6irD4IzmpSEjfXYTPozXt5oiHZ1fgUXzXAHalHJkISUqKdhgFd/6whHMp
         85jKpdfekyT+el9YVSFtLzVYZ2ZrXL+n4Jp0d7cY1kVAUgd1leXJ2C0kN4RcsaW1sn/M
         Rf8A==
X-Gm-Message-State: AC+VfDyA8qrU4hpOG/66UNoJV5EA6NYZX7DW1wY6zRBOTEIBXohi7Ewi
        qW1jL2YBqV2xcaXA6cZwrMf7TknUq7DEDhQZVQM=
X-Google-Smtp-Source: ACHHUZ4wrOhEYShKyW/O1eY1HmQbKQKS6rz1bi7T5GEPQgCb9egPC4yZhclR5xQE+XYa5cZMmp8Cwd8iFnqTUqJgR/g=
X-Received: by 2002:aa7:d80b:0:b0:50b:fe20:1c7f with SMTP id
 v11-20020aa7d80b000000b0050bfe201c7fmr7110715edq.33.1684721273786; Sun, 21
 May 2023 19:07:53 -0700 (PDT)
MIME-Version: 1.0
References: <20220515203653.4039075-1-jolsa@kernel.org> <20230520094722.5393-1-zegao@tencent.com>
 <b4f66729-90ab-080a-51ec-bf435ad6199d@meta.com> <CAD8CoPAXse1GKAb15O5tZJwBqMt1N_btH+qRe7c_a-ryUMjx7A@mail.gmail.com>
 <ZGp+fW855gmWuh9W@krava>
In-Reply-To: <ZGp+fW855gmWuh9W@krava>
From:   Ze Gao <zegao2021@gmail.com>
Date:   Mon, 22 May 2023 10:07:42 +0800
Message-ID: <CAD8CoPDASe7hpkFbK+UzJats7j4sbgsCh_P4zaQYVuKD7jWu2w@mail.gmail.com>
Subject: Re:
To:     Jiri Olsa <olsajiri@gmail.com>
Cc:     Yonghong Song <yhs@meta.com>, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Hao Luo <haoluo@google.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Song Liu <song@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Yonghong Song <yhs@fb.com>, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        kafai@fb.com, kpsingh@chromium.org, netdev@vger.kernel.org,
        paulmck@kernel.org, songliubraving@fb.com,
        Ze Gao <zegao@tencent.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Oops, I missed that. Thanks for pointing that out, which I thought is
conditional use of rcu_is_watching before.

One last point, I think we should double check on this
     "fentry does not filter with !rcu_is_watching"
as quoted from Yonghong and argue whether it needs
the same check for fentry as well.

Regards,
Ze
