Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC84673FAAE
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 13:01:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230219AbjF0LBu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 07:01:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229667AbjF0LBk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 07:01:40 -0400
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 573961FC7
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jun 2023 04:01:39 -0700 (PDT)
Received: by mail-yb1-xb30.google.com with SMTP id 3f1490d57ef6-bd61dd9a346so4317866276.2
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jun 2023 04:01:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687863698; x=1690455698;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=R0Q5h3oMUk2WtX+PDTrt5F7ey8kBpdLCkGKFBOqFPxc=;
        b=zuJwE5340h3/k5+rDoVZOKBMBZx1HiKZhMvMUS2/M43/CfGpxC68ECF7fRpRqzo9gm
         rA0DBXnKE29qdJSY8BZOGJpEc/m1vNQenb9JYV4P2hjbURDv20nAeg5VZUSvfa+W8ek0
         E0zbbqkmpQntms0UhlGt5vuyBMyLGlPaA/ym62aq5iA6sQmNjb9tQ/dGm1en9n9rQ4J+
         NGyI/VGX1e7e6VNtQWoz/rM/J3UwKE/XQ+F/7HgPCG1ajwHvms0SqNXBqER0jqTCzdVx
         hovb1cNOUDIFp/CYwUYQyuKOQY/2I+UBzclq6M8lZtFcBoz+NDgsKAghCjrC2geIXjYF
         EOpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687863698; x=1690455698;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=R0Q5h3oMUk2WtX+PDTrt5F7ey8kBpdLCkGKFBOqFPxc=;
        b=mAunPu7iVmhfiJ9dslf3vF3+9oJZTSCfK/EvqjUte+R2DvhHW3cs0zLpePLXmVDpXg
         DxXJLwbMU2TnmJEOEzDm+wB8Nm7OpyjuiT0AyQNFKiO1geOwGW26Xnmy3TmQ38AOn03N
         lTN/A3oWxB7s/zyFR29he2/3TfB0jaDE4aAFm6qAD0y/s5eIkh4S08REjeewBsvdiUmY
         LrO4DjgmZ847wDOUB60ITF4vKSNlYVs6Qbi+CgKeY0Q8OZJi4Wq+mwI377QKixfmmy5i
         ar7dJBOjHJ+0mtBCOkTUr07yxP3kEM8mn4wYD83B8K3v570TyaZ5uBvILtO9KVVp5pZo
         v+6g==
X-Gm-Message-State: AC+VfDwtjWrwigmjAnpDlDuBjeARrPrRzWUVZq3Hcf3ourNYUc55+CW3
        PffoqgPnWcpJcByvILwxqj6B+MJGq+AGIQaR1G9nqA==
X-Google-Smtp-Source: ACHHUZ7ug4OCrtj/DupQ71tMmD5IsVeQaLXq3Q6iFEaOFaChH77FdCS1aVFPq0dzJPGQQ9EKZsgWgZJhTioJVhOFig8=
X-Received: by 2002:a25:aa2a:0:b0:c1e:7649:c244 with SMTP id
 s39-20020a25aa2a000000b00c1e7649c244mr5893887ybi.15.1687863698511; Tue, 27
 Jun 2023 04:01:38 -0700 (PDT)
MIME-Version: 1.0
References: <CA+CX+bjcvbtW2Wto1XF1dKcAbpGGisdyHAGHX12v3TchhLbKtg@mail.gmail.com>
In-Reply-To: <CA+CX+bjcvbtW2Wto1XF1dKcAbpGGisdyHAGHX12v3TchhLbKtg@mail.gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 27 Jun 2023 13:01:02 +0200
Message-ID: <CAPDyKFoTH0j1uVSKvY_d7boMdG0kt_WvmLEKenYG22ZJR=UmvA@mail.gmail.com>
Subject: Re: rtsx_usb_sdmmc not detecting card insertion anymore
To:     Pascal Terjan <pterjan@gmail.com>,
        Kai Heng Feng <kai.heng.feng@canonical.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        linux-mmc@vger.kernel.org, Ricky WU <ricky_wu@realtek.com>,
        Oleksandr Natalenko <oleksandr@natalenko.name>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+ Ricky WU, Kai Heng Feng, Oleksandr Natalenko

On Sat, 24 Jun 2023 at 22:39, Pascal Terjan <pterjan@gmail.com> wrote:
>
> Hi,
> I have an ASUS PN50 machine with a 0bda:0129 card reader. The card is
> not seen unless I reload the rtsx_usb_sdmmc module.

Thanks for reporting, let's see how we can move this forward.

I have looped in some of the people that has been involved in the
relevant changes for rtsx_usb. Let's see if they can help too.

>
> I found a Debian bug report for the same regression
> https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=993068 but nothing
> to see there.
>
> Trying to understand things I found
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=4dad599b8b5d1ffc5ef12a2edb13d15d537202ba
> which seemed related, so I first tried to revert it and that worked.

Okay! That's certainly good information. Are you willing to help
running further debug testings?

Unless I mistaken, I think we should avoid doing a plain revert
(assuming we can find another option) as it will cause us to waste a
lot of energy instead.

>
> Assuming the description is correct and the rtsx USB driver runtime
> resumes the rtsx_usb_sdmmc device when it detects that a new card has
> been inserted, I assume this means it doesn't detect that a card was
> inserted and the problem would be in rtsx_usb rather than
> rtsx_usb_sdmmc.

There is also another interesting commit, which was also part of the
re-work of the rtsx_usb_sdmmc driver that you pointed to above.

commit 883a87ddf2f1 (misc: rtsx_usb: Use USB remote wakeup signaling
for card insertion detection")

>
> I am not sure how to debug this further, usbmon doesn't see anything
> when I insert the card.

If you are willing to run some tests, I suggest to add some debug prints in:
drivers/mmc/host/rtsx_usb_sdmmc.c
  sdmmc_get_cd()
  rtsx_usb_sdmmc_runtime_resume()
  rtsx_usb_sdmmc_runtime_suspend()

sdmmc_get_cd() should be returning 1 when it finds that there is card
inserted, but of course the error path would be interesting too.

rtsx_usb_sdmmc_runtime_resume() may be called during probing of the
rtsx_usb_sdmmc driver. Beyond that point, it should also be called
when you insert an SD card. Just having a debug print in there should
help answer if that actually happens.

Kind regards
Uffe
