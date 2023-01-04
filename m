Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D189965D082
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Jan 2023 11:20:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234097AbjADKUH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 05:20:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234001AbjADKUA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 05:20:00 -0500
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3ACAC165AC
        for <linux-kernel@vger.kernel.org>; Wed,  4 Jan 2023 02:19:59 -0800 (PST)
Received: by mail-lf1-x135.google.com with SMTP id bp15so49731407lfb.13
        for <linux-kernel@vger.kernel.org>; Wed, 04 Jan 2023 02:19:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=n5AIi3oo/j4t83M1h552PsjCFgTBtqwf7lvGweoNpRU=;
        b=CdMgsi5zZzoS8b82NZatQ+GbIyoA8ZmA+j07ZNSzNtq2TF4ygCSBrtXIyY3oKlQ7TI
         HXp8r5hLqkiXiq9BPwkwjGr65ol4y7ewGfUJTk4fEtUTxMtS8XHE3rRiZr+SZy7CGGoF
         ihVHKPd1y+/MhZUvC9AtpHw1fcOVWWUhhJEG7QLXQa9vgGu9aUnBl7nQbq3cgrW4IN7l
         M1dcggWSBSgidpueVLCA+rp5QhyBPrwAYhnMnH7WbU0MdQbATo++PZOK4EJsvwozV1Jd
         Ys9PulGPOhso6rql4XiyhDpi+s+r5YKFeN6KahCPCxI8nkOZUnxuZyqs/zMP7EIXybP8
         aXOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=n5AIi3oo/j4t83M1h552PsjCFgTBtqwf7lvGweoNpRU=;
        b=za1cAyEh/fxl/th3durxiol5k5/5Y3S/FZm0E9AsHibsGzC7dD9NEw/hhew9qWaNeC
         wD7/8QD8NtRr94FZ+IdkQqjr2tHlCkedi17rIVMZvoFANvlqfDAy5NmRsWBtnaOASK6h
         /0qnPJuq6O8vsS/11ppK04kGArD5TmTPigw8YY2Oud/rZaPNTpguhOyPe4Ea53lBFfmv
         M3fdEF9KGlUFXRqRVJ9tZpBVc3g2HIOYlEBxF4bIuN3sCw5lmqg4Nts+MSBV6VD4HlB7
         NHBODAmJPPofU05+6OeTrGumG7dMmZZv4eWlPV6+nb2h7fueAW/v4Gd66xUc/NE2v6fW
         9evw==
X-Gm-Message-State: AFqh2krKd1BQDC9Ui4Vk9X+2Igxw+EypXGBqHg+KVdpGZCfbGR/FFGt2
        +xdG5GviR2ji/oZPbKhMXeioutdo0Xyie4yJGw==
X-Google-Smtp-Source: AMrXdXv2elRYY7IGp09uyWG3HCQvkXIxJpwUdFNwotjZ4EVJaU7PWLeERYy5RgabGqouLcaBpmtNajXqiI7873OJUds=
X-Received: by 2002:a05:6512:2288:b0:4b5:28c9:be2a with SMTP id
 f8-20020a056512228800b004b528c9be2amr1930704lfu.15.1672827597535; Wed, 04 Jan
 2023 02:19:57 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a05:6504:210f:b0:211:f56c:a180 with HTTP; Wed, 4 Jan 2023
 02:19:56 -0800 (PST)
Reply-To: wijh555@gmail.com
From:   "Dr. Kim Park" <kimpark828282@gmail.com>
Date:   Wed, 4 Jan 2023 02:19:56 -0800
Message-ID: <CA+-2j8SQTODZ-2nz1m1SdCtM2Na8MzaZqASg70hiRGWAX+GJLQ@mail.gmail.com>
Subject: Season Greetings,
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=4.8 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,UNDISC_FREEM autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

-- 
Hello,
I tried e-mailing you more than twice but my email bounced back
failure, Note this, soonest you receive this email revert to me before
I deliver the message it's importunate, pressing, crucial. Await your
response.

Best regards
Dr. Kim Park
