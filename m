Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DEE75BCCEB
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Sep 2022 15:21:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230337AbiISNU4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 09:20:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230292AbiISNUp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 09:20:45 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBE37B489;
        Mon, 19 Sep 2022 06:20:43 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id w13so12241611plp.1;
        Mon, 19 Sep 2022 06:20:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date;
        bh=3FSqfCwAOSoWCQSKtKdEJhh1ehyDg7LpqHHsFJkm4eE=;
        b=of4u4F3Ccg3YA7uF09B3X4EyFwqs+Ae2qPV0i6a4iP9b4/L5pTYbNyESLVGK3/liYY
         6HA1wAg9rCZx9si0ge7RRdNG4qARus6eInLtilQCbid5RNSracGnGXjcyjDy2GR5xFgs
         dxBxvNnNUdyI4MVx/7D0WF9rI3nGyNrop6BnHm4Z+Dwb4rhupkEFk0dqqolW3I/zoZFA
         n3vVodJ4KVyzz3e3NhxcdmBoj3vciK50NTKm9mbpelPFZQHMfuuMhRzGsYcQ3pIU7TQS
         tu6KUumWRWfOW7KUG3rgfHOdcqRf+MHhubM+/0Ultfc0lbIpDdPibQFgiHIFPeHTWQil
         n6UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date;
        bh=3FSqfCwAOSoWCQSKtKdEJhh1ehyDg7LpqHHsFJkm4eE=;
        b=sCce8pLWU+0sTyjhXhOVAB7tyuVLXziYgwtAdrVHzoBQG1tekkY2Yeb8p4jupSRJBJ
         sAYOYQv/ya/tQ6cRG8eXKUHMBp5JAaC1OawGwiDLZnJS12vynvrO4oflQPw5w7aaqa0J
         INI2wVfHjLAV6Owoc8ru3P0whuY6dtLqZ8PnkUh4TkYQkKlpjjYAi/tCzmZsKjSOPc1Y
         E6IA9Fi4YD7TEIDMCRtvw+FwKLgpPrJb0mULWSlvvg1lgK+fDxN+icC3Js0nYy1p61th
         68XIYbgXlxFHaZYttHDKqn6Fm0jbMUGAFxNBCP6JVs/lv0j40XfpfKRmFMPokbaxoilp
         Ohxw==
X-Gm-Message-State: ACrzQf3q9u+gLs8kAuV8cH3hdPTi9vzi83Kql/jc0aZXQLaOwvTgGIb6
        o1mbFbbsAq9qoRKZVFakDW8=
X-Google-Smtp-Source: AMsMyM4aIx3x4J5YFAkGKW1sKYKJPPXq4ys0NZfXZTOfIbgWKOJxNQ+fLE7PGxvUwwQMs90eyLEHQA==
X-Received: by 2002:a17:902:ab14:b0:176:9fd4:d61d with SMTP id ik20-20020a170902ab1400b001769fd4d61dmr12938632plb.76.1663593643357;
        Mon, 19 Sep 2022 06:20:43 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id b77-20020a621b50000000b00545b91e78d3sm14524120pfb.89.2022.09.19.06.20.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Sep 2022 06:20:42 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Mon, 19 Sep 2022 06:20:41 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Eliav Farber <farbere@amazon.com>
Cc:     jdelvare@suse.com, robh+dt@kernel.org, p.zabel@pengutronix.de,
        rtanwar@maxlinear.com, andriy.shevchenko@intel.com,
        linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, hhhawa@amazon.com, jonnyc@amazon.com
Subject: Re: [PATCH v5 18/21] dt-bindings: hwmon: (mr75203) add coefficient
 properties for the thermal equation
Message-ID: <20220919132041.GA3547266@roeck-us.net>
References: <20220908152449.35457-1-farbere@amazon.com>
 <20220908152449.35457-19-farbere@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220908152449.35457-19-farbere@amazon.com>
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

On Thu, Sep 08, 2022 at 03:24:46PM +0000, Eliav Farber wrote:
> Add optional temperature coefficient properties:
>  *) moortec,ts-coeff-g
>  *) moortec,ts-coeff-h
>  *) moortec,ts-coeff-cal5
>  *) moortec,ts-coeff-j
> If defined they shall be used instead of defaults.
> 
> The coefficients were added to device tree on top of the series property
> (which can be used to select between series 5 and series 6), because
> coefficients can vary between product and product, and code defaults might
> not be accurate enough.
> 
> Signed-off-by: Eliav Farber <farbere@amazon.com>
> Reviewed-by: Rob Herring <robh@kernel.org>

Applied to hwmon-next.

Thanks,
Guenter
