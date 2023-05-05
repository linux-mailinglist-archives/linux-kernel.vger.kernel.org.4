Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58DAE6F8438
	for <lists+linux-kernel@lfdr.de>; Fri,  5 May 2023 15:38:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232674AbjEENi1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 May 2023 09:38:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232370AbjEENiV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 May 2023 09:38:21 -0400
Received: from mickerik.phytec.de (mickerik.phytec.de [91.26.50.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF8851F4AB
        for <linux-kernel@vger.kernel.org>; Fri,  5 May 2023 06:38:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; d=phytec.de; s=a4; c=relaxed/simple;
        q=dns/txt; i=@phytec.de; t=1683293896; x=1685885896;
        h=From:Sender:Reply-To:Subject:Date:Message-ID:To:CC:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=wxFL9G0S/t93w0CmIn6+BXOdHjm0l4hb+AZgw9N18gw=;
        b=jUdQH0lZxkWf7us5n9znI8hkLbqzDq3c888YSRBOD4bA6xtR/+hXqJ4fYV6yjVbr
        g5kLbm+VjVHLh0aaEycShENNgitYLpFfsW75447aXh1raHLo9/jZ5Vezv++yF/N8
        fHqf5IvRVfYMwroXRJkm9KCCx9yGyZsQKwWZ//sxs+k=;
X-AuditID: ac14000a-917fe70000007ecb-db-645506c8124e
Received: from berlix.phytec.de (Unknown_Domain [172.25.0.12])
        (using TLS with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client did not present a certificate)
        by mickerik.phytec.de (PHYTEC Mail Gateway) with SMTP id 68.F8.32459.8C605546; Fri,  5 May 2023 15:38:16 +0200 (CEST)
Received: from [172.25.39.28] (172.25.0.11) by Berlix.phytec.de (172.25.0.12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Fri, 5 May
 2023 15:38:14 +0200
Message-ID: <8db31b08-5a8b-f317-a954-c228a08004a8@phytec.de>
Date:   Fri, 5 May 2023 15:38:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 2/2] arm64: dts: ti: Add basic support for
 phyBOARD-Lyra-AM625
Content-Language: en-US
To:     Tony Lindgren <tony@atomide.com>, Nishanth Menon <nm@ti.com>
CC:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-hardening@vger.kernel.org>, <upstream@lists.phytec.de>,
        <vigneshr@ti.com>, <kristo@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <keescook@chromium.org>,
        <tony.luck@intel.com>, <gpiccoli@igalia.com>
References: <20230504140143.1425951-1-w.egorov@phytec.de>
 <20230504140143.1425951-2-w.egorov@phytec.de>
 <20230504142643.pkzsftrsrqph4vql@banked> <20230505093930.GS14287@atomide.com>
From:   Wadim Egorov <w.egorov@phytec.de>
In-Reply-To: <20230505093930.GS14287@atomide.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [172.25.0.11]
X-ClientProxiedBy: Florix.phytec.de (172.25.0.13) To Berlix.phytec.de
 (172.25.0.12)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrCIsWRmVeSWpSXmKPExsWyRpKBR/cEW2iKwcbJnBbzj5xjtZh3/jC7
        xZnuXIvln2ezW/S9eMhssenxNaD4+p+MFpd3zWGzePPjLJNF694j7BZvLtxjsdh/xcui+526
        xf+zH9gd+Dy+fZ3E4jG74SKLx4TZ3Wwei/e8ZPLYtKqTzePOtT1sHpuX1Hv0d7ewehy/sZ3J
        4/MmuQCuKC6blNSczLLUIn27BK6M5+0vWQraeSrett9hamA8xtnFyMkhIWAi8eXOO/YuRi4O
        IYElTBKPJ59mhHDuMkpsnPmbDaSKV8BGom/5PFYQm0VAReLItcVMEHFBiZMzn7CA2KIC0RI3
        ln8DiwsLhEh8P/YbzGYWEJe49WQ+mC0i4CAxfccHZoj4TSaJ58stIJbtZJRo/ruPHSTBJqAu
        cWfDN7BlnAKGEpsv3WGDaLCQWPzmIDuELS+x/e0csEFCQPaLS8tZIN6Rl5h27jUzhB0qcWTT
        aqYJjMKzkNw6C8lNs5CMnYVk7AJGllWMQrmZydmpRZnZegUZlSWpyXopqZsYQTErwsC1g7Fv
        jschRiYOxkOMEhzMSiK8Hwr9UoR4UxIrq1KL8uOLSnNSiw8xSnOwKInz3u9hShQSSE8sSc1O
        TS1ILYLJMnFwSjUwmqyZtbNh8pnHnhvP5Hydv+TF23szZ3ydoLxR3iHp7bvz0VxrPXK1Z3fv
        mxzDLuBc8e9VSJyrURnD0k/2LL2VMvfj7re9k9uT9F1v2nGeaamz41dMbW7gieg9/VA1Z5d8
        0veJr4pi5bZeWBEjab/m7fXjlX8W/stT/XLsZN7i2XOUl7wx7FpWnqfEUpyRaKjFXFScCAAK
        rC1sxwIAAA==
X-Spam-Status: No, score=-6.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Am 05.05.23 um 11:39 schrieb Tony Lindgren:
> * Nishanth Menon <nm@ti.com> [230504 14:33]:
>> Just wondering: if the carrier board can easily work with different
>> SoMs.. in which case, we could do overlay to create the som + carrier
>> overlay to create rdk dtb - this might allow the scheme to scale to
>> additional SoMs and carrier combinations.. and the SoM dtb could be
>> sufficient for something like a bootloader.
> It might be best to limit the overlay usage to devices that might see
> dual use on the carrier board.. Not sure if setting up the entire
> carrier board makes sense as an overlay :) Not sure if folks want to
> debug boot issues on a remote server for example if an overlay is
> needed to boot with Ethernet :)

Our idea is to create overlays for SoM variants, e.g. an overlay for a SoM 
without SPI NOR flash populated.
If we want to reuse a carrier board, we could factor out the carrier board dts 
into a dtsi file and provide the needed combinations in form of different dts files.

In the bootloader world the situation is a bit different.
Here we would like to have a universal phycore_am62x "board" that should be able 
to handle most carrier board designs using that SoM. And since u-boot is moving 
towards having a single source of device trees, this concept will probably no 
longer work anymore. So your idea with a SoM dtb sounds interesting.
I wonder what ideas other SoM vendors have or how it is handled on other 
architectures.

Regards,
Wadim

>
> Regards,
>
> Tony
