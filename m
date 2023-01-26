Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E133867C6B1
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 10:15:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236711AbjAZJP5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 04:15:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229641AbjAZJP4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 04:15:56 -0500
Received: from mail-vs1-xe30.google.com (mail-vs1-xe30.google.com [IPv6:2607:f8b0:4864:20::e30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 958045AB5B
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 01:15:55 -0800 (PST)
Received: by mail-vs1-xe30.google.com with SMTP id y8so1347632vsq.0
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 01:15:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from:reply-to
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=1qHBbKgw2Jw+0BKs8Nxpf189+VTp1lz24Npoal+8f/g=;
        b=QE2Z0ahy4TMPXwATR4KOfI/nzE7PNcbCSS0ryLbTXGpdDbDSvRnAnvwfD3UmZ7G5LM
         VzGaUgu7mn0F7SaYUPGD4Z/c4Kn/AHGhUYXQvsPby4PGAH3MMoRR86zE4iB7yoEXjR/X
         kitAWEJH7E4nmFIf2G4Y0hWwXQaWeK0z+dmj7dynzts+g1AP8bUPEgk8TB5z5L+Cys7N
         5GxIx+ldKlrMNiD4TdJm8KuyecI7xVyIfQcZqMaIfFjqSqqyUxScxh+7dsPTyOT9kkxj
         31KsOA9KqcA92RSHJvONvVpr1FfoPqf+/zoNkAO6aW+RdSdUBGnnlt9DU5UtnV2b0qjs
         xNKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from:reply-to
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1qHBbKgw2Jw+0BKs8Nxpf189+VTp1lz24Npoal+8f/g=;
        b=NcVlSdwsMK+eGWhw2cqgcFBTHfUTVPZM1+5FOV1Bz9BdMePS3D9S3H77vkOm32g9Tt
         +bKScso3baA2yf/U3Qzf9XVwLmrk8NmPf/a2Szvfq42sl1jMgag8cOggA97OxIW0bDwl
         L3jlRk2sAxIEvOsDt1TDgXE4FwQpce9Zj6JwjV6a414P7phun7tKJaWQRqG/e0Co8lri
         YhPg0HcVzgA0QDAi0WLFvTidHn0IXEeXCPotQd+/ZHhcPDEvkBR9Qyjb8obadLyd07c2
         gA07Jl2VThvNlvfavUarQk8o7LK1V3mrsr//GyDwQArrwSPskgTvcU2jw21bT8ady4St
         5O0A==
X-Gm-Message-State: AO0yUKVtV8PItafpfGmi9VesrDoj0+nw4UX9qPyToOQ3ti2FYGs8gcgx
        lAXX4QrO4ZX+CezwOYc3lVs5JMAX7eXarZNvkr4=
X-Google-Smtp-Source: AK7set9nc3qt1wL0fdhLY3Uv/uGemKhwoQ0VesVJfXnxyL91iJWhB9rxkzSTAu+vSoqUUcu5a2yJqGb0etN8IRpJmxY=
X-Received: by 2002:a05:6102:14a6:b0:3ea:c7ec:50de with SMTP id
 d38-20020a05610214a600b003eac7ec50demr224139vsv.77.1674724554749; Thu, 26 Jan
 2023 01:15:54 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a59:dc41:0:b0:395:e450:a202 with HTTP; Thu, 26 Jan 2023
 01:15:54 -0800 (PST)
Reply-To: madis.scarl@terlera.it
From:   "Ms Eve from U.N" <kimanguyen542@gmail.com>
Date:   Thu, 26 Jan 2023 10:15:54 +0100
Message-ID: <CAEFdNaw6ucpQR-E0w6UoKCLdvNc=x7_C4CuFKQtSKZOakr_ZNg@mail.gmail.com>
Subject: =?UTF-8?B?T0RQT1bEmsSO?=
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=2.9 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,HK_SCAM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dobr=C3=BD den, dobr=C3=BD den, Va=C5=A1e odpov=C4=9B=C4=8F je nutn=C3=A1

R=C3=A1di bychom v=C3=A1s informovali, =C5=BEe ve=C5=A1ker=C3=A9 na=C5=A1e =
snahy v=C3=A1s kontaktovat
prost=C5=99ednictv=C3=ADm tohoto selhalo va=C5=A1e e-mailov=C3=A9 ID
kontaktujte Barrister.
Steven Mike { mbarrsteven@gmail.com } na sv=C3=A9m soukrom=C3=A9m e-mailu p=
ro
uplatn=C4=9Bn=C3=AD sv=C3=A9ho pr=C3=A1va na n=C3=A1hradu =C5=A1kody

Pozn=C3=A1mka: Mus=C3=ADte zaplatit poplatek za doru=C4=8Den=C3=AD.

S respektem
pan=C3=AD EVE. LEWIS
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
Hello,
This is to bring to your notice that all our efforts to contact you
through this your email ID failed Please Kindly contact Barrister.
Steven Mike { mbarrsteven@gmail.com } on his private email for the
claim of your compensation entitlement

Note: You have to pay for the delivery fee.
Yours Sincerely
Ms EVE. LEWIS
