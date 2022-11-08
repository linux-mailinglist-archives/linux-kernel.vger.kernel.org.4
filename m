Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0254620C9F
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 10:47:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233691AbiKHJrK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Nov 2022 04:47:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233617AbiKHJqe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Nov 2022 04:46:34 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBAE0E094;
        Tue,  8 Nov 2022 01:46:30 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id y16so19995919wrt.12;
        Tue, 08 Nov 2022 01:46:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=O5IgkeQmSxEG1HaPKm+nMukRSPWOYNkhN02jAR5oCCE=;
        b=hezLi6sT4lRvroGT/dZOxWO8QJQl7HtGGdEeklPbIsTUo5Ej1iJ7EAs3lPtSFluUuh
         E7PFq3+gd15YoXaGCWAU41s7C0LBWt0kd+4k+q/+k3PXqUZrQ5nSdGoy0NIa/eckmY+i
         A9gb5ebUP5yJFyjjBFeWNxbQbI31Qho8pZqoDsnicVQVIHihQZ5Fa76rWf5x3HqZgMn4
         78uUewQeRQBxQNNZCOybuGYxfwsLCldVjIRxCNf87ejoN1nDKujNJrEa6pVFYzj30h3L
         iICueYSj52+m0urr3vZVSldPzQ216KPiezqqE3s3Gc9gWaqqNWRIImJABL3AGRWcQADe
         srqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O5IgkeQmSxEG1HaPKm+nMukRSPWOYNkhN02jAR5oCCE=;
        b=WNDN7UhaJghqHQe/zwdb+Oe1tYZ5G7Bp3QTrnrluqvXtQkdKEpVaNUfUvoRzLWw/lh
         PNmmWcA9/SdM3E4kYB2yggzBS3TahxpGs1ACLVv1a93myBlo+uviEEIib4lnjgrH+OEc
         dxTIF8O9f4CUZrvvYj9WPHX1xuryMKB5LJuyZOXHEwp6Hz9pHkNVe9qXWYZLBSdjte8w
         4Ln6jnujrUl+e8GmAsHO43wk+eHQFF7AqdQf4JEoC0uqORirCEtWMqMsxOwCnlsnRQvp
         drasDU5nEOp5GvImWI0u7d+g6j68zLl1YOFU3VLEhSvsFyLqDL3VLPa5UZFukoVIKfWB
         dYZQ==
X-Gm-Message-State: ACrzQf0qjJur9shMi0s2fcWrFrx5sk87KBveEShiSqnZrqA4p83X5Lln
        LCro0VP+F7hBelvEcohwmag=
X-Google-Smtp-Source: AMsMyM5IZKYCnOmlHMEgK799dgzKIDWJt0m+zOxQXKffBaJo4gDQj8fc+whAJY8algsbapvM3hN5FA==
X-Received: by 2002:adf:e911:0:b0:236:73b7:e668 with SMTP id f17-20020adfe911000000b0023673b7e668mr34305141wrm.96.1667900789237;
        Tue, 08 Nov 2022 01:46:29 -0800 (PST)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id p15-20020a1c544f000000b003cf483ee8e0sm13565499wmi.24.2022.11.08.01.46.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Nov 2022 01:46:28 -0800 (PST)
Date:   Tue, 8 Nov 2022 12:46:25 +0300
From:   Dan Carpenter <error27@gmail.com>
To:     Hans Verkuil <hverkuil@xs4all.nl>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Deepak R Varma <drv@mailo.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        linux-media@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linux-staging@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: patches for staging:media drivers
Message-ID: <Y2olcaNp3xkRRK7j@kadam>
References: <Y2eSCZJNWn6DzCUu@qemulion>
 <48f4bda9-b5e3-9649-aab9-b529889bf110@linaro.org>
 <Y2oO7fU4whKr+3hb@kadam>
 <bf7dc5f6-acf3-73f0-b73b-d5707152190b@xs4all.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bf7dc5f6-acf3-73f0-b73b-d5707152190b@xs4all.nl>
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 08, 2022 at 10:35:54AM +0100, Hans Verkuil wrote:
> 
> I don't mind taking patches for media staging drivers as long as:
> 
> 1) they are not for atomisp, and
> 2) they are not for deprecated drivers (drivers/staging/media/deprecated/)
> 

This is unrelated but I somehow misread an email and thought we were
going to create a drivers/deprecated/ directory.  I still think that's a
good idea for future deprecated drivers.  We normally put them in
staging/ but it's not really the ideal place for them.

regards,
dan carpenter
