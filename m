Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C49F6603D3
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Jan 2023 17:00:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232169AbjAFQA1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Jan 2023 11:00:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232920AbjAFQAH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jan 2023 11:00:07 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F37D6086D;
        Fri,  6 Jan 2023 08:00:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1673020806; x=1704556806;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Gr0ThjkBH4hqu7cX0DnaFFxx29/OpLOv7ZxaLh7iykA=;
  b=nBQCaQfpIu1WVkQ76CekdAqtHIs5brxCb4aeIrUgV9nNxGASMlXYXq9H
   kwDrkq6OcodV6w/wCBZQkhKThRqIw1lcrAJkDVs5E9pMsfDWRCcLJVgpg
   bK0+oz8vMJLnTI81U11QfV+AkzL5JRLYRjehiPJhTpI3hmAqz+HYLGf3A
   +4jvjke5x4t3ZsjcdJrUIgTl+JkiLtvR3Z6EQR1eKvK8+qHZaRrQVNaYy
   lmufyyExwXhtVjzHQIJdiWIfygEAOraVooNHbBcGa7zavRda3ppnNTNbX
   0SvhsxDIw3Vz88nRIPWMzOi10O3iuBzUqKT3D1WFleZQfSi8J0KLxcjtk
   g==;
X-IronPort-AV: E=Sophos;i="5.96,305,1665471600"; 
   d="scan'208";a="194620230"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 06 Jan 2023 09:00:05 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex02.mchp-main.com (10.10.87.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Fri, 6 Jan 2023 08:59:57 -0700
Received: from [10.159.245.112] (10.10.115.15) by chn-vm-ex02.mchp-main.com
 (10.10.85.144) with Microsoft SMTP Server id 15.1.2507.16 via Frontend
 Transport; Fri, 6 Jan 2023 08:59:54 -0700
Message-ID: <f653b23f-cf25-61ec-60d4-91dd7823edd2@microchip.com>
Date:   Fri, 6 Jan 2023 16:59:52 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v2] MAINTAINERS: Update email of Tudor Ambarus
To:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Tudor Ambarus <tudor.ambarus@linaro.org>
CC:     <arnd@arndb.de>, <richard@nod.at>,
        <krzysztof.kozlowski+dt@linaro.org>, <herbert@gondor.apana.org.au>,
        <robh+dt@kernel.org>, <akpm@linux-foundation.org>,
        <claudiu.beznea@microchip.com>, <broonie@kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-crypto@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-spi@vger.kernel.org>, <linux-mtd@lists.infradead.org>,
        <pratyush@kernel.org>, <michael@walle.cc>,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
References: <20221226144043.367706-1-tudor.ambarus@linaro.org>
 <feb09bac-0ea4-9154-362b-6d81cba352a8@linaro.org>
 <678ad800-7a3b-e2bf-6428-f06d696d8edb@linaro.org>
 <20230106165506.0a34fa78@xps-13>
Content-Language: en-US
From:   Nicolas Ferre <nicolas.ferre@microchip.com>
Organization: microchip
In-Reply-To: <20230106165506.0a34fa78@xps-13>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/01/2023 at 16:55, Miquel Raynal wrote:
> Hey Tudor, hello all,
> 
> tudor.ambarus@linaro.org wrote on Fri, 6 Jan 2023 17:45:20 +0200:
> 
>> Miquel,
>>
>> Since we don't have an answer from Arnd, would you please queue this to
>> mtd/fixes?
> 
> Are MAINTAINERS changes accepted through fixes PR? I see a number of
> experienced people in Cc:, I would like to hear from you folks, because
> I never had to do that before. If yes, then I'll do it right away,
> otherwise I'll apply to mtd/next. I'm all ears :)

I remember a conversation that stated that MAINTAINERS changes must land 
in Linus' tree the quickest, because it'll just avoid confusion and 
bouncing emails.

My $0.2...

Regards,
   Nicolas

-- 
Nicolas Ferre

