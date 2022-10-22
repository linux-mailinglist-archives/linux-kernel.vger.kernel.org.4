Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0850608419
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Oct 2022 06:03:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229765AbiJVEDv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Oct 2022 00:03:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbiJVEDs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Oct 2022 00:03:48 -0400
Received: from mail-yw1-x112e.google.com (mail-yw1-x112e.google.com [IPv6:2607:f8b0:4864:20::112e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D13D727E2C9
        for <linux-kernel@vger.kernel.org>; Fri, 21 Oct 2022 21:03:46 -0700 (PDT)
Received: by mail-yw1-x112e.google.com with SMTP id 00721157ae682-345528ceb87so40420377b3.11
        for <linux-kernel@vger.kernel.org>; Fri, 21 Oct 2022 21:03:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=0tZftHfmzOLMo3r4h5XVOG55kRaxX2tuCbZMHefzPrw=;
        b=OR5i3xt84PohVQq/dd/KPzxEflRFXPhk3pxIUfQI07RW8YeURs1oPvS/QSzHILd6fc
         /qHHA/Vn2JvmV1Yddrn6TzPjc6VgP2fjvbY361RA2R4o2jO1hwOu4Waku9L3fNFzRjou
         N1BAhaOmS2w+Yfds2YvrzZCw92uhXr75nzgWCm7YIvY9UIXRAMCqRkoHh/ts2qjyFuC9
         RxtftYS4rHij9Bo3hiLNywExbx/g1B0U+16Km8XnCZiSMu5bnRu4utgQepLZiPkaDGSb
         zE3IgnJ2+so6Q3M4Lxtw7+joR6ArTA12RQHYqhMUiXNk91nbXh4vTkQKaW9O+95sRCkh
         ZtDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0tZftHfmzOLMo3r4h5XVOG55kRaxX2tuCbZMHefzPrw=;
        b=E7kzHaMeQqsZWyTBm3vpQX9o5kBJQ5d7ytGHOO9vA074NMvZOjSXN0Y4PGjgizWh0f
         6FBfPd+YtYFKOqJktmEoix/OQQOWP1aDYMXDUo+VNEcBIOiSLEX1tnASxxGfX0vyI4fy
         OXS5TZYf1DhWL1TysEn8oYpoyFeuBHNIBZOSsaqLvYO+dxGeRfobtveNqC5hpkmCvwJU
         J7/JhSwj6NuecCHDIOfDEoeN9FhE+INYuZ92YkHqqAgpMdGZfXTJa9hmz4gXORzcKbZB
         7YvIxPEqUmpwi+AzosQiU0LQpZGVH5VcKYM6ZDxMuHgD3MZee4Gh1BoI4XqySjUAz7aU
         b/yw==
X-Gm-Message-State: ACrzQf1KBBDtfSwehcdi2TgTpHBbmoG8pXef8CFpe7Vd60g5Z135t0Fb
        ztQmV7si2XPQtk8OQ7GB+J+NNorSiuPHdAV07C2IvxCV4kw=
X-Google-Smtp-Source: AMsMyM7gR/OfiXSZ0NqhD/1/b4fRCRo2ItqvyYxK2UGcMWMs0cJn8posQCOLAOk/iwdGgOe2m8XB8W+IrwI9mToWtZA=
X-Received: by 2002:a0d:df85:0:b0:367:6e3a:ba5e with SMTP id
 i127-20020a0ddf85000000b003676e3aba5emr15100545ywe.455.1666411425832; Fri, 21
 Oct 2022 21:03:45 -0700 (PDT)
MIME-Version: 1.0
References: <20221010225744.101629-1-surenb@google.com> <20221021013613.1428-1-hdanton@sina.com>
 <CAJuCfpGMnoci2y_JiM0LR_OnY1MPKhpabhfAJZCpzzUiGMdL+w@mail.gmail.com> <20221022035200.1911-1-hdanton@sina.com>
In-Reply-To: <20221022035200.1911-1-hdanton@sina.com>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Fri, 21 Oct 2022 21:03:34 -0700
Message-ID: <CAJuCfpGkTPJXmdpygJu5b2Gm38G1F3yrFKXZ95r9HxpaFYakHQ@mail.gmail.com>
Subject: Re: [RESEND PATCH v4 1/1] psi: stop relying on timer_pending for
 poll_work rescheduling
To:     Hillf Danton <hdanton@sina.com>
Cc:     peterz@infradead.org, hannes@cmpxchg.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 21, 2022 at 8:52 PM Hillf Danton <hdanton@sina.com> wrote:
>
> On 21 Oct 2022 12:54:16 -0700 Suren Baghdasaryan <surenb@google.com>
> > psi_poll_worker runs at a low FIFO priority to prevent normal tasks
> > from preempting PSI signal generation (see sched_set_fifo_low() call
> > inside psi_poll_worker()), so schedule_delayed_work() would not be
> > usable as is I think, since it uses normal priority system_wq.
>
> I missed FIFO and sorry for my noise.

No issues at all. I appreciate your input!

>
> Hillf
