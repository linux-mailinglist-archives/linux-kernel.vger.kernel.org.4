Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AEF16FDC92
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 13:21:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234032AbjEJLV4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 07:21:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236672AbjEJLVs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 07:21:48 -0400
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [81.169.146.165])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4817E10D;
        Wed, 10 May 2023 04:21:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1683717336; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=EWwmxZvDEbh/EvewipoVJ6EEs8xiYN0U6HMxY0qv9121j7F1rzKSb4rACy+DW6Qhk2
    WTVFATSg87K+vQ6fizI06MAl+8TxtiiK/H58mvQS4fSUboCKAXwFfZuIjtbBZtA/3KWf
    cGcRNZZ5AP5ceXJ6EfDhmmz90+0iknIwtuWZDloXSuV+R82hmo9oyR4NmeFtguAn2nlM
    h6I6nAGEuV1vHTBClYWcL4+XgNCRkWEiPTEcjs+74OMNBDyGj1gHEOPSsLpCPwyeUKGE
    pIaFKrKjml/82I6dQw6TSn7gPTv1ccsPLerfz0qameDR8J0WimX3/oTsT8BW4diw2yJg
    by/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1683717336;
    s=strato-dkim-0002; d=strato.com;
    h=Message-Id:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=xVR76s/qYkgwABaggqWtw0/Sy+22wbeuCtrKV1648n0=;
    b=CVxuGvEUMAZYZD9iTf2jf/2d2VEO+vJBDeGpyTPCkGO06j7KTEifgjqxSh+f7Y2r36
    WRl6B6JL+Lvn7WMdfZeI16KnsZEuz/Se6kWDkfOt1n8joOdKIRBpqxLGMNlaj/tFJgJ4
    4HVy7dr00MftgLQEQDffShSpRnPBboiyHByriKuNyGT1x0je8g1KBF6yj7ms5ghgrlyh
    EbsThMZbi4eqbn7e1qKrExyGtG/2z1VHXjOz495VEGvWuNMK7S26r92gvsItlTc6uhBv
    U8Y4sfm4Ee0rYIzQI07HGR8Xnxd76sznIgZjhwH48LqrKonKbKn/zJ36THeuc9advns2
    m4QQ==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1683717336;
    s=strato-dkim-0002; d=ict42.de;
    h=Message-Id:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=xVR76s/qYkgwABaggqWtw0/Sy+22wbeuCtrKV1648n0=;
    b=fixUEaPcrEZb6GQ1isyJh8sMKQlQoQ++cXtVIESGOhNYICscxFd+7LYhmmaDjj3zvN
    Zx/R4SZcdutDEQRetl4CzGZhE/+HKFMGsq4Hs7B4d3w+WfjELiKMqxJQx48XqnSLOddY
    aGVISriBOOsYcYtjRoIjow3Wd49lE0UoQzIYgcxSJFwrbrvNODFA16CoOEAj5nCG524J
    qS8X3GJwk7rwGv5jZwczPqgZ6wzWSgERPb7fOq6aLPzRRZiAkDCEU/cb4nN2MC5cy4vX
    Xt5Oo3ABrEG79ixpjDI09I+iZsP6xCViaSLIEr+VyxYNK/DYnNJJgONJAPafPwtfun3m
    N16w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1683717336;
    s=strato-dkim-0003; d=ict42.de;
    h=Message-Id:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=xVR76s/qYkgwABaggqWtw0/Sy+22wbeuCtrKV1648n0=;
    b=OuzdIrz0c+imvnkHG0IRQVomb6AP5SYgqMTxU2K1HMZHQDhi24NVufYznEtbm8iHT9
    haClr9H+bjP+Kv4A8SCA==
X-RZG-AUTH: ":IHkAYkmvNfSwjg/qSc4u8zZOVaURsoXe3UH2mQA0KglxDI1B7BeEcdPLARTmoNSwY8PK6ePqLwYCwAs="
Received: from debian-test.local.in-circuit.de
    by smtp.strato.de (RZmta 49.4.0 DYNA|AUTH)
    with ESMTPSA id R2b608z4ABFZJXv
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Wed, 10 May 2023 13:15:35 +0200 (CEST)
From:   Ludwig Kormann <ludwig.kormann@ict42.de>
To:     samuel@sholland.org, jernej.skrabec@gmail.com, wens@csie.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        andre.przywara@arm.com
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH v4 0/2] arm: dts: sunxi: Add ICnova A20 ADB4006 board support
Date:   Wed, 10 May 2023 13:15:26 +0200
Message-Id: <20230510111528.2155582-1-ludwig.kormann@ict42.de>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add board support for ICnova A20 SomPi compute module on
ICnova ADB4006 development board.

I rebased the series on v6.4-rc1, I'm also using a new
mail address because of bouncing issues.

v4:
- rebase on v6.4-rc1

v3:
- drop stray blank lines at end of files
- separate patch for bindings
- update licensing to "GPL-2.0 OR MIT"
- fix typo: ICNova -> ICnova

v2:
- use short licensing header
- remove deprecated elements from led nodes
- disable csi power supply
- add missing pins in usbphy node
- split dts into SoM dtsi and carrier board dts

v1 of this patch was sent to the uboot mailing list [1].

[1] https://lists.denx.de/pipermail/u-boot/2023-April/514605.html

Ludwig Kormann (2):
  dt-bindings: arm: sunxi: add ICnova A20 ADB4006 binding
  arm: dts: sunxi: Add ICnova A20 ADB4006 board

 .../devicetree/bindings/arm/sunxi.yaml        |   6 +
 arch/arm/boot/dts/Makefile                    |   1 +
 .../boot/dts/sun7i-a20-icnova-a20-adb4006.dts | 137 ++++++++++++++++++
 arch/arm/boot/dts/sun7i-a20-icnova-a20.dtsi   |  62 ++++++++
 4 files changed, 206 insertions(+)
 create mode 100644 arch/arm/boot/dts/sun7i-a20-icnova-a20-adb4006.dts
 create mode 100644 arch/arm/boot/dts/sun7i-a20-icnova-a20.dtsi

-- 
2.30.2

