Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FE9465C017
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jan 2023 13:45:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237583AbjACMpr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 07:45:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230006AbjACMpj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 07:45:39 -0500
Received: from mail-ua1-x941.google.com (mail-ua1-x941.google.com [IPv6:2607:f8b0:4864:20::941])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAAD110B40
        for <linux-kernel@vger.kernel.org>; Tue,  3 Jan 2023 04:45:37 -0800 (PST)
Received: by mail-ua1-x941.google.com with SMTP id j1so6822314uan.1
        for <linux-kernel@vger.kernel.org>; Tue, 03 Jan 2023 04:45:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from:reply-to
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=c9dAEuNoOT4wz25Wv9wXjf4qyj8bGYBnq2qOd6MNODw=;
        b=I+UxaMiZjm3WBTwf4s9l6X5Yhm3P1/+2mLBHhdM7JqeMr6zDE5IBYREydLgSAqao4S
         yS0BKK0Dahf8nLTs+ztK23FkAKU8Zu3ZED1xkI0NOygaBqGzXm7lBcrlWLtezj1bxGLR
         utaDctCg+l5b6vaU9wX1YPrX+aj3gjRkkOdPrE5qQoRrHbs1apaSzUMTix2V6mq/8P/K
         XDudmo7q8YRTT4Qv8buapjk/RV0b3b8BXVy/MVkRxwXfrF5mR4nOzNdtNfRuAEuVaWzO
         Twy1tvgociulGdXXbr6jIqZfV7KBB7QZZVUJ4km2VECpMi+gT5q9oKiz+FBj1mPEW5I5
         MNiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from:reply-to
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=c9dAEuNoOT4wz25Wv9wXjf4qyj8bGYBnq2qOd6MNODw=;
        b=tXxpuMkToA94ktVSQvakd6N98iFLpmpIa1TdXLQCmdSKhTGLvm8oOgBavgFHwwqnqI
         9RAlxUULMgugG93rGhYSViufEJ/KiYzUYyz+m6iksqUlCWmnJf/ihaCS0pQI3+/bmAm5
         JPP7dE8aKpIJ0dFL6tfX8f+avtoRJH1WXtaGhz6Uxzygx+xmj4Cb2pGMrAWfhoC+Jvqx
         k0f3wz+TKpWOGQnufVSfm1yEmxSSArCa2ExgFAhjP3lTVkphnFStcb77Dx91/rgiM7LC
         V2NX2x8JofsKE68Gk/6U78A+hwjUAru1rIiLRtS1gjONLqM881rsQd7GxLrqdWVJ/aLT
         uMfQ==
X-Gm-Message-State: AFqh2kqNglWKZSUbWsQCbH+vgIeNZ5iJa7wM7DCCBeb5TZpNH2Lf7OSb
        T1B2Hfdmv0nUhRIbD6ITen2tFwqCjZozAnugaHR5Ilc/s7+rCA==
X-Google-Smtp-Source: AMrXdXs06ijNLzFai3Hmmnb/SFt8p4MU5w/nUN0g/+iDyYonOfuDJaeYW85tVPrtRXIMoOBJsDwWnkWiLqnGvG+ll+U=
X-Received: by 2002:ab0:664b:0:b0:50d:e449:78aa with SMTP id
 b11-20020ab0664b000000b0050de44978aamr2301520uaq.2.1672749936499; Tue, 03 Jan
 2023 04:45:36 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a05:612c:f:b0:381:fdb5:3ec3 with HTTP; Tue, 3 Jan 2023
 04:45:36 -0800 (PST)
Reply-To: bil.ingolfs@gmail.com
From:   DON CASTRO LOAN FINANCE <okporuagrace@gmail.com>
Date:   Tue, 3 Jan 2023 04:45:36 -0800
Message-ID: <CAD8QfJo0pWKbfLrWxSqexBxkvs6Lk9bcvPPH6i4493HJzks06Q@mail.gmail.com>
Subject: Kredit vorschlag
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=4.3 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLYTO,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,UNDISC_FREEM autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=20
Mein Name ist Herr Don Castro aus Frankreich, wohnhaft in italy. Ich
habe ein Kapital, das verwendet wird, um alle Arten von kurz- und
langfristigen Darlehen von 5.000,00 =E2=82=AC bis 50.000.000,00 =E2=82=AC a=
n alle zu
vergeben, um ernsthaften, ehrlichen und moralischen Menschen zu
vergeben, die dies wollen Darlehen. Mein Zinssatz betr=C3=A4gt 02% mit sehr
einfachen Konditionen. Je nach Kredith=C3=B6he k=C3=B6nnen Sie eine Laufzei=
t von
01 bis maximal 30 Jahren zur=C3=BCckzahlen. Z=C3=B6gern Sie nicht, mir zu
antworten, wenn Sie wirklich eine Finanzierung ben=C3=B6tigen. Ich werde
Ihnen ohne Entt=C3=A4uschung helfen. Vielen Dank f=C3=BCr das Teilen der
Botschaft und Gott segne Sie.

HINWEIS: ALLE NACHRICHTEN WERDEN AN DIESE E-MAIL GESENDET: bil.ingolfs@gmai=
l.com

Gr=C3=BC=C3=9Fe.

DON CASTRO
07 RUE DUPIN
75006 PARIS
FRANCE
