Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEB216137E5
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Oct 2022 14:25:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230207AbiJaNZ5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Oct 2022 09:25:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231208AbiJaNZz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Oct 2022 09:25:55 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5181010059;
        Mon, 31 Oct 2022 06:25:54 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1A9621FB;
        Mon, 31 Oct 2022 06:26:00 -0700 (PDT)
Received: from bogus (unknown [10.57.6.137])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 297E63F703;
        Mon, 31 Oct 2022 06:25:51 -0700 (PDT)
Date:   Mon, 31 Oct 2022 13:25:23 +0000
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Cristian Marussi <cristian.marussi@arm.com>
Cc:     Guenter Roeck <linux@roeck-us.net>, linux-kernel@vger.kernel.org,
        Sudeep Holla <sudeep.holla@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        linux-hwmon@vger.kernel.org
Subject: Re: [PATCH v2 7/8] hwmon: (scmi) Register explicitly with Thermal
 Framework
Message-ID: <20221031132523.mfp7d5esk5hohldk@bogus>
References: <7acc7a49-debb-abdb-f01c-f8adef4c1f0e@roeck-us.net>
 <20221031114018.59048-1-cristian.marussi@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221031114018.59048-1-cristian.marussi@arm.com>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 31, 2022 at 11:40:18AM +0000, Cristian Marussi wrote:
> Available sensors are enumerated and reported by the SCMI platform server
> using a 16bit identification number; not all such sensors are of a type
> supported by hwmon subsystem and, among the supported ones, only a subset
> could be temperature sensors that have to be registered with the Thermal
> Framework.
> Potential clashes between hwmon channels indexes and the underlying real
> sensors IDs do not play well with the hwmon<-->thermal bridge automatic
> registration routines and could need a sensible number of fake dummy
> sensors to be made up in order to keep indexes and IDs in sync.
> 
> Avoid to use the hwmon<-->thermal bridge dropping the HWMON_C_REGISTER_TZ
> attribute and instead explicit register temperature sensors directly with
> the Thermal Framework.
>

Hi Guenter,

FWIW from scmi perspective,

Acked-by: Sudeep Holla <sudeep.holla@arm.com>

I was about to ask for your ack to pickup myself but I see there is no
strict dependency for that. Not sure if you want to take this as fix for
v6.1 as the thermal changes broke the existing support in SCMI hwmon
or do you still prefer v6.2 ?

-- 
Regards,
Sudeep
