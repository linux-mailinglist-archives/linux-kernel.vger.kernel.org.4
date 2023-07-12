Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC62A75028F
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 11:12:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232068AbjGLJMM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 05:12:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229610AbjGLJMJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 05:12:09 -0400
Received: from www530.your-server.de (www530.your-server.de [188.40.30.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E588FB;
        Wed, 12 Jul 2023 02:12:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=geanix.com;
        s=default2211; h=To:References:Message-Id:Content-Transfer-Encoding:Cc:Date:
        In-Reply-To:From:Subject:Mime-Version:Content-Type:Sender:Reply-To:Content-ID
        :Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=aQra3Uq/mkNc3te3ij718BXDMrPqbP8wZ5ecEv6aL4k=;
        b=SIGrgma6Kq5y2QQwAagG/1vXkByFdmBj98YZy8r2KaSM66jDgH/fKCNjxzQfoMxyg1EKK2zLFbs
        7GQQiTnRXBzRY4oIbnTbUDxo0D9AeK5M32rjCgxg2gpywg6EQqYT401JRObGezIWEJY4md1kyaD3f
        B/nxt8uwDa/qSBY7OXUHkIU2c+HI4R64MVqh80oJywklq7ToWne4JxWuzNvb2qYxDb43PKjQPt236
        +dG1H3ZeLU/g9+1K0IDhEmosWD3olRaD8RuTQnttK8gQ+2/LP/u8FtdKD2m4IGB6yqyEQAG2+Tat2
        ZLN3A3MQ/EZqIZB8P3VQOFSNy3NsAToBtBJQ==;
Received: from sslproxy02.your-server.de ([78.47.166.47])
        by www530.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <sean@geanix.com>)
        id 1qJVtF-000EK2-De; Wed, 12 Jul 2023 11:12:05 +0200
Received: from [2a06:4004:10df:0:6cc7:3173:9f32:f330] (helo=smtpclient.apple)
        by sslproxy02.your-server.de with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.92)
        (envelope-from <sean@geanix.com>)
        id 1qJVtE-00048P-N4; Wed, 12 Jul 2023 11:12:04 +0200
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3731.600.7\))
Subject: Re: [PATCH v3 7/8] dt-bindings: arm: stm32: add extra SiP compatible
 for oct,stm32mp157c-osd32-red
From:   Sean Nyekjaer <sean@geanix.com>
In-Reply-To: <92f7f4cd-c9cc-8a1a-74c7-39eed955cd6a@pengutronix.de>
Date:   Wed, 12 Jul 2023 11:11:53 +0200
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        dantuguf14105@gmail.com, Conor Dooley <conor.dooley@microchip.com>,
        devicetree@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <92C36A18-F359-497E-8267-03E5C62811F6@geanix.com>
References: <20230712062954.2194505-1-sean@geanix.com>
 <20230712062954.2194505-7-sean@geanix.com>
 <92f7f4cd-c9cc-8a1a-74c7-39eed955cd6a@pengutronix.de>
To:     Ahmad Fatoum <a.fatoum@pengutronix.de>
X-Mailer: Apple Mail (2.3731.600.7)
X-Authenticated-Sender: sean@geanix.com
X-Virus-Scanned: Clear (ClamAV 0.103.8/26967/Wed Jul 12 09:28:32 2023)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On 12 Jul 2023, at 10.38, Ahmad Fatoum <a.fatoum@pengutronix.de> =
wrote:
>=20
> Hello Sean,
>=20
> On 12.07.23 08:29, Sean Nyekjaer wrote:
>> Add binding support for the Octavo OSD32MP1-RED development board.
>>=20
>> General features:
>> - STM32MP157C
>> - 512MB DDR3
>> - CAN-FD
>> - HDMI
>> - USB-C OTG
>> - UART
>>=20
>> Signed-off-by: Sean Nyekjaer <sean@geanix.com>
>> Acked-by: Conor Dooley <conor.dooley@microchip.com>
>=20
> Just a heads up: The LXA TAC, another OSD32MP1 board has been merged =
into
> stm32-next yesterday, so applying your series onto that tree may =
result
> in conflicts. You may want to rebase for v4.
>=20
> Cheers,
> Ahmad

Thanks, will do :)

Can I get you to look at 4/8, 5/8 and 6/8 in this series? Will they =
break anything for LXA TAC?

/Sean

>=20
>=20
>> ---
>> Documentation/devicetree/bindings/arm/stm32/stm32.yaml | 3 ++-
>> 1 file changed, 2 insertions(+), 1 deletion(-)
>>=20
>> diff --git a/Documentation/devicetree/bindings/arm/stm32/stm32.yaml =
b/Documentation/devicetree/bindings/arm/stm32/stm32.yaml
>> index 13e34241145b..55e45db1af26 100644
>> --- a/Documentation/devicetree/bindings/arm/stm32/stm32.yaml
>> +++ b/Documentation/devicetree/bindings/arm/stm32/stm32.yaml
>> @@ -143,7 +143,8 @@ properties:
>>       - description: Octavo OSD32MP15x System-in-Package based boards
>>         items:
>>           - enum:
>> -              - lxa,stm32mp157c-mc1 # Linux Automation MC-1
>> +              - lxa,stm32mp157c-mc1       # Linux Automation MC-1
>> +              - oct,stm32mp157c-osd32-red # Octavo OSD32MP1 RED =
board
>>           - const: oct,stm32mp15xx-osd32
>>           - enum:
>>               - st,stm32mp157
>=20
> --=20
> Pengutronix e.K.                           |                           =
  |
> Steuerwalder Str. 21                       | =
http://www.pengutronix.de/  |
> 31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0  =
  |
> Amtsgericht Hildesheim, HRA 2686           | Fax:   =
+49-5121-206917-5555 |



