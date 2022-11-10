Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C6896240B7
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 12:07:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230394AbiKJLHL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 06:07:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230397AbiKJLHJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 06:07:09 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34FAB6CA02
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 03:07:08 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id bs21so1733465wrb.4
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 03:07:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=qDtELxG2pjhBBxJl2d7+OAI9FoT6ZVqcBQqrZubApBo=;
        b=phLYZJ+uh6cOW8osdoGD2YoQRQYOvhS7h1MD8zcvdPhYuU1tnlQR3QapS6MJSA01ue
         SQKB3V/4NFj9fU2njEDHJm5d/+evzApG6UbNTYJlT7BwvXlB+zZmLXaD0eBwK+0RFI9F
         38IQP3Clqx2VoJY/BQ5sS50KV9jKXISrQUUNTwrjY0BclAAVCrgdJ/CrYR8RVqoF0Jk7
         zAmfHEp3OfGhkQOSAqwQ2UJB5DIU/TAypo5j6au0xg8jULfnW/ER9CCBtzVPOHvfTQa+
         lsmJfTXnO7+SwOyVMP++BpXtmiBFjoyAMqeOskvhv2YwGxWuy0Xlg9MGA1XcdcSzO+Uo
         byAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qDtELxG2pjhBBxJl2d7+OAI9FoT6ZVqcBQqrZubApBo=;
        b=pNYPkMSlu+MK2ArVyxTV0JSTZ3I79rybVxgWYwtgl18iPLsw/cjQq/s0dxslPYsI35
         cjFdB9mG5esPPvGfMwhelhjxprVQaXx83/N/2fG0OZU40BR03xEZD40jS9z0Yjylza+D
         cxjWC9UoZ/vbSZNPl8tneulyOLTghNF4xhu/O/c3x9BL2F4r1z19Z0vSOK0eShaHo3nl
         e5KY9wTpk3QEQFvay70YNl+G+n7kKLGxUpLDkdH9YeT92xS8feClumnOszGGNkwETOwo
         37+AdMHILfU7BFrxumYrkg3JiTHVCLyi4jWQ812bsMNYXDLrRmh5gwwfW9dT1ShMN8Iz
         M6Sw==
X-Gm-Message-State: ACrzQf1PjtrmS4krIPmlf/7M7dHOsKTZFNQPam0VtxAWtk3jq0IPQwmM
        MsnOjt13rX2Dbbuqcs3rY4NZe9qaZUY=
X-Google-Smtp-Source: AMsMyM69vyORlfbR5KwRfwyoaSWG4uOdtnNEmFwPVWzlRBZKjmL8e/6zAYbguV1RVwHNC7p5EohL3Q==
X-Received: by 2002:adf:fa01:0:b0:236:debd:f682 with SMTP id m1-20020adffa01000000b00236debdf682mr31424167wrr.49.1668078426699;
        Thu, 10 Nov 2022 03:07:06 -0800 (PST)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id fn14-20020a05600c688e00b003c6bd91caa5sm4537185wmb.17.2022.11.10.03.07.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Nov 2022 03:07:06 -0800 (PST)
Date:   Thu, 10 Nov 2022 14:07:03 +0300
From:   Dan Carpenter <error27@gmail.com>
To:     Jacob Bai <jacob.bai.au@gmail.com>
Cc:     gregkh@linuxfoundation.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 2/2] staging: rtl8192e: replace macro defines with
 variables
Message-ID: <Y2zbV6xDUGPv8mVY@kadam>
References: <cover.1668075486.git.jacob.bai.au@gmail.com>
 <354847ce7b2f9ea4dc549bf13656192c1db7c231.1668075486.git.jacob.bai.au@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <354847ce7b2f9ea4dc549bf13656192c1db7c231.1668075486.git.jacob.bai.au@gmail.com>
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 10, 2022 at 09:35:11PM +1100, Jacob Bai wrote:
> -u32 RTL8192E_PHY_REG_1T2R_ARRAY[RTL8192E_PHY_REG_1T2R_ARRAY_LEN] = {
> +u32 RTL8192E_PHY_REG_1T2R_ARRAY[] = {
>  	0x800, 0x00000000,
>  	0x804, 0x00000001,
>  	0x808, 0x0000fc00,
> @@ -158,8 +159,9 @@ u32 RTL8192E_PHY_REG_1T2R_ARRAY[RTL8192E_PHY_REG_1T2R_ARRAY_LEN] = {
>  	0xe18, 0x161a1a1a,
>  	0xe1c, 0x12121416,
>  };
> +u32 RTL8192E_PHY_REG_1T2R_ARRAY_LEN = ARRAY_SIZE(RTL8192E_PHY_REG_1T2R_ARRAY);

This patch is kind of a headache to review.  I have to go through and
count 148 array elements to ensure that the array hasn't changed size.

But the first patch renames all these arrays, so I first have go back
to patch #1 to find the original name.  It might be easier to do the
renames afterward.

Also the commit message should say something like "I have checked the
object code and there is no change at all" or "I have counted all these
array elements and there is no change to the size of the array."

regards,
dan carpenter

