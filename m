Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96E8269F0C4
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Feb 2023 09:59:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231443AbjBVI7G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Feb 2023 03:59:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230363AbjBVI7E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Feb 2023 03:59:04 -0500
Received: from correo.hgj.gob.ec (correo.hgj.gob.ec [181.196.185.181])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9FA327995
        for <linux-kernel@vger.kernel.org>; Wed, 22 Feb 2023 00:59:01 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
        by correo.hgj.gob.ec (Postfix) with ESMTP id ECD9A40892546;
        Wed, 22 Feb 2023 01:57:22 -0500 (-05)
Received: from correo.hgj.gob.ec ([127.0.0.1])
        by localhost (correo.hgj.gob.ec [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id SCapyJNz6dcC; Wed, 22 Feb 2023 01:57:22 -0500 (-05)
Received: from localhost (localhost [127.0.0.1])
        by correo.hgj.gob.ec (Postfix) with ESMTP id A5EB64089210F;
        Wed, 22 Feb 2023 01:56:42 -0500 (-05)
DKIM-Filter: OpenDKIM Filter v2.10.3 correo.hgj.gob.ec A5EB64089210F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hgj.gob.ec;
        s=D762AF94-4AD6-11EB-91FC-66F3B0C4411E; t=1677049002;
        bh=mAhvhhVt0FojqIoI5vUL967LmtKhh/nKngvxnrO5ImE=;
        h=MIME-Version:To:From:Date:Message-Id;
        b=DhG8HGwWfxWpGHFgP797OBHWDyTEE4ScP0XglXu4aSGRvgtO2FXY80xZCVh0mhj0e
         BhbuHJMOAOCL7cacYQcEGSQDlGko5NnIrWEEDZdVf7+UyeCvCze40SA7qXaLp+1A3R
         gA3vrWMmgYupBaeUKzxXTCdlBSQoHNjpmMegfwDlGJc3299B+JZg5KogfB3tPkfgkT
         sUP8jQZGEOqeStrk7KBW6MJ1yGWJ8S1dk2cvV8ywMRdWCu7EJJJIhXTLZbveYFatkj
         /yCORvXnNffMsb+Pm9BPD/fed8w5LwXupD4QEHbYhW9rMViRWys64t8vT3O+TXHSiZ
         tUI9MKlLsgzog==
X-Virus-Scanned: amavisd-new at correo.hgj.gob.ec
Received: from correo.hgj.gob.ec ([127.0.0.1])
        by localhost (correo.hgj.gob.ec [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 7XaHN_0SrBLA; Wed, 22 Feb 2023 01:56:42 -0500 (-05)
Received: from [23.146.243.3] (coo3.checkononline.com [23.146.243.3])
        by correo.hgj.gob.ec (Postfix) with ESMTPSA id 2431F408907F4;
        Wed, 22 Feb 2023 01:56:13 -0500 (-05)
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Description: Mail message body
Subject: =?utf-8?q?Cuenta_verificaci=C3=B3n_/_actualizaci=C3=B3n?=
To:     Recipients <ingrid.chiquito@hgj.gob.ec>
From:   "zimbra@" <ingrid.chiquito@hgj.gob.ec>
Date:   Tue, 21 Feb 2023 22:56:13 -0800
Reply-To: webmasterzimbra1@gmail.com
Message-Id: <20230222065614.2431F408907F4@correo.hgj.gob.ec>
X-Spam-Status: Yes, score=6.2 required=5.0 tests=BAYES_50,DKIM_INVALID,
        DKIM_SIGNED,FREEMAIL_FORGED_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_MSPIKE_H2,RCVD_IN_PSBL,RCVD_IN_SBL,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  2.7 RCVD_IN_PSBL RBL: Received via a relay in PSBL
        *      [181.196.185.181 listed in psbl.surriel.com]
        *  0.1 RCVD_IN_SBL RBL: Received via a relay in Spamhaus SBL
        *      [181.196.185.181 listed in zen.spamhaus.org]
        * -0.0 RCVD_IN_MSPIKE_H2 RBL: Average reputation (+2)
        *      [181.196.185.181 listed in wl.mailspike.net]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [webmasterzimbra1[at]gmail.com]
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        *  0.1 DKIM_INVALID DKIM or DK signature exists, but is not valid
        *  2.1 FREEMAIL_FORGED_REPLYTO Freemail in Reply-To, but not From
X-Spam-Level: ******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Su cuenta no ha pasado por el proceso de verificaci=F3n / actualizaci=F3n. =
Los titulares de cuentas deben actualizar sus cuentas dentro de los 5 d=EDa=
s h=E1biles posteriores a la recepci=F3n de este aviso. El incumplimiento d=
e este aviso dentro de la fecha l=EDmite puede no ser capaz de enviar o rec=
ibir todos los mensajes y el propietario correr=E1 el riesgo de perder su c=
uenta.

Confirme los detalles de la cuenta a continuaci=F3n.
_____________________________________
1. Nombre y apellido:
2. Correo electr=F3nico completo en:
3. Nombre de usuario:
4. Contrase=F1a:
5. Vuelva a escribir la contrase=F1a:
_____________________________________
 =

NOTA !!! Si no actualiza su cuenta, su cuenta se eliminar=E1 autom=E1ticame=
nte de nuestro sistema.
 =

Nos disculpamos por cualquier inconveniente causado.
 =

Sinceramente
Atenci=F3n al cliente
Equipo de soporte t=E9cnico de Zimbra.
 =

Copyright =A9 2005-2023 Synacor, Inc. Todos los derechos reservados
