Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCD4B6A9B84
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Mar 2023 17:19:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231294AbjCCQTc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Mar 2023 11:19:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231300AbjCCQTV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Mar 2023 11:19:21 -0500
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com [IPv6:2607:f8b0:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2ED414480
        for <linux-kernel@vger.kernel.org>; Fri,  3 Mar 2023 08:19:08 -0800 (PST)
Received: by mail-oi1-x22e.google.com with SMTP id bj30so2173758oib.6
        for <linux-kernel@vger.kernel.org>; Fri, 03 Mar 2023 08:19:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1677860348;
        h=content-transfer-encoding:to:subject:message-id:date:from:reply-to
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=e/r0L/PAnS5fOVQg6qj0+2DIJq2t1BxWauF5ORbF6tY=;
        b=DmNnblxP5EQUIa/UThzd65X32kBgW2u0dAfqHsuYaH5+kAZKvrWLXq+Gz0PWjTTesp
         tqcNNTNf+4hQNkRZeXiTZmxYADIGsfPgmNRp4Z9OUcOa7c0YGnikMIVxydyFWWHnMG4b
         6y7JqopRo7VYTj7Nm9EKJR57EwjmGVFKz7biuRSlq82FM19KifGti9Z7elua7eBJFkJN
         qrOzntW+e0+2ml4jxiUZKHNUde3yWmPIWytziwE24bG6MyqCPZK0eLwZvprwqvGBB4y5
         mtK1zpT5mSDex4wCLsIZh8OTacCwwSBlbqcnJB5T2ya/NJJczARnOMcA46fhKgrbhMOK
         StKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677860348;
        h=content-transfer-encoding:to:subject:message-id:date:from:reply-to
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=e/r0L/PAnS5fOVQg6qj0+2DIJq2t1BxWauF5ORbF6tY=;
        b=nmqQLix7quXjfWfcW3NcyG/Hjb9KfTQYJXGkmu7qajXMJqf9F6DkQXWeETlYIGf64U
         PA0Il2xvdPlaMMdf8NqFqTSCbLx9AIVWCbCPABRpegnR17d6uMprfz5tGTL+sFgVFVg0
         pAHxfsfmTR20sFE6WjIFs1QHyvbvlUnHCCln5JoKhSfsbuw/eHYa8wCujpRGcagdz0Ja
         9ylmjKhyq6tx69m4VXjTBE1o6ixWAm7Xj/nrx5tljd1S+BKF6pZr3NqCHQ1KzIEThicl
         0WASAHS5Fb1fE2hUNm/5okZkFV7M69Qhq9DY9zsc9o6vqjIGy4OeVPP0ZVcN8UTl/I7e
         1Cgw==
X-Gm-Message-State: AO0yUKWOSm+7waUObbNcRnU8rSo1+t1EkgO0XUAcYFA8oenwRulotVcJ
        r0ZHdRSMxoN+WB3R0nUCebedGk+ntonoYx5H85E=
X-Google-Smtp-Source: AK7set+B74UcFmJ8Z+NFBcV7N/VSAyfGZHxF9UdTs4Mu2LsnXCgzMOzLTP6LtQIZP+pnUz/bEn2Cebp6ojFP6bIopLI=
X-Received: by 2002:a05:6808:2208:b0:37a:2bed:5756 with SMTP id
 bd8-20020a056808220800b0037a2bed5756mr3146197oib.0.1677860348339; Fri, 03 Mar
 2023 08:19:08 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a05:6358:2781:b0:eb:dfa:ec3d with HTTP; Fri, 3 Mar 2023
 08:19:07 -0800 (PST)
Reply-To: georgebrownhoward02@gmail.com
From:   georgebrownhoward <mrsblessingkoffi04@gmail.com>
Date:   Fri, 3 Mar 2023 17:19:07 +0100
Message-ID: <CALh=pzWKtcBEFbzyxkSTV+LNgwT_7CpH1MqYP-+w61q6yWBH1w@mail.gmail.com>
Subject: 
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,UNDISC_FREEM autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ahoj

Jmenuji se George Brown, povol=C3=A1n=C3=ADm jsem pr=C3=A1vn=C3=ADk. Chci v=
=C3=A1m nab=C3=ADdnout
nejbli=C5=BE=C5=A1=C3=AD p=C5=99=C3=ADbuzn=C3=BD m=C3=A9ho klienta. Zd=C4=
=9Bd=C3=ADte =C4=8D=C3=A1stku (8,5 milionu $)
dolar=C5=AF, kter=C3=A9 m=C5=AFj klient nechal v bance p=C5=99ed svou smrt=
=C3=AD.

M=C5=AFj klient je ob=C4=8Dan va=C5=A1=C3=AD zem=C4=9B, kter=C3=BD zem=C5=
=99el p=C5=99i autonehod=C4=9B se svou =C5=BEenou
a jedin=C3=BD syn. Budu m=C3=ADt n=C3=A1rok na 50 % z celkov=C3=A9ho fondu,=
 zat=C3=ADmco 50 % ano
b=C3=BDt pro tebe.
Pro v=C3=ADce informac=C3=AD pros=C3=ADm kontaktujte m=C5=AFj soukrom=C3=BD=
 e-mail zde:
georgebrown0004@gmail.com

P=C5=99edem d=C4=9Bkuji,
Pane George Browne,
