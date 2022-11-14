Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87E12628D50
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 00:20:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237814AbiKNXU3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 18:20:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235813AbiKNXU1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 18:20:27 -0500
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BF1310EF;
        Mon, 14 Nov 2022 15:20:27 -0800 (PST)
Received: by mail-pj1-x1034.google.com with SMTP id f5-20020a17090a4a8500b002131bb59d61so21838pjh.1;
        Mon, 14 Nov 2022 15:20:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XYE+aPNNHJ7fVwVvl7/DiAZRroOufRRoYNS0OuqrPeI=;
        b=IuE/15Ju55FoBQ+HJwIbs85VTtZM91zKA8Egi8SNlLSOu8NPKunLk7mq/YwiwSWUGh
         lUDqxVK0A4+Bx2Z9NU3qTPsZwa1BJSOpkNtK81vImBXzAwcGzXNfm3DCwuo4e18YodNy
         yupwPR5HoCrYgtaXSiGGJt9jKsq8UOGvuEBVLHZRbTEQKY+l5Og2cglOKG0clWyPuDgC
         4/aqTN6pahfgMI+ta2jPdhv16W3oc1IFHaBybbmftDKWZ7z9hxiYMpdMT63CiVGQ9gr+
         ktDG9oYr+CTnqA6p94an280aUcpSUcC9O4VI5pQykAWNn9g6o5PMhQHt4evitj2MMbjo
         16Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XYE+aPNNHJ7fVwVvl7/DiAZRroOufRRoYNS0OuqrPeI=;
        b=kay3UeBBtZZ1+gd6h9xF3HbwBKa7Pq7/wnh1OIkKAX3zPtfJIQXJr/zead19jCnBlK
         Wct22HEYzY4FfNTYmx+d55s1sjvP0koLnZtbIdsz/L3PW4jPfiK10l9lbCWuzaP4Ig59
         dW3Afk4mI1vVp+DX5jUDM6e2nw30x8QX3eo41CH3ewGqWF0zl1Nr+8trNk2fenjRvVK1
         Zkd8xf3VWIcFff29QSgIXp143Dq8iZhn5bizqEBgxAmrCUjaa9uLuUaeShW4mElTzb9A
         k8yBxm3CUp5mYFySrsE6iflH8XiC1J84qDQ/p9vZyfdtSOp+whRt4PYSzeQ5wlQv8mV0
         9r9g==
X-Gm-Message-State: ANoB5pkKoW/OCtJH5yEhJ8Aj6sB/j3zz4OB2Dj6C7KQ8kY94qPM9zYZ6
        WKX4rQWHRjWKkW6xKjAmSsa1qZcj7ps=
X-Google-Smtp-Source: AA0mqf6CZ+K7NCcfD9AKrzS+wqdvy+rG3oXMNSgcPQXt0qJJGPDebwK3iSladG+X3Wwm5+1dt5Br3Q==
X-Received: by 2002:a17:902:8484:b0:185:55db:c328 with SMTP id c4-20020a170902848400b0018555dbc328mr1432521plo.71.1668468026753;
        Mon, 14 Nov 2022 15:20:26 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id c4-20020a655a84000000b00473c36ea150sm6289908pgt.92.2022.11.14.15.20.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Nov 2022 15:20:26 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Mon, 14 Nov 2022 15:20:24 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     Roger Lucas <vt8231@hiddenengine.co.uk>,
        Jean Delvare <jdelvare@suse.com>, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-hwmon@vger.kernel.org
Subject: Re: [PATCH] hwmon: Remove some useless #include <linux/hwmon-vid.h>
Message-ID: <20221114232024.GA2289674@roeck-us.net>
References: <41610f64a69bd0245ebc811fcff10ee54e93ac46.1668330765.git.christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41610f64a69bd0245ebc811fcff10ee54e93ac46.1668330765.git.christophe.jaillet@wanadoo.fr>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 13, 2022 at 10:13:16AM +0100, Christophe JAILLET wrote:
> <linux/hwmon-vid.h> is not needed for these drivers. Remove the
> corresponding #include.
> 
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

Applied to hwmon-next.

Thanks,
Guenter
