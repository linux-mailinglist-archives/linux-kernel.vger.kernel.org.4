Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C89356E3C1C
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Apr 2023 23:26:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229593AbjDPVZ7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Apr 2023 17:25:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbjDPVZ5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Apr 2023 17:25:57 -0400
Received: from mail.andi.de1.cc (mail.andi.de1.cc [IPv6:2a01:238:4321:8900:456f:ecd6:43e:202c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 895C21BE3;
        Sun, 16 Apr 2023 14:25:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=kemnade.info; s=20220719; h=Content-Transfer-Encoding:Content-Type:
        MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=Bs63x70rdsxCq7It95t8f+p2x7fYiriUv+8Gh4KJY+U=; b=A5Q0bDs+zQyaMeT9GKb6T2xv2B
        r485j/9ulNsB6h9OI039djmvsM8IJXmpX0h69wsL9Ow+MEkrEBsPr0Ki6T3Fq1A01egVgFDhq787M
        H0ehYptS7+zO1hQTI4MSQIkiDaMbH5/wxOqBiuKmObGjNiw3jfB8XsSeyyMJaaeLzlKVtkDBa14XX
        xIThtb3TIuQK4Gv+9BNqdzDRrrO56j5QI9o2PpBq7JDExyI075xyvmJXwCvD9x04bDPLStAF83L7w
        8t917tNVMPakvto4FHUtRebx7AV9n8xEqr+2FO+sQbhfic2PizKvKV6El1LndBDT3jM/iMU9dC66R
        9AT44oGA==;
Received: from p200300ccff45ca001a3da2fffebfd33a.dip0.t-ipconnect.de ([2003:cc:ff45:ca00:1a3d:a2ff:febf:d33a] helo=aktux)
        by mail.andi.de1.cc with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <andreas@kemnade.info>)
        id 1po9sd-0002mZ-1u; Sun, 16 Apr 2023 23:25:51 +0200
Date:   Sun, 16 Apr 2023 23:25:49 +0200
From:   Andreas Kemnade <andreas@kemnade.info>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     pavel@ucw.cz, lee@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-leds@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Matti Vaittinen <mazziesaccount@gmail.com>
Subject: Re: [PATCH v4 1/2] dt-bindings: leds: Add ROHM BD2606MVV LED driver
Message-ID: <20230416232549.3b0a5eed@aktux>
In-Reply-To: <7fe8d6f5-ab0f-c6d5-2551-7beb3dfb16d7@linaro.org>
References: <20230414055341.335456-1-andreas@kemnade.info>
        <20230414055341.335456-2-andreas@kemnade.info>
        <f9da7499-3fb3-1ce6-db0b-d87febee2052@linaro.org>
        <20230414175412.37a15572@aktux>
        <7fe8d6f5-ab0f-c6d5-2551-7beb3dfb16d7@linaro.org>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.24; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Score: -1.0 (-)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, 14 Apr 2023 23:17:56 +0200
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> wrote:

> On 14/04/2023 17:54, Andreas Kemnade wrote:
> > On Fri, 14 Apr 2023 17:28:49 +0200
> > Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> wrote:
> >   
> >> On 14/04/2023 07:53, Andreas Kemnade wrote:  
> >>> Document ROHM BD2606MVV LED driver devicetree bindings.    
> >>
> >> Subject: no improvements and no comments from your side. Why?
> >>  
> > old subject (v2):
> > 
> > dt-bindings: leds: ROHM BD2606MVV LED driver
> > 
> > Your comment:
> > Subject: maybe drop "driver" (suggests it is for Linux drivers, although
> > maybe it matches the actual hardware here?) and add missing verb, e.g.
> > "Add ROHM ..."
> > 
> > New Subject (v3/4):
> > dt-bindings: leds: Add ROHM BD2606MVV LED driver
> > 
> > What is still missing?  
> 
> There is still "driver". Comment was: drop "driver". Where is it dropped?
> 
> If you do not agree, sure, just respond with something.
> 
I am fine with both. On one hand BD2606MVV is not a LED by itself
but LEDs can be connected to it. so the chip itself can be called LED driver.

But on the other hand I think that holds true for everything in drivers/leds
and binding/leds and we do not call the subsystem leddriver.
So there are reasons for and against "driver" in the subject line.

Regards,
Andreas
