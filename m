Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FFBB70ECA8
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 06:47:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238988AbjEXErh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 00:47:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238999AbjEXEra (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 00:47:30 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 754031BF
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 21:47:23 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id ffacd0b85a97d-30644c18072so163562f8f.2
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 21:47:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684903642; x=1687495642;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=MF3zjzyqLKusdnLu2cFV58+HdPXe0H0Lh5vvV2VNIwg=;
        b=sln8cXJ8qzy5HVSd8Co9u/U0nEkGx2RLR6GaZEpOVVeeBnqkkP6Z/XI/0Ae95Zktrz
         wzx3Uzt7BGAA+G4jPsza3Dv2I2kM95jeeuQiDfWtlxbHrm+BgYeVNBHbZnMWyzoWOiBf
         VdicnhAkbtrMrmuX34fZTOLGg27Ezp0pfAjzDljs4ulib3rUYgybCNK+xEMKjC9tSsGP
         gVqdXMTdNQ2grXPbupRX/ez8u83eZM66hYy7bflUIrAfC1To4CeQVG1nVihgLFk4HfxL
         nRfddk/qsHtnnfI2YXvhXDZyy1KKsPAOsx+Bv6gktbnZz/gvpComWQO0qHMcDvhL7SxE
         MB7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684903642; x=1687495642;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MF3zjzyqLKusdnLu2cFV58+HdPXe0H0Lh5vvV2VNIwg=;
        b=YCUsw6ev1efY6bZ9RH4Q2hr08MnO+jZhXaWVARPnNIqPYIN1s3dcTS/dx0vsmpriUh
         57G+BMM+wZZY+r5rPMofClgnw1RQE3f5NWA1fevS9TpuRyr8SM2mxzqF7FzyWhBfkT3O
         DhXC8TSpaYaJPyyH5a0gvTDZ68FgLq6l80eJqYRz6ZRCiF+uqvcZiONCeT5ho+NERJcK
         HAQLqNWOepiUYZzY0dXM/Fs9sNV9b5wolGwD+aFNo6BFTm3YC/j1iSy4V7rQCZYojDiF
         OBSoc3ZNT/CLzopl5D3UZPDqC999VyynnFw9j1CDX7ZGXOu/XWxlxC6byfLXZNjTJMcs
         0dfQ==
X-Gm-Message-State: AC+VfDw9rcxMrQd3yL+L1ZmIMJkz6s8l1xwlw1WT+I0a9BFtMB8Whs/+
        xa9MZLUW8lq2ihqREcff0VMMdQ==
X-Google-Smtp-Source: ACHHUZ4eCiAL3KATuxU8f4+GToIRF03ne11cy3xDVyM5Qtn8KrlLw5lsTgOrCzlRlAuxhWACDwueSA==
X-Received: by 2002:adf:e4c5:0:b0:305:e8db:37df with SMTP id v5-20020adfe4c5000000b00305e8db37dfmr11652178wrm.22.1684903641894;
        Tue, 23 May 2023 21:47:21 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id k16-20020a5d5190000000b003078c535277sm12921492wrv.91.2023.05.23.21.47.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 May 2023 21:47:19 -0700 (PDT)
Date:   Wed, 24 May 2023 07:47:15 +0300
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     Su Hui <suhui@nfschina.com>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        YongSu Yoo <yongsuyoo0215@gmail.com>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] media: dvb_ringbuffer: Return -EFAULT if copy fails
Message-ID: <41a9c6a6-4b9a-4d84-9e32-09bf64c65b6c@kili.mountain>
References: <20230524012733.414441-1-suhui@nfschina.com>
 <7af16b9a-09d1-46ff-b9f9-c178173cf940@kili.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7af16b9a-09d1-46ff-b9f9-c178173cf940@kili.mountain>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 24, 2023 at 07:23:45AM +0300, Dan Carpenter wrote:
> On Wed, May 24, 2023 at 09:27:33AM +0800, Su Hui wrote:
> > The copy_to/from_user() functions return the number of bytes remaining
> > to be copied, but we want to return -EFAULT to the user.
> > 

So basically these bugs are caused because people are used to functions
returning negative error codes and they write some form of:

	ret = copy_from_user();
	if (ret)
		return ret;

If you look at the code and you think, "They author thinks 'ret' is
negative" then probably it is a bug.  The common false positives are
in the core kernel where it does:

	return copy_from_user();

and the caller checks:

	if (function_one() || function_two() || function_three())
		return -EFAULT;

Those are done because it's a fast path and adding a lot of if
statements would slow things down.  Driver code tends not to do this
because normally drivers are not so performance sensitive and it's more
important to be readable.

So you have to look at the context a bit.

regards,
dan carpenter

