Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 562E4618E44
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 03:32:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231297AbiKDCcE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 22:32:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231393AbiKDCcC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 22:32:02 -0400
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A522C55A7;
        Thu,  3 Nov 2022 19:32:01 -0700 (PDT)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 2A42VkvS130916;
        Thu, 3 Nov 2022 21:31:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1667529106;
        bh=gcHERWs2mSrfMNDNIIJMza4iX1Fo2m0A7cuWSRnx0TI=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=uAKIOWPUaxvxHh+gL0rBGXt8EXPIFCBKzXUBudZbw3W1l2W5cElczLpHGPFHBGc5+
         oaF1LOeaGjw77JznjUkXIH9aqOP0CDzoIv3jc0gTxoTZ7Do+wMzrd7KNxSlT3ZRMll
         rRl5UWkOyMOTjGfXeFpVRQZb3mJ2yOkWGvNyNFNU=
Received: from DLEE103.ent.ti.com (dlee103.ent.ti.com [157.170.170.33])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 2A42VkrX023235
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 3 Nov 2022 21:31:46 -0500
Received: from DLEE100.ent.ti.com (157.170.170.30) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6; Thu, 3 Nov
 2022 21:31:46 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6 via
 Frontend Transport; Thu, 3 Nov 2022 21:31:46 -0500
Received: from [10.250.234.171] (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 2A42VhjP097295;
        Thu, 3 Nov 2022 21:31:44 -0500
Message-ID: <8220bff8-6800-7a41-5316-c4d629dff4fc@ti.com>
Date:   Fri, 4 Nov 2022 08:01:43 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH] spi: hisi-sfc-v3xx: Fix a typo ("duall")
To:     =?UTF-8?Q?Jonathan_Neusch=c3=a4fer?= <j.neuschaefer@gmx.net>,
        <linux-spi@vger.kernel.org>
CC:     John Garry <john.garry@huawei.com>,
        Mark Brown <broonie@kernel.org>, <linux-kernel@vger.kernel.org>
References: <20221103190052.915755-1-j.neuschaefer@gmx.net>
Content-Language: en-US
From:   Dhruva Gole <d-gole@ti.com>
In-Reply-To: <20221103190052.915755-1-j.neuschaefer@gmx.net>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 04/11/22 00:30, Jonathan Neuschäfer wrote:
> Simple typo, simple fix.
>
> Signed-off-by: Jonathan Neuschäfer <j.neuschaefer@gmx.net>

[...]

Reviewed-By: Dhruva Gole <d-gole@ti.com>

[...]

-- 
Best regards,
Dhruva Gole
Texas Instruments Incorporated

