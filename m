Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16AB168052E
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 05:47:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235544AbjA3Erv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Jan 2023 23:47:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235555AbjA3Ers (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Jan 2023 23:47:48 -0500
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6E73234FA;
        Sun, 29 Jan 2023 20:47:45 -0800 (PST)
Received: by mail-pj1-x1032.google.com with SMTP id mi9so858986pjb.4;
        Sun, 29 Jan 2023 20:47:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=oKL2NInmZ0LNi1cw4W/fihY59FtPj5zWMPWFc1V8d40=;
        b=QAE4uQkNTFQfDSPWBU1/PpqviUfEbgZvwWdD60gMzDywjtORX1j0XPK5MG5Ktw3A/k
         sT8DGBBb43XLYLhCP2LSm29xKxTizlvOCTwXt+1qhthk5VnH3PBaIW7qtLWxjh0oNucv
         CjCpTg99MKjbTDW0DSGy5lhH2mE/TOqrsKewkNrEgRteEq5sHTxCbdX7Q7dfQ7J1KREd
         D48//ckROYK5QxKz2NW5Zl//5iF4O1ZlmZCnoYomi/noNADgzdavvTVbuWonqFdol6YU
         mxQkM7ZJSyUxjn2fGk4rmnHQsJSJtUZLAJ6itidmCd5L87EAiomKBKTbd0gZOylAWgRP
         cdiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oKL2NInmZ0LNi1cw4W/fihY59FtPj5zWMPWFc1V8d40=;
        b=cEGum+jL6tIx/73Z72BDBlFJ73LDgGBoAqLM9Ct4iUCC2iQR73JiuRrwl66qs/Xnu6
         gvtQnbdlhKU0GoBTlP2QyMERRQccO2Bvmj7rwryhjah9OM8um3iR1kZxyknu0NRzlRj2
         dL0ZU0JuDNEu36RqdXTRIVBTiXIrFJoEdCmwqPOk8qPdFxBMej2Js1Xt/QqbCtjw+V4m
         /XtT0qbZGf1lXog603aFm0yMnu+5YVkO1eWCg9EJWYqYju3k4xc9K3OXFyElmcQS8Ppt
         vJ3keLicUl8pFWdkNevDYyMq6gHqIBxWrAQeZwaddv85fZ6cEWF0wBnH8SRJU62g3ZJK
         Y15Q==
X-Gm-Message-State: AO0yUKU4EjQR5YzWGlHZG9dg2ZiuhGF1V9jDaCLN7gpbYSnd3t0OIPjF
        v8QG6ZGG01SA5EE3pb0gkEM=
X-Google-Smtp-Source: AK7set/Z565qb0kacSv13SxjbrUHC82fFK4TzDEnlUslLCxYbz9C+IBFUtFoqmAeGR916UIdXGlBjg==
X-Received: by 2002:a05:6a21:99aa:b0:bc:bbb6:7582 with SMTP id ve42-20020a056a2199aa00b000bcbbb67582mr7051785pzb.21.1675054065176;
        Sun, 29 Jan 2023 20:47:45 -0800 (PST)
Received: from google.com ([2620:15c:9d:2:6882:174b:bc70:101])
        by smtp.gmail.com with ESMTPSA id c64-20020a624e43000000b00586fbbdf6e4sm6421843pfb.34.2023.01.29.20.47.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Jan 2023 20:47:44 -0800 (PST)
Date:   Sun, 29 Jan 2023 20:47:41 -0800
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     ye.xingchen@zte.com.cn
Cc:     wsa+renesas@sang-engineering.com, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Input: apbps2 - Use
 devm_platform_get_and_ioremap_resource()
Message-ID: <Y9dL7S5YgR4I2Bay@google.com>
References: <202301281604596831304@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202301281604596831304@zte.com.cn>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 28, 2023 at 04:04:59PM +0800, ye.xingchen@zte.com.cn wrote:
> From: ye xingchen <ye.xingchen@zte.com.cn>
> 
> Convert platform_get_resource(), devm_ioremap_resource() to a single
> call to devm_platform_get_and_ioremap_resource(), as this is exactly
> what this function does.
> 
> Signed-off-by: ye xingchen <ye.xingchen@zte.com.cn>

Applied, thank you.

-- 
Dmitry
