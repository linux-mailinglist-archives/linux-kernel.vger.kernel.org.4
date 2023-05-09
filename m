Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 249526FC37B
	for <lists+linux-kernel@lfdr.de>; Tue,  9 May 2023 12:08:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234914AbjEIKIF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 May 2023 06:08:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235019AbjEIKHz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 May 2023 06:07:55 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id BADBE76BC;
        Tue,  9 May 2023 03:07:53 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F3F1B106F;
        Tue,  9 May 2023 03:08:37 -0700 (PDT)
Received: from usa.arm.com (e103737-lin.cambridge.arm.com [10.1.197.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 4977B3F67D;
        Tue,  9 May 2023 03:07:52 -0700 (PDT)
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Liviu Dudau <liviu.dudau@arm.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH] ARM: dts: vexpress: add missing cache properties
Date:   Tue,  9 May 2023 11:07:48 +0100
Message-Id: <168362502121.1113193.4942626039024445750.b4-ty@arm.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230423150837.118466-1-krzysztof.kozlowski@linaro.org>
References: <20230423150837.118466-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 23 Apr 2023 17:08:37 +0200, Krzysztof Kozlowski wrote:
> As all level 2 and level 3 caches are unified, add required
> cache-unified property to fix warnings like:
> 
>   vexpress-v2p-ca5s.dtb: cache-controller@2c0f0000: 'cache-unified' is a required property
> 

Applied to sudeep.holla/linux (for-next/juno/fixes), thanks!

[1/1] ARM: dts: vexpress: add missing cache properties
      https://git.kernel.org/sudeep.holla/c/328acc5657c6
--
Regards,
Sudeep

