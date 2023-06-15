Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 173007312B5
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 10:50:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244337AbjFOIut (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 04:50:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244175AbjFOIuX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 04:50:23 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39755171F;
        Thu, 15 Jun 2023 01:50:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1686819022; x=1718355022;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=s6xySSvqAyBgvbFbPXNePC1dpE5fMWsiRXZNX2mbPaw=;
  b=Pp1uV2Pgka2Oj+hmLcr/6g7lhwzZMProv05IvKfP0VN6egFHfKey4r3N
   LzElvvDTZ0yWJngOnHtzCZy3bSJ4beh+PoUP5uLr/TSW4sSOMZNmWaPal
   nhvl2kGzsuVTwb8CEXw8koY9lowjD4J7jo1lhbPUTzaSo8sKGyRRXC4ht
   pt7ZZJl5Xs8j01pNTdEW/YjL7f/tM7I0CPQfnLh2r3D+UmR5CxkA4hOJS
   m4EKZhUI9WjRPdgpqwM/FBUWV3FcOqlQsV5MDcjBarKCey3TuFCZ8V6wZ
   DRNXeJ2vmZwGkHGsGvWBLJJ8z0uKPw1eFHxvgwyYzy1JthuaAyT7FYR9g
   g==;
X-IronPort-AV: E=Sophos;i="6.00,244,1681196400"; 
   d="scan'208";a="157080682"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 15 Jun 2023 01:50:20 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Thu, 15 Jun 2023 01:50:20 -0700
Received: from [10.159.245.112] (10.10.115.15) by chn-vm-ex01.mchp-main.com
 (10.10.85.143) with Microsoft SMTP Server id 15.1.2507.21 via Frontend
 Transport; Thu, 15 Jun 2023 01:50:17 -0700
Message-ID: <5fd62bc2-4383-8511-1e53-a4253e4a319f@microchip.com>
Date:   Thu, 15 Jun 2023 10:50:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH net-next v4 1/2] dt-bindings: net: cdns,macb: Add
 rx-watermark property
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Pranavi Somisetty <pranavi.somisetty@amd.com>,
        <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <claudiu.beznea@microchip.com>
CC:     <git@amd.com>, <michal.simek@amd.com>, <harini.katakam@amd.com>,
        <radhey.shyam.pandey@amd.com>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
References: <20230613054340.12837-1-pranavi.somisetty@amd.com>
 <20230613054340.12837-2-pranavi.somisetty@amd.com>
 <a3f053e9-b6b0-29a8-8b43-7abe5a43057b@linaro.org>
From:   Nicolas Ferre <nicolas.ferre@microchip.com>
Organization: microchip
In-Reply-To: <a3f053e9-b6b0-29a8-8b43-7abe5a43057b@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/06/2023 at 10:23, Krzysztof Kozlowski wrote:
> EXTERNAL EMAIL: Do not click links or open attachments unless you know the content is safe
> 
> On 13/06/2023 07:43, Pranavi Somisetty wrote:
>> watermark value is the minimum amount of packet data
>> required to activate the forwarding process. The watermark
>> implementation and maximum size is dependent on the device
>> where Cadence MACB/GEM is used.
>>
>> Signed-off-by: Pranavi Somisetty <pranavi.somisetty@amd.com>
>> ---
>> Changes v2:
> 
> 
> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

If mine is needed as well:
Acked-by: Nicolas Ferre <nicolas.ferre@microchip.com>


-- 
Nicolas Ferre

