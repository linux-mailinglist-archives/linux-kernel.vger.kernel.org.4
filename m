Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 965E3676BCC
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Jan 2023 10:09:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229938AbjAVJJF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Jan 2023 04:09:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbjAVJJE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Jan 2023 04:09:04 -0500
Received: from mail.andi.de1.cc (mail.andi.de1.cc [IPv6:2a01:238:4321:8900:456f:ecd6:43e:202c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72A3C1F4A5;
        Sun, 22 Jan 2023 01:09:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=kemnade.info; s=20220719; h=Content-Transfer-Encoding:Content-Type:
        MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=VrpSjRVWRpLB+kPorI91UdQAtzr72U2i/Ay10A+MJmQ=; b=iVxCDSSLpwaBZwREXNIipYG3vR
        4llqgpbYdLbFt1zbYcVwfBvPaCt+8On9z8KLmkf4Du996DtFfQ/+d2gUFdQ1WUvdD6v9vNmBCh6xv
        5qO3OsVbKI2z3DkkGMo9yVtgKMRm+tmEPt9tE4ISb0aEsg2TcW319z2ijvj72Vg7PdEzJVUPgIR3M
        gdsHpFReipT9d6iU7R6wn9QB5NTwVRWPF6r7RPN7xG1jdH904/D+eLGvLPO8GX6tb4K6z23Bj30dM
        ymlsVFzQcpCKVybiVavDGY33spsFIonmPLNa3CSDFa2VFk3Beh4aDICYoGHkuF1Gdb8JTzsaGcJSM
        Zy0Efdzg==;
Received: from p200300ccff40f1001a3da2fffebfd33a.dip0.t-ipconnect.de ([2003:cc:ff40:f100:1a3d:a2ff:febf:d33a] helo=aktux)
        by mail.andi.de1.cc with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <andreas@kemnade.info>)
        id 1pJWLN-0002qn-Np; Sun, 22 Jan 2023 10:08:54 +0100
Date:   Sun, 22 Jan 2023 10:08:52 +0100
From:   Andreas Kemnade <andreas@kemnade.info>
To:     Tony Lindgren <tony@atomide.com>
Cc:     Adam Ford <aford173@gmail.com>, bcousson@baylibre.com,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        linux-omap@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        "H. Nikolaus Schaller" <hns@goldelico.com>
Subject: Re: [PATCH] ARM: dts: gta04: fix excess dma channel usage
Message-ID: <20230122100852.32ae082c@aktux>
In-Reply-To: <Y8jxjBZrPV0n363P@atomide.com>
References: <20230113211151.2314874-1-andreas@kemnade.info>
        <CAHCN7xJH+c41Yas+xnWA57KNi9arOOJDxJ=joEDEJr2k6jrRrw@mail.gmail.com>
        <Y8VkjQ2yZQssx/wJ@atomide.com>
        <20230116173922.585904bf@aktux>
        <Y8WBuKt6mw6TN1Cp@atomide.com>
        <CAHCN7x+b2_dnpRs8RarhhgTfBrTVfGfmcQNbfHLoWBwkZ_3Puw@mail.gmail.com>
        <Y8WEoxiOXgZNB1Oc@atomide.com>
        <Y8jxjBZrPV0n363P@atomide.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Score: -1.0 (-)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 19 Jan 2023 09:30:20 +0200
Tony Lindgren <tony@atomide.com> wrote:

> * Tony Lindgren <tony@atomide.com> [230116 17:33]:
> > * Adam Ford <aford173@gmail.com> [230116 17:00]:  
> > > Doesn't this imply the target-module stuff needs to be implemented for
> > > the drivers?  It looks like a lot of the omap3 drivers are still using
> > > hwmods although some have target-modules. In this case, the mcspi
> > > drivers that Andreas is disabling don't appear to have target-module
> > > stuff configured.  
> > 
> > Sorry I don't remember if omap_device.c ignores status disabled or not.
> > But in any case, it should be trivial to update omap3.dtsi to configure
> > some of the devices like mcspi to probe with device tree data and ti-sysc
> > as needed.  
> 
> So as long as gta04 power management still behaves with this patch it
> should good to go.
> 
# sleep 10 ; /usr/local/bin/idledump
     CM_IDLEST1_CORE 00000042
     CM_IDLEST3_CORE 00000000
     CM_FCLKEN1_CORE 00000000
     CM_FCLKEN3_CORE 00000002
     CM_CLKSTST_CORE 00000003
     CM_IDLEST_CKGEN 00000209
    CM_IDLEST2_CKGEN 00000000
       CM_FCLKEN_DSS 00000000
       CM_IDLEST_DSS 00000000
       CM_FCLKEN_CAM 00000000
       CM_IDLEST_CAM 00000000
       CM_FCLKEN_PER 00000000
       CM_IDLEST_PER 00000000


FCLKEN3_CORE becomes 0 after unbinding the bandgap sensor.

but...
# cat /sys/kernel/debug/pm_debug/time 
usbhost_pwrdm (ON),OFF:830267486567,RET:0,INA:0,ON:12202880865
sgx_pwrdm (INA),OFF:0,RET:0,INA:841224365234,ON:1245971680
core_pwrdm (ON),OFF:0,RET:0,INA:0,ON:842470336914
per_pwrdm (ON),OFF:520406799328,RET:30043365464,INA:0,ON:292020111087

hmmm.... 

but does not look like anything related to mcspi*.

Regards,
Andreas

