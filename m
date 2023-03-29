Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 106816CD287
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 09:07:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229789AbjC2HG7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 03:06:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229772AbjC2HGx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 03:06:53 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1FE3213A;
        Wed, 29 Mar 2023 00:06:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9CA4DB820CB;
        Wed, 29 Mar 2023 07:06:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B52DC433EF;
        Wed, 29 Mar 2023 07:06:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680073575;
        bh=PzE8sNS2KtJjDlaMDX6p/pDK9kSnGtMNseNsxXQ4sRA=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=T0UsTiTwaUzh+hIGRhMywgGlH5MHIFwAjHgqYI2PTra/HJ5pebsbl4ygM7oxCfSyZ
         NfgwyAjrFLxJ/8tBsY5iZh5xxXOZo9I/vx9nsYmM03zKrPoBlmu75D3SneaTRj/eQr
         7Nqcvt9laupO0UCQt/zl3Rx9RH2jPdiGR0ptf4PVA9meNgYm/BF3zXasXUnq/ZVVDB
         r6Kj9y36dUvfesjs4YgPOHqBnCUTR/RiHk2mOHfRCEe5iukrlVvHD0wXduEFouBwJg
         FvCkjZUpm3+HBq/lzjunpSGgz/duqwjyGzlzeVUm4f6pLYhawWpahem06q31UfpaRZ
         qX/wnc46RNEOA==
Message-ID: <f9352150-9d2f-71f7-fc60-bd09b6de0522@kernel.org>
Date:   Wed, 29 Mar 2023 10:06:11 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v2 2/2] arm64: dts: ti: k3-am625-sk: Enable Type-C port
 for USB0
Content-Language: en-US
To:     Nishanth Menon <nm@ti.com>
Cc:     vigneshr@ti.com, kristo@kernel.org, srk@ti.com,
        r-gunasekaran@ti.com, linux-arm-kernel@lists.infradead.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
References: <20230328124315.123778-1-rogerq@kernel.org>
 <20230328124315.123778-3-rogerq@kernel.org>
 <20230328131810.x2j6uvwzhniclvwf@evoke>
 <3bd6191c-caa4-15a8-92ad-17a07ec085e2@kernel.org>
 <20230328133024.ow6cvm22o2c5heem@untrimmed>
 <39cb4f8c-d10f-f543-ddca-8a8507757f4c@kernel.org>
 <20230328215234.ug7x34rjfiv7ixhi@trimness>
From:   Roger Quadros <rogerq@kernel.org>
In-Reply-To: <20230328215234.ug7x34rjfiv7ixhi@trimness>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 29/03/2023 00:52, Nishanth Menon wrote:
> On 22:46-20230328, Roger Quadros wrote:
> [...]
>>>>> 	How about sk-lp ?
>>>>
>>>> moved it to sk-lp. see above in this patch.
>>>>
>>>
>>> A bit confused. Looking at [1] vs [2], it seems to indicate pd controller at
>>> 0x3f as well? Am I misreading the schematics?
>>>
>>> [1] https://www.ti.com/tool/SK-AM62-LP#design-files
>>> [2] https://www.ti.com/tool/SK-AM62#design-files
>>
>> Yes PD controller is at 0x3f for both boards but IRQ is not routed on AM62-LP.
>> I tried to explain this the cover letter. ;)
>>
>> Pasting here for convenience.
>>
>>> Although k3-am625-lp-sk USB is exactly the same as on k3-am625-sk,
>>> it is missing the IRQ line from Type-C chip which is currently
>>> required as per chip's DT binding. So we don't add Type-C support
>>> for k3-am625-lp-sk till h/w is fixed or polling mode support for
>>> Type-C chip is accepted [2]
>>>
>>> [2] - https://lore.kernel.org/lkml/20230324133741.43408-1-rogerq@kernel.org/T/
> 
> Thanks, This thread does seem to be progressing? Since LP-SK is already
> in production, it might do good to hold on to this series a little
> longer instead of shuttling dts nodes back and forth.
> 

I agree. This will need a re-spin.

cheers,
-roger
