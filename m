Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4EB56EE0DF
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Apr 2023 13:08:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233361AbjDYLIP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Apr 2023 07:08:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233554AbjDYLIN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Apr 2023 07:08:13 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2156240FB
        for <linux-kernel@vger.kernel.org>; Tue, 25 Apr 2023 04:07:41 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id 4fb4d7f45d1cf-507bdc5ca2aso9966825a12.3
        for <linux-kernel@vger.kernel.org>; Tue, 25 Apr 2023 04:07:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682420859; x=1685012859;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=tZDpkWkPwSqvS+OGwjsMWdVZ65s3MQQGCpo5qK8LiIk=;
        b=nep088igHyzYjH4ffAeQerALaqVVaveH6wkJK8vhROt2bYMQJeFKo9qKMYLmczi7c/
         2TQfXvYELwVW10bKdMOqhiiqojqXroCQSUr4mosCosTGdwUAUpDf3SuDZyPUxkcq8fl3
         O3GG4zl/eD5nntml5FmaK2akcNnkX7JnCKxrSH82f8UfuR9m+Ro+siSsW1LfG+6zUrM2
         rP7b5qlhdMiCNYFTz4pF5fqqKQgUkBOS/pkYasCgZOd2deWRqnP19OV75NWqh+2i+lEo
         DVCEkXfv7yCae0PMRNzzd2SisEtP5Sw0DYd/H6LGj73byubpkZGTZ9Q6717Z91MTUmrP
         OfHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682420859; x=1685012859;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tZDpkWkPwSqvS+OGwjsMWdVZ65s3MQQGCpo5qK8LiIk=;
        b=VHkOu9garuSEFdbjh4Ogxr2I8cHLigHbeS5pVZ8pYA/Hw+wOckcVXQ25afecW3FC8y
         y2nTVK9/FNKTiAGXQPUzLpYty44J8I02bDWmz3Z7wuLlaRn7Msv7InBU7Gz1XCi9OLSQ
         OYiTf4dQWsA0QVOySFp3OiLxduLIeMEaLm5mjmqop4njKLvoXyCowHKuvodMxIbR6V9t
         IpkKfvDAMdbaAsl5FwgS2ITuqTUexy6bGBQvL5X7SM0o5o429Rz4NVRhqutRmZEscgU9
         zseTHyrAJWloIH+7+p141y3vCQjmzZ3E8YvZ3dRW1PNXsWJseUMzEeAZpVLT23q7IfvM
         dNWg==
X-Gm-Message-State: AAQBX9c8kgKHCieOh3F2c0fH8/mH8aZyE70HVRXMzfUNS0xEpnXPfqhd
        YHL+EnPJB1ywG7hGeu1yO/94XFErbNEUe9yPAAsTwhM4F0Q=
X-Google-Smtp-Source: AKy350b7H22Q9onIRJiaNSXj+ds7a/LxaXqVtDk3emNBF6QYZ/KsNGtdA0tUdt+Hokwh1Qk4gpLm0hTBHF4x46seFHQ=
X-Received: by 2002:a50:fb0b:0:b0:508:4120:201f with SMTP id
 d11-20020a50fb0b000000b005084120201fmr15084550edq.35.1682420859211; Tue, 25
 Apr 2023 04:07:39 -0700 (PDT)
MIME-Version: 1.0
From:   Raj J Putari <jmaharaj2013@gmail.com>
Date:   Tue, 25 Apr 2023 04:07:27 -0700
Message-ID: <CADXzsihkMLoWoPh+WfF99HkvVUGNtD44nEor8Fqg38z1Coi3HQ@mail.gmail.com>
Subject: programming tips
To:     LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

you can do stuff like

int x = read(x) = process(macro);

its like a little loop that occupies a thread

lets say im doing cpu stuff (im new to kernel programming.. some
asshole fried all my monitors) and i want wait for a return value

i can do
int x = cpu_read(code) = return_value_that_you_seek;

additionally i feel that, with security, that there should be a local
sql server tied to the linux kernel, so you can do stuff like easily
share data in a lan

sql in the linux kernel can be sorta secure if you do it from top
level = kernel to down = userspace

hope this helps, new to kernel programming and just want to help
