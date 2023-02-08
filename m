Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CE2968F689
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Feb 2023 19:04:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231717AbjBHSEr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 13:04:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231578AbjBHSEl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 13:04:41 -0500
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com [IPv6:2607:f8b0:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFBF64ED0C
        for <linux-kernel@vger.kernel.org>; Wed,  8 Feb 2023 10:04:12 -0800 (PST)
Received: by mail-oi1-x234.google.com with SMTP id cz14so6819031oib.12
        for <linux-kernel@vger.kernel.org>; Wed, 08 Feb 2023 10:04:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=O/yYLbDmVAKhtP8X+LmC29BJSStWEUQPLeH77WHP6dc=;
        b=RzQC+g8VDw5QUgQluU0fadg6ShuYtqdzeVThydyjTbD4pEBH2WvZFVLK85twqKgQxy
         w6fQE3djW2HasC9GxNBEQFavQJEwuhGo0UjJIxhfEICZg1YjdbTT0zjn4dl+D/DsJVor
         6GnAvV4YTVmTfS4rUBbqxT4fk863nSc4c/jaz0la6ml3QDAkdhDBTo9v8vJ/Gz8yDF8r
         GvArRJzN1/RMer+xeR6rnuCjVDcb0R6BPmbe3HZKs5nKywtg5R9o5vgo0i82nZ3wSl6D
         M6iSfhkf+ZzKvbI8g3tyqovsBd77aG45e5f7EvX9aRM2QsMe61nExaa/RLQCisNJdth4
         Du0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=O/yYLbDmVAKhtP8X+LmC29BJSStWEUQPLeH77WHP6dc=;
        b=FUPItgiDFIPvcDYUDGEVXXPX0Qnp++hzefx3SGfQLVImpBd2DsWHUTRWTj8LYVFare
         9MMXkWneTbWoKER70a3wLMwoni6V7vWOr/P4J4hCPRDvzmUgCvD2rTtCwGCRSnN1CDbP
         KgSYlxqqFrZxzKPN0KKwIZPZ5D76zocWYYBANRnzNLupozLq45g/QLDNqb09Ni4LiERu
         ELNewUY/lIX8Pj2Siipz0IJGBF9eE2loL+KmUyLMAXpopxENXu29nbGaGmWAdhqlqAtZ
         NEIPvFjqvoz27TQ/4Qba8YbcMZZj3sHPRdKrHG25AiSysm3Wd2wx40Z8DS6l299OfBS1
         UVAA==
X-Gm-Message-State: AO0yUKWJN6Alydry/XRpjvoRWxIvOwVpIeqte/RJpFF2P6Cbe7zwr+Jj
        OnGrw9oD/0O5Es7SGokBGrf86RKjWVo=
X-Google-Smtp-Source: AK7set8qcDe8W2WKf0+i5hQvRiLJ68yKZLpDh2UBtRqIYNqX7CH3WmvZbxys0yr8x9gcP/CFr4msng==
X-Received: by 2002:a54:4704:0:b0:37b:77fb:235a with SMTP id k4-20020a544704000000b0037b77fb235amr1393394oik.50.1675879448493;
        Wed, 08 Feb 2023 10:04:08 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id q130-20020aca5c88000000b0037ac4a18acfsm7260948oib.48.2023.02.08.10.04.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Feb 2023 10:04:07 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Wed, 8 Feb 2023 10:04:06 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     David Rau <david.rau.zg@renesas.com>
Cc:     Mark Brown <broonie@kernel.org>, "perex@perex.cz" <perex@perex.cz>,
        "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "tiwai@suse.com" <tiwai@suse.com>,
        "support.opensource@diasemi.com" <support.opensource@diasemi.com>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ASoC: da7219: Fix pole orientation detection on OMTP
 headsets when playing music
Message-ID: <20230208180406.GB3065515@roeck-us.net>
References: <38f09c4d-70d1-f65f-6e9b-4ad84eda4059@roeck-us.net>
 <Y9kE1cSUg2CQM5vq@sirena.org.uk>
 <20230202155101.GB1373010@roeck-us.net>
 <Y9vtIISfmpICi+9u@sirena.org.uk>
 <8f89eeac-b3ef-4137-80df-6cf044873b05@roeck-us.net>
 <Y9wQygzbFyOWl54r@sirena.org.uk>
 <20230204154222.GA877819@roeck-us.net>
 <OS3PR01MB6641CA1DB8524BCA0F9867D9CDDA9@OS3PR01MB6641.jpnprd01.prod.outlook.com>
 <1ba5cedb-0f0f-69a9-96f0-d93ba060745e@roeck-us.net>
 <OS3PR01MB6641BD5C3B3BA89F82245627CDDB9@OS3PR01MB6641.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <OS3PR01MB6641BD5C3B3BA89F82245627CDDB9@OS3PR01MB6641.jpnprd01.prod.outlook.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 07, 2023 at 02:42:14AM +0000, David Rau wrote:
> 
> > You mean just keep the above two patches and revert 969357ec94e6 ?
> > Sure, I can do that, but feedback from the field would take some
> > 2-3 months. Is that what you recommend to do for now ?
> 
> > Thanks,
> > Guenter
> 
> Thanks for the feedback.
> What I mean is just do rollback to remove the "sleep" patch I did in your repository.
> 
> After the rollback, could you please let me know the average number of crashes per affected system with the same test conditions?
> Will it still take some 2-3 months?
> 
The msleep() patch has been reverted in R111 and dev
releases of ChromeOS. I did not get permission to land
the revert in R110, meaning we'll continue to see the
crashes there. R111 is expected to go to Beta shortly,
so we should get _some_ feedback in the next few weeks.

Still, it would be great to get a more permanent fix
for the underlying problem. Also, the msleep() patch
is still upstream, so a solution is still needed there.

I can try to get and play with one of the affected
Chromebooks, but I don't think that would help much
since we still don't know what the undocumented ground
switch is supposed to do.

Thanks,
Guenter
