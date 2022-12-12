Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8ADB3649BC0
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Dec 2022 11:11:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231602AbiLLKK7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Dec 2022 05:10:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231335AbiLLKKe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Dec 2022 05:10:34 -0500
Received: from mail-vs1-xe36.google.com (mail-vs1-xe36.google.com [IPv6:2607:f8b0:4864:20::e36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2C8C1004B
        for <linux-kernel@vger.kernel.org>; Mon, 12 Dec 2022 02:09:40 -0800 (PST)
Received: by mail-vs1-xe36.google.com with SMTP id c184so10697461vsc.3
        for <linux-kernel@vger.kernel.org>; Mon, 12 Dec 2022 02:09:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=4s9K/+lMEs5qEFbAtakvSrIm/fChVksj2dPdXChFNK4=;
        b=QfbRRA6i4p9/NoxwVfWQdQiOjGRN61+yA8Qo74qEEhP7aXYHRTSRsyGxMUdh+Alpx7
         y6jRVhtpV0gn87Kqi6TNcEQ0y69eciHEqSxmiTPmu8U9wzlBsW74iuTmjtwnbKUQ8SeA
         VQgX0uQbPqqyto59YWRnkhUfupUkM5fxac2yDGlB1HdiMLR10reSK7ZnpQOMG0bIxO0i
         Ir9Iyirj4IG/MIsTdDz4VB3wTj2Nx2vKNd+BZ8537mpNjfMLDgLf32Hc7vJMhNvkshIW
         wDSz6RrLfVqE1bVlFYZ4zLzfoGAilm3nN87Sp8jJcXH5Y0cQiPNRf99dy/T3PovtkZXe
         cHyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4s9K/+lMEs5qEFbAtakvSrIm/fChVksj2dPdXChFNK4=;
        b=tz7lwD9cpa+/wkNpm63xzvjd0UG7AZFUEdvZLQ/apLf3hcFXDBPOLKzLBkB0GzPQd4
         tj/VKxIaxs3gzfkHlXrfPJ+1EVsbUNZM5DouBTQOtg0Ug89SgG5ZpXJwy3+JttAHz1TC
         kuqJ52j5DFMG7bXdy4D+Xmo+EHHyzvXF1eCkj382rn14z6S9z4rcgxARDrtQSHGfnQ5B
         FbdN1HPp8VtCML4kLbIJ/kMCLULK1SVu4P2RvHczcQFCtO9hg54IXafiIHMV+edaaQEH
         1DBA9tBb1e0QU/ATKF3bXk1XSwpC0f764XjszEcOdEbDbitM1yHl/u47SdYssamSdFWH
         Ehcg==
X-Gm-Message-State: ANoB5pkFXoikxOeTnIiWq276hnZIxXcwtQYy/f4O5SS+ptGU9DwmPnJU
        skq5bs2sqXd5v+bx4ljxU7d8Kaa8Z/FiD43XpDE=
X-Google-Smtp-Source: AA0mqf7Ow/HFbucVBIk5EPWpDo4kAvi2ONbt+Q+aNkWLq1VQeLBbLUeiNBkkNGAZueFU0qDf63OTIfPSfOjlF40oK80=
X-Received: by 2002:a67:fe53:0:b0:3b1:3d9a:6932 with SMTP id
 m19-20020a67fe53000000b003b13d9a6932mr10678744vsr.59.1670839779627; Mon, 12
 Dec 2022 02:09:39 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a67:ea8b:0:0:0:0:0 with HTTP; Mon, 12 Dec 2022 02:09:39
 -0800 (PST)
From:   Koko Yovo <kokoyovo1959@gmail.com>
Date:   Mon, 12 Dec 2022 10:09:39 +0000
Message-ID: <CAKX_-gUs40JZRmvgKtsQ4fhVuTEEG2X=orFv+i+oifSU5=qviw@mail.gmail.com>
Subject: 
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=4.0 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,LOTS_OF_MONEY,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        UNDISC_MONEY autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: ***
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Warum schweigst du, ich hoffe, es geht dir gut, weil ich dir diese
Mail jetzt schon zweimal geschickt habe, ohne von dir zu h=C3=B6ren? Heute
komme ich von meiner Reise zur=C3=BCck und Sie schweigen =C3=BCber die Post=
, die
ich Ihnen seit letzter Woche geschickt habe. Bitte teilen Sie mir den
Grund mit, warum Sie geschwiegen haben. Ich habe mir vorgestellt,
warum Sie mir nicht geantwortet haben. Sehr wichtig Ehrliches
Vertrauen und Hilfe? Mit meiner guten Absicht kann ich darauf
vertrauen, dass Sie die Summe von 47.500.000.00 Millionen US-Dollar
auf Ihr Konto in Ihrem Land =C3=BCberweisen, wenn m=C3=B6glich, kontaktiere=
n Sie
mich f=C3=BCr weitere Details. Ich warte auf Ihre Antwort und bitte lassen
Sie es mich wissen, als zu schweigen ?
Herr Koko Yovo.
