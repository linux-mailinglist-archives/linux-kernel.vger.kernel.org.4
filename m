Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6F4770970E
	for <lists+linux-kernel@lfdr.de>; Fri, 19 May 2023 14:08:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231281AbjESMIM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 May 2023 08:08:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229929AbjESMIL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 May 2023 08:08:11 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6A40128;
        Fri, 19 May 2023 05:08:10 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id d9443c01a7336-1ae452c2777so5821395ad.0;
        Fri, 19 May 2023 05:08:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684498090; x=1687090090;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=C6BBqUoJ4/4c3Znf57SydvHkRL6P0DusBuHBrxg8e2U=;
        b=KMMCbehNSm4rWRP1n7ZuJVMQa3GotzEHXSoG70C+PpyV6UhZ6EpV0iOm2U68OlHL60
         HO2d/N0vweaTM1a+OpmmmrO6XRzYUOJPEXlJPPr0mMm+HVWj+VrPTCdliTDKqB9DAWl8
         ytJVFixN9gjk9QDWi0BKJq809XZQ8j98Lnv681L0En2CpXMeXkVPuYZonJ1B6233qYPi
         3lovK5GCqJ9kBi3Ft8uecD7WcJve3mM1+EOz0DTGkdNu94m/Am7nM/jyoJrhwQwK6dHk
         K+7YqjMfy1jGcAWjzpFTCX2BkHaA6l6CQI9UZiRjbFXpc5e8uMYY57JKbVLqVAwcDc/K
         /GbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684498090; x=1687090090;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=C6BBqUoJ4/4c3Znf57SydvHkRL6P0DusBuHBrxg8e2U=;
        b=ijrIyHswnb4QdbmewS93y7O6Fe80IRGE4n7WtjIO3eDzHwmmO7i2CGwXsPPEgYLoaF
         t+He02bQ8xT1YccGHeCsxbi6pY/hFL3gPiRwjP7ivPPcw6qPP5Cr9zakRr5ctq771GjA
         hToZcvngND8PEK8kd/0Us9Exgd8ujyRVyEpba9Vd8jw/OzFkYZMW7HtmAD58IZ8On47o
         qFKY3LbfetqkMf035UFOG+SUkqhcfPtNwyJ/v16klLkhbw44H4o/etMdlFkMAlRnUKPT
         9aW6dFzBVtLX/IhuquiCmuR0fKYtMW/gf6Aq/W9wq8/kxQXUgg2ZTkB7umJjGDT5URLu
         56iQ==
X-Gm-Message-State: AC+VfDzMRFAjKMHgv52I8ldAGimwWNq0bwh2Q02udCEPEzx9QHzbvmU9
        Rrgk870sc84bLe4dAjdb8ejc6XXweCEj+UiTehyAbkl9H8k=
X-Google-Smtp-Source: ACHHUZ7GYTC+oWEngnW9J6+8ApgdZ1+WdQmZoz840G1bbSvnat/kRo0fmJc49r+dm0L3m3Y79c55X4AbMPalrP5sw6o=
X-Received: by 2002:a17:903:2343:b0:1ae:35b8:d5ae with SMTP id
 c3-20020a170903234300b001ae35b8d5aemr2842877plh.19.1684498089812; Fri, 19 May
 2023 05:08:09 -0700 (PDT)
MIME-Version: 1.0
From:   Zhouyi Zhou <zhouzhouyi@gmail.com>
Date:   Fri, 19 May 2023 20:07:58 +0800
Message-ID: <CAABZP2wiPdij+q_Nms08e8KbT9+CgXuoU+MO3dyoujG_1PPHAQ@mail.gmail.com>
Subject: a small question about bpftool struct_ops
To:     bpf@vger.kernel.org, linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear developers:
I compiled bpftool and bpf tests in mainline (2d1bcbc6cd70),
but when I invoke:
bpftool struct_ops register bpf_cubic.bpf.o

the command line fail with:
libbpf: struct_ops init_kern: struct tcp_congestion_ops data is not
found in struct bpf_struct_ops_tcp_congestion_ops
libbpf: failed to load object 'bpf_cubic.bpf.o'

The host OS I used to compile the kernel and bpf is Ubuntu 23.04, the
guest OS that I run bpftool is Ubuntu 22.04.
I have stumbled on this for several days, could you help me by guidance my way?

Thanks in advance
Zhouyi
