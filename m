Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36D8C6E6E42
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 23:33:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232827AbjDRVdH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 17:33:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232608AbjDRVdF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 17:33:05 -0400
Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACDAB619E
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 14:33:02 -0700 (PDT)
Received: by mail-qv1-f49.google.com with SMTP id o7so26794615qvs.0
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 14:33:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681853582; x=1684445582;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FcixbIsW3kO64h6Jtj5sJY2E9ztLhq82+LQGVeq96m8=;
        b=Bo+E65McpPUkfTcdsLjjvqZGTnnSQ3UhZBzsqSL08u9okmiZEkO7j2ytFJs1GOkVFz
         lIlHUjHqgdGA5nhzdNRr8bGUvZtDyBHASYAl0m+9cVp37NzrTTKuuRde7CNIgLPTai19
         3oRc9lf4CalM9wuFZlYDJU/57dQwOVy6Vl1ztAF/CE8x8bmc6OJH5zB6wdRq3FqUTJAX
         h0+XBPEDpOOzR6GevFP7vwpL2VZ5QbskHesty9eWEmiKXr2vAoHumpU1KL84gmfN8qVZ
         XqXdCrXwkIqG/9LM+xRYaVigtWSOZFB2mBi2VvloIf/8nnyTTrxKXVGAaPwtoplSUAoQ
         aViQ==
X-Gm-Message-State: AAQBX9djx7s35t9IrHEpwukaPJOmJx6OqE+lBbusBy/cmxX3jMZMKfJo
        jRwuSmPV0SbXngO80xQ+yYQ=
X-Google-Smtp-Source: AKy350bEq70ceFE7+W1TpymqrSVvydtzlM1MkpbnuWmZgo0ndiXdLjyliZhRp3htjRDp6fJxK0qN3g==
X-Received: by 2002:a05:6214:1304:b0:5e8:63ae:a9a9 with SMTP id pn4-20020a056214130400b005e863aea9a9mr29773327qvb.47.1681853581644;
        Tue, 18 Apr 2023 14:33:01 -0700 (PDT)
Received: from Belldandy-Slimbook.tail03774.ts.net ([32.221.209.96])
        by smtp.gmail.com with ESMTPSA id u5-20020a05620a454500b0074debbb36b1sm2008309qkp.69.2023.04.18.14.33.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Apr 2023 14:33:01 -0700 (PDT)
From:   Neal Gompa <neal@gompa.dev>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     David Sterba <dsterba@suse.com>, David Sterba <dsterba@suse.cz>,
        linux-kernel@vger.kernel.org, Rafael Wysocki <rafael@kernel.org>,
        Chris Mason <clm@meta.com>, Boris Burkov <boris@bur.io>,
        regressions@leemhuis.info, regressions@lists.linux.dev,
        Neal Gompa <neal@gompa.dev>
Subject: Re: Linux regressions report for mainline [2023-04-16]
Date:   Tue, 18 Apr 2023 17:32:28 -0400
Message-Id: <20230418213228.1273218-1-neal@gompa.dev>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <CAHk-=wjL7GG9s9Y2+u2725M+Ru=bUXnzOnXRwoSktY0fVdhhzw@mail.gmail.com>
References: <CAHk-=wjL7GG9s9Y2+u2725M+Ru=bUXnzOnXRwoSktY0fVdhhzw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus and David,

I'm the guy that sort of kickstarted this whole thing a year ago.
From my perspective in Fedora-land, we've been running automatic
weekly fstrim on every Fedora system for three years now[1] and
have not received any complaints about SSDs pushing daises from
that.

When we started discussing btrfs discard=async within Fedora
two years ago[2], I started soliciting feedback and information
from the Btrfs developers I was regularly working with at the time.

Last year, I had a face-to-face with Chris Mason and we discussed
the idea in depth and decided to go for this, based on both Fedora's
data with consumer disks and Facebook's data with their datacenters.

The only real surprise we had was the so-called "discard storm",
which Boris Burkov made adjustments to resolve a couple weeks ago[3].

With all that context in mind, I'm not sure we really should be panicking
about having async discard enabled, since it's the same operation
that the fstrim timer was doing before, just queued by btrfs itself instead.

So personally, I would prefer *not* to revert the new default.

Thanks in advance and best regards,
Neal

[1]: https://fedoraproject.org/wiki/Changes/EnableFSTrimTimer
[2]: https://pagure.io/fedora-btrfs/project/issue/6
[3]: https://lore.kernel.org/linux-btrfs/cover.1680723651.git.boris@bur.io/T/#t


-- 
真実はいつも一つ！/ Always, there's only one truth!
