Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDD9E6CB85A
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 09:40:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230245AbjC1HkO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 03:40:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230200AbjC1HkL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 03:40:11 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4926E211E;
        Tue, 28 Mar 2023 00:40:10 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id q19so8044016wrc.5;
        Tue, 28 Mar 2023 00:40:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679989209;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=qYSKi6P9F33q3cGk3dc2X+3QTPP68ecCLe041fZqdtM=;
        b=HbSxQr4r8Zf3+yFQGbqcSxzOtKd8vj2cIF9+ve9dHjUlZoMwR8DYHXDG3+N4uRe0Vd
         y0tyA33+FCOrO1XVTYqLMCQaVei6b+K0kcXheOPsVWLV4HEKyUxEQf1Z835o14j9bacp
         ghe9VyKKvUiP1a7uUEtkJuyjM+AOUdFwrLJWU7Q3Au0XD5DV4t0QUX5irMgq4g1YTI75
         5fGfeDGJnMAmrLjC4zaBRLAACxa02wIPHGF48zub+woOFOA0kqTGgHJq1xBs+FeNbLW7
         h5cPb4t6yvBDTFgqAtUzrgUlRqccvDftKeSJUDmZZTvjxIVqSo3FDfDz142jvg4L4KaV
         AbLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679989209;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qYSKi6P9F33q3cGk3dc2X+3QTPP68ecCLe041fZqdtM=;
        b=A+aLHzm1g+sLGbiKLQQbNRarL1hntq8wvtmW/42MCROUSSLQZ6onSNcXwnQBRc6rBP
         GIQFkb1gb2Rt5FvRTywrFZPe7fyg3vUhN6GKnmVfRsLqgSt8tqEUEs25Oc8nEh53t4Rf
         pYgZGCJjp7dhS56DXMSCldZFqFrDgsF/rUC1oL+Xi2YwRfb1opEVZKuAVSZEew8C3gW2
         xVdf7kqUm5KVQYxEyA6qlrsRu72Od2ACZ9voEiRZvFnn5kIkYuJmx7+Hgo4S5SMwxrVI
         p9kIDfGkT1YGgkXYXTGFZyDFOzZ7bRvsUEEniAZrO2csT47P7/UMtOlR4rcOBD0Ahu4a
         VTrA==
X-Gm-Message-State: AAQBX9f50/P6OcVMFABVQLhU/E0Fl4rN7CEME4IYcbSF+xSx7pVXpyHP
        CUhky8tWwPU1WAYt/k5KazUT7plQS+tCPA==
X-Google-Smtp-Source: AKy350ZblYUnLPCJxBsWxVjLmOt7Surp3uSMJdu3VZiB82QN73WYQMcps/WK/CciM1DKpYZAGC5tMA==
X-Received: by 2002:adf:fe45:0:b0:2c7:d7c:7d7 with SMTP id m5-20020adffe45000000b002c70d7c07d7mr11055389wrs.22.1679989208657;
        Tue, 28 Mar 2023 00:40:08 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id k6-20020a5d6d46000000b002c5598c14acsm27215726wri.6.2023.03.28.00.40.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Mar 2023 00:40:08 -0700 (PDT)
Date:   Tue, 28 Mar 2023 10:40:04 +0300
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
Subject: Re: [PATCH v3] remoteproc: remove unnecessary (void*) conversions
Message-ID: <4b64c2ed-b3a3-46fc-b5c7-3c03b30cd8a2@kili.mountain>
References: <20230320061157.29660-1-yuzhe@nfschina.com>
 <20230328015749.1608-1-yuzhe@nfschina.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230328015749.1608-1-yuzhe@nfschina.com>
X-Spam-Status: No, score=0.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 28, 2023 at 09:57:49AM +0800, Yu Zhe wrote:
>  static void devm_rproc_free(struct device *dev, void *res)
>  {
> -	rproc_free(*(struct rproc **)res);
> +	rproc_free(res);

This introduces a bug.

regards,
dan carpenter

