Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92FF15EA9EC
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 17:14:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235656AbiIZPO2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 11:14:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235897AbiIZPNI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 11:13:08 -0400
Received: from mail-oa1-x33.google.com (mail-oa1-x33.google.com [IPv6:2001:4860:4864:20::33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C844F7C767
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 06:53:28 -0700 (PDT)
Received: by mail-oa1-x33.google.com with SMTP id 586e51a60fabf-130bd20fae6so9266531fac.9
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 06:53:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from:sender
         :mime-version:from:to:cc:subject:date;
        bh=rvST2aDVGvDCU3HMgHNHnrp8ARz+qwXlplbLfK2nA2M=;
        b=C9+GdXBaUSTz77sQKqG5qr8H3XJj/G+OE3Bhtu22E2hTlfwZREw7xw9dSk9wk7wUQ7
         PC3rVuJwatLhhpjrnx0Y3AvxLmzIO28fFLzq/sWb2Mh24OLgclIBbGGhRPHXdzFaG8Nh
         XXM2J2GRS2pUaQHOFahzvy0Gi+dq1ADzXIiz+x5bzSnFUlZL3GSRq6cPTFXz6qfutVal
         nEJ/51SJM+bn+/AKGeRr2hV4/vzuTZu+v5A8qVvvH164oHO256IkpR4koG1hdWFYu6LA
         BBCF2iD2icZB5CXmc+V8k8hvpPJ6QKhGB5aBOt2pv+uEasc51jkOwSPz6jt4SsUW6AeY
         uRSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from:sender
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=rvST2aDVGvDCU3HMgHNHnrp8ARz+qwXlplbLfK2nA2M=;
        b=pm1qHwqMGk1kqkp4mMznqbPw5x8p2v5bN6U/k9m5ML2TNljKskuPOvHnZq+hMs2kJK
         441bZiN6bl7p6WGrKjBoEBxNloqaL4E1S5NVxS6Ba1YzSXVRQAQgW0R0KJm4fwk0UoHo
         /iRabbekK5X2PWYCQaQwRLQ2K9jbmQyAbU1UFoKA3xvL2nV/MVaY7qvV1exzIs/6Cv/z
         AieUDrOIIo6PeK8csMh6PTDx/vqjYzvubPgZSXDV/R/U5o9vrAL7G0f033y+KQfg/Esh
         RDNsKRXlvzy0ffRtsHKuwFrBmPg1aHjR/Yx+SUpj5BeeXis7gDa7udSCxJ4U7d4j+f4A
         jppw==
X-Gm-Message-State: ACrzQf2wMa5jUwDazdxmxB9S1Lb2sGCv1GcDV0hXpdwC+2IRSJ29qlFg
        aDAAZENucp8BW4JDzd+Lcb/nYm2ZBreZdyH4hGjZjUzszFhFHA==
X-Google-Smtp-Source: AMsMyM7ckq0iV1tViqx93t+NotM3Q26YFdC7NpEZIwdljX88t6+h5oAmqstkp2CUzmt6JWq/fIAYzObBVpMlm9KqadI=
X-Received: by 2002:a05:6870:46a8:b0:128:b162:621a with SMTP id
 a40-20020a05687046a800b00128b162621amr18641033oap.90.1664200397622; Mon, 26
 Sep 2022 06:53:17 -0700 (PDT)
MIME-Version: 1.0
Sender: huganbrooks811@gmail.com
Received: by 2002:a4a:b141:0:0:0:0:0 with HTTP; Mon, 26 Sep 2022 06:53:16
 -0700 (PDT)
From:   "Mrs.Maya" <mayaouedrago22@gmail.com>
Date:   Mon, 26 Sep 2022 13:53:17 +0000
X-Google-Sender-Auth: xUn_FAHji0uExJUd9pIEK8t-PsI
Message-ID: <CAFUf7Zm3gzgn+x-682+xxQpUg29R2BN=8zOR96mnjgnNv580gQ@mail.gmail.com>
Subject: Re: hola
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=4.1 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,HK_RANDOM_FROM,LOTS_OF_MONEY,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_HK_NAME_FM_MR_MRS,UNDISC_MONEY autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Re: hola

Te escribo este correo con muchas l=C3=A1grimas en los ojos y gran
dolor en mi coraz=C3=B3n, Mi Nombre es Sra. Maya ouedrago, soy de T=C3=BAne=
z y
me comunico con usted desde un Hospital en Burkina Faso, quiero
decirle esto porque no tengo otra opci=C3=B3n que decirle como era.
Conmovido por abrirme a usted, me cas=C3=A9 con el Sr. Ouedrago Brown,
quien trabaj=C3=B3 con el Embajador de T=C3=BAnez en Burkina Faso durante n=
ueve
a=C3=B1os antes de morir en el a=C3=B1o 2010. Estuvimos casados =E2=80=8B=
=E2=80=8Bdurante once
a=C3=B1os sin un hijo.

Muri=C3=B3 despu=C3=A9s de una breve enfermedad que dur=C3=B3 solo cinco d=
=C3=ADas. Ya que
Despu=C3=A9s de su muerte, decid=C3=AD no volver a casarme. Cuando mi difun=
to
esposo estaba vivo, deposit=C3=B3 la suma de US$ 8,5 millones (ocho
millones quinientos mil d=C3=B3lares) en un banco en Uagadug=C3=BA, la capi=
tal
de Burkina Faso, en el oeste de =C3=81frica. Actualmente, este dinero
todav=C3=ADa est=C3=A1 en el Banco. Puso este dinero a disposici=C3=B3n par=
a la
exportaci=C3=B3n de oro de la miner=C3=ADa de Burkina Faso.

Recientemente, mi m=C3=A9dico me dijo que no durar=C3=ADa el per=C3=ADodo d=
e
siete meses debido a un problema de c=C3=A1ncer. El que m=C3=A1s me inquiet=
a es
mi enfermedad del accidente cerebrovascular. Habiendo conocido mi
condici=C3=B3n, decid=C3=AD entregarle este dinero para que se ocupe de las
personas menos privilegiadas, utilizar=C3=A1 este dinero de la manera que
le instruir=C3=A9 en este documento. Quiero que tome el 30 por ciento del
dinero total para su uso personal Mientras que el 70% del dinero se
destinar=C3=A1 a personas de caridad en la calle y ayudando al orfanato.
Crec=C3=AD como hu=C3=A9rfano y no tengo a nadie como mi familia. miembro, =
s=C3=B3lo
para esforzarse en que la casa de Dios se mantenga.

Hago esto para que Dios perdone mis pecados y acepte mi alma en
su para=C3=ADso porque esta enfermedad me ha hecho sufrir tanto.

Tan pronto como reciba su respuesta le dar=C3=A9 el contacto del
banco en Burkina Faso y tambi=C3=A9n instruir=C3=A9 al Gerente del Banco pa=
ra
emitirle una carta de autoridad que le probar=C3=A1 el presente
beneficiario del dinero en el banco, es decir, si me aseguras que
actuar=C3=A1s en consecuencia como he dicho aqu=C3=AD.

De la Sra. Maya ouedrago
