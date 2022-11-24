Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BFD5637832
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Nov 2022 12:57:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230173AbiKXL5N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Nov 2022 06:57:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229563AbiKXL5M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Nov 2022 06:57:12 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 094AAC6611
        for <linux-kernel@vger.kernel.org>; Thu, 24 Nov 2022 03:57:11 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 47C2223A;
        Thu, 24 Nov 2022 03:57:17 -0800 (PST)
Received: from bogus (e103737-lin.cambridge.arm.com [10.1.197.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 03C543F73D;
        Thu, 24 Nov 2022 03:57:09 -0800 (PST)
Date:   Thu, 24 Nov 2022 11:57:07 +0000
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     =?utf-8?B?546L5rSq6L6J?= <honghui.wang@ucas.com.cn>
Cc:     Cristian Maruss <cristian.marussi@arm.com>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: =?utf-8?B?UmXvvJpSZQ==?= =?utf-8?Q?=3A?= [PATCH 3/3] arm_scpi:
 modify to support acpi
Message-ID: <20221124115707.e5hsb5we25rzstv6@bogus>
References: <tencent_6578975367ED7DB20B7903C3@qq.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <tencent_6578975367ED7DB20B7903C3@qq.com>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Wang,


Please use text for your emails. I think it is html and I can't read it.

On Thu, Nov 24, 2022 at 07:17:32PM +0800, 王洪辉 wrote:
> For&nbsp;ARM64,&nbsp;If&nbsp;boot&nbsp;from&nbsp;uefi,&nbsp;SCPI&nbsp;driver&nbsp;should&nbsp;support&nbsp;ACPI&nbsp;to&nbsp;show&nbsp;CPU&nbsp;temp&nbsp;&amp;&nbsp;freq,&nbsp;This&nbsp;patch&nbsp;is&nbsp;for&nbsp;the&nbsp;case,&nbsp;I&nbsp;had&nbsp;test&nbsp;ok&nbsp;on&nbsp;Phytium&nbsp;FT2000/4&nbsp;plantform.&nbsp;And&nbsp;please&nbsp;append&nbsp;Patch&nbsp;V2&nbsp;3/3.
> 
> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;---原始邮件---
> 发件人:&quot;Sudeep&nbsp;Holla&quot;<sudeep.holla@arm.com&gt;
> 发送时间:2022年11月24日(星期四)&nbsp;晚上7:10
> 收件人:&quot;Wang&nbsp;Honghui&quot;<honghui.wang@ucas.com.cn&gt;;
> 主题:&nbsp;[PATCH&nbsp;3/3]&nbsp;arm_scpi:&nbsp;modify&nbsp;to&nbsp;support&nbsp;acpi
> Hi&nbsp;W&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
> ------------------&nbsp;Original&nbsp;------------------
> From:&nbsp;&quot;Sudeep Holla&quot;<sudeep.holla@arm.com&gt;
> Date:&nbsp;Thu, Nov 24, 2022 07:10 PM
> To:&nbsp;&quot;Wang Honghui&quot;<honghui.wang@ucas.com.cn&gt;;
> Cc:&nbsp;&quot;Cristian Maruss&quot;<cristian.marussi@arm.com&gt;;&quot;Jassi Brar&quot;<jassisinghbrar@gmail.com&gt;;&quot;Sudeep Holla&quot;<sudeep.holla@arm.com&gt;;&quot;linux-arm-kernel&quot;<linux-arm-kernel@lists.infradead.org&gt;;&quot;linux-kernel&quot;<linux-kernel@vger.kernel.org&gt;;
> Subject:&nbsp;Re: [PATCH 3/3] arm_scpi: modify to support acpi

Doing %s/&nbsp;/ /g gave me:

> For ARM64, If boot from uefi, SCPI driver should support ACPI to show CPU
> temp &amp; freq, This patch is for the case, I had test ok on Phytium
> FT2000/4 plantform. And please append Patch V2 3/3.

Let me repeat. You must use PCC driver without any phytium ft2000/4 platform
code. All platform specific code and SCPI protocol must be hidden/abstracted
in ACPI AML.

Your changes are not acceptable for upstream. No change will be allowed in
SCPI for ACPI as it needs to go in the firmware tables.

Also I noticed drivers/mailbox/phytium_mailbox.c doesn't exist. So this patch
is wrong in so many ways. Please check on how to represent phytium_mailbox
hardware using ACPI PCC and add AML code that uses SCPI to achieve whatever
you want. You may want to check on how to use PCC OpRegion as well in ACPI.

-- 
Regards,
Sudeep
