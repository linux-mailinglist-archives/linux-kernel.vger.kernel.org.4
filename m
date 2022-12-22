Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B0A265410F
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Dec 2022 13:33:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235539AbiLVMdW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Dec 2022 07:33:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235449AbiLVMdF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Dec 2022 07:33:05 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5A43721E0F;
        Thu, 22 Dec 2022 04:32:56 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 60510AD7;
        Thu, 22 Dec 2022 04:33:37 -0800 (PST)
Received: from e126835.arm.com (unknown [10.57.87.234])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7FDB93FA32;
        Thu, 22 Dec 2022 04:32:53 -0800 (PST)
From:   Emekcan Aras <emekcan.aras@arm.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Liviu Dudau <liviu.dudau@arm.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Miguel Silva <rui.silva@linaro.org>
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Emekcan Aras <emekcan.aras@arm.com>
Subject: [PATCH v3 0/2] adds corstone500 device tree
Date:   Thu, 22 Dec 2022 12:32:42 +0000
Message-Id: <20221222123244.147238-1-emekcan.aras@arm.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adds device tree and correspondent binding for ARM Corstone500 reference 
solution. 

Thanks for the comments, and sorry for the late reply. Most of the comments are
addressed except one.

@Krzysztof Kozlowski: Thanks a lot for the comments. I've tried to fixed all of 
them. Just have one question regarding having no dtsi or compatible platform.
Corstone500 is a reference hardware design, however there is no silicon solution
from it yet. And from device tree perspective, both FPGA and FVP (virtual 
platform) implementations are identical(same addresses and same nodes, etc.).
So we didn't want to create a seperate dtsi file. What would you recommend here
? Can you point me to a device tree from a similar platform?

Cheers,
Emek

Emekcan Aras (2):
  arm: dts: arm: add arm corstone500 device tree
  dt-bindings: Add Arm corstone500 platform

 .../bindings/arm/arm,corstone500.yaml         |  30 +++
 arch/arm/boot/dts/Makefile                    |   3 +-
 arch/arm/boot/dts/corstone500.dts             | 182 ++++++++++++++++++
 3 files changed, 214 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/arm/arm,corstone500.yaml
 create mode 100644 arch/arm/boot/dts/corstone500.dts

-- 
2.25.1

