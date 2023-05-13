Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D929701619
	for <lists+linux-kernel@lfdr.de>; Sat, 13 May 2023 12:16:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233374AbjEMKQS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 May 2023 06:16:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233748AbjEMKQQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 May 2023 06:16:16 -0400
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DA6119A6
        for <linux-kernel@vger.kernel.org>; Sat, 13 May 2023 03:16:15 -0700 (PDT)
Received: by mail-yb1-xb2d.google.com with SMTP id 3f1490d57ef6-ba6fa8be5f7so2818305276.0
        for <linux-kernel@vger.kernel.org>; Sat, 13 May 2023 03:16:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683972974; x=1686564974;
        h=content-transfer-encoding:to:subject:message-id:date:from:sender
         :reply-to:mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=1/mYDthqIZEuEOLDfdiZBvh92qN4dXiUcAlu4QRTyt8=;
        b=Hn7huzVvd2d77ozpSowLVtoCRyghNObiRFiQOkcZTXmd5ZjuEVbhesQnTnB2NeUrEE
         RE7TdGCFB6St6QCu8dw8D8BrhUBLI/4fiVjVCKnYQ192R2d5ovK9GU28xmX+wk9u1YnK
         Ck52Uo2h5krwT4s12TJ7bwySQ2T1fJhyPxuCEdbAHETwFmF0807O2ewMYoSalk7qq6mh
         breO/2ZNg7PR2KKetVVtlLZenLPOYvL0gNh/gKaE3pTMa1cOvauFCVhKGpalQ2/v5A0a
         v8i89SnCZFk+Sme6LBn1OpOEGkQ++gm7tzuMpifWExxH5Hx3v3uTPklfkI6d5QDrhH2i
         nyqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683972974; x=1686564974;
        h=content-transfer-encoding:to:subject:message-id:date:from:sender
         :reply-to:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1/mYDthqIZEuEOLDfdiZBvh92qN4dXiUcAlu4QRTyt8=;
        b=TNuvVSIgz1TjZr+9lPxZQhQ7+rGdDaBVMX0EY4Yo/dB4+xzz5yPoiUCw94+4KEpNCZ
         CrpMbtkJP5xQa8OAb/xbMePH+SBIl/7W4LgitaedN1/0Y6OV6aGOOCOk0aRjEihX+2fU
         kO6NQy1CCYNWRdTa2JhjepXshvmSIYZku6+0NEEdZwOG4MR9a1jbc8i1c5wtTHLdE14P
         cdMcH0iJMplOiAptdeXMh008aHxkX5M6bOPKOu2r6eo0DbsRprJk7KwWM7HdpNx5tC8w
         qXo6NKPOx1RU6GHRRz3vJ8DsQ8Ok0Um5ns2o6Nf9B4ExbXswWtPZOzNrJ+J0o6+X/E7s
         3nUA==
X-Gm-Message-State: AC+VfDzaCNO7uwsgjG6y27o5kzQjkLx6r5O0KBqG/KDmqEr26GCZJUCG
        IfB9BEIlZLHqKoYRZFSSmZGzU2ir3kZv5k7PbPY=
X-Google-Smtp-Source: ACHHUZ5SUzVW7XeEUVh4kqnqXrgxQfySRuadC6fjsjZ1kijLuOuf/+V7E6ZgUcGJ//GwZ707VNf1wlZ1ZYMIZKxKrA8=
X-Received: by 2002:a25:25cf:0:b0:ba7:4ef5:1ffc with SMTP id
 l198-20020a2525cf000000b00ba74ef51ffcmr1616061ybl.41.1683972973925; Sat, 13
 May 2023 03:16:13 -0700 (PDT)
MIME-Version: 1.0
Reply-To: zahirikeen@gmail.com
Sender: issasalif505@gmail.com
Received: by 2002:a05:7010:360f:b0:34b:cf64:b219 with HTTP; Sat, 13 May 2023
 03:16:13 -0700 (PDT)
From:   Zahiri Keen <mrzahirikeen1@gmail.com>
Date:   Sat, 13 May 2023 10:16:13 +0000
X-Google-Sender-Auth: sZmdmTWQemof8oWb0khilL_0Gu8
Message-ID: <CAO1GMASWj+d_D13E3erdt8eXBCgpFK8UpwrZ5HyU1ReWcW0ShQ@mail.gmail.com>
Subject: Urgent Please.
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=4.6 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNDISC_FREEM autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  I know this email might come to you as a surprise because is coming
from someone you haven=E2=80=99t met with before.

I am Mr. Zahiri Keen, the bank manager with BOA bank i contact you for
a deal relating to the funds which are in my position I shall furnish
you with more detail once your response.

Regards,
Mr.Zahiri
