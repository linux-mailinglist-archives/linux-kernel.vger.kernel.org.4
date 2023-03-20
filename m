Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41C6A6C0A27
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 06:36:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229655AbjCTFgb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 01:36:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbjCTFfv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 01:35:51 -0400
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81C7A1F5E2;
        Sun, 19 Mar 2023 22:34:42 -0700 (PDT)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 32K5YVie127523;
        Mon, 20 Mar 2023 00:34:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1679290471;
        bh=lG2X9obZvuudtgH7UvF290nF5C4M8JC2K0ve+oiB1Yc=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=L2I6tXX1VUQrYBJcS/o/W6iOnnxjxfXACgh5e4O66kXS3TwdhxPjKMVWfl5v5JHTx
         lPjtdLwUtwE5bt1zG5egkkv5vyNk1JYYuQimWh0yIystN9JbmO9ZPOyiJfp5lvRzGd
         4ljSmRH+VMc2Yw+5Fu5z49+JqpYMf5Av9EUmON4E=
Received: from DLEE107.ent.ti.com (dlee107.ent.ti.com [157.170.170.37])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 32K5YVTG013581
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 20 Mar 2023 00:34:31 -0500
Received: from DLEE107.ent.ti.com (157.170.170.37) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16; Mon, 20
 Mar 2023 00:34:30 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16 via
 Frontend Transport; Mon, 20 Mar 2023 00:34:30 -0500
Received: from [10.24.69.141] (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 32K5YOas089474;
        Mon, 20 Mar 2023 00:34:25 -0500
Message-ID: <8ed02bb8-b1a3-519f-d0c6-d36756e7e2c2@ti.com>
Date:   Mon, 20 Mar 2023 11:04:24 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v7 13/13] media: dt-bindings: Convert Cadence CSI2RX
 binding to YAML
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        <linux-media@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <mripard@kernel.org>, <mchehab@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>,
        <laurent.pinchart@ideasonboard.com>,
        <sakari.ailus@linux.intel.com>, <tomi.valkeinen@ideasonboard.com>
CC:     <linux-kernel@vger.kernel.org>, <bparrot@ti.com>,
        <niklas.soderlund+renesas@ragnatech.se>, <j-luthra@ti.com>,
        <devarsht@ti.com>, <praneeth@ti.com>, <u-kumar1@ti.com>,
        <vigneshr@ti.com>, <nm@ti.com>, <martyn.welch@collabora.com>
References: <20230314115516.667-1-vaishnav.a@ti.com>
 <20230314115516.667-14-vaishnav.a@ti.com>
 <f97ed61d-71d0-f05a-e4f8-abae8f9fbdd8@linaro.org>
From:   Vaishnav Achath <vaishnav.a@ti.com>
In-Reply-To: <f97ed61d-71d0-f05a-e4f8-abae8f9fbdd8@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Krzysztof,

On 15/03/23 13:15, Krzysztof Kozlowski wrote:
> On 14/03/2023 12:55, Vaishnav Achath wrote:
>> From: Pratyush Yadav <p.yadav@ti.com>
>>
>> Convert the Cadence CSI2RX binding to use YAML schema.
>>
>> Signed-off-by: Pratyush Yadav <p.yadav@ti.com>
>> Signed-off-by: Vaishnav Achath <vaishnav.a@ti.com>
>> Reviewed-by: Rob Herring <robh@kernel.org>
>> Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
>> ---
>>
>> (no changes since v5)
>>
> 
> So it seems your patchset is not bisectable. Fix this and test
> bisectability. All patchsets are expected to be fully bisectable.
> 

Thank you for the review, I will fix for bisect and address the rest of your
feedback in next revision and fix the order of bindings vs driver changes (will
wait for few more days for more feedback on the main j721e-csirx driver).

-- 
Thanks and Regards,
Vaishnav

> Best regards,
> Krzysztof
> 

