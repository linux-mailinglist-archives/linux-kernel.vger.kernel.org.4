Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8357A642248
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 05:31:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231475AbiLEEbg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Dec 2022 23:31:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231165AbiLEEbd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Dec 2022 23:31:33 -0500
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com [IPv6:2607:f8b0:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26717120A9
        for <linux-kernel@vger.kernel.org>; Sun,  4 Dec 2022 20:31:33 -0800 (PST)
Received: by mail-ot1-x333.google.com with SMTP id v19-20020a9d5a13000000b0066e82a3872dso4541858oth.5
        for <linux-kernel@vger.kernel.org>; Sun, 04 Dec 2022 20:31:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from:reply-to
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=HD0C+vijYy0hCXPKpjsTOCXB37VEeR3fSALh7dwqTLc=;
        b=g50b6j4VfKITLK2EnLMcpoP13+4YuP68wILK/qONsCvVjwlLMjqauguEDyKMH2B9bo
         muOVlY6BO/ctqUuz1aK+pweUmnK44KiPjWLgJOb76h0YW2GJjkzoh/sa7gcMUB7Ch3Co
         oj+hWxp+vDBAQZMLSfE08XjGvGwflbP012eEKoaaDmlLA8NOD6vK08B6bNChAMztUSvN
         vmhV1aq+ogKjJvf/V2f387hHsp5gyDmRHVWPmcVKmm9WPQbLFlezengzB2LgIi2nsgUL
         b64Vrmvq3fyWEFeDpTO2aTJ3neG+TFQFdhRL2DtawyfZR/dzxuG51Ol6VTAoE82vpY0L
         qYMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from:reply-to
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HD0C+vijYy0hCXPKpjsTOCXB37VEeR3fSALh7dwqTLc=;
        b=QFKgkfPrxloEXJkCw+TXVnXtE6LsQCzIqXrTkxR6olucp/sA+RUsUEGoKV985LMzkR
         ARTnrTtHvWP8LlVVAf7IoEpH4efcDDmhv2x03nRPDZgLJcnKBXwtBqx76ETvupCpB8fi
         IlBZMKHTJ0iW/WrE/hcJER1ugDH7F+QcSmI0LRQbSP7jvHQe+xuqz2yF2EACGJIztFs2
         3KUDHnC5D4kTeFX2ZKrZQfy6TxDytcJsRfmBMnQfxLf+QGddJAcBY/eacv+boxAz/DEk
         Utnh/xtQ1fcv0iMS3V7DPbB/a8JXp9xleOwIpjxSBMsdbs18sjZ6ebhU3U7PFI8PUb2V
         0WKg==
X-Gm-Message-State: ANoB5plTnyYlkXblbuuJ60QWfMApHkmNh1Aep+xJZrBVl0csIklu7X4D
        6B34qjbpYl+JLySwNxJOPyvO+BtIhfPFj9td5fk=
X-Google-Smtp-Source: AA0mqf7YUAz+5EvLwcag2IQgvokpDUn3gVHkFc6ROteMHmcV8/JitaMzxXY+siNxF16tOM5utA+61Z6QtSc1nuLxLV0=
X-Received: by 2002:a9d:282:0:b0:66c:794e:f8c6 with SMTP id
 2-20020a9d0282000000b0066c794ef8c6mr41141111otl.343.1670214692406; Sun, 04
 Dec 2022 20:31:32 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a05:6358:78b:b0:e0:44f5:f678 with HTTP; Sun, 4 Dec 2022
 20:31:32 -0800 (PST)
Reply-To: jennifermbaya036@gmail.com
From:   "Mrs.Jennifer Mbaya" <basileelegbe@gmail.com>
Date:   Mon, 5 Dec 2022 05:31:32 +0100
Message-ID: <CALgXR7BADx2av2QKfSKU5-Or2HzuojSbvGyHi1OxUrvTgucnyg@mail.gmail.com>
Subject: Mottaker
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=4.7 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLYTO,
        FREEMAIL_REPLYTO_END_DIGIT,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_HK_NAME_FM_MR_MRS,UNDISC_FREEM autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mottaker
Det er en pris i ditt navn fra FN og Verdens helseorganisasjon
tilknyttet det internasjonale pengefondet der e-postadressen og fondet
ble frigitt til oss for overf=C3=B8ring, vennligst bekreft dataene for
overf=C3=B8ringen.
Vi ble bedt om =C3=A5 overf=C3=B8re alle ventende transaksjoner innen de ne=
ste
to, men hvis du har mottatt din fond vennlig ignorere denne meldingen,
hvis ikke overholde umiddelbart.
Vi trenger din presserende svar p=C3=A5 denne meldingen, dette er ikke en
av de internett svindlere der ute, det er pandemisk lettelse.
Jennifer
