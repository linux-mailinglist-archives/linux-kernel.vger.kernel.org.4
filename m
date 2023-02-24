Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D70096A1B2B
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Feb 2023 12:10:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230331AbjBXLKj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Feb 2023 06:10:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230162AbjBXLKG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Feb 2023 06:10:06 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86CA76A75
        for <linux-kernel@vger.kernel.org>; Fri, 24 Feb 2023 03:09:43 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id j2so13342085wrh.9
        for <linux-kernel@vger.kernel.org>; Fri, 24 Feb 2023 03:09:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=n/Z2k3uhGM1mFQRxjY65KZb2SAot2YZx+BGvC1DEn5A=;
        b=aji8sxAZQ8b1cIhTPkaiHJK+srEp+45Xx4S3DISIzCNcCFdyXPJWlQANMsK0ObnPO+
         olTwlYHERBgsNdwg0z6qbqdwg6AbeO/akzM61PEv/+eivk0nV0Eepf9ZJv3K5WMnbO7/
         sVCQHtqBKTv1f3eXdNwYlj53Up/xRhUQM2y3ZVPgl3Qtzf3l7FGAd2jFsOF2Kx2vU+yv
         xrplZhufJEizVwWwWY3n0ullcCU04ttij7QOLEMXoZddjEEFwwP60X45ZKEY/Dk28tec
         BDalhFPi15YlrO8zDSr1LnmmvUvarj0KPMJjtGmr7og5xZtsf3DsP3kro35n+IX5wh+7
         QJ2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n/Z2k3uhGM1mFQRxjY65KZb2SAot2YZx+BGvC1DEn5A=;
        b=NBTRwmqZT9sQy5oNk/YMiniTrT5Or4e5U2zsx/fdIyOE/yKftb2xnLikBeHcwOSSNy
         YmuczWyFJ4r1Gw4rsdGCtGiE68rL6Wg5DoDkzAaLl2b/5f6ontbe0312wzTLvfBLGCL2
         O8Qdu6g2gBvnukaTxCMmzP5noWrFqVpGrPy3bRr+CV6bVfAXl58vQHxojxqSOPO3ooUk
         z9wa10zG6FvF8BbIIG0cTQC13sqLtWmDabjSCunbpIt9sevzwx506zYkP7TKTTtHNjRw
         2ebB6jDbOGZIa8LgGO0GhxrsBVyn5pWczMTjdaK77sEg1H8Fg1vyxS/D6nnZ1QyfYY39
         AR0w==
X-Gm-Message-State: AO0yUKWN+md7sXH7rgb671PMZY/EywTcO3mfmm61n7C+kcj3woMt67CJ
        W9A63tsaVlwC9O9DHnToX2LT83OtsU8=
X-Google-Smtp-Source: AK7set9Mtdu29Yf04ZhDdSBgs2apjDJ293D2pS7KKtWtozcLW7fZUhcEdHk0+a2ZB/0b5BqX017e0Q==
X-Received: by 2002:a5d:690e:0:b0:2c7:1e52:c5a8 with SMTP id t14-20020a5d690e000000b002c71e52c5a8mr1327995wru.21.1677236981951;
        Fri, 24 Feb 2023 03:09:41 -0800 (PST)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id h10-20020a05600c350a00b003daffc2ecdesm2731291wmq.13.2023.02.24.03.09.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Feb 2023 03:09:41 -0800 (PST)
Date:   Fri, 24 Feb 2023 14:09:33 +0300
From:   Dan Carpenter <error27@gmail.com>
To:     Rohit Chavan <roheetchavan@gmail.com>
Cc:     Martyn Welch <martyn@welchs.me.uk>,
        Manohar Vanga <manohar.vanga@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev
Subject: Re: [PATCH] staging: vme: remove unnecessary parentheses
Message-ID: <Y/ia7a6YdjpfUAx4@kadam>
References: <20230224105048.758-1-roheetchavan@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230224105048.758-1-roheetchavan@gmail.com>
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 24, 2023 at 04:20:48PM +0530, Rohit Chavan wrote:
> This patch removes unnecessary parentheses in order to fix a checkpatch issue.
> 

This line is too long.  Commit messages can only have 75 characters
per line.  Please run checkpatch.pl on your patches.

But also Greg doesn't like the "unnecessary parentheses" warning so just
ignore checkpatch for those warnings.

regards,
dan carpenter

