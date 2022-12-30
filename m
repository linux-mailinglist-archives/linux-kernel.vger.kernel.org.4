Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01C366598A7
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Dec 2022 14:22:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234993AbiL3NWn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Dec 2022 08:22:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbiL3NWm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Dec 2022 08:22:42 -0500
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEC331A05B;
        Fri, 30 Dec 2022 05:22:41 -0800 (PST)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 2BUDMSVq001704;
        Fri, 30 Dec 2022 07:22:28 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1672406548;
        bh=+D7sQawiDcYXeRgnc/n9jTpgspxAmapRIOe8XeRxsJs=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=DtU6UL0OVvTcjoc9tnrfYU4un1sX0onWzbiJQVm6E5wGJmBFdlSB1et9qJKOxQj6I
         WP1A44LYtf+nWu1IUe28kC3RQQ23b+6dPsep4v7OBuaIppNxwQExHeVe/FKELAdWfx
         gyLPnOHOZU1VbMwqXUiB5HlvwwWfw23Gm7Od917I=
Received: from DLEE105.ent.ti.com (dlee105.ent.ti.com [157.170.170.35])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 2BUDMSU7098933
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 30 Dec 2022 07:22:28 -0600
Received: from DLEE114.ent.ti.com (157.170.170.25) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16; Fri, 30
 Dec 2022 07:22:28 -0600
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16 via
 Frontend Transport; Fri, 30 Dec 2022 07:22:28 -0600
Received: from [10.249.48.175] (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 2BUDMSAE018844;
        Fri, 30 Dec 2022 07:22:28 -0600
Message-ID: <8b954442-40cd-1b2a-3682-248496e38462@ti.com>
Date:   Fri, 30 Dec 2022 07:22:28 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH 2/2] remoteproc: k3-c7x: Add support for C7xv DSP on AM62A
 SoC
Content-Language: en-US
To:     "Raghavendra, Vignesh" <vigneshr@ti.com>, <andersson@kernel.org>,
        <devicetree@vger.kernel.org>, <mathieu.poirier@linaro.org>,
        <p.zabel@pengutronix.de>, <linux-remoteproc@vger.kernel.org>,
        <robh+dt@kernel.org>, <linux-kernel@vger.kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <s-anna@ti.com>
CC:     <praneeth@ti.com>, <nm@ti.com>, <a-bhatia1@ti.com>,
        <j-luthra@ti.com>, <devarsht@ti.com>
References: <20221228123655.15384-1-hnagalla@ti.com>
 <20221228123655.15384-3-hnagalla@ti.com>
 <617decfc-bab6-2ba9-53de-c9a0462a2c2a@ti.com>
From:   Hari Nagalla <hnagalla@ti.com>
In-Reply-To: <617decfc-bab6-2ba9-53de-c9a0462a2c2a@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/28/22 07:32, Raghavendra, Vignesh wrote:
>> with anlytics engine for deep leraning purposes. The remoteproc
>> handling for device management is similar to the C66/C71 DSPs on K3
>> J7 family SoCs, even though there are additional hardware accelerators
>> and IP updates to C7xv subsystem.
>>
>> Signed-off-by: Hari Nagalla<hnagalla@ti.com>
>> Signed-off-by: Jai Luthra<j-luthra@ti.com>
>> ---
> Signed-off-by of submitter should be at the last.
> 
> I see original author of the patch is Jai here. So you need to amend the
> patch such that original author is set to Jai. His Signed-off-by should
> be the first and then yours.
> 
Thanks for pointing it out. Fixed, sending v2 with the corrections.
