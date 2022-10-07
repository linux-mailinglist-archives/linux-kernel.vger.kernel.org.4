Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 814E65F7A36
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Oct 2022 17:04:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229921AbiJGPES (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Oct 2022 11:04:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229539AbiJGPEQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Oct 2022 11:04:16 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88BABDD88D
        for <linux-kernel@vger.kernel.org>; Fri,  7 Oct 2022 08:04:15 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id 129so4896938pgc.5
        for <linux-kernel@vger.kernel.org>; Fri, 07 Oct 2022 08:04:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=lhpQtxQPreKPextix6gPpSleYRkKFNce+PIqc6irMr8=;
        b=dQMffJGUZJxJA4sQ8Y5dwws2hkZgcwRnzVzz5olQpBNjAJUZ3cfD2ZWgRPV5EbORgL
         lTIq7iEkz/6Xcj6qVBmu9DF7xnpHSUIljS/2RJIYWHfyJH73CNgGQdO4cH4QH2yYG3Kw
         nQE6T5t4srqsVoLjQUOFqqWEtjfwiOoQPjJP3qynYimUgIV41UX2AJHM/Qka9uXG8jft
         f8s0/DQTltKB6RVxEYjACj4prqaLip0yxe2vV7ZxQah64n9ctJ65oKE0mQp3QtlYaKR5
         6OSjlBEtuwPdF67dHFLfgE1No4+4Kr5QPrZFuFNLL0UWToJPwibsvts1XUFSOd35VW9W
         gbEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lhpQtxQPreKPextix6gPpSleYRkKFNce+PIqc6irMr8=;
        b=TAHmJzANskCwo2qpNvBg5EEQC1x4nm6WIMASsFvlQ/jhDXXK1/l5S07g1oyBlUB0Zr
         7maF2SUjN6LmWUQUbC/bwnotwaChHVkjnL4G8Y8qKwLAiRmPv6Qk7sCbmJMy2lxNqnVg
         meI7DmQzT7cArCmQQht5B66LHMWzoqxwisAMzLMjotu/4Ug69S7BtBEP7tdUxrUWQt0q
         skQPak7oOUwRoi+CI+NryimIWLIgGmnIghtLoH2BsM+haJONG++vpt5QVY0txkfG7Z/s
         6Tv2URnOAznp9lzsN+0cBxvMR29cCnLnRv7zHZXda4x7OiiQpz1w3qYyrXaJzBbq/LUM
         jbnw==
X-Gm-Message-State: ACrzQf08gP6v1Ch3n75mRFQFf0spigS7eqCo9KUDMvDkRJxDd2LZKuXz
        KZoV1s8GIBaL5wJZ+IgqeW0zBcwuJYT7H1YkUSE=
X-Google-Smtp-Source: AMsMyM7jzpv9ewSpj2GwsSRt6+Nd3hLEwyLgcPtWbX+6OHk2iAK6e1sRmqjzt+YZioG23NrLz+7CVEEdSqFpaj01BJI=
X-Received: by 2002:aa7:9a09:0:b0:562:64cc:94e0 with SMTP id
 w9-20020aa79a09000000b0056264cc94e0mr5391346pfj.60.1665155055001; Fri, 07 Oct
 2022 08:04:15 -0700 (PDT)
MIME-Version: 1.0
From:   Carl Dasantas <dasantas2020@gmail.com>
Date:   Fri, 7 Oct 2022 11:04:04 -0400
Message-ID: <CANNVxH_uwnz31kak4fKAVuj8UP4wbWcFiDQ+kFwTametBvixGA@mail.gmail.com>
Subject: Re: Reg the next LTS kernel (6.1?)
To:     gregkh@linuxfoundation.org
Cc:     kaiwan.billimoria@gmail.com, linux-kernel@vger.kernel.org
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

Please reconsidrer using 6.1 as the next LTS.

6.0 or 5.19 is much more fitting due to not having Rust support, a
major  change. A lot of the community is hesitant on how Rust will
work and it would be nice to have a non-Rust capable LTS besides 5.15
since that is already one year old. Having a more recent non-Rust
capable LTS would make the transition more smooth as it provides a
couple years for those of us that are hesitant to see if it goes down
well or who knows, gets ejected altogether.

Thank you for your consideration,

Carl
