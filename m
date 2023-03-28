Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B90B56CB866
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 09:42:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231561AbjC1Hmv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 03:42:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230245AbjC1Hms (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 03:42:48 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 760D5211E;
        Tue, 28 Mar 2023 00:42:47 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id h17so11106449wrt.8;
        Tue, 28 Mar 2023 00:42:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679989366;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=reWFyQdHA0Txjoyw/asL10WD0B3MGC9C1OYGnj8cjLU=;
        b=WCqPg7kj6QzLXEOVdoQ1xMWD4fQdgnzUfP73CB10wcAeR2+Rvyv6nLGcAmRfEqAPBN
         uxsVum3wm7djw1PR/wmloQ3SbizDsX/f0KKbyGVdMrIp1eRklDFd+0mUKYHzhJWdy3Ok
         hoK4vhXeeWa7NGRBpfPq9ZeaL9R9E2inGfpoDAD+bZT41NplWgWq2QHxWZWGRX5Pb21M
         yjGyPJV7+LorCR4Qv1Ro9oWOXMjVTMoyQR2HW502gC1l5q/gCpND23aQMEfoLZezPoYG
         NkrPghb3zVtL3KeYo3roJmiQrOEArrxbSVIX7vN/EG+zdE89GSbv5TpVUBTU3imGpeUE
         Ak9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679989366;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=reWFyQdHA0Txjoyw/asL10WD0B3MGC9C1OYGnj8cjLU=;
        b=6vBuMTD4356E+7PmwjUMfsARk6IgxHYBeNYGoaFFM/TVbZa4tMJ0HW1I8sEqKz/5T/
         JAMAl9ArUsi1OfdDYi2UiygTCa7kSM/fTVUOFiSO/PLG+QJT0iJm5j3nlVfgpv81ZqpZ
         GvjB06JFS1kXEuQsORz5HHv+H95YUo9rwsnSKGZtpWTzmDYf8ik8Z9E2luRmEhI7vbG0
         DhqjvMLmqms5Vgg/WonXBOhuOu7hf6j8sopK8R3wSKLtYngj4JVky1eoL4oWQpLVeJWq
         fZ8KphZzSebmJVv0C4i9b+mAmNLNRIaREP9qYvMZlpo9GOgmihyBu/PDYPHHmm66xVpG
         noSQ==
X-Gm-Message-State: AAQBX9dI+39gOkdhqNIFKJE6mX8jZ2jBrpAqkOZsZBu+arobzWSf+8Qn
        fjVhxJFrOZ2CT9BQz1HTczc=
X-Google-Smtp-Source: AKy350ae8pPppl5m9E/fAgObS0u170HobthBF6NK9Qjbn7LyCnoBrzLmAj4S8NpGj1TURzpOwmkCFg==
X-Received: by 2002:a5d:5691:0:b0:2d7:d4b:b33 with SMTP id f17-20020a5d5691000000b002d70d4b0b33mr12209300wrv.21.1679989365793;
        Tue, 28 Mar 2023 00:42:45 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id v7-20020a5d4b07000000b002c56af32e8csm26731234wrq.35.2023.03.28.00.42.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Mar 2023 00:42:45 -0700 (PDT)
Date:   Tue, 28 Mar 2023 10:42:42 +0300
From:   Dan Carpenter <error27@gmail.com>
To:     Yu Zhe <yuzhe@nfschina.com>
Cc:     andersson@kernel.org, mathieu.poirier@linaro.org,
        matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com,
        agross@kernel.org, konrad.dybcio@linaro.org,
        mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com,
        linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-arm-msm@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        kernel-janitors@vger.kernel.org, liqiong@nfschina.com
Subject: Re: [PATCH v4] remoteproc: remove unnecessary (void*) conversions
Message-ID: <fdcfe2ae-fa49-4758-8b5c-b853cc6a0b80@kili.mountain>
References: <20230328015749.1608-1-yuzhe@nfschina.com>
 <20230328024907.29791-1-yuzhe@nfschina.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230328024907.29791-1-yuzhe@nfschina.com>
X-Spam-Status: No, score=0.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 28, 2023 at 10:49:07AM +0800, Yu Zhe wrote:
> Pointer variables of void * type do not require type cast.
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Link: https://lore.kernel.org/oe-kbuild-all/202303272213.jOYrwBZu-lkp@intel.com/
> Signed-off-by: Yu Zhe <yuzhe@nfschina.com>
> ---
> 
> v3->v4:
>  Drop wrong modifies

Seems okay.  (I haven't tried compiling it or anything).

regards,
dan carpenter

