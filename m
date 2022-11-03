Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9994561776C
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 08:14:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230308AbiKCHOe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 03:14:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230348AbiKCHO1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 03:14:27 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2DB77E1B
        for <linux-kernel@vger.kernel.org>; Thu,  3 Nov 2022 00:14:27 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4409B1FB;
        Thu,  3 Nov 2022 00:14:33 -0700 (PDT)
Received: from usa.arm.com (e103737-lin.cambridge.arm.com [10.1.197.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 42F523F703;
        Thu,  3 Nov 2022 00:14:26 -0700 (PDT)
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     linux-kernel@vger.kernel.org,
        Cristian Marussi <cristian.marussi@arm.com>,
        linux-arm-kernel@lists.infradead.org
Cc:     Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH 8/8] arm64: dts: juno: Add Thermal critical trip points
Date:   Thu,  3 Nov 2022 07:14:21 +0000
Message-Id: <166745944966.2972112.9834987127508152225.b4-ty@arm.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221028140833.280091-8-cristian.marussi@arm.com>
References: <20221028140833.280091-8-cristian.marussi@arm.com>
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

On Fri, 28 Oct 2022 15:08:26 +0100, Cristian Marussi wrote:
> When thermnal zones are defined, trip points definitions are mandatory.
> Define a couple of critical trip points for monitoring of existing
> PMIC and SOC thermal zones.

> This was lost between txt to yaml conversion and was re-enforced recently
> via the commit 8c596324232d ("dt-bindings: thermal: Fix missing required property")
>
> [...]

Applied to sudeep.holla/linux (for-next/juno), thanks!

[8/8] arm64: dts: juno: Add Thermal critical trip points
      https://git.kernel.org/sudeep.holla/c/c4a7b9b587ca

--
Regards,
Sudeep

