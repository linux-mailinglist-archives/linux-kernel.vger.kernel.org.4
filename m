Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F68F6678B5
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 16:12:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240361AbjALPMY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 10:12:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233576AbjALPLp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 10:11:45 -0500
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48C6913FBE;
        Thu, 12 Jan 2023 07:00:38 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id m26-20020a05600c3b1a00b003d9811fcaafso15276250wms.5;
        Thu, 12 Jan 2023 07:00:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=CEpR1Oghu5jEh+XHJUeeAWnEqFA8sGLzT1Q2gGhmDfc=;
        b=kQ63ArvEjzXqRck7zKZEwAyh5nGwRANCnuIVm8WrAdRY8tMo44S4wS/RYukWQlYZbd
         w8rEzqK5GlM3IcUlsH21acsBij842Z9DoNE1nHdehTZfcPDDrxF1oDT5q1/Prc9hoRxl
         7bE3PjjzggefIaBl4Mnl+ecOD7+5lUXuZgJgAYK1dWal7VkTl0v70kDluCGMiGnH+Oo5
         XfO1KVJtE2pyptoFW9xbLPWc0fSy/z7AEUAjTAv8+X3VfN+D0xdWMCmkmaQHh3UAjKpI
         AYsx3g+FtJddVDZllZlTYo2UtI3+l47u/VuVhB4hWhgXBsG30mnNDGUeTGrV/usiX5hq
         ctLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CEpR1Oghu5jEh+XHJUeeAWnEqFA8sGLzT1Q2gGhmDfc=;
        b=nfew2ez8+l38MEShSRm9io7vZLqdtjUtSEtP1Ci/Ek+Dgkj2X7/rUrpva7ry+ZnFYk
         ylid84tvmN1CxBJyHwFW0ghgnele2kEQZ0gobds8LztFsOK6R0wzZarlP2v3WIiGHSMK
         jtDEzDP7V659kmeob0TQIXb9onNNh4EBEQXVyXzXQb3ndTu6E5FGxBWM036iByziRHl5
         tp0TESiEAxAknAUtz6W/XpkvIDifZIvAW3gfPEeK/iCy/ho5mgmQhTYlioOCWhBAiFuq
         pcyaho+9Gg/wOy1l9lknB2fJFj6ps4GehftP01VuyFDX3vTljcud7kjD8gs7XlNhhelx
         m/pA==
X-Gm-Message-State: AFqh2kp2TpJer43Hkk2s4pg8aMTf6zqSuhz/CqGVQCTQVi1KqlQFosEj
        EqyC527TEg8C5ZobH+zirJxiwVv5I98=
X-Google-Smtp-Source: AMrXdXuGLkT3WZD2pYqv1rvVwoetthcfUn6ngawoGge0A/6oW0jjMXW61GolUhC9dFk9o4yNWMSfww==
X-Received: by 2002:a05:600c:3b29:b0:3cf:d18e:528b with SMTP id m41-20020a05600c3b2900b003cfd18e528bmr56615779wms.39.1673535636697;
        Thu, 12 Jan 2023 07:00:36 -0800 (PST)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id f12-20020a05600c154c00b003d9fba3c7a4sm8832671wmg.16.2023.01.12.07.00.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Jan 2023 07:00:35 -0800 (PST)
Date:   Thu, 12 Jan 2023 18:00:33 +0300
From:   Dan Carpenter <error27@gmail.com>
To:     Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
Cc:     Sebastian Fricke <sebastian.fricke@collabora.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-rockchip@lists.infradead.org, linux-staging@lists.linux.dev,
        Jonas Karlman <jonas@kwiboo.se>,
        Alex Bee <knaerzche@gmail.com>,
        Nicolas Dufresne <nicolas.dufresne@collabora.com>,
        Collabora Kernel-domain <kernel@collabora.com>,
        Robert Beckett <bob.beckett@collabora.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Andrzej Pietrasiewicz <andrzej.p@collabora.com>,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>
Subject: Re: [PATCH v2 04/12] staging: media: rkvdec: Block start streaming
 until both queues run
Message-ID: <Y8AgkQ8WehS4PfX7@kadam>
References: <20230101-patch-series-v2-6-2-rc1-v2-0-fa1897efac14@collabora.com>
 <20230101-patch-series-v2-6-2-rc1-v2-4-fa1897efac14@collabora.com>
 <CAAEAJfBuA=gTpyeKs5mj0_1z+x5sZhse2OGPP5nmb5E6XNjBKw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAAEAJfBuA=gTpyeKs5mj0_1z+x5sZhse2OGPP5nmb5E6XNjBKw@mail.gmail.com>
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 12, 2023 at 11:55:07AM -0300, Ezequiel Garcia wrote:
> Hi Sebastian,
> 
> On Thu, Jan 12, 2023 at 9:56 AM Sebastian Fricke
> <sebastian.fricke@collabora.com> wrote:
> >
> > Ensure that both the CAPTURE and the OUTPUT queue are running (e.g. busy
> > -> have buffers allocated) before starting the actual streaming process.
> >
> 
> Usually, you want to write the "why" in the commit description,
> instead of the "what",
> which is (hopefully) more or less clear by reading the commit change.
> 
> The commit description should have enough information to understand
> what is the impact of merging the commit (or what is the bug without
> the merging the commit).
> 
> If you are fixing a spec violation, adding a reference to the spec is important,
> if you are fixing a v4l2-compliance, pasting the error, etc.
> 

Yeah, and if it's a bug fix then add a Fixes tag as well.  Even if the
bug was added when the driver was first merged, that's still useful
information.

regards,
dan carpenter

