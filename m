Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62FF462357C
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 22:11:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231449AbiKIVLG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 16:11:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231293AbiKIVLE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 16:11:04 -0500
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 210C91E3EB
        for <linux-kernel@vger.kernel.org>; Wed,  9 Nov 2022 13:11:04 -0800 (PST)
Received: by mail-pl1-x633.google.com with SMTP id d20so17195186plr.10
        for <linux-kernel@vger.kernel.org>; Wed, 09 Nov 2022 13:11:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=AZ+t64XRqECpJcebUuW72OLDqcyhCy8s9xRctERCP1k=;
        b=khMvfoO+gnYhqt/Yqde4DbkpWQ720tYpzG3t60Q5zp5ibRQrNnNdxS9Fhzs7cvmZMe
         5xSDLMtkSufLsqoDsGhScUJC90mvzmUGp3u3Ua5zRYF9DQ13Q7OaDfdoCNiSSfZUjyBj
         UTdN016ULZBkEhYJzFfHCHzz5Ish+z+GsmbY6wDp1LwaB7zGDpe755SxQpiMv7wrRpYR
         drGzjARib69W3OxfCoC6MAfyvletpwrnPE4vHRBMiu44uTolb4rRS9DOHVyoOZwyIo9t
         lQL2hoC5rW21Z1jcs0njVUejfKJa3J0uOr3UyMhhTCv2ClCXyTXAfyu2WRwQBhNLQ895
         Shng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AZ+t64XRqECpJcebUuW72OLDqcyhCy8s9xRctERCP1k=;
        b=aGKQhhhdHzsjXgSSNi4aGv4ZMeTg9QfOtFgxrIEtATu9J/EXebW03olQXF96z2yW2g
         LOfLmJc1pHXJYrpepkGhM5rmkzbEI1y8X9+4TftMvnzYbW+jqFcRNinTGxoVixzpefgB
         AA90+BdsBfVsIzYx7NS7wkxU4H1T6pMx4bO1apnzDTvz1UEbhuzP0g80941wDMg2DyBL
         wcIZKgLiov/ILIx8/lr35K6pLEqYLjFF7aC4tKtPu40Y/BtuecMvxOspW8iQOtB4GCzN
         Lt0otFdK4u5Wetl7yNH1d7R2bICu0h9Dhz3YHDF62p8Z5jp2jvMqR0Ne7rb0kNuki4at
         Cldw==
X-Gm-Message-State: ACrzQf23Ze03s51gvd30kAsHcwSw+Dj1qWpKfqpXUwpQ7ows77CZJmWF
        Rsln7H8nkgKPbMH6Lvdk3gM=
X-Google-Smtp-Source: AMsMyM5maFoMgHn059eK5XmFIC0oorclTzEmRP8vgboQfiAdFuwJYjs5+dHazQqCefEwDa5Ns4p6yA==
X-Received: by 2002:a17:903:2341:b0:188:5bb2:d52 with SMTP id c1-20020a170903234100b001885bb20d52mr32726241plh.32.1668028263419;
        Wed, 09 Nov 2022 13:11:03 -0800 (PST)
Received: from google.com ([2620:15c:9d:2:6af4:9e55:5482:c0de])
        by smtp.gmail.com with ESMTPSA id j126-20020a625584000000b0056bb21cd7basm8702931pfb.51.2022.11.09.13.11.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Nov 2022 13:11:02 -0800 (PST)
Date:   Wed, 9 Nov 2022 13:10:59 -0800
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] driver core: remove devm_device_remove_groups()
Message-ID: <Y2wXYxrr/qed/j//@google.com>
References: <20221109140711.105222-1-gregkh@linuxfoundation.org>
 <CAJZ5v0gv6L9Q+Nu3U0JAWqJk4MPt7kGVGiOAKuX5FcF=znyfTA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0gv6L9Q+Nu3U0JAWqJk4MPt7kGVGiOAKuX5FcF=znyfTA@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 09, 2022 at 03:11:47PM +0100, Rafael J. Wysocki wrote:
> On Wed, Nov 9, 2022 at 3:07 PM Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> >
> > There is no in-kernel user of this function, so it is not needed anymore
> > and can be removed.
> >
> > Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> > Cc: "Rafael J. Wysocki" <rafael@kernel.org>
> > Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> 
> For both patches in the series:
> 
> Reviewed-by: Rafael J. Wysocki <rafael@kernel.org>

I find it really weird to have an asymmetric core API...

Thanks.

-- 
Dmitry
