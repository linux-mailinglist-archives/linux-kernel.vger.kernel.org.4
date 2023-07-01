Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CD84744B35
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Jul 2023 23:57:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229644AbjGAV5q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 Jul 2023 17:57:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229502AbjGAV5p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Jul 2023 17:57:45 -0400
X-Greylist: delayed 207 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sat, 01 Jul 2023 14:57:43 PDT
Received: from hall.aurel32.net (hall.aurel32.net [IPv6:2001:bc8:30d7:100::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7226171D;
        Sat,  1 Jul 2023 14:57:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=aurel32.net
        ; s=202004.hall; h=In-Reply-To:Content-Type:MIME-Version:References:
        Message-ID:Subject:Cc:To:From:Date:Content-Transfer-Encoding:From:Reply-To:
        Subject:Content-ID:Content-Description:X-Debbugs-Cc;
        bh=ESQh2Q+J0+KOjCLAOqWvKR9Wn07hny/kQnYrkVfd2nY=; b=mAwVwZr09EuuZKp7Y+ECNtX51Y
        oI3ITdXfeLoYBRrKusNNTP+RcyoFKTvFyEg8vaAKa6DQ4l8cENWzCoJhljV4y1CloXdDTyRXtjnZH
        J/SNNfOAYXZXfg1vQIQbQvfEIIStc3YA63+ysm+rMCw5qWtgEmP/l8BOP+RCAa5dLbSTOz3z8Gz1E
        B4rlSZ1QcYSpSSCVFOGS0Y/8Nc6jDHOy92CtMjZ36Q83AHZNT/tHIq3pLJR3tlQQFSleuH3G+f0aS
        Vh84GN/g9VrjftL4T+mipsknLVqp7N/JG/F/zUg5BK8Fu9dzLLCERPnHv77CyYQNuyIP2QMLaLdLP
        +ebmeOeg==;
Received: from [2a01:e34:ec5d:a741:8a4c:7c4e:dc4c:1787] (helo=ohm.rr44.fr)
        by hall.aurel32.net with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <aurelien@aurel32.net>)
        id 1qFib4-00F8qC-PV; Sat, 01 Jul 2023 23:57:38 +0200
Received: from aurel32 by ohm.rr44.fr with local (Exim 4.96)
        (envelope-from <aurelien@aurel32.net>)
        id 1qFib4-00FE57-0Y;
        Sat, 01 Jul 2023 23:57:38 +0200
Date:   Sat, 1 Jul 2023 23:57:38 +0200
From:   Aurelien Jarno <aurelien@aurel32.net>
To:     Guo Samin <samin.guo@starfivetech.com>
Cc:     Jakub Kicinski <kuba@kernel.org>, linux-riscv@lists.infradead.org,
        netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Emil Renner Berthing <kernel@esmil.dk>,
        Richard Cochran <richardcochran@gmail.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Peter Geis <pgwipeout@gmail.com>,
        Yanhong Wang <yanhong.wang@starfivetech.com>
Subject: Re: [PATCH v6 0/8] Add Ethernet driver for StarFive JH7110 SoC
Message-ID: <ZKChUuUpCgh/jPSU@aurel32.net>
Mail-Followup-To: Guo Samin <samin.guo@starfivetech.com>,
        Jakub Kicinski <kuba@kernel.org>, linux-riscv@lists.infradead.org,
        netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Emil Renner Berthing <kernel@esmil.dk>,
        Richard Cochran <richardcochran@gmail.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Peter Geis <pgwipeout@gmail.com>,
        Yanhong Wang <yanhong.wang@starfivetech.com>
References: <20230313034645.5469-1-samin.guo@starfivetech.com>
 <20230313173330.797bf8e7@kernel.org>
 <51102144-1533-d2f7-5fde-e01160a6f49e@starfivetech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <51102144-1533-d2f7-5fde-e01160a6f49e@starfivetech.com>
User-Agent: Mutt/2.2.9 (2022-11-12)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 2023-03-15 09:31, Guo Samin wrote:
> Re: [PATCH v6 0/8] Add Ethernet driver for StarFive JH7110 SoC
> From: Jakub Kicinski <kuba@kernel.org>
> to: Samin Guo <samin.guo@starfivetech.com>
> data: 2023/3/14
> 
> > On Mon, 13 Mar 2023 11:46:37 +0800 Samin Guo wrote:
> >> This series adds ethernet support for the StarFive JH7110 RISC-V SoC.
> >> The series includes MAC driver. The MAC version is dwmac-5.20 (from
> >> Synopsys DesignWare). For more information and support, you can visit
> >> RVspace wiki[1].
> > 
> > I'm guessing the first 6 patches need to go via networking and patches
> > 7 and 8 via riscv trees? Please repost those separately, otherwise
> > the series won't apply and relevant CIs can't run on it.
> 
> Hi Jakub,
> 
> 	Thanks a lot, I will repost those separately.

Unless I am mistaken, this patches haven't been reposted since them.
Could you please do that?

Thanks
Aurelien

-- 
Aurelien Jarno                          GPG: 4096R/1DDD8C9B
aurelien@aurel32.net                     http://aurel32.net
