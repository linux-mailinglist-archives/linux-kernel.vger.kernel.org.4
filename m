Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E7176DF82B
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 16:16:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231452AbjDLOQw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 10:16:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229722AbjDLOQv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 10:16:51 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5372519C;
        Wed, 12 Apr 2023 07:16:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C5023632B8;
        Wed, 12 Apr 2023 14:16:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4182BC433EF;
        Wed, 12 Apr 2023 14:16:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681309009;
        bh=lCSJSRXtqb2QD0ekqpNwQgpnDOFGNh7gQzeRU9Qv/jg=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=tT8y+ksTvQdvvDojJRI8w8FmuMY9qdEBqjZzifQljkQQoge8MJo9hhuwr3uSpIK0e
         qS7Ihgzr3ZUBLihrDIt7cbxQZ4mb/CLxjsPnTQ0o1WPuLjLXletu0REbn4M6tGvWAc
         XnIJwMMfilgpThH0sDF+3xLN/tUSDhkJS8GjrG+AeNow0t5t/qxzTAtPGm2TJ7TNfv
         El2x1wjLJb+QjueTv76mggGi5Alc2DYC3acAasLP0vhgg83PjB1WRUfEDnOpmUM4R6
         m/Z5dCTcu7GKunhGyl9XhGx4y9Q8l4qL1Lx5fqn8+KxOYIMjwQht+31PgjHoA+1/O3
         w1CTIkXKVUocQ==
Message-ID: <ea82fff5-a532-e2c0-3988-9a8f93312e28@kernel.org>
Date:   Wed, 12 Apr 2023 16:16:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH v2 2/2] dt-bindings: usb: snps,dwc3: Add
 'snps,parkmode-disable-hs-quirk' quirk
Content-Language: en-US
To:     =?UTF-8?B?U3RhbmxleSBDaGFuZ1vmmIzogrLlvrdd?= 
        <stanley_chang@realtek.com>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>
Cc:     "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Felipe Balbi <balbi@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20230411053550.16360-1-stanley_chang@realtek.com>
 <20230411053550.16360-2-stanley_chang@realtek.com>
 <42476475-3de1-49e8-4cfe-a9b3d98df8be@kernel.org>
 <f775fb3674d446feab7dbfeb04e3987a@realtek.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
In-Reply-To: <f775fb3674d446feab7dbfeb04e3987a@realtek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/04/2023 13:10, Stanley Chang[昌育德] wrote:
>> On 11/04/2023 07:35, Stanley Chang wrote:
>>> Add a new 'snps,parkmode-disable-hs-quirk' DT quirk to dwc3 core for
>>> disable the high-speed parkmode.
>>>
>>> Signed-off-by: Stanley Chang <stanley_chang@realtek.com>
>>> ---
>>>  Documentation/devicetree/bindings/usb/snps,dwc3.yaml | 5 +++++
>>>  1 file changed, 5 insertions(+)
>>
>> NAK, so Greg won't pick it up too fast. :)
>>
>> Please use scripts/get_maintainers.pl to get a list of necessary people and lists
>> to CC.  It might happen, that command when run on an older kernel, gives
>> you outdated entries.  Therefore please be sure you base your patches on
>> recent Linux kernel.
>>
>> Best regards,
>> Krzysztof
>>
> 
> CC more maintainers by using scripts/get_maintainers.pl
> 

This does not work like this.

Best regards,
Krzysztof

