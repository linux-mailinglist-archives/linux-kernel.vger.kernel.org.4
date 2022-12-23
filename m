Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F5626552B9
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Dec 2022 17:22:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231922AbiLWQWK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Dec 2022 11:22:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231338AbiLWQV5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Dec 2022 11:21:57 -0500
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB1522BDB
        for <linux-kernel@vger.kernel.org>; Fri, 23 Dec 2022 08:21:54 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id fm16-20020a05600c0c1000b003d96fb976efso1270082wmb.3
        for <linux-kernel@vger.kernel.org>; Fri, 23 Dec 2022 08:21:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=hI2AAVr0GajMn6R38dDdetCgvikhxBGvAxzi6T7wg0k=;
        b=dKMhvPsIEPUzoTnSdzSjitUM9MyhEDdt1DRMWa6rATPUveG38LwbqZbzfbilPnfYAS
         QB3uHYH7tC3JTz2ZkWc0V9Idq8vxuz0FYSCybrP91h/UZzUL2mg5Jr557+PsdoS7VqzX
         XitIerrhDf4YB8JIeW2oySG+bQ3uXAnO7hFwHIB5NNxSa9RrtcHxUnpMmtz8966m60fg
         TE0J3FXayCITuJRn6pYEjzxyvaNi95AZCqs7SLiuooH4TuMvzy/fogS3YgYe7oN8GqMr
         PY9aGsK1ITqcFQy+s81WvDiN119e7t6DV10U2HJIQnH1Tf08FJwQchAI0gfLnlJfeVH3
         pqew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hI2AAVr0GajMn6R38dDdetCgvikhxBGvAxzi6T7wg0k=;
        b=us5ah6rfWfdye5EIsObowHbQT5uHhyWo+d9tkYF2CQHr6hmKJbqNMRn0wYFa2F4ess
         bcPCoDkfeQoBA3lzShLvcQu8N/xJZP1s2blpn15nQk5epVBqKNFJS2lvY53dpNR2xHLb
         S1lWDxMrZNRtY/iKRx2NRzOcNihYgkecY/+ki2Qx74yBLnUviv1f36d6Hw/GEHabxFAK
         CwiWUgLcS2Xf7IFKZv7drmXnwFFlKbrgyg0W/9SEzwtZC/Ft//dJhsxvH//itLMIl93B
         Rt+0getXyQDwNVt6VxdP9fn8J+18mg/gTcmRT6rqMNaK7Qq8nVc8QADMt618pEsz9pdA
         vWaQ==
X-Gm-Message-State: AFqh2krE+2WPQKa8dkHaxFYzBu3Mdug25QwVGwvGtoQ/kqKeJ6jyEeXx
        BtukBtXZjkw2is2eiocJp5YkQHpzpdgAA4gV
X-Google-Smtp-Source: AMrXdXvcv7aKaagigLS48DwM5czqYbY//VUKgxMMwbvv/+ONNDRe6/3C7KVWfc17NL49kXOVZ0OtZg==
X-Received: by 2002:a1c:19c4:0:b0:3d1:ebdf:d592 with SMTP id 187-20020a1c19c4000000b003d1ebdfd592mr7529261wmz.22.1671812513280;
        Fri, 23 Dec 2022 08:21:53 -0800 (PST)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id w20-20020a1cf614000000b003cf4d99fd2asm4895248wmc.6.2022.12.23.08.21.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Dec 2022 08:21:52 -0800 (PST)
Date:   Fri, 23 Dec 2022 19:21:49 +0300
From:   Dan Carpenter <error27@gmail.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     oe-kbuild@lists.linux.dev, Sagi Grimberg <sagi@grimberg.me>,
        lkp@intel.com, oe-kbuild-all@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: drivers/nvme/host/auth.c:950 nvme_auth_init_ctrl() warn: missing
 error code? 'ret'
Message-ID: <Y6XVnWCNx6cB7Itw@kadam>
References: <202212222333.vrYfUBqM-lkp@intel.com>
 <20221223154754.GA30339@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221223154754.GA30339@lst.de>
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 23, 2022 at 04:47:54PM +0100, Christoph Hellwig wrote:
> diff --git a/drivers/nvme/host/auth.c b/drivers/nvme/host/auth.c
> index bb0abbe4491cdc..c808652966a94f 100644
> --- a/drivers/nvme/host/auth.c
> +++ b/drivers/nvme/host/auth.c
> @@ -943,16 +943,19 @@ int nvme_auth_init_ctrl(struct nvme_ctrl *ctrl)
>  	INIT_WORK(&ctrl->dhchap_auth_work, nvme_ctrl_auth_work);
>  	if (!ctrl->opts)
>  		return 0;
> -	ret = nvme_auth_generate_key(ctrl->opts->dhchap_secret,
> -			&ctrl->host_key);
> -	if (ret)
> -		return ret;
> -	ret = nvme_auth_generate_key(ctrl->opts->dhchap_ctrl_secret,
> -			&ctrl->ctrl_key);
> -	if (ret)
> +
> +	ctrl->host_key = nvme_auth_generate_key(ctrl->opts->dhchap_secret);
> +	if (IS_ERR(ctrl->host_key)) {
> +		ret = PTR_ERR(ctrl->host_key);
> +		goto out;
> +	}
> +	ctrl->ctrl_key = nvme_auth_generate_key(ctrl->opts->dhchap_ctrl_secret);
> +	if (IS_ERR(ctrl->ctrl_key)) {
> +		ret = PTR_ERR(ctrl->ctrl_key);
>  		goto err_free_dhchap_secret;
> +	}
>  
> -	if (!ctrl->opts->dhchap_secret && !ctrl->opts->dhchap_ctrl_secret)
> +	if (!ctrl->host_key && !ctrl->ctrl_key)
>  		return ret;

ret is uninitialized now.

regards,
dan carpenter

