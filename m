Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE9F15F1BC0
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Oct 2022 12:14:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229638AbiJAKOf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 Oct 2022 06:14:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbiJAKOc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Oct 2022 06:14:32 -0400
Received: from mail-ua1-x92d.google.com (mail-ua1-x92d.google.com [IPv6:2607:f8b0:4864:20::92d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAFBF67160
        for <linux-kernel@vger.kernel.org>; Sat,  1 Oct 2022 03:14:31 -0700 (PDT)
Received: by mail-ua1-x92d.google.com with SMTP id z6so379877uaq.2
        for <linux-kernel@vger.kernel.org>; Sat, 01 Oct 2022 03:14:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date;
        bh=FcyQcUXi9xALQQ6Lm7VNXiWYStBjH/LCUTADg6v4m+k=;
        b=U5HCNSuZOFPre9BWCP8CVNLu2mT9+0ZSQJa0le/54W5aU6uBlCbeSOtc2RQBBXrWTA
         qHJNX2egH3XLY6Z8XzBaAfIbcOO1NjWSk9JDCZsdWMbTXQEO3i6sJa3X/thMx2s4Y8Xw
         820DKKTVmtcrjS1fZqF52eKXsWkTjiNWSOR8ZH94xKCQ0A/M5jzTqucnr1l45HgRZaHd
         /nbTAghqWW2gCF0DvBvXgBjkOZ7+p1B2s2eb7qg4CUbOFwjuvTNPBdqfHajcOUTZKA0U
         S2U7lHk2mFnKc//UVohyetasLPmBxUVWhq2MON5ume6QQg1wyL/blqubc8Hw27LqHYsW
         s6qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date;
        bh=FcyQcUXi9xALQQ6Lm7VNXiWYStBjH/LCUTADg6v4m+k=;
        b=o5uglBnUTw6xA9unEPDledpnUbBfwL8Yu+PeUf90nRLDKzg6wbScI66+qXCKITlYJ+
         6DG5+aotTuplzHNj/fivCG4rZl+CsNvHhJaq6zIz943sQsWoNk4QT/sJclnQAzkct30T
         sAG33E3H0nvz7S/TACrieZvNwbCzssWaCM1Wqr1wlTzUV8N4xT3jobsFWg35Dgb6Mnp/
         kKJvV7kUloX7VyoIlLmiBSAiqlEhUaPiL1POHzz6B9Kf+SC7KbRTKUhFk6Ri4hj8hRXh
         s+7Bjhj7K3gFi0+oJcGOeOPzY/wpWw0HqcZfvrnV+RV4CLZHvIBoitAgbfTVqmzpECjW
         pY+A==
X-Gm-Message-State: ACrzQf0XY0LEmZ1O0KCf2FpwezDcRBU2rfwUgJ6AYueaSzY+J2odBwrv
        KLCn7ghRj5wz7vfnN9io3e/Ouxn1M2rWLdFYIkM=
X-Google-Smtp-Source: AMsMyM7MKFe/mVwcRMMRcYrjcc78xAwpxc4JHSa6QP131W54H4LfJ53mvtZstl24NC0Y8+XWgpy00bGiheGQFdao56M=
X-Received: by 2002:ab0:2256:0:b0:3cd:36b4:41c with SMTP id
 z22-20020ab02256000000b003cd36b4041cmr6186377uan.73.1664619271043; Sat, 01
 Oct 2022 03:14:31 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a59:a885:0:b0:302:a595:cd2f with HTTP; Sat, 1 Oct 2022
 03:14:30 -0700 (PDT)
Reply-To: linadavid0089@gmail.com
From:   Lina David <leguezim@gmail.com>
Date:   Sat, 1 Oct 2022 11:14:30 +0100
Message-ID: <CAP8wXGtPvDe=QCu-GTBevqEZqsc2gh2ztZFxm4UM9nqaQC4AHw@mail.gmail.com>
Subject: 
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=4.9 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLYTO,
        FREEMAIL_REPLYTO_END_DIGIT,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        UNDISC_FREEM autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

-- 
Hello,
how are you?
