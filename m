Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CA8D61D9B3
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Nov 2022 12:35:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229511AbiKELfd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Nov 2022 07:35:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbiKELfa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Nov 2022 07:35:30 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73E0A1C920
        for <linux-kernel@vger.kernel.org>; Sat,  5 Nov 2022 04:35:28 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id k15so6664428pfg.2
        for <linux-kernel@vger.kernel.org>; Sat, 05 Nov 2022 04:35:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from:reply-to
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=c8XA1N0uaxkLO/wKHErNWHaSuu64k5Pjb5u9dmcZrOc=;
        b=ExNx77mv8si2dVzbypx+a8uJmDf5KwfRKoRmLPlthVrAVKee/pY4MU7xTsIgrJlLV+
         2Gd5a7/OMwY6BDmTH5LRAABEJ4mfkp0mH02+aqPn0bLKYEjCUdOqD04KkQInBfUUr6CO
         wo1n8JRl54P9fNfvBitek8+utL/rIFyRgyNrFKMuIa/PrdFcS9J+bfHt6wPmiehEUtqH
         05uupNkgZLtGCevugYSK2I5gUeCkOqKPrFWkVhBSm1CUiKKJfmZfxP5aiudJiIECrhz6
         D1ayx0dMcRzH2oPJzxSYrR10I4dlMIvoC2Ld0BH4g1GZBrxYGopjwUv/uWgdGLdJwvM/
         FT/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from:reply-to
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=c8XA1N0uaxkLO/wKHErNWHaSuu64k5Pjb5u9dmcZrOc=;
        b=HcW+/uUO9n3pmuoE//TSv/216EE6hzqlcKvhIblXg/IBS7GxO/SgArmXPejBaNs7X2
         BrPmYJzUskCfLLAhWkGLS29cn5+hqbZy7RgjLzinUQQuZHRX7tYHzrGjl/eRifjjBXoC
         rX6CymUmwqv5qp7LejDhX4v3HTBPuqLQRgTOFihZRBR0khWR9tHRxMeHMvh3spTgiRZW
         5YMZWrYV3a40LlGNDVhVzTqkZE0b40wcfEwvhtTnVSWL9YdVn37yxkmvFrCuo5TOeM/r
         y8GL+k/+uIhjfX1eES3LWX06r1CyJxTVfgS7o5ptwHEB+R07yPmLo1+DJFZ1Emtmx5BX
         dPSg==
X-Gm-Message-State: ACrzQf2beoPIRAHROtMXe+0cwQPQwKG2ZxFgBKLkeJED+luVJhg6lzzK
        O/EW6zHwBztvYHHqwG/wWfXGzsgQCO4vJN4wLME=
X-Google-Smtp-Source: AMsMyM5K/vvNjvEf2gCo9OM6lAF+NRhoQBEdlSy5LVPYVW4UNnkvwIq1OIHBni6js7cNjfEypq0wqCFJ8QLM9VQIbGY=
X-Received: by 2002:a05:6a00:bd2:b0:56d:8bb9:5a0b with SMTP id
 x18-20020a056a000bd200b0056d8bb95a0bmr29082281pfu.20.1667648127754; Sat, 05
 Nov 2022 04:35:27 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6a10:6789:b0:2fe:da9d:d60 with HTTP; Sat, 5 Nov 2022
 04:35:26 -0700 (PDT)
Reply-To: stefanopessia755@hotmail.com
From:   Stefano Pessina <essakewlcomputers@gmail.com>
Date:   Sat, 5 Nov 2022 14:35:26 +0300
Message-ID: <CAAnK-qeE4qCsjMwCweW--ibBAvJ0VR7g3ibckptooxeZA239fA@mail.gmail.com>
Subject: Geldspende
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=4.7 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLYTO,
        FREEMAIL_REPLYTO_END_DIGIT,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        UNDISC_FREEM autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=20
Die Summe von 500.000,00 =E2=82=AC wurde Ihnen von STEFANO PESSINA gespende=
t.
Bitte kontaktieren Sie uns f=C3=BCr weitere Informationen =C3=BCber
stefanopessia755@hotmail.com
