Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3931B5B6BAC
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Sep 2022 12:33:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231428AbiIMKdV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Sep 2022 06:33:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230494AbiIMKdS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Sep 2022 06:33:18 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FDA85D0CB
        for <linux-kernel@vger.kernel.org>; Tue, 13 Sep 2022 03:33:17 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id a41so5040040edf.4
        for <linux-kernel@vger.kernel.org>; Tue, 13 Sep 2022 03:33:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:sender:mime-version:from:to:cc
         :subject:date;
        bh=+IOkPYBVudVE123a/Rn57DKbqImHDs6xTaqKWEnTeaU=;
        b=Sey68H9AaYkmlDEsTrSHR0ricClTUgDJuFwE7wv6y37CNohLB1oSZVOAhHJhXgciLd
         Pdv4Fe+tAlVuwGQAbW2t1leQ6Q0XHvxMbDR53fAHeq29jC1ObEMV4duIdRfr1M4bvxiz
         GeZaRTB8WRrIodK7RQOm8UBHRCJszuUf32qBXYrDUA/dKZpPlYC6/waUK1MBdd9fYAIj
         3DbYAUUrd5HR42XDTn5OCfOfnfInijHgdelahQvjlIW3oTpEhlGIfM9V3by0ESzdsLNK
         bkof22AHwi+B1A1auPIfX8JFTkuroHl1xhF9yha/qMLa7d4XR8FePSA5vXraZOIU8KZc
         sBPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:sender:mime-version
         :x-gm-message-state:from:to:cc:subject:date;
        bh=+IOkPYBVudVE123a/Rn57DKbqImHDs6xTaqKWEnTeaU=;
        b=IJ3LN19Dtrt2U5OEFrsnY1CNzmk6eqGLmGxNjadZANB8SrXhv6IXhQmCFT6AnZpQ1M
         20jzd7n4m4VE8uvLIi3SOQypToaMxQ2rYu+x51zVIoq5006e+YuY9bB7QJXe8ixdavPs
         7aY01+9AZQOr9GgcROiUhJFCZsQ41Z5lCDUmQEJEg5i3rQNuuISUoiEE7j09dMd7+MnB
         hC8aTOTokIpGkZbFWxauJlJ1/2QhwGrxzmAj40tp9e7LQFg2/mhFBrZorjFmHnK1gFm5
         cU9I1MDCvVtzYZ3Jb/dIgY5HXCicwM63YT0qX4EW5s88lH9lL0fBXX1CLKuw3Y0TSROX
         ZvPw==
X-Gm-Message-State: ACgBeo08wiml4BAP/lmkgdZ3DOxpawtDmnV5SogTnD8EiVlCoV8hJRb7
        Km6Ya6p/DT7hacmvDKhnaxDV/3KwjBfMtgXw+IM=
X-Google-Smtp-Source: AA6agR6hB3xruOUIyKlv91G9UmtJkjcan5icUjuFCtulfpXXnxiuMoD6qwTF9paWCRdmXe0Rv8Z421pd+uL9FNa88ts=
X-Received: by 2002:aa7:d3d3:0:b0:44e:baab:54d9 with SMTP id
 o19-20020aa7d3d3000000b0044ebaab54d9mr25380532edr.43.1663065195965; Tue, 13
 Sep 2022 03:33:15 -0700 (PDT)
MIME-Version: 1.0
Sender: oyebuchikalu29@gmail.com
Received: by 2002:a17:907:961c:0:0:0:0 with HTTP; Tue, 13 Sep 2022 03:33:15
 -0700 (PDT)
From:   Hannah Wilson <hannahwilson11254@gmail.com>
Date:   Tue, 13 Sep 2022 10:33:15 +0000
X-Google-Sender-Auth: DtZStylnndtMDPL4vvzpLF3plck
Message-ID: <CAOkQLHUMuyZY-7DAF_jK75xWd2q=hOuYiY+yX7J7oL+5bw=jpw@mail.gmail.com>
Subject: Hello My Dear,
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.9 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,LOTS_OF_MONEY,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_MONEY_PERCENT,T_SCC_BODY_TEXT_LINE,UNDISC_MONEY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello My Dear,

It is my pleasure to communicate with you, I know that this message
will be a surprise to you my name is Mrs.Hannah Wilson David, I am
diagnosed with ovarian cancer which my doctor have confirmed that I
have only some weeks to live so I have decided you handover the sum
of($12,000.000 ) through I decided handover the money in my account to
you for help of the orphanage homes and the needy once

Please   kindly reply me here as soon as possible to enable me give
you more information but before handing over my bank to you please
assure me that you will only take 40%  of the money and share the rest
to the poor orphanage home and the needy once, thank you am waiting to
hear from you

Mrs,Hannah Wilson David.
