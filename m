Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 446AA62CC4A
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 22:08:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233114AbiKPVI2 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 16 Nov 2022 16:08:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239272AbiKPVH7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 16:07:59 -0500
Received: from relay01.th.seeweb.it (relay01.th.seeweb.it [IPv6:2001:4b7a:2000:18::162])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C88C5CD0A
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 13:07:29 -0800 (PST)
Received: from [127.0.0.1] (bband-dyn193.178-41-216.t-com.sk [178.41.216.193])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by m-r1.th.seeweb.it (Postfix) with ESMTPSA id 569622009F;
        Wed, 16 Nov 2022 22:07:27 +0100 (CET)
Date:   Wed, 16 Nov 2022 22:07:25 +0100
From:   Martin Botka <martin.botka@somainline.org>
To:     Lee Jones <lee@kernel.org>
CC:     martin.botka1@gmail.com, ~postmarketos/upstreaming@lists.sr.ht,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        Jami Kettunen <jamipkettunen@somainline.org>,
        Paul Bouchara <paul.bouchara@somainline.org>,
        Yenda <jtrmal@gmail.com>, Chen-Yu Tsai <wens@csie.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] mfd: ax20x: Add suppport for AXP1530 PMIC
User-Agent: K-9 Mail for Android
In-Reply-To: <Y3UGc//UuuinJcbE@google.com>
References: <20221114162334.1801137-1-martin.botka@somainline.org> <Y3UGc//UuuinJcbE@google.com>
Message-ID: <671D1BC5-589B-4AFF-B026-1810F48522FD@somainline.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On November 16, 2022 4:49:07 PM GMT+01:00, Lee Jones <lee@kernel.org> wrote:
>On Mon, 14 Nov 2022, Martin Botka wrote:
>
>> AXP1530 is a PMIC chip produced by X-Powers and an be connected via
>> I2C or RSB bus.
>> Where AXP313A seems to be closely related so the same driver can be used and
>> seen it only paired with H616 SoC.
>> 
>> Signed-off-by: Martin Botka <martin.botka@somainline.org>
>> ---
>>  drivers/mfd/axp20x-i2c.c   |  2 ++
>>  drivers/mfd/axp20x-rsb.c   |  1 +
>>  drivers/mfd/axp20x.c       | 63 ++++++++++++++++++++++++++++++++++++++
>>  include/linux/mfd/axp20x.h | 34 ++++++++++++++++++++
>>  4 files changed, 100 insertions(+)
>
>No major concerns.
>
>> +static struct mfd_cell axp1530_cells[] = {
>> +	{
>> +		.id = 0,
>> +		.name = "axp20x-regulator",
>> +	},
>> +};
>
>Why .id = 0?
>

Oh good eye. Yea thats just left over. Will be removed in V2 :) 
