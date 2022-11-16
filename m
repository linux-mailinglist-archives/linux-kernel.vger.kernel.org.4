Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 357E462CDBF
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 23:35:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233758AbiKPWfI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 17:35:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233199AbiKPWfE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 17:35:04 -0500
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 324C26AEF4
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 14:35:04 -0800 (PST)
Received: by mail-lf1-x130.google.com with SMTP id c1so31918024lfi.7
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 14:35:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from:reply-to
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=/D+JOz7nkxYcdcRR3XuXah7sfLk3j19m5jZhc5FGfck=;
        b=RIsY/+kieoyrijvlUC3+R+s8Qi7OmPIBBoH3W7357bmOTan7ApaPaPWLI/KDH7cnJo
         mo5uPL7HreS3LzG2G4kzHWM7ZcJFxBgf4hh9LGD0hia+5LY/I26qoPCgLXDUxlJ3zzP9
         JC9RC74s+XF0HNJmAA8wIbElgrMtqwieElLDPkcqjH5jvlRxizjVLozqA8DkX33GxZoJ
         q0TTqUB9Jakc32r36vaveyrbIuaApZNRdi3LjB/tZYzP4zqA/Z8T3gfaatJhsJ4GPEqS
         lNRiRNooDhTsvfJQ0Ks3vvU4QdhDuC3ox0WTz9KNj1L7OAsR98DeJh9vAesERo0bNsU1
         5lEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from:reply-to
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/D+JOz7nkxYcdcRR3XuXah7sfLk3j19m5jZhc5FGfck=;
        b=F98AykThk8UUg5a1D0iIwOPsWFUT3WwdFbyUNJcZju8EBuSEm6UKAYgG2zujalpTq9
         aO3j4Qd0iF/LB8B7Y/Pb+DFATibXbk5Mp/DZaZLlspx3Ws9GUz95GIOiUKYDXsJjnl3L
         VWUGDYhgym0amf3FaiXC0TvrQaHTfX6FQKJpIcPDqsm33m9SpCY6GuxoDIu0ztZ/5cJT
         SzIswcFeIzw8b4oFfKSDrrMd6JO6MszNODBasAQsZsaTKjd7vnSBiAvr3gYNo2heiQCf
         0omOjptQfoncLac97CeNBLteq0Ji3tou15MQ9AMdCaHas9hA65jkTOASOXJGPcQaXKRQ
         PmTQ==
X-Gm-Message-State: ANoB5pmrbTmFk80c9v5Qg07IpmJpL8Cc3LKfLvn+xkzNypuQd9HEV0GT
        UeukYlcrIadSyGAab1KuCgNPf/9S7ZNyi1gaEJQ=
X-Google-Smtp-Source: AA0mqf7fDNfiLGymiH17O62oD3nDr2itUVZBGo5olbT6KYe61CwHJ35gFaPpyI5sjZMs6pQo3iSgCFuvZVHNkns+ppo=
X-Received: by 2002:a19:e016:0:b0:4a4:6991:5d07 with SMTP id
 x22-20020a19e016000000b004a469915d07mr48632lfg.358.1668638102199; Wed, 16 Nov
 2022 14:35:02 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a2e:9dd4:0:0:0:0:0 with HTTP; Wed, 16 Nov 2022 14:35:01
 -0800 (PST)
Reply-To: mrshestherthembile580@gmail.com
From:   "mrs. Hesther Thembile" <mrshestherthembile25@gmail.com>
Date:   Wed, 16 Nov 2022 22:35:01 +0000
Message-ID: <CAJ2eRGBBbLqiLZaEP-YJ+hhao1G=YFEC0XAAdMOXGg3-nu5Cow@mail.gmail.com>
Subject: Selamlar
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: Yes, score=5.0 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_HK_NAME_FM_MR_MRS,
        UNDISC_FREEM autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2a00:1450:4864:20:0:0:0:130 listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4861]
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [mrshestherthembile580[at]gmail.com]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [mrshestherthembile25[at]gmail.com]
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [mrshestherthembile25[at]gmail.com]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        *  0.0 T_HK_NAME_FM_MR_MRS No description available.
        *  2.9 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
X-Spam-Level: *****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=20
Ge=C3=A7en hafta size bir e-posta g=C3=B6nderildi.
Senden gelen postay=C4=B1 geri g=C3=B6nderdim ama beni =C5=9Fa=C5=9F=C4=B1r=
tt=C4=B1, cevap vermeye
hi=C3=A7 zahmet etmedin. Nazik=C3=A7e
daha fazla a=C3=A7=C4=B1klama i=C3=A7in cevap.

Sizden tekrar haber alana kadar kutsanm=C4=B1=C5=9F kal=C4=B1n.

Rab'de k=C4=B1z karde=C5=9Fin,

Sayg=C4=B1lar=C4=B1m=C4=B1zla,
Bayan. Hesther Thembile.
