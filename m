Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FC1862F14B
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 10:35:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241958AbiKRJfH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 04:35:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241240AbiKRJfE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 04:35:04 -0500
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23669C5D;
        Fri, 18 Nov 2022 01:35:04 -0800 (PST)
Received: by mail-ed1-x52a.google.com with SMTP id x102so6419468ede.0;
        Fri, 18 Nov 2022 01:35:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=fYL2lqqcJ/7e1uhSD1iCGZdR4sa0akGcGPNEmZ3Ebs8=;
        b=K7dvmblKPEYFvoyA1jXzSwVPyVsYLRCvz0SdVOTvVagx9/S+/UKtM22hbUhi3Wt301
         6mViMS3mjGCF0MOtD4UjlX6Hy2JhXZtf7yz14AAdB1SYxlD1jfqDQTToABg45kR91gee
         ZkyqKgzmiGEHSiDvTskz+j40cjTXWU81TXKQAwf/RElLLbGc/g31Mil4blhBvu1LpoaU
         8hebEeDrkbwpiS3mpeX4RrSf7NVfg7M2ierGUVgZxpM9vsK7ncZnyRONJdQI2NCbG1ac
         tOQgYYCMZ9L2pFCZg22Fo5eQ2i+MydWWET/KqPnAe0vczb77VDHZTQm6WXjgKwRnzdu/
         UikA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fYL2lqqcJ/7e1uhSD1iCGZdR4sa0akGcGPNEmZ3Ebs8=;
        b=2P5kLLIh+fX1rbsAxJqyiC7c+JimSLXeqqYPuKD24MeMA5PjtyG9SisDAlIcvT7VRl
         Qji9NHsrFd2AQu0muCUCDrD26OAsq+/ERhul62ofSW1Oboi2qqvTD4QGjoLWYq02dikw
         5NVinaQhN2EMjDXtCsMeGcilGTgj6v/vvb4XDnkVCpw+C6cBOzG++ToesTXojQm66tOT
         DGxkce5zdzKPj62lgRSZ0ke4ge9RTjHsMjshxgBkCslnUMu8fG7P3mK4fHHvl8OfemaH
         xm7fGlTfayovJx0C6RuMoPZb+JmDC8ROv8vp3tg6zmrVfy0Kgra6T9diQ44Ant+s6voN
         qmxw==
X-Gm-Message-State: ANoB5pm3MWUkw9IBr9kozo+YqGjvyl22KEgws7CP2g+RBAvR8j8g4GTA
        Py9WGw+ETwUrz5nPVJoYAho0jUSEGJB1TfeYwG4=
X-Google-Smtp-Source: AA0mqf6GCwrX18gDBDCF6o6ToPuYobYosdpVjryabNOZJgLVMsl/zCJpx4QbqmYhuhxpW3picNzIlMLTQcbXObBRihw=
X-Received: by 2002:a05:6402:504:b0:461:5542:6884 with SMTP id
 m4-20020a056402050400b0046155426884mr5256294edv.390.1668764102550; Fri, 18
 Nov 2022 01:35:02 -0800 (PST)
MIME-Version: 1.0
References: <20221116200150.4657-1-linux.amoon@gmail.com> <20221116200150.4657-2-linux.amoon@gmail.com>
 <bdcd2071-8f56-b829-7e78-3fc9efec09fc@wolfvision.net>
In-Reply-To: <bdcd2071-8f56-b829-7e78-3fc9efec09fc@wolfvision.net>
From:   Anand Moon <linux.amoon@gmail.com>
Date:   Fri, 18 Nov 2022 15:04:46 +0530
Message-ID: <CANAwSgQkwXb0KE+1856egmUyTx_pmr9hq6nk8-0YoMQJdBoDvQ@mail.gmail.com>
Subject: Re: [linux-next-v2 1/5] arm64: dts: rockchip: Fix gmac phy mode to
 rgmii on Rock 3A SBC.
To:     Michael Riesch <michael.riesch@wolfvision.net>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Chukun Pan <amadeus@jmu.edu.cn>,
        Peter Geis <pgwipeout@gmail.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Michael,

On Fri, 18 Nov 2022 at 12:33, Michael Riesch
<michael.riesch@wolfvision.net> wrote:
>
> Hi Anand,
>
> On 11/16/22 21:01, Anand Moon wrote:
> > On rk356x ethernet phy support reduced media independent interface (RMII)
> > and reduced gigabit media independent interface (RGMII).
> > So set the phy mode to rgmii to support clock delay, also
> > add TX and RX delay for phy-mode.
>
> Based on this commit message I still don't understand what you are
> actually trying to fix here. If you encounter network problems/stability
> issues, please let me know what test triggers the faulty behavior.
> Please describe the problem you are facing in detail here or in the
> cover letter.
>

Ok, Ethernet does not work on my Radxa 3A see boot logs.

[0] https://gist.github.com/moonlinux/bb56c787031226fbb9f69121564e76a2

Please find this updated commit message.

As per the schematic and datasheet PHY mode is RGMII
Use 2ns clock delay to RXC for RXD and TXC for TXD latching.

> > Fix the following warning
> >
> > [    7.365215] rk_gmac-dwmac fe010000.ethernet: Can not read property: tx_delay.
> > [    7.365219] rk_gmac-dwmac fe010000.ethernet: set tx_delay to 0x30
> > [    7.365224] rk_gmac-dwmac fe010000.ethernet: Can not read property: rx_delay.
> > [    7.365228] rk_gmac-dwmac fe010000.ethernet: set rx_delay to 0x10
>
> If the only purpose of this patch is to get rid of this warnings, it may

No, the intent is to fix the PHY mode to RGMII and fix the delay.
[ 7.066357] rk_gmac-dwmac fe010000.ethernet: init for RGMII_ID

> make sense to set them to dev_dbg as Peter pointed out.
>
Ok, will update this in the next version.

> Best regards,
> Michael
>
Thanks
-Anand
