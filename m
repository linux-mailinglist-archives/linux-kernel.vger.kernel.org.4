Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4155A5F22E7
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Oct 2022 13:25:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229780AbiJBLZx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Oct 2022 07:25:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229864AbiJBLZq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Oct 2022 07:25:46 -0400
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 151EB2C13B
        for <linux-kernel@vger.kernel.org>; Sun,  2 Oct 2022 04:25:43 -0700 (PDT)
Received: by mail-qk1-x734.google.com with SMTP id u28so5274322qku.2
        for <linux-kernel@vger.kernel.org>; Sun, 02 Oct 2022 04:25:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=F8GQpBLMbSSQndmhlGAvL/vCPrdHrcNqTn85qYLXTLM=;
        b=CICQgxwNoPvxJj3P5vfBaE4dhnLO3nlosxMATPREMLwYxBKxbl7ioXXq6yefbSkaBh
         pJGniM1VX5W2HHHm5BJtpqEzIPSU2yatUomlD6y3rundQELyDWgpfReNoVslpQuo1COE
         nzaJqx+qI2s41tqj132/YDK9l84Ev+WzDkVCzxrxFenFvb5N7LVCczUuII3CXBO0hT1G
         1ScrkekmWf/mHAJ/jPkRJKONgUup0m90KtjeNTT1m0lNiqc2mJkqHGP0s4ejZQa1NMVb
         yQTyeWANTj6/akhmpwLxG84ft22qjkXiPuEhSxNFEgeDx2iYKzjOJ5W+XQ/CCrLIBeAl
         lX5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=F8GQpBLMbSSQndmhlGAvL/vCPrdHrcNqTn85qYLXTLM=;
        b=HdnZdPv73Xql9E3fYdtcLhTYY38JcFfRCpUKiYgcQ8PfYi4YKpfjbSJZW3U+aJnRO2
         gi9P655sTpWayQKF+WqZrnaq4SJv9LGo9/T3+PFrOdH1ZT3EmQnYyW0Ay2GD/kyC114K
         rWrLiprsNMEIaq52XVC1p0eKEg8XZfnIhRgAexK7gVtZV29IGqSuGy1PO+J5ayVtZrg3
         HiaY/Y/9ejjYBK/dmbfE9rzUG8H1TUthXCWM1wUsLme3Z4L8DeFdHdDCqY0KUO4xarN4
         szfG2+cXOkMxT4SooFY/iv9e32Mayx8Gaj0QB5keDCm+jETYiUwjvQC3juNBgqNH0YGj
         6Cug==
X-Gm-Message-State: ACrzQf1FFXl73WbhKrlGmq4lprPWDIXLc+hrJnZRsQrXq4o4mU0hvtpp
        XGpUvgq1eELgK62gbHc27Z/kkThz/JgLvPVIRds=
X-Google-Smtp-Source: AMsMyM4QD1GNI2MyApJ6LxoImD8k5GwlHYSr3eczAZLUOxbtWmidOmj9bQ2x2o56qMmOQvGNiTpMaDEcSL2p5XTUwv0=
X-Received: by 2002:a37:9a51:0:b0:6cf:427b:c180 with SMTP id
 c78-20020a379a51000000b006cf427bc180mr10754906qke.767.1664709942531; Sun, 02
 Oct 2022 04:25:42 -0700 (PDT)
MIME-Version: 1.0
References: <20220926043618.566326-1-zyytlz.wz@163.com> <YzFkpRfkdnwgDDw6@kroah.com>
 <CAJedcCxGkz6i2LeCGWcHgU7P2n1TeB9gKVZCzmjPPJK=hhsfLA@mail.gmail.com>
 <YzMmp9llFUN1yUDH@kroah.com> <CAJedcCxjjNFsHibTO3-M6a8vay3-2LcSN=0dNkqCicLakG4wOw@mail.gmail.com>
In-Reply-To: <CAJedcCxjjNFsHibTO3-M6a8vay3-2LcSN=0dNkqCicLakG4wOw@mail.gmail.com>
From:   Zheng Hacker <hackerzheng666@gmail.com>
Date:   Sun, 2 Oct 2022 19:25:32 +0800
Message-ID: <CAJedcCxjYDj5s2XbGDYSVMkcdZPOLqz5joN-L6P3aJzQ1Jy2_Q@mail.gmail.com>
Subject: Re: [PATCH] misc: sgi-gru: fix use-after-free error in
 gru_set_context_option, gru_fault and gru_handle_user_call_os
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Zheng Wang <zyytlz.wz@163.com>, dimitri.sivanich@hpe.com,
        arnd@arndb.de, linux-kernel@vger.kernel.org,
        alex000young@gmail.com, security@kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Here is the link of new
patch(https://lore.kernel.org/all/20220928025957.1050698-1-zyytlz.wz@163.com/T/#u),
I added the Fixes line to tell which commit introduced the bug.

Thanks,
Zheng Wang
