Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E5A262B64A
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 10:20:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233545AbiKPJUC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 04:20:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233506AbiKPJT5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 04:19:57 -0500
Received: from mail-vk1-xa33.google.com (mail-vk1-xa33.google.com [IPv6:2607:f8b0:4864:20::a33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82233264AE
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 01:19:55 -0800 (PST)
Received: by mail-vk1-xa33.google.com with SMTP id g26so7923654vkm.12
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 01:19:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=BUN7/4LmlekQxxQ0sXdskXPaxAf94LKcc0d3rUx3r1s=;
        b=ollJLf1Jg84MwsEVRPIA1MT5NBd3ypjsOlaGQ207JHRbhdjzkHoFfiQx92AWNggo2V
         QgMGD1QD4VAQBMRj8H5/VYcEydoicYj1Xs9a6N+NfrJ0mwFD5FRbbKdoaGnEwpMS5iMb
         fzIIrztJL6OSYXKV/GqjONxsR2UW77qeGrMlXPMloN1WRJHEoXg2NPDXEZN/uIJ9145F
         Al5uQWpW0TciAT0ts4kI8t3E94rjOqkJPS1TWj55VoxR6ODuMy3vPj7viBjy/CakP+AP
         rTwg1VUwGcGjyQ840KTq/qXQiVAyFWXw7Wo+bXX5hhtWZr2AZfI6bFsLWhAKHzS6HgkI
         D9kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BUN7/4LmlekQxxQ0sXdskXPaxAf94LKcc0d3rUx3r1s=;
        b=VRrjojQir4ztzvOddOGlt2cJkhXipy66JIScWYhr9dV0KIgK5zlRRAEFRxQyxD3W+Z
         gF+k5DCvHiRatKbbVMPKuaZF79ZfOksrHn905KKzqjImdweP4QLG4kjk5ddzxY7neTa2
         qyUCKY7Re9uTHoIsIKnRydnQGmTs+aZku92oc7rieAYahz7zrd6J0SXQvGCugMKf3hLU
         DfkwOBvm4idvAPiZPZnD64VI81r8NXB2fdISBt8SCpcnMzm8oNCr9wUPvE9xdY/cM5YJ
         bPMHpLOJQ58Gr11AdHvAjS2z8qD2It+v8fuqOogTHcCjbFVEubN5w/5rGqdJ4WgmTWtG
         Ktsg==
X-Gm-Message-State: ANoB5plML8XZao8R+epuX84HYwJiy8yAp/q6P4HgvtboXrj/wujczSEG
        LBMdhxxhMOvd65LqSug9rSIE4Up6cd4JtAuH6eBilg==
X-Google-Smtp-Source: AA0mqf7+38km0i0PCChmHH1AegbkOQf6ZutAJR2EMP69gRCuIpgWSEbF2mCWmGSmCboGG1wAk2yrP6aQ8HZB1Ou4rGc=
X-Received: by 2002:a05:6122:2209:b0:3b7:3aca:9868 with SMTP id
 bb9-20020a056122220900b003b73aca9868mr11918281vkb.33.1668590394633; Wed, 16
 Nov 2022 01:19:54 -0800 (PST)
MIME-Version: 1.0
References: <20221114202943.2389489-1-bmasney@redhat.com> <7420da17-d6d6-10e6-c87e-d3dc37d17ffb@linaro.org>
 <CAKXuJqgckbmikXwFi0g3P3Db5jvyst+xhQBcPoV7mA2XStVVzA@mail.gmail.com>
In-Reply-To: <CAKXuJqgckbmikXwFi0g3P3Db5jvyst+xhQBcPoV7mA2XStVVzA@mail.gmail.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Wed, 16 Nov 2022 10:19:43 +0100
Message-ID: <CAMRc=McxHpm98eeq3jBdVKjqG1w2jhrPFe-5GuabwBaW1pTAUA@mail.gmail.com>
Subject: Re: [PATCH RFC] gpiolib: ensure that fwnode is properly set
To:     Steev Klimaszewski <steev@kali.org>
Cc:     "Bryan O'Donoghue" <bryan.odonoghue@linaro.org>,
        Brian Masney <bmasney@redhat.com>, linus.walleij@linaro.org,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, psodagud@quicinc.com,
        quic_shazhuss@quicinc.com, quic_ppareek@quicinc.com,
        ahalaney@redhat.com, echanude@redhat.com,
        nicolas.dechesne@linaro.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 15, 2022 at 11:02 PM Steev Klimaszewski <steev@kali.org> wrote:
>
> Hi,
>
> Others in the thread pointed to Thierry's patch, but on the Lenovo
> Thinkpad X13s, that patch did *not* fix the issue, and with it
> applied, the X13s still immediately reboots as soon as exiting EFI
> services.  With this patch applied, the X13s does *not* reboot after
> exiting EFI services, so thank you for this patch.
>
> Tested-by: Steev Klimaszewski <steev@kali.org> #Lenovo Thinkpad X13s

My bad, I was under the impression that Thierry's patch fixed this
issue too. Now applied.

Bart
