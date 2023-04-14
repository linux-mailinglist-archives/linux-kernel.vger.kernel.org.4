Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5D056E2CA8
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Apr 2023 01:02:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229766AbjDNXB6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Apr 2023 19:01:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229685AbjDNXB5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Apr 2023 19:01:57 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FF3D6EBB
        for <linux-kernel@vger.kernel.org>; Fri, 14 Apr 2023 16:01:56 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id qb20so48990949ejc.6
        for <linux-kernel@vger.kernel.org>; Fri, 14 Apr 2023 16:01:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681513315; x=1684105315;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sUOHhi2wFVkAmoeZobfiiSQx8edu3RIYtmBFfZseuKE=;
        b=kQlFfHWN0ARaEDP21Ga9pLb12FJY7vuHLv2uiHvEmvnRLNejM8+1+dKIDDNX/H3DE0
         3WjGjQTq4/7MZKve9/4Uo/q0vFSTQikZDD1hPRCIvkot+1vwq1Nw+P6y0zQwlMCBhz5C
         Lh4L1SZ4WMSaJY3dh1WIt1p0HMb4Si4fYfCpAyKTJ2TXIvzmFH1dQQRVT5HrU9IInfZ8
         nDbTFGWftBYm4cU98LqqqCEhY8XDKHqQ6HDa/QpO7C4q3eslb7dBReUjILIN4sJ57Ozu
         aRaqhmTv2Q7Q79xPklVj96B/QTPkR4FP6awZcFQ/miTyYDUgl8WB1VYtSVWd9noFAxRI
         sMUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681513315; x=1684105315;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sUOHhi2wFVkAmoeZobfiiSQx8edu3RIYtmBFfZseuKE=;
        b=ZOPbxfxHt4XwE6Kfls/0foAH9qWr2dkpw4klPSyn8mJapQVymNyDaeRPYduPo4aXmC
         kYDoShIwIUozp2NzvVUyxh9e5YNyYGcy6pgAqaQfM3bNTCUxauk8+bIvy4+wZ9hyCBqP
         74OvSXeuWYAClzB4Hp3J/W3wbB+7zgq429Wvzz2cZPD+JSaIi0JKipHvX2CMEg6Hw8Ne
         J2ev4qbM2JokS03svu6q3stjjL+Mg05MKxJYRuoM+SdX5esY/XwzzNG7grdwczR8qEgL
         a6n3jujloAkLRcAyz2INzfOSBCCa/cRLbb9KBgbYQLJL5WXaTWUAPv/DiJAiaT9JFNFx
         VoZA==
X-Gm-Message-State: AAQBX9fs3d2H6YPcxV/KzXoY3XCHWElZjqYpS1XbLblega4nPWy/m0n6
        GDGOZ8Yvk/nnZSar5Y7938gb9Z0z2+AHDWI/lZI=
X-Google-Smtp-Source: AKy350aRcCSZXVL70ba6ojvusAWBjti57o+Byt/PLg18hzpirBPGBmqOBFbja+VJSdAgZQhPVuFPcQ7YOhFUZ9nNqt4=
X-Received: by 2002:a17:907:1c26:b0:94a:98a1:75d3 with SMTP id
 nc38-20020a1709071c2600b0094a98a175d3mr339694ejc.12.1681513314516; Fri, 14
 Apr 2023 16:01:54 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:7208:4013:b0:67:2f9b:5221 with HTTP; Fri, 14 Apr 2023
 16:01:53 -0700 (PDT)
Reply-To: wormer.amos@aol.com
From:   Wormer Amos <claudiakhaledyahya02@gmail.com>
Date:   Fri, 14 Apr 2023 23:01:53 +0000
Message-ID: <CANcjk_AOSYrA6ES6PV7pMS+0ZBygiRXq7WCm9NyX_UiTbjezZw@mail.gmail.com>
Subject: SO URGENTLY
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,SUBJ_ALL_CAPS,T_SCC_BODY_TEXT_LINE,UNDISC_FREEM autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

My friend i wanted to know if you're willing for investment project in
your country. i
need a serious partnership with good background, kindly reply
me to discuss details immediately. i will appreciate you to contact me
on this email address Thanks and awaiting your quick response,

Amos....
