Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DDB7639A16
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Nov 2022 12:22:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229555AbiK0LWw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Nov 2022 06:22:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbiK0LWt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Nov 2022 06:22:49 -0500
Received: from mail-vs1-xe36.google.com (mail-vs1-xe36.google.com [IPv6:2607:f8b0:4864:20::e36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86452DF13
        for <linux-kernel@vger.kernel.org>; Sun, 27 Nov 2022 03:22:48 -0800 (PST)
Received: by mail-vs1-xe36.google.com with SMTP id k17so215858vsr.10
        for <linux-kernel@vger.kernel.org>; Sun, 27 Nov 2022 03:22:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from:sender
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=fKI9vFEPXIzHzVFr+QxTcG5Lyf/zrgASR8cbrQonBSw=;
        b=Kgc0NcKlEc89svpcxUZzXQftexvYKuZHbrr9p4ogOFL8+JzY5cXS4z8nnArXS14IAo
         BSwMjSaLVklUMej5Yg7t3nTp4/Z4bqON+IguK1NTMCMvaNu5+HbkA8h/fy0g2ElTHkGg
         WW6OnisI9mdN6JH18aOz6nVJAtcInAjcAXm6z4didplxDEdey8+FYQ/5UPyXAUD66p7F
         RG8lQx2MP1HtQVlo7A7GRgNNAhBH7mnRDgKPPiUW6ecpNHhHzn817qKSM7BYXycgkqP3
         FWSwIMnLpVihLAQ4qTjiz9okEw+I0KXGo5tHrbyhQItyvnNND0LoGHju2N75nHjjjOfi
         Smeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from:sender
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fKI9vFEPXIzHzVFr+QxTcG5Lyf/zrgASR8cbrQonBSw=;
        b=6f647cKNZzPBU63a7Bhw/61jRp+PgFLJF2cvHbqtYmyrMrHynJaHxZfU3Cth2yeZ3o
         9xHkOgAiPdKiGCAOdhw/kfvlD4lW6hrVdgHHs8rnRfJA1Xoa+Ma1Symas1Zq076qfX9W
         W5MjZxxM6ksySA7ukOquXfS9JpyHHi00PUCf93oAudx+FIyNh6whYGbbMeqo467/1sAt
         X++ps0t6u39EoFl49EDxjYPYjLaMOhuK3hvfq3Bp5di5lur69Fp/OLgeCLdigxU1i7ry
         7skBuhVRXTdJrZo1Rk1apR47brCFKu5IvLbcIbjvkaaErrJioqmdsMrDKJIJJ3v5oTiG
         fqQQ==
X-Gm-Message-State: ANoB5plVXFeY1L0Pf3saHj8/LJczcSFij/ASZ/g+h1SIIUspZlCdDLHj
        tEa+mUM58Pj7/b2hR+KhoBlz1p6zdlP3KP2JdiU=
X-Google-Smtp-Source: AA0mqf4ET5gcD0ClzSd02IfAjNl5pkP36nlPhT8nYN1U5oZ09Gh5OO0TdFwRllW5SiJfdH92eKBG08hg0T9H2Qa6TgM=
X-Received: by 2002:a05:6102:159f:b0:3b0:51c3:fab9 with SMTP id
 g31-20020a056102159f00b003b051c3fab9mr14128692vsv.63.1669548167531; Sun, 27
 Nov 2022 03:22:47 -0800 (PST)
MIME-Version: 1.0
Sender: mr.handase002@gmail.com
Received: by 2002:ab0:3259:0:b0:3d1:7be7:2eb6 with HTTP; Sun, 27 Nov 2022
 03:22:47 -0800 (PST)
From:   "Miss.Cynthia" <cynthiahazem11@gmail.com>
Date:   Sun, 27 Nov 2022 11:22:47 +0000
X-Google-Sender-Auth: M6jFiSOEOEytDd48oeCW_jCGYvA
Message-ID: <CAPq4bZZ66fTR1DzRgiVDD8cV4+EhwdOnnuLh6+gk7Z50SEzmeg@mail.gmail.com>
Subject: =?UTF-8?B?R3LDvMOfZS4=?=
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=0.9 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_HK_NAME_FM_MR_MRS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Gr=C3=BC=C3=9Fe.

Mein Name ist Cynthia und ich bin ein M=C3=A4dchen aus Tunesien. Ich habe
Ihre E-Mail-Adresse im Internet gefunden und beschlossen, Sie wegen
etwas sehr Wichtigem zu kontaktieren, wenn Sie mir nur antworten,
wof=C3=BCr ich bete.

Aufrichtig,
Cynthia
