Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 123D2706252
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 10:10:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230270AbjEQIK2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 04:10:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230034AbjEQIKW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 04:10:22 -0400
Received: from mail.andi.de1.cc (mail.andi.de1.cc [IPv6:2a02:c205:3004:2154::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E64510C3;
        Wed, 17 May 2023 01:10:20 -0700 (PDT)
Received: from p5dcc3760.dip0.t-ipconnect.de ([93.204.55.96] helo=aktux)
        by mail.andi.de1.cc with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <andreas@kemnade.info>)
        id 1pzCEg-00087e-BY; Wed, 17 May 2023 10:10:14 +0200
Date:   Wed, 17 May 2023 10:10:10 +0200
From:   Andreas Kemnade <andreas@kemnade.info>
To:     Tony Lindgren <tony@atomide.com>
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, afd@ti.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org
Subject: Re: [PATCH v7 1/2] dt-bindings: omap: Partially convert omap.txt to
 yaml
Message-ID: <20230517101010.31142e67@aktux>
In-Reply-To: <20230517064031.GP14287@atomide.com>
References: <20230515074512.66226-1-andreas@kemnade.info>
        <20230515074512.66226-2-andreas@kemnade.info>
        <20230517064031.GP14287@atomide.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.24; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tony,

On Wed, 17 May 2023 09:40:31 +0300
Tony Lindgren <tony@atomide.com> wrote:

> * Andreas Kemnade <andreas@kemnade.info> [230515 07:45]:
> > From: Andrew Davis <afd@ti.com>
> > 
> > Convert omap.txt to yaml.  
> 
> Looks good to me, thanks a lot for doing this:
> 
> Reviewed-by: Tony Lindgren <tony@atomide.com>
> 
> Anreas, for future patch reference, care to summarize what's still
> blocking updating the rest of the TI SoCs for the binding? I think
> it may have been discussed earlier here and there already so apologies
> if I'm the only one who lost track :)
> 
The original patch by Andrew allows probably too many combinations of
compatibles for the rest of the SoCs (e.g.  pattern: '^ti,dra7[12456][024568p]).
I do not know the intention of that and nobody commented, so I would have to
do a lot of research, so I decided to split the work.

Regards,
Andreas
