Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C47B96B1BCD
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 07:49:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230229AbjCIGt3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 01:49:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229799AbjCIGt0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 01:49:26 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3734178C87;
        Wed,  8 Mar 2023 22:49:25 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C6831B81E6D;
        Thu,  9 Mar 2023 06:48:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4FF3C433D2;
        Thu,  9 Mar 2023 06:48:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678344532;
        bh=AJVfjSxXcYK0gQiUUxvO9djvnoPGcPdXxAgjdYlMoLk=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=TfjM3ykd05WNsNTCgGh4gwUq7zCRq+j6JJ0315QgdeNERLSm1dn7L8sIK3V9nY+Gb
         uO//nBDv6sfLYL/iM4aAlL9YssJq54H55HmqKv1RZ8hiCLCycpwU5CaTaFsAdU0WbG
         ARgAeoMuy40GvRqD1IKYaFkgD8GZa+XCIhybyEQRz6YTJK+d0AIkyABDrNtB9+Pi1u
         pE53NHKpMQ5GAzUDIVWbpy8yQoZYsKUnOuIqLOHIZLAIvQjB1ZeK4NnD45hmXnLUMJ
         v1Yk/Fmjsqdtdv6WeW09srlYBOgbL45dEz7+8yDYW09bqouD9znIZBw1jU0v20IAQ+
         +stcs56nyHHWw==
Message-ID: <f2a11482-e5b4-027b-ba06-4d1302b658c3@kernel.org>
Date:   Thu, 9 Mar 2023 07:48:45 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v1 2/4] Revert "dt-bindings: mmc: Add bindings for Intel
 Thunder Bay SoC"
Content-Language: en-US
To:     "A, Rashmi" <rashmi.a@intel.com>,
        "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
        "michal.simek@xilinx.com" <michal.simek@xilinx.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kishon@ti.com" <kishon@ti.com>,
        "vkoul@kernel.org" <vkoul@kernel.org>,
        "andriy.shevchenko@linux.intel.com" 
        <andriy.shevchenko@linux.intel.com>,
        "linux-phy@lists.infradead.org" <linux-phy@lists.infradead.org>,
        "mgross@linux.intel.com" <mgross@linux.intel.com>
Cc:     "kris.pan@linux.intel.com" <kris.pan@linux.intel.com>,
        "Hunter, Adrian" <adrian.hunter@intel.com>,
        "Vaidya, Mahesh R" <mahesh.r.vaidya@intel.com>,
        "Srikandan, Nandhini" <nandhini.srikandan@intel.com>,
        "Itha, Vasavi V" <vasavi.v.itha@intel.com>,
        "Demakkanavar, Kenchappa" <kenchappa.demakkanavar@intel.com>,
        "Zhou, Furong" <furong.zhou@intel.com>,
        "Sangannavar, Mallikarjunappa" 
        <mallikarjunappa.sangannavar@intel.com>
References: <20230124054427.28808-1-rashmi.a@intel.com>
 <20230124054427.28808-2-rashmi.a@intel.com>
 <c850df25-57b8-3172-8e5c-c466dc8556cd@kernel.org>
 <DM6PR11MB306560B02E22BC934A6BFD1F8CB59@DM6PR11MB3065.namprd11.prod.outlook.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
In-Reply-To: <DM6PR11MB306560B02E22BC934A6BFD1F8CB59@DM6PR11MB3065.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/03/2023 07:43, A, Rashmi wrote:
>>
>>> ---
>>>  .../devicetree/bindings/mmc/arasan,sdhci.yaml | 25
>>> -------------------
>>>  1 file changed, 25 deletions(-)
>>>
>>> diff --git a/Documentation/devicetree/bindings/mmc/arasan,sdhci.yaml
>>> b/Documentation/devicetree/bindings/mmc/arasan,sdhci.yaml
>>> index 4053de758db6..0d5d21dd30bb 100644
>>> --- a/Documentation/devicetree/bindings/mmc/arasan,sdhci.yaml
>>> +++ b/Documentation/devicetree/bindings/mmc/arasan,sdhci.yaml
>>> @@ -88,12 +88,6 @@ properties:
>>>          description:
>>>            For this device it is strongly suggested to include
>>>            arasan,soc-ctl-syscon.
>>> -      - items:
>>> -          - const: intel,thunderbay-sdhci-5.1   # Intel Thunder Bay eMMC PHY
>>> -          - const: arasan,sdhci-5.1
>>
>> Instead should be made rather deprecated, unless you are sure there is no single
>> person in the world using the bindings (e.g. with BSD or bootloader)?
> May I know what has to be done in order to deprecate the complete patchset?

deprecated: true

(git grep for examples)

Best regards,
Krzysztof

