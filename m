Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE30F710DB7
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 15:57:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241224AbjEYN5a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 09:57:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241195AbjEYN52 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 09:57:28 -0400
Received: from mail-vk1-xa31.google.com (mail-vk1-xa31.google.com [IPv6:2607:f8b0:4864:20::a31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 028B4199
        for <linux-kernel@vger.kernel.org>; Thu, 25 May 2023 06:57:14 -0700 (PDT)
Received: by mail-vk1-xa31.google.com with SMTP id 71dfb90a1353d-456f7ea8694so194564e0c.0
        for <linux-kernel@vger.kernel.org>; Thu, 25 May 2023 06:57:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685023033; x=1687615033;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SjXLBP5xNer1wTnBOJomhSlEzBF7juDtm2PHV6Lv/6M=;
        b=SCYpJCxD3xQFw84DxLYIw4xYuFIXbznBg4TaKsdVZDBcAgriBwuolhGfxV9FkLp2g0
         XoQ61QezNJLfaTqcyTcVbhqXIm8FaYt26urbDInX4AHZF9MHSq2PAUlzUrmaB0iTdR+3
         ECGzCtoZQrOGX8OS98ZEzr38Tm7GmvPvgD/g+I+fZLxjHIcDtCi9T46LLp/KCQTW1FkN
         zIdtekswGYRFN0Hd79AAkBP819NHJJeLU/8/XpHqPCvPEVH+dC7RGOa0Mvaw93cg8SJh
         89i22WmnmesgFwMcsEc6G3QjmOTZyVGM5+R5mNNmuxVL6MhbUwXEECD19AyTNnhIcB5c
         0m/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685023033; x=1687615033;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SjXLBP5xNer1wTnBOJomhSlEzBF7juDtm2PHV6Lv/6M=;
        b=L5eB1ccbnNpiz4YrQ0aJ6hd9mJk4sMe13gDhACWA0ZunTtT6wA0mdShkjCwS0n7zQ6
         KQ5Fja0yzsQV/FlddyAdydAJ9wn/5UOEkrtJ02JEaeQx5cXu1aJY3lFB+hN1tiIWHDdR
         f/Huv27RwQjKjsYEXs4/NX2GE9biqW/9DurwRRBF+4c1h0E1o4ZIMw5OWh+44tCXSW4i
         d1xmBpEYoj5hqMwoUCw935QRHpQ+9n/rcuftjyTJlcGlOcGmJNdlzBc9ZjAHFeSR5qFh
         k6xoTSdAv79q/q32dpU09Bs7muRzVmw+8ffu6sGWrfjYiV0aAxy3jWT2sHekL9KMt7l3
         wSaQ==
X-Gm-Message-State: AC+VfDznAxgf3koyIy5Lb+WBUNHbJzqVdnH1iNFl+kWafMV/j9veWM5+
        jxicHgn22Ehvs4ekN/of9B+tkanCJLuoERNBWO4=
X-Google-Smtp-Source: ACHHUZ6/8dzD8nIiqszVtA0BuNuIlptN/pBJrknucK9LJ2heZzxO7Il3YJ/5h5tJvlIeDgJq531WMjAjgfKlR+cyjG0=
X-Received: by 2002:a1f:5c4d:0:b0:456:d210:68e2 with SMTP id
 q74-20020a1f5c4d000000b00456d21068e2mr6588416vkb.10.1685023033065; Thu, 25
 May 2023 06:57:13 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6124:5199:b0:36b:efd0:c1b4 with HTTP; Thu, 25 May 2023
 06:57:12 -0700 (PDT)
Reply-To: choipark90@yahoo.com
From:   Choi Park <ubacustormerscar@gmail.com>
Date:   Thu, 25 May 2023 14:57:12 +0100
Message-ID: <CAGMLrsUUA8Xv+u9EBF6a6jJiLABe3FeLDmDRXkKqzEFu=FrmYw@mail.gmail.com>
Subject: investment partners
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

-- 
Hello my friend how are you doing with your daily activities I hope
you are doing well, sorry that I have to contact you via this platform
again as I have tried to post this information via regular post but I
did not get a reply from you.
Please this massage is not meant to steal your information or harm you
but just to  do what my client mandated me to do  . i got your contact
when searching for a reliable and reputable person that can be trusted
as my that client  Mrs Ma-Ri  Kim from  Hong Kong  who  Directed  me
to get her someone that she will trust to invest part of her money
outside Hong Kong   for her under aged child  if you are interested
and can handle this funds let me know I hoping to hear from you for
more details  .
as said this  massage  does not any way  to steal your information or
anything evil
Mr Choi Park
