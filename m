Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACF19658B3C
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Dec 2022 10:52:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232081AbiL2Jvl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Dec 2022 04:51:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230073AbiL2JtX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Dec 2022 04:49:23 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B2B5BD8
        for <linux-kernel@vger.kernel.org>; Thu, 29 Dec 2022 01:49:09 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id z10so16927364wrh.10
        for <linux-kernel@vger.kernel.org>; Thu, 29 Dec 2022 01:49:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=sGQu9zaoGiTvvokNF12XdMZeXrMDq+udW21w5TfdmPU=;
        b=Sr0cbGK6iyGpJRqPGXFi/1Gt4IVqCB8HIYvN5Nc26ZnQ878k1xBdd7X6yHDuA1RGXD
         4H45gVTxKCTQJz83XPxYSvGfzso0ZvGheZeN0T9/zXT2A/pZkDK68kwtYLwyW5uhC4tE
         6YrTyURGoQ+aLNwOjNLiYIoB8hLjANRTOelFyuAeynbH3EOK9Pto2gqxkH09mOshh8HV
         Z1Ug0r86MWCZ9eJa/yizzA1VkvXSKg2a5bgaWAezlyAof21yVE2YUtvcj97Xt922x8aG
         i1Bh65DWfRspifsGK5MTEOGwF2M5TmdAhlq+v7J5iigTLA6geNghfXvtcvGs7CEuz2Rz
         Kgcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sGQu9zaoGiTvvokNF12XdMZeXrMDq+udW21w5TfdmPU=;
        b=aStbIocXtiftc1BynBcYApHd2CPJTiLOdQ/dXDDwH78/LfquQnXwt43dnnVn9atoJc
         EYf8TmpO2a83Z/rzV0u9rliaj3sroU1VOwMD8ajQzI19gTpTUFRV2I0h5FcXhlegTKRe
         j+usFGjbCQQPY6fqKe2AecV10g/Oa8OQFMNoFj1Kr/KvI0vNZPAKhrqnFqwjahFC1+18
         ZWVEHztc4/wY3BBj3PCbMLHP4CMXLuna7Bly4EdLiQocNi2Qi9Q60RbEVqb0gZvz67Fs
         wjnPNUEr1Tob2gwLASy8fKf055Www0Afg5XrZ2fj6V8G8ywouUA7Ieg/CJR6w9evOJ1f
         aQsg==
X-Gm-Message-State: AFqh2krHkOgLuXhNkvJ+5hALV4DrZwsIQZruyx3Dfy8SfwLqxWKoMlyN
        6NF7tSictR4bFCC1NkUh4Ak=
X-Google-Smtp-Source: AMrXdXs9n04ZTXVb0tTcwCQaxPUqKDBHTXiszLnaSokx9MBxtjRZVELyIHROgISb344M6iUNU9qijQ==
X-Received: by 2002:a5d:4902:0:b0:281:cdb2:f351 with SMTP id x2-20020a5d4902000000b00281cdb2f351mr622047wrq.67.1672307347529;
        Thu, 29 Dec 2022 01:49:07 -0800 (PST)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id v18-20020a5d6792000000b0027e5501f7f5sm9777775wru.53.2022.12.29.01.49.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Dec 2022 01:49:06 -0800 (PST)
Date:   Thu, 29 Dec 2022 12:49:04 +0300
From:   Dan Carpenter <error27@gmail.com>
To:     yang.yang29@zte.com.cn
Cc:     gustavoars@kernel.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org, xu.panda@zte.com.cn
Subject: Re: [PATCH linux-next] staging: ks7010: use strscpy() to instead of
 strncpy()
Message-ID: <Y61ikBL9ulTFHP9N@kadam>
References: <202212261903245548969@zte.com.cn>
 <Y61hpuMcp3NKbqL5@kadam>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y61hpuMcp3NKbqL5@kadam>
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 29, 2022 at 12:45:10PM +0300, Dan Carpenter wrote:
> On Mon, Dec 26, 2022 at 07:03:24PM +0800, yang.yang29@zte.com.cn wrote:
> > From: Xu Panda <xu.panda@zte.com.cn>
> > 
> > The implementation of strscpy() is more robust and safer.
> > That's now the recommended way to copy NUL-terminated strings.
> > 
> > Signed-off-by: Xu Panda <xu.panda@zte.com.cn>
> > Signed-off-by: Yang Yang <yang.yang29@zte.com>
> > ---
> >  drivers/staging/ks7010/ks_wlan_net.c | 3 +--
> >  1 file changed, 1 insertion(+), 2 deletions(-)
> > 
> > diff --git a/drivers/staging/ks7010/ks_wlan_net.c b/drivers/staging/ks7010/ks_wlan_net.c
> > index 044c807ca022..e03c87f0bfe7 100644
> > --- a/drivers/staging/ks7010/ks_wlan_net.c
> > +++ b/drivers/staging/ks7010/ks_wlan_net.c
> > @@ -382,8 +382,7 @@ static int ks_wlan_get_nick(struct net_device *dev,
> >  		return -EPERM;
> > 
> >  	/* for SLEEP MODE */
> > -	strncpy(extra, priv->nick, 16);
> > -	extra[16] = '\0';
> > +	strscpy(extra, priv->nick, 17);
> 
> I think this code is a buffer overflow.  This is an implementation of
> SIOCGIWNICKN.

Huh...  Maybe I'm wrong.  I looked at a couple other implementations of
SIOCGIWNICKN and they all seem to assume a 17 character buffer...

Let me look deeper.  I guess for now assume I am wrong.

regards,
dan carpenter

