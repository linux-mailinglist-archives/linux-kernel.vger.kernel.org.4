Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A01626DA919
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Apr 2023 08:52:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232757AbjDGGvX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Apr 2023 02:51:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229524AbjDGGvW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Apr 2023 02:51:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6D796E94;
        Thu,  6 Apr 2023 23:51:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5C82361011;
        Fri,  7 Apr 2023 06:51:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09CDFC433EF;
        Fri,  7 Apr 2023 06:51:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680850276;
        bh=LMTAC/yn+tcHlKbg9ULyItn48nBnUuiX3Tp1VD1J60g=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=BDWW/GlTW4xectp2MdArf65kLoooZ6u6OWbfkGcf59FS1VrmU7wpPy4nurCt/Y77s
         9u0+czyn1442ZjdleAkfQ8qrQxjRFC8sVMsm2efc+AhVjVr6Ge18XOB7zjpvC4MX9G
         nV3pJKk7/6sjsTfUCuat/6g2lnHQHpl9kbgVFC9nU8A2ff6tTVYuOuGos9URWVgd77
         OZ5Z1PSVIvquthT+X5exyJu7NoSJVeRAH9MCY70g93MytOHQnmVYu5/fvUEo6No2g1
         Beu6047WctdSwc8LKn7HFYLvRoMnkKv1kVelVDhjhO5eeUzdwG/54C/yqeHMQilOF0
         XLUFCYO7uNwpw==
Message-ID: <4555d5e8-0403-99bc-9cc2-26b72ea5be3b@kernel.org>
Date:   Fri, 7 Apr 2023 08:51:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v2 2/2] dt-bindings: cisco: document the CrayAR
 compatibles
Content-Language: en-US
To:     "Daniel Walker (danielwa)" <danielwa@cisco.com>
Cc:     "xe-linux-external(mailer list)" <xe-linux-external@cisco.com>,
        "Marcin Wierzbicki -X (mawierzb - GLOBALLOGIC INC at Cisco)" 
        <mawierzb@cisco.com>, Rob Herring <robh+dt@kernel.org>,
        Daniel Walker <dwalker@fifo99.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20230405223028.1268141-2-danielwa@cisco.com>
 <6a9f041b-1c35-4691-8451-7119cd05ed17@linaro.org>
 <20230406151512.GL40472@zorba>
 <14634180-aca9-a3e9-d1af-dfaca77b42ee@linaro.org>
 <20230406183253.GM40472@zorba>
 <5e2e5b82-35ae-c3b5-becb-40d387226a7a@linaro.org>
 <20230406191506.GN40472@zorba>
From:   Krzysztof Kozlowski <krzk@kernel.org>
In-Reply-To: <20230406191506.GN40472@zorba>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.4 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/04/2023 21:15, Daniel Walker (danielwa) wrote:
> On Thu, Apr 06, 2023 at 08:56:06PM +0200, Krzysztof Kozlowski wrote:
>> On 06/04/2023 20:32, Daniel Walker (danielwa) wrote:
>>>>>>> +++ b/Documentation/devicetree/bindings/arm/cisco/crayar.yaml
>>>>>>
>>>>>> How many (or not many) platforms do you expect from Cisco? We mostly
>>>>>> have one file per SoC manufacturer.
>>>>>
>>>>> We have two SoC's one called CrayAR and another called Craw. I've submitted the
>>>>> Craw dts file before , but I've not resubmitted it. Under Craw I think we have
>>>>> at least two, but more likely five variations. CrayAR we have one variation with
>>>>> at least one more planned.
>>>>>
>>>>> So we would plan over time to add two dtsi files and three to four dts files to
>>>>> this directory. Then more over time.
>>>>
>>>> So just keep them in one file maybe.
>>>
>>> If/when I submit again with anther chip we can discuss it at that time.
>>
>> Or you can do it now.
> 
> What do you want to talk about exactly ? You said keep everything in one file, doesn't this
> already fit your suggestion ? I'm only submitting one file.

That is supposed to be one file named like: cisco.yaml
If you ever need to have separate maintainers, then split it.

Best regards,
Krzysztof

