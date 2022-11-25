Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F665638ECA
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Nov 2022 18:06:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230059AbiKYRGO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Nov 2022 12:06:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230053AbiKYRGB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Nov 2022 12:06:01 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9123247333;
        Fri, 25 Nov 2022 09:06:00 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E0C3C2B;
        Fri, 25 Nov 2022 09:06:06 -0800 (PST)
Received: from usa.arm.com (e103737-lin.cambridge.arm.com [10.1.197.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 23E203F73B;
        Fri, 25 Nov 2022 09:05:59 -0800 (PST)
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     devicetree@vger.kernel.org,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org,
        Liviu Dudau <liviu.dudau@arm.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH] ARM: dts: vexpress: align LED node names with dtschema
Date:   Fri, 25 Nov 2022 17:05:57 +0000
Message-Id: <166939568022.1879157.7297800855222309879.b4-ty@arm.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221125144112.476817-1-krzysztof.kozlowski@linaro.org>
References: <20221125144112.476817-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 25 Nov 2022 15:41:12 +0100, Krzysztof Kozlowski wrote:
> The node names should be generic and DT schema expects certain pattern.
> 
>   vexpress-v2p-ca9.dtb: leds: 'user1', 'user2', 'user3', 'user4', 'user5', 'user6', 'user7', 'user8' do not match any of the regexes: '(^led-[0-9a-f]$|led)', 'pinctrl-[0-9]+'
>
> 

Applied to sudeep.holla/linux (for-next/juno), thanks!

[1/1] ARM: dts: vexpress: align LED node names with dtschema
      https://git.kernel.org/sudeep.holla/c/e15031539490
--
Regards,
Sudeep

