Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFDFD6A5A54
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Feb 2023 14:48:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229724AbjB1Nsc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 08:48:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229677AbjB1Nsa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 08:48:30 -0500
Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4A9F166C6;
        Tue, 28 Feb 2023 05:48:14 -0800 (PST)
Received: by mail-qv1-f49.google.com with SMTP id op8so6811822qvb.11;
        Tue, 28 Feb 2023 05:48:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ByVxdS/basDlCycjFYWHfawf1ZvBXNewjczRvauznmY=;
        b=dvmnWtG8Tee//DEJ2iAg0RPq9Y8uuIKLS+rE51VvU+hFB+AGi2OvnNSCRSYTa4ARH+
         tQUo9nYMe/R/iym3FFh21CdZTjO0z00U1a/qG2BHUMbpfWyjo7cq9b3jU0dBjDJQAbec
         XLDJQPKqsKlUAaxCM+4J6g959ohTegT2lchAFA1RXCNuXgYMIBhkYoPywsddo//Vmohw
         5ln83mo/NeGvYVZ8X5+uVEL9AFYy+sl/0pWP3/G6TyvNk7u2yHtUXM0WDe/DzHytmk1X
         Tn0R9E/SIsYiLtS/Im/WEhqtGRd1cUyjLytMXunRGOCT9LHLtlN/xAfNSZO1R9YVN8NT
         4iZg==
X-Gm-Message-State: AO0yUKXJrmnuGsu8gbm2ignVoGA69paFgk/dlabIYZrj48pJg8nnF+MV
        JT+vGvEhsKxWcDHNElMi4LnpjCMlp81n5A==
X-Google-Smtp-Source: AK7set8dE5CRm6J6zRQCz35DOxI93+w7K9kAgqig2XhUYoQATTVkGN6lIBgfOhn1VHXQUqxySi6QTA==
X-Received: by 2002:a05:6214:262d:b0:572:2aa2:6dfa with SMTP id gv13-20020a056214262d00b005722aa26dfamr5938683qvb.28.1677592082628;
        Tue, 28 Feb 2023 05:48:02 -0800 (PST)
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com. [209.85.128.179])
        by smtp.gmail.com with ESMTPSA id n188-20020a37bdc5000000b007425f242cb8sm6833296qkf.66.2023.02.28.05.48.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Feb 2023 05:48:02 -0800 (PST)
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-536bbe5f888so273167967b3.8;
        Tue, 28 Feb 2023 05:48:02 -0800 (PST)
X-Received: by 2002:a81:ac10:0:b0:533:99bb:c296 with SMTP id
 k16-20020a81ac10000000b0053399bbc296mr1648198ywh.5.1677592081988; Tue, 28 Feb
 2023 05:48:01 -0800 (PST)
MIME-Version: 1.0
References: <20230228130215.289081-1-nick.alcock@oracle.com>
In-Reply-To: <20230228130215.289081-1-nick.alcock@oracle.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 28 Feb 2023 14:47:48 +0100
X-Gmail-Original-Message-ID: <CAMuHMdUo3BkELZzhr0yVF7eU53_h757m1QWN8fQeLWKe5fCZDA@mail.gmail.com>
Message-ID: <CAMuHMdUo3BkELZzhr0yVF7eU53_h757m1QWN8fQeLWKe5fCZDA@mail.gmail.com>
Subject: Re: [PATCH 00/20] MODULE_LICENSE removals, fifth tranche
To:     Nick Alcock <nick.alcock@oracle.com>
Cc:     mcgrof@kernel.org, linux-clk@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-modules@vger.kernel.org, linux-perf-users@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-serial@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-trace-devel@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=1.1 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        SUSPICIOUS_RECIPS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nick,

On Tue, Feb 28, 2023 at 2:05 PM Nick Alcock <nick.alcock@oracle.com> wrote:
> This series, based on current modules-next, is part of a treewide cleanup
> suggested by Luis Chamberlain, to remove the LICENSE_MODULE usage from
> files/objects that are not tristate.  Due to recent changes to kbuild, these
> uses are now problematic.  See the commit logs for more details.

Does this mean you expect us to queue them for v6.3?
Thanks!

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
