Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9DFD734454
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Jun 2023 00:22:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230510AbjFQWQN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Jun 2023 18:16:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbjFQWQL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Jun 2023 18:16:11 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC7E8E52
        for <linux-kernel@vger.kernel.org>; Sat, 17 Jun 2023 15:16:10 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id a640c23a62f3a-9881b9d8cbdso90866866b.1
        for <linux-kernel@vger.kernel.org>; Sat, 17 Jun 2023 15:16:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687040169; x=1689632169;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=wau2xWZUdYqvQ1F4cBXEqcjOnSavN2WgrVjSh51w6XI=;
        b=g6rcCodOSybZr/mz8fcH2LjfWpTNBusQROxlpPDBBbMYu2fTqtYD/yof4y4tIrq4/A
         8+ONOvikuxQlHZciDdnPcO0A1wamC4X9xsuuvsffnLDzDcaNfsUVz1PlKQzprMivuDSn
         UED/xhR6iEdbrgHeyBS9AkRVrCvPkgrwJniM3GSjK2IOfh3DDzncrKTXZpM/ECObwcjt
         skodAPc9q7sEbgIMeQEqbF5MDD2wnELgGkdhyXrbZqEgJYe9SCgxp6EKE8wYHdmU5d7N
         +RMybkpptL+987DSIa5HN+dXTomdq/luKi8TO+Igh8rToRwHFEIsCnMnkK8QHlhPe/tm
         1vDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687040169; x=1689632169;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wau2xWZUdYqvQ1F4cBXEqcjOnSavN2WgrVjSh51w6XI=;
        b=HfEPXveipa2vr8plbs2hrXOZRq/3yTJbuedE+A76nLpRnqfIHUhyXPLBf/DvPdG92J
         Moc9OL9JdXvqnDtMNY9J9JaE5dNoUusDbpB7A0TkeOr78ppulr3F9434Bp1qo9gA/rnr
         inN+aFlybQvwWzhmdV9wxiaWzAxmBM7jUxgRonTvD4UaT2e6fybQ/j189IeCsTZwA8PC
         zRU17JT6kRzCop80ONUvIPPNw8SfUkM+skTyr9+9+l2nwZB1fuoBdjr0bYeDwOBH4z15
         JQ7Vk7gmvE5ECWyfm4w81Vf3luZUUSmsY3uY2MzQOG17AZ3mahHN4DLICx8YKM+HtJA6
         lTyQ==
X-Gm-Message-State: AC+VfDzDmExeWspiqVyPfSEkHcIl4NO5MhwrovcWLpk0t0KbwSsa8L/O
        hpoma/f0IgbZA0DRjYxczJdknqNTuYFaE1V7jfv//HxH
X-Google-Smtp-Source: ACHHUZ6M8wtWD23zTIL+O24bbay3F+trbYVwlyjosukWDYltqJsSuBaJwtxEeS1v14SWHSbOT4QLmiB9U5JSE708mP0=
X-Received: by 2002:a17:907:84b:b0:94e:4285:390c with SMTP id
 ww11-20020a170907084b00b0094e4285390cmr4906937ejb.10.1687040168764; Sat, 17
 Jun 2023 15:16:08 -0700 (PDT)
MIME-Version: 1.0
From:   Jon Maser <jonmaser8@gmail.com>
Date:   Sat, 17 Jun 2023 15:15:57 -0700
Message-ID: <CAF=mWJMZF+8VZE=UutUb=ZzL-EjKXT1KQxHtd=VSX--43ew_yA@mail.gmail.com>
Subject: new alchemy discovery! you can compile the linux kernel with the c++ compiler
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

(and a rant)

first the rant

i believe the linux kernel is in good development, im saying this
because my audio sounds better in linux then in windows, sounds like
we have a solid crew

but linux needs programs. were talking big names that everyone can
use, with a business model and everything, but whatever

anyways, you can modify the makefile of the kernel to compile the
kernel in c++ easily

freebsd/c++ freezes on a virtual machine on boot, i believe its the
bzimage code in linux if it still works in 6.3

linux/c++ (you can fork it baby, yeah baby yeah!) can provide very
advanced usage, including abstraction, paradigms, a wide set of object
orientated libraries that are open source that are advanced, and c++
has a practical use in the computing industry

id research but i have pc and medical problems

you can do stuff like, make an object directly from classes in the
kernel libraries in the kernel, its like systctl on steroids
