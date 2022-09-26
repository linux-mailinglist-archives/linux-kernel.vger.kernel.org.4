Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5A3B5EB149
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 21:26:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229980AbiIZT0t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 15:26:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229945AbiIZT0p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 15:26:45 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18E3B6612B
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 12:26:43 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id bu25so10554646lfb.3
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 12:26:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from:sender
         :mime-version:from:to:cc:subject:date;
        bh=6oHWX8sH3tohS1DPDLSFcUzMKYSwL6J87hX19yyB3G8=;
        b=IeBvvAfVGQRrY0wDRx38uL83DkCvMiZtbpIrpfP8ucb+f5ETn2VgGJU1QTQPfwQbrS
         HfSld5/APloz1HAhB7bcPO25JWf1P6RWrvv6E+h70LLbFpLAh+y0ZtqVQL5ykhDWVKaT
         bvvp8SvbeVwb1Y6IasBp88HsgM8qxeKB2x8oryjdN6r4QbKVXebsknRKSw77CykGL8j1
         wgRl7YuvHElev5hXWF+fMbBw68C9zQhAtw8eMHGRtxq62y6VawArToroegz6ANiN4a98
         M41gm9gly5TsoiG6J/dcG7NDKt7q8r6+/e1wbufK22hLAQOmCAA0TrfebHjzztf5Stuq
         3AIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from:sender
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=6oHWX8sH3tohS1DPDLSFcUzMKYSwL6J87hX19yyB3G8=;
        b=iR/E/JGRUoOQr1aMAW5uXUTmwbCH4MXezgmzKx3WGvEbTeJE5y59sHwI3/G4BnQIIO
         QfF3EIRTw79vgelBmmBvzVGfMeTcg0lVfL8ohfZBtat4Utsmo05YZzc5GU+niTKTZx+r
         nB3FQ4jQc2JMLUbAVQ/HPHQeuTdY64F7XPgBeJqgJQ2zRmKneolkYl1RLXXyP0atEynN
         jG/DhzoOTZc0pjAD8lJ2xIGROFpoCS1O8vyMccdCT3tieCuEIrl+khOCrFndkeyNrlbr
         X2D3UZQCxYT7Hiv6oE8i0sYxNzYDLHDkO0lUiD0H57xva879uHFFju2ib3rFsfnyFc0H
         VEjA==
X-Gm-Message-State: ACrzQf1593By1umzx1q6u0W/Cs+gcgiW5Z3ntwxV/adTqwEbVncv2NjG
        0s73xJoV+rN+kD5p7PGp0zkGBFX6Q2NuL2sPSwA=
X-Google-Smtp-Source: AMsMyM5Mfrufsn4kFB2P/VEG4HjnA0BiMFe5XqaiQg9e7yUPLJZ6spPgHdzzJfcOusqNKAM68edTZ4tM3+vXLEBTZ18=
X-Received: by 2002:a05:6512:3b8a:b0:499:ac9a:425b with SMTP id
 g10-20020a0565123b8a00b00499ac9a425bmr8973258lfv.301.1664220401363; Mon, 26
 Sep 2022 12:26:41 -0700 (PDT)
MIME-Version: 1.0
Sender: seidouadam49@gmail.com
Received: by 2002:a05:6504:19a6:b0:1e4:2efc:2df3 with HTTP; Mon, 26 Sep 2022
 12:26:40 -0700 (PDT)
From:   Capt Katie <katiehiggins302@gmail.com>
Date:   Mon, 26 Sep 2022 19:26:40 +0000
X-Google-Sender-Auth: nh5iUs5k0xRGnX61SA8vugzVuGk
Message-ID: <CAOavD-rBoLVBMgWQ4GO3Bc3CeNFm9OmqSBULo5-UppxaSs5i1w@mail.gmail.com>
Subject: Re: HELLO DEAR
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=2.6 required=5.0 tests=BAYES_80,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,SUBJ_ALL_CAPS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hallo,

Sie haben meine vorherige Nachricht erhalten? Ich habe Sie schon
einmal kontaktiert, aber die Nachricht ist fehlgeschlagen, also habe
ich beschlossen, noch einmal zu schreiben. Bitte best=C3=A4tigen Sie, ob
Sie dies erhalten, damit ich fortfahren kann.

warte auf deine Antwort.

Gr=C3=BC=C3=9Fe,
Kapit=C3=A4n Katie
