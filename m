Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F2B9702624
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 09:36:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237999AbjEOHgI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 03:36:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232916AbjEOHgG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 03:36:06 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3A5410DC
        for <linux-kernel@vger.kernel.org>; Mon, 15 May 2023 00:36:04 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id 5b1f17b1804b1-3f42769a0c1so80037315e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 15 May 2023 00:36:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684136163; x=1686728163;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ogyt3w7itUo+rHlMTlZBSSla7TInVf3CNLCbZty+gyk=;
        b=jvPjK4/5XlZn+OlOsyK1ZW5x0wykse+Hn2H/3MMPXoIG0AiCiyty5Bn7a5llfJgm+C
         7DwCSu5k+v9gug88dOqEeYOQKIIMpC0YkHIG6doLmKR8HIvNFiPOo1qXLGh0AzCHpNlF
         ubyPVRgO4aBDcnJAHFMDFbK4uFf3VVysg8cB4yg9ATJoT16Em6+UN794WKwxvDGqwU02
         fX5Rz5F1rIpX0UTf5CHKIfobGv3xBK93rqgrJB4Oz1EHxav5z3uBf2zWu6gY0J79BB5y
         tipFCjOFrMMhgwoUw4YyGUvqmhAGPCljM9HaBkqI1BDBF3VO3kUMtSNMuqOWIYjZeO2K
         EPMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684136163; x=1686728163;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ogyt3w7itUo+rHlMTlZBSSla7TInVf3CNLCbZty+gyk=;
        b=JfCW51OJxoAhKIYUOACvP1A2/Qm814z+XFRClUp74jBKAidqpevYGWOi6dNwS/t6Rr
         2RovTvJ6sq8MamyhepTOc3DH54TWYHNn7Ow6c92tzbc66TMm58IZj52loLPLIIx5+ECX
         IZUr6D4aZp/Owyzd5NlI/ewExsgl1XmjMpxmOCJqYUXN2vwry4oWFpelguEMVFwlyhQI
         Ye5t7SVByYgy+0q1IxUz2ez5TtCQY2+acS4Mkcfr97lUtsZ8A8bjoC97WJO57JSr31gg
         4ejsf4ygqmUzChCifn32oV6jVy+WL+/YMcmBOuuv0kKeZ/kH3asox5br6yHUyAC+FzX1
         rmhw==
X-Gm-Message-State: AC+VfDw7pkZQ/CPpr9/Z/EEjMMEb823YC3z3Sr55D+18XOIWSHknF46Z
        jfT5VldxfXk/+omUvZRIAncnXQ==
X-Google-Smtp-Source: ACHHUZ6v7H49onNtAu54KlMySdOPBK1eVP5sZkV6+UtBfjPI+Pqap2JYiybcZpMjEHXD4BVxgaL3qg==
X-Received: by 2002:adf:e448:0:b0:307:cb94:972f with SMTP id t8-20020adfe448000000b00307cb94972fmr11013717wrm.46.1684136163224;
        Mon, 15 May 2023 00:36:03 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id r10-20020a056000014a00b00307972e46fasm23275962wrx.107.2023.05.15.00.36.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 May 2023 00:36:01 -0700 (PDT)
Date:   Mon, 15 May 2023 10:35:58 +0300
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     Su Hui <suhui@nfschina.com>
Cc:     Jan Harkes <jaharkes@cs.cmu.edu>, coda@cs.cmu.edu,
        codalist@coda.cs.cmu.edu, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] coda: return -EFAULT if copy fails
Message-ID: <3e92c08d-9c0d-4fcd-bf15-0fbcac3be26a@kili.mountain>
References: <20230515061923.767680-1-suhui@nfschina.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230515061923.767680-1-suhui@nfschina.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 15, 2023 at 02:19:23PM +0800, Su Hui wrote:
> The copy_to/from_user() functions should return -EFAULT instead of -EINVAL.
> 
> Signed-off-by: Su Hui <suhui@nfschina.com>
> ---

Could you add a Fixes tag?

regards,
dan carpenter

