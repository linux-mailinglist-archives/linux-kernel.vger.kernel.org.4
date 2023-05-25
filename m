Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D31C7107E6
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 10:50:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240446AbjEYIux (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 04:50:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240015AbjEYIuu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 04:50:50 -0400
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com [IPv6:2607:f8b0:4864:20::1129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0917B9E
        for <linux-kernel@vger.kernel.org>; Thu, 25 May 2023 01:50:50 -0700 (PDT)
Received: by mail-yw1-x1129.google.com with SMTP id 00721157ae682-561b7729a12so4318557b3.1
        for <linux-kernel@vger.kernel.org>; Thu, 25 May 2023 01:50:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685004649; x=1687596649;
        h=to:subject:message-id:date:from:sender:reply-to:mime-version:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+B4dgNIniQHEcCF576ZP77lV9Zwje+bwHibbyEl51SY=;
        b=qLhUq4OI/JpvDdnoXWOyt5XZfbBbAM7J+LhAnN77B2UJ4ptjBGNOOIEOq/mGb1xCf3
         0NI+dym2WQS513pA/m6Rry5RJ40H1RbSWjvYTOtHdJVf4/9xuixsbGTATE/hIcKJCSHz
         HLb/h3Sp8w2h8wWB8NW0LJuhdvcw8y63r2zsQwxvTFAb049pQVze1dN30s2tq5noudWC
         bithX5XKP9O4wXgM9yNw6zJ/G7rdq9zkMa+9QUcNPT/JGKI+309QbzwPekuChEFZuxCU
         WgY+lsBS2of7l6YPwa4HmG8DcT5WF72A0Iw02AEE+alES1MugJ7/Y3YJyMED4Ptg6Q5t
         01yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685004649; x=1687596649;
        h=to:subject:message-id:date:from:sender:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+B4dgNIniQHEcCF576ZP77lV9Zwje+bwHibbyEl51SY=;
        b=KPaUpf3P6mVkqC7qPIEpiKcILWyC0drL+1SojR7zRjIwhgxLtfES0KFbjuRItpXrK0
         z+0p8JTym+DyXRVqkAe4KdL0VP0ivfHtnZET5eHK9K3C+p1VKcdqF54MVvvJxgBNfKwO
         GQppMPm9Oud5hHgJHySutos9L/eRl3ey6d1Xa9m9CfDpxz10Vg77DFGvCQYUD3cDjRbg
         obgfmKkDKd7cGuph8pp0WEU7dj0MxtCKmvjAYnj0pFNBNOdOng7YdTu1vTlLNFHUxl6W
         ieajj1DmTH+pmXfJB6U2AjdbAZxKLNNdTWKVyG/oqrF+svAuIK5xI2YGga1GGi/HdIC3
         HArA==
X-Gm-Message-State: AC+VfDxEAkw63mmKHuuzRdsbNs/d0USEFdbowwIGsBWkatdqcE74mgzC
        wdORU5VUAtd550PnalLTKsVtEU9OvqqZMgSZn9Q=
X-Google-Smtp-Source: ACHHUZ4ZyBodIUDDGW+Ey5mLR3tP/rBVo9xtVaXp3wSng1pZaVCQmkC5ryCypRN4o1VGICi8Fj+PlXnNi1Eb3e+cdQ0=
X-Received: by 2002:a81:4d44:0:b0:552:ae41:50a2 with SMTP id
 a65-20020a814d44000000b00552ae4150a2mr2009322ywb.21.1685004649118; Thu, 25
 May 2023 01:50:49 -0700 (PDT)
MIME-Version: 1.0
Reply-To: vandekujohmaria@outlook.com
Sender: sw971116@gmail.com
Received: by 2002:a05:7000:4744:b0:4a3:9f3f:5b59 with HTTP; Thu, 25 May 2023
 01:50:48 -0700 (PDT)
From:   Gerhardus Maria <vandekujohmaria@gmail.com>
Date:   Thu, 25 May 2023 08:50:48 +0000
X-Google-Sender-Auth: JtDhxtcCy4e_7E8ZwMZde3ytDkg
Message-ID: <CADWhY8HVSz9W-dKRoGmFe0SuM6ozL5gTuuBH7+W8JAS+oL2yDw@mail.gmail.com>
Subject: Hello
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=3.8 required=5.0 tests=BAYES_40,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNDISC_FREEM autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: ***
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With all due respect

I'm van der kuil Johannes gerhardus Maria. I am a lawyer  from the
Netherlands who reside in Belgium and I am working on the donation
file of my client, Mr. Bartos Pierre Nationality of Belgium. I would
like to know if you will accept my client's donation Mr. Bartos
Pierre? if yes get back to me
