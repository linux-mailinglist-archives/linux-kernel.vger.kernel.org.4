Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64A68692FB6
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Feb 2023 10:12:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229890AbjBKJMv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Feb 2023 04:12:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229696AbjBKJMs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Feb 2023 04:12:48 -0500
Received: from sender4-op-o14.zoho.com (sender4-op-o14.zoho.com [136.143.188.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 974C01A965;
        Sat, 11 Feb 2023 01:12:42 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1676106742; cv=none; 
        d=zohomail.com; s=zohoarc; 
        b=jk65BL09iN2GERWdHs65LJxMPXaD6suwK5ozfbQ+5Mh14WSNIBUvuvNwJ4AlUDg1P07uJDSSpivmuKODyWvjiaw0fWgeSLzdQgvfeXXHL+PzQuUyrpvM8XjF0uIuD4bfQEwTLhK7t+3dECeDP+aXcq7fgB1ZKSDKLuIAypea6Ek=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
        t=1676106742; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=MkQdwA/QXaiKt+bHFwNe8YCFs401QF7zQKhmxVVcQFI=; 
        b=eLApP6LEYUfim8eTURf50CeZbAiBapY7BLILBiAjEK/mFi+yqCFrmrJEnxJkHaNgLFtumEkNQj1L+vbZbntJ92cDsl2bUvB1Yne178KX6a1pWQvt6DVoqBbe8Qf7k8kHJUVj3mvflJfNvWFdqeRcwX4MVKwssDF/Z2ORu5gpp/s=
ARC-Authentication-Results: i=1; mx.zohomail.com;
        dkim=pass  header.i=arinc9.com;
        spf=pass  smtp.mailfrom=arinc.unal@arinc9.com;
        dmarc=pass header.from=<arinc.unal@arinc9.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1676106742;
        s=zmail; d=arinc9.com; i=arinc.unal@arinc9.com;
        h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
        bh=MkQdwA/QXaiKt+bHFwNe8YCFs401QF7zQKhmxVVcQFI=;
        b=OzjlQTbiQFNNl2ttvUlIv+kDDXEg7aF1OVRLCLb6FErUnURy2PAUTiQe/vgY5wzK
        IQ/EkVOoyNXXnv7h8qFixFCw5JdjRDTqyy1TcpL2+4seub6teCoCQrogPqfthDTKTkd
        zz2ET9ioblirlExYj4xlDx9SskCRqBiHfONcRPu4=
Received: from [10.10.10.3] (37.120.152.236 [37.120.152.236]) by mx.zohomail.com
        with SMTPS id 1676106739991550.5857652221796; Sat, 11 Feb 2023 01:12:19 -0800 (PST)
Message-ID: <96fb94a0-4910-d7b9-9ae6-e97a058b0fe0@arinc9.com>
Date:   Sat, 11 Feb 2023 12:12:16 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v4 3/5] mips: dts: ralink: mt7621: rename watchdog node
 from 'wdt' into 'watchdog'
Content-Language: en-US
To:     Sergio Paracuellos <sergio.paracuellos@gmail.com>,
        linux-watchdog@vger.kernel.org
Cc:     wim@linux-watchdog.org, linux@roeck-us.net, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, matthias.bgg@gmail.com,
        tsbogend@alpha.franken.de, p.zabel@pengutronix.de,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-mips@vger.kernel.org
References: <20230211073357.755893-1-sergio.paracuellos@gmail.com>
 <20230211073357.755893-4-sergio.paracuellos@gmail.com>
From:   =?UTF-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>
In-Reply-To: <20230211073357.755893-4-sergio.paracuellos@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11.02.2023 10:33, Sergio Paracuellos wrote:
> Watchdog nodes must use 'watchdog' for node name. When a 'make dtbs_check'
> is performed the following warning appears:
> 
> wdt@100: $nodename:0: 'wdt@100' does not match '^watchdog(@.*|-[0-9a-f])?$'
> 
> Fix this warning up properly renaming the node into 'watchdog'.
> 
> Signed-off-by: Sergio Paracuellos <sergio.paracuellos@gmail.com>

Reviewed-by: Arınç ÜNAL <arinc.unal@arinc9.com>

Thanks.
Arınç
