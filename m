Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BD257320A0
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 22:09:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233787AbjFOUJJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 16:09:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229653AbjFOUJG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 16:09:06 -0400
Received: from mail-il1-f182.google.com (mail-il1-f182.google.com [209.85.166.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF2E81FD7;
        Thu, 15 Jun 2023 13:09:04 -0700 (PDT)
Received: by mail-il1-f182.google.com with SMTP id e9e14a558f8ab-340bdf36dd9so7929335ab.3;
        Thu, 15 Jun 2023 13:09:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686859744; x=1689451744;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aTfjaS0IPEiXuHhWcjsCm7WS5mqkvAN6gaYW2Bcvzz4=;
        b=HKsyIAlc1gychI1Iug+BOUo7rfqrlvPgWzjmTRztywf8iehrXgMOdF86aEO0jUIkrC
         rXilVZpDf+EWKRgpU+bDIQvbkoDlyp+GiMMseNqzLGl6kzfhgNj7uf0LncjdVYnufWvr
         IaJ+IMuxTL9Njv8ZrE+sjbHjF3JMWj+ltaxH9ikmvUm/d7L0t5ueDI/Fo4j5etlEaziB
         XnQg3pj2xV7tH9RCdkXMP5ZpSELHHfiHg7ZPpoXQTldoHQs2dCchUEUCEDrnTOPzvjq+
         7Sz3rLhJaX9Asz5xGzbfxxXYRCSJub7hCUuvKcGFQM/eqJrUP/l6FTAAwEjUE9y3JZKW
         /56w==
X-Gm-Message-State: AC+VfDzW5OuMjZjgI6L4jw00cTSUvzydQ8beLOZtsS5zF6YK1WG+o0Ue
        bT3GJXCLd/Z8JhUTf4SsB701X/9NRg==
X-Google-Smtp-Source: ACHHUZ79LfJp9RkPNTpyZJ5OtyEoIgIYPICSHb+vRi8hTHwBhSpMqkvv/DethS+ipksLPiMZ71fxMQ==
X-Received: by 2002:a92:d3c3:0:b0:340:6984:cc6f with SMTP id c3-20020a92d3c3000000b003406984cc6fmr478157ilh.3.1686859744059;
        Thu, 15 Jun 2023 13:09:04 -0700 (PDT)
Received: from robh_at_kernel.org ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id g24-20020a056638061800b004166c24e30dsm5685797jar.32.2023.06.15.13.09.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jun 2023 13:09:03 -0700 (PDT)
Received: (nullmailer pid 1586553 invoked by uid 1000);
        Thu, 15 Jun 2023 20:09:01 -0000
Date:   Thu, 15 Jun 2023 14:09:01 -0600
From:   Rob Herring <robh@kernel.org>
To:     Michal =?iso-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>
Cc:     Thomas Zimmermann <tzimmermann@suse.de>,
        Linux regressions mailing list <regressions@lists.linux.dev>,
        Salvatore Bonaccorso <carnil@debian.org>,
        Cyril Brulebois <cyril@debamax.com>,
        linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, stable@vger.kernel.org
Subject: Re: [PATCH 1/2] fbdev/offb: Update expected device name
Message-ID: <20230615200901.GA1572644-robh@kernel.org>
References: <20230412095509.2196162-1-cyril@debamax.com>
 <20230412095509.2196162-2-cyril@debamax.com>
 <ZDvrY7X9mpJ7WZ3z@eldamar.lan>
 <11b342dc-1a46-d1be-5fdd-c6eee661e15a@leemhuis.info>
 <fe3b90b0-b52f-9677-0245-a201975c3e0c@suse.de>
 <20230615132107.GA9196@kitsune.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230615132107.GA9196@kitsune.suse.cz>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 15, 2023 at 03:21:07PM +0200, Michal Suchánek wrote:
> Hello,
> 
> On Thu, Jun 15, 2023 at 03:06:28PM +0200, Thomas Zimmermann wrote:
> > Hi
> > 
> > Am 15.06.23 um 15:03 schrieb Linux regression tracking (Thorsten Leemhuis):
> > > On 16.04.23 14:34, Salvatore Bonaccorso wrote:
> > > > 
> > > > On Wed, Apr 12, 2023 at 11:55:08AM +0200, Cyril Brulebois wrote:
> > > > > Since commit 241d2fb56a18 ("of: Make OF framebuffer device names unique"),
> > > > > as spotted by Frédéric Bonnard, the historical "of-display" device is
> > > > > gone: the updated logic creates "of-display.0" instead, then as many
> > > > > "of-display.N" as required.
> > > > > 
> > > > > This means that offb no longer finds the expected device, which prevents
> > > > > the Debian Installer from setting up its interface, at least on ppc64el.
> > > > > 
> > > > > It might be better to iterate on all possible nodes, but updating the
> > > > > hardcoded device from "of-display" to "of-display.0" is confirmed to fix
> > > > > the Debian Installer at the very least.
> 
> At the time this was proposed it was said that "of-display", is wrong,
> and that "of-display.0" must be used for the first device instead, and
> if something breaks an alias can be provided.
> 
> So how does one provide an alias so that offb can find "of-display.0" as
> "of-display"?

I'm not aware of any way. There isn't because device names and paths are 
not considered ABI. There are mechanisms for getting stable class device 
indices (e.g. i2c0, mmcblk0, fb0, fb1, etc.) though not implemented for 
fbN (and please don't add it). 

In any case, this should be an easy fix. Though if "linux,opened" or 
"linux,boot-display" is not set, then you'd still get "of-display.0":

diff --git a/drivers/of/platform.c b/drivers/of/platform.c
index 78ae84187449..e46482cef9c7 100644
--- a/drivers/of/platform.c
+++ b/drivers/of/platform.c
@@ -553,7 +553,7 @@ static int __init of_platform_default_populate_init(void)
                        if (!of_get_property(node, "linux,opened", NULL) ||
                            !of_get_property(node, "linux,boot-display", NULL))
                                continue;
-                       dev = of_platform_device_create(node, "of-display.0", NULL);
+                       dev = of_platform_device_create(node, "of-display", NULL);
                        of_node_put(node);
                        if (WARN_ON(!dev))
                                return -ENOMEM;
