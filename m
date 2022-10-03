Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EA825F310C
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Oct 2022 15:18:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230101AbiJCNSu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Oct 2022 09:18:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230162AbiJCNSm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Oct 2022 09:18:42 -0400
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com [IPv6:2607:f8b0:4864:20::843])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CAA9B92
        for <linux-kernel@vger.kernel.org>; Mon,  3 Oct 2022 06:18:41 -0700 (PDT)
Received: by mail-qt1-x843.google.com with SMTP id w2so6269700qtv.9
        for <linux-kernel@vger.kernel.org>; Mon, 03 Oct 2022 06:18:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from:reply-to
         :mime-version:from:to:cc:subject:date;
        bh=rmkGPy6VmDRy6+8kEWq+V0Sst7xyvToKWWddQt+Ywl8=;
        b=iW5uKWBxuCtsAdpYgGijZrAyLPSpHdgW1pkVjY4DMmrP3SEt0ZnpR+YYFaQMq7nJw+
         GORU8xOHBMC/l3T6TMVVYWyPbzBvVKq7p3xSC7UpEK3CdPJorMj20kNVh6l3/Oac7Jme
         JewFDphYm030Nz5MmAmoNCw6N4Onk/bFvpJ4MbH0YuLbqq1TabwKfqHFkIZmhiP9TCi7
         V02wIhtXj9HgOanmwlyC5SHXNT822wOu874ZGcsb8uqeX53GaVHwXw13HGjeuiyByU8w
         NlatEXHLf+aL1MvalKRU80Un70O9KYyKgen9A4CL+bW4Zw9c4r46j20ZAfAzuEU/l812
         vEKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from:reply-to
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=rmkGPy6VmDRy6+8kEWq+V0Sst7xyvToKWWddQt+Ywl8=;
        b=5CzM7GzOvP7LXEn45orFSfnO+CIeNpSIGixsMoOp5OF0W+MZOQeZgL/wGxVVHM0p+t
         I80iS5uJZv81G3Q+XQZQl36nWW4TMtEFEdPo8ocekFkWjnh7C/I/+jWuaJMVfuDEfETf
         M4QcHM1pyaIVA09Fv/Tl+J0PqbONEOm3AE0lr53w/moOhOzm8og8t6SXH+rwq4aRB/xJ
         +jatWvuxmCRN6d4hwmlWhHeQKuDh8h4Goth1dNbwEQPqkqR+4O7KtDxtcHwF4X0yFws/
         2LjRhduauPlp/3cU8Dmdo9o2LFevHy/D8g6m8OE35sg2qUQFXEXMkIOvR+rTgWpqPCNL
         oW9A==
X-Gm-Message-State: ACrzQf0Coj56jfLAHShbeEb3RwV/bP1JuHJVvU/4LPDOoPiy3wKdu77z
        feUt7nZpt4R1nddQJi1OnkS8ZbPLQSh/15r14OE=
X-Google-Smtp-Source: AMsMyM7LyjDmcTv49GdCNHRjngLUgzzo78oCzl05kmnsoV76U7GOqcmxSjx2X9r2y0TtdC5DBiRTcEEni9qkFjsDrxQ=
X-Received: by 2002:a05:622a:1391:b0:35d:fb0:d830 with SMTP id
 o17-20020a05622a139100b0035d0fb0d830mr15446793qtk.607.1664803120249; Mon, 03
 Oct 2022 06:18:40 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ad4:5aa2:0:0:0:0:0 with HTTP; Mon, 3 Oct 2022 06:18:39 -0700 (PDT)
Reply-To: donaldphilip801@gmail.com
From:   James Williame <jameswilliame730@gmail.com>
Date:   Mon, 3 Oct 2022 06:18:39 -0700
Message-ID: <CAJN_m4cMR=GvKNbM4bv+ov7ko7uS65n9xa6Hvw1nw5hpzfw40w@mail.gmail.com>
Subject: ATM CARD
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: Yes, score=5.2 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,UNDISC_FREEM autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:843 listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4966]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [jameswilliame730[at]gmail.com]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [jameswilliame730[at]gmail.com]
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [donaldphilip801[at]gmail.com]
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        *  3.1 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
X-Spam-Level: *****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Drah=C3=BD p=C5=99=C3=ADteli

Jak se dnes m=C3=A1=C5=A1? Mysl=C3=ADm, =C5=BEe od na=C5=A1=C3=AD posledn=
=C3=AD komunikace uplynula
dlouh=C3=A1 doba. Ka=C5=BEdop=C3=A1dn=C4=9B v=C3=A1s znovu kontaktuji ohled=
n=C4=9B na=C5=A1=C3=AD p=C5=99edchoz=C3=AD
transakce, kter=C3=A1 s v=C3=A1mi nebyla =C3=BAsp=C4=9B=C5=A1n=C4=9B dokon=
=C4=8Dena. Bylo ne=C5=A1=C5=A5astn=C3=A9, =C5=BEe
va=C5=A1e partnerstv=C3=AD se mnou nedok=C3=A1zalo dokon=C4=8Dit p=C5=99evo=
d fondu. Nev=C3=ADm,
mo=C5=BEn=C3=A1 kv=C5=AFli velk=C3=A9mu tlaku jste nuceni ztratit z=C3=A1je=
m o transakci.

V ka=C5=BEd=C3=A9m p=C5=99=C3=ADpad=C4=9B jsem r=C3=A1d, =C5=BEe v=C3=A1s m=
ohu informovat o m=C3=A9m =C3=BAsp=C4=9Bchu p=C5=99i
p=C5=99evodu fondu ve spolupr=C3=A1ci s nov=C3=BDm partnerem z Venezuely. M=
oment=C3=A1ln=C4=9B
jsem ve Venezuele kv=C5=AFli investici. Nezapomn=C4=9Bl jsem v=C5=A1ak na v=
a=C5=A1e minul=C3=A9
snahy a pokusy pomoci mi p=C5=99i p=C5=99evodu fondu, p=C5=99esto=C5=BEe js=
me nemohli
dosp=C4=9Bt ke konkr=C3=A9tn=C3=ADmu z=C3=A1v=C4=9Bru. Jako ocen=C4=9Bn=C3=
=AD va=C5=A1=C3=AD snahy mi pom=C3=A1hat jsme
se j=C3=A1 a m=C5=AFj nov=C3=BD partner rozhodli, =C5=BEe v=C3=A1m vynahrad=
=C3=ADme 850 000,00 $,
abyste s n=C3=A1mi mohli za=C5=BE=C3=ADt radost a =C5=A1t=C4=9Bst=C3=AD.

Nechal jsem va=C5=A1i kartu s kompenza=C4=8Dn=C3=ADm v=C3=ADzem u sv=C3=A9 =
sekret=C3=A1=C5=99ky, aby mi
pomohla ji poslat. Nyn=C3=AD kontaktujte mou sekret=C3=A1=C5=99ku v Togu, j=
menuje se
pan=C3=AD Donald Philip a jej=C3=AD e-mail je: < donaldphilip801@gmail.com =
>.
=C5=98ekn=C4=9Bte j=C3=AD, aby v=C3=A1m poslala kartu s v=C3=ADzem do banko=
matu v hodnot=C4=9B 850
000,00 $. V tuto chv=C3=ADli jsem zde ve Venezuele velmi zanepr=C3=A1zdn=C4=
=9Bn kv=C5=AFli
investi=C4=8Dn=C3=ADm projekt=C5=AFm, kter=C3=A9 j=C3=A1 a nov=C3=BD partne=
r m=C3=A1me po ruce. Rychle se
spojte s pan=C3=AD Donald Philipovou a =C5=99ekn=C4=9Bte j=C3=AD, kam v=C3=
=A1m m=C3=A1 poslat
kompenza=C4=8Dn=C3=AD v=C3=ADzovou kartu. Kartu v=C3=A1m bez prodlen=C3=AD =
za=C5=A1le. P=C5=99eji v=C3=A1m
hodn=C4=9B =C5=A1t=C4=9Bst=C3=AD ve v=C5=A1ech va=C5=A1ich snah=C3=A1ch.

james williame
