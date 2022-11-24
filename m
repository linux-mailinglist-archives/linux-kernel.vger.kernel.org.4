Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CC5D63773D
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Nov 2022 12:10:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229884AbiKXLKV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Nov 2022 06:10:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229863AbiKXLKT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Nov 2022 06:10:19 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 93D5A6F0CE
        for <linux-kernel@vger.kernel.org>; Thu, 24 Nov 2022 03:10:18 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DB2AA23A;
        Thu, 24 Nov 2022 03:10:24 -0800 (PST)
Received: from bogus (e103737-lin.cambridge.arm.com [10.1.197.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7B5703F587;
        Thu, 24 Nov 2022 03:10:17 -0800 (PST)
Date:   Thu, 24 Nov 2022 11:10:15 +0000
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Wang Honghui <honghui.wang@ucas.com.cn>
Cc:     Cristian Maruss <cristian.marussi@arm.com>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] arm_scpi: modify to support acpi
Message-ID: <20221124111015.vrfuroty4fbemqv7@bogus>
References: <F813BC8072CDDB25+Y38Yq2QKFefSupZV@TP-P15V.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <F813BC8072CDDB25+Y38Yq2QKFefSupZV@TP-P15V.lan>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Wang,

On Thu, Nov 24, 2022 at 03:09:31PM +0800, Wang Honghui wrote:
> arm_scpi: modify to support acpi
>

1. The commit message is pretty useless. I don't get the complete picture
   of why you need this change or what you are trying to do in this change.

2. I am unable to see the series as a whole, just have 2 versions of 3/3
   in my inbox.

3. This is not the correct way to use SCPI or mailbox in ACPI. You need
   to use PCC and PCC OpRegion to achieve what you want. The whole SCPI
   protocol details gets abstracted in the firmware(ACPI ASL)

Hope this helps. So in short, NACK for this approach for ACPI.

-- 
Regards,
Sudeep
