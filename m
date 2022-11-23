Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFB206358A0
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 11:02:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236804AbiKWKCV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 05:02:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237172AbiKWKAz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 05:00:55 -0500
Received: from mail-il1-x136.google.com (mail-il1-x136.google.com [IPv6:2607:f8b0:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B04811A706
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 01:53:11 -0800 (PST)
Received: by mail-il1-x136.google.com with SMTP id x13so4991661ilp.8
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 01:53:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from:reply-to
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=jYp5ciN+0qztnx6RQRU9dAwf2ffuXWpcwKE4LLsfTYI=;
        b=lCz6WF00d4O+Tal73kRXJROlcVyF48WmIgEfi6QtzIErr8dvbBsFPC3IA/Zgvg3AOx
         pPBRh6hewio/grqJAKDQqlW5ZYaQIcA3RYyjLINQqd/mZafinXFdMZOftnymNKaRQ096
         1fQPVZRVu1nD+aaSDVSgNdmomH50rxmmxi6IQtfAS77oYrcp2D2leewGSKp/IqwjbxVT
         2k9qpv8lb8bwturHOyW4FxMF5eXxwvN/BDXrXV0zw5maBhGR21bzXUUDj08ytwj+/rUE
         a0EozBjX/+aZJBuFs0NkabtvTFTQsgbzX72M5vjsTIdMkXU6jNCHK/nw3cMdBxEWhqXC
         IkJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from:reply-to
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jYp5ciN+0qztnx6RQRU9dAwf2ffuXWpcwKE4LLsfTYI=;
        b=R4ahY4vmpk0UEURaDQ4Dq0CahrqT3nNvIWWUtDmT/N5yh8D1523ZIGeUHEyutUPAWz
         H7ggXqMv5Rt9ebAUsE+twp1yoiJ3q+fSTD2sy1n9a4/XCXbqzcGXl35Mj9LoMxCbjizh
         Zm/rvAIUKd4Wb6eFd0KS+WV09rn/Vz6uaSF92+rGxdMq+bg66lefZd/sACN2VGugCZFI
         m/QU8FdSCguLZbclVWQWpcAkrslteM2PS5C6M4vofHiU1NBP/Q5mhuwNM3WimislpIuX
         2NqEAOZ4PNG4RuulMyiy7/blgQNev2cCpJ0bVWh5AC9Uh+lDq4Fnl8rb4sbgvF6WI4cj
         eEYQ==
X-Gm-Message-State: ANoB5pkTIFE/M3A7DVT8HlHoqJ82MbiU3liwTrURFfJu0YgSeUUqL31x
        TwQ2dw1JSRtRvThr3AoBWQJqY1O8O4/dtfCpof8=
X-Google-Smtp-Source: AA0mqf7iT7AhDxgTNACX6iuzF3c1Y0Vf7cdQBvzzQWrWxRgp5l8IGwiODoFiizJYEE7r9FUhEzfWGABQ8iB1up451jg=
X-Received: by 2002:a92:b0e:0:b0:2fa:52cd:80eb with SMTP id
 b14-20020a920b0e000000b002fa52cd80ebmr3463260ilf.236.1669197190612; Wed, 23
 Nov 2022 01:53:10 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a05:6e02:1e08:0:0:0:0 with HTTP; Wed, 23 Nov 2022 01:53:10
 -0800 (PST)
Reply-To: cristinacampel@outlook.com
From:   "Mrs. Cristina Campbell" <sa6917671@gmail.com>
Date:   Wed, 23 Nov 2022 09:53:10 +0000
Message-ID: <CAJOk5_qf2fELfvtszToaF6UQvoO5CzQczrHStkBttzxUuwAsdA@mail.gmail.com>
Subject: =?UTF-8?Q?K=C3=B6nnen_Sie_ein_H=C3=A4ndler_unserer_Produkte_werden=3F?=
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=4.8 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_HK_NAME_FM_MR_MRS,UNDISC_FREEM autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sehr geehrter Herr / Frau


Mein Name ist Dr. John Smith; ein Verkaufsberater bei Diageo Company
London, Vereinigtes K=C3=B6nigreich, Diageo Company sucht nach einer
zuverl=C3=A4ssigen Person in Ihrem Land, die ihr Vertreter als Distributor
ihrer Produkte und Marken sein kann.

Das Unternehmen stellt Ihnen 50 % Vorauszahlung f=C3=BCr das Produkt zur
Verf=C3=BCgung, wenn es davon =C3=BCberzeugt ist, dass Sie zuverl=C3=A4ssig=
 sind und
die F=C3=A4higkeit haben, die Interessen des Unternehmens zu vertreten und
die Markenprodukte zur Gewinnmaximierung effektiv in und um Ihr Land
herum zu vertreiben.

Ich werde Ihnen weitere Einzelheiten mitteilen, nachdem ich von Ihnen
geh=C3=B6rt habe, und wenn Sie daran interessiert sind, ein Distributor und
Vertreter der Diageo Company in Ihrem Land zu werden, antworten Sie
mir bitte auf meine unten angegebene pers=C3=B6nliche E-Mail.

Mit freundlichen Gr=C3=BC=C3=9Fen
Dr. John Smith
E-Mail; johnoffic@hotmail.com
