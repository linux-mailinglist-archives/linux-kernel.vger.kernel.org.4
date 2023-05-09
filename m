Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E5506FCD84
	for <lists+linux-kernel@lfdr.de>; Tue,  9 May 2023 20:14:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234398AbjEISOQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 May 2023 14:14:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229527AbjEISOL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 May 2023 14:14:11 -0400
Received: from mail-vk1-xa29.google.com (mail-vk1-xa29.google.com [IPv6:2607:f8b0:4864:20::a29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 443184C2C
        for <linux-kernel@vger.kernel.org>; Tue,  9 May 2023 11:14:01 -0700 (PDT)
Received: by mail-vk1-xa29.google.com with SMTP id 71dfb90a1353d-44fa9d3cdf3so2233172e0c.3
        for <linux-kernel@vger.kernel.org>; Tue, 09 May 2023 11:14:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683656040; x=1686248040;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DNFhsPbkfGfOWNF5M4aRb8nwKD8L5aVj2WV/H46NM8s=;
        b=TemI3zFgCUYISQvulCYhxwT98DJyqa+vNetMaPd0acPkh9NUEkit/vwykZAqV07VM/
         AzrPz8f/BQZr/D/D/Lq4n4y1vdGRhmZsl2cWYv5prQsI8e4lx1tXKgrFggFBNeW7vjB0
         0oL2xm/zNp3XTcNRGRmTeYsMJj8VEDlbE4aC0GwfQkteKI43KJMLK2vnzEVp0cNOyGFP
         lwmbr08LKWA7ERZYIZCuLEbW4D47rvHgaZr71JYM8WMLaecuj6VA0ydcd1qcEVl2RP6a
         oot3JlFGqF1TgmEAX1gT3cvy/9zioyAaN89Y3qzVyW2bKC0gFFYiPTi3TGd4XFZNTGaG
         X94Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683656040; x=1686248040;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DNFhsPbkfGfOWNF5M4aRb8nwKD8L5aVj2WV/H46NM8s=;
        b=lpduSPmHj2OABqWbFHmhD8br8HPrQ2sioeE8iRJiNCHt9ScAbtTEWIOfvEhqE+FKUt
         jnILkRVcQjg0JtsBtU0mCxexL7DO3d9VB5oGlk8G5JQLTm5yq/5e2ngHOkZu8Y+pC7EC
         4ZhC+DdQBsNYBgcYQFbriHiguRiY8+nV0QL4u28ogj0Bv8Zu4H1Hs2D0/ngJ2/ulWsvh
         h1NN13zqcBrfYKJ1n6I2uOLxxR0i0I27sEJFOQZStJfyMud6bLh3nFbCySs9iEosfB98
         U6+61Q1L4eih7q/VuFdkBUyfPec9CXDeGQvoBM0893JoR7CWiTi2JfgXu4fwQQ8T2UhD
         yKmA==
X-Gm-Message-State: AC+VfDzf6Nz+8ouRJSGM2SQ4MJ57jfLGpspYy8GSNHdI2FzBrMKCZd6v
        7VMgryDnofxkG/iVqlpHPiFDyKxOsn3oBi9XOfQ=
X-Google-Smtp-Source: ACHHUZ6Vcpu3IkmtxlgEFVt0T252fl2a23IOeOpVnuEqe+VBFPa9MS31IEV6MjwnyXAz8bWrdH1/vEeOHoT+V+9uUZw=
X-Received: by 2002:a1f:ca03:0:b0:440:8a24:e71d with SMTP id
 a3-20020a1fca03000000b004408a24e71dmr3878814vkg.3.1683656040036; Tue, 09 May
 2023 11:14:00 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a59:c18f:0:b0:3b7:747f:aada with HTTP; Tue, 9 May 2023
 11:13:59 -0700 (PDT)
Reply-To: dorismartins9000@gmail.com
From:   Doris Martins <fofficefille@gmail.com>
Date:   Tue, 9 May 2023 10:13:59 -0800
Message-ID: <CA+CSU5hHQiR1VNvzHs3CCTRnT9fEExgrneZtkgPYywADTSQ-WA@mail.gmail.com>
Subject: Greetings,
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=4.6 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLYTO,
        FREEMAIL_REPLYTO_END_DIGIT,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNDISC_FREEM autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Greetings,

I wonder why you continue neglecting my emails. Please, acknowledge
the receipt of this message in reference to the subject above as I
intend to send to you the details of the mail. Sometimes, try to check
your spam box because most of these correspondences fall out sometimes
in SPAM folder.

Best regards,
