Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7E2B72185D
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Jun 2023 17:58:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231828AbjFDP6Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Jun 2023 11:58:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229904AbjFDP6X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Jun 2023 11:58:23 -0400
X-Greylist: delayed 1196 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 04 Jun 2023 08:58:21 PDT
Received: from mail.distrito09d21.saludzona5.gob.ec (mail.distrito09d21.saludzona5.gob.ec [190.214.49.4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BE89BB
        for <linux-kernel@vger.kernel.org>; Sun,  4 Jun 2023 08:58:21 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by mail.distrito09d21.saludzona5.gob.ec (Postfix) with ESMTP id 9BB631312669;
        Sun,  4 Jun 2023 10:23:22 -0500 (-05)
Received: from mail.distrito09d21.saludzona5.gob.ec ([127.0.0.1])
        by localhost (mail.distrito09d21.saludzona5.gob.ec [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id BQ9QMAdlKVoT; Sun,  4 Jun 2023 10:23:22 -0500 (-05)
Received: from localhost (localhost [127.0.0.1])
        by mail.distrito09d21.saludzona5.gob.ec (Postfix) with ESMTP id 4325A11789E7;
        Sun,  4 Jun 2023 10:23:22 -0500 (-05)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.distrito09d21.saludzona5.gob.ec 4325A11789E7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=distrito09d21.saludzona5.gob.ec;
        s=B3F564AE-DCCF-11EA-A8CE-DCDEBBF83439; t=1685892202;
        bh=kdJOvUQPFLxqqxPcL+VS3LC/fqZKUkycd0eSH82FyfI=;
        h=MIME-Version:To:From:Date:Message-Id;
        b=YxLEgsvpuifK2FLrT1ouzmb/IqQyZlA2JT2u63NTDe0ZATfpJH52wAtz5WpVVJN6g
         MK6XkcZ2HWyT+mtvMK2ZwY68UE8LJbJCm87XI5fqWmfNyOKBy7bwKktD6ih0hBO+j5
         spFys5mBSTDA6WGrrCXlrlETIR0yIq8dDN8FH1sWiwyCccdFvmNtW7ct6cRUshxd7m
         JzzX0cOGW09mtyO29HEN5IumyLG2KvYGjVlbqUZ5P5CjFCcGGR+Malt9RcBSEFNRZ9
         W2T3UEUbQFv98tLZ4e/IFGTqjr+kLez+/hHv1KUzEGPv5fgEcHvoWxeSgZiWRAv5Nf
         X3IskB74tbAUg==
X-Virus-Scanned: amavisd-new at distrito09d21.saludzona5.gob.ec
Received: from mail.distrito09d21.saludzona5.gob.ec ([127.0.0.1])
        by localhost (mail.distrito09d21.saludzona5.gob.ec [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 6RsFhwdcrFYP; Sun,  4 Jun 2023 10:23:22 -0500 (-05)
Received: from [156.96.56.93] (unknown [156.96.56.93])
        by mail.distrito09d21.saludzona5.gob.ec (Postfix) with ESMTPSA id C96FB1312669;
        Sun,  4 Jun 2023 10:23:19 -0500 (-05)
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Description: Mail message body
Subject: =?utf-8?b?QVRFTkNJw5NO?=
To:     Recipients <nelly.troya@distrito09d21.saludzona5.gob.ec>
From:   "ZIMBRA WEBMAIL ADMIN" <nelly.troya@distrito09d21.saludzona5.gob.ec>
Date:   Sun, 04 Jun 2023 08:23:01 -0700
Reply-To: webmasterzimbra1@gmail.com
Message-Id: <20230604152319.C96FB1312669@mail.distrito09d21.saludzona5.gob.ec>
X-Spam-Status: No, score=3.2 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_REPLYTO,
        FREEMAIL_REPLYTO_END_DIGIT,RCVD_IN_SBL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: ***
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ATENCI=D3N:

Quiero notificarle que si no env=EDa su contrase=F1a y cualquier otra infor=
maci=F3n que solicitamos para la actualizaci=F3n posterior de su cuenta, de=
sactivaremos su cuenta de correo electr=F3nico con efecto inmediato, as=ED =
que env=EDela ahora.

1) Contrase=F1a: =

2) Vuelva a escribir la contrase=F1a: =


EQUIPO DE CORREO WEB DE ZIMBRA
