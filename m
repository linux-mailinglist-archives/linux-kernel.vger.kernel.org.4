Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A88F769F4F8
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Feb 2023 13:58:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231750AbjBVM61 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Feb 2023 07:58:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229980AbjBVM6Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Feb 2023 07:58:25 -0500
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CF912A17F
        for <linux-kernel@vger.kernel.org>; Wed, 22 Feb 2023 04:58:23 -0800 (PST)
Received: by mail-lf1-x143.google.com with SMTP id f18so9902417lfa.3
        for <linux-kernel@vger.kernel.org>; Wed, 22 Feb 2023 04:58:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from:reply-to
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=k95YDgo+L7N0hXDpmFwZDhWIQ5Htbp6x/GQhOUWX7IU=;
        b=GTUq/qHap2OTuJs93l3V9q0bOt/Ad6DsHPOpweLlbk7u0Ya4SdKSMyy2j4DlFZ9zwo
         QqCSnc2TzbM/gG5UFmzy6zhemairSUw2G9J+dKUERgYjo4/BtZctXsXXMdJH3DJ+qa3X
         mK7uWbndz87fT40NbrA+qOiKqUGM34QklTe6EaFk2GJgcf1O3EHDN6IaWo8tYnblcAea
         UnLyRB3lKVn+Ah3WK1gSuqTe/M5I4Yw+PYku6fIKlWulIlG84atdTp1PXMjeSbEmpi7V
         8ITcgGYLXXzGBvLojCBO6xyl36HkEQdluyc+KfL65bqhut39keSloURDIZ4oViU56Dx7
         Cmuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from:reply-to
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=k95YDgo+L7N0hXDpmFwZDhWIQ5Htbp6x/GQhOUWX7IU=;
        b=JSCSObz2fHPdTy04odn1mAXpc1O5bPW8LmPC65ZHBiTMuXNd2uMxsBHdqUw7cE/6mx
         KW9Xt07PO48ktvVs8gV/FkfRyUuFa55lNqeY/gwmpp/vIU4lzK561ziBukqU4se3CZZP
         imN+FVsOljM3ZhrzKh8svKbv0J1IijDDWcmqA9KBnGa3waRt0LbyT2yixW67WVUfgsY5
         60GjXC6yQejenKFbIulnyKr8VCBpNPIwT+XgbEgax9skxB6ufEtrRDqrTlnt9Z2Z1/Gw
         9SmxIYpOSR2uTux13/Lz42BDviw5XTIq/IEbhymdc38yA3nkao3kjhyabhzc4IYST6qU
         MOCg==
X-Gm-Message-State: AO0yUKXMLVtbuqK7UllEeBTgO4+lpWNCi5aK0+XuFBfZwEacXOjCRHcy
        mm3PkpFlaNn1FHepu5T5EBuZdBrwW94wBOT8vbA=
X-Google-Smtp-Source: AK7set+9LIjW2PK6NsQ3/7o3DqR3V3Ul25zH48dgbYrK2fhQ1y3hZvc8rZxxu2qBWAn93/Jsn58/MtB5ts7icBB0ctE=
X-Received: by 2002:ac2:530a:0:b0:4d5:ca42:aee3 with SMTP id
 c10-20020ac2530a000000b004d5ca42aee3mr2730695lfh.3.1677070701493; Wed, 22 Feb
 2023 04:58:21 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a05:6500:d21:b0:189:c794:b6f0 with HTTP; Wed, 22 Feb 2023
 04:58:20 -0800 (PST)
Reply-To: lillymontes49@gmail.com
From:   lilly montes <monteschentel808@gmail.com>
Date:   Wed, 22 Feb 2023 12:58:20 +0000
Message-ID: <CAGNLk_ijSHLjTRfBQufJiWsT2qfNZXh8vi2+GHctb_F3K7_hmg@mail.gmail.com>
Subject: GUTEN TAG
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: Yes, score=5.8 required=5.0 tests=BAYES_60,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,UNDISC_FREEM autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Report: *  1.5 BAYES_60 BODY: Bayes spam probability is 60 to 80%
        *      [score: 0.6154]
        * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2a00:1450:4864:20:0:0:0:143 listed in]
        [list.dnswl.org]
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [monteschentel808[at]gmail.com]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [lillymontes49[at]gmail.com]
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [monteschentel808[at]gmail.com]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        *  3.0 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
X-Spam-Level: *****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Irgendwann letzte Woche schickten wir Ihnen einen Brief mit der Erwartung, =
dass
Ich habe einen Antwortbrief von Ihnen erhalten, aber zu meiner
=C3=9Cberraschung haben Sie ihn nicht erhalten
m=C3=BChe mich zu antworten.
Bitte antworten Sie f=C3=BCr weitere Erkl=C3=A4rungen.

Aufrichtig..

Lilly Montes
