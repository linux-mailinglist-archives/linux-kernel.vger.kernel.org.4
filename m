Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74D2F74C1D5
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Jul 2023 12:15:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230298AbjGIKPA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Jul 2023 06:15:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229593AbjGIKO7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Jul 2023 06:14:59 -0400
X-Greylist: delayed 785 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 09 Jul 2023 03:14:56 PDT
Received: from mail.heg.gob.ec (mail.heg.gob.ec [186.47.84.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7718E9C
        for <linux-kernel@vger.kernel.org>; Sun,  9 Jul 2023 03:14:56 -0700 (PDT)
Received: from heg.gob.ec (unknown [10.10.10.2])
        by mail.heg.gob.ec (Postfix) with ESMTP id 8A4256107EEF;
        Sun,  9 Jul 2023 04:55:32 -0500 (-05)
Received: from localhost (localhost [127.0.0.1])
        by heg.gob.ec (Postfix) with ESMTP id A4919E16574B8;
        Sun,  9 Jul 2023 04:54:57 -0500 (-05)
Received: from heg.gob.ec ([127.0.0.1])
        by localhost (heg.gob.ec [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id pPk8oMSTpouZ; Sun,  9 Jul 2023 04:54:57 -0500 (-05)
Received: from localhost (localhost [127.0.0.1])
        by heg.gob.ec (Postfix) with ESMTP id 8E528E132C34F;
        Sun,  9 Jul 2023 04:23:04 -0500 (-05)
DKIM-Filter: OpenDKIM Filter v2.10.3 heg.gob.ec 8E528E132C34F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=heg.gob.ec;
        s=03034450-EF7C-11ED-84F8-2903654E080F; t=1688894584;
        bh=10NcWloSzjbrkgR8ZipZgBic23aM8dztmAtQ8hqzLyQ=;
        h=MIME-Version:To:From:Date:Message-Id;
        b=npS0iUeSjflBmztMwyCp7K+hUqLZgnOD6g6O2eOX5kat8y6AWgwpzV2LiIaQDzfvA
         kgAW6fhfgWDW3HuYcSkB00Pt/AT6v5R7rGHb0PyI/0xNuBgvmcuB3kcnIRT1b5tl87
         kVJN7tClxqvYNWduMosxoUNiMKgl3B5hfztj/XKQ=
X-Virus-Scanned: amavisd-new at heg.gob.ec
Received: from heg.gob.ec ([127.0.0.1])
        by localhost (heg.gob.ec [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id SH06fLA_wQ9B; Sun,  9 Jul 2023 04:23:04 -0500 (-05)
Received: from [23.146.243.30] (unknown [138.10.0.10])
        by heg.gob.ec (Postfix) with ESMTPSA id 439B7E132C362;
        Sun,  9 Jul 2023 04:06:28 -0500 (-05)
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Description: Mail message body
Subject: =?utf-8?q?Cuenta_Verificaci=C3=B3n?=
To:     Recipients <indira.acosta@heg.gob.ec>
From:   "@zimbra" <indira.acosta@heg.gob.ec>
Date:   Sun, 09 Jul 2023 05:08:24 -0700
Reply-To: webmasterzimbra1@gmail.com
Message-Id: <20230709090628.439B7E132C362@heg.gob.ec>
X-HEG-MailScanner-Information: Please contact the ISP for more information
X-HEG-MailScanner-ID: 8A4256107EEF.A61A3
X-HEG-MailScanner: Found to be clean
X-HEG-MailScanner-SpamScore: s
X-HEG-MailScanner-From: indira.acosta@heg.gob.ec
X-Spam-Status: No, score=2.9 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_REPLYTO,
        FREEMAIL_REPLYTO_END_DIGIT,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: **
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

NOTA !!! Si no actualiza su cuenta, su cuenta se eliminar=E1 autom=E1ticame=
nte de nuestro sistema.

Nos disculpamos por cualquier inconveniente causado.

Sinceramente
Atenci=F3n al cliente
Equipo de soporte t=E9cnico de Zimbra.

Copyright =A9 2005-2023 Synacor, Inc. Todos los derechos reservados
