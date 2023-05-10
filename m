Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 042AD6FDB9F
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 12:29:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236635AbjEJK3n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 06:29:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236533AbjEJK3l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 06:29:41 -0400
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22E6F3582;
        Wed, 10 May 2023 03:29:40 -0700 (PDT)
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: marex@denx.de)
        by phobos.denx.de (Postfix) with ESMTPSA id 1CE4A846B6;
        Wed, 10 May 2023 12:29:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
        s=phobos-20191101; t=1683714578;
        bh=R1m1mR/Dho8oLQpQRXJtga5P52rmazCagd9Sof4muII=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=kVCNbeQg1T58bukb36yrFqqUtuKH/5e/gqQXkfagmRy4z5qtiCzlgqvX5T9wry3jq
         bWsniRCc2Pt3/oIPNoSq4fH64Wozc77sp5H/3EqBLiMi7W1Lh4n6nKyFQFkU76Xzx/
         84pxAy8NgP6KZlJDIc/c+8ou/YsQWNhv8Lp3vnPgNwNrJvscd8L33Uqg3w7jsj7C71
         u2JAX67jmtClB8ygwB1bB3oJFiL+KF0Um5DuVrGy8thZmgh2Pwpi2YNt71zmOsaXOo
         rDdeybKpO2lzinRki0xc5qhrko7FuY/YLL+2wBe7NfhirO22TMtluJT6kp4R8Jxotu
         xtdxJ+4v5br7w==
Message-ID: <b917dd8a-489a-82b4-fd64-81029db594c6@denx.de>
Date:   Wed, 10 May 2023 12:29:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v3 2/3] dt-bindings: arm: fsl: Enumerate Emtop SOM
To:     Himanshu Bhavani <himanshu.bhavani@siliconsignals.io>,
        "krzysztof.kozlowski@linaro.org" <krzysztof.kozlowski@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Frieder Schrempf <frieder.schrempf@kontron.de>,
        Fabio Estevam <festevam@denx.de>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Stefan Wahren <stefan.wahren@i2se.com>,
        Jesse Taube <mr.bossman075@gmail.com>,
        Li Yang <leoyang.li@nxp.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20230510083311.3692416-1-himanshu.bhavani@siliconsignals.io>
 <f848adde-895e-18d5-0e9a-a29de24ae861@denx.de>
 <BM1PR01MB4899814FFE961006E01E71D09A779@BM1PR01MB4899.INDPRD01.PROD.OUTLOOK.COM>
Content-Language: en-US
From:   Marek Vasut <marex@denx.de>
In-Reply-To: <BM1PR01MB4899814FFE961006E01E71D09A779@BM1PR01MB4899.INDPRD01.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/10/23 11:13, Himanshu Bhavani wrote:
> Hi Marek Vasut

Hi,

> Yes, it is SOM-IMX8MMLPD4.

In that case, have a look at e.g. this "dh,imx8mp" system. That's also a 
SoM and a carrier board (PDK3). Notice the structure, where both carrier 
board compatible and SoM compatible and imx8mp compatible are listed in 
the DT. I suspect you want to reproduce the same -- include both SoM and 
carrier board compatible string.
