Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB7DD74CE3C
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 09:23:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229683AbjGJHXq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 03:23:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjGJHXo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 03:23:44 -0400
Received: from mg.richtek.com (mg.richtek.com [220.130.44.152])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B58DECC
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 00:23:41 -0700 (PDT)
X-MailGates: (SIP:2,PASS,NONE)(compute_score:DELIVER,40,3)
Received: from 192.168.10.46
        by mg.richtek.com with MailGates ESMTPS Server V6.0(2128825:0:AUTH_RELAY)
        (envelope-from <alina_yu@richtek.com>)
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256/256); Mon, 10 Jul 2023 15:23:35 +0800 (CST)
Received: from ex3.rt.l (192.168.10.46) by ex3.rt.l (192.168.10.46) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.25; Mon, 10 Jul
 2023 15:23:35 +0800
Received: from linuxcarl2.richtek.com (192.168.10.154) by ex3.rt.l
 (192.168.10.45) with Microsoft SMTP Server id 15.2.1118.25 via Frontend
 Transport; Mon, 10 Jul 2023 15:23:35 +0800
Date:   Mon, 10 Jul 2023 15:23:35 +0800
From:   Alina Yu <alina_yu@richtek.com>
To:     Krzysztof Kozlowski <krzk@kernel.org>
CC:     <broonie@kernel.org>, <linux-kernel@vger.kernel.org>,
        <cy_huang@richtek.com>, <alina_yu@richtek.com>
Subject: Re: [PATCH v2 1/2] regulator: dt-bindings: rtq2208: Add Richtek
 RTQ2208 SubPMIC
Message-ID: <20230710072335.GA30810@linuxcarl2.richtek.com>
References: <cover.1688569987.git.alina_yu@richtek.com>
 <341af3996c430549243365bb8204d33a15a482be.1688569987.git.alina_yu@richtek.com>
 <d3308334-aa91-f265-2469-8a6fbc727798@kernel.org>
 <20230706103040.GA32138@linuxcarl2.richtek.com>
 <20230710030858.GA16636@linuxcarl2.richtek.com>
 <8b5bde1a-08e2-15ad-ebe1-08a16de00468@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <8b5bde1a-08e2-15ad-ebe1-08a16de00468@kernel.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 10, 2023 at 08:02:39AM +0200, Krzysztof Kozlowski wrote:
> On 10/07/2023 05:08, Alina Yu wrote:
> >> Yes, "0" refers to DVS0 registers, and "1" refers to DVS1.
> >> and there is only DVS0 and DVS1, so I use boolean to check which one is used.
> >>
> >> Is it more understandable if I modify that to enum ? And description will be like this
> >>
> >> richtek,mtp-sel:
> >>   enum: [0, 1]
> >>     description: |
> >>       vout register selection besed on this value.
> >>       0 - Using DVS0 register setting to adjust vout
> >>       1 - Using DVS1 register setting to adjust vout
> >>
> > 
> > May I ask one more question ?
> > If I modify the name into "richtek,mtp-sel-high", is that more understandable ?
> > It will be like this,
> > 
> > richtek,mtp-sel-high:
> >   type: boolean
> >   description:
> >   vout register selection besed on this value.
> >   0 - Using DVS0 register setting to adjust vout
> >   1 - Using DVS1 register setting to adjust vout
> 
> You don't have 0 or 1 values in such case. The property can be bool, but
> description is not good.
> 

May I modify the description like this ?

richtek,mtp-sel-high:
  type: boolean
  description:
  vout register selection besed on this boolean value.
  false - Using DVS0 register setting to adjust vout
  true - Using DVS1 register setting to adjust vout


BR,
Alina.
