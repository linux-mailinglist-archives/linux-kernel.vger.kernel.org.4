Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8953A73FE20
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 16:38:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231740AbjF0OiD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 10:38:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229488AbjF0Oh1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 10:37:27 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84D5F3AA6;
        Tue, 27 Jun 2023 07:37:12 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id 5b1f17b1804b1-3fb10fd9ae9so20026885e9.2;
        Tue, 27 Jun 2023 07:37:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687876631; x=1690468631;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=9MhYFB3Vnyn9pGR4cU1f+rWvzWLxp7ZwlU3PpNKPX7A=;
        b=mxf2FptiSsBdSQaiB2DlyXaQq0HHjtnYezWq2o/OGj+B0wLLbMsdEXxnGZw9g8sIEl
         TwgjnBtCuzsf9cHpg31bFI2KOIc7dSHhaBOCSSv7t5XsTo/+QUm0JnrNPyN62JOea4wj
         6GOg/YxUubaY6EwgkrbSO1Db4Uydhrk2sJO43G2/eNUiHrhyYboImKs/zNOQzZ5Yvr1o
         7Ia1LHgNccvI1pGD7k9IauQXg8K7YOqb2g3AKRi5fHh0WjlWrS5PvwISOJHkeoVm2YCO
         vBwzSOd8yZgWYJFYoFPEvYZUu42q1loQawklsneXTtAJbjPpei+WhA9R/VUV7dymDe4P
         zVrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687876631; x=1690468631;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9MhYFB3Vnyn9pGR4cU1f+rWvzWLxp7ZwlU3PpNKPX7A=;
        b=Ddn6oEjTZc2a4DuqhuDrwPNZynCMKEF24T5UjzN4W0QHzhg9S6JycnRowN70NCYco9
         rHcdpFiygjPBxuk9hhI/nd8Xf2o1PKuANGI+fluC9Lfk8YI32UgyREQR2PpbRDLWbspz
         oEUo3ZimTuqfZkO5m75hvRhFbhgzRuKlhbnsvGb1WYJHbzdoeQyP0kpeIyglGg/uf8nP
         gLwRg+LShmZs12QlC4ZaDZE+ulZO4C3Uo9emi2ZrF/NYq5uo1W3mR5B2PzlyGXjaABq0
         Wwf7mYZzVHezsZyPx+52jnbIZopsH0/nFhKwtjcC77i4lHckYYzVgYyi09BysJKig/od
         iLIg==
X-Gm-Message-State: AC+VfDwMS9LCICLKb27rjNLQW5c2OCzRXdsBJE9icd25wsPUXJvkecgR
        3c5iAHicmsPmdN0GtN5SU7luLSJQyBqgCJfpLiE=
X-Google-Smtp-Source: ACHHUZ4IpJw+jWEEf0rqZEhsnrHthI5Yk24fPER/Nhoy3Lx53fEEhwSx/7kBB0Fgt74gANa9byWYdRkXN7KHdFAkibc=
X-Received: by 2002:a05:600c:284a:b0:3fb:ac73:f7d4 with SMTP id
 r10-20020a05600c284a00b003fbac73f7d4mr43025wmb.14.1687876630480; Tue, 27 Jun
 2023 07:37:10 -0700 (PDT)
MIME-Version: 1.0
References: <20230627105209.15163-1-dg573847474@gmail.com> <CANn89iJRaT1B=HwWDsEdcAUZzYERzeR8iwGYHZuLcy+G4G39Lw@mail.gmail.com>
In-Reply-To: <CANn89iJRaT1B=HwWDsEdcAUZzYERzeR8iwGYHZuLcy+G4G39Lw@mail.gmail.com>
From:   Chengfeng Ye <dg573847474@gmail.com>
Date:   Tue, 27 Jun 2023 22:36:59 +0800
Message-ID: <CAAo+4rUwQ0Nrb4M+nhpmyEXVssxVLPs0N9pqohTfAeeZ9tbffQ@mail.gmail.com>
Subject: Re: [PATCH] net/802/garp: fix potential deadlock on &app->lock
To:     Eric Dumazet <edumazet@google.com>
Cc:     davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
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

I should have noticed that _rcv suffix mostly denotes RX handlers,
thanks much for pointing that out!

Best regards,
Chengfeng
