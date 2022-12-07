Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD56164589D
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Dec 2022 12:10:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230044AbiLGLKz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Dec 2022 06:10:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229876AbiLGLKE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Dec 2022 06:10:04 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 393B122BC0;
        Wed,  7 Dec 2022 03:09:59 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id m14so27560571wrh.7;
        Wed, 07 Dec 2022 03:09:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ICFciUzqeiA5TCqnWMy+yTZQrd2p8LuMqKRatp5gkOM=;
        b=q6xZGM8wdEgdRT+AAi2IGnwmA/DLvQBFChaF3gfYESHoY5CTsovDMps1EQ09MJzzUI
         RzcKqAI5MPmrANbwiAARTOIppoWsTwg/Wltf23xvsBfnoXi2UlAjj4/EkSKUceM045Dg
         gFBQ3K8Z1/EqONclWrihhQO/CeaLa7M+bz4V0K6Wf4y1Y/Z7Eb1kGTBPwtyuN2ClQ2Hh
         aKNfdfR+ZnFGUY28WpKMUI7b2gnnhEI70h/IERmyuYMCxMepiBkaccGE+J1NdVZ0m/s/
         eespEJwYpCgKWnbfRcgxwVJNF0b3hRqZnnb5Af+WZbdsMcARNnAojVGJXBfWQFFAjmvj
         nCfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ICFciUzqeiA5TCqnWMy+yTZQrd2p8LuMqKRatp5gkOM=;
        b=lCYzuJDrkvER+5EPy6J9rGZ2aIOr7Qo0kC84g0CQiUZDUrjvAFhoi0a7BUZlm2pCMy
         vyUb6LPktn+/6rMkLScR+/SIU/gg6lD9DzNaQLTiga7AJpC+zRFiTuyn92Y0xK+5k1+e
         ZyVe0ZXOdl1d9IpRN+wqE5NC+p37fpNJN04lnXScKIMx3R3NV+ZtBAVFXI5vO6SZ5bcl
         P7YvXJ+O3YvIpDszy1VRi1sXJ4zaFD4mghL8rcPzJNVpZK7PHiXJTuc+JguhwPh/c97j
         A2R7vTGusIkoXodokjjlhcsX36AJguDqDUXTp1mCzp0yzPvAbWmjWVQvjncr98mLA2PS
         HX6A==
X-Gm-Message-State: ANoB5pkMiDcnSgMdSjS+vBgBj1gVpVttHmcHvuYIQZ9BJzLiM9LjWJFW
        hrZj0FeC2pHcOEJVxgJgwdM=
X-Google-Smtp-Source: AA0mqf7iWewb8CjBGIvYjTdV48Sin4KSCqRo5q788eaoVU/JLiAQSeAGP1fRLC/4BocEFsM0E+82jw==
X-Received: by 2002:a5d:49c5:0:b0:242:2fe2:ffa1 with SMTP id t5-20020a5d49c5000000b002422fe2ffa1mr18548975wrs.96.1670411397546;
        Wed, 07 Dec 2022 03:09:57 -0800 (PST)
Received: from fedora ([94.73.32.229])
        by smtp.gmail.com with ESMTPSA id o15-20020a05600c4fcf00b003cf483ee8e0sm1548479wmq.24.2022.12.07.03.09.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Dec 2022 03:09:57 -0800 (PST)
Date:   Wed, 7 Dec 2022 12:09:55 +0100
From:   =?iso-8859-1?Q?Jos=E9_Exp=F3sito?= <jose.exposito89@gmail.com>
To:     Alexander Zhang <alex@alexyzhang.dev>
Cc:     Jiri Kosina <jikos@kernel.org>, benjamin.tissoires@redhat.com,
        openglfreak@googlemail.com, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/1] HID: uclogic: Add HID_QUIRK_HIDINPUT_FORCE quirk
Message-ID: <Y5B0gwGZJ/PQyV4+@fedora>
References: <20221110174056.393697-1-jose.exposito89@gmail.com>
 <e1daf0a9-b699-affd-0d14-e46981733096@alexyzhang.dev>
 <nycvar.YFH.7.76.2211141509340.6045@cbobk.fhfr.pm>
 <d08049f2-443b-f769-cfde-629cdfb96fc0@alexyzhang.dev>
 <1dc9d0ba-4836-dfc6-8bf2-322ce3b5c24d@alexyzhang.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1dc9d0ba-4836-dfc6-8bf2-322ce3b5c24d@alexyzhang.dev>
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alexander,

On Mon, Dec 05, 2022 at 04:49:10PM -0800, Alexander Zhang wrote:
> Hello,
> 
> On 11/19/22 11:01 PM, Alexander Zhang wrote:
> > On 11/14/22 6:10 AM, Jiri Kosina wrote:
> > > On Thu, 10 Nov 2022, Alexander Zhang wrote:
> > > 
> > > > Hi José,
> > > > 
> > > > On 11/10/22 9:40 AM, José Expósito wrote:
> > > > > Hi everyone,
> > > > > 
> > > > > About 3 months ago, Torge Matthies sent a patch fixing an issue with
> > > > > his XP-Pen Star G640 [1].
> > > > > 
> > > > > His patch changes the IS_INPUT_APPLICATION() macro to accept
> > > > > HID_DG_DIGITIZER. However, it looks like it is not being merged because
> > > > > of the possible side effects that changing that macro could generate.
> > > > > 
> > > > > This patch aims to fix the same issue but using a more conservative
> > > > > approach hoping that the bug can be fixed.
> > > > > 
> > > > > Torge, Alexander, could you test it and confirm that it fixes your
> > > > > issues, please?
> > > > 
> > > > I tested the patch on commit 4bbf3422df78 and it fixes the issue.
> > > 
> > > I will add
> > > 
> > >     Tested-by: Alexander Zhang <alex@alexyzhang.dev>
> > > 
> > > to the commit; please speak up if you disagree.
> > 
> > I'm not sure if you're still waiting for a response from me but I'm fine
> > with that.
> 
> Is there something preventing this patch from being merged? I'm not very
> familiar with the kernel development process.

The patch is already applied in the for-next branch, you can find it here:
https://git.kernel.org/pub/scm/linux/kernel/git/hid/hid.git/commit/?h=for-next&id=3405a4beaaa8

Jose

> Best,
> Alexander Zhang
