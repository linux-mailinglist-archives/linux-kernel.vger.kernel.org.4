Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A79E6E2790
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Apr 2023 17:54:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230322AbjDNPyZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Apr 2023 11:54:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230088AbjDNPyX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Apr 2023 11:54:23 -0400
Received: from mail.andi.de1.cc (mail.andi.de1.cc [IPv6:2a01:238:4321:8900:456f:ecd6:43e:202c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6320B26BB;
        Fri, 14 Apr 2023 08:54:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=kemnade.info; s=20220719; h=Content-Transfer-Encoding:Content-Type:
        MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=QUM4XJ7mQSq9TvavrDLW/Vfh3IOCjYmda+Bn99hI3jo=; b=Bx5rH30nQUbNs2a4ibnFIy/vZn
        ei99LiZ1NJtk+FqSEjiPoKBJG01g7iCkpydbTFw1fPeRfOhWtaIBpx4Nt1FXbiRtuAq6r1sRsUwVb
        Q2VT+YQUIS5u4nvsYrAnqQ8VeU2VdPF9BxI76rW25Pn4k65dPU+AijY+qJUbvK4exMPQMfhYitWsp
        RxsR4Y5D6dajbuQMH9lOwWbyukSne47xZObCeh5e1g9P+L/Y/plsT+tjFsqQnw/6fR8Oh967ifQXO
        fPieog9jD/+GqPquYVXiA34Sqw1e6BkOTnfRGh10I7kL7wqk0Fzh417vlRoDa71bNw8G/3nwsfBmQ
        N1JZAgmQ==;
Received: from p200300ccff0c0d001a3da2fffebfd33a.dip0.t-ipconnect.de ([2003:cc:ff0c:d00:1a3d:a2ff:febf:d33a] helo=aktux)
        by mail.andi.de1.cc with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <andreas@kemnade.info>)
        id 1pnLkb-0006RA-Ti; Fri, 14 Apr 2023 17:54:15 +0200
Date:   Fri, 14 Apr 2023 17:54:12 +0200
From:   Andreas Kemnade <andreas@kemnade.info>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     pavel@ucw.cz, lee@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-leds@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Matti Vaittinen <mazziesaccount@gmail.com>
Subject: Re: [PATCH v4 1/2] dt-bindings: leds: Add ROHM BD2606MVV LED driver
Message-ID: <20230414175412.37a15572@aktux>
In-Reply-To: <f9da7499-3fb3-1ce6-db0b-d87febee2052@linaro.org>
References: <20230414055341.335456-1-andreas@kemnade.info>
        <20230414055341.335456-2-andreas@kemnade.info>
        <f9da7499-3fb3-1ce6-db0b-d87febee2052@linaro.org>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.24; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Score: -1.0 (-)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 14 Apr 2023 17:28:49 +0200
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> wrote:

> On 14/04/2023 07:53, Andreas Kemnade wrote:
> > Document ROHM BD2606MVV LED driver devicetree bindings.  
> 
> Subject: no improvements and no comments from your side. Why?
> 
old subject (v2):

dt-bindings: leds: ROHM BD2606MVV LED driver

Your comment:
Subject: maybe drop "driver" (suggests it is for Linux drivers, although
maybe it matches the actual hardware here?) and add missing verb, e.g.
"Add ROHM ..."

New Subject (v3/4):
dt-bindings: leds: Add ROHM BD2606MVV LED driver

What is still missing?

Regards,
Andreas
