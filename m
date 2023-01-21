Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A410767664B
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Jan 2023 14:00:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229597AbjAUM7f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 Jan 2023 07:59:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbjAUM7e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Jan 2023 07:59:34 -0500
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56300196A7
        for <linux-kernel@vger.kernel.org>; Sat, 21 Jan 2023 04:59:33 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id c4-20020a1c3504000000b003d9e2f72093so7576723wma.1
        for <linux-kernel@vger.kernel.org>; Sat, 21 Jan 2023 04:59:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ps43Ql5Tjnd+rS8BdUE8H1PpwwGazEWm6mc1DzBYYUo=;
        b=YRbeGPF0vzAL9vP1ayq6j23GPI+Xu6Pjso5rZAqVgnNw0bnHPTBZOE18O/MN4KGs4l
         hnD/+fHbs58kjw8Rc0oUb/2SWkRcMM4Rrykeo92jjtsXTteSOUCshzZHj+N9lQwiPCm+
         wuC+YNm38OwL9Dq5krViJMUnShdSFXfVotDbWUC49jml+OmIY9KSxTSfL409bgjSx4FH
         QGSlQB7QaG9hfY5M04zWqPg/gYyGk3Sldzx2s8XRrgJMPdeR/LelvZxihrayGRjETvfu
         2oh0GxBJqzlVxaZUHv/nNJ9LusDBBYqql5tsbKpPpXEf3EScICBV+fcoQ5uy/lSD14F4
         k/SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ps43Ql5Tjnd+rS8BdUE8H1PpwwGazEWm6mc1DzBYYUo=;
        b=EcZjDyJlGl3wLGhrapmptr4DRd9PD+RxVujD47W2SBWieFNHpgGHFQZ6su+g3zS8kz
         T9++Rx6zf36ozP9/rWQNvbnuj4xNRWqw5svlQmBZOhFM0dfV0nTuENGZMFJ8gKHmosSa
         UgYsk5SBQO3q7Q8nU1Fl3iYVmHWbtqaiDsu6QQ5El77noqx0/KPKZKrPCtjdKMMq7tal
         U+f1iJK8yMFN5D5PhoTOd1RG9k0nQYES42RDWTJKpR/Ldw2kfrQZnxFJuPTJAnT4Q6EI
         l0SsKKYcR2+pIcdJxXtgzFj4q4BWOYThfbrhP9/7ELDPX7kYYqHFvh2H/CeASa1BVrbQ
         UoEQ==
X-Gm-Message-State: AFqh2kodPd0y2iXSS7i30Gdl9+/k9gy9eQmUEgro7jATIv2zJWGBuk4D
        6Yr6uksHnHoGHq8RqlQEI1hs0y+IzeEWlL/Xzs4=
X-Google-Smtp-Source: AMrXdXsvhV7YOtWBaqBzKvTlyZbR9+174ah2we4wkBdQQ7+67e9gX8kuShnOy0mnLkPORvi2ftUJ7nHK6xi0yLArczs=
X-Received: by 2002:a05:600c:1c12:b0:3db:99c:bc9e with SMTP id
 j18-20020a05600c1c1200b003db099cbc9emr985917wms.69.1674305971844; Sat, 21 Jan
 2023 04:59:31 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:adf:d212:0:0:0:0:0 with HTTP; Sat, 21 Jan 2023 04:59:31
 -0800 (PST)
Reply-To: fionahill.usa@outlook.com
From:   Fiona Hill <xaviergbesse.2020@gmail.com>
Date:   Sat, 21 Jan 2023 04:59:31 -0800
Message-ID: <CABEvWULvp02KDKW9PBNZgQMe15irPsNttX+=Z3A8V2ZfyiWU-Q@mail.gmail.com>
Subject: 
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=4.5 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,UNDISC_FREEM autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

-- 
Hello did you receive my message?
