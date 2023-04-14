Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56BC36E1CC5
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Apr 2023 08:42:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229739AbjDNGmA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Apr 2023 02:42:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbjDNGl7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Apr 2023 02:41:59 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6D85189;
        Thu, 13 Apr 2023 23:41:57 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id lh8so4482553plb.1;
        Thu, 13 Apr 2023 23:41:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681454517; x=1684046517;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9woUy3PxgOHJgXfQPPz0DGWiVkVDHz3NkKhCrLWDH8k=;
        b=Xxkzg9VaOCUKcsG/uiCwjCpRK1yGJTP/PhnyQgUNlHioxtysplrgHNf5YB/NyuPnFR
         1ov1yCdOnGGRZ5M/wpJly6T5ctGhFmZcfDa6hH8SyFMBua9ZyFDaXnIwV+fufIHCjPap
         mPohPm/AwokDzhFyRe+Mdnf6RMTtXNIv2DGBdzzHw8iWCo4nIEdvZh6fU+icpcpRaVQZ
         f/ZG49gTz5ASYy6aevmPNm7g3WGGgOvu4Jl10nzbnWpBMBBrxrVwrtPTG9ME+nn2J3Vi
         TYfIU7Rqe4BBXO1HDwF8MBA6lD2giFhaqvYXnShb6EelTgRcYF461myagsXVSsp5K1sa
         lKWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681454517; x=1684046517;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9woUy3PxgOHJgXfQPPz0DGWiVkVDHz3NkKhCrLWDH8k=;
        b=DO4m8WjCzd5YdpWJE7FAqhl6VO8eq2D73GhQEN4Ez0Zh9KvmDhg8WpTtO4irYEtkUm
         Gs/CnfhkCc26LulvOEROifQDpurAE+RaccEHlYTk9lScX+mQ8npj23A9HVJiQDHUK5Uy
         OJeD2oMYU879RZpwf+/nuaNxpW8gDuHv7ptNsmD5U8djWDj9k/bcIyj7sHy3yhxCEHe3
         aZTnbftMyET/gHXdoI3bxlCmvRxxtZ8XCwyFWc8moB2DGxi/B+TIRWCanXDpCcS17nzQ
         bin1FTEB+lw+kpoj+RqLmQp5E5ZJukEETmqdCZGRsXoKEub3OgqB1D1KPIEi1iWM6FNq
         cdgA==
X-Gm-Message-State: AAQBX9cwuVW+3wOvXVhUpGY6cdOj5AS3cEAJDZYrNcatEvyweAnybMzD
        jpxuJAz1RGoSB56hbjTT+2qDCUFqbjqU0w==
X-Google-Smtp-Source: AKy350aWTJiXJ3XOXdk2PsVpOVhuR217IAPmV97Bw5Aury8vQ9rEDnd17Ifgon1BjwnbYyDXGOpPYw==
X-Received: by 2002:a17:90b:314c:b0:234:e0c:caaa with SMTP id ip12-20020a17090b314c00b002340e0ccaaamr4489720pjb.6.1681454516977;
        Thu, 13 Apr 2023 23:41:56 -0700 (PDT)
Received: from google.com ([2620:15c:9d:2:5142:7eb2:ace5:60c1])
        by smtp.gmail.com with ESMTPSA id m4-20020a17090ade0400b00231227781d5sm4247509pjv.2.2023.04.13.23.41.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Apr 2023 23:41:56 -0700 (PDT)
Date:   Thu, 13 Apr 2023 23:41:53 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     hrdl <git@hrdl.eu>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        Alistair Francis <alistair@alistair23.me>
Subject: Re: [PATCH] Input: cyttsp5 - fix sensing configuration data structure
Message-ID: <ZDj1sXlHNJDlC523@google.com>
References: <20230411211651.3791304-1-git@hrdl.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230411211651.3791304-1-git@hrdl.eu>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 11, 2023 at 11:16:51PM +0200, hrdl wrote:
> Prior to this patch, the sensing configuration data was not parsed
> correctly, breaking detection of max_tch. The vendor driver includes
> this field. This change informs the driver about the correct maximum
> number of simultaneous touch inputs.
> 
> Tested on a Pine64 PineNote with a modified touch screen controller
> firmware.
> 
> Signed-off-by: hrdl <git@hrdl.eu>

Applied, thank you.

-- 
Dmitry
