Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79FB5693DE0
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 06:27:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229907AbjBMF1q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 00:27:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229910AbjBMF1n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 00:27:43 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE310EB5A
        for <linux-kernel@vger.kernel.org>; Sun, 12 Feb 2023 21:27:42 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id o36so7910590wms.1
        for <linux-kernel@vger.kernel.org>; Sun, 12 Feb 2023 21:27:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=d0i8yyIm+gGF9ZBg2Jv4kyt1WO1dq4pAI/4blUIxBss=;
        b=FwrbHQrd1rLSIbDm6SzojQjzwesCLRr61Pm5udUaORLjg6Oa4zW5UDChv0XHXhp2QN
         KWgDvHbORXtH90Ot9w7C1DY0827qQxUfiE3lvEn1MLP5f2/zz4+gHiS1aFaVozW/OOOd
         S83r+Dz7IMyHbCyfa2bJ7xIWq2cXizWEoPSH4EuKT81hBobeTZcKQew5J8S2BwSSCSCH
         Y1C5XQfymXwu2Z3wf2EZ7JakkH6mpm6mIh9CwB8LhN5IJ4NgNbH0Ma8tWt4RjTX5dsUV
         FNA14mZW5+YI3ynIAfGCz8hTnvryEKigZdXhuUIwZWIYI9mEzlfTpxytUIOqzoJzD+dq
         SHNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d0i8yyIm+gGF9ZBg2Jv4kyt1WO1dq4pAI/4blUIxBss=;
        b=xyOcD0SnW9Xcb5xCRPAgNiZFUzvLV9o+nPNLS/6OyKUCUZ3gA7vH59/c2ZUKRgcoSN
         jWVe0+PouG1T1pyzpVD+vL693awHAga4UA3sxol39BZi+QZenip2o04wTd/5WiK60DFf
         w4kKPjjJOn2AiBbXvU3yIL8BqmxefJJuc2Sm3agE+u+F9mYhNMyUTuI4JVC5U9aBXAB1
         rHYTIGKXN82jpG5Vf9caMkeciQhf9ARAAdQ5UQtkkVp3uoRxNhp3qtio3xx/F1Q1cq9v
         CxflP8YfogCG3OVxQBLFeadqaiNEkiXTH95Eyz88iwGLiNrNKFzWVDvgVQd+X8k9v4VV
         lwWg==
X-Gm-Message-State: AO0yUKVC7OL5lozB/0bVLBpm1Qpf0HUcQ3XXwWSi/OkN3GXBCBvuMzH2
        F1diR5QSqwuDfYVlTS7WLTs=
X-Google-Smtp-Source: AK7set+B6jDm2d1ZqDtLGONP9jZueVno76liDBoh/Hm6c2bxVtjLXpZIiQHTXG9nMYbtx1h6KC6yYQ==
X-Received: by 2002:a05:600c:a295:b0:3dd:1bcc:eb17 with SMTP id hu21-20020a05600ca29500b003dd1bcceb17mr17970915wmb.28.1676266061450;
        Sun, 12 Feb 2023 21:27:41 -0800 (PST)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id n22-20020a05600c4f9600b003dcc82ce53fsm13960099wmq.38.2023.02.12.21.27.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Feb 2023 21:27:40 -0800 (PST)
Date:   Mon, 13 Feb 2023 08:27:37 +0300
From:   Dan Carpenter <error27@gmail.com>
To:     Martin Kaiser <martin@kaiser.cx>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Michael Straube <straube.linux@gmail.com>,
        Pavel Skripkin <paskripkin@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Revert "staging: r8188eu: simplify rtw_get_ff_hwaddr"
Message-ID: <Y+nKSc6fPf4E1Y2S@kadam>
References: <20230211183205.426820-1-martin@kaiser.cx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230211183205.426820-1-martin@kaiser.cx>
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 11, 2023 at 07:32:05PM +0100, Martin Kaiser wrote:
> This reverts commit fd48124e09825797bdc8ff0120f2401030c618ee.
> 
> The cleanup in this commit removes the qsel to addr mappings in
> rtw_get_ff_hwaddr. The underlying assumption is that rtw_write_port
> uses its addr parameter only for the high_queue check.
> 
> This is obviously incorrect as rtw_write_port calls
> ffaddr2pipehdl(pdvobj, addr);
> where addr is mapped to a usb bulk endpoint.
> 
> Unfortunately, testing did not show any problems. The Edimax V2 on which I
> tested has two bulk out endpoints. I guess that with the incorrect patch,
> addr could only be 0 (no high queue) or 6 (high queue), both of which were
> mapped to the first bulk out endpoint. Data transfers did still work...
> 
> Signed-off-by: Martin Kaiser <martin@kaiser.cx>
> ---
> 
> Hello Greg,
> 
> sorry for introducing a regression in commit fd48124e0982 ("staging:
> r8188eu: simplify rtw_get_ff_hwaddr").
> 
> Could you take this revert before the 6.3 pull request?
> 
> Thanks,
> Martin
> 

I feel like the ancient `git revert` script is not at all in line with
current standards and sets people up for failure.  This one at least
has a commit message.  But
1) The subject doesn't have a correct patch prefix.
2) "commit fd48124e09825797bdc8ff0120f2401030c618ee" is not human
   readable or how we describe commits these days with a 12 char hash.
3) There is no fixes tag.

regards,
dan carpenter


