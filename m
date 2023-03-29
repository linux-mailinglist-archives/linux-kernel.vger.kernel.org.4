Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FC096CD17D
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 07:22:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229601AbjC2FWf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 01:22:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjC2FWd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 01:22:33 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A3D630D2;
        Tue, 28 Mar 2023 22:22:31 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id o6-20020a17090a9f8600b0023f32869993so17444501pjp.1;
        Tue, 28 Mar 2023 22:22:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680067351;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=82yVM7sYH31Om3QqxDjo0pU0ohro8Dtb8BPvc+yj3W0=;
        b=j1vjtXvOPnC1Ny80mu41nRfW77JFV+DXUXteMYD9Nv7JRrT5twsVsOg/W4eS8P0Bfi
         UUJNqVBc67h8eOTvsbU9gSM1cUKFN1D8CE1vcwg5uUWvRnnykXYMA5BIrqZJ92KB0XCn
         oaAjUrSeKD+0LTIY46iT8SX5em9KHuEdtOMZdvYWd+f/8ngI3vGXf0U+OO54VfuhzxcR
         1kCzvrANouaoi7KMqJZEgKxrjn3C673ZFZq3mZbzRStGMEZkZGwxKt8naQwaRVGPRaY0
         6x0twUxoeoHHt2SJ+oCXfEcIYxUDND82CvrnIzHhpLumPktNexrWqjSK2SS52Btngmx6
         xpRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680067351;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=82yVM7sYH31Om3QqxDjo0pU0ohro8Dtb8BPvc+yj3W0=;
        b=UmbTE+nsmJneaTqiufWMRSqXMlOGQUgXrfQSimHNn35iLpj6QF6XhZ7o6kcRWyRusF
         rdFyXGMzet0MaNTkFIwI2VI7inrKK3lshY2anqGmgRlHzCxtvTmBytJxZz7boRLLRsHQ
         QxIiTFAFx6vy3N1UxIJ46kth6D53iEh8a4HGBY2+okZDpnMJFyKkjL1NrvNlQRF5pVMQ
         hNKRVOenHwQsGM7hQwfEZkiib8jwmV+w0+IhU3XiRbvMclZrDx6UcBpBnpgwT4wH+O7L
         1E8oShRre6ELf/i0HF0iOpcN69LQGUDkAc4UHzYYPuTr7K/7QcppwLrP3JpKcZdLA+GW
         I3Tw==
X-Gm-Message-State: AO0yUKU6bju+0zBZJvnokX8n5rEt6GQGsU7/tB4eo57/27Vck1pQWICS
        xqMYHdAyaUrEzaQgdBKNKSs=
X-Google-Smtp-Source: AK7set84mFBgpOQnFp5uFECqg94DQv/SSArWXMLtEWZ6llrqqrNemu0gZJzOzMGZbq6w608gN270mg==
X-Received: by 2002:a05:6a20:49a4:b0:da:834d:edd with SMTP id fs36-20020a056a2049a400b000da834d0eddmr16680804pzb.34.1680067350889;
        Tue, 28 Mar 2023 22:22:30 -0700 (PDT)
Received: from [192.168.11.9] (KD106167171201.ppp-bb.dion.ne.jp. [106.167.171.201])
        by smtp.gmail.com with ESMTPSA id x3-20020a654143000000b0050301745a5dsm20894552pgp.50.2023.03.28.22.22.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Mar 2023 22:22:30 -0700 (PDT)
Message-ID: <c38176c7-c30a-4c2c-3516-8d3be1c267dc@gmail.com>
Date:   Wed, 29 Mar 2023 14:22:28 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Content-Language: en-US
To:     Carlos Bilbao <carlos.bilbao@amd.com>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Akira Yokosawa <akiyks@gmail.com>
From:   Akira Yokosawa <akiyks@gmail.com>
Subject: [PATCH] docs/sp_SP: Remove ZERO WIDTH SPACE in memory-barriers.txt
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As this file is included literally, ZERO WIDTH SPACE causes
"make pdfdocs" to emit messages which read:

  Missing character: There is no =E2=80=8B (U+200B) in font DejaVu Sans M=
ono/OT:script=3Dlatn;language=3Ddflt;!
  Missing character: There is no =E2=80=8B (U+200B) in font DejaVu Sans M=
ono/OT:script=3Dlatn;language=3Ddflt;!

U+200B (ZERO WIDTH SPADE) has no effect in literal blocks.
Remove them and get rid of those noises.

Signed-off-by: Akira Yokosawa <akiyks@gmail.com>
Cc: Carlos Bilbao <carlos.bilbao@amd.com>
Cc: Jonathan Corbet <corbet@lwn.net>
---
Hi,

Offending commit is 259b007f5729 ("docs/sp_SP: Add memory-barriers.txt
Spanish translation") merged into v6.2.
As this is not a bug fix, I'm not putting a Fixes: tag.

Note: It might be hard for human eyes to see where the removed
ZERO WIDTH SPACEs were. :-)

        Thanks, Akira
--
 Documentation/translations/sp_SP/memory-barriers.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/translations/sp_SP/memory-barriers.txt b/Docum=
entation/translations/sp_SP/memory-barriers.txt
index f62bd797216d..27097a808c88 100644
--- a/Documentation/translations/sp_SP/memory-barriers.txt
+++ b/Documentation/translations/sp_SP/memory-barriers.txt
@@ -604,7 +604,7 @@ READ_ONCE() para DEC Alpha, lo que significa que las =
=C3=BAnicas personas que
 necesitan prestar atenci=C3=B3n a esta secci=C3=B3n son aquellas que tra=
bajan en el
 c=C3=B3digo espec=C3=ADfico de la arquitectura DEC Alpha y aquellas que =
trabajan en
 READ_ONCE() por dentro. Para aquellos que lo necesitan, y para aquellos =
que
-est=C3=A9n interesados =E2=80=8B=E2=80=8Bdesde un punto de vista hist=C3=
=B3rico, aqu=C3=AD est=C3=A1 la historia
+est=C3=A9n interesados desde un punto de vista hist=C3=B3rico, aqu=C3=AD=
 est=C3=A1 la historia
 de las barreras de dependencia de direcci=C3=B3n.
=20
 [!] Si bien las dependencias de direcciones se observan tanto en carga a=


base-commit: 4f1bb0386dfc0bda78ddad0e4fb3cd519b2886ab
--=20
2.25.1

