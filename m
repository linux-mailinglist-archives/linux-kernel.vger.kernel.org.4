Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C66825FA93C
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Oct 2022 02:20:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229984AbiJKAUE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Oct 2022 20:20:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229910AbiJKAUA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Oct 2022 20:20:00 -0400
X-Greylist: delayed 2398 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 10 Oct 2022 17:19:56 PDT
Received: from mailgate.kemenperin.go.id (mailgate.kemenperin.go.id [202.47.80.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A259723385;
        Mon, 10 Oct 2022 17:19:55 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by mailgate.kemenperin.go.id (Postfix) with ESMTP id 424043763266;
        Tue, 11 Oct 2022 06:01:54 +0700 (WIB)
Received: from mailgate.kemenperin.go.id ([127.0.0.1])
        by localhost (mailgate.kemenperin.go.id [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id zKaAc2fXxHm4; Tue, 11 Oct 2022 06:01:53 +0700 (WIB)
Received: from localhost (localhost [127.0.0.1])
        by mailgate.kemenperin.go.id (Postfix) with ESMTP id 204CF376325D;
        Tue, 11 Oct 2022 06:01:49 +0700 (WIB)
DKIM-Filter: OpenDKIM Filter v2.10.3 mailgate.kemenperin.go.id 204CF376325D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kemenperin.go.id;
        s=3298A942-BBC6-11E3-B333-483736368EC2; t=1665442909;
        bh=ojiPJcDR+TIWYTwq3WfgringZ3Cc/DnLcOpy2XzifYo=;
        h=Date:From:Message-ID:MIME-Version;
        b=KTWUo8Sx5nHpeKhkHRjXaNuaVr1LcfZuzLmih7Iepi3yA2CuD1DjrJ8PYI4/59cF8
         27bF8UWyEV8bTDr5vnPGsURYKJJC4uh9KLLhqKyijQGeP64JOAeeJqu4z/DlWON4mz
         d8GEUR9n9RDWFYzailXjfkBSMytaww9+eCkzrk1c=
X-Virus-Scanned: amavisd-new at kemenperin.go.id
Received: from mailgate.kemenperin.go.id ([127.0.0.1])
        by localhost (mailgate.kemenperin.go.id [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id yIk69QrvBgDl; Tue, 11 Oct 2022 06:01:49 +0700 (WIB)
Received: from mailgate.kemenperin.go.id (mailgate.kemenperin.go.id [10.1.0.89])
        by mailgate.kemenperin.go.id (Postfix) with ESMTP id 484203763257;
        Tue, 11 Oct 2022 06:01:38 +0700 (WIB)
Date:   Tue, 11 Oct 2022 06:01:38 +0700 (WIB)
From:   Iccrea Banca SpA Istituto Centrale del Cooperativo 
        <afriyanto@kemenperin.go.id>
Reply-To: Iccrea Banca SpA Istituto Centrale del Cooperativo 
          <ibspaicdc@gmail.com>
Message-ID: <1909739179.54723.1665442898222.JavaMail.zimbra@kemenperin.go.id>
Subject: =?utf-8?Q?=C3=9Cberweisung_abgeschlossen_(=E2=82=AC280.000,00_)?=
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [10.1.0.89]
Thread-Index: XUiDgADoxrL1kwFkeUWMbm3LczkhPw==
Thread-Topic: =?utf-8?Q?=C3=9Cberweisung_abgeschlossen_=28=E2=82=AC280=2E000=2C00?= )
X-Spam-Status: Yes, score=5.3 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_REPLYTO,
        MISSING_HEADERS,REPLYTO_WITHOUT_TO_CC,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  1.0 MISSING_HEADERS Missing To: header
        * -0.0 SPF_PASS SPF: sender matches SPF record
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        *  1.6 REPLYTO_WITHOUT_TO_CC No description available.
        *  2.1 FREEMAIL_FORGED_REPLYTO Freemail in Reply-To, but not From
X-Spam-Level: *****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



=C3=9Cbertragung abgeschlossen!
Haben Sie die Bankbenachrichtigung =C3=BCber die =C3=9Cberweisung best=C3=
=A4tigt, die =C3=BCber den Europ=C3=A4ischen Fonds f=C3=BCr humanit=C3=A4re=
 Hilfe auf Ihr Konto gesendet werden soll?
Ihr Name und Ihre Einzelheiten waren der Betrag der Liste der Empf=C3=A4nge=
r des Geldbetrags. Wenn Sie Ihre Zahlung noch nicht best=C3=A4tigt haben, b=
est=C3=A4tigen Sie dies bitte freundlicherweise bei Iccrea Banca S.p.A. Ist=
ituto Centrale del Credito Cooperativo, Via Lucrezia Romana, 41/47, 00178 R=
oma RM, Italien.

E-Mail1: info@iccreabancn.org
E-Mail2: ibspaicdc@gmail.com


Guido Josef
Tel. +39 03 8829911
E-Mail:=C2=A0info@iccreabancn.org
E-Mail:=C2=A0customercare@iccreabancn.org
E-Mail:=C2=A0ibspaicdc@gmail.com
Forma giuridica: Societa Per Azioni Con Socio
Tipo di azienda: Sede Centrale
P. Iva: 04774801007
