Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4CF863791F
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Nov 2022 13:42:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229675AbiKXMmZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Nov 2022 07:42:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229903AbiKXMmJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Nov 2022 07:42:09 -0500
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F7B7D9BA7
        for <linux-kernel@vger.kernel.org>; Thu, 24 Nov 2022 04:42:01 -0800 (PST)
Received: by mail-pl1-x62a.google.com with SMTP id d20so1362096plr.10
        for <linux-kernel@vger.kernel.org>; Thu, 24 Nov 2022 04:42:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from:reply-to
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=/spAceZjGo7hEwRbpkX1KXC8t1LyoBwzTnObopY/QLY=;
        b=bc+/VoTvLSj8qpcR780fhdqPwG1579XbYK3lu8jvAJ/Klr2rqweYFdvI2S4lM/FKzm
         e9LWTXB238YjFMnGPF8u7z7mH4OETeoVSk9kQf+qpxDO0TkTrKkfOM0dxhM5qIIsHc2W
         V760Rvk2Anzt0EoO4MvE3KuuRM8Mra1eraGX1srDasFWyY6UksDXXS+PC1CGsN/iljcw
         JgLL1jt1FZyDxnAEiRiL4gvCrtThBW1YmntMva1itV4ylq10w4bHX+zmBZZydKsANMdZ
         T8ja6GOdUnoRCaENMXRDBGhal3VjWmZJz2sBYNowJFwD+uFw5fUndjp2xZ7FRkXJC0KG
         wFHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from:reply-to
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/spAceZjGo7hEwRbpkX1KXC8t1LyoBwzTnObopY/QLY=;
        b=JbggwJ1FDiE835BnSjZHHy2yh/Atu3TuqCwIfayPFmBsgVcaiwy5foo6Y6nPSOsB03
         XspSoMVED33NVr69817MFatwiC11KPZgCWuLrBnYT4HpcgrNGO8exRBqX0Fh+Ca0rB12
         Td90qMp1wa3+jPnzlmIljT3GoiBzlt9/ZFP3zeJZJwVDjBoG0UfUMpPtwCw6My8uGL7l
         9vH2X4keJproLqG8q1tm2vjSWeNtfC60Tt8j42rTewcXCXHiNYD4nhMI/e5C/BlftaX0
         7EoBFUQ7oN8GmqD+yd4798gk0SICHfXMCL1TrGvp74ghZIMxK7kpt9hZ+7cyh2mBIhKa
         Jw3A==
X-Gm-Message-State: ANoB5ploZiu2AaFdJ78I+mEyzsFypq96nf+M27MngdsxN3+SaEM1w99/
        a+5QVECHeCtKYohWBCWvp1so3ZwbrnGtMkGOxXM=
X-Google-Smtp-Source: AA0mqf5qHthsmOnntxNBJChWGaan7irEWOn6A+GRwC9Ee7Up94heyvl6P0crNSA25vrc8dDHVupPEDwonEyfKXsrm0w=
X-Received: by 2002:a17:902:d34a:b0:188:f0cb:9ac0 with SMTP id
 l10-20020a170902d34a00b00188f0cb9ac0mr16602856plk.112.1669293720670; Thu, 24
 Nov 2022 04:42:00 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a05:6a11:3ef1:b0:34f:db24:ef0b with HTTP; Thu, 24 Nov 2022
 04:42:00 -0800 (PST)
Reply-To: attorneyjoel4ever.tg@gmail.com
From:   Felix Joel <felixjoel477@gmail.com>
Date:   Thu, 24 Nov 2022 12:42:00 +0000
Message-ID: <CAE2R5QSkjEehrZynNq_w=v7qx-QRmUhdwNJJHnqqU2f9b0_G8Q@mail.gmail.com>
Subject: =?UTF-8?Q?jeg_venter_p=C3=A5_svaret_ditt?=
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=4.8 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,UNDISC_FREEM autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=20
Hallo,
V=C3=A6r s=C3=A5 snill, godta mine unnskyldninger. Jeg =C3=B8nsker ikke =C3=
=A5 invadere
privatlivet ditt, jeg er Felix Joel, en advokat av yrke. Jeg har
skrevet en tidligere e-post til deg, men uten svar, og i min f=C3=B8rste
e-post nevnte jeg til deg om min avd=C3=B8de klient, som har samme
etternavn som deg. Siden hans d=C3=B8d har jeg mottatt flere brev fra
banken hans hvor han gjorde et innskudd f=C3=B8r hans d=C3=B8d, banken har =
bedt
meg om =C3=A5 gi hans n=C3=A6rmeste p=C3=A5r=C3=B8rende eller noen av hans =
slektninger som
kan gj=C3=B8re krav p=C3=A5 hans midler, ellers vil de bli konfiskert og si=
den
Jeg kunne ikke finne noen av hans slektninger. Jeg bestemte meg for =C3=A5
kontakte deg for denne p=C3=A5standen, derfor har du samme etternavn med
ham. kontakt meg snarest for mer informasjon.
Vennlig hilsen,
Barrister Felix Joel.
