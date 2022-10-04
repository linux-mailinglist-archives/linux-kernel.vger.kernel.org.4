Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3282D5F3F45
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Oct 2022 11:17:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230385AbiJDJRr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Oct 2022 05:17:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229705AbiJDJRm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 05:17:42 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 305D22CC9F
        for <linux-kernel@vger.kernel.org>; Tue,  4 Oct 2022 02:17:41 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id b6so14596926ljr.10
        for <linux-kernel@vger.kernel.org>; Tue, 04 Oct 2022 02:17:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date;
        bh=7cz8B92GLUd8cNOrq89lrIWmGPjV1RnqOIT6dqWa4nY=;
        b=FZZrdGls4xMs0zlC0csGThOmpVKXkpOtDgBPROIyzGG+XNvAY6UcPEesTO04X3oIVV
         OOoCnibDwFS52SfHvB9GwuthqDo1XVYmVRj8BjRDsYOedFrMfXfBua6XgjTo2kCbp6vO
         sjmllBDLnEFYQS9/0a1M3t5FlgffehZiohyKAib+ga0/jU3D83HEMJI/mw+FQ83ghZ+b
         tvFdxMh1K1+6U7uVOXQ31hIaWHkzt/cpOpjveL6wde72dIu9Xr53GyqBu/AqcGY+ZWs+
         2lscAHOCnpnhR+GpbrMwAU2ZqUzpGGTT+FecjQSOehIB+ElJf/vl1mjaiGK5XetOKKrx
         fY7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date;
        bh=7cz8B92GLUd8cNOrq89lrIWmGPjV1RnqOIT6dqWa4nY=;
        b=x5jd0K/gKIf4rCRqGWFRodG8RGMDXJ3/g5t1FFsk++4oM7WOqZvbeAr4y1i7334BsF
         1a/lTbEARfjLSzq0ueuagqPQJmyIlVwYXswATIpLXNEsKCD6opPVMp1TOijO/tnXohsX
         Zcydy+dYSdr1nMuBy7SiF4Zamrajp+pIoFhvG1FTZLXzXrEsIPpvw/khGYWsCKuweIRF
         Hrsjzdsn0ZRVOnGw9UgcOHZy7O29ja3F8xZzZeaePUNidBs7Wl9DuLIIQpVZEov6ngqx
         J0Zh35JUNVsajKzvItjnZWYcOSIAe2c/HkpmatxP3JwSckUNcJXzP3/Mnp2/sgHNXeh4
         wZ1g==
X-Gm-Message-State: ACrzQf2C+YWMBVCiWUaEcBGDt0tV/WAZvUUri4TuyFdXopoyXwO2ZO0V
        37VV9ymBwYnz/Bwwg4Ivizs1f6PnWfsqjyR9rIho7X6fzOw=
X-Google-Smtp-Source: AMsMyM7IerhYUDPDOLSwJlnQ/xUInb5ZzMBKAmRxEnBAnbBvKsuPlm3qM+mXVRVXlLupIZsAMGEoFQlHAXzcLVGi4Wo=
X-Received: by 2002:a2e:9ec9:0:b0:26d:c7ba:479f with SMTP id
 h9-20020a2e9ec9000000b0026dc7ba479fmr4743682ljk.146.1664875059116; Tue, 04
 Oct 2022 02:17:39 -0700 (PDT)
MIME-Version: 1.0
From:   wu seafly <seafly0616@gmail.com>
Date:   Tue, 4 Oct 2022 17:18:05 +0800
Message-ID: <CACwS5zPAH-tBkZxxpZ5x3af_qMVWKct29UCGuzH4geswBjCU_w@mail.gmail.com>
Subject: Clean the rust spot
To:     linux-kernel@vger.kernel.org
Cc:     me@alancui.cc
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This email was sent on behalf of AlanCui4080<me@alancui.cc>
----------
Hi,


As we all know, rust finally stepped into the kernel mainline.

However, there are many people with a negative opinion of rust.

So if you are like-minded to me, please give "non-rusted kernel tree"a go.

We will keep the source tree up to the mainline but NOT RUSTED. Once a
core module is RUSTED, we will CLEAN it into C and keep it up.


Nobody can also make differences.Let's do rust removal together.


Alan.




The first rust spot on the kernel:


author Linus Torvalds <torvalds@linux-foundation.org> 2022-10-03 16:39:37 -0700

committer Linus Torvalds <torvalds@linux-foundation.org> 2022-10-03
16:39:37 -0700

commit 8aebac82933ff1a7c8eede18cab11e1115e2062b (patch)

tree 8305fe6437fe1db1a5dedf218d53a6bd21120793

parent a5088ee7251e5106a4efa9588a73866eb4b4154e (diff)

parent 615131b8e9bcd88e2d3ef78a4954ff4abfbb1fb7 (diff)

download linux-8aebac82933ff1a7c8eede18cab11e1115e2062b.tar.gz

Merge tag 'rust-v6.1-rc1' of https://github.com/Rust-for-Linux/linux
