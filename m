Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE2C160BD98
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 00:40:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231675AbiJXWkU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 18:40:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232288AbiJXWjX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 18:39:23 -0400
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F5AD2BABC9;
        Mon, 24 Oct 2022 14:02:58 -0700 (PDT)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 29OHTCDQ049088;
        Mon, 24 Oct 2022 12:29:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1666632552;
        bh=adanlXXMqLG7D31QcjsmCrsQK+NgdUg/Qpj94rrEAeU=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=wZ6kx/rxmTfZLpzb85qoPyFJuGrLRyJVzXE9zsj306a8JVTpvBdG9mn/i9+D7njp/
         MbFUm5gva2Xrccif3TKo1BCuUk0O7Hb0barGRNHf1HGn73rIisbTGkP8CyvXAtOtcj
         S1BjgNGuN4gKyPuT7zuUr1C0juPnegFa7h+eIB5s=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 29OHTC5C002438
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 24 Oct 2022 12:29:12 -0500
Received: from DFLE113.ent.ti.com (10.64.6.34) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6; Mon, 24
 Oct 2022 12:29:11 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6 via
 Frontend Transport; Mon, 24 Oct 2022 12:29:11 -0500
Received: from [10.250.34.50] (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 29OHTAUk033402;
        Mon, 24 Oct 2022 12:29:10 -0500
Message-ID: <f52c205c-477d-2135-afb7-d2f8be928185@ti.com>
Date:   Mon, 24 Oct 2022 12:29:10 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH 0/6] Rename DTB overlay source files
To:     Geert Uytterhoeven <geert@linux-m68k.org>
CC:     Shawn Guo <shawnguo@kernel.org>, Li Yang <leoyang.li@nxp.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Nishanth Menon <nm@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Frank Rowand <frowand.list@gmail.com>,
        <devicetree@vger.kernel.org>, <linux-kbuild@vger.kernel.org>,
        <linux-renesas-soc@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
References: <20221023182437.15263-1-afd@ti.com>
 <CAMuHMdVSeqcgj=ocY-9XAf9A312xBwdypBCNk-fsnh+bWiCtTg@mail.gmail.com>
Content-Language: en-US
From:   Andrew Davis <afd@ti.com>
In-Reply-To: <CAMuHMdVSeqcgj=ocY-9XAf9A312xBwdypBCNk-fsnh+bWiCtTg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/24/22 7:28 AM, Geert Uytterhoeven wrote:
> Hi Andrew,
> 
> On Sun, Oct 23, 2022 at 8:24 PM Andrew Davis <afd@ti.com> wrote:
>> This is a series based on my patch here[0]. As suggested by Rob
>> I've resurrected Frank's patch and appended it to mine as a series.
>>
>> First patch here is my original patch, 3rd is Frank's patch but with
>> the unittest changes pulled out into the 2nd patch. That was re-worked
>> moving the source building macro into scripts/Makefile.lib.
>>
>> Patches 4, 5, and 6 are an attempt at renaming all the existing DTB
>> overlays. Split out by platform so they could be taken by platform
>> maintainers or if easier ACK'd here and taken all together.
>>
>> This should cover all the DTB overlays so we can remove the old .dts
>> rule for overlays and make .dtso the only supported way, let me know
>> if we want that this cycle and I can post that too.
> 
> Thanks a lot for picking this up!
> 
> Everything builds still fine, and the OF unit tests still run fine, so
> Tested-by: Geert Uytterhoeven <geert+renesas@glider.be>
> 
> BTW, you missed the Smarthome-Wolf Pi433 overlay[1] and its
> documentation[2] under drivers/staging/, but perhaps that was
> intentional, as it is not tied into the build system?
> 

Wasn't really sure about that one, but it seems simple enough to rename,
will add a patch for that in v2. Will also fix the wording in the last
3 patches as suggested.

Thanks,
Andrew

> [1] drivers/staging/pi433/Documentation/devicetree/pi433-overlay.dts
> [2] drivers/staging/pi433/Documentation/devicetree/pi433.txt
> 
> Gr{oetje,eeting}s,
> 
>                          Geert
> 
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org
> 
> In personal conversations with technical people, I call myself a hacker. But
> when I'm talking to journalists I just say "programmer" or something like that.
>                                  -- Linus Torvalds
