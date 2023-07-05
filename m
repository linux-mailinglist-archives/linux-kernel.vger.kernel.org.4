Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38EAF7489C6
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 18:57:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232077AbjGEQ5A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 12:57:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232213AbjGEQ4q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 12:56:46 -0400
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9340A10EA
        for <linux-kernel@vger.kernel.org>; Wed,  5 Jul 2023 09:56:45 -0700 (PDT)
Received: by mail-yb1-xb2e.google.com with SMTP id 3f1490d57ef6-be49ca27e1fso7618790276.3
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jul 2023 09:56:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688576205; x=1691168205;
        h=content-transfer-encoding:to:subject:message-id:date:from:reply-to
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=CMIGP0ZZWT5O2QR0z+yr4OGXplF7Y5GzqDYVMwsXf9Y=;
        b=hZ4mEC8AnHYdUI3jxCd8iY8Q0cslwVz96Rm0UeDZKg3VCgxR3REHc/lEYBkOaWpZ6f
         yIUjdKfV6FMLp0qkeHQ/tyt51aENNNcjrENlvXCJocrR9bo668nIvHmYutOH/UGIQQ2Q
         oJjDq1GBvWdUqA5foFxk36/x/gGUbiSpLv6T+XxUae1+fQb82sD7AgA9Zdg03IZcT6Ov
         tbN/3707QNGPcsC9mv5ZF6+oJd7NmxFUQ1I+lkze5QisAlkeI9uMglSyhZltMHHliclx
         bRLFFITkiGw2xiK9tC+i+eRauyWDtlVktiYAeONbDIlD7aAViyYC4ClzRCBHgGduxqB3
         sVAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688576205; x=1691168205;
        h=content-transfer-encoding:to:subject:message-id:date:from:reply-to
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CMIGP0ZZWT5O2QR0z+yr4OGXplF7Y5GzqDYVMwsXf9Y=;
        b=Coqq8rV+4palof1R8ByRbCuKNt2vRys2Dood7FFJWnw52hMUOKkXecD00zdf4AvEPi
         gZhMR1uIWGSqN/vXNB9MSt4/IiNDdTPL881KsEEc8JxiEvkc42HNAr7Gxnr+F288iRfd
         6LITn+sS3Qtv0THvypYcBsd/6RE/xqOTA7S4hCwKMr41mpE16JQnsHxgfmLc+3VSbXsQ
         vxiXBfkcIeCoEByGCFazxGR6kk1KNOwCa0FjMAvK4ifsyBuESMO3ee3J6273Chfg6SlI
         bSWheizyuoUX5nJrfe/zMf7a5r7dHzXvNysrmV3OhEmFFopQncCnXb3hXPZJjf+VWhn6
         KmAA==
X-Gm-Message-State: ABy/qLZ5HaYSjgsV1/+uKopOjvToKpPaSIj0fBj9qodOsjYAgbFhAt6S
        GEkJQEHGdi35k6ky/9k5139TeEIcvU6BzefHU6Q=
X-Google-Smtp-Source: APBJJlHpVabgTFuOSwRV2brkEJPZ5WP8KD4ugjpm/Lek42eCZr0QjN7mb6LrhfIarpF954yXmyI9qojwUGDV+y7lEf0=
X-Received: by 2002:a25:8b11:0:b0:c39:50fe:79be with SMTP id
 i17-20020a258b11000000b00c3950fe79bemr12423668ybl.61.1688576204717; Wed, 05
 Jul 2023 09:56:44 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:7000:a502:b0:4d4:6b81:32c8 with HTTP; Wed, 5 Jul 2023
 09:56:44 -0700 (PDT)
Reply-To: cristiinacampbell@hotmail.com
From:   INFORMATION <barrmercyjohnson2000@gmail.com>
Date:   Wed, 5 Jul 2023 17:56:44 +0100
Message-ID: <CAFvLHNw1w6F1if-gzBy13z6emrRbG3KyuAj6tFJ0ZwxeOmO07A@mail.gmail.com>
Subject: Yritystarjous
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=4.5 required=5.0 tests=BAYES_50,DKIM_SIGNED,
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

Rakas yst=C3=A4v=C3=A4,

Nimeni on tohtori John Smith; myyntikonsultti Diageo Companyssa
Lontoossa, Iso-Britanniassa, Diageo Company etsii maastasi luotettavaa
henkil=C3=B6=C3=A4 edustamaan heid=C3=A4n tuotteitaan ja tuotemerkkej=C3=A4=
=C3=A4n.

Yritys tarjoaa sinulle 50 % Advance Upfront -tuotteen, jos he ovat
vakuuttuneita siit=C3=A4, ett=C3=A4 olet luotettava ja pystyt edustamaan Yh=
ti=C3=B6n
etuja ja jakamaan tuotemerkkien tuotteita tehokkaasti maassasi ja sen
ymp=C3=A4rill=C3=A4 voiton maksimoimiseksi.

Annan sinulle lis=C3=A4tietoja kuultuani sinusta. Jos olet kiinnostunut
toimimaan Diageo Companyn jakelijana ja edustajana maassasi, ole hyv=C3=A4
ja vastaa minulle alla olevaan henkil=C3=B6kohtaiseen s=C3=A4hk=C3=B6postii=
ni.

Parhain terveisin
Tohtori John Smith
S=C3=A4hk=C3=B6posti; johnoffic@hotmail.com
