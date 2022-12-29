Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49984658ABD
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Dec 2022 09:57:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233008AbiL2I5U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Dec 2022 03:57:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbiL2I5S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Dec 2022 03:57:18 -0500
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2B86CE7
        for <linux-kernel@vger.kernel.org>; Thu, 29 Dec 2022 00:57:16 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id ja17so12709847wmb.3
        for <linux-kernel@vger.kernel.org>; Thu, 29 Dec 2022 00:57:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8ic43VHVW9R6k6oI9UHAIL60iJzHQ67Y4AV951PlE8Q=;
        b=TxwlrCzTrDmmG+wTA3/tM+p9QAnafIRXqh4Ua1lSFsNVBWbF0OAh3Fc2WgbOY3uufN
         oWfGxCjxvdTtJlszSquF4XztipaxbqRYAo2zgwf/t5jOI2Ud+nCsatxvBO24Yzl6UztA
         LqNFW8XyWku+SS7o86rlIPpu4y+Nl5LMbUMdc/r3hSvesZfQtnmEzrpY6sg+U52ejUuE
         28kwsWUqlrxmAMUgtelA8FWn0cRyl4DB2j1DZ83G2/NBl0OdZVR0sNaO1BsZA27xTucD
         KlIVPZws7ugMec/ZotoJF2MkmgByZh6SLyGELS1R3swdE323Yzb7bIbbb4Kw2+iYw+FY
         MlBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8ic43VHVW9R6k6oI9UHAIL60iJzHQ67Y4AV951PlE8Q=;
        b=EpjNPugFVWbS55SbMcCcri1uP0PPxlsUsumnq3Q+KdNvViR7hLBzQVlANCJ/ybe0JV
         ZPGFy3mrL/FbHkJP4afsIj8J++WYiZghWj9SuNoKA/E6k7JbvXDnqhOQp/lF0JlOAZZh
         YctXarNW2fonNd5AnUFcyiSZrSKZy/qcwVPlZyHECdkZ8dSRidkiOxkHHmKIa4ymoBG/
         zgnIszHEa/iCTbyYEYbY5dj3X/bfi6C9N0Empqo+njzXXBFBB4AtbpFPOBK+F1kOq0z8
         A95f0oWaUaLVfhoFlxZpngSMEcmm9756sAPJx12ONmEeFfHrbpThvH+L6xM7xD6cXmU3
         aFvg==
X-Gm-Message-State: AFqh2kq3AXPV09uwn7ZclH28UCGo4jbI7TdatcQYwJOv3deyshrNWHWB
        63e1NdS+1dUiswp7KJnVsDQ=
X-Google-Smtp-Source: AMrXdXvuGCKE9rhgMW5S5NuVWuaEzVHwAkNrJwGPH1OPX3mm1hl0B7t5Q7s1qhwe0EM2dQfW+RN2ug==
X-Received: by 2002:a05:600c:5014:b0:3d3:446a:b46a with SMTP id n20-20020a05600c501400b003d3446ab46amr20624683wmr.38.1672304235499;
        Thu, 29 Dec 2022 00:57:15 -0800 (PST)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id l6-20020a05600c4f0600b003d9780466b0sm17311651wmq.31.2022.12.29.00.57.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Dec 2022 00:57:15 -0800 (PST)
Date:   Thu, 29 Dec 2022 11:56:42 +0300
From:   Dan Carpenter <error27@gmail.com>
To:     Anup Sharma <anupnewsmail@gmail.com>
Cc:     bagasdotme@gmail.com, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev
Subject: Re: [PATCH v2] staging: rtl8723bs: hal: Fix codespell-reported
 spelling mistakes
Message-ID: <Y61WSt4vzTjhDFS5@kadam>
References: <Y605bbJ+gPtBFrAZ@local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y605bbJ+gPtBFrAZ@local>
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 29, 2022 at 12:23:33PM +0530, Anup Sharma wrote:
> They are appear to be spelling mistakes, initially identified in a codespell report and never been addressed so far.

You're going to need to wrap this line.  It's too long.  Run
scripts/checkpatch.pl on your patches before sending them.

> 
> drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c:656: regsiters ==> registers
> drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c:1696: beacause ==> because
> drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c:2092: Checl ==> Check
> drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c:2513: checksume ==> checksum
> drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c:2726: sequense ==> sequence
> drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c:2780: vlaue ==> value
> drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c:3409: equall ==> equal, equally
> 
> Signed-off-by: Anup Sharma <anupnewsmail@gmail.com>
> 
> Changes in v2:
>   - Added codespell report to make the commit message more clearer.
> ---
  ^^^
You need to put the v2 note under this --- cut off marker.

https://staticthinking.wordpress.com/2022/07/27/how-to-send-a-v2-patch/

v3 now.

regards,
dan carpenter

