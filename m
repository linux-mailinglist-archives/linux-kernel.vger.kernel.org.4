Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A39EC60CB4E
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 13:54:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230327AbiJYLyG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 07:54:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231229AbiJYLyA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 07:54:00 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 46E79F5CD2
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 04:53:59 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4D130D6E;
        Tue, 25 Oct 2022 04:54:05 -0700 (PDT)
Received: from bogus (e103737-lin.cambridge.arm.com [10.1.197.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E65A83F7B4;
        Tue, 25 Oct 2022 04:53:57 -0700 (PDT)
Date:   Tue, 25 Oct 2022 12:53:55 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Johan Hovold <johan+linaro@kernel.org>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] firmware/psci: demote suspend-mode warning to debug level
Message-ID: <20221025115355.26zrhmaudigumivn@bogus>
References: <20221024143417.11463-1-johan+linaro@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221024143417.11463-1-johan+linaro@kernel.org>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 24, 2022 at 04:34:17PM +0200, Johan Hovold wrote:
> On some Qualcomm platform, like SC8280XP, the attempt to set PC mode
> during boot fails with PSCI_RET_DENIED and since commit 998fcd001feb
> ("firmware/psci: Print a warning if PSCI doesn't accept PC mode") this
> is now logged at warning level:
>
> 	psci: failed to set PC mode: -3
>
> As there is nothing users can do about the firmware behaving this way,
> demote the warning to debug level.
>

As mentioned in the other thread I prefer to keep this as error as we
shouldn't mask this error and enable more/newer platforms to ignore it
when they can go and fix it. So I don't agree with this.

--
Regards,
Sudeep
