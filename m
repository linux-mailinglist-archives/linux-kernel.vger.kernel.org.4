Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 083487243BB
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 15:08:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238018AbjFFNIC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 09:08:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238007AbjFFNIA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 09:08:00 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 52C3710EC;
        Tue,  6 Jun 2023 06:07:28 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7D50BC14;
        Tue,  6 Jun 2023 06:07:52 -0700 (PDT)
Received: from usa.arm.com (e103737-lin.cambridge.arm.com [10.1.197.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 331323F793;
        Tue,  6 Jun 2023 06:07:05 -0700 (PDT)
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-pm@vger.kernel.org,
        Cristian Marussi <cristian.marussi@arm.com>
Cc:     Sudeep Holla <sudeep.holla@arm.com>, james.quinlan@broadcom.com,
        Jonathan.Cameron@Huawei.com, f.fainelli@gmail.com,
        vincent.guittot@linaro.org, tarek.el-sherbiny@arm.com,
        nicola.mazzucato@arm.com, souvik.chakravarty@arm.com,
        wleavitt@marvell.com, wbartczak@marvell.com
Subject: Re: [PATCH v3 0/3] Add SCMI v3.2 Powercap disable support
Date:   Tue,  6 Jun 2023 14:07:00 +0100
Message-Id: <168605677582.2818698.14748743125850879874.b4-ty@arm.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230531152039.2363181-1-cristian.marussi@arm.com>
References: <20230531152039.2363181-1-cristian.marussi@arm.com>
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

On Wed, 31 May 2023 16:20:36 +0100, Cristian Marussi wrote:
> Upcoming SCMI v3.2 specification (publicly available as BETA at [1])
> introduces support to disable powercapping as a whole on the desired
> zones.
> 
> This small series at first add the needed support to the core SCMI Powercap
> protocol, exposing a couple more enable/disable protocol operations, and
> then wires such new ops in the related Powercap framework helpers.
> 
> [...]

Applied to sudeep.holla/linux (for-next/scmi/updates), thanks!

[1/3] firmware: arm_scmi: Refactor powercap get/set helpers
      https://git.kernel.org/sudeep.holla/c/4e1a53b4030e
[2/3] firmware: arm_scmi: Add Powercap protocol enable support
      https://git.kernel.org/sudeep.holla/c/758cd5fc13b2
[3/3] powercap: arm_scmi: Add support for disabling powercaps on a zone
      https://git.kernel.org/sudeep.holla/c/aaffb4cacd4c
--
Regards,
Sudeep

