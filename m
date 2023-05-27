Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD4887134D4
	for <lists+linux-kernel@lfdr.de>; Sat, 27 May 2023 14:55:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229948AbjE0Mz1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 May 2023 08:55:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229571AbjE0MzZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 May 2023 08:55:25 -0400
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com [IPv6:2607:f8b0:4864:20::1134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58B80F7;
        Sat, 27 May 2023 05:55:24 -0700 (PDT)
Received: by mail-yw1-x1134.google.com with SMTP id 00721157ae682-565a3cdba71so26416247b3.0;
        Sat, 27 May 2023 05:55:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685192123; x=1687784123;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :references:in-reply-to:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R6FD39z6/yzoWxqjGj5l/A+h56k6dEgj9IgVq61xwoo=;
        b=njcTblcgpVxv3wI4hpd9wHTEM8Am8OYyAQqarleNmhfvLAcrn3ek09x1cJqIalePA9
         YQCyEfV185krG1CcSZS9a1H/Ek6dWNXWrLz7BnDb+Gz+LM4xqykAMVEmBMTUd6A5ZtGN
         b2r6CYrtGlJHsqPgueGlIMb0gnbOnIfdhhgDQuyP8cuPrtLsXtOli2erlm9mvIkv/HEB
         XmoB+YtSUfYRivpsWQO6U9ZrcAU8AxzvBTrKhFGWv007eIC6lJJMNpyLmp1ZehPy5+bl
         Td9UXd4ahJiZPLqNF2prRO6RV+H88CR0knbutnewIl2jQaSrxuZ+0Gr6uCs0GOG3+rMY
         BPWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685192123; x=1687784123;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :references:in-reply-to:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=R6FD39z6/yzoWxqjGj5l/A+h56k6dEgj9IgVq61xwoo=;
        b=j+wQ3AWgMThiWz9FSEqTUjBU110aB7vaumd4vzZU8x9hJ89IYHVzWa2Xmz/LGnM8fO
         RWT92p6YRwykB9w5i81lThsZ4HUL1PRK9JJhoMh82noMVuNVtIO3BOB6xfRpttlbkGFC
         VTkytYgQTiCzYtUqLqJii5hxc/KMm12dDYRFj8ViJvMZdqMZbReeCezE5cEz8CU8quc7
         XDRgY2aHY94EF7LD+mKMKbz040Y7dlcMq7mqKT189PEpLYzyB1hhNRYlpCnZkb9DzmhH
         d2gluXR4qwM2yUJK1lttNNhP4O+BLjh1Shkee+u0SEbLZvHGeuFUSmE0p7mRlT0vgta2
         +jlg==
X-Gm-Message-State: AC+VfDzKnpAa+f+76ltQ4/lfaDMy+265tjHuuRyobQnDBXHl9ejyTG8i
        QcX3an0QkrgrBksBjoJlcz99QlXvUfDjpJv0G6swC0Kl
X-Google-Smtp-Source: ACHHUZ4vt9yh9LDs6HIeVo3ri8/CSWJ2oOKU3vIEjXRB4dphoMZZaHfWXEzl5IdUwPmqIx2S4YoMXFDD7kgWJjpIeB8=
X-Received: by 2002:a0d:eb48:0:b0:55a:72f6:a451 with SMTP id
 u69-20020a0deb48000000b0055a72f6a451mr5834226ywe.41.1685192123526; Sat, 27
 May 2023 05:55:23 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:7000:4cc2:b0:4c8:422c:a99d with HTTP; Sat, 27 May 2023
 05:55:23 -0700 (PDT)
In-Reply-To: <f10a1c61-bc8b-420f-988d-ba0ebfccf00f@roeck-us.net>
References: <20230526215621.16075-1-samsagax@gmail.com> <430e7be0-26a9-43b0-a61f-66cb8dfc805e@roeck-us.net>
 <CABgtM3jNVp63XB5A8Cf0KhB4So2==HLGa9_meuTn0vHYy=gBzQ@mail.gmail.com> <f10a1c61-bc8b-420f-988d-ba0ebfccf00f@roeck-us.net>
From:   Joaquin Aramendia <samsagax@gmail.com>
Date:   Sat, 27 May 2023 09:55:23 -0300
Message-ID: <CABgtM3i9rmrqCzMiAcdi5zowPM9b8g8vNDY7WVhO+f7h7Tpp7w@mail.gmail.com>
Subject: Re: [PATCH] hwmon: (oxp-sensors) Differentiate new BIOS for the Mini
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     "Derek J. Clark" <derekjohn.clark@gmail.com>,
        Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I have resubmitted the change that uses this that includes this change. So
drip this one and let's continue the review on the other.

Thanks!
Joaqu=C3=ADn I Aramend=C3=ADa

--=20
Joaqu=C3=ADn I. Aramend=C3=ADa
