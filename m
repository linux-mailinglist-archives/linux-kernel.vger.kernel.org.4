Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA4646E1EFA
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Apr 2023 11:05:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230141AbjDNJF3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Apr 2023 05:05:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbjDNJF1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Apr 2023 05:05:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 996D04EF2;
        Fri, 14 Apr 2023 02:05:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3C4F5645AB;
        Fri, 14 Apr 2023 09:05:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 293CFC433EF;
        Fri, 14 Apr 2023 09:05:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681463125;
        bh=RKUWjVPJrlvFOSvux9HcYl0d5UDv8c+EXyBgf50pelE=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=mE442eTSMCUa1C9zYj7L4qpyrvhC5zrPs2rpEW2uH1GvQOSH3pMGef5IGz1qD/sf2
         +xZb8ETgUWeUIcx9mWiF2EkWQ9AYyP5IXkClZh8BM94lNXXHpDNkRlMI+xlyeMOdcJ
         zIJbOsNdU77wL2A4MQzKTboe7YeuPgJISKZ8AlR/PwSzuCjQkYkTGFFZt8ValSde5v
         cBmHyFr1f1acGKWTKJTMWpVLZEigJKXA9nciQZsB/CpOYbY0O1uG1P8tgAVWdrtRFv
         oy2xsLn/FVCd5bxgOrWCXPc3/4ZUVpUC02oHgFUmOfIQBDi9Mpqpr6SKz/rQs1/pMz
         3EEkhpIGvjztw==
Message-ID: <1db257c0-ef31-ca03-2101-948974d31c42@kernel.org>
Date:   Fri, 14 Apr 2023 11:05:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH v2 2/2] dt-bindings: usb: snps,dwc3: Add
 'snps,global-regs-starting-offset' quirk
Content-Language: en-US
To:     =?UTF-8?B?U3RhbmxleSBDaGFuZ1vmmIzogrLlvrdd?= 
        <stanley_chang@realtek.com>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>
Cc:     "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Felipe Balbi <balbi@kernel.org>
References: <20230412033006.10859-2-stanley_chang@realtek.com>
 <20230413042503.4047-1-stanley_chang@realtek.com>
 <167e4a8c-3ebd-92b7-1481-947f08901f97@kernel.org>
 <9f6abbe7a6fd479c98e2fd6c1080ad8a@realtek.com>
 <19946f94-db48-fe0d-722c-cbb45b8bd0ba@kernel.org>
 <313863df3a3b492aa7590e1354d22d8b@realtek.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
In-Reply-To: <313863df3a3b492aa7590e1354d22d8b@realtek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/04/2023 04:12, Stanley Chang[昌育德] wrote:
> 
>>>> Didn't you got already comment for this patch? How did you implement it?
>>>>
>>>> Also, I asked you multiple times:
>>>>
>>>> Please use scripts/get_maintainers.pl to get a list of necessary
>>>> people and lists to CC.  It might happen, that command when run on an
>>>> older kernel, gives you outdated entries.  Therefore please be sure
>>>> you base your patches on recent Linux kernel.
>>>>
>>>> I don't understand why you ignore this.
>>>>
>>>> NAK, patch is not correct.
>>>>
>>>> Best regards,
>>>> Krzysztof
>>>>
>>>
>>> Thank you for your patient guidance.
>>> Because I'm not familiar with the review process and didn't use
>> scripts/get_maintainers.pl properly in the initial email thread.
>>> Therefore, this series of errors was caused. Sorry for the confusion.
>>> Now I know how to use the script properly.
>>> After correcting the maintainer's suggestion, I'll restart a new email thread
>> and review again.
>>
>> Did you respond to feedback you got about the property? Did reviewer agreed
>> on your view after your feedback?
>>
>> If not, then why resending this patch?
>>
> 
> 1. Because you said, "This patch is incorrect". And I won't be cc'ing the proper maintainer.
> I think I need to restart a new review process.
> 2. Modify the previous reviewer's comments and fix the dtschema validation error.
> 
> Am I misunderstanding what you mean?
> Can I keep reviewing this patch on this email thread until consensus is reached with the reviewers?

I guess confusion is because you never received response from Rob. I'll
reply there.

Best regards,
Krzysztof

