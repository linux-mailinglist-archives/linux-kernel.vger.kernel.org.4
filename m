Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD7296D4241
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 12:38:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231925AbjDCKiJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 06:38:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232011AbjDCKhp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 06:37:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EB3112CC6;
        Mon,  3 Apr 2023 03:36:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1B78B61892;
        Mon,  3 Apr 2023 10:35:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8271C433EF;
        Mon,  3 Apr 2023 10:35:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680518150;
        bh=85MRH2+l503eK5l0LF+Zu620qHQWK59g5PiItRKZf7o=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=vQ1L4qyC2EwczDh0CP3gVr5E26DwJseI8Wn/kWS+bfPXVaW3rObDtc5Ef8GiXJJBo
         7vuO9iaicULZ2EFMvk+3ynLlSamu1js7Pq4d7eMZs7Jy12Wv7vVquwIo8/bdZL0nWb
         faJClZhI3osujKIPXQ/uyOphCjelrme90RUdomY4x0t3cT33DpMn21HpTArKD8h3jT
         CipKiblzKuq6EdJLKQ+E5uy5Qyfdrr5ks3Yu2mhLmOaG3XM0SV2o+QPwAsu/aRFuks
         P03SYFS0gscfaNbV1KCGjo0pgy0xAVXqG1BUZPfR1aqQKCN+QUeoJffegbjP6k1U0K
         L7+wahKfknzhw==
Message-ID: <11d12eea-e70f-8bf8-ed1e-f82cf95a20ee@kernel.org>
Date:   Mon, 3 Apr 2023 12:35:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v3 1/2] dt-bindings: omap: Convert omap.txt to yaml
Content-Language: en-US
To:     Andreas Kemnade <andreas@kemnade.info>
Cc:     robh+dt@kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Tony Lindgren <tony@atomide.com>,
        Andrew Davis <afd@ti.com>
References: <20230401140248.3363674-1-andreas@kemnade.info>
 <20230401140248.3363674-2-andreas@kemnade.info>
 <3865a750-2cd1-c92f-8bd2-22dfeea43769@kernel.org>
 <20230403121813.55c8aa2a@aktux>
From:   Krzysztof Kozlowski <krzk@kernel.org>
In-Reply-To: <20230403121813.55c8aa2a@aktux>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/04/2023 12:18, Andreas Kemnade wrote:
> Hi,
> 
> On Sun, 2 Apr 2023 13:26:46 +0200
> Krzysztof Kozlowski <krzk@kernel.org> wrote:
> 
>> On 01/04/2023 16:02, Andreas Kemnade wrote:
>>> From: Andrew Davis <afd@ti.com>
>>>
>>> Convert omap.txt to yaml.
>>>
>>> Signed-off-by: Andrew Davis <afd@ti.com>
>>> [various cleanup, adding Epson Moverio BT-200]
>>> Signed-off-by: Andreas Kemnade <andreas@kemnade.info>  
>>
>> Please use scripts/get_maintainers.pl to get a list of necessary people
>> and lists to CC.  It might happen, that command when run on an older
>> kernel, gives you outdated entries.  Therefore please be sure you base
>> your patches on recent Linux kernel.
>>
>> Your CC list is broken in few ways. Just use the script, don't re-invent
>> the addresses.
>>
> well, I am using the script and added a few adresses obviously missing.

And one of them (omap@kernel) was invalid which made it impossible to
reply to you...


> But maybe I have used the script from an older kernel. The patch was against
> linux-next.
> 
> [...]
>>> +      - description: TI DRA7 SoC based platforms
>>> +        items:
>>> +          - enum:
>>> +              - ti,dra718-evm  
>>
>> This is not correct. Maybe you forgot to fix DTS, but anyway it's
>> confusing to have dra718-evm with dra768 SoC. Is this really proper
>> combination?
>>
> dra718-evm has a lot of compatibles, no idea if that is sane.
> And to better discuss such things I added the omap mailinglist (with a typo,
> sorry). To avoid that trouble in the future, I added a patch to MAINTAINERS.
> 
> But I think it is better to not convert dra7 stuff for now, then
> it can be discussed by the right people. 


Best regards,
Krzysztof

