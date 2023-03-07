Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27FF96AE189
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 14:59:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230002AbjCGN7J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 08:59:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229652AbjCGN7G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 08:59:06 -0500
Received: from mail-oa1-x36.google.com (mail-oa1-x36.google.com [IPv6:2001:4860:4864:20::36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90C33769DF
        for <linux-kernel@vger.kernel.org>; Tue,  7 Mar 2023 05:59:03 -0800 (PST)
Received: by mail-oa1-x36.google.com with SMTP id 586e51a60fabf-176e43eb199so5011636fac.7
        for <linux-kernel@vger.kernel.org>; Tue, 07 Mar 2023 05:59:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678197543;
        h=to:subject:message-id:date:from:sender:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N3tQa/xAjjFjMbYTIPvabJVdNLC/DkLFMMTZCH3qWNU=;
        b=ZWm34bgz7tLJ05GImz5/QsQNPOCUlu9WqTuXoao68lY6Y6az9vbb8A3ejPmTOCoYO3
         HTaG0CtWUui4+GhPiqeDC4pBOZws3sISqd7zY5EcA7xmIvENH0Cy/eH0Vsk/JQVKwEx5
         BIc4cG059HpfVH4YP9HYY0ptzF1bGGYWmShNka0AUFIhliHz9JtggFJ0xPtw9MKa8pu2
         2uK16xhl05itTDdE1Rw/MHEAzL9L4tzLE18SUrmcq6cjr42j2IK/odYGqMMkJnCT+tV4
         FI8nK9VA1TUKGEBBQQ0ccc7CZaBeIq+8vmTU3oGGLr9haBdiann/3maaAm5pdfk+hPPk
         KNxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678197543;
        h=to:subject:message-id:date:from:sender:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=N3tQa/xAjjFjMbYTIPvabJVdNLC/DkLFMMTZCH3qWNU=;
        b=pjs2CCpMLXdbHk8sf4IQm1fL4Xf7VA3ovyC8QEVz2BO4XZZ4CvC7lk0xaC8uuU1JXv
         tiQyEeTYkhJmdUt4TS/40yqlgcEruzc/TJd6EiAnzii2B4yJJf3rTtuNAUEQAPf5uP7U
         kd7W/szlzNhB7cqf1EZ47rLgukwVK1s6EEz91d7e4HdWv1P+MrU1+nF8n1Np3JShoOXy
         uFE6DS/zhT68xw9Nzu860ckXnTXIAXQgHgvPw8C+igE9VvdheRoBYiShXfoTROQLhLx6
         XlmVLj3q7piCXuZ6YCgiy07Iv2g2s28u/65UpSQUsZ51BfoJ66BHsrS9NntOII9wFV1k
         2yIg==
X-Gm-Message-State: AO0yUKX7XDyu1LeFUcH+WVgHoujKJuCo81xdsLLtVK0zaFMuWkNqGTsF
        bXUf+D+nbrGMFM7XhCrX2TjbOB8p66mkhbtN/w8=
X-Google-Smtp-Source: AK7set/Z1q63uT6pqC1Po1AwUYnyytW0EVk0ShgL+QZctDmlCTab0b6ii7aLTf3rB0ldHCZwRc5deo6FDxjKVojnvEY=
X-Received: by 2002:a05:6871:6b9d:b0:175:4a1f:edff with SMTP id
 zh29-20020a0568716b9d00b001754a1fedffmr4905426oab.8.1678197542772; Tue, 07
 Mar 2023 05:59:02 -0800 (PST)
MIME-Version: 1.0
Sender: innocentwokocha4u@gmail.com
Received: by 2002:a05:6358:6f19:b0:105:65cc:5172 with HTTP; Tue, 7 Mar 2023
 05:59:02 -0800 (PST)
From:   Elena Tudorie <elenatudorie987@gmail.com>
Date:   Tue, 7 Mar 2023 19:29:02 +0530
X-Google-Sender-Auth: LiIyEZHBjvfxTF6D9ltBWLoVvYY
Message-ID: <CAEyv66=VbwLag8_1fD5=+uC3F_3DAB3+qs-6N3he+5WyBN+frQ@mail.gmail.com>
Subject: Greetings
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.6 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I am Ms Elena Tudorie, I have a important  business  to discuss with you,
Thanks for your time and  Attention.
Regards.
Mrs.Elena Tudorie
