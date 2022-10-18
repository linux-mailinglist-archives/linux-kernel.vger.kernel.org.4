Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15BC7602C82
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 15:10:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230048AbiJRNKF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 09:10:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229726AbiJRNKA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 09:10:00 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 409F722B39;
        Tue, 18 Oct 2022 06:09:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 5DD2ACE1D9C;
        Tue, 18 Oct 2022 13:09:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 547D7C433D6;
        Tue, 18 Oct 2022 13:09:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666098593;
        bh=Gjhm/s/yibZyBOljamtWhCKr3oz98vC+6kbBR7ZDIqk=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=O+J3ODY7IbDk8Am1Z+2eYA2tfMHUPa58Q7kZiiS0fVSCZFjIgrya+Zy3LnR0nvhJC
         rZU4weULmKd2kkng4j+NaO7qZGRD70Vl3lOXhK/VfqVghwyh8TdIltzo+YeNj7WM7r
         ZSYkb1zX/CieMaZ1pLE/9KaTLImhkj9sIWhWup7jFZi7Q0lPNybnfiFchuzOrYlVcw
         nC2KaQ4SUOAGHA7Bj+QAykiaYWFaZ2MJx+iWgFwuPED8Ez0STSIbPolquWgARnjgIV
         v8bE/QXI/GscOh6blTxhnABZFX11zWzLMC28MdRzIPVBOuRecfoKrrfuLuNkbeanGb
         vHeWOFcxVPMYg==
Message-ID: <3f2f8e87-3d9e-5742-408a-17f96df6f9ca@kernel.org>
Date:   Tue, 18 Oct 2022 09:09:29 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [Patch v3 01/15] dt-bindings: media: s5p-mfc: Add new DT schema
 for MFC
Content-Language: en-US
To:     Aakarsh Jain <aakarsh.jain@samsung.com>,
        linux-arm-kernel@lists.infradead.org, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Cc:     m.szyprowski@samsung.com, andrzej.hajda@intel.com,
        mchehab@kernel.org, hverkuil-cisco@xs4all.nl,
        ezequiel@vanguardiasur.com.ar, jernej.skrabec@gmail.com,
        benjamin.gaignard@collabora.com, stanimir.varbanov@linaro.org,
        dillon.minfei@gmail.com, david.plowman@raspberrypi.com,
        mark.rutland@arm.com, robh+dt@kernel.org, krzk+dt@kernel.org,
        andi@etezian.org, alim.akhtar@samsung.com,
        aswani.reddy@samsung.com, pankaj.dubey@samsung.com,
        linux-fsd@tesla.com, smitha.t@samsung.com
References: <20221011122516.32135-1-aakarsh.jain@samsung.com>
 <CGME20221011125142epcas5p13c858a5f27830fb1de50fa51e9730eca@epcas5p1.samsung.com>
 <20221011122516.32135-2-aakarsh.jain@samsung.com>
 <87380fdb-4053-e8dc-e997-b7c42be025ca@kernel.org>
 <000001d8e233$04db73d0$0e925b70$@samsung.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
In-Reply-To: <000001d8e233$04db73d0$0e925b70$@samsung.com>
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

On 17/10/2022 10:16, Aakarsh Jain wrote:
> 
> 
>> -----Original Message-----
>> From: Krzysztof Kozlowski [mailto:krzk@kernel.org]
>> Sent: 12 October 2022 18:27
>> To: aakarsh jain <aakarsh.jain@samsung.com>; linux-arm-
>> kernel@lists.infradead.org; linux-media@vger.kernel.org; linux-
>> kernel@vger.kernel.org; devicetree@vger.kernel.org
>> Cc: m.szyprowski@samsung.com; andrzej.hajda@intel.com;
>> mchehab@kernel.org; hverkuil-cisco@xs4all.nl;
>> ezequiel@vanguardiasur.com.ar; jernej.skrabec@gmail.com;
>> benjamin.gaignard@collabora.com; stanimir.varbanov@linaro.org;
>> dillon.minfei@gmail.com; david.plowman@raspberrypi.com;
>> mark.rutland@arm.com; robh+dt@kernel.org; krzk+dt@kernel.org;
>> andi@etezian.org; alim.akhtar@samsung.com; aswani.reddy@samsung.com;
>> pankaj.dubey@samsung.com; linux-fsd@tesla.com; smitha.t@samsung.com
>> Subject: Re: [Patch v3 01/15] dt-bindings: media: s5p-mfc: Add new DT
>> schema for MFC
>>
>> On 11/10/2022 08:25, aakarsh jain wrote:
>>> From: Smitha T Murthy <smitha.t@samsung.com>
>>>
>>> Convert DT schema for s5p-mfc in yaml format
>>
>> Convert S5P-MFC bindings to DT schema.
>>
>> You also missed full-stop.
>>
> Ok will address it in next series.
> 
>> My second comment was ignored here.
>>
> I missed one review comment which was related to change in commit message. Will address it in next series.
>>>
>>> Cc: linux-fsd@tesla.com
>>> Signed-off-by: Smitha T Murthy <smitha.t@samsung.com>
>>> Signed-off-by: Aakarsh Jain <aakarsh.jain@samsung.com>
>>> ---
>>>  .../devicetree/bindings/media/s5p-mfc.txt     |  75 --------
>>>  .../bindings/media/samsung,s5p-mfc.yaml       | 163
>> ++++++++++++++++++
>>>  2 files changed, 163 insertions(+), 75 deletions(-)  create mode
>>> 100644 Documentation/devicetree/bindings/media/samsung,s5p-mfc.yaml
>>>
>>> diff --git a/Documentation/devicetree/bindings/media/s5p-mfc.txt
>>> b/Documentation/devicetree/bindings/media/s5p-mfc.txt
>>> index aa54c8159d9f..8b137891791f 100644
>>> --- a/Documentation/devicetree/bindings/media/s5p-mfc.txt
>>> +++ b/Documentation/devicetree/bindings/media/s5p-mfc.txt
>>
>> This is a friendly reminder during the review process.
>>
>> It seems my previous comments were not fully addressed. Maybe my
>> feedback got lost between the quotes, maybe you just forgot to apply it.
>> Please go back to the previous discussion and either implement all requested
>> changes or keep discussing them.
>>
>> Thank you.
>>
> Apart from your second review comment  I guess we have addressed all your review comments in the current patch.
> Please review other changes as well and let us know if any changes required.

No, as I said you did not. Instead of bouncing back immediately, go
through previous emails and through reviews.

I already reviewed this patch and it did not apply all my comments.
Asking me to review second time is not the solution here. The solution
here is for you to go through the comments and implement them, or answer
and keep discussion going.

Best regards,
Krzysztof

