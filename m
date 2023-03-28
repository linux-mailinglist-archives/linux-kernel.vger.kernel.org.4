Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE9CC6CB83B
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 09:37:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232127AbjC1Hgd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 03:36:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232240AbjC1HgK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 03:36:10 -0400
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com [IPv6:2607:f8b0:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02CD64C21
        for <linux-kernel@vger.kernel.org>; Tue, 28 Mar 2023 00:35:33 -0700 (PDT)
Received: by mail-oi1-x236.google.com with SMTP id bi31so8275433oib.9
        for <linux-kernel@vger.kernel.org>; Tue, 28 Mar 2023 00:35:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679988928;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=zUPDzhqQG7pVvsZWPkDA6f8B20sI5Wp396ymMcTIkLg=;
        b=JWqsr2N7cdHtGIapR9Ee13lCa0yxwemAYJkWq4taaYxd9jVdpdHfoBdgSNa7LATL3Q
         WFoFapsGZ3kCWfTs2d8v+FzDDTfH1IqXnJAIPWsUsUBOp9DzaUFNx7TQv+x4AHfKiqUq
         61OWJz/3QzuExXlQTC0M4Pny+9AFQDsXB2fy881Fy76bWSdjt6qXpg/KKhT3VhT37u/1
         c8A4VvIYlEoKjZSo5C0Edmgx8nldV6gwN46wL+YS050J8Gflru3sMf9/+ec8G0JT05sB
         /Xtm//nkIsJNBpxhrhZ34HXCjKHquuLbUQ6+inwBGe+XtxW28I29EXIaVJcpov9BcKwx
         7e5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679988928;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zUPDzhqQG7pVvsZWPkDA6f8B20sI5Wp396ymMcTIkLg=;
        b=pbqGygiwyqjjZ+xMx+v2tYT/2jRlFOuFUk25/PG0cmnZYn7AULcs/976sfXuhzck8m
         IC7blle3eA8i1KCacIosP5uUANXiLf1yjutJ6ip9Ztptv3RCfYirR6dtGflhju3AAbjD
         1LwkOFryYkIVxqwZVvEq3fJ8X8gtbrDyJXI1l952oML2oUcZSBgHrAFnHlxvwa9RJSLL
         IIax/KB/Vgm3a1CpMyCjAhA1ZrxLshdUCevwajfGqZ8CpQJ0JzczgRUnKJ0uGgm3HaCP
         WnIuB+75uX0gGQ1lhlZeANnmMj+CBY96ugeNNmQpp+W7ubZyoSAkP2Dp6Ce6G/6+qGh+
         +dFw==
X-Gm-Message-State: AO0yUKUe7kEJgb113Jv9TrVbShbQrsyQHFG7UOtmwmjGhLbvsJgniPKG
        KbVQZKuZAfgBqXxjrfEP48nIf1IRd3YBhrmPLZ6YrnVM2/c=
X-Google-Smtp-Source: AK7set99xJ0uXImmGyfbFQc1Q9P1KiHBnO1+1mni/tfyZOgRev+khJfalFTVltVz2mkuCAJpePCeY4NdSprXbPSHhUk=
X-Received: by 2002:aca:1b09:0:b0:383:fcba:70e6 with SMTP id
 b9-20020aca1b09000000b00383fcba70e6mr3801174oib.1.1679988927948; Tue, 28 Mar
 2023 00:35:27 -0700 (PDT)
MIME-Version: 1.0
From:   Ann Zhou <annzhou99@gmail.com>
Date:   Tue, 28 Mar 2023 15:34:00 +0800
Message-ID: <CAB=gZe-GQ+OZmUTcMX9RYKzXQEHCNAURjUWnH3uA6cKHkwnyDg@mail.gmail.com>
Subject: electronic components
To:     linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=0.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey guy=EF=BC=8C
Have a nice day.

We are a professional electronic components vendor in Shenzhen, China.

If you are interested in=EF=BC=8Cwelcome to make an inquiry.

Looking forward to working with you.

________________________________
Best regards!
Ann Zhou
GOSON TECHNOLOGY (HONGKONG) LIMITED
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
Add: Rm B313, Building B, Changan Zhigu,  Shajiang Road No. 199,
Songgang Street,
         Bao 'an District, Shenzhen China
Phone / Wechat / What's App : +86 18894784132
Website:https://www.gosonxm.com
E-mail : sales01@gosonxm.com
