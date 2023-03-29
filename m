Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 931DB6CD913
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 14:05:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229957AbjC2MFg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 08:05:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229652AbjC2MFV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 08:05:21 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D6D2049F1;
        Wed, 29 Mar 2023 05:05:09 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B5DAB1FB;
        Wed, 29 Mar 2023 05:05:53 -0700 (PDT)
Received: from bogus (unknown [10.57.52.160])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 42F203F6C4;
        Wed, 29 Mar 2023 05:05:06 -0700 (PDT)
Date:   Wed, 29 Mar 2023 13:04:32 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Cristian Marussi <cristian.marussi@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-pm@vger.kernel.org, james.quinlan@broadcom.com,
        Jonathan.Cameron@huawei.com, f.fainelli@gmail.com,
        vincent.guittot@linaro.org, tarek.el-sherbiny@arm.com,
        nicola.mazzucato@arm.com, souvik.chakravarty@arm.com,
        wleavitt@marvell.com, wbartczak@marvell.com
Subject: Re: [PATCH v2 1/3] firmware: arm_scmi: Refactor powercap get/set
 helpers
Message-ID: <20230329120432.ao36v536sdwqi6e5@bogus>
References: <20230309140724.2152712-1-cristian.marussi@arm.com>
 <20230309140724.2152712-2-cristian.marussi@arm.com>
 <CAJZ5v0ixFvJ6akSMZmcUsg1n_kufq_WonWhS+ef=ps1FXKqUGQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJZ5v0ixFvJ6akSMZmcUsg1n_kufq_WonWhS+ef=ps1FXKqUGQ@mail.gmail.com>
X-Spam-Status: No, score=-2.3 required=5.0 tests=RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 27, 2023 at 07:06:36PM +0200, Rafael J. Wysocki wrote:
> On Thu, Mar 9, 2023 at 3:09 PM Cristian Marussi
> <cristian.marussi@arm.com> wrote:
> >
> > Refactor SCMI powercap internal get/set helpers.
> >
> > Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
> 
> I can apply this series if I get an ACK or preferably Reviewed-by:
> from an SCMI person.
>

Sorry, I had looked at this and just delayed asking you about your preference.
I am fine to take it or else

Reviewed-by: Sudeep Holla <sudeep.holla@arm.com> (for SCMI parts)

Please ack 3/3 if you prefer me to take it once you are happy with it.

-- 
Regards,
Sudeep
