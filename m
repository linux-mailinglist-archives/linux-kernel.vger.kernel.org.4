Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6113B70D9A5
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 11:56:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236123AbjEWJ4W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 05:56:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233200AbjEWJ4R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 05:56:17 -0400
Received: from www530.your-server.de (www530.your-server.de [188.40.30.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D651118;
        Tue, 23 May 2023 02:56:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=geanix.com;
        s=default2211; h=To:References:Message-Id:Content-Transfer-Encoding:Cc:Date:
        In-Reply-To:From:Subject:Mime-Version:Content-Type:Sender:Reply-To:Content-ID
        :Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=sPTpaU0MI+AKYcYS7XYeyiGHQ1aUICs7uWVzSFG0HuU=;
        b=sIfySMTYO/8E3llsH3sU3FFRfPRssMKDqQZ2wWuMxhNmab6goU1CVBuObnab5YlRn9fFAdRBZ59
        Ynepm4voH0sK8HmQR8xLBXNJ1k+Ou6rK67sbFIvR3MgVwPXB7BXglfKnkWO6u6JGGZs36I90rHx9k
        qUGqpHhg6mYtoRH6Y8XdwPXZRlKvUHrGPYjVMCj48+f5oYQpfK6oPZhuWt/tX9rRrFwEGX0POZNyI
        CJcmnq5E8QZKCVGn64VQC5Y9/xnqkCBoHBOjYDwfuQELsMJUOfS2wUzaRvKd1OTp6P1Sxd7I9FoHw
        em8wHE6EPkF1/9g80/Or/DuE10ItjVUOBjIQ==;
Received: from sslproxy03.your-server.de ([88.198.220.132])
        by www530.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <sean@geanix.com>)
        id 1q1OkL-000PUc-Q9; Tue, 23 May 2023 11:56:01 +0200
Received: from [185.17.218.86] (helo=smtpclient.apple)
        by sslproxy03.your-server.de with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.92)
        (envelope-from <sean@geanix.com>)
        id 1q1OkL-000Fvb-Cn; Tue, 23 May 2023 11:56:01 +0200
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3731.600.7\))
Subject: Re: [PATCH v2 3/3] dt-bindings: mfd: stpmic1: add fsl,pmic-poweroff
 property
From:   =?utf-8?Q?Sean_Nyekj=C3=A6r?= <sean@geanix.com>
In-Reply-To: <20230516-footprint-handoff-bcd553ff6146@spud>
Date:   Tue, 23 May 2023 11:55:50 +0200
Cc:     robh+dt@kernel.org, Lee Jones <lee@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        pascal Paillet <p.paillet@foss.st.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <9B1EE405-77D3-4980-9A13-9D4F87C1A64F@geanix.com>
References: <20230516132225.3012541-1-sean@geanix.com>
 <20230516132225.3012541-3-sean@geanix.com>
 <20230516-footprint-handoff-bcd553ff6146@spud>
To:     Conor Dooley <conor@kernel.org>
X-Mailer: Apple Mail (2.3731.600.7)
X-Authenticated-Sender: sean@geanix.com
X-Virus-Scanned: Clear (ClamAV 0.103.8/26916/Tue May 23 09:22:39 2023)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey Conor,

> On 16 May 2023, at 20.06, Conor Dooley <conor@kernel.org> wrote:
>=20
> Hey Sean,
>=20
> On Tue, May 16, 2023 at 03:22:24PM +0200, Sean Nyekjaer wrote:
>> Document the new optional "fsl,pmic-poweroff" property.
>>=20
>> Signed-off-by: Sean Nyekjaer <sean@geanix.com>
>> ---
>> Documentation/devicetree/bindings/mfd/st,stpmic1.yaml | 8 ++++++++
>> 1 file changed, 8 insertions(+)
>>=20
>> diff --git a/Documentation/devicetree/bindings/mfd/st,stpmic1.yaml =
b/Documentation/devicetree/bindings/mfd/st,stpmic1.yaml
>> index 9573e4af949e..5183a7c660d2 100644
>> --- a/Documentation/devicetree/bindings/mfd/st,stpmic1.yaml
>> +++ b/Documentation/devicetree/bindings/mfd/st,stpmic1.yaml
>> @@ -26,6 +26,14 @@ properties:
>>=20
>>   interrupt-controller: true
>>=20
>> +  st,pmic-poweroff:
>> +    $ref: /schemas/types.yaml#/definitions/flag
>> +    description: |
>> +      if present, configure the PMIC to shutdown all power rails =
when
>> +      power off sequence have finished.
>> +      Use this option if the SoC should be powered off by external =
power management
>> +      IC (PMIC).
>=20
> Just reading this description, this is sounding quite like a "software
> behaviour" type of property, which are not permitted, rather than
> describing some element of the hardware. Clearly you are trying to =
solve
> an actual problem though, so try re-phrasing the description (and
> property name) to focus on what exact hardware configuration it is =
that
> you are trying to special-case.
> Krzysztof suggested that the samsung,s2mps11-acokb-ground property in
> samsung,s2mps11.yaml is addressing a similar problem, so that could be
> good to look at.

Better wording?
      Indicates that the power management IC (PMIC) is used to power off =
the board.
      So as the last step in the power off sequence set the SWOFF bit in =
the
      main control register (MAIN_CR) register, to shutdown all power =
rails.

>=20
> Also, the dt-binding patch should go before the patch adding the
> property to the driver.
>=20

I will switch them around.

> Thanks,
> Conor.

/Sean

