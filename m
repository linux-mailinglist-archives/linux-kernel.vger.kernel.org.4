Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32700692FB2
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Feb 2023 10:12:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229630AbjBKJM1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Feb 2023 04:12:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjBKJMZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Feb 2023 04:12:25 -0500
Received: from sender4-op-o14.zoho.com (sender4-op-o14.zoho.com [136.143.188.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAA6A18A98;
        Sat, 11 Feb 2023 01:12:24 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1676106721; cv=none; 
        d=zohomail.com; s=zohoarc; 
        b=IWLbIlEP935YnliKAxzGLsqIlwjzqb2NWrrjVOYIs9g3DXa5aABKT5j7n44t60TPCQRo4nFgTA9VuAs1H7+YHp9TvXwMQg9MCJPeq7dgR7cjJ9lFM8c5edIFBirJU+GWSdkiG67+T7iBVE3hL1q1vEHV5PZrd02FOp/mt87Kh5g=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
        t=1676106721; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=WNt3L1hFcLj8X+5fArmHgoaWd5qLxrKQAxbyO3oIM0o=; 
        b=HQqxy/HNvcBe7vSO76H2zuFL16YrVQgQC62fG35kDHevNsUF6Ww9hDi31UYTw1df3LPzedwou3bRaZynEctN2tZNTNH9GYpi8I6+3jkmW/URUUWMphsi0//BAWvMHZboBOvNG3ubgHBqIXuhQsOAZo+TPQDDz5E9aWSALBvVpTU=
ARC-Authentication-Results: i=1; mx.zohomail.com;
        dkim=pass  header.i=arinc9.com;
        spf=pass  smtp.mailfrom=arinc.unal@arinc9.com;
        dmarc=pass header.from=<arinc.unal@arinc9.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1676106721;
        s=zmail; d=arinc9.com; i=arinc.unal@arinc9.com;
        h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
        bh=WNt3L1hFcLj8X+5fArmHgoaWd5qLxrKQAxbyO3oIM0o=;
        b=OJgAK77RYehyVZxscsS71nZ2dyRVT/PJXBnmUWEnfrO0lsnaLMIoPr5g27wVOgUg
        6idQyqwyC4sjdh682BBdFUtPKKZkyL9RdlDIypcxm+mvIDxVrTFmI9C/iU8lZ0zjE8+
        t+AhxjnwlkEf16p34SCcYu3tQ1sDngYcTDfR/+xE=
Received: from [10.10.10.3] (37.120.152.236 [37.120.152.236]) by mx.zohomail.com
        with SMTPS id 1676106720862738.6172796023416; Sat, 11 Feb 2023 01:12:00 -0800 (PST)
Message-ID: <13b819f9-cccd-dec5-f128-35c3a5fd525c@arinc9.com>
Date:   Sat, 11 Feb 2023 12:11:56 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v4 2/5] mips: dts: ralink: mt7621: add phandle to system
 controller node for watchdog
Content-Language: en-US
To:     Sergio Paracuellos <sergio.paracuellos@gmail.com>,
        linux-watchdog@vger.kernel.org
Cc:     wim@linux-watchdog.org, linux@roeck-us.net, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, matthias.bgg@gmail.com,
        tsbogend@alpha.franken.de, p.zabel@pengutronix.de,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-mips@vger.kernel.org
References: <20230211073357.755893-1-sergio.paracuellos@gmail.com>
 <20230211073357.755893-3-sergio.paracuellos@gmail.com>
From:   =?UTF-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>
In-Reply-To: <20230211073357.755893-3-sergio.paracuellos@gmail.com>
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
> To allow to access system controller registers from watchdog driver code
> add a phandle in the watchdog 'wdt' node. This avoid using arch dependent
> operations in driver code.
> 
> Signed-off-by: Sergio Paracuellos <sergio.paracuellos@gmail.com>

Reviewed-by: Arınç ÜNAL <arinc.unal@arinc9.com>

Thanks.
Arınç
