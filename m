Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E44076873E2
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 04:35:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231921AbjBBDfV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Feb 2023 22:35:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231705AbjBBDfS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 22:35:18 -0500
Received: from mail-vs1-xe2a.google.com (mail-vs1-xe2a.google.com [IPv6:2607:f8b0:4864:20::e2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBECC1420F;
        Wed,  1 Feb 2023 19:35:12 -0800 (PST)
Received: by mail-vs1-xe2a.google.com with SMTP id k4so512790vsc.4;
        Wed, 01 Feb 2023 19:35:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=QiX3UcRTZwH0PLnaIsBgvLzcPBnC8tyuWq+Tqoi57VM=;
        b=LQUc4BmX3WhY4mCYLPKfRRvqUABK3NtdI6frXZWIw2784c3oIQ4Vos7Gfhs7jCn7FK
         ynUp9byn/0vh/mgPEfgfa2s6HUwC/x8103svoUAmaCr6lqe6qs+ynwJfzZgpGprvNqEa
         K/fIl+LWWDS910UYITK51n3aU2u9jfgox/mCClFrVHeiduGiwSkhWUMy+45sDj4wPY+l
         b5/3gDmJDha/kuSwQr68eyFDIoKXruksNowHFRr20PCvEL9wSAvc4tYoIVNHX6fLRDvW
         4xHfgSrKFDpE065ma9Lr8QwzS8MfsoWf64vPignS7vm5f1KXPQQY7q0Nd285c7QcfD65
         5v/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QiX3UcRTZwH0PLnaIsBgvLzcPBnC8tyuWq+Tqoi57VM=;
        b=Zn6n2kuFcxwCGLNjGcSX93+joORiNiE/pbcXE6tnJU6vfz/2ka0botMq21SdvdP54X
         bB6s3uBuh0PQdU6P5Xee8sVOQ2L2lsdU7sT75XTlf3EE5SKQnRqDdATne0c+owAc4q9p
         cYXKmcu0XhypOhH9b+VqcbIHvBbxLmfqL4DmDM6DOqZ8L/V9ggz6mZ1yDjIJbHToMpvV
         gHYuNo9niZ1N8ph9PSD0d7HxLKQ47wb5ue5AkApEexjisBYTcXQfS9qaXpVelLcX9957
         2v0ypzuM+hWMObzT1GKKSUTCzMfcik4m76vz1YrloiC5dw2mRP/fohkcAutwPcqOLxo9
         J8jw==
X-Gm-Message-State: AO0yUKUMUmk5Qc5n6+6ptr8ZDh1nFU+CBvFcvDEyITuhdROg7Ss5aMeo
        XlQhyE6kLD8s2Ba3zwGAQvLChfwM3axzW2aj28c=
X-Google-Smtp-Source: AK7set97jRS3svZhsG5T+qiZsHY/NEQaMcAWihNka2rtA4CCpDWrOkoxXYP4/3EZzRL1yy4Mm6pL6xwG6axK7PFRcMA=
X-Received: by 2002:a05:6102:1276:b0:3ee:4ef8:45d3 with SMTP id
 q22-20020a056102127600b003ee4ef845d3mr691400vsg.64.1675308911888; Wed, 01 Feb
 2023 19:35:11 -0800 (PST)
MIME-Version: 1.0
References: <20221227095123.2447948-1-milkfafa@gmail.com> <20221227095123.2447948-8-milkfafa@gmail.com>
 <b8f173c0-6d40-d6aa-543e-fa8b06557f4f@molgen.mpg.de> <CADnNmFr1naRfam=z0p-4hEugSDJy_HCK8XZyQJ0eFirnmwuH4A@mail.gmail.com>
 <4d64e3f9-57a3-c6be-2709-36e9a1617bf9@molgen.mpg.de> <CADnNmFqFMBUj07oAZze3eeXAR0hbep4p9za=XNu5YrLVqUex=w@mail.gmail.com>
In-Reply-To: <CADnNmFqFMBUj07oAZze3eeXAR0hbep4p9za=XNu5YrLVqUex=w@mail.gmail.com>
From:   Kun-Fa Lin <milkfafa@gmail.com>
Date:   Thu, 2 Feb 2023 11:35:00 +0800
Message-ID: <CADnNmFqtUMnyCCnKfk3DUJ-VLgJdwC8X6fznVYCF6V5jeZ2bNw@mail.gmail.com>
Subject: Re: [PATCH v10 7/7] media: nuvoton: Add driver for NPCM video capture
 and encode engine
To:     Paul Menzel <pmenzel@molgen.mpg.de>
Cc:     mchehab@kernel.org, hverkuil-cisco@xs4all.nl,
        avifishman70@gmail.com, tmaimon77@gmail.com, tali.perry1@gmail.com,
        venture@google.com, yuenn@google.com, benjaminfair@google.com,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        andrzej.p@collabora.com, kwliu@nuvoton.com,
        devicetree@vger.kernel.org, openbmc@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, kflin@nuvoton.com,
        linux-media@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Paul,

> > >>> +MODULE_LICENSE("GPL");
> > >>
> > >> Not GPL v2?

When using GPL v2, I got this warning from checkpatch.pl:

WARNING: Prefer "GPL" over "GPL v2" - see commit bf7fbeeae6db
("module: Cure the MODULE_LICENSE "GPL" vs. "GPL v2" bogosity")
#2104: FILE: drivers/media/platform/nuvoton/npcm-video.c:1816:
+MODULE_LICENSE("GPL v2");

It looks better to keep GPL, do you have any suggestions?

Regards,
Marvin
