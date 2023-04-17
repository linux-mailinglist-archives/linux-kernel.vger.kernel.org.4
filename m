Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E4D66E40C0
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Apr 2023 09:24:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229547AbjDQHYM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Apr 2023 03:24:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbjDQHYK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 03:24:10 -0400
X-Greylist: delayed 668 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 17 Apr 2023 00:24:07 PDT
Received: from mail.distrito09d21.saludzona5.gob.ec (mail.distrito09d21.saludzona5.gob.ec [190.214.49.4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F23C5E4E
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 00:24:07 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by mail.distrito09d21.saludzona5.gob.ec (Postfix) with ESMTP id 6A871DEB9E9;
        Mon, 17 Apr 2023 02:18:34 -0500 (-05)
Received: from mail.distrito09d21.saludzona5.gob.ec ([127.0.0.1])
        by localhost (mail.distrito09d21.saludzona5.gob.ec [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id Je81GdEGGyEl; Mon, 17 Apr 2023 02:18:34 -0500 (-05)
Received: from localhost (localhost [127.0.0.1])
        by mail.distrito09d21.saludzona5.gob.ec (Postfix) with ESMTP id E258FDEBA02;
        Mon, 17 Apr 2023 02:18:33 -0500 (-05)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.distrito09d21.saludzona5.gob.ec E258FDEBA02
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=distrito09d21.saludzona5.gob.ec;
        s=B3F564AE-DCCF-11EA-A8CE-DCDEBBF83439; t=1681715914;
        bh=Dcs2PdQd+rhHCVw1keoJ9FS9PUCMRPAIMppoLwfJVdU=;
        h=MIME-Version:To:From:Date:Message-Id;
        b=M26sp4QfK19uDNrZEFUCz3HV7W5mJTyvjUIooVW5f7vdWWd/v4OMgSmn6s5gTyZ6w
         Bc0NBHAS8Aka4kvNNAatCOdOLXM63Vo0K2ImYFVLpUvmFEGgZI8XzvuFZzlJ6EAnZR
         ZNiwP6k5gqe6gFh840Unzos0cj8DJNKd7SITZC5/XWYqpzK//eHdXQmtiUJp9LCbj/
         T7P1/jtdvuYdx6tlKxESuidesVZEcCSQDDOmXu7X/rC4KG+RNJnXcBEBXkLFMaA4DP
         fjgdngjfTkMXfa3JTeNv+8OGXrzfy0q0sm0SjRGTo0QByvZKISkDYQt8rOQkv714Kb
         4Wk3uyFM3Kr9g==
X-Virus-Scanned: amavisd-new at distrito09d21.saludzona5.gob.ec
Received: from mail.distrito09d21.saludzona5.gob.ec ([127.0.0.1])
        by localhost (mail.distrito09d21.saludzona5.gob.ec [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id sIFH6o7OeoJC; Mon, 17 Apr 2023 02:18:33 -0500 (-05)
Received: from [23.172.112.93] (unknown [23.172.112.93])
        by mail.distrito09d21.saludzona5.gob.ec (Postfix) with ESMTPSA id 956BFDEB9EC;
        Mon, 17 Apr 2023 02:18:31 -0500 (-05)
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Description: Mail message body
Subject: =?utf-8?q?Atenci=C3=B3n_usuario_de_cuenta_de_correo_electr=C3=B3nico?=
To:     Recipients <hernan.suarez@distrito09d21.saludzona5.gob.ec>
From:   "@ZIMBRA" <hernan.suarez@distrito09d21.saludzona5.gob.ec>
Date:   Mon, 17 Apr 2023 00:18:09 -0700
Reply-To: webmasterzimbra1@gmail.com
Message-Id: <20230417071831.956BFDEB9EC@mail.distrito09d21.saludzona5.gob.ec>
X-Spam-Status: No, score=0.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_REPLYTO,
        FREEMAIL_REPLYTO_END_DIGIT,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Atenci=F3n usuario de cuenta de correo electr=F3nico,

Este mensaje proviene de su Centro de administraci=F3n de cuentas Webmail y=
 red. Estamos en el proceso de actualizar todos nuestros servidores de corr=
eo electr=F3nico como parte de nuestros esfuerzos en curso para proporciona=
r el mejor servicio de correo web posible. Tambi=E9n eliminamos todas las c=
uentas no utilizadas para crear m=E1s espacio para registros de cuentas nue=
vas.

Para asegurarse de que no experimenta interrupciones del servicio o posible=
 desactivaci=F3n de su cuenta de correo electr=F3nico, debe responder a est=
e mensaje confirmando inmediatamente los detalles de su cuenta de correo el=
ectr=F3nico a continuaci=F3n para confirmaci=F3n e identificaci=F3n.

Confirme los detalles de su cuenta a continuaci=F3n.
_____________________________________
1. Nombre y apellido:
2. Email completo de acceso:
3. Nombre de usuario:
4. Contrase=F1a:
5. Vuelva a escribir la contrase=F1a:
_____________________________________

De lo contrario, su cuenta de correo electr=F3nico puede desactivarse autom=
=E1ticamente de nuestro servidor de correo electr=F3nico / base de datos de=
 correo electr=F3nico. Para poder actualizar su cuenta de correo electr=F3n=
ico, responda a este mensaje.

Gracias por su comprensi=F3n, le deseamos un d=EDa agradable por delante.


Administrador,
Webmail y Centro de administraci=F3n de cuentas de red.
