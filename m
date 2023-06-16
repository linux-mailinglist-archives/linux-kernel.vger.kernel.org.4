Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C35F37333F6
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 16:50:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345745AbjFPOuf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 10:50:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229706AbjFPOue (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 10:50:34 -0400
Received: from sonata.ens-lyon.org (domu-toccata.ens-lyon.fr [140.77.166.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E64F30E7;
        Fri, 16 Jun 2023 07:50:32 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by sonata.ens-lyon.org (Postfix) with ESMTP id 2D6EE20135;
        Fri, 16 Jun 2023 16:50:30 +0200 (CEST)
Received: from sonata.ens-lyon.org ([127.0.0.1])
        by localhost (sonata.ens-lyon.org [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id h_zPkR2w8rQC; Fri, 16 Jun 2023 16:50:30 +0200 (CEST)
Received: from begin (nat-inria-interne-52-gw-01-bso.bordeaux.inria.fr [194.199.1.52])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by sonata.ens-lyon.org (Postfix) with ESMTPSA id 80AA220107;
        Fri, 16 Jun 2023 16:50:29 +0200 (CEST)
Received: from samy by begin with local (Exim 4.96)
        (envelope-from <samuel.thibault@ens-lyon.org>)
        id 1qAAmS-006jR9-2M;
        Fri, 16 Jun 2023 16:50:28 +0200
Date:   Fri, 16 Jun 2023 16:50:28 +0200
From:   Samuel Thibault <samuel.thibault@ens-lyon.org>
To:     Muhammad Usama Anjum <usama.anjum@collabora.com>
Cc:     William Hubbs <w.d.hubbs@gmail.com>,
        Chris Brannon <chris@the-brannons.com>,
        Kirk Reiser <kirk@reisers.ca>, kernel@collabora.com,
        kernel-janitors@vger.kernel.org, speakup@linux-speakup.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] accessibility: speakup: remove linux/version.h
Message-ID: <20230616145028.7rzrbqfj7wmoenj6@begin>
Mail-Followup-To: Samuel Thibault <samuel.thibault@ens-lyon.org>,
        Muhammad Usama Anjum <usama.anjum@collabora.com>,
        William Hubbs <w.d.hubbs@gmail.com>,
        Chris Brannon <chris@the-brannons.com>,
        Kirk Reiser <kirk@reisers.ca>, kernel@collabora.com,
        kernel-janitors@vger.kernel.org, speakup@linux-speakup.org,
        linux-kernel@vger.kernel.org
References: <20230303125152.2030241-1-usama.anjum@collabora.com>
 <fb6121fc-101f-0779-b752-ac8202eb761e@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <fb6121fc-101f-0779-b752-ac8202eb761e@collabora.com>
Organization: I am not organized
User-Agent: NeoMutt/20170609 (1.8.3)
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Muhammad Usama Anjum, le ven. 16 juin 2023 17:53:12 +0500, a ecrit:
> Soft reminder.

It somehow hadn't appeared in my inbox.

> On 3/3/23 5:51 PM, Muhammad Usama Anjum wrote:
> > make versioncheck reports the following:
> > ./drivers/accessibility/speakup/genmap.c: 13 linux/version.h not needed.
> > ./drivers/accessibility/speakup/makemapdata.c: 13 linux/version.h not needed.
> > 
> > So remove linux/version.h from both of these files.
> > 
> > Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>

Reviewed-by: Samuel Thibault <samuel.thibault@ens-lyon.org>

Thanks!

> > ---
> >  drivers/accessibility/speakup/genmap.c      | 1 -
> >  drivers/accessibility/speakup/makemapdata.c | 1 -
> >  2 files changed, 2 deletions(-)
> > 
> > diff --git a/drivers/accessibility/speakup/genmap.c b/drivers/accessibility/speakup/genmap.c
> > index 0125000e00d9..0882bab10fb8 100644
> > --- a/drivers/accessibility/speakup/genmap.c
> > +++ b/drivers/accessibility/speakup/genmap.c
> > @@ -10,7 +10,6 @@
> >  #include <stdio.h>
> >  #include <libgen.h>
> >  #include <string.h>
> > -#include <linux/version.h>
> >  #include <ctype.h>
> >  #include "utils.h"
> >  
> > diff --git a/drivers/accessibility/speakup/makemapdata.c b/drivers/accessibility/speakup/makemapdata.c
> > index d7d41bb9b05f..55e4ef8a93dc 100644
> > --- a/drivers/accessibility/speakup/makemapdata.c
> > +++ b/drivers/accessibility/speakup/makemapdata.c
> > @@ -10,7 +10,6 @@
> >  #include <stdio.h>
> >  #include <libgen.h>
> >  #include <string.h>
> > -#include <linux/version.h>
> >  #include <ctype.h>
> >  #include "utils.h"
> >  
> 
> -- 
> BR,
> Muhammad Usama Anjum
> 

-- 
Samuel
---
Pour une évaluation indépendante, transparente et rigoureuse !
Je soutiens la Commission d'Évaluation de l'Inria.
