Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D2D763EFAD
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 12:41:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230258AbiLALlZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 06:41:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230308AbiLALlO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 06:41:14 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id DA6D19838A
        for <linux-kernel@vger.kernel.org>; Thu,  1 Dec 2022 03:41:10 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0104DD6E;
        Thu,  1 Dec 2022 03:41:17 -0800 (PST)
Received: from bogus (e103737-lin.cambridge.arm.com [10.1.197.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 78ABB3F73D;
        Thu,  1 Dec 2022 03:41:09 -0800 (PST)
Date:   Thu, 1 Dec 2022 11:41:07 +0000
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     =?utf-8?B?546L5rSq6L6J?= <honghui.wang@ucas.com.cn>
Cc:     Cristian Marussi <cristian.marussi@arm.com>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Subject: Re: =?utf-8?B?UmXvvJpSZTogW1BBVENIXW1haWxib3gvYXJtX3NjcGk6IEFk?=
 =?utf-8?Q?d?= to support Phytium FT2000/4 CPUs, show temperature of cpu.
Message-ID: <20221201114107.2ig6pdncekzlpdq2@bogus>
References: <tencent_2F6BF4F403D4DD764FD3D0BF@qq.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <tencent_2F6BF4F403D4DD764FD3D0BF@qq.com>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 01, 2022 at 06:41:46PM +0800, 王洪辉 wrote:
> In DTS of FT2000/4 passed from uboot. Add the DTS file to kernel?
>

No, I was referring to the binding not the DTS file like
Documentation/devicetree/bindings/firmware/arm,scpi.yaml

> Of course, it's also a good way to modify DTS file built in uboot.
>

You need to add the binding to make use of this new compatible in the driver.
And when you add, the first question I have is why you need new compatible
or why you can't use the generic one. If you have valid reasons for that,
then we can add the driver change along with the binding. Please split the
binding that you are about to add and the SCPI driver changes separate from
the mailbox driver changes in this patch.

-- 
Regards,
Sudeep
