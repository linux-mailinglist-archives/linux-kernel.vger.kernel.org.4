Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 099D273A431
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 17:04:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232216AbjFVPEn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 11:04:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232199AbjFVPEl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 11:04:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B76A41731
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jun 2023 08:04:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2482861896
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jun 2023 15:04:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1D45C433C0;
        Thu, 22 Jun 2023 15:04:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687446277;
        bh=Anr3qQidNRhEyr8UpzGT9mXpgJe8zbwO3uFUdokDKoY=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=lcVITt0TatJxsw35g4wpqnQrjrY+aiV4A+YKGs6V03eUMgbhVsx+57K0V0O5yyhdt
         3B6NIWguULn+RSdl5T5B67WyUpkiW9eAOD8ml+UVpt+YSpTwx7SOyXmp05CX1uj5kB
         9lBrp9iVTEvMNDMW8fe4IDI5RebVIiJqK5HAs9BXXcI3yNv54Irl5s5IUPH/UdsaKi
         Dh7LO9CSStjipdIN91iP0xB95lDAH68tb4+8sNHVoIREBmXDC0P9U75ltSytNxQq4L
         4EIlXBvve6V2bsxLzntusq6159gtLleWZLiSvO0SYleF9GzNa1W4hsqgt1cNI7IWLZ
         bcRgyMpsqI3/w==
Message-ID: <0fe8dc83-f23b-5f20-10b7-0414b25fd45b@kernel.org>
Date:   Thu, 22 Jun 2023 17:04:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 1/7] dt-bindings: qcom: Document new msm8916-samsung
 devices
Content-Language: en-US
To:     Rob Herring <robh@kernel.org>
Cc:     "Lin, Meng-Bo" <linmengbo0689@protonmail.com>,
        linux-kernel@vger.kernel.org
References: <20230622000007.48219-1-linmengbo0689@protonmail.com>
 <20230622000254.48260-1-linmengbo0689@protonmail.com>
 <e66f1431-a4fd-07f8-6d34-5f6a358a361a@kernel.org>
 <20230622144007.GA1662197-robh@kernel.org>
From:   Krzysztof Kozlowski <krzk@kernel.org>
In-Reply-To: <20230622144007.GA1662197-robh@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/06/2023 16:40, Rob Herring wrote:
> On Thu, Jun 22, 2023 at 10:31:24AM +0200, Krzysztof Kozlowski wrote:
>> On 22/06/2023 02:03, Lin, Meng-Bo wrote:
>>> Document the new following device tree bindings used in their
>>> device trees:
>>>
>>> - samsung,fortuna3g
>>> - samsung,fortunaltezt
>>> - samsung,gprimeltecan
>>> - samsung,grandprimelte
>>> - samsung,heatqlte
>>> - samsung,rossa
>>
>> Please use scripts/get_maintainers.pl to get a list of necessary people
>> and lists to CC.  It might happen, that command when run on an older
>> kernel, gives you outdated entries.  Therefore please be sure you base
>> your patches on recent Linux kernel.
>>
>> You missed at least DT list (maybe more), so this won't be tested by our
>> tools. Performing review on untested code might be a waste of time, thus
>> I will skip this patch entirely till you follow the process allowing the
>> patch to be tested.
>>
>> Please kindly resend and include all necessary To/Cc entries.
>>
>> You just ignored maintainers entirely... It's not even about testing but
>> no one would apply it.
> 
> Something strange going on with this one as it still made it to the DT 
> patchwork, so it did go to the DT list. Must have been Bcc'ed.
> 
> The patches are also quoted-printable encoded which shouldn't be used.

Maybe hidden feature of protonmail... Although other mails in the thread
were sent to everyone.

Best regards,
Krzysztof

