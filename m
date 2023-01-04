Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A540165D460
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Jan 2023 14:36:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234514AbjADNf6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 08:35:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239441AbjADNfT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 08:35:19 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8699442E22;
        Wed,  4 Jan 2023 05:33:19 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id t15so24089430wro.9;
        Wed, 04 Jan 2023 05:33:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1OZYEOsIa4HC8bLEt9jxOMrEzLh4jE7nib0ZT+FWq/g=;
        b=SpSZbnAzW6o9lg07NRzRVSfCJpbhYU7a2YVcM/TLkt2cPBzgq5yO33mVU57wQ14Ez+
         lzUdAcGRRgxyCuqpYSk8Bq4k3/N4Jj4C+CyVZROziBQ0kgqELjPMNQTgm2pMaIilbHz9
         /kT+HrG87x5VlCzEnKybjkC3u2hgkRrW7cO6PDSI7BMHVAgIUuEZQE/Tx7s4dGPQxItx
         Pwccv0rxsXD2UyJc/7TsLF0xQb8oYXWCsNegth8cxa73RWYXa2F2nKtgtqS7GiUl6/+r
         UYsxu5am1bQCRzGlem2QX1gEh0jw0YuzNu1ROY18vdETW9ZGOoTv5nzEtZvshPytMk5b
         szcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1OZYEOsIa4HC8bLEt9jxOMrEzLh4jE7nib0ZT+FWq/g=;
        b=bXZrr/GFJj09OM9GybaXDnq4Qhm5mJ+6okyW+NOLimp+g5FIa3SyMFF2CW/vf3RfX6
         wtmE2uh9dxrcA89ptQgi+x7Om77Xo0eAukk7mMSO6hqfbNgJ+LkbGaZra7J4jbkGtdzT
         NteJIJZ8eAkLJr9dMdWUOrnBPraP3FF/+bSM6gQ9KFgP9IeavOVQVEBZifJGWvqF8HHd
         +4cCCKuSyTOPbpTwMNhDCaJQyeChkbOAcdC+1y8queYncSQVT2WKKR3o9mpk7IRWdJ5L
         5qlwa28gCRYlDwgm5kWCMrcVsvkUve6YuOS+REEbXcSF+1g6lY+oifKVOCKyfySnPbTm
         qYZA==
X-Gm-Message-State: AFqh2kpTQr11JE87FUUbzxvTY2Kcfvpb39oKBTLVuES9C1BGRjlVXeD9
        YaH9NAB3kMPLa6yNaRzsWfI=
X-Google-Smtp-Source: AMrXdXs4S3mE1SgBSPU2HGJPt7oU9k09p3+BZXz1hKBcx6RAjNzKLxxc12jfkmafWZjX6s/MtZFqOw==
X-Received: by 2002:a5d:54d0:0:b0:24a:e56d:e20 with SMTP id x16-20020a5d54d0000000b0024ae56d0e20mr29166930wrv.29.1672839190899;
        Wed, 04 Jan 2023 05:33:10 -0800 (PST)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id s13-20020adfdb0d000000b002420dba6447sm34648247wri.59.2023.01.04.05.33.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Jan 2023 05:33:10 -0800 (PST)
Date:   Wed, 4 Jan 2023 16:33:07 +0300
From:   Dan Carpenter <error27@gmail.com>
To:     Sakari Ailus <sakari.ailus@linux.intel.com>
Cc:     Aleksandr Burakov <a.burakov@rosalinux.ru>,
        Bingbu Cao <bingbu.cao@intel.com>,
        Tianshu Qiu <tian.shu.qiu@intel.com>,
        linux-media@vger.kernel.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org, lvc-project@linuxtesting.org
Subject: Re: [PATCH] staging: media: ipu3: buffer overflow fix in
 imgu_map_node
Message-ID: <Y7WAExw/lQg4cd1E@kadam>
References: <20221223123025.5948-1-a.burakov@rosalinux.ru>
 <Y7LfAR4QdIzp81yW@paasikivi.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y7LfAR4QdIzp81yW@paasikivi.fi.intel.com>
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 02, 2023 at 01:41:21PM +0000, Sakari Ailus wrote:
> > diff --git a/drivers/staging/media/ipu3/ipu3.c b/drivers/staging/media/ipu3/ipu3.c
> > index 0c453b37f8c4..cb09eb3cc227 100644
> > --- a/drivers/staging/media/ipu3/ipu3.c
> > +++ b/drivers/staging/media/ipu3/ipu3.c
> > @@ -60,8 +60,10 @@ unsigned int imgu_map_node(struct imgu_device *imgu, unsigned int css_queue)
> >  	for (i = 0; i < IMGU_NODE_NUM; i++)
> >  		if (imgu_node_map[i].css_queue == css_queue)
> >  			break;
> > -
> > -	return i;
> > +	if (i < IMGU_NODE_NUM)
> > +		return i;
> > +	else
> > +		return (IMGU_NODE_NUM - 1);
> >  }
> >  
> >  /**************** Dummy buffers ****************/
> 
> Thanks for the patch. It would require a bug elsewhere in the driver for
> this to happen. If some handling for this case is added, it shouldn't be
> hiding the issue.
> 
> One easy way could be to add WARN_ON() for this, and return some value (as
> you do). Zero would do equally well.
> 
> I.e.
> 
> 	return WARN_ON(i >= IMGU_NODE_NUM) ? 0 : i;
> 

I sent basically the same response but somehow my email never went
through...  I'm using mutt with gmail Oauth2 and msmtp and so my
weekly(?) login has expired then something silently eats my outgoing
emails.

In this case the emails that I sent directly before and after went
through so it seems like my login wasn't expired or everything would
have been eaten.

This Oauth2 transition has just been so frustrating.  Am I the only
person having trouble with it?

regards,
dan carpenter

