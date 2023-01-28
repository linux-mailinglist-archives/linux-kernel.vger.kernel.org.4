Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3954B67F6A8
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Jan 2023 10:22:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233336AbjA1JWU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Jan 2023 04:22:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229464AbjA1JWR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Jan 2023 04:22:17 -0500
Received: from sender3-op-o19.zoho.com (sender3-op-o19.zoho.com [136.143.184.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 778B2EC55;
        Sat, 28 Jan 2023 01:22:16 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1674897723; cv=none; 
        d=zohomail.com; s=zohoarc; 
        b=jw5wUlkaB4m9q6pEVFsXF4b0811CfM9e1oARm78QqCfwHPUUfgsa9Wp29SR8pJnobS6IG5bmDeswqGzw1GrXYbTdaRdtQ7qHdH9po+flVI7v55xGzI1PNvj9199+C8KP5VqWdtWiT4z0KPWhj2ciEy05gPKV/CbPnXF/UChaA7U=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
        t=1674897723; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=c3mLu0aZy6uOCJK19gTsXRIo6vWN4vTKXGm5RXWhOI4=; 
        b=iH+7iZmRSJ7e/C4oRmWspY9B4dtW4Tj//sFvEcs1qKd5H7GRMTPzUPFa0tUODkJpcOj9YRBEbQCC9X7+yJe/TcqLZqHL5qxsHdTl3WJfaDhcFIYmPfPmDmigTHm9Ljb92IX7QeNHGzt+H3OgjRPCITdxhVAV4yKPYfMrrVhNnn0=
ARC-Authentication-Results: i=1; mx.zohomail.com;
        dkim=pass  header.i=linux.beauty;
        spf=pass  smtp.mailfrom=me@linux.beauty;
        dmarc=pass header.from=<me@linux.beauty>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1674897723;
        s=zmail; d=linux.beauty; i=me@linux.beauty;
        h=Date:Date:From:From:To:To:Cc:Cc:Message-ID:In-Reply-To:References:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
        bh=c3mLu0aZy6uOCJK19gTsXRIo6vWN4vTKXGm5RXWhOI4=;
        b=JxoTha8s2+otH6d+ax19Tof19CtLi63UqtDiyo0aXLmgjYvqpyaxsv+b0UCdAj2y
        y4xrYVwt7gOijtCWM4C0vYarNj7tBJsQN2P1O4gXSeIf7VJruyrPZpNOBT3LPgJYn/J
        yXnQZAHAV1H5t5UBduBdVTUBffOVPHy5vXpGpokU=
Received: from mail.zoho.com by mx.zohomail.com
        with SMTP id 1674897720911736.6953243528183; Sat, 28 Jan 2023 01:22:00 -0800 (PST)
Date:   Sat, 28 Jan 2023 17:22:00 +0800
From:   Li Chen <me@linux.beauty>
To:     "Krzysztof Kozlowski" <krzysztof.kozlowski@linaro.org>
Cc:     "li chen" <lchen@ambarella.com>,
        "greg kroah-hartman" <gregkh@linuxfoundation.org>,
        "rob herring" <robh+dt@kernel.org>,
        "krzysztof kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        "moderated list:arm/ambarella soc support" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:serial drivers" <linux-serial@vger.kernel.org>,
        "open list:open firmware and flattened device tree bindings" 
        <devicetree@vger.kernel.org>,
        "open list" <linux-kernel@vger.kernel.org>
Message-ID: <185f7af063c.f732379f485828.699470667125550366@linux.beauty>
In-Reply-To: <c1793a63-5691-a705-b2f2-4267c53934fe@linaro.org>
References: <20230123073305.149940-1-lchen@ambarella.com>
 <20230123073305.149940-10-lchen@ambarella.com>
 <bdff58bf-1a07-ab78-a782-d58d8c644e00@linaro.org>
 <87wn5bgcrv.wl-me@linux.beauty> <c1793a63-5691-a705-b2f2-4267c53934fe@linaro.org>
Subject: Re: [PATCH 09/15] dt-bindings: serial: add support for Ambarella
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Importance: Medium
User-Agent: Zoho Mail
X-Mailer: Zoho Mail
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzysztof,

Sorry for my late reply.

 ---- On Wed, 25 Jan 2023 17:56:15 +0800  Krzysztof Kozlowski  wrote --- 
 > On 25/01/2023 10:54, Li Chen wrote:
 > > 
 > > Hi Krzysztof Kozlowski,
 > > 
 > > Sorry for my late reply.
 > > 
 > > On Mon, 23 Jan 2023 16:11:52 +0800,
 > > Krzysztof Kozlowski wrote:
 > >>
 > >> On 23/01/2023 08:32, Li Chen wrote:
 > >>> Add compatible for Ambarella.
 > >>>
 > >>> Signed-off-by: Li Chen lchen@ambarella.com>
 > >>> Change-Id: I32513d98f52af0311dfb55dd5c4739a58f6b9fc1
 > >>> ---
 > >>>  .../bindings/serial/ambarella_uart.yaml       | 57 +++++++++++++++++++
 > >>>  MAINTAINERS                                   |  1 +
 > >>>  2 files changed, 58 insertions(+)
 > >>>  create mode 100644 Documentation/devicetree/bindings/serial/ambarella_uart.yaml
 > >>>
 > >>> diff --git a/Documentation/devicetree/bindings/serial/ambarella_uart.yaml b/Documentation/devicetree/bindings/serial/ambarella_uart.yaml
 > >>> new file mode 100644
 > >>> index 000000000000..238d68078270
 > >>> --- /dev/null
 > >>> +++ b/Documentation/devicetree/bindings/serial/ambarella_uart.yaml
 > >>> @@ -0,0 +1,57 @@
 > >>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
 > >>> +%YAML 1.2
 > >>> +---
 > >>> +$id: http://devicetree.org/schemas/serial/ambarella_uart.yaml#
 > >>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
 > >>> +
 > >>> +title: Ambarella S6LM SoC UART Controller
 > >>> +
 > >>> +maintainers:
 > >>> +  - Li Chen lchen@ambarella.com>
 > >>> +
 > >>> +properties:
 > >>> +  compatible:
 > >>> +    const: ambarella,uart
 > >>> +
 > >>> +  reg:
 > >>> +    maxItems: 1
 > >>> +
 > >>> +  amb,ignore-fe:
 > >>> +    description: |
 > >>> +      ignore frame error report for CV2/CV22/CV25/S6LM because it's
 > >>> +      checked too strict so that normal stop may be treated as frame error.
 > >>
 > >> Missing type. I don't understand why this is property of DT.
 > > 
 > > Ok, I will add "type: boolean" to it.
 > 
 > I still do not understand why this is a property of DT. You need to
 > justify it.
 > 
 > Otherwise: No. drop it.

Yes, this property is not describing hardware. I will drop it from dts and handle it via soc_device_attribute->data
or of_device_id->data instead.

Regards,
Li
