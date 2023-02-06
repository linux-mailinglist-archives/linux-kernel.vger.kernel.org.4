Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5929668C318
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 17:23:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229695AbjBFQXQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 11:23:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229830AbjBFQXJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 11:23:09 -0500
Received: from mail-oo1-xc2b.google.com (mail-oo1-xc2b.google.com [IPv6:2607:f8b0:4864:20::c2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C9FC9ECD;
        Mon,  6 Feb 2023 08:23:06 -0800 (PST)
Received: by mail-oo1-xc2b.google.com with SMTP id y13-20020a4ae7cd000000b0051a750e2ebdso458516oov.5;
        Mon, 06 Feb 2023 08:23:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=69rgHGASmOjimVJahWXhwu9vx5pYLpUxFerdIc3BruI=;
        b=klVJAXpVdBfGzl24PqqKNGkiPl69nxXJvo3ns/FEm4cU2QMtJ7lkLQDRIOs3iuwzgl
         vZTm5ex623uomYTx4E06LzGFsl87eEyI72cO85StzlZijAfa5O2FtQk7KKrVwvaVRvi6
         /AhFqCHFGT+npBCKqWg/Ys8Gwl2dkPssTro6u/kyzpqbHkRrkD9ayjuz8WzPp77nlD3d
         AIreXCiaSr4wMic45j13XWTnAfA+4itgxH9Z6g/rCLqrULoFSqadl7X29rr46HEAKSwt
         rbG7W23JwvojO4on2ENKOiYf/oDQqyN5gnBhNUfcRAuk7/0ASOqbONGaclJ6+1FW0SRK
         P+Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=69rgHGASmOjimVJahWXhwu9vx5pYLpUxFerdIc3BruI=;
        b=msCiajbYT31FuZrDhf9wAQs9MRa4zp+frgPvGMrNegsPn8TX+1Rjoh3fBhvpbgIZby
         SFRq5roupcMN1IAODrxL/iUs6RiJzZEV1ZDql0tYfRjQfy3Q62SpWa9OKKjzX69stG8s
         j3+UoLa09Ocgs/O6HPN4L2149110L9/hjNTHagCALDPeE7bpKJZGUojmAmTjaVYJu6/T
         TeR0s0ysVsFLAia0moXqePG6Dd37UP/fh0J+8f0ko6M03edsfo+c1uwQeLS07sQfmfcf
         gvnzfE1QqO3kRAHlUkJEEYyq8qujFTkAH4NSOEypeiOZouNKwSFIfRn1oM4c3jEZ3jd3
         OINg==
X-Gm-Message-State: AO0yUKX6wjgbuupTYyPGyvJ2Bl3wrSTpy3cnFWjNcXP1D6EVKAEz/mGo
        ZcrxwAcZz8WdrWHIDF4AVaHYFXxJ7zA=
X-Google-Smtp-Source: AK7set/H2RWwwLdZ5YSDwU3Nc/rsAl68g3F+EsLVIX+Fm6mqvvbX+S5aJsgNH+q1x0tOIuTydUosLw==
X-Received: by 2002:a05:6820:1892:b0:517:5714:8355 with SMTP id bm18-20020a056820189200b0051757148355mr9894177oob.9.1675700585370;
        Mon, 06 Feb 2023 08:23:05 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id c20-20020a4ad8d4000000b0050dfbe2460bsm4749538oov.48.2023.02.06.08.23.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Feb 2023 08:23:04 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Mon, 6 Feb 2023 08:23:03 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Armin Wolf <W_Armin@gmx.de>, markgross@kernel.org,
        jdelvare@suse.com, platform-driver-x86@vger.kernel.org,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] platform/x86: dell-ddv: Add hwmon support
Message-ID: <20230206162303.GA195090@roeck-us.net>
References: <20230205205456.2364-1-W_Armin@gmx.de>
 <20230205205456.2364-2-W_Armin@gmx.de>
 <a7d2e011-142d-88b9-2591-cf4508f1b8c5@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a7d2e011-142d-88b9-2591-cf4508f1b8c5@redhat.com>
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 06, 2023 at 03:13:25PM +0100, Hans de Goede wrote:
> Hi Armin,
> 
> On 2/5/23 21:54, Armin Wolf wrote:
> > Thanks to bugreport 216655 on bugzilla triggered by the
> > dell-smm-hwmon driver, the contents of the sensor buffers
> > could be almost completely decoded.
> > Add an hwmon interface for exposing the fan and thermal
> > sensor values. Since the WMI interface can be quite slow
> > on some machines, the sensor buffers are cached for 1 second
> > to lessen the performance impact.
> > The debugfs interface remains in place to aid in reverse-engineering
> > of unknown sensor types and the thermal buffer.
> > 
> > Tested-by: Antonín Skala <skala.antonin@gmail.com>
> > Tested-by: Gustavo Walbon <gustavowalbon@gmail.com>
> > Signed-off-by: Armin Wolf <W_Armin@gmx.de>
> 
> This looks nice and clean to me, thank you:
> 
> Reviewed-by: Hans de Goede <hdegoede@redhat.com>
> 
> I'm going to wait a bit with merging this to see if Guenter
> has any remarks. If there are no remarks by next Monday then
> I'll merge this for the 6.3 merge window.
> 

I don't have any further remarks. I won't send an Ack, though.
I noticed that the empty lines before return statements distract
me sufficiently enough that I am not sure about the actual code.

Guenter
