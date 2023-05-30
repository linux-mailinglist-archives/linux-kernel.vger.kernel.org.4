Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 059C4715C1C
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 12:45:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231668AbjE3KpJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 06:45:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231649AbjE3Koy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 06:44:54 -0400
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com [IPv6:2607:f8b0:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89B9CE8
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 03:44:49 -0700 (PDT)
Received: by mail-ot1-x332.google.com with SMTP id 46e09a7af769-6af6df840ffso3320458a34.1
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 03:44:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685443489; x=1688035489;
        h=content-transfer-encoding:to:subject:message-id:date:from:reply-to
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=V4+2rZKBXa1Z5xz6nnUi0KpnZt/DKwoqdE+m2GoQd6Q=;
        b=pBjGYUIKmeYLLqsQEHtmYlz0AVujaq+DSHXwUcaM1VWrwrxU7mTEMD2RrbhPNNb/G8
         jzy5c8dt+s6jl1O4NjxgQz6wFSRFac6iKtI53vZ5GtiA28ihEDDvXrdCaPdkjaVK2dPp
         X9olFoDBDL3xlsa/42AoOLz2JtPXg4FwsCYgBWOFmulk0br06s66XQAhJpx5IfLqvhOw
         qHPKhMCyN3T8YQoDsl5Z7CCa12NhGUyIeRQy+61s+w5bGIBkkiyXvF8BeRdnFrQl6hTI
         eZ1Tzm2m6DRpAy5QYXqtlf5e0wJD9tYw6yykYB1+2lTYcMgw08+qphzEn/+pGGBz1hUW
         Vkeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685443489; x=1688035489;
        h=content-transfer-encoding:to:subject:message-id:date:from:reply-to
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=V4+2rZKBXa1Z5xz6nnUi0KpnZt/DKwoqdE+m2GoQd6Q=;
        b=THcSh6yMatYYtmR2gv4bneeVrgWDgSK34YhI1m5H5RbrtOzV4riekaFN8R+5b8nu3d
         Z3cvLk6pVZnCVttZCBY2m+z8HUskBzk5ffs7+ZMZA0BUH6/2HbJxUb/bo9a+Fluuu3qV
         7Pq+O78RJpNpVYtTg3lmOJmpUZ771WzlZoag40a7U61Fv7QRR3oHScctGqRI1wNUWiJO
         1+/jSIovPUohYKwj51uUqZBMACDVHLTuBENnl3wLjyhV9KHdemnCBxLVviFMQsKIBnC9
         lX4kJbDd526PeZU1QUPgQUwRCZn55J1T7HZZzGS7UCRkrlfC8mXGos0hY/CwaOR0mxM+
         xKAA==
X-Gm-Message-State: AC+VfDz1a5cveoPbi+njBfuxWk3v/E9jYvgkVa1K89nsUzG1XnE6VIhv
        rxkLyEX8FxT8m4Fp8VS0PEeL+rLh0VVwI0UuXeE=
X-Google-Smtp-Source: ACHHUZ6BWDhqZdI2z5TsbyjuJbWj/yg+VeoKAFTDZey/tI7l1OxG6/tzEF6sAG9cjEno/GS8zCsmI1ozD3SJw4fGRb0=
X-Received: by 2002:a05:6808:14c5:b0:399:b8e:8532 with SMTP id
 f5-20020a05680814c500b003990b8e8532mr1114122oiw.11.1685443488675; Tue, 30 May
 2023 03:44:48 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6358:103:b0:127:67ec:694a with HTTP; Tue, 30 May 2023
 03:44:48 -0700 (PDT)
Reply-To: muhammedkhalid653@gmail.com
From:   muhammed khalid <able6136@gmail.com>
Date:   Tue, 30 May 2023 10:44:48 +0000
Message-ID: <CABbgLSSv3NzTEwgxBrXLe8-QQc=3nZizE7EWvvgdnqNH3xTWvg@mail.gmail.com>
Subject: re
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
X-Spam-Status: No, score=4.3 required=5.0 tests=BAYES_40,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNDISC_FREEM autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

LS0gDQpHb29kIGRheSENCnBsZWFzZSwgY29uZmlybSBpZiBJIGNhbiB3cml0ZSB0byB5b3UgaGVy
ZS4NClRoZXJlIGlzIGEgdml0YWwgaXNzdWUgSSBuZWVkIHRvIGRpc2N1c3Mgd2l0aCB5b3UgdXJn
ZW50bHkuIENvbmZpcm0NCnlvdXIgZW1haWwgaWYgdmFsaWQgZm9yIGNvbnNjaW91cyBzZWN1cml0
eSByZWFzb25zLg0KDQpUaGFua3MNCk1yLiBNdWhhbW1lZCBLaGFsaWQNCg0KDQrZitmI2YUg2KzZ
itivIQ0K2YXZhiDZgdi22YTZgyDYjCDYo9mD2K8g2YXYpyDYpdiw2Kcg2YPYp9mGINio2KXZhdmD
2KfZhtmKINin2YTZg9iq2KfYqNipINil2YTZitmD2YUg2YfZhtinLg0K2YfZhtin2YMg2YLYttmK
2Kkg2K3ZitmI2YrYqSDYo9ix2YrYryDZhdmG2KfZgti02KrZh9inINmF2LnZgyDYqNi02YPZhCDY
udin2KzZhC4g2YrYqtij2YPYrw0K2KjYsdmK2K/ZgyDYp9mE2KXZhNmD2KrYsdmI2YbZiiDYpdiw
2Kcg2YPYp9mGINi12KfZhNit2YvYpyDZhNij2LPYqNin2Kgg2KPZhdmG2YrYqSDZiNin2LnZitip
Lg0KDQrYtNmD2LHZi9inDQrYp9mE2LPZitivINmF2K3ZhdivINiu2KfZhNivDQo=
