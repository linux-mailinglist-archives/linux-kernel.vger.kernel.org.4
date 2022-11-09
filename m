Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB5146232B7
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 19:41:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231401AbiKISlk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 13:41:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231348AbiKISlO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 13:41:14 -0500
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 418112B638;
        Wed,  9 Nov 2022 10:41:08 -0800 (PST)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 2A9IewrO049194;
        Wed, 9 Nov 2022 12:40:58 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1668019258;
        bh=QiOpBj3dhDmiDUOHhk0+32U4Qls8ez/CjB61jc9c00Q=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=Is+Sy5hSudCgBXAsQJ2MMQheVhSWezyMP3WNR85hoIvY41RRk9xFatvnZg62rR564
         eH9GGd8JcOW2v/lc3daYs1bJzn4P1LnZ9jRKumNSIJz6BzakZuTli0s0u78BQ/Fh4F
         FtgAC7io1xAskks0mrX5NBJROkwUX7057M1CwR2c=
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 2A9IewmG085102
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 9 Nov 2022 12:40:58 -0600
Received: from DFLE112.ent.ti.com (10.64.6.33) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6; Wed, 9 Nov
 2022 12:40:58 -0600
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6 via
 Frontend Transport; Wed, 9 Nov 2022 12:40:58 -0600
Received: from [128.247.81.39] (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 2A9IewQp006831;
        Wed, 9 Nov 2022 12:40:58 -0600
Message-ID: <08d41457-9405-b869-4b11-6c93e504bd03@ti.com>
Date:   Wed, 9 Nov 2022 12:40:58 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH v2 0/2] AM57x EVM Device Tree Overlays
Content-Language: en-US
To:     Tony Lindgren <tony@atomide.com>, Rob Herring <robh+dt@kernel.org>
CC:     =?UTF-8?Q?Beno=c3=aet_Cousson?= <bcousson@baylibre.com>,
        Nishanth Menon <nm@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        <linux-omap@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20221101221110.17885-1-afd@ti.com> <Y2tlXVA6CH/aSzeK@atomide.com>
From:   Andrew Davis <afd@ti.com>
In-Reply-To: <Y2tlXVA6CH/aSzeK@atomide.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/9/22 2:31 AM, Tony Lindgren wrote:
> Hi Andrew & Rob,
> 
> * Andrew Davis <afd@ti.com> [221102 00:01]:
>> Hello all,
>>
>> These is an uncontroversial (hopefully) DT Overlay to support the
>> TI AM57x EVM. More complex cases are staged and ready to follow but
>> wanted to test the water with this one.
>>
>> For some reason dtbs_check does not get run on overlays, this
>> will need further investigation to fix in kbuild. For now I ran
>> it through manually but am not 100% sure it actually checked it,
>> so double checks here very welcome.
>>
>> Series depends on https://www.spinics.net/lists/kernel/msg4548509.html
> 
> Looks like we now have commit 26c9134a370a ("Merge branch 'dt/dtbo-rename'
> into dt/next") in Linux next.
> 
> Can these two patches now be applied if I merge in the commit above?
> 

26c9134a370a is the same (v2) as the series (v1) I pointed to in the
commit message. This series works on top of either.

Thanks,
Andrew

> Regards,
> 
> Tony
