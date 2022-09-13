Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 421E05B71DC
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Sep 2022 16:53:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231839AbiIMOrM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Sep 2022 10:47:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234588AbiIMOoC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Sep 2022 10:44:02 -0400
Received: from mail.3ffe.de (0001.3ffe.de [IPv6:2a01:4f8:c0c:9d57::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D10F65267;
        Tue, 13 Sep 2022 07:23:36 -0700 (PDT)
Received: from 3ffe.de (0001.3ffe.de [IPv6:2a01:4f8:c0c:9d57::1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.3ffe.de (Postfix) with ESMTPSA id 6F18422D1;
        Tue, 13 Sep 2022 16:21:24 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2022082101;
        t=1663078884;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=g0cz2RuwebJaTXH0eI4H1to3O9WXEkI2yKThc7wO9xs=;
        b=puA9H+i874EBUSaakIlALbTcIJMrhgUsmPKYhLqpOWbQ20JTJ5fVFwUB/0xL7PdtjoZNkn
        /LWHDZkmGolvwMHG6otGJgppi6NYVWn1e5Ux4UEQyg2OKcHnC8BjRHgY4iRIDnUIA0VNxN
        vg3s0PSonX5qKSLbx8UH7z7jRGR0Ho6oGhpbNamn+d0EvSIIe8CAUJz8rb1sIHY2YcBAQa
        FHTIxbnc7cadTKVIabma6BXzUJvc6zdu3MqM6ROQLiPvX7ninN5VJayFW6Cm5xOIThjlkf
        QjyP+ll1YRpedOOB89zlAk8nwDlU11gfigOL3zR2wAExzfa+yweYJabWn+5d6Q==
MIME-Version: 1.0
Date:   Tue, 13 Sep 2022 16:21:24 +0200
From:   Michael Walle <michael@walle.cc>
To:     Rob Herring <robh@kernel.org>
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>, Li Yang <leoyang.li@nxp.com>,
        =?UTF-8?Q?Rafa=C5=82_Mi=C5=82ecki?= <rafal@milecki.pl>,
        Frank Rowand <frowand.list@gmail.com>,
        linux-mtd@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Ahmad Fatoum <a.fatoum@pengutronix.de>,
        Philipp Zabel <p.zabel@pengutronix.de>
Subject: Re: [PATCH v2 15/20] dt-bindings: nvmem: add YAML schema for the sl28
 vpd layout
In-Reply-To: <20220912192038.GA1661550-robh@kernel.org>
References: <20220901221857.2600340-1-michael@walle.cc>
 <20220901221857.2600340-16-michael@walle.cc>
 <20220912192038.GA1661550-robh@kernel.org>
User-Agent: Roundcube Webmail/1.4.13
Message-ID: <aa53a858e362ae747a2cbd28caa3fa78@walle.cc>
X-Sender: michael@walle.cc
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 2022-09-12 21:20, schrieb Rob Herring:

>> +  base-mac-address:
>> +    type: object
>> +    description:
>> +      Base MAC address for all on-module network interfaces. The 
>> first
>> +      argument of the phandle will be treated as an offset.
>> +
>> +    properties:
>> +      "#nvmem-cell-cells":
> 
> You can't just add a new #.*-cells buried in a device binding. I'm fine
> with the concept though having more than 1 user would be nice.

I was under the impression the tooling will handle it, but as you
pointed out below, this isn't the case for a missing default. The
statement above should only be to validate that there is one
additional argument if the base-mac-address node is used in a
phandle.

> Any case that doesn't match foos->#foo-cells or has a default # of
> cells if missing (as this does) has to be added to dtschema to decode 
> it
> properly. It won't really matter until there's a user with 2 or more
> entries. I'm happy to do update the dtschema part, but I'd prefer to 
> see
> the schema in dtschema rather than the kernel.

Ok, but I'm not sure I understand you correctly here. You will
update the dtschema tooling (I guess it's about fixup_phandles() in
dtb.py) and which schema should be in dtschema? nvmem.yaml
and/or nvmem-consumer.yaml? The entire schema or only a
subset of it?

-michael
