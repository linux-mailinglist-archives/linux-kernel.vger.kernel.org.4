Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E05574CDF8
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 09:10:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229865AbjGJHKP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 03:10:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229823AbjGJHKK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 03:10:10 -0400
Received: from mg.richtek.com (mg.richtek.com [220.130.44.152])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9AE06129;
        Mon, 10 Jul 2023 00:10:07 -0700 (PDT)
X-MailGates: (SIP:2,PASS,NONE)(compute_score:DELIVER,40,3)
Received: from 192.168.10.47
        by mg.richtek.com with MailGates ESMTPS Server V6.0(2128796:0:AUTH_RELAY)
        (envelope-from <cy_huang@richtek.com>)
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256/256); Mon, 10 Jul 2023 15:09:56 +0800 (CST)
Received: from ex3.rt.l (192.168.10.46) by ex4.rt.l (192.168.10.47) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.25; Mon, 10 Jul
 2023 15:09:56 +0800
Received: from linuxcarl2.richtek.com (192.168.10.154) by ex3.rt.l
 (192.168.10.45) with Microsoft SMTP Server id 15.2.1118.25 via Frontend
 Transport; Mon, 10 Jul 2023 15:09:56 +0800
Date:   Mon, 10 Jul 2023 15:09:56 +0800
From:   ChiYuan Huang <cy_huang@richtek.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
CC:     <broonie@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>, <robh+dt@kernel.org>, <lgirdwood@gmail.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 0/2] Add compatible support for RT5733
Message-ID: <20230710070956.GA31191@linuxcarl2.richtek.com>
References: <1688048996-25606-1-git-send-email-cy_huang@richtek.com>
 <20230710014725.GA12147@linuxcarl2.richtek.com>
 <224afbe7-f0d5-ced2-a300-9e05789f08e8@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <224afbe7-f0d5-ced2-a300-9e05789f08e8@linaro.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 10, 2023 at 08:55:17AM +0200, Krzysztof Kozlowski wrote:
> On 10/07/2023 03:47, ChiYuan Huang wrote:
> > On Thu, Jun 29, 2023 at 10:29:54PM +0800, cy_huang@richtek.com wrote:
> > Hi,
> >> From: ChiYuan Huang <cy_huang@richtek.com>
> >>
> >> This series is to add the compatible support for rt5733 based on rt5739.
> >>
> > Sorry, not intend to ping, just want to check the current review status.
> > 
> > Any comment about this patch series?
> 
> You sent it during merge window, so what do you expect? What should
> happen during the merge window?
>
Since I do not know it's merge windows period, sorry to bother you guys.

Thanks for the notice. 
> Best regards,
> Krzysztof
> 
