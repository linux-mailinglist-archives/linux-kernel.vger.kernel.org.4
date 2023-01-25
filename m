Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1EE567B75E
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jan 2023 17:52:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235295AbjAYQwr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Jan 2023 11:52:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229496AbjAYQwo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jan 2023 11:52:44 -0500
Received: from sender4-op-o14.zoho.com (sender4-op-o14.zoho.com [136.143.188.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 309B110D7;
        Wed, 25 Jan 2023 08:52:43 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1674665548; cv=none; 
        d=zohomail.com; s=zohoarc; 
        b=JgY/DFxi5wzMgRQ+sYu8oaeM+0JcJURHVL0tqksIK6sf5di9goLVm6mxgCYU9cCUQGEuf3i2MxmbhctJigNmp4wicQ6ovKmlk3Lu1wHC3Ow1wLdRLIvhakKzZNHOrGtQQb/rUaN3SDchfNYDxOowdFW8wQEZBImu66I/n1Dmm+Y=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
        t=1674665548; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=n6uhViJAk2dcnYUKQtk76YHI3HBSLcS24oN4Cx0z7Nk=; 
        b=kTEV9POAYIoBN7LpMkySt47cS5a2+JcVN9axrdgyg+oFtGxbGHctVntG+vs3DjwLtr90BY9c35Qai1VEwrt5rP3m8cisH/VWoG/B+BUHs+14aHEthZlaUE6BCo6yPANx48YfCnILYyajxuB0SBSvWb/ZM9QSICyJxl4w7H4wV+g=
ARC-Authentication-Results: i=1; mx.zohomail.com;
        dkim=pass  header.i=arinc9.com;
        spf=pass  smtp.mailfrom=arinc.unal@arinc9.com;
        dmarc=pass header.from=<arinc.unal@arinc9.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1674665548;
        s=zmail; d=arinc9.com; i=arinc.unal@arinc9.com;
        h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
        bh=n6uhViJAk2dcnYUKQtk76YHI3HBSLcS24oN4Cx0z7Nk=;
        b=hBDT9b4mWWMH9J0Ohrl3UNLqZBywU/CoGnCDToJVOq8VHdRQy1pevJpArt3Yjqo/
        rQ+BS8I6R+0j1XUzgl9KiBBrqGnkHCWiYLl7tPMDMGhS8twEszzfvh9jnEL/q4xo91Z
        3i0w1p0C4JKtHXsRLUolGginS0g7KwrOAMU8Wais=
Received: from [10.10.10.3] (37.120.152.236 [37.120.152.236]) by mx.zohomail.com
        with SMTPS id 1674665547622312.4603569868316; Wed, 25 Jan 2023 08:52:27 -0800 (PST)
Message-ID: <3ab1b3d2-f9fd-e64d-6346-1d80e7f57dba@arinc9.com>
Date:   Wed, 25 Jan 2023 19:52:21 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH 1/5] arm: dts: mt7623: add gmacs to mt7623.dtsi
To:     frank-w@public-files.de, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        erkin.bozoglu@xeront.com, Sean Wang <sean.wang@mediatek.com>,
        DENG Qingfang <dqfext@gmail.com>
References: <20230120205318.519493-1-arinc.unal@arinc9.com>
 <20230120205318.519493-2-arinc.unal@arinc9.com>
 <BAF25F3F-7B1B-4E9D-A0D9-89DB663B0AB3@public-files.de>
Content-Language: en-US
From:   =?UTF-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>
In-Reply-To: <BAF25F3F-7B1B-4E9D-A0D9-89DB663B0AB3@public-files.de>
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

On 25.01.2023 19:45, Frank Wunderlich wrote:
> Am 20. Januar 2023 21:53:14 MEZ schrieb "Arınç ÜNAL" <arinc.unal@arinc9.com>:
> 
>> index 25d31e40a553..5eb698a90d34 100644
>> --- a/arch/arm/boot/dts/mt7623.dtsi
>> +++ b/arch/arm/boot/dts/mt7623.dtsi
>> @@ -981,6 +981,20 @@ eth: ethernet@1b100000 {
>> 		#address-cells = <1>;
>> 		#size-cells = <0>;
>> 		status = "disabled";
>> +
>> +		gmac0: mac@0 {
>> +			compatible = "mediatek,eth-mac";
>> +			reg = <0>;
>> +			phy-mode = "trgmii";
>> +			status = "disabled";
>> +		};
>> +
>> +		gmac1: mac@1 {
>> +			compatible = "mediatek,eth-mac";
>> +			reg = <1>;
>> +			phy-mode = "rgmii";
>> +			status = "disabled";
>> +		};
>> 	};
>>
> 
>> diff --git a/arch/arm/boot/dts/mt7623n-bananapi-bpi-r2.dts b/arch/arm/boot/dts/mt7623n-bananapi-bpi-r2.dts
>> index 5008115d2494..a5800a524302 100644
>> --- a/arch/arm/boot/dts/mt7623n-bananapi-bpi-r2.dts
>> +++ b/arch/arm/boot/dts/mt7623n-bananapi-bpi-r2.dts
>> @@ -175,9 +175,7 @@ &eth {
>> 	status = "okay";
>>
>> 	gmac0: mac@0 {
> 
> Should node not be accessed with label (&gmac0) instead of defining it again and shadow the one from dtsi?

I think that's up to preference. I kept it the current way as it's 
cleaner than taking it out of &eth.

Arınç
