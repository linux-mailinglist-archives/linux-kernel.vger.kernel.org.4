Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C8F7677A83
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 13:05:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231441AbjAWMFA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 07:05:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231483AbjAWME6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 07:04:58 -0500
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFCD023C76
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 04:04:53 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id c4-20020a1c3504000000b003d9e2f72093so10435310wma.1
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 04:04:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=yEW+4BVZ5ANLLKSU6/pPWr+45B5glov6svDw8cCDQvI=;
        b=RmFzJxAPOtZ8+xn00ZferYr7RB5rD7OufL3hGTVRHS4dvw83IRFiZDzmpQsv3UnxLT
         tEMn+gpS1FdOKiCKS29Hb4mIi1Jnj6s2tMyLhkR866+3W/b+bhKLqlWharvxz6vaZsKU
         J1re8wH1mLk9y5qZDZ8mIrhRUadvn5z5vFewkRXTaL3inZKPA6JDQGSzewNHvjc70TEh
         kfP5jJgs8xitNRe8DsT74NXADTULkfkewhGUN62ABEMxMbicAV6whi2hSHj6OWQTOm/9
         z8f/yKUZwmU8U1luOafA+nCnhICe10Z8dOKf5Rhf5ZXw9WAMOixts8ho05CzL4xUUYpR
         YBsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yEW+4BVZ5ANLLKSU6/pPWr+45B5glov6svDw8cCDQvI=;
        b=axxoReI9scWg8PiXmP/kl1Hc8yt3QTPYReMP4Yd95Yk6NT/+Q7apzNwTTnBVbNaH5o
         Ips9HPaDSS8GAnl7UzahODOVN+asNNjQbtfiNF3RrcUOS4bEcGexDsSkRaMav6CvT2yT
         G7j5FleKVRIEVUGHKDt+OMP79dXaeh9PRpqBPS08b1oFB6fbB6BchGIuuoPRMddK0TPK
         S9w3IbDaNd5eDIgsS/g5l5RjHEuN5Ye5JsC84m5zc4p6Nui2DoPUy3+wnYP0wMhKUKxQ
         L0PrbL1WMxEforV/ynCwpJHrFfbqqJ07HMIOIaE07mODnD9Im7o+FXYU4OGUGlBFSuga
         8VjQ==
X-Gm-Message-State: AFqh2kpUqozCHk2nNndH/3oET8bAGj55bRpflwAx1svXduji7No/+VQZ
        b2gRLF1H4sFS0ja1aU6zvwb1MiWsHT/gVA==
X-Google-Smtp-Source: AMrXdXv5ZMGamm9R3AWrjyhn15xXR3YYflE3NfcWaD+iEm1LJp3aaueWtJibWE7ROr2kFZ2GA1xlyQ==
X-Received: by 2002:a05:600c:5390:b0:3d9:a145:4d1a with SMTP id hg16-20020a05600c539000b003d9a1454d1amr20516589wmb.34.1674475492382;
        Mon, 23 Jan 2023 04:04:52 -0800 (PST)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id f14-20020a05600c154e00b003daff80f16esm14511122wmg.27.2023.01.23.04.04.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Jan 2023 04:04:51 -0800 (PST)
Date:   Mon, 23 Jan 2023 15:04:48 +0300
From:   Dan Carpenter <error27@gmail.com>
To:     Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Diederik de Haas <didi.debian@cknow.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: wlan-ng: Fix full name of the GPL
Message-ID: <Y8534H/2JvussfAh@kadam>
References: <20230122191047.58769-1-didi.debian@cknow.org>
 <Y84wk+sw/gR7gNW4@kroah.com>
 <Y85Kkax5+U4AUedT@debian.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y85Kkax5+U4AUedT@debian.me>
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 23, 2023 at 03:51:29PM +0700, Bagas Sanjaya wrote:
> On Mon, Jan 23, 2023 at 08:00:35AM +0100, Greg Kroah-Hartman wrote:
> > - You did not specify a description of why the patch is needed, or
> >   possibly, any description at all, in the email body.  Please read the
> >   section entitled "The canonical patch format" in the kernel file,
> >   Documentation/process/submitting-patches.rst for what is needed in
> >   order to properly describe the change.
> > 
> 
> Hi Greg,
> 
> drivers/staging/wlan-ng/hfa384x.h (for example) has already SPDX identifier
> that matches the verbose copyright notice below it. 

Resend the patch with a better commit message.

https://staticthinking.wordpress.com/2022/07/27/how-to-send-a-v2-patch/

regards,
dan carpenter

