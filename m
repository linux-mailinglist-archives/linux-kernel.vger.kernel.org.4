Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64912654F9B
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Dec 2022 12:22:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236138AbiLWLWq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Dec 2022 06:22:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229613AbiLWLWl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Dec 2022 06:22:41 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83FAB6578;
        Fri, 23 Dec 2022 03:22:39 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 23D7561F1F;
        Fri, 23 Dec 2022 11:22:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECC9EC433D2;
        Fri, 23 Dec 2022 11:22:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671794558;
        bh=iml0LYBf4pgDoBM3uptB0jlwdBiRt0cmsJC1LuqZC2A=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=aY5TgDlrecotk9zN++iFVn917CJ+lpYtPgCOsLqE6mlo5PYbmGFNIjI5j/sG2V9Ve
         mP1VBTBOiM+b2tyDgBQA/PUos0IbAVXAk7nmRqJlSNskSxf/GJLIX3s8aspc9Fwavq
         mtVmuSnoXNdbk6sY51QgOH5WocjpZTjle+vrrz5dtyjLj1H9sjgfqmCSrNHBIsAuLS
         gA+547InUUE5VZrRI/bjIe/z2agrxZQvVNhiILZ2p/DS+sADk/ErmUs52Xhq0mb22w
         o+9Q/YR2BLRUjlg8xurCRGkcMDRoK2etrW6x7RfzuGUVnr0Lg2BzhkanNjbTEAz5d1
         r6sJb5SJOgpcg==
Message-ID: <23436455-098f-6e21-2330-d91158a591ad@kernel.org>
Date:   Fri, 23 Dec 2022 12:22:34 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH 4/5] dt-bindings: firmware: arm,scmi: Add support for
 syspower protocol
Content-Language: en-US
To:     Cristian Marussi <cristian.marussi@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        sudeep.holla@arm.com, Rob Herring <robh+dt@kernel.org>,
        devicetree@vger.kernel.org
References: <20221222183823.518856-1-cristian.marussi@arm.com>
 <20221222183823.518856-5-cristian.marussi@arm.com>
 <3d89e135-c8e4-ede4-950f-03900a660822@kernel.org>
 <Y6WE1zQAxYYn6Ahz@e120937-lin>
From:   Krzysztof Kozlowski <krzk@kernel.org>
In-Reply-To: <Y6WE1zQAxYYn6Ahz@e120937-lin>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/12/2022 11:37, Cristian Marussi wrote:

>>>  
>>> +  protocol@12:
>>> +    type: object
>>> +    properties:
>>> +      reg:
>>> +        const: 0x12
>>> +
>>
>> Why? It did not got lost, it's already covered by pattern. If you refer
>> to particular warning, please paste it in commit msg. Otherwise it looks
>> incorrect.
>>
> 
> Yes indeed, but as a matter of fact it seemed to me that we used to add an
> entry and an example for all the currently published standard SCMI protocols,
> even though already covered by the patternProp (which covers also any
> custom-vendor protocol in the wild) and not sporting any additional
> custom properties (see protocol@18), but maybe this is just a unneeded wrong
> habit adding only cruft to the bindings.
> 
> If you think it does not add any value I can happily drop this, or
> limiting the addition just to the example (and/or drop equally the unneeded
> protocol@18 node too in this case).

Duplicating the node (once in properties, second in patternProperties)
is not needed. I am also not sure what would be the point to add to the
example - example does not have to be complete DTS for all cases, but
illustrate the binding and allow is to test it.

Best regards,
Krzysztof

