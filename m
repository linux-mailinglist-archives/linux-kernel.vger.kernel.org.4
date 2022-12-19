Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52AF4650E93
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Dec 2022 16:25:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232054AbiLSPZz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Dec 2022 10:25:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231631AbiLSPZw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Dec 2022 10:25:52 -0500
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39B6826D4
        for <linux-kernel@vger.kernel.org>; Mon, 19 Dec 2022 07:25:51 -0800 (PST)
Received: by mail-ej1-x62a.google.com with SMTP id tz12so22296208ejc.9
        for <linux-kernel@vger.kernel.org>; Mon, 19 Dec 2022 07:25:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from:reply-to
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=aj0IM0CjoexC2i+yXzlejMAdGHqKdzeRDWPxbdEC52Y=;
        b=C27vv2XZEEG7o+ka9HbL1o5t/B7aIJ4pAiWnEmugk/R1THnHYJhrpcvb3g+33/nV3m
         FUS4GDIoBadaCouoSTNr3Hni6vlup0jMFlP1BF7zUVsymILYTZS51SdGqdVKmbe7F5gT
         W7H2pkRhunEQFxeFlzT3xhHEuTALwlc5r/S7HFR94VpbgneKm4zMVB0vd1aDVFKvhmAO
         4zZmNa+pabm0UqudM7n1qGo5k96yNSRBzFcLzeHmFUCQev0j5qSTIHkwWNQVJdJdRfin
         DEgPICs36diGa1KlQqxM1wE1Ku7EMgoFDdUzfxbFpnY4FanfMQ4KUPWYAXCWR/mZ2jdD
         JaJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from:reply-to
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aj0IM0CjoexC2i+yXzlejMAdGHqKdzeRDWPxbdEC52Y=;
        b=yHcVnRCymg1STnG7MuH4NBadYFbni0dt9iAqFH3/y5GJq4dCzZRJAVU/9ycMQL3p4v
         qhb03pDDQELzH5PPpfgrxifcV+9E7VbEn2fQpHY2rJFbAvGijAjZICOHgbqS08YMBjaC
         UZS9YRhrGgyLc+EdAYz9S/KMoxiZMODOa9kGJze8ao50g7GhqU3wlsDUkyNBFDKKVotW
         PnBCvKo+FeR0Tyu/NC1egBy9xpCxUZX786frJxrmARjlIzXEZOqfx/Tf7BbWK8R4cehL
         WX+xKDTWVFgP7zwcyhlOt6lXTKzughPnjcyrup6izVe0m+clFA68POxt9w+aBSvo/H/V
         uY4A==
X-Gm-Message-State: ANoB5pm2m/tO6heYbDFFwJ9eF/nlFCjQr48/ui6+RhPkrsccDhEov/FO
        qrFISZZIeGW7CPRzpZiCYkuz3g7JOGcHM60q61A=
X-Google-Smtp-Source: AA0mqf6RNAS3BLxNGbG+6VbszxBZsCh5Lwxp+Nx0tJByBwVj3fDL4RyN+tNMFS7BsJ2gpqcowZENPTnJfzVaCuZEevs=
X-Received: by 2002:a17:907:9d04:b0:7c1:1342:61b7 with SMTP id
 kt4-20020a1709079d0400b007c1134261b7mr11287051ejc.524.1671463549653; Mon, 19
 Dec 2022 07:25:49 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a05:640c:1d45:b0:183:d190:e1fd with HTTP; Mon, 19 Dec 2022
 07:25:49 -0800 (PST)
Reply-To: sra.xinmeishen@yahoo.com
From:   Xinmei Shen <consultecanadalome@gmail.com>
Date:   Mon, 19 Dec 2022 07:25:49 -0800
Message-ID: <CADOWGUF7q6cuW3oFj0URQVRpuGhbiOWDoNWRYxiddajnSW72BQ@mail.gmail.com>
Subject: Re: Respuesta
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

Beneficiario,

Sali=C3=B3 con un premio de las Naciones Unidas afiliado al fondos
monetario internacional en el que se nos entreg=C3=B3 su direcci=C3=B3n de
correo electr=C3=B3nico y el fondos para su transferencia, as=C3=AD que env=
=C3=ADe
sus datos para su transferencia.

Se nos indic=C3=B3 que transfiri=C3=A9ramos todas las transacciones pendien=
tes
dentro de las pr=C3=B3ximas 48 horas o si ya recibi=C3=B3 su fondo, si no l=
o
cumple de inmediato. Nota: Necesitamos su respuesta urgente, este no es
uno de esos estafadores de Internet, es el alivio de COVID-19

Sra. Xinmei Shen
