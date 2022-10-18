Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCDB7602C87
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 15:10:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230106AbiJRNKj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 09:10:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229978AbiJRNKd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 09:10:33 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27D20BE51C;
        Tue, 18 Oct 2022 06:10:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id BA061B81D4A;
        Tue, 18 Oct 2022 13:10:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D1FEC433B5;
        Tue, 18 Oct 2022 13:10:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666098629;
        bh=dfF8FcI2saLIqjZTG/1sKDixOK6GGspv5xgMbrwZw3I=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=LNW6xM7esjCexiaXs9p/5BEptbQUNkxAHuOdxcj9oW2pqTbTnXJVXwrHc+QIYxx4b
         t15jDmjVRJhPB+RAif+jgHWKP24++XleqxiUenTee6KvvK7U/kc9+hrQ8ODvgFNg0i
         vrUPs0VLIIvSdE8Ow8ApqjBQac2u4iHyBrv3qXcfijXOScPa49AuY7hCS6RDlhXemR
         KU9pLFB14gXhUesIycJYLo+tfn6p73kRDI4FLeQP/MW5poCnS0rMU/Rt6/20v6I5LA
         /A0Yz3FnjVPgDR1oGVfvBZL4mdj0pwZEaWkGjLwbPdxtECAkvX7jMgDC76eygfLubj
         ZQa+PHrnTRWnA==
Message-ID: <1b079ee2-d406-507c-77f9-a228d337ad71@kernel.org>
Date:   Tue, 18 Oct 2022 09:10:23 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [Patch v3 01/15] dt-bindings: media: s5p-mfc: Add new DT schema
 for MFC
Content-Language: en-US
To:     Aakarsh Jain <aakarsh.jain@samsung.com>,
        'Rob Herring' <robh@kernel.org>
Cc:     linux-fsd@tesla.com, linux-media@vger.kernel.org,
        pankaj.dubey@samsung.com, linux-arm-kernel@lists.infradead.org,
        dillon.minfei@gmail.com, devicetree@vger.kernel.org,
        krzk+dt@kernel.org, smitha.t@samsung.com,
        benjamin.gaignard@collabora.com, stanimir.varbanov@linaro.org,
        jernej.skrabec@gmail.com, robh+dt@kernel.org,
        aswani.reddy@samsung.com, mchehab@kernel.org,
        hverkuil-cisco@xs4all.nl, mark.rutland@arm.com,
        m.szyprowski@samsung.com, linux-kernel@vger.kernel.org,
        alim.akhtar@samsung.com, andi@etezian.org, andrzej.hajda@intel.com,
        ezequiel@vanguardiasur.com.ar, david.plowman@raspberrypi.com
References: <20221011122516.32135-1-aakarsh.jain@samsung.com>
 <CGME20221011125142epcas5p13c858a5f27830fb1de50fa51e9730eca@epcas5p1.samsung.com>
 <20221011122516.32135-2-aakarsh.jain@samsung.com>
 <166558064414.1937173.2124012536890566845.robh@kernel.org>
 <000501d8e2df$3d209700$b761c500$@samsung.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
In-Reply-To: <000501d8e2df$3d209700$b761c500$@samsung.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/10/2022 06:48, Aakarsh Jain wrote:
>>
>> codec@f1700000: clock-names:1: 'sclk_mfc' was expected
>> 	arch/arm/boot/dts/s5pv210-aquila.dtb
>> 	arch/arm/boot/dts/s5pv210-fascinate4g.dtb
>> 	arch/arm/boot/dts/s5pv210-galaxys.dtb
>> 	arch/arm/boot/dts/s5pv210-goni.dtb
>> 	arch/arm/boot/dts/s5pv210-smdkc110.dtb
>> 	arch/arm/boot/dts/s5pv210-smdkv210.dtb
>> 	arch/arm/boot/dts/s5pv210-torbreck.dtb
>>
>> codec@f1700000: memory-region: [[51], [52]] is too long
>> 	arch/arm/boot/dts/s5pv210-fascinate4g.dtb
>>
>> codec@f1700000: memory-region: [[55], [56]] is too long
>> 	arch/arm/boot/dts/s5pv210-galaxys.dtb
> 
> 
> 
> Hi Rob,
> 
> We tried reproducing warnings as reported above, but I am not able to see
> these warnings after  running make dtbs_check & make DT_CHECKER_FLAGS=-m
> dt_binding_check.
> Packages used-
> yamllint 1.10.0
> $ dt-mk-schema --version
> 2022.9


Are you sure you are running these commands on proper config and arch?

Best regards,
Krzysztof

