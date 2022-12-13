Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D414364B5A8
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Dec 2022 14:05:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235442AbiLMNFL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Dec 2022 08:05:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234296AbiLMNFH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Dec 2022 08:05:07 -0500
Received: from sender4-op-o14.zoho.com (sender4-op-o14.zoho.com [136.143.188.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6825D1D333;
        Tue, 13 Dec 2022 05:05:06 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1670936693; cv=none; 
        d=zohomail.com; s=zohoarc; 
        b=NJyWtGUqF9JoKZqBoobQ45oKdr1MImtZ5bqTP16He/oe6n/w4IXVSLMAGk/7K+edz1KdoZBUnSJM39bCP8NbRa03dcKVqAZEJdhLZIQucuGMzSm9XNxPvqSO7eR545qWHAh5acYl5A3Qij1xblYgVMdXfI15EDvt/qMqy3nrkpA=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
        t=1670936693; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:MIME-Version:Message-ID:Subject:To; 
        bh=HBt2SS58XZzUibGPuuuRWTkBBCLZP/33uVke48GYcq8=; 
        b=BBp/PvcTELArqBLbNLEyTZrQNzJuHRXR1j/76UpmDWf+oWQB6kqrsrIIbNf4oxTc5oCaEqEPc/yjTB+TMhqpNmSK319seMdiagFnkCtlYCzEkjKAU+WOe5vravoeXtSM+NFTrUwvkojS0eNakDN4xqtiJ/9OP0eMQOJwWF0LuTo=
ARC-Authentication-Results: i=1; mx.zohomail.com;
        dkim=pass  header.i=arinc9.com;
        spf=pass  smtp.mailfrom=arinc.unal@arinc9.com;
        dmarc=pass header.from=<arinc.unal@arinc9.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1670936693;
        s=zmail; d=arinc9.com; i=arinc.unal@arinc9.com;
        h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-Id:Message-Id:MIME-Version:Content-Type:Content-Transfer-Encoding:Reply-To;
        bh=HBt2SS58XZzUibGPuuuRWTkBBCLZP/33uVke48GYcq8=;
        b=MwFCLHL6CARmRv4PykO1TpwxEXK3NSqSf8G4CwIfEJRvO253WHyH674UPFGLCiTY
        jz4yiJTXdjWOOW5HdgaTOS3hoEMCIngzBmFDo9++ehqctwY14aSwbCs5Uf0BbBhPth/
        KYsQAqQdk6hQT6ily0LrvYuyaajkgWZXQ2aXzjqs=
Received: from arinc9-PC.lan (37.120.152.236 [37.120.152.236]) by mx.zohomail.com
        with SMTPS id 1670936688339228.90466503221523; Tue, 13 Dec 2022 05:04:48 -0800 (PST)
From:   =?UTF-8?q?Ar=C4=B1n=C3=A7=20=C3=9CNAL?= <arinc.unal@arinc9.com>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Sergio Paracuellos <sergio.paracuellos@gmail.com>,
        Luiz Angelo Daros de Luca <luizluca@gmail.com>
Cc:     linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mips@vger.kernel.org
Subject: [PATCH 0/6] Enhance Ralink pinctrl documentation
Date:   Tue, 13 Dec 2022 16:04:24 +0300
Message-Id: <20221213130430.172876-1-arinc.unal@arinc9.com>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Heyo,

This series mainly enhances the Ralink pinctrl documentation, and make a
small variable name change on the subdrivers.

I've compile-tested all the subdrivers.
I've tested the dt-binding changes with:
make dt_binding_check DT_SCHEMA_FILES=pinctrl/ralink

Arınç ÜNAL (6):
  pinctrl: ralink: rename variables which point out the pin group
  dt-bindings: pinctrl: mt7620: add proper function muxing binding
  dt-bindings: pinctrl: mt7621: add proper function muxing binding
  dt-bindings: pinctrl: rt2880: add proper function muxing binding
  dt-bindings: pinctrl: rt305x: add proper function muxing binding
  dt-bindings: pinctrl: rt3883: add proper function muxing binding

 .../bindings/pinctrl/ralink,mt7620-pinctrl.yaml | 632 +++++++++++++++++--
 .../bindings/pinctrl/ralink,mt7621-pinctrl.yaml | 204 +++++-
 .../bindings/pinctrl/ralink,rt2880-pinctrl.yaml |  85 ++-
 .../bindings/pinctrl/ralink,rt305x-pinctrl.yaml | 235 ++++++-
 .../bindings/pinctrl/ralink,rt3883-pinctrl.yaml | 204 +++++-
 drivers/pinctrl/ralink/pinctrl-mt7620.c         | 164 ++---
 drivers/pinctrl/ralink/pinctrl-mt7621.c         |  48 +-
 drivers/pinctrl/ralink/pinctrl-rt2880.c         |  28 +-
 drivers/pinctrl/ralink/pinctrl-rt305x.c         |  82 +--
 drivers/pinctrl/ralink/pinctrl-rt3883.c         |  44 +-
 10 files changed, 1462 insertions(+), 264 deletions(-)


