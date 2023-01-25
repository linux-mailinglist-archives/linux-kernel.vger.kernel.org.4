Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 831D967B767
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jan 2023 17:54:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235313AbjAYQym (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Jan 2023 11:54:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229496AbjAYQyk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jan 2023 11:54:40 -0500
Received: from sender4-op-o14.zoho.com (sender4-op-o14.zoho.com [136.143.188.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A85572BF;
        Wed, 25 Jan 2023 08:54:39 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1674665668; cv=none; 
        d=zohomail.com; s=zohoarc; 
        b=Q3SZIKmg98u/0LCExf0y8XU+kU0RsgSRE/aINqK48rm5nnvIekxBzlnAHXqL10VTe+04Z+udVF9G62OYASNfD1T5P+KkrZxeRUAKeYekbGf+LbmewEK+cE9H6jDn2OsEMW4rdq2ka21B7d6gFABGMnhfbDUSkcqZuL5GmqdeRwU=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
        t=1674665668; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=SIZywMUisVmnloRixbIoiGBncQ3oo41hmW5rDh5H3HY=; 
        b=mZ+1TjJJApQjKngEPPHBo+4yhHnGVQqZKigFFF+DirjGk9Vz0iWBvw7JPj+Nb6BX178TZYeA2/jpiwjGLnHUC6Lf5VKoasqfAXJAphZ9ohK5bMpu3DVG/XueR8iRVZtUQQN+yoBHP9saE25g+F9fR0Vs+14tmM6digtvRTzPT5E=
ARC-Authentication-Results: i=1; mx.zohomail.com;
        dkim=pass  header.i=arinc9.com;
        spf=pass  smtp.mailfrom=arinc.unal@arinc9.com;
        dmarc=pass header.from=<arinc.unal@arinc9.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1674665668;
        s=zmail; d=arinc9.com; i=arinc.unal@arinc9.com;
        h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
        bh=SIZywMUisVmnloRixbIoiGBncQ3oo41hmW5rDh5H3HY=;
        b=gW3CYVCtcwPvM2mNPI5GHVE5m0ks6GtRUL7o0xaH87KZSI6y7S1dS+pWuH9ZreXw
        8wykqSKrg+7fmQk4Hw0MCz50ftYhg8zzuon2WC9SU4hWjw66FhGEGLcpRMBtK2pq825
        /FtJQKEjIiC4vR3Q21qrKbdKd8aTJpQSbXChrv9o=
Received: from [10.10.10.3] (37.120.152.236 [37.120.152.236]) by mx.zohomail.com
        with SMTPS id 1674665667043392.6251380291727; Wed, 25 Jan 2023 08:54:27 -0800 (PST)
Message-ID: <cf7d3247-4d21-98f0-819b-7653153ee4c0@arinc9.com>
Date:   Wed, 25 Jan 2023 19:54:22 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH 4/5] arm: dts: mt7623: mux phy0 on Bananapi BPI-R2
Content-Language: en-US
To:     frank-w@public-files.de, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        erkin.bozoglu@xeront.com, Sean Wang <sean.wang@mediatek.com>,
        DENG Qingfang <dqfext@gmail.com>
References: <20230120205318.519493-1-arinc.unal@arinc9.com>
 <20230120205318.519493-5-arinc.unal@arinc9.com>
 <9A7BD95A-F026-4EAB-96E1-12B1B0C6AAA4@public-files.de>
From:   =?UTF-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>
In-Reply-To: <9A7BD95A-F026-4EAB-96E1-12B1B0C6AAA4@public-files.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_BL_SPAMCOP_NET,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25.01.2023 19:41, Frank Wunderlich wrote:
> Am 20. Januar 2023 21:53:17 MEZ schrieb "Arınç ÜNAL" <arinc.unal@arinc9.com>:
> 
>> 		switch@1f {
>> 			compatible = "mediatek,mt7530";
>> 			reg = <0x1f>;
>> @@ -199,11 +208,6 @@ ports {
>> 				#address-cells = <1>;
>> 				#size-cells = <0>;
>>
>> -				port@0 {
>> -					reg = <0>;
>> -					label = "wan";
>> -				};
>> -
> 
> This will break existing userspace setups using wan as interface name.

Yup. The OS being used will have to either rename the interface or adapt 
to the new name, eth1.

Arınç
