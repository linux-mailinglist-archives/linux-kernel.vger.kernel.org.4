Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CBD16C0D90
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 10:42:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230045AbjCTJme (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 05:42:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230380AbjCTJmY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 05:42:24 -0400
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CD82149AA;
        Mon, 20 Mar 2023 02:42:23 -0700 (PDT)
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1peC1x-0001Q1-WE; Mon, 20 Mar 2023 10:42:18 +0100
Message-ID: <84540c66-166e-067a-e1d9-961234640d2e@leemhuis.info>
Date:   Mon, 20 Mar 2023 10:42:17 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH] media: i2c: imx290: fix conditional function defintions
Content-Language: en-US, de-DE
To:     Sakari Ailus <sakari.ailus@linux.intel.com>,
        Linux regressions mailing list <regressions@lists.linux.dev>
Cc:     Manivannan Sadhasivam <mani@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Alexander Stein <alexander.stein@ew.tq-group.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Dave Stevenson <dave.stevenson@raspberrypi.com>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Arnd Bergmann <arnd@kernel.org>
References: <20230207161316.293923-1-arnd@kernel.org>
 <Y+J+7lsf083k4x80@pendragon.ideasonboard.com>
 <c5383d0e-d33c-d59f-3ee6-4635c1c4d334@leemhuis.info>
 <ZBgoHvg3kxsVoSzg@kekkonen.localdomain>
From:   "Linux regression tracking (Thorsten Leemhuis)" 
        <regressions@leemhuis.info>
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
In-Reply-To: <ZBgoHvg3kxsVoSzg@kekkonen.localdomain>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1679305343;b7ccaf3b;
X-HE-SMSGID: 1peC1x-0001Q1-WE
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20.03.23 10:32, Sakari Ailus wrote:
> On Mon, Mar 20, 2023 at 10:18:23AM +0100, Linux regression tracking (Thorsten Leemhuis) wrote:
>> On 07.02.23 17:40, Laurent Pinchart wrote:
>>> On Tue, Feb 07, 2023 at 05:13:12PM +0100, Arnd Bergmann wrote:
>>>> From: Arnd Bergmann <arnd@arndb.de>
>>>>
>>>> The runtime suspend/resume functions are only referenced from the
>>>> dev_pm_ops, but they use the old SET_RUNTIME_PM_OPS() helper
>>>> that requires a __maybe_unused annotation to avoid a warning:
>>>>
>>>> drivers/media/i2c/imx290.c:1082:12: error: unused function 'imx290_runtime_resume' [-Werror,-Wunused-function]
>>>> static int imx290_runtime_resume(struct device *dev)
>>>>            ^
>>>> drivers/media/i2c/imx290.c:1090:12: error: unused function 'imx290_runtime_suspend' [-Werror,-Wunused-function]
>>>> static int imx290_runtime_suspend(struct device *dev)
>>>>            ^
>>>>
>>
>> I might be missing something (if so, please tell me), but to me it looks
>>  this fix for a build issue in 6.3-rc (which shows up in Guenters weekly
>> reports to Linus) didn't make any progress in the past few weeks. Is
>> there a reason why? Who actually needs to pick it up and send it towards
>> mainline? Manivannan Sadhasivam? Sakari Ailus?
> 
> Mauro has recently pulled my PR including this and I understand it's in
> Mauro's tree now.

Ahh, great, many thx.

I checked Linux-next before writing my mail, but didn't sport it there. :-/

Ciao, Thorsten
