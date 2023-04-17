Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77A5F6E40F5
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Apr 2023 09:30:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230479AbjDQHaS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Apr 2023 03:30:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230429AbjDQH3j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 03:29:39 -0400
Received: from mail.distrito09d21.saludzona5.gob.ec (mail.distrito09d21.saludzona5.gob.ec [190.214.49.4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00A38ED
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 00:29:28 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by mail.distrito09d21.saludzona5.gob.ec (Postfix) with ESMTP id C0EFD14D7DCF;
        Mon, 17 Apr 2023 02:12:10 -0500 (-05)
Received: from mail.distrito09d21.saludzona5.gob.ec ([127.0.0.1])
        by localhost (mail.distrito09d21.saludzona5.gob.ec [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id IUgWHR5NvBwp; Mon, 17 Apr 2023 02:12:10 -0500 (-05)
Received: from localhost (localhost [127.0.0.1])
        by mail.distrito09d21.saludzona5.gob.ec (Postfix) with ESMTP id 53C951221CAC;
        Mon, 17 Apr 2023 02:12:10 -0500 (-05)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.distrito09d21.saludzona5.gob.ec 53C951221CAC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=distrito09d21.saludzona5.gob.ec;
        s=B3F564AE-DCCF-11EA-A8CE-DCDEBBF83439; t=1681715530;
        bh=Dcs2PdQd+rhHCVw1keoJ9FS9PUCMRPAIMppoLwfJVdU=;
        h=MIME-Version:To:From:Date:Message-Id;
        b=H9A0AdThwOA/WD3n5RhTToS9A1VnGZSMYShvmjaXhh4+rE1n6BkDq5lRENajne/yI
         y06uiIQb1wkPd9wdArbFoAgVVuwwZErvVbpqfW+jIdCMJXpk86GiR4IoVdhq6sRqE/
         vB38EmSWRaCXIjdmytlH1vEjacO+5Dpg6DZqF8pNMMKkliyAYbPW0lCwxLRNOsotOo
         FAwZ3BjfsW6wHhRJTJ5kxZfJmx7eN7ftxS55okXebGMBbK90DOQCyvLtCnyQZWtjKu
         KzCPXFdr/+EhWLU/C3T2bfEAusk3G1PZroOdKpuBKRgrVr9GmuxcD6aQlClGzNHdXV
         si6RiQrUCy/yQ==
X-Virus-Scanned: amavisd-new at distrito09d21.saludzona5.gob.ec
Received: from mail.distrito09d21.saludzona5.gob.ec ([127.0.0.1])
        by localhost (mail.distrito09d21.saludzona5.gob.ec [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id mUOwnWfAEqyB; Mon, 17 Apr 2023 02:12:10 -0500 (-05)
Received: from [23.172.112.93] (unknown [23.172.112.93])
        by mail.distrito09d21.saludzona5.gob.ec (Postfix) with ESMTPSA id BD3F114D7DA8;
        Mon, 17 Apr 2023 02:12:06 -0500 (-05)
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Description: Mail message body
Subject: =?utf-8?q?Atenci=C3=B3n_usuario_de_cuenta_de_correo_electr=C3=B3nico?=
To:     Recipients <hernan.suarez@distrito09d21.saludzona5.gob.ec>
From:   "@ZIMBRA" <hernan.suarez@distrito09d21.saludzona5.gob.ec>
Date:   Mon, 17 Apr 2023 00:11:44 -0700
Reply-To: webmasterzimbra1@gmail.com
Message-Id: <20230417071206.BD3F114D7DA8@mail.distrito09d21.saludzona5.gob.ec>
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
