Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9FD76C0C62
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 09:44:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230381AbjCTIoe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 04:44:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229892AbjCTIoc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 04:44:32 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CFBC12CFB;
        Mon, 20 Mar 2023 01:44:29 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id lr16-20020a17090b4b9000b0023f187954acso11588157pjb.2;
        Mon, 20 Mar 2023 01:44:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679301869;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=gs8rcm/d7d5rUf8zE5Zuo/A8IdhoZtRoqNxyEktI7DU=;
        b=D1Zmcz+v1MK/aSof4oDyzd7q1lx9K9HTk27r+LV6Lh1C3y/VPTkYrWUQMA/OMPpcKU
         we08QnxWPTFCyvkjbDwhE3gvfDeg2Jn0RzBP4V+/2fH0eNEg36YInV9OONtM4o6Dh3x5
         qXABGpInu9pkf6OBcanjeGCD6sMY50g9QkfUk2RT3Igek5ixe3O75VESxkXnrq00JXyr
         9Cs6qlykNDGCbrYqav6bfOyJ82b9huN0+x0ahdhTu3wnkJNC2whpCfZf6e0MOZHAtgBi
         VO8GxL4tZ1h9YYEM6GnojpOykTBVhIcWmpVO+SHsjNgsnvFU+NBzkK4GWrBATqH6zCwk
         gUzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679301869;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gs8rcm/d7d5rUf8zE5Zuo/A8IdhoZtRoqNxyEktI7DU=;
        b=1lLd+yteqHnpR+xHSPKljGsQccn6Y25i26vsPHj53KteOqRqLc7fDgHfDHnwqt87dL
         VzXJwCcIuQlBoPb2FIJtOC4IBFPtrobD2/n/q1R3L8S/MNneNs8cSQcKh4q8dswOpZeo
         7ZT+0KA2grMHmPXh5NgV/ZbO3UL7bfrHpJ2yBQwda6rRIRTJZ5J0liB/fB5DGttNc9CM
         fmXl7iTarIVWWWeJmjPSt7nu414QmAYpbK35PphlMevGsuzApyAfZBlaRs9PJgu6/r+j
         d2HFGnXt8mz6Bx8PmCcfFxzKh20HzG+CaswZyNkR6Y+xf+FmE1aeD1J6PtzXEvLidP6Q
         s5Lw==
X-Gm-Message-State: AO0yUKU5JdludfT5ywBO3CxoNd77JBSKXpyvut057V+JI+rjUZantEDi
        K1EzkRUKjU7s1FfvcILauRU=
X-Google-Smtp-Source: AK7set/c7pstRRWuhurf3gUuxnXwtKb1375FG/fOeRr1dGCOpfdeRb7/xUqrWb2ye0HQRVT8Xbwv3w==
X-Received: by 2002:a17:902:e742:b0:19f:7977:c9d6 with SMTP id p2-20020a170902e74200b0019f7977c9d6mr18905610plf.28.1679301869033;
        Mon, 20 Mar 2023 01:44:29 -0700 (PDT)
Received: from sumitra.com ([210.212.97.176])
        by smtp.gmail.com with ESMTPSA id d4-20020a170902b70400b001a1c2eb3950sm2847455pls.22.2023.03.20.01.44.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Mar 2023 01:44:27 -0700 (PDT)
Date:   Mon, 20 Mar 2023 01:44:22 -0700
From:   Sumitra Sharma <sumitraartsy@gmail.com>
To:     Dan Carpenter <error27@gmail.com>
Cc:     Marc Dietrich <marvin24@gmx.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        ac100@lists.launchpad.net, linux-tegra@vger.kernel.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        outreachy@lists.linux.dev
Subject: Re: [PATCH v2] Staging: nvec: Convert to_nvec_led from a macro to an
 inline function
Message-ID: <20230320084422.GA126429@sumitra.com>
References: <20230318175250.GA49618@sumitra.com>
 <417e944c-4653-43ef-b492-c82c536e4d87@kili.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <417e944c-4653-43ef-b492-c82c536e4d87@kili.mountain>
X-Spam-Status: No, score=2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SBL_CSS,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 20, 2023 at 08:39:49AM +0300, Dan Carpenter wrote:
> On Sat, Mar 18, 2023 at 10:52:50AM -0700, Sumitra Sharma wrote:
> > Convert to_nvec_led from a macro to a static inline function, to make the
> > relevant types apparent in the definition and to benefit from the type
> > checking performed by the compiler at call sites.
> > 
> > Signed-off-by: Sumitra Sharma <sumitraartsy@gmail.com>
> > ---
> 
> You need to compile test your changes.
>

Hi dan,

I am facing problems in creating modules and in compiling them.

Any help in this would be appreciated. Here is the link to the thread https://lore.kernel.org/outreachy/alpine.DEB.2.22.394.2303191336090.2867@hadrien/T/#t

Regards,

Sumitra

> regards,
> dan carpenter
> 
