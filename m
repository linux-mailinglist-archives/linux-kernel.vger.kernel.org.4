Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0A476B5CCF
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Mar 2023 15:23:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230015AbjCKOX1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Mar 2023 09:23:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229814AbjCKOXY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Mar 2023 09:23:24 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3970D509
        for <linux-kernel@vger.kernel.org>; Sat, 11 Mar 2023 06:23:17 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id o5-20020a05600c510500b003ec0e4ec6deso1927650wms.3
        for <linux-kernel@vger.kernel.org>; Sat, 11 Mar 2023 06:23:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678544596;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=JC79/623i27Cxw2oHO9ZNA+BBrwFL63Y2y1N3InP394=;
        b=qzQizoZdoOAV8U0V1DKM5AXdgHedYktTRCqc8eC9LY8VLJ7hJLsoruAM0UiOQahmDd
         XzJUNT1h33ILhuAaLC1/gCgyj0ug74fR6JdU4uICnxvXs/BIwAlCSsOnMqXSpAZVPFQB
         gRhfgrAy5Brobv5P5ndTNL2zvMm0bOM336CF0k4kIVymF5hhSiGpaH7DvSLA3Z7AUWDv
         95MJZy9KOJUi24Olo88njU/+YREJD++FvAs2glMz2snGUkV77kPJQ3lruJGvbrP1mEzX
         CnN2nnZwr2EDAQ1nVDLeBKQIVUO0XtpryhpQ2Ra5exgRbm5KFC2ro5DeiuCtYExUlno7
         VS5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678544596;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JC79/623i27Cxw2oHO9ZNA+BBrwFL63Y2y1N3InP394=;
        b=BcEKt5hvqLBPUqIMNdPPehi/f1XVLTJzBzk95Yk4ctJGSZOBDLIqhVA+ISUo2ARu/Y
         i1y/ZGEDiXVpFUygqRpOqN91DW8R026h4gqzzHnD9KIZg4nnfr3IjM5Lh3rNVNXqj7Sf
         e+WkbSR9vbKSFfo/LBAkA5XUSeaf6KOrx9gi2KfRXAOjwlTQtNJZxBznTAwGPxsYr+lU
         DOnDYiPiTyzVylUcQbJXdjzBCofqRKwPx3FHso8TnsR3HbjdE5wTtgnm2BGuCVR6/79e
         Yx7ycb3YH8XlmW8/uMtv1j0LlblTIlhKG64yKEx/VPuMySoUfj69ERohqAWDL2CCeGMH
         7h1Q==
X-Gm-Message-State: AO0yUKWINwtA/swfGn2GqwDqU912BSo1npZlOGZFdxDSLKW7oJWZCnFh
        Aah30x3Cv+MXzhE3MhR62b1MBDqpH2epbGIV
X-Google-Smtp-Source: AK7set+0hL7GplngJh2S5guRgk81WnVs+2avq3FwRMHVkBPis5fUt0y6gsw5oWe7JFtN55dR6XDQCw==
X-Received: by 2002:a05:600c:314d:b0:3eb:3945:d3fd with SMTP id h13-20020a05600c314d00b003eb3945d3fdmr5912869wmo.14.1678544596078;
        Sat, 11 Mar 2023 06:23:16 -0800 (PST)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id p15-20020a7bcdef000000b003e00c453447sm2988242wmj.48.2023.03.11.06.23.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Mar 2023 06:23:15 -0800 (PST)
Date:   Sat, 11 Mar 2023 17:23:11 +0300
From:   Dan Carpenter <error27@gmail.com>
To:     Menna Mahmoud <eng.mennamahmoud.mm@gmail.com>
Cc:     Julia Lawall <julia.lawall@inria.fr>, outreachy@lists.linux.dev,
        vireshk@kernel.org, johan@kernel.org, elder@kernel.org,
        gregkh@linuxfoundation.org, greybus-dev@lists.linaro.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] staging: greybus: Fix Alignment with parenthesis
Message-ID: <e0d7928e-854e-4d10-a90f-db87a7d60569@kili.mountain>
References: <b6521b9a75a4088d621246b436c7ec5d35365690.1678462486.git.eng.mennamahmoud.mm@gmail.com>
 <alpine.DEB.2.22.394.2303110958250.2802@hadrien>
 <71211670-60f9-11f4-1ee7-f94d4d9df4fb@gmail.com>
 <alpine.DEB.2.22.394.2303111354490.2802@hadrien>
 <61dab579-f10b-5538-8b61-ebe73ae5b4f1@gmail.com>
 <27dfe880-35f7-cbc1-cf8b-7bbd7f1c7301@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <27dfe880-35f7-cbc1-cf8b-7bbd7f1c7301@gmail.com>
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 11, 2023 at 04:06:51PM +0200, Menna Mahmoud wrote:
> according to Alex feedback
> 
> " I think this type of alignment is not a major problem,
> and alignment isn't done this way in general in this
> driver, it's probably OK to keep it that way. - Alex "
> 
> 
> ,I won't resubmit these patches, right?

Yeah.  Find something else to fix.

I feel like in outreachy and similar that people send a first patch and
then they get a bunch of different feedback.  And it's like checkpatch
is complaining and it's staging code so probably the code is actually
ugly in a way.  But often it's better to abandon the project instead of
getting obsessed with it.  Zoom out a bit.  Find something else where
it's obvious how to improve the code from a readability perspective.

People are giving you feedback to help you and not because they are
about that particular line of code.  They won't care if you work on
something else instead.

regards,
dan carpenter

