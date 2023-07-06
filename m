Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 763217498CD
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jul 2023 11:56:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231628AbjGFJ4l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jul 2023 05:56:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231466AbjGFJ4i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jul 2023 05:56:38 -0400
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com [IPv6:2607:f8b0:4864:20::f35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E36A113
        for <linux-kernel@vger.kernel.org>; Thu,  6 Jul 2023 02:56:36 -0700 (PDT)
Received: by mail-qv1-xf35.google.com with SMTP id 6a1803df08f44-635dd1b52a2so4423306d6.3
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jul 2023 02:56:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688637395; x=1691229395;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=9AzgtpWCF3+Hz3ZhsbJDMqK4tmJOwAYQ6e+X53j2ZZ4=;
        b=UPwKGVSuX2YEC4nVWX8VxuSWW+vsgXlkZIO/eNGWl1goxkKTywZAGcLvtOd1RJKWiR
         o/1m79W5I72HqwI89CCY5iU2NHRbeb7pyjb2MIDXa8yvSvI9DrgWb9t1YaHrnwN79HyY
         WBF8beAIjcv5qIFtdheyNYPt+6UKRuhGYvgbvKDS3LE19Vie43iRPtfyFq4IakLjZRqU
         lc/kdtS1VdzeKBPy0SiJ9JS66q9Hh6N+7GzOU3QIjXSGjkzpoPdAaHQfJRTXcf09gPJf
         IPuYoZsVgLd/qzhJuV5+rm5i6Eva9nYUMSMnerJi4N57aytBjtgmB0O9IaJiiSfW7UGV
         pnkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688637395; x=1691229395;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9AzgtpWCF3+Hz3ZhsbJDMqK4tmJOwAYQ6e+X53j2ZZ4=;
        b=cFEPZYTrS0s4FWlQU6BR9Su+YvKmS6kw2COpwec9FABN5VZNl+2jawXSFMCofiYjWA
         skiIx9X8sdTmVT8xEpiHtIyETnEbJ7u0ysOh/BpP2VN0r9FaEdkSDJ4yQ//EDJiZXlBU
         /qBtW2nVUiOc+7xfLoa7/wd1r8JSzJkf+yJD9E6TvWHj9cSNbzZX+sN/uAg+ws6VF/w6
         6CPCh7oJWGFiPB/nWp4doJnRTDn+cvqG6ugWCdi7TU1tAfBVupJf4iidlPeHdfsUhpF4
         Zp7ZG+7rUC/JFY8V/XakMlhsr3vPsZsyvgP9XYLtG/qVwU3znMB5WP6m7AAgOVVIkc/O
         JtMA==
X-Gm-Message-State: ABy/qLY97xnybcvEcfbXDjIVEViYohASlztWmNcuRlKQ72xL7jiezV4P
        TeD/JkvuoVNKZvh5OzjJXOEfxYDUHmFmrb6xZGYj+2YkztscYlZQp5w=
X-Google-Smtp-Source: APBJJlEUw5Yil4ApBMQr2kcvrNA/T9dN9OEq+SUwsL7MRtu4N+H7vr25EFlbzhxnvZWtRrY5jwHgw6XptFJd6A4oVco=
X-Received: by 2002:a0c:ca06:0:b0:630:1bc8:9c7 with SMTP id
 c6-20020a0cca06000000b006301bc809c7mr1088092qvk.2.1688637395360; Thu, 06 Jul
 2023 02:56:35 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6200:492:b0:50b:7b5f:6dbc with HTTP; Thu, 6 Jul 2023
 02:56:34 -0700 (PDT)
From:   Israel Ojie <israelojie3@gmail.com>
Date:   Thu, 6 Jul 2023 02:56:34 -0700
Message-ID: <CAM8Cj3=+Dn-OytZh8kVk3SGWPSFNdPAKMev12i5po=jfBGv5-Q@mail.gmail.com>
Subject: Aw: Spende
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: Yes, score=5.0 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLY,LOTS_OF_MONEY,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,UNDISC_MONEY autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:f35 listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [israelojie3[at]gmail.com]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [israelojie3[at]gmail.com]
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        *  0.0 LOTS_OF_MONEY Huge... sums of money
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  1.0 FREEMAIL_REPLY From and body contain different freemails
        *  3.2 UNDISC_MONEY Undisclosed recipients + money/fraud signs
X-Spam-Level: *****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=20
Hallo,

Ich bin Maria Elisabeth, eine deutsche Gesch=C3=A4ftsfrau, Investorin, und
nachdem ich meinen Mann im Krankenhausbett verloren hatte, sagte er
mir, ich solle einer guten Person wie Ihnen 1.000.000 Euro spenden.
Ich habe 35 Prozent meines pers=C3=B6nlichen Verm=C3=B6gens f=C3=BCr wohlt=
=C3=A4tige
Zwecke gespendet. Und ich habe auch zugesagt, die restlichen 35% in
diesem Jahr 2023 an Einzelpersonen zu verschenken. Ich habe mich
entschieden, 1.000.000,00 Euro an Sie zu spenden. Wenn Sie an meiner
Spende interessiert sind, kontaktieren Sie mich bitte f=C3=BCr weitere
Informationen.

Lesen Sie den Link, den Sie hier sehen k=C3=B6nnen:
https://en.wikipedia.org/wiki/Maria-Elisabeth_Schaeffler

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

Mit freundlichen Gr=C3=BC=C3=9Fen,
Frau Maria Elisabeth Schaeffler,
Vorsitzende
Supermarktkette.
E-Mail: mariaelisabethschaeffler47@gmail.com
