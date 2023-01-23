Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0D6167795B
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 11:41:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231848AbjAWKl3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 05:41:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230241AbjAWKl1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 05:41:27 -0500
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com [IPv6:2607:f8b0:4864:20::f34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B57F513DC0
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 02:41:26 -0800 (PST)
Received: by mail-qv1-xf34.google.com with SMTP id t7so8796986qvv.3
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 02:41:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :references:in-reply-to:reply-to:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=vInRThZKXVUC1ZA1/3kxwUYMEp/+QiJOzDcEeepAllQ=;
        b=izOe7URMiRPRDMQuR1Jb2PPVmDFxtw65T+ujTCan3mSgSScPbCFPTeKhXfh3OQ7mU1
         ry1wSFqW1KZGnV4RmQUEW0gsrGQibNnCXtL+K6uMi+scW9m4AvVHRsqFiWa7Kzswh1Ot
         qhiMnfkHfXBw7VU1cVLEJlW+32rXx+F5WvaconINlBaUOUTccGcootw3FjsPDTbbpS9n
         JUC5Cz6LSQHA6zaws6cZZ88jvhsTJoi6fbjRRHVDFvCMvLH+Qb7gUoH3l+RTgVt8dm97
         As3H/gnXaAEN3l6ZSGji9HLZauW94SJQ7IX5rfBXFPWdnsGqXWYDwcf0vopDV07W8Ewo
         2zUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :references:in-reply-to:reply-to:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vInRThZKXVUC1ZA1/3kxwUYMEp/+QiJOzDcEeepAllQ=;
        b=PkuD9sQm9wCn4+Ym83atGBPvO07DPFb9z0jmEIYVXN2Q2DEuQMpDSriD6TbKwqWGIA
         no579lT1e8+/t4Oh+63WRqf47fTKz6srG6E+a719lFjhmhHyWn+DHxNtcSYBI3tBAVsp
         gjBjetlF1MN2NBQQc+FwCdwxsPUydfDQocvArPTovWuB9nVny1f55m1FV0FU9TVAVPjM
         N7/1Rimk8X/lsWo+qBm9hK1ypYRm2E6DzrlUl2ZkbPzOGN3hssP2qMIGMO1/5COZH1yv
         0d3t1dT0ZQFh8t2wA6V2G7WFnN+ezdEl6OXFcIQOY5YPPNOU6ES5jK0Uw/taQBpCge7B
         0KFg==
X-Gm-Message-State: AFqh2krAKWch0RTGGkhoVzNQEJE6qJkzj+kvlPpti6J3aGe/Too10SYW
        I7raLqvs1zo5K9lJomhqrHjDN5WexsM5qPIOYJI=
X-Google-Smtp-Source: AMrXdXs1mOen7o3oUCm67nVGhx2E2FPc2eI2VXrrcjBrr42CMR2ZPJ2qcICghmSuPF+dPnP5QTE2v9Zre/YiQj0drpU=
X-Received: by 2002:a05:6214:3484:b0:534:7205:e661 with SMTP id
 mr4-20020a056214348400b005347205e661mr1245097qvb.46.1674470485583; Mon, 23
 Jan 2023 02:41:25 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:ac8:5e52:0:0:0:0:0 with HTTP; Mon, 23 Jan 2023 02:41:25
 -0800 (PST)
Reply-To: Eibheadoffice@accountant.com
In-Reply-To: <CAFscNxOGgdmwM0CkjKNnBReUnV9280-Q6G4TJiAauUcHpc-Ewg@mail.gmail.com>
References: <CAFscNxOGgdmwM0CkjKNnBReUnV9280-Q6G4TJiAauUcHpc-Ewg@mail.gmail.com>
From:   mrs kristalina georgieva <affoussatousambo8@gmail.com>
Date:   Mon, 23 Jan 2023 11:41:25 +0100
Message-ID: <CAFscNxNc=5Y9-0+F0nC=oDmxw8a7Saqnt8L8=T1ywH3HYw6T5A@mail.gmail.com>
Subject: Attn: korisniku fonda,
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: Yes, score=7.9 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,LOTS_OF_MONEY,MONEY_FREEMAIL_REPTO,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_HK_NAME_FM_MR_MRS,
        UNDISC_FREEM,UNDISC_MONEY autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:f34 listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [affoussatousambo8[at]gmail.com]
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [affoussatousambo8[at]gmail.com]
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        *  0.0 LOTS_OF_MONEY Huge... sums of money
        *  0.0 T_HK_NAME_FM_MR_MRS No description available.
        *  2.8 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
        *  0.0 MONEY_FREEMAIL_REPTO Lots of money from someone using free
        *      email?
        *  3.2 UNDISC_MONEY Undisclosed recipients + money/fraud signs
X-Spam-Level: *******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Attn: korisniku fonda,

Europska investicijska banka iz Londona i MMF ovlastili su nas da
istra=C5=BEimo razloge nepotrebno odobrenih odgo=C4=91enih sredstava. Tijek=
om
na=C5=A1e istrage otkrili smo da su va=C5=A1u isplatu odgodili korumpirani
slu=C5=BEbenici iz nekih banaka koji su poku=C5=A1ali preusmjeriti va=C5=A1=
a sredstva
na va=C5=A1e osobne ra=C4=8Dune.

Kako bismo zaustavili sumnjivi =C4=8Din, dogovorili smo se s Europskom
investicijskom bankom iz Londona i Me=C4=91unarodnim monetarnim fondom
(MMF) da mo=C5=BEemo obraditi ovu uplatu i pratiti je. Izbjegavajte o=C4=8D=
ajne
situacije s bankama i drugim tijelima u kaznenim postupcima.

Od MMF-a smo dobili neopozivu garanciju pla=C4=87anja za va=C5=A1u uplatu.
=C5=BDeljeli bismo vas obavijestiti da je Europska investicijska banka
odlu=C4=8Dila nadoknaditi vam iznos od 1.000.000,00 USD i prebaciti ga na
va=C5=A1 bankovni ra=C4=8Dun putem bankovnog prijenosa. Obratite se Europsk=
oj
investicijskoj banci na adresu e-po=C5=A1te u nastavku.

Banka pla=C4=87anja: Europska investicijska banka
E-po=C5=A1ta: Eibheadoffice@accountant.com
Kontaktirajte nas na Whatsapp: +447933207234
Kontakt osoba: Dr. Mr. Michael Webster

Obavezno kontaktirajte gore navedenu banku bez odlaganja za kona=C4=8Dno
osloba=C4=91anje i prijenos va=C5=A1eg fonda. Europska investicijska banka =
mora
bez odlaganja prenijeti va=C5=A1a sredstva na va=C5=A1 bankovni ra=C4=8Dun.

Pretpostavljamo va=C5=A1u hitnu suradnju.

Hvala.
