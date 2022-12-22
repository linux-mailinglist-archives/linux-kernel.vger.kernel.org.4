Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61ED56542CD
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Dec 2022 15:23:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235591AbiLVOW7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Dec 2022 09:22:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235558AbiLVOWq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Dec 2022 09:22:46 -0500
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com [IPv6:2607:f8b0:4864:20::f2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44A39286D4
        for <linux-kernel@vger.kernel.org>; Thu, 22 Dec 2022 06:22:46 -0800 (PST)
Received: by mail-qv1-xf2b.google.com with SMTP id q10so1316879qvt.10
        for <linux-kernel@vger.kernel.org>; Thu, 22 Dec 2022 06:22:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/rL+TycpMQLfB5P4Zn9xgGfUWg8yPCNTwrE46ZNldMM=;
        b=qmmRfxVYHda+lhjmxbsI0ReXxUa6mFsqw1Eu4coE60BWiufuMmr+PfFx90msjh9VlR
         jKt7qkT1D20NRJmjfoI8aH/3z+t8itCILC9Ycsb0PZ06VYNPowjo7XeQ/erFy9cNlLnC
         Nx0XdIHwf19W9NCz/XrNd6sO5RorEKMkTFF6UYX9d80isvO8HJGKSYoxANBI8C44vaj9
         eNcDTUzQW6ihdxjAfMLoSa+nviE1J0LU4fcRQJEPPLg9Ex/NBnFfnncbE2+G1dyjg8LW
         B7zo94bxtInqSF4yN8crjgi1TFJyM/oOs4oEy/YtFwf6hZk4eQLzHrqabLvgd33lT0Hm
         rHfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/rL+TycpMQLfB5P4Zn9xgGfUWg8yPCNTwrE46ZNldMM=;
        b=u31HhJlsSDGcrNVMMhdhtBp27DKX9qaFr+VUM4XSzpofwdleW4dirbEKBfJ0Sfon67
         9wiiU8Mv9SPekLkgBBhqrpTRAMNnZtkhROWnTmAyYCjBX/J/yU4R291Lrs76u1gr/Kpm
         0HAlTH2f2u4NS9ewUBR/WASMWaibzxnwUCywBYotSNb7IIlkVM3+4+yoHHf7dQZYAsH4
         T2OjmUGleQaTj2Dhxxu6HBpfkKI4gjSUssgp+MfxdqC5h6gdt2usNOwG9pLAdELPZfGB
         7C/CJCiWHyB9BxNyvhzNyAIRbytxB/8vzc8uh686WG350/zXBdBVNyozyomSlxkJJxlF
         DcQA==
X-Gm-Message-State: AFqh2ko6sfePr/v8kh/TTh15IjL84aMzKSvvnTECi2++SeV4qkPg3ecW
        g7daO/ZX90H6ZYFSoVfeB44nI++ORHuOcem1zlg=
X-Google-Smtp-Source: AMrXdXtO9qATNm4hxXCupHu6282q7HTN39BMf1C1ZnF/UNuOyLNcF45TbLU7DNG9e2CFqD23v/Nj91xpnvQWchRx72A=
X-Received: by 2002:a0c:f94e:0:b0:4ce:4893:711a with SMTP id
 i14-20020a0cf94e000000b004ce4893711amr350387qvo.76.1671718964160; Thu, 22 Dec
 2022 06:22:44 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a0c:e945:0:b0:4c7:8099:bc1 with HTTP; Thu, 22 Dec 2022
 06:22:43 -0800 (PST)
Reply-To: ava014708@gmail.com
From:   Dr Ava Smith <avaf0628@gmail.com>
Date:   Thu, 22 Dec 2022 06:22:43 -0800
Message-ID: <CAAt3dDvX4SD8+7W7BFkChA8tSxHiGzDcpOnJNyar0VTS3gecnw@mail.gmail.com>
Subject: Hi
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=4.9 required=5.0 tests=BAYES_50,DKIM_SIGNED,
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
Hello Dear,
how are you today?hope you are fine
My name is Dr Ava Smith ,Am an English and French nationalities.
I will give you pictures and more details about me as soon as i hear from you
Thanks
Ava
