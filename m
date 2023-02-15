Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BF906985CA
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Feb 2023 21:44:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229674AbjBOUoD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Feb 2023 15:44:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbjBOUoB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Feb 2023 15:44:01 -0500
Received: from stravinsky.debian.org (stravinsky.debian.org [IPv6:2001:41b8:202:deb::311:108])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07AB32A6CB;
        Wed, 15 Feb 2023 12:44:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
        s=smtpauto.stravinsky; h=X-Debian-User:Content-Transfer-Encoding:Content-Type
        :In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:
        Reply-To:Content-ID:Content-Description;
        bh=FkpPjBi+rHVjTdLlMQGMpiIrvag580LeZ4r5zllWXIw=; b=S7CwLmDWMdsBaeDdmmbE94Fd6r
        YfnYg+wWyh2JTR8ajXhvmZQpSFwyJXM2tieQ/vmRLetW2L6fFfs5bgn9oHJtXvLHWx1Bje+Q9xKk0
        WksNFzH3FZkNuIXlzQELhdlArMi+ZI3cCllEPs6N7oRw3d65tq/lfUUWvoPA1z0p5Pzx0L9SPsYcF
        DoA8xxwwH4AYCjqbVeMbfrwRI4NG+ZczyDV5RCL/S/ws/7eNG67oaKlE3epRsTydOV66QDCBlp6cT
        0q4+607bU2xELjgHUKGGiNyS6Wtu54nJ2Usz9uqDVUs2FmFAYcfoC44w2YbFOJWnCgXqHS4r7Kk66
        WWo0Znvw==;
Received: from authenticated user
        by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128)
        (Exim 4.94.2)
        (envelope-from <bage@debian.org>)
        id 1pSOd6-002jOy-4V; Wed, 15 Feb 2023 20:43:52 +0000
Message-ID: <aefc027c-e330-c117-87d2-3ea3023f610e@debian.org>
Date:   Wed, 15 Feb 2023 21:43:50 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:102.0) Gecko/20100101
 Thunderbird/102.7.2
Subject: Re: [PATCH v2 2/5] dt-bindings: hwlock: sun6i: Add #hwlock-cells to
 example
Content-Language: en-US
To:     Andre Przywara <andre.przywara@arm.com>
Cc:     Wilken Gottwalt <wilken.gottwalt@posteo.net>,
        Ohad Ben-Cohen <ohad@wizery.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Samuel Holland <samuel@sholland.org>,
        linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        devicetree@vger.kernel.org
References: <20230215203711.6293-1-bage@debian.org>
 <20230215203711.6293-3-bage@debian.org>
 <20230215204026.318d4b2d@slackpad.lan>
From:   Bastian Germann <bage@debian.org>
In-Reply-To: <20230215204026.318d4b2d@slackpad.lan>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Debian-User: bage
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,UNPARSEABLE_RELAY
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 15.02.23 um 21:40 schrieb Andre Przywara:
> On Wed, 15 Feb 2023 21:37:07 +0100
> Bastian Germann <bage@debian.org> wrote:
> 
> Hi,
> 
>> The dt-bindings tools will compile the yaml dt examples
>> and this prevents an error about this node not existing.
> 
> This needs to be part of patch 1/5, otherwise it will break
> bisecting. Just squash the two patches together.

Is this also okay with 1/5 already being applied in linux-next?

> 
> Cheers,
> Andre
> 
>> Signed-off-by: Bastian Germann <bage@debian.org>
>> ---
>>   .../bindings/hwlock/allwinner,sun6i-a31-hwspinlock.yaml          | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/Documentation/devicetree/bindings/hwlock/allwinner,sun6i-a31-hwspinlock.yaml b/Documentation/devicetree/bindings/hwlock/allwinner,sun6i-a31-hwspinlock.yaml
>> index 01b1bbb3061f..38478dad8b25 100644
>> --- a/Documentation/devicetree/bindings/hwlock/allwinner,sun6i-a31-hwspinlock.yaml
>> +++ b/Documentation/devicetree/bindings/hwlock/allwinner,sun6i-a31-hwspinlock.yaml
>> @@ -48,5 +48,6 @@ examples:
>>           reg = <0x01c18000 0x1000>;
>>           clocks = <&ccu CLK_BUS_SPINLOCK>;
>>           resets = <&ccu RST_BUS_SPINLOCK>;
>> +        #hwlock-cells = <1>;
>>       };
>>   ...
> 

