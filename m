Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3EC07135C1
	for <lists+linux-kernel@lfdr.de>; Sat, 27 May 2023 18:44:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229914AbjE0Qoa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 May 2023 12:44:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229494AbjE0Qo0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 May 2023 12:44:26 -0400
Received: from mail-vk1-xa32.google.com (mail-vk1-xa32.google.com [IPv6:2607:f8b0:4864:20::a32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5E86CE
        for <linux-kernel@vger.kernel.org>; Sat, 27 May 2023 09:44:25 -0700 (PDT)
Received: by mail-vk1-xa32.google.com with SMTP id 71dfb90a1353d-457026417ffso521520e0c.3
        for <linux-kernel@vger.kernel.org>; Sat, 27 May 2023 09:44:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685205865; x=1687797865;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N3RvBGd1CGeoc5WWIc9RrGLqcXMM+f/OcXZH8+5h6SE=;
        b=TkoF1nznezoaDLb70EDhUluUjmYlrl3Fcn8CE6+TinQGQmKfV6nvceuOxC2j9I9Vvy
         aLNELO5RXvUJ2uodCHkJYdI1cMh06vonRCvP5BMD1BrJdGtlTt4mXLSwEDZ5QvJ/XuAT
         Mp97We1XUkvPiUdwXhvSg8xGiad4PtArmMG1Rj1emAYdhYv3+/Mh9AcAbXF0P1JggLM8
         +O2yj7sjfWCsu7pAc7rxuYxrNXFvqPRbnGjht2UFdYl98MxeOiL92u4XspBiayq0Lkxg
         +TEaahkhhiE0hZOejQz+uIaFPq2OxaSqwnr5kjex9u8z6+XL5b5MFIQCSgh3HCrMr9nS
         joTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685205865; x=1687797865;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=N3RvBGd1CGeoc5WWIc9RrGLqcXMM+f/OcXZH8+5h6SE=;
        b=kWDSiUMvKvlbKxMj4xBfWOwILfjTC8RBflucDppzs6/c2Au0e2JyCyetFmPSgjugAY
         WoEonSef1EG89slGSJw2YdEbFpB6ItBpXtoicl3swA14rLjjR9XQOkqn+gWWuvIbbE2L
         yiwDtfupNtpsc2etXXSFLjHnRYeyTP/icQfSOepFCS8H0NkNFy9Lo7AAicE1RDQBG+tP
         pJkTzfHfvijG8yGj8eK2lq55d/iDOkzn22I1xwzwyG0A/hCwjdBVpwj6QUlXbS09K7eH
         +PsqNFyEcyjdCbo518VzRhgstdEe7yuwyk/xFgU9rmIYA2nNTnGJTtzzR8JxI6zb6QIn
         kxZQ==
X-Gm-Message-State: AC+VfDz1keSjJLd8+bIVCCt+9JOsSGApUMj+NvIFzp7dqAfxVPr2drT3
        iWz1qX5W6UTLy2RY2N3ZLJoUWFwmR0YgmzdXRTk=
X-Google-Smtp-Source: ACHHUZ6JpHRtkFCUQ7gA+x4vuOhgUSZq3PwAo6GOmqwt8NAEDvL91Tx+MDR/EG14cMD8op6qFc+zGrmXtswolzWpk0o=
X-Received: by 2002:a1f:5886:0:b0:456:d3e1:92d4 with SMTP id
 m128-20020a1f5886000000b00456d3e192d4mr885115vkb.12.1685205864390; Sat, 27
 May 2023 09:44:24 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a59:af44:0:b0:3d1:260b:ad8d with HTTP; Sat, 27 May 2023
 09:44:23 -0700 (PDT)
Reply-To: wormer.amos@aol.com
From:   Wormer Amos <concepttradinglimited@gmail.com>
Date:   Sat, 27 May 2023 17:44:23 +0100
Message-ID: <CADfPB6dWFPqOoM9Hu9+6bMhXTfszsKuau6_kyoHkdMCFzA4-0w@mail.gmail.com>
Subject: ATTENTIONS PLEASE....
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=4.9 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLYTO,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,SUBJ_ALL_CAPS,
        T_SCC_BODY_TEXT_LINE,UNDISC_FREEM autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sir/Ma'am, please i want to know if you're capable of handling investment
project in
your country because i
need a serious partnership with good background, kindly reply
me to discuss details urgently. i will appreciate you to contact me
on this same email?

Thanks and awaiting for your quick response,

Wormer??
