Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86D415FD9AD
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Oct 2022 14:57:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229673AbiJMM5g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Oct 2022 08:57:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229627AbiJMM5d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Oct 2022 08:57:33 -0400
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDF3E139E45
        for <linux-kernel@vger.kernel.org>; Thu, 13 Oct 2022 05:57:32 -0700 (PDT)
Received: by mail-qt1-f182.google.com with SMTP id c23so896453qtw.8
        for <linux-kernel@vger.kernel.org>; Thu, 13 Oct 2022 05:57:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=irrtQDfSNa+nC82dDhEaw7oZ22ZAh6yjPzt5Hm4L+Ic=;
        b=Fj5rDDj7PQ7oUI1hLh8p6yFL6xGALiAMy9JzznQtqTgctaUKUuzyaJ8fxOP6/LkOiL
         1fzQT4A/5SUeHf2s1lmYsLn8T/EqcC1WbvwJDWZZRrZDaBP17BMfogRRtzD0IMTLE3dl
         MsuQSwjezBCxn7Eg9AmYY8LV+VmNiySJULroMrirN0oiyX6DNJ5ZWU/bAdw0AzE2RSlq
         nr1tcMWGYrWGyY2d5lDqOKfjxM/5I9t04rxRsaprdavUSfce7tPX1+LatAkKtx7Biqcl
         2jLvbd19LooIE7s3ZeU5/Sfgg19qLqt4uvMBBe20N1oF201swKY82HqkRVw44Uw4jqMw
         tkjg==
X-Gm-Message-State: ACrzQf2jK5/qOILvbIHrLajg+MF2XA6lU8ZhDHi80fH93Fv1XYQPV9Gp
        zydfd1HeshDM9b/eI9ZqVuAQz95WRBIgAw==
X-Google-Smtp-Source: AMsMyM4HJC2ZulcaFqq1jnJK2H2IQEyGP6gyEe/eb79e9Vy3GpHxqoc2CRbR323JoYWdSNiRbpnP5A==
X-Received: by 2002:ac8:5a07:0:b0:39c:1de3:e75c with SMTP id n7-20020ac85a07000000b0039c1de3e75cmr11430830qta.49.1665665851886;
        Thu, 13 Oct 2022 05:57:31 -0700 (PDT)
Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com. [209.85.219.169])
        by smtp.gmail.com with ESMTPSA id s13-20020a05620a0bcd00b006b95b0a714esm19185694qki.17.2022.10.13.05.57.30
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Oct 2022 05:57:31 -0700 (PDT)
Received: by mail-yb1-f169.google.com with SMTP id e62so1921748yba.6
        for <linux-kernel@vger.kernel.org>; Thu, 13 Oct 2022 05:57:30 -0700 (PDT)
X-Received: by 2002:a5b:104:0:b0:6b0:429:3fe9 with SMTP id 4-20020a5b0104000000b006b004293fe9mr31953207ybx.543.1665665850700;
 Thu, 13 Oct 2022 05:57:30 -0700 (PDT)
MIME-Version: 1.0
References: <20221012191142.GA3109265@bhelgaas> <885a98b927a5244ad5a5ec8727b67b2135d5a8ad.camel@sipsolutions.net>
 <f57d954a-b565-9bfa-b8eb-ce608e168f1a@cambridgegreys.com> <2135037685.24273.1665665172126.JavaMail.zimbra@nod.at>
 <CAMuHMdVWWbonfT7-RRV4U9UUudUobpeAGOXpO9Y0Cyuqzy=DeQ@mail.gmail.com>
In-Reply-To: <CAMuHMdVWWbonfT7-RRV4U9UUudUobpeAGOXpO9Y0Cyuqzy=DeQ@mail.gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 13 Oct 2022 14:57:18 +0200
X-Gmail-Original-Message-ID: <CAMuHMdU=TurB14tkAbqb9nWYvCOcr0UUScdga25h3-oWjYfzTg@mail.gmail.com>
Message-ID: <CAMuHMdU=TurB14tkAbqb9nWYvCOcr0UUScdga25h3-oWjYfzTg@mail.gmail.com>
Subject: Re: Add linux-um archives to lore.kernel.org?
To:     Richard Weinberger <richard@nod.at>
Cc:     anton ivanov <anton.ivanov@cambridgegreys.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        Bjorn Helgaas <helgaas@kernel.org>,
        linux-um <linux-um@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        helpdesk <helpdesk@kernel.org>,
        David Woodhouse <dwmw2@infradead.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Richard.

> > >>> https://korg.docs.kernel.org/lore.html says pipermail archives like
> > >>> infradead has are not ideal, but I don't have any archives at all, and
> > >>> I don't know how to get even pipermail archives out of infradead.

The first step is
https://korg.docs.kernel.org/lore.html#requesting-archival-of-an-existing-list

It doesn't make much sense to start collecting archives if the lore
collector hasn't been activated yet.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
