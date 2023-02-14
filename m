Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DC146957C8
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 05:13:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231520AbjBNEM5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 23:12:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231589AbjBNEMv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 23:12:51 -0500
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 141571BAFA
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 20:12:45 -0800 (PST)
Received: by mail-qk1-x744.google.com with SMTP id j22so5649419qka.0
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 20:12:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from:reply-to
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=O3iIghNYce+dgV8YXeRndeSBcZ6lqwpwyBMDGmIlOl8=;
        b=NOaiRQz8/erHu63o/MSbzbiH2dmiIQi0N0YfbT4HXb0CLIBSXOIIVY9SodHRc7V4in
         mRaScclm4RUTavZepiGyN/qUZf/iE4JPpVTY0A6Yc66Z4d0qpGffV/cQinqECPpDZU5t
         L6KpyyNX8vvNsQ4ZAWRGeIeEF+fcOqLovMh8u4oV5EEq/jmZkaOHm9T8kIRAS1e0pTU6
         51haYM1xiLQQyQ9swU++2Ye/KJxfAgNkY9sf00gifLMbKFeUVyN2CBqSl6iIJ5ZNLX8g
         IzicdftGyR6GYUfIyQmjOTYiMKXc26LRh2/NWqFxvVcaR7e2VCJWHRwx+E8aTYLbyGDN
         UKXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from:reply-to
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=O3iIghNYce+dgV8YXeRndeSBcZ6lqwpwyBMDGmIlOl8=;
        b=QV9hr2vddw4H0TdHL3VCaDu4foxXdGPcVfGjITpcqG+rtPElE+JiS4J79FtgHopwjn
         VRQ7VhhbHp52DEBd6fNqcVTqC/N9D+z6KO+99CVXWyXsT6nnO4zFK6kn6dK89K+Hmqq1
         U2uvd4bf7RpwYKHaEWTUZGi8cxGnhfgawvExDsBflhAtJDVztWX1xhI688X5+dc2aZp2
         AzunRqjCyWeDuIzxtoiTALDxyxS6xMFIASZDs9UkFuvJWIsx1MY/Ij7FgXq24qpyd63h
         46O/A3PDHsE/RAYZLIO9XDa/HE653pFcnE2j23O1IOUEwVl1jLf3/AZvcyTT6ZqisKV8
         Lojg==
X-Gm-Message-State: AO0yUKWtT2H4rwiR3t4kyAZ0ZRZ/u/9qfBIrvpvy40XKP86ybAs8iZBK
        43M8PZN2DiWxZ955Akg62eGxj9g5MQx/Pvbz8g==
X-Google-Smtp-Source: AK7set+AdzIq/5rDhtDrF4XiTC+Tcq5dF2Hh0/zQULOdzxDf5Ik2ez3ccExxuOFjvH+3SfGSVMH2ODpSbWFaEto+BZA=
X-Received: by 2002:a37:be47:0:b0:706:2a8e:1992 with SMTP id
 o68-20020a37be47000000b007062a8e1992mr38245qkf.137.1676347963913; Mon, 13 Feb
 2023 20:12:43 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:ac8:6749:0:b0:3bb:740c:7a09 with HTTP; Mon, 13 Feb 2023
 20:12:43 -0800 (PST)
Reply-To: cfc.ubagroup013@gmail.com
From:   Kristalina Georgieva <sergeyforuk@gmail.com>
Date:   Mon, 13 Feb 2023 20:12:43 -0800
Message-ID: <CAKqLMiSq47fbpxPRT+Kr-2rBPfdu8bPaAZjDxqLGJcVOEuoHuQ@mail.gmail.com>
Subject: =?UTF-8?Q?BOAS_NOT=C3=8DCIAS?=
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: Yes, score=5.3 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLYTO,
        FREEMAIL_REPLYTO_END_DIGIT,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        SUBJ_ALL_CAPS,UNDISC_FREEM autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:744 listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  0.5 SUBJ_ALL_CAPS Subject is all capitals
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [sergeyforuk[at]gmail.com]
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [cfc.ubagroup013[at]gmail.com]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        *  3.0 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
X-Spam-Level: *****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Prezado Benefici=C3=A1rio,
Enviei esta carta h=C3=A1 um m=C3=AAs, mas n=C3=A3o tive not=C3=ADcias suas=
, n=C3=A3o
Tenho certeza que voc=C3=AA recebeu, e =C3=A9 por isso que enviei para voc=
=C3=AA novamente,
Em primeiro lugar, sou a Sra. Kristalina Georgieva, Diretora Administrativa=
 e
Presidente do Fundo Monet=C3=A1rio Internacional.

Na verdade, revisamos todos os obst=C3=A1culos e quest=C3=B5es que envolvem
sua transa=C3=A7=C3=A3o incompleta e sua incapacidade de atender =C3=A0s co=
bran=C3=A7as
taxas de transfer=C3=AAncia cobradas, contra voc=C3=AA, pelas op=C3=A7=C3=
=B5es de
transfer=C3=AAncias anteriores, visite nosso site para confirma=C3=A7=C3=A3=
o 38
=C2=B0 53=E2=80=B256 =E2=80=B3 N 77 =C2=B0 2 =E2=80=B2 39 =E2=80=B3 W

Somos o Conselho de Administra=C3=A7=C3=A3o, o Banco Mundial e o Fundo Mone=
t=C3=A1rio
Internacional (FMI) de Washington, DC, juntamente com o Departamento de
Tesouro dos Estados Unidos e algumas outras ag=C3=AAncias de investiga=C3=
=A7=C3=A3o
relevante aqui nos Estados Unidos da Am=C3=A9rica. ordenou
nossa Unidade de Remessa de Pagamentos no Exterior, United Bank of
Africa Lome Togo, para lhe emitir um cart=C3=A3o VISA, onde $
1,5 milh=C3=A3o do seu fundo, para um maior saque do seu fundo.

Durante o curso de nossa investiga=C3=A7=C3=A3o, descobrimos com
consterna=C3=A7=C3=A3o que seu pagamento tenha sido atrasado por funcion=C3=
=A1rios corruptos
do Banco que est=C3=A3o tentando desviar seus fundos para suas contas
privado.

E hoje informamos que seu fundo foi creditado em um cart=C3=A3o
VISA pelo UBA Bank e tamb=C3=A9m est=C3=A1 pronto para ser entregue. Agora
entre em contato com o diretor do UBA Bank, seu nome =C3=A9 Sr. Tony
Elumelu, E-mail: (cfc.ubagroup013@gmail.com)
para lhe dizer como receber o seu cart=C3=A3o VISA Multibanco.

Sinceramente,

Sra. Kristalina Georgieva
