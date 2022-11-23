Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75697635CB8
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 13:24:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236110AbiKWMYl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 07:24:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235818AbiKWMYi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 07:24:38 -0500
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13E165987B
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 04:24:38 -0800 (PST)
Received: by mail-pj1-x102c.google.com with SMTP id q96-20020a17090a1b6900b00218b8f9035cso1673924pjq.5
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 04:24:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from:reply-to
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=TPHpaIWCl8CJQQVBkvfML4lDlp+sQhHzAHxYHakC4Tg=;
        b=IwQX1xKrdvtlv6IVrd+4DfpPgnYGvI9q9gTpLcF1oAPUy2mBuRYTIkMHm9fW2b7t+N
         vi5OrAF7N05nHXzNkbNINkJjx/RUNaw4Zv6HlGfCctn9VdDWk3TvGsFAIu0/HGRBrhBm
         rkH79/aBSe23DryvKr+o0TxUQ3alzEn4vM2x/mR3e5smOr4/rjTJXEo7lDTjwDLCcmaP
         YKLGiKOrJSMWrwdV/vlshsYjdYn/XOD0EuOi2iM4cwazYdIAp/OwSpLNU9LRuJ+Hp+h8
         2hMtia4alVIlhCQUxO8qFk4sJvtYyuaMfUj4dh6fj8ycfNar5aSX/V/QDmIkyg5uJuRl
         Gr4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from:reply-to
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TPHpaIWCl8CJQQVBkvfML4lDlp+sQhHzAHxYHakC4Tg=;
        b=pPwxNcljWSa69kO/ZfpwZFXhzQlSVQYG9qc12UR4CI3w5WgBXTklSR5uxPw0byzInV
         QdNHdB8Ldq9ZYqTNAbhT6QoHsAqdSVYkRBDxhGUfNCDnKceFowvVBPprQsCpn7YkUfJ/
         zRGb8TuxigIeKeMwyGC3mTipYM/v1uLmG3Tr4Ard1ox94WxaMpnM7za573pNEE5eGk4M
         JZHTi1kAT5+MsW7qO1qTUClkufa3An+Fy0+6zMclCKM2OluaUs5ahiBSio4f07dDtAED
         8sPeYJ7zR9aJ5mfQacwtjILZg2vLXJunXZjuHQteUcUErKQI+UQ0FqeAwrDpNJPqjxfO
         XABg==
X-Gm-Message-State: ANoB5pniRZFiO0YPHt/lsE8lmjqgKKDInH5hoB/Arpp/Kn0NoL9t8/8v
        NljLBVF5W7O+yW+wqPJqHv0izqxUVcmvjPUWa3Y=
X-Google-Smtp-Source: AA0mqf6UrbZHmvteswF50Ss6tvhulvzqfma5WJJz9oyZQNMJG4FK8UeuH5eZEN5cpA4Xmuti5ph9Qjmm67BRcFRPOIY=
X-Received: by 2002:a17:902:aa4a:b0:188:d4ea:2567 with SMTP id
 c10-20020a170902aa4a00b00188d4ea2567mr8692711plr.155.1669206277552; Wed, 23
 Nov 2022 04:24:37 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a17:902:c1d4:b0:189:3744:717c with HTTP; Wed, 23 Nov 2022
 04:24:37 -0800 (PST)
Reply-To: liaahil100@gmail.com
From:   Lil Hilal <frederickjohn655@gmail.com>
Date:   Wed, 23 Nov 2022 04:24:37 -0800
Message-ID: <CA+XYMLGQwdQQfOEAgjLXzs5YJnjJ=AHzUxaoWX-9JH+vPwDK+w@mail.gmail.com>
Subject: Hallo
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: Yes, score=5.0 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,UNDISC_FREEM autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:102c listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [frederickjohn655[at]gmail.com]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [frederickjohn655[at]gmail.com]
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [liaahil100[at]gmail.com]
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        *  2.9 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
X-Spam-Level: *****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hallo, mein Lieber, mein Name ist Lil Hilal (Anw=C3=A4ltin). Ich habe Ihnen
vorhin geschrieben, aber Sie haben nicht geantwortet. Ich brauche Ihre
Hilfe beim Abrufen der Gelder meines verstorbenen Mandanten. Beachten
Sie, dass Ihr Nachname dem Nachnamen meiner verstorbenen Mandantin
=C3=A4hnelt, und das war der Grund, warum ich Sie kontaktiert habe, um mir
zu helfen, die nicht beanspruchten Gelder abzurufen

Gr=C3=BC=C3=9Fe. Lil Hilal
