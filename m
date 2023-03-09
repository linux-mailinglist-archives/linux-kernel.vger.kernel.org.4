Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D070A6B280F
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 16:01:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232108AbjCIPBb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 10:01:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232112AbjCIPBE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 10:01:04 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CEBC62DB2;
        Thu,  9 Mar 2023 06:57:46 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 8FDCDCE2441;
        Thu,  9 Mar 2023 14:57:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE7DEC433EF;
        Thu,  9 Mar 2023 14:57:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678373862;
        bh=lrCJhGy31REAFHmpoQYpEnNmpg1BxinPjcIzS4zLQwc=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=dwRK5TvFHEOjFA1gJxyzNNpaoZTlAyUA24jtVNCJCjO9bjjEnNS6Hzvbcwkj5rQ7U
         x6Aj/t6wb89PkNSrXXWha6lDESk8LQoGk/CTDCYQLZwj8b3CvyX9QknJmnWxAvCOEC
         dxB5eqLSRu9mRE0aKKL2AIrXGlKd7GIjoXdt9/Ou3bFB+NHs9VsMnOedyDU6C8Ub4V
         Z6MCKmDWKg0KGlhceC4CSE5Rlyy5SG+LNT4ZMFQHR2yeMUeOlBzJR8OmFEfFRxLrVl
         Wbn3CWxeMXstVI9B3TDgUR+0fwHdclevSCbytb0fwuwmsO3z2p72+4iB/kJ1UFhCVT
         qOAS9y0fJKdhg==
Message-ID: <50c2b5de-4aed-ebd5-86e9-55813e740869@kernel.org>
Date:   Thu, 9 Mar 2023 15:57:36 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v1 2/4] Revert "dt-bindings: mmc: Add bindings for Intel
 Thunder Bay SoC"
Content-Language: en-US
To:     Adrian Hunter <adrian.hunter@intel.com>, rashmi.a@intel.com,
        ulf.hansson@linaro.org, michal.simek@xilinx.com,
        linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        robh+dt@kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, kishon@ti.com, vkoul@kernel.org,
        andriy.shevchenko@linux.intel.com, linux-phy@lists.infradead.org,
        mgross@linux.intel.com
Cc:     kris.pan@linux.intel.com, mahesh.r.vaidya@intel.com,
        nandhini.srikandan@intel.com, vasavi.v.itha@intel.com,
        kenchappa.demakkanavar@intel.com, furong.zhou@intel.com,
        mallikarjunappa.sangannavar@intel.com
References: <20230124054427.28808-1-rashmi.a@intel.com>
 <20230124054427.28808-2-rashmi.a@intel.com>
 <c850df25-57b8-3172-8e5c-c466dc8556cd@kernel.org>
 <ef2f8faf-76cc-d221-8281-cc7b8cb68485@intel.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
In-Reply-To: <ef2f8faf-76cc-d221-8281-cc7b8cb68485@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/03/2023 15:12, Adrian Hunter wrote:
> On 24/01/23 13:31, Krzysztof Kozlowski wrote:
>> On 24/01/2023 06:44, rashmi.a@intel.com wrote:
>>> From: "A, Rashmi" <rashmi.a@intel.com>
>>>
>>> This reverts commit ab991c05c42853f0b6110022db9bf30fcc6323dd.
>>
>> Please use scripts/get_maintainers.pl to get a list of necessary people
>> and lists to CC.  It might happen, that command when run on an older
>> kernel, gives you outdated entries.  Therefore please be sure you base
>> your patches on recent Linux kernel.
>>
>>>
>>> Revert Thunder Bay specific code as the product got cancelled
>>> and there are no end customers.
>>>
>>> Signed-off-by: A, Rashmi <rashmi.a@intel.com>
>>> Reviewed-by: Hunter, Adrian <adrian.hunter@intel.com>wq
>>
>> Stray characters.
>>
>>> ---
>>>  .../devicetree/bindings/mmc/arasan,sdhci.yaml | 25 -------------------
>>>  1 file changed, 25 deletions(-)
>>>
>>> diff --git a/Documentation/devicetree/bindings/mmc/arasan,sdhci.yaml b/Documentation/devicetree/bindings/mmc/arasan,sdhci.yaml
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
>> Instead should be made rather deprecated, unless you are sure there is
>> no single person in the world using the bindings (e.g. with BSD or
>> bootloader)?
> 
> I am sorry but this is not clear to me.  As I understand it,
> the hardware was never released, so the binding serves no
> purpose.  Should it be removed or "deprecated"?

Hm, commit msg said cancelled and I understood that it was released and
then got cancelled. But indeed maybe just remove it.

Best regards,
Krzysztof

