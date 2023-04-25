Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8902B6EDDED
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Apr 2023 10:27:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233609AbjDYI1F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Apr 2023 04:27:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233604AbjDYI1D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Apr 2023 04:27:03 -0400
X-Greylist: delayed 575 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 25 Apr 2023 01:26:59 PDT
Received: from godel.csic.edu.uy (godel.csic.edu.uy [164.73.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D5444C1E
        for <linux-kernel@vger.kernel.org>; Tue, 25 Apr 2023 01:26:59 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by godel.csic.edu.uy (Postfix) with ESMTP id 8561B114F8C6;
        Tue, 25 Apr 2023 05:17:18 -0300 (-03)
Received: from godel.csic.edu.uy ([127.0.0.1])
        by localhost (godel.csic.edu.uy [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id K5jWCFkP3-Lm; Tue, 25 Apr 2023 05:17:12 -0300 (-03)
Received: from localhost (localhost [127.0.0.1])
        by godel.csic.edu.uy (Postfix) with ESMTP id DF1A2114F3D0;
        Tue, 25 Apr 2023 05:16:55 -0300 (-03)
DKIM-Filter: OpenDKIM Filter v2.10.3 godel.csic.edu.uy DF1A2114F3D0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cur.edu.uy;
        s=B0715144-E611-11EA-A8C2-A2F3B34B9628; t=1682410616;
        bh=mAhvhhVt0FojqIoI5vUL967LmtKhh/nKngvxnrO5ImE=;
        h=MIME-Version:To:From:Date:Message-Id;
        b=mx+P2Vpha/2dBR7j8DvKF6HFphRcLff7G2wP73AedjDUIa8kuNrcXpz0Iz7t+9p7T
         NekRV06ht8H3Aeq7mZfyGyXJXeO/dLXK6v+iDiB3dTXEm8Y6Uov2WMkaewumd7BKTL
         +0jP8SdQEefBQH3yhzcwuXxuLW1fB55tuqwVorrNpHc5NFfZ3OCI1G6zTu7ph5nl40
         EKTt6aADDsgiMcT0BCGD6FNZElmxkYrIvwxCBSeGnKwA3ITg0mqobTxcZJde3PsDip
         0mzvhFdDD12HgWhn7rkWKEE6740+bNGoYaIq+nMkle3NN+lLiTm397iLca4vM566IK
         diEMMkjXPqgbw==
X-Virus-Scanned: amavisd-new at correo.cure.edu.uy
Received: from godel.csic.edu.uy ([127.0.0.1])
        by localhost (godel.csic.edu.uy [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id VYu6ruNY_h-f; Tue, 25 Apr 2023 05:16:55 -0300 (-03)
Received: from [23.172.112.93] (unknown [23.172.112.93])
        by godel.csic.edu.uy (Postfix) with ESMTPSA id 107F5114F45E;
        Tue, 25 Apr 2023 05:16:32 -0300 (-03)
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Description: Mail message body
Subject: RE: Se requiere respuesta urgente.
To:     Recipients <asilveira@cur.edu.uy>
From:   "WEBMAIL MAIL ZIMBRA" <asilveira@cur.edu.uy>
Date:   Tue, 25 Apr 2023 01:16:26 -0700
Reply-To: webmasterzimbra1@gmail.com
Message-Id: <20230425081633.107F5114F45E@godel.csic.edu.uy>
X-Spam-Status: No, score=0.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_REPLYTO,
        FREEMAIL_REPLYTO_END_DIGIT,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
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
