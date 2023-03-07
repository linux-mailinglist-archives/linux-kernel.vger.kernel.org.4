Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D80C6AD9FB
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 10:13:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230200AbjCGJNS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 04:13:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230105AbjCGJNQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 04:13:16 -0500
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96C1336FEA
        for <linux-kernel@vger.kernel.org>; Tue,  7 Mar 2023 01:13:15 -0800 (PST)
Received: by mail-yb1-xb30.google.com with SMTP id t39so10723267ybi.3
        for <linux-kernel@vger.kernel.org>; Tue, 07 Mar 2023 01:13:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678180395;
        h=content-transfer-encoding:to:subject:message-id:date:from:sender
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=wHIvokc6x7RyV0eSxrOkPDESP91thUp+HVjpEAppVQ4=;
        b=ZWms5OfBcBxKsiQO52EUsrMYIUSVI0rWyl5ZXZr3jqwszULvBaAOhVym7WQk9UZCCd
         oO4XlY5fVfr980Nvr3Du91BKOaz8p/mKwWxWnVzsVkPqxT2mVM/lhnN08Z3jh8ILNiLK
         +aCLSM6NcSHVXAm+RR2wAybB0Xx2S6Cdb3GUFjHiglRW/p75y7gXof7im4yNfmDsowHl
         yFFSF2wRpr4XqTx+eAuLwCL+5zEziOwqYzUE5cNTxurbzcR/v6ev/s43eoEFKGj7g9O4
         1qdSAz5hQftWmUsT525XnEGQk+xcNYJyKyGewLYWQ7UYHK8rZT2P8/5JBfO5nljqs4Ba
         I7Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678180395;
        h=content-transfer-encoding:to:subject:message-id:date:from:sender
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wHIvokc6x7RyV0eSxrOkPDESP91thUp+HVjpEAppVQ4=;
        b=FbmNHKyhJk1yrgHe2wrG60bgOTRY6ra8uA8JYEo86pEaKlxqios5pqIbvYBjbuAJkz
         oxFsQPIEYF86JlIwIqIMy3ciLFJm2+pwTmKhiJlSSlrUETc3O5d1R1vlbHeaIiMIdhRa
         5wz4rrVNi4w4jKC9XR0YfmaqsanLMUMkD7WiiZMcEOyyTasihp+tPyde75gi5J+xS4dU
         dKnr/cad9X5gydu/00sOQHtNiYzrLoBtj3BAExBG3DFdVrSZjTYeKbMHDVI+VCsMeBg7
         wdsvJmGUqeMW9wxPrIfmeD/bWOh5gLFEIcMdPaP75jWi5IuEC6BvG4CnuEtLMnDXZH5j
         cqfA==
X-Gm-Message-State: AO0yUKX8DKuWAaljoQTFgFm7vVZyYa/OtuqEbVd+gGT+PjHq2EkWgEG1
        U+fgMeg/BUeVBoc5BSSUCIO1XO71UvK8cYTRw5w=
X-Google-Smtp-Source: AK7set90GX0srEAMGXEOgeTQkXEHAWZIDlvSxxcSm7kq5cpY4awI/ThVKUlo9wxyU6Icfe8PeVuqgt2hHBlSuq0yj2A=
X-Received: by 2002:a05:6902:208:b0:acd:7374:f154 with SMTP id
 j8-20020a056902020800b00acd7374f154mr8259257ybs.7.1678180394636; Tue, 07 Mar
 2023 01:13:14 -0800 (PST)
MIME-Version: 1.0
Sender: mrs.kimhongyeoh55@gmail.com
Received: by 2002:a05:7110:204c:b0:1a2:a069:abe4 with HTTP; Tue, 7 Mar 2023
 01:13:14 -0800 (PST)
From:   Stepan CHERNOVETSKY <s.chernovetskyi@gmail.com>
Date:   Tue, 7 Mar 2023 10:13:14 +0100
X-Google-Sender-Auth: R9zt43AB2KsfxtTRWPGcki7HnQ8
Message-ID: <CAPeJZ8ChzGx=EKA8Brxmci65j2-8-_=kBiNeYa8ibgKYwrfiXA@mail.gmail.com>
Subject: I Need Your Help In Investment Project;;
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=3.7 required=5.0 tests=ADVANCE_FEE_5_NEW,BAYES_50,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,UNDISC_MONEY autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: ***
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Greetings Dear Friend,

Please do not be embarrassed for contacting you through this medium; I
got your contact from Google people search and then decided to contact
you. My goal is to establish a viable business relationship with you
there in your country.

I am Stepan l. CHERNOVETSKYI, from Kyiv (Ukraine); I was a
businessman, Investor and Founder of Chernovetskyi Investment Group
(CIG) in Kyiv before Russia=E2=80=99s Invasion of my country. My business h=
as
been destroyed by the Russian military troops and there are no
meaningful economic activities going on in my country.

I am looking for your help and assistance to buy properties and other
investment projects, I consider it necessary to diversify my
investment project in your country, due to the invasion of Russia to
my country, Ukraine and to safeguard the future of my family.

Please, I would like to discuss with you the possibility of how we can
work together as business partners and invest in your country through
your assistance, if you can help me.

Please, if you are interested in partnering with me, please respond
urgently for more information.

Yours Sincerely,
Stepan l. CHERNOVETSKYI,
Chairman and founder of Chernovetskyi Investment Group (CIG)
