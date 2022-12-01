Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB26F63EF7B
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 12:30:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230337AbiLALaA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 06:30:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229617AbiLAL35 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 06:29:57 -0500
Received: from gateway34.websitewelcome.com (gateway34.websitewelcome.com [192.185.149.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2CDA5436A
        for <linux-kernel@vger.kernel.org>; Thu,  1 Dec 2022 03:29:55 -0800 (PST)
Received: from atl1wswcm06.websitewelcome.com (unknown [50.6.129.167])
        by atl3wswob05.websitewelcome.com (Postfix) with ESMTP id 4E9A423773
        for <linux-kernel@vger.kernel.org>; Thu,  1 Dec 2022 11:29:55 +0000 (UTC)
Received: from md-in-79.webhostbox.net ([43.225.55.182])
        by cmsmtp with ESMTP
        id 0hlIpjkolPz0t0hlKpegY8; Thu, 01 Dec 2022 11:29:55 +0000
X-Authority-Reason: nr=8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=linumiz.com
        ; s=default; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
        References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=TCNr02UaRvZ8qQ2TFTX6Ynk9lUh1O4TOo+08fJJNC2k=; b=hwsuGXY080THqr1c9HDjoVevnH
        AGIl7kcDBCpnI9P7+Io3E2QG5TM/ArD2mNLA7y3MxW3nDWUOXKkfr8DrvrJhWljO75m1FQ/jk60hJ
        NjQkUanU7sQ+2mBcO2IXiS9hjcjokThkYt/tjyb73VILbCJxVZFKxyLPalHrGVNo0X8rsSs/FfqnI
        2d/mO4STFp/1tVNPeY/pRLhnx4Hp5lECjwyk4qjX2fp3jArj1gTCt7DKUe0yS21QQCkXaVUAvEyvP
        t0iP9eeC/9RJLLCOsZtGxmOQgsadmH6+bKJguEH/E1SVTlRlP4p1yw7/cpfr2NcByhMwrhHblsZgV
        MZGtLXMg==;
Received: from [223.187.121.253] (port=40120 helo=[192.168.221.42])
        by md-in-79.webhostbox.net with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.95)
        (envelope-from <saravanan@linumiz.com>)
        id 1p0hlG-000MTk-Km;
        Thu, 01 Dec 2022 11:29:51 +0000
Message-ID: <e7b20055-4f44-aa91-e18d-9fb0f835fbf1@linumiz.com>
Date:   Thu, 1 Dec 2022 12:29:44 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v2 2/4] dt-bindings: hwmon/pmbus: Add mps,mpq7932
 power-management IC
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
        linux@roeck-us.net, linux-kernel@vger.kernel.org,
        marten.lindahl@axis.com, jdelvare@suse.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org
References: <20221201044643.1150870-1-saravanan@linumiz.com>
 <20221201044643.1150870-3-saravanan@linumiz.com>
 <bc86121f-3cc2-1e55-4c6a-02cb1644a8bd@linaro.org>
Content-Language: en-US
From:   Saravanan Sekar <saravanan@linumiz.com>
In-Reply-To: <bc86121f-3cc2-1e55-4c6a-02cb1644a8bd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - md-in-79.webhostbox.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - linumiz.com
X-BWhitelist: no
X-Source-IP: 223.187.121.253
X-Source-L: No
X-Exim-ID: 1p0hlG-000MTk-Km
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: ([192.168.221.42]) [223.187.121.253]:40120
X-Source-Auth: saravanan@linumiz.com
X-Email-Count: 5
X-Source-Cap: bGludW1jbWM7aG9zdGdhdG9yO21kLWluLTc5LndlYmhvc3Rib3gubmV0
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfOwl0/C6Hqv2GdUE9IbQbU1cgux6d2HtEnftl9j/M7UI5sRekRQQjiN5N+GXfgO9RZJiv3ApLvljNppFt0HUOlcq/mG0hNAqw6nNQFFllVIxBLuFhl30
 63uSPczeLvup8OIqNpZ+0SZpHo81APfRm9GxdGF5aECujk6hN2F/NjHQyTX+FJs9F3RhN7DynMg2JP5WmAyZWbykrSIsmSW7jDA=
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/12/22 11:26, Krzysztof Kozlowski wrote:
> On 01/12/2022 05:46, Saravanan Sekar wrote:
>> Document mpq7932 power-management IC
>>
>> Signed-off-by: Saravanan Sekar <saravanan@linumiz.com>
>> ---
> 
> This is a friendly reminder during the review process.
> 
> It seems my previous comments were not fully addressed. Maybe my
> feedback got lost between the quotes, maybe you just forgot to apply it.
> Please go back to the previous discussion and either implement all
> requested changes or keep discussing them.
>
Hi Krzysztof,

Thanks for your time to review and feedback.

Here are the summary of comments on V1, I have fixed all according to my 
understanding.


1. Use subject prefixes matching the subsystem (git log --oneline -- ...).

git log --oneline -- Documentation/devicetree/bindings/hwmon/pmbus/
1ccca53618c4 dt-bindings: hwmon/pmbus: Add mps,mpq7932 power-management IC
373c0a77934c dt-bindings: hwmon/pmbus: Add ti,lm25066 power-management IC
7f464532b05d dt-bindings: Add missing 'additionalProperties: false'
8a36e38d8b0f dt-bindings: hwmon/pmbus: Add ti,ucd90320 power sequencer

I have used the same format of 373c0a77934c.

2. Does not look like you tested the bindings. Please run `make
dt_binding_check` (see
Documentation/devicetree/bindings/writing-schema.rst for instructions).

I did run dt_binding_check on V1 but failed to notice warnings. Fixed 
warning on V2 and didn't observed any warnings.

3. Why requiring nodename? Device schemas usually don't do that.
dropped "pattern: "pmic@[0-9a-f]{1,2}""

4. regulators node is a regulator with one more regulator? Drop.
dropped "$ref: regulator.yaml# "

5. Messed indentation. Use same for entire example, e.g. 4-spaces.
Fixed it.


Please help if anything which I missed


> Thank you.
> 
> Best regards,
> Krzysztof
> 

