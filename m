Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACA5F74CC8C
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 08:02:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229792AbjGJGCt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 02:02:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229592AbjGJGCs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 02:02:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64D4CF9
        for <linux-kernel@vger.kernel.org>; Sun,  9 Jul 2023 23:02:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id ECE7860DF4
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 06:02:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 906D9C433C7;
        Mon, 10 Jul 2023 06:02:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688968966;
        bh=lXX8+8C2CPgAH+JV9a0WXKBIs81GM0CysUlsX48kz1o=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=ZzGxdSG3D3vxOGMof/r0+nd8BzWgh1pyl0T03Orrd94jtOl4JA3dqEvqg4fQczYEk
         4EW6uHRTG1r3dFDJRS3S6kULnL+2mi2juGRxHk9dy1JSe3E+ZZNOUuXOuJCmz5DY78
         xz1s2I5QoT/F0JkWC0Tq004RhEXQ8akNQqb34GisfYpK1vtbvL53ZKcRPFYUToOkvZ
         I2XcGSCT0ZO/ZLm2H9B45CSS/YQtWSCq1F6HUplKWcklxIPnq21L+z+riWKZZ+dA8d
         OlDqf6VGNQHU1f4CaM7HO56fomWLHCMEiFjAAnSxkYVqpTgd59AK9GEHWrHX6WIZ1T
         AFgwIn8s5rg8w==
Message-ID: <8b5bde1a-08e2-15ad-ebe1-08a16de00468@kernel.org>
Date:   Mon, 10 Jul 2023 08:02:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v2 1/2] regulator: dt-bindings: rtq2208: Add Richtek
 RTQ2208 SubPMIC
To:     Alina Yu <alina_yu@richtek.com>
Cc:     broonie@kernel.org, linux-kernel@vger.kernel.org,
        cy_huang@richtek.com
References: <cover.1688569987.git.alina_yu@richtek.com>
 <341af3996c430549243365bb8204d33a15a482be.1688569987.git.alina_yu@richtek.com>
 <d3308334-aa91-f265-2469-8a6fbc727798@kernel.org>
 <20230706103040.GA32138@linuxcarl2.richtek.com>
 <20230710030858.GA16636@linuxcarl2.richtek.com>
Content-Language: en-US
From:   Krzysztof Kozlowski <krzk@kernel.org>
In-Reply-To: <20230710030858.GA16636@linuxcarl2.richtek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/07/2023 05:08, Alina Yu wrote:
>> Yes, "0" refers to DVS0 registers, and "1" refers to DVS1.
>> and there is only DVS0 and DVS1, so I use boolean to check which one is used.
>>
>> Is it more understandable if I modify that to enum ? And description will be like this
>>
>> richtek,mtp-sel:
>>   enum: [0, 1]
>>     description: |
>>       vout register selection besed on this value.
>>       0 - Using DVS0 register setting to adjust vout
>>       1 - Using DVS1 register setting to adjust vout
>>
> 
> May I ask one more question ?
> If I modify the name into "richtek,mtp-sel-high", is that more understandable ?
> It will be like this,
> 
> richtek,mtp-sel-high:
>   type: boolean
>   description:
>   vout register selection besed on this value.
>   0 - Using DVS0 register setting to adjust vout
>   1 - Using DVS1 register setting to adjust vout

You don't have 0 or 1 values in such case. The property can be bool, but
description is not good.

Best regards,
Krzysztof

