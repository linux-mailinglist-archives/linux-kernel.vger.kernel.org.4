Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1DCC648012
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Dec 2022 10:23:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229978AbiLIJXk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Dec 2022 04:23:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229810AbiLIJXi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Dec 2022 04:23:38 -0500
Received: from mail-yw1-x112f.google.com (mail-yw1-x112f.google.com [IPv6:2607:f8b0:4864:20::112f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 466993C6C7
        for <linux-kernel@vger.kernel.org>; Fri,  9 Dec 2022 01:23:37 -0800 (PST)
Received: by mail-yw1-x112f.google.com with SMTP id 00721157ae682-3b5d9050e48so44933467b3.2
        for <linux-kernel@vger.kernel.org>; Fri, 09 Dec 2022 01:23:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=w90NWJhw4FQfn+8z7KfpbjxiRrip6Hjp/8w4XPYddxs=;
        b=iqh92EkCQeenTIY7b3yJxBYXAFRNpBrF7i6bNR31xHnoMbk/jWuDRv9Y2YkkZgqj0t
         x6XlECzWaSMmBk4psVHoHIthPuDyMuFMOPC/F0NRPpUfnDfxzKmb73Bq3cy5MwlDVJ0P
         ryh/3jM56b8gyfb1cWoW/cShrWFfrSeNjtpUqrZQn3NzzpNZONpIGcuIgifKIiUtPK3M
         4KcjJ0hWx/ijRV2Wwg6e6LUI+SD9TeMeUVFRXfEYXqYQtYiNIeRkt4/TCyNM/6HVHLIo
         ioGYPTrktRsQl+WEmB7jAo9UrmsnJXHcZceHso7tAbUdqdRV+1Fj5h4qOwyO3cljJ1m2
         rs8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=w90NWJhw4FQfn+8z7KfpbjxiRrip6Hjp/8w4XPYddxs=;
        b=rqhWTDqAtyH5ckGCdscS6SA3OMT2WSaBZVvy08d4OPcSgxPhjjoeIVUOLLtgpKHInV
         v/wV3Tjrjdm6LyqUwdSeABQ7JFB2xWt8ky46C1tgAEnsRxExDKid9XkHimDgaLt1H9uV
         M7wsRmQnap1UfGCjtm88QncsqJyibZ6bACMzALQkh2NMwcwn4hnOL6xyIQkSw/mXk1gl
         fUMWIsBs7Z6OrkNTjgML4Dh2OSZARWQ/gojqF4oRGeA4eQxbtyUg/EfUHUmMek+VfhTJ
         KNWXJhgwvvdIwzDLY50YVgZGJy1GUXN0eDP3jpg1aYG1hCxRhwMMeH/HYj3QUgUhcCNL
         F9pw==
X-Gm-Message-State: ANoB5plfgN/NjNI1FpT67mcaiNdeVXqs2lFiuWQV4Z6W3aWkL5DzMKcj
        r/IFpH98MEhQCjVqXa66qpSiKnUnscqK4cX42bk=
X-Google-Smtp-Source: AA0mqf6nhFuCsu2bMXIrstTcyTXI2XxP1q4+InUZJUv5tIef8SOyrVsP+9mLR7XX/D88SdOA/HPUiRmJtGlvJFrL0io=
X-Received: by 2002:a0d:eb56:0:b0:35f:dedf:fe5 with SMTP id
 u83-20020a0deb56000000b0035fdedf0fe5mr25692400ywe.408.1670577816418; Fri, 09
 Dec 2022 01:23:36 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a05:7010:a3a4:b0:319:90e1:bd03 with HTTP; Fri, 9 Dec 2022
 01:23:35 -0800 (PST)
From:   Bethany Logan <bethanylogan44@gmail.com>
Date:   Fri, 9 Dec 2022 03:23:35 -0600
Message-ID: <CAHobhXNRp9zqWPxYpKmWkrj65TDBB2VA+HC2jxVYoVOhjEyU4g@mail.gmail.com>
Subject: hi
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.1 required=5.0 tests=BAYES_40,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dear, I have a good proposal
for you.
