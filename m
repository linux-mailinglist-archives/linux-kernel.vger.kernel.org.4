Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38F3C6D18DB
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 09:45:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230294AbjCaHpf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Mar 2023 03:45:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229561AbjCaHpc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Mar 2023 03:45:32 -0400
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17D4C12D;
        Fri, 31 Mar 2023 00:45:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1680248730; x=1711784730;
  h=subject:message-id:from:to:cc:date:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=nPnOXf+mYp3iMUEf2q4+nsf6byWz7qdqnBUi6q4GngI=;
  b=cuzIaO1Ib/2eReMwBkPWgjvl6YBp2KcMQyfK2TY2J0U/2agn730VIuno
   NLsEVJEWNfXIYdsLjUBXTFJbqJsYvGEsaHFDfSc4Q5l8yuc8MPPbCJNEL
   pFz/wMxLafWb1lhQwt7DxPIHQLJprA1IP9wWpZESZmoR7MWYDZOIB/oMw
   LpZc80bzvT1VLYUbQj062jl9tKxW0KKG9OTAsknx/9ceUu2AZbesJsbGK
   swlutqr4FpJVinWiJXgrdNsOq1uQ1YQyoS94LpjedM4zHmWZFdB1IohCJ
   XkA4NCKPnabrGqrAgWmp95k+zoDbOIrrEBQiA/HX/WgIziXjoLXEqgWHs
   A==;
X-IronPort-AV: E=Sophos;i="5.98,307,1673910000"; 
   d="scan'208";a="30062118"
Received: from unknown (HELO tq-pgp-pr1.tq-net.de) ([192.168.6.15])
  by mx1-pgp.tq-group.com with ESMTP; 31 Mar 2023 09:45:27 +0200
Received: from mx1.tq-group.com ([192.168.6.7])
  by tq-pgp-pr1.tq-net.de (PGP Universal service);
  Fri, 31 Mar 2023 09:45:27 +0200
X-PGP-Universal: processed;
        by tq-pgp-pr1.tq-net.de on Fri, 31 Mar 2023 09:45:27 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1680248727; x=1711784727;
  h=message-id:from:to:cc:date:in-reply-to:references:
   mime-version:content-transfer-encoding:subject;
  bh=nPnOXf+mYp3iMUEf2q4+nsf6byWz7qdqnBUi6q4GngI=;
  b=lyYSi0hns03j9/V8uqAb8Yaa/zMTOyQyKWIP3ae2tuqEmdZfh97xQkNE
   jcN6pznehtV/8DnttJF9MkgVrU8/E0wLBTBYi2ykP3GQNXpKR6S5HcTN9
   sPkllKDaSdedwTJ0BDp47YMrYvPF6SjM0AR5L78ucr+LMN/epI/mlQMZq
   qkZSVnNshjLgnfypQD9MU8+Pcbk+cMl+Sc4wEoQxY6PKDoP9JTZU3YHDd
   NnSU8OEwQWLIY5CiS8g25nNxF3ycwdtRujR07Xb9Fq3RZs8qKzA0eZ73f
   acx73oFoGApLNP070d/gNWHACEesQcVzSehHKCgzB7jdjq4smsbgvlgvQ
   Q==;
X-IronPort-AV: E=Sophos;i="5.98,307,1673910000"; 
   d="scan'208";a="30062117"
Subject: Re: Re: [PATCH V3 7/7] arm64: dts: imx8mp: add interconnect for hsio blk ctrl
Received: from vtuxmail01.tq-net.de ([10.115.0.20])
  by mx1.tq-group.com with ESMTP; 31 Mar 2023 09:45:27 +0200
Received: from NIEBEL-W3 (unknown [10.123.53.155])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by vtuxmail01.tq-net.de (Postfix) with ESMTPSA id D8A6A280056;
        Fri, 31 Mar 2023 09:45:26 +0200 (CEST)
Message-ID: <2924b1a62f126678870160bdbbf4e5d51aceb8d4.camel@ew.tq-group.com>
From:   Markus Niebel <Markus.Niebel@ew.tq-group.com>
To:     Greg Ungerer <gerg@kernel.org>,
        Marco Felsch <m.felsch@pengutronix.de>
Cc:     peng.fan@nxp.com,
        Alexander Stein <alexander.stein@ew.tq-group.com>,
        abailon@baylibre.com, krzysztof.kozlowski+dt@linaro.org,
        festevam@gmail.com, abelvesa@kernel.org, marex@denx.de,
        Ahmad Fatoum <a.fatoum@pengutronix.de>,
        paul.elder@ideasonboard.com, linux-imx@nxp.com,
        devicetree@vger.kernel.org,
        "Peng Fan (OSS)" <peng.fan@oss.nxp.com>, linux-pm@vger.kernel.org,
        s.hauer@pengutronix.de, robh+dt@kernel.org, aford173@gmail.com,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        laurent.pinchart@ideasonboard.com, linux-kernel@vger.kernel.org,
        kernel@pengutronix.de, djakov@kernel.org, shawnguo@kernel.org,
        l.stach@pengutronix.de
Date:   Fri, 31 Mar 2023 09:45:24 +0200
In-Reply-To: <792028b9-cd4c-4ff4-a7cb-e60c518aa573@kernel.org>
References: <20220703091451.1416264-8-peng.fan@oss.nxp.com>
         <20230327045037.593326-1-gerg@linux-m68k.org> <2678294.mvXUDI8C0e@steina-w>
         <b23a44ab-3666-8a41-d2a0-0d2fbdbd9f00@pengutronix.de>
         <ecd3a92b-ba1e-e7c1-088a-371bd1a2c100@linux-m68k.org>
         <20230328073302.jj64u5hvdpc6axa5@pengutronix.de>
         <426b4776-104c-cb47-c8cc-c26515fcb6e3@linux-m68k.org>
         <20230328134201.yaxrdtetjygkgkmz@pengutronix.de>
         <20230328135100.rbmnfelphe7juhxo@pengutronix.de>
         <c368a0f8-41f0-69ac-04f4-459e5fc8b9d6@linux-m68k.org>
         <20230328151100.msl46qupstwplkgw@pengutronix.de>
         <792028b9-cd4c-4ff4-a7cb-e60c518aa573@kernel.org>
Organization: TQ Systems GmbH
User-Agent: Evolution 3.36.5-0ubuntu1 
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

Am Freitag, dem 31.03.2023 um 15:55 +1000 schrieb Greg Ungerer:
> Hi Marco,
> 
> On 29/3/23 01:11, Marco Felsch wrote:
> > Hi Greg,
> > 
> > On 23-03-29, Greg Ungerer wrote:
> > > Hi Marco,
> > 
> > ...
> > 
> > > > I forgot to ask: Does your i.MX8MP have a VPU? There are
> > > > i.MX8MP devices
> > > > (don't know the name) which don't have support for certain IPs.
> > > > If this
> > > 
> > > The hardware platform I have is using the MIMX8ML4CVNKZAB "i.MX
> > > 8M Plus QuadLite"
> > > (https://www.nxp.com/part/MIMX8ML4CVNKZAB#/) which does not have
> > > the hardware
> > > video encode/decoder module (like the "i.MX 8M Plus Quad" parts).
> > 
> > and that's the problem :) You need to update your bootloader to a
> > version which support disabling the VPU nodes else you will always
> > see
> > the errors.
> 
> I agree this is the problem, I don't agree that the boot loader is
> the
> only place to fix this :-)  I should be able to generate a working
> devicetree
> blob from the kernel that is good, and ready to use no runtime
> changes
> required I figure.
> 

Just to point out: the approach of run time fixing in boot loader is
used for the other i.MX8M SOC, too. If you know exactly what SOC type
is assembled, you could disable non available IP in the board part of
your tree.

> It is not overly difficult to break out the vpu nodes and have them
> only included when you have a board that has the iMX8MP-quad with the
> VPU hardware blocks.
> 

Depending on the SOC type there is more to look for than the VPU: core
count, ISP, NPU - just to mention a few. Current approach allows to
keep a single tree for all types.

Regards, Markus

-- 
-- 
TQ-Systems GmbH | Mühlstraße 2, Gut Delling | 82229 Seefeld, Germany
Amtsgericht München, HRB 105018
Geschäftsführer: Detlef Schneider, Rüdiger Stahl, Stefan Schneider
http://www.tq-group.com/

