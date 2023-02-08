Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69DB268EE6C
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Feb 2023 13:04:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231200AbjBHMEI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 07:04:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbjBHMEF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 07:04:05 -0500
Received: from mail-io1-xd44.google.com (mail-io1-xd44.google.com [IPv6:2607:f8b0:4864:20::d44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DA2C460AB
        for <linux-kernel@vger.kernel.org>; Wed,  8 Feb 2023 04:04:00 -0800 (PST)
Received: by mail-io1-xd44.google.com with SMTP id r6so6839946ioj.5
        for <linux-kernel@vger.kernel.org>; Wed, 08 Feb 2023 04:04:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from:reply-to
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=SjqeUWDoSs0kIbCfr3nS8TzW819KiR3PYMo9rpWCO4k=;
        b=bXPRL2IO7JwNbKysc0B3vSbLrNEVCFCU5DLL1JI6zOT2yfNlgCvSZfy7pUPC/OAaaP
         BAWsNaA+leqsaGFQd4cH18X5E5yK0ZqccKba1FEMw5qV5GNCN40nhOt886YDD1HFVOjG
         sqckeeIswqA/5wjW1b603p1i40UoNazftPb/w8fZWXgSWu/9A3c2IhKmZ03x11AneUTE
         EnZoZuCQvj+Kof+EPVwcrzs9lvqHX5RdMsCZeNXTcbwdiTs+gAunD3v+gCaz6PSDRxoz
         l1d3ooSxAaqAMXD6WMtdC4pHnHFmUxdPyn9myHQxZlsaIhLJy2LwRNaOtiiXb5nW2mjS
         hzqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from:reply-to
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SjqeUWDoSs0kIbCfr3nS8TzW819KiR3PYMo9rpWCO4k=;
        b=oSwtqqoVEWH8BzoxYTW1VA7pkjMgXxqrUaXByGXc2nNregWO5AmeDx3WsKnfG1LKga
         K+KBNYL8IyyICQpfpAY749k5AksjIt1o+gRI8dRKr7/NUsi+5qJ4vVi8whqEFD9VJSyy
         kKVP9tbifPmGBbPWAjDPTAWPjD9INtGqPXQ74QXDyGCcQptWfIilDGGTBqYrBlSfGGix
         ZiyNS3f14FUBKU27ssZWjoiUJwtv/7u67tVR+TLsh1Ntvqnw6ExYXEOq9nrRbVlmoIkp
         gS6wtlFDanig5z44VQQ8w29o+2YASthcqiLEu+ICAgOfyVvw8iP5a1sKRsIV9DFQNOXx
         GI1A==
X-Gm-Message-State: AO0yUKVFMZWhjAEW2QE/Vxdo4bXjulpybGeUnaBkNmQ/uDZpwlXwyQuq
        NjMV6e3AYyRDuE5qhtgdwHgxoR62MGNcXhRj0jM=
X-Google-Smtp-Source: AK7set9nbrPGCPmc1W83llwMy9MhyS28idmfFifkZ8R+nWJo2A4PsDLfMyi7EpfceSLf+Ut7mUj/Q58Px6gp8v8MrnA=
X-Received: by 2002:a02:8815:0:b0:3be:9943:54f5 with SMTP id
 r21-20020a028815000000b003be994354f5mr3676671jai.84.1675857839426; Wed, 08
 Feb 2023 04:03:59 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a02:8810:0:b0:3b4:8c8e:8d4f with HTTP; Wed, 8 Feb 2023
 04:03:59 -0800 (PST)
Reply-To: georgebrown0004@gmail.com
From:   george brown <joeakaba00@gmail.com>
Date:   Wed, 8 Feb 2023 13:03:59 +0100
Message-ID: <CAEoXQLwegje+NRPty5kJJGHfOivA8r11xN5P++X7r2oOCo9xeg@mail.gmail.com>
Subject: 
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=4.2 required=5.0 tests=BAYES_20,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,UNDISC_FREEM autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Buna ziua

Numele meu este George Brown. Sunt avocat de profesie. vreau sa va ofer
rudele apropiate clientului meu. Ve=C8=9Bi mo=C8=99teni suma de (8,5 milioa=
ne USD)
dolari pe care clientul meu i-a l=C4=83sat =C3=AEn banc=C4=83 =C3=AEnainte =
de moartea lui.

Clientul meu este un cet=C4=83=C8=9Bean al =C8=9B=C4=83rii tale care a muri=
t =C3=AEntr-un
accident de ma=C8=99in=C4=83 =C3=AEmpreun=C4=83 cu so=C8=9Bia sa
si singurul fiu. Voi avea dreptul cu 50% din fondul total, =C3=AEn timp ce
50% va avea
fie pentru tine.
V=C4=83 rug=C4=83m s=C4=83 contacta=C8=9Bi e-mailul meu privat aici pentru =
mai multe
detalii: georgebrown0004@gmail.com

Multe mul=C8=9Bumiri in avans,
Domnule George Brown,
