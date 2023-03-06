Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C39D6AC5CD
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 16:45:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231382AbjCFPpE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 10:45:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231359AbjCFPpA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 10:45:00 -0500
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 426B755B1
        for <linux-kernel@vger.kernel.org>; Mon,  6 Mar 2023 07:44:31 -0800 (PST)
Received: by mail-qt1-x844.google.com with SMTP id s12so10932892qtq.11
        for <linux-kernel@vger.kernel.org>; Mon, 06 Mar 2023 07:44:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678117468;
        h=content-transfer-encoding:to:subject:message-id:date:from:reply-to
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=1LoMPu+4BrHZKD2eSZojyEi/Tom9jYTKcc2sg2dBTY0=;
        b=ANelTIRlVPOZItV4JXHm1CPNK9hW9fzcgFLe/5WgMVnkgJFGzCvA8hSb2q26e6hhd9
         QE3dyKP1gmM8vQpX8nA9TcqfGS7p30kSy4vfj5Kw2t8iPdmoHoF82KSOQvQElwM3rwpT
         BlM7LiQyKoJcAone1PzEMt4U4uUpQTTClU4E7i0B0yqOn3NWNoxGfcNGE6467afswHjr
         yePbJICbDfm/iPj99yluw19nm99uLoGn8CX7t81RGQUQIWkpSneOgJfvRVq04BaXEOKn
         kTCJrnbLWGi7MI4Wy/2rSWtou2Upm5Wcx/Tu/NJJtk3tSGs2KA5NwIcjCn3xbUVI54Sj
         Z1qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678117468;
        h=content-transfer-encoding:to:subject:message-id:date:from:reply-to
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1LoMPu+4BrHZKD2eSZojyEi/Tom9jYTKcc2sg2dBTY0=;
        b=74gumYws1nEBPkmbofgU0MvYUMiljj+JZ7hXTBWzJ4D5wjAPJke2IxiLTRretsGxqQ
         uY2pLSWkA4EWRyR8IpYav/AfZhvOOLHxTV+hpx9bvem+NL2FVxKNWM/TNG696XknA8f+
         NEt2jNiD3bJhpNJd1XVuZkpxXom4gs7dZKcFlYiRsZY0WT0dF9iYutbjoYQiriP5QgkG
         zdUmrcbQu11VoFYfaA5x6oogfiEBB1zMtbw/1J9O8ifSxzu5PzT4eqO1lsJR2kBvS5Vf
         Duk4nyT0jMr5z/wxdwtx0e/1HVeTsKnCeJNTqcselk3cFYM0WrFEDLVBBzAZNpAdO0UV
         cXZA==
X-Gm-Message-State: AO0yUKWysV6Ow8kz2+imG4DLY9hc/qVNLgbNbX8iwlMcPUyM0cFz9ZRi
        gbBdEHcPCE6zNsHGrewSpJirY5dV3CfS059VNaY=
X-Google-Smtp-Source: AK7set/3VYpkEzcH8uIJtagU1v6m6jf85whW+6SqgrgbBpAv+3mT/vEiOOjd5xguatkdFz0cVrHK+AXHkVyzf/zglA0=
X-Received: by 2002:ac8:6105:0:b0:3bf:bff3:eb86 with SMTP id
 a5-20020ac86105000000b003bfbff3eb86mr3217726qtm.3.1678117468338; Mon, 06 Mar
 2023 07:44:28 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a05:6214:449c:b0:571:a43f:546a with HTTP; Mon, 6 Mar 2023
 07:44:27 -0800 (PST)
Reply-To: stefanopessina835@hotmail.com
From:   STEFANO PESSINA <biubaomar@gmail.com>
Date:   Mon, 6 Mar 2023 18:44:27 +0300
Message-ID: <CAJTfa2Q5mhVfr1Nu9sSVjK8pkjUJCG=7UaOigZWBbzM_LBzb_Q@mail.gmail.com>
Subject: =?UTF-8?B?RG9uYcibaWUgw65uIG51bWVyYXI=?=
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=4.8 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLYTO,
        FREEMAIL_REPLYTO_END_DIGIT,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        UNDISC_FREEM autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=20
Suma de 1.000.000,00 =E2=82=AC v-a fost donat=C4=83 de STEFANO PESSINA. V=
=C4=83 rug=C4=83m s=C4=83
reveni=C8=9Bi pentru mai multe informa=C8=9Bii prin
stefanopessina835@hotmail.com




The sum of =E2=82=AC1,000,000.00 has been donated to you by STEFANO PESSINA=
.
Kindly get back for more info via stefanopessina835@hotmail.com
