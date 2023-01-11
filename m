Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 554A6665D72
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 15:14:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238488AbjAKOOU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 09:14:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236599AbjAKOOP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 09:14:15 -0500
Received: from out162-62-57-210.mail.qq.com (out162-62-57-210.mail.qq.com [162.62.57.210])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B73FD5FF3;
        Wed, 11 Jan 2023 06:14:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
        s=s201512; t=1673446449;
        bh=FSKqGBNrgKQCak0MyFaGE4iEHv/JDgMhWdF5s45tZpg=;
        h=From:To:Cc:Subject:Date;
        b=Pthr5uSYh/6PJTMcW/60Yfp6fY5SY+qP3LzhmqioFalLQs678cfyuBT1YVLS5oqGQ
         +zNIVuSkP2LOJHDxTqMuvd0yTqbkPKPmp7aMhk7sWmqXnYcd8XyXJKryvVbfXk8cpL
         OR88swWg2M6xixyjhYx7GYxLbaXtlm3sdodgpS/w=
Received: from localhost.localdomain ([111.60.247.106])
        by newxmesmtplogicsvrszc2-1.qq.com (NewEsmtp) with SMTP
        id 37731CEB; Wed, 11 Jan 2023 22:13:55 +0800
X-QQ-mid: xmsmtpt1673446435t2vx4gzx7
Message-ID: <tencent_D178F84C6D097A3CB089BB3F7FD45C67B406@qq.com>
X-QQ-XMAILINFO: ONLymQk6scaO6hvmk8/TxESbge0m43Ptvb4kt/ty8040BWjBTDdu2uA3PE8Vfp
         43jjvlRjKcvarrCyZCsPgwqZC4ieGNwLRuyoP5VFmbKHrO9ZUbHU7SaVlZWjFbs3D7yT/fP9zTN0
         xur+9WF6KedPhRUwaVS90aNo164yJUvy6S6q+juGFqea47E/fTtQjhGBa2SQPUfc/i1qu3nEIGmD
         cNJ3uElwm30D1hrvk8Ess88zaUD0/t1olCOSpPmttj2cF0jhqO6ikvHKpykPXgUeDLuzU6pwaycu
         z7m9arrwrJGzUf8GgxSWweXK0eshDUoQCvmdIlIBnkJiJb4KaehqM/yW/0YCKGdEpjFmAujzfYzA
         Dt6rHsXJXeXMTkKq6lcwgl/rZ+dYfDVTueHctuD9iXPoxY1k1RowjhdTqLdFDVVhkVbdv4+cwHtv
         /zJ4/bCDQJ5NJ/NHFWbiODuj631ZOyFZUPL9hUK0dxtBt/JPsXiYeiQvk0ajTdlOBgKIY1dePIIR
         1qOCFNevR0wSfOmRG4rIKrkSm8/cUb54QbBJN+6i4odW5IMgXHjkl/wmrd5loeoJz317XhhpNQLc
         pEUddzJD6iKLMfl4E/lYnvBz+9Ng8vSq+Hh3cqEtme44P80wv7wdl8+HgLUHUaC1S+M6D/oj9BQY
         Er0taDksV3YJjE2186eM0NBCqD8+ynZOsNwfuFTK1MWNetzzxTcKVKnay+oS0w7qOX3ELFAwkUl9
         K+JkZbc4orlizFPvWG80nY/FR2nXjr5mEizuhXdTWDxl2gN0jw8Ua3nFC6x93ySGbcJp5W955q0U
         h7LUCmGEbCRlRyNN/IFducVfsCNpEaEriI66ZyG+6aGitdazgu2wwR2/5Gh8T0yHb8Sz0uAmPJSd
         ggTQU2toko8iXDLXiT/FEV3z5kNDAWLeSVLYgc7XGlv7tUHPW870HXR1Dcn027J+uyqebwehrg6I
         mS0YfSUhfARSPk40kqT1R/Qmgcggs4DnOBVrOPphUPbWH4ngOA0TXgKx3/4E6Y
From:   Yang Xiwen <forbidden405@foxmail.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Jaime Breva <jbreva@nayarsystems.com>,
        Nikita Travkin <nikita@trvn.ru>,
        ~postmarketos/upstreaming@lists.sr.ht,
        Yang Xiwen <forbidden405@foxmail.com>
Subject: [PATCH v2 0/3] Support for MSM8916-based UFi ufi001c and uf896
Date:   Wed, 11 Jan 2023 22:13:08 +0800
X-OQ-MSGID: <20230111141311.14682-1-forbidden405@foxmail.com>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,HELO_DYNAMIC_IPADDR,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        RDNS_DYNAMIC,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Managed to get the real vendor for these devices.

Yang Xiwen (3):
  dt-bindings: vendor-prefixes: add thwc
  dt-bindings: qcom: Document msm8916-thwc-uf896 and ufi001c
  arm64: dts: qcom: msm8916-thwc: Add initial device tree for Tong Heng
    Wei Chuang Wifi/LTE dongle UFI-001C and uf896

 .../devicetree/bindings/arm/qcom.yaml         |   2 +
 .../devicetree/bindings/vendor-prefixes.yaml  |   2 +
 arch/arm64/boot/dts/qcom/Makefile             |   2 +
 .../boot/dts/qcom/msm8916-thwc-uf896.dts      |  41 +++
 .../boot/dts/qcom/msm8916-thwc-ufi001c.dts    |  39 +++
 arch/arm64/boot/dts/qcom/msm8916-ufi.dtsi     | 246 ++++++++++++++++++
 6 files changed, 332 insertions(+)
 create mode 100644 arch/arm64/boot/dts/qcom/msm8916-thwc-uf896.dts
 create mode 100644 arch/arm64/boot/dts/qcom/msm8916-thwc-ufi001c.dts
 create mode 100644 arch/arm64/boot/dts/qcom/msm8916-ufi.dtsi

-- 
2.39.0

