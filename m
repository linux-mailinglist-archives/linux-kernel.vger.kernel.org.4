Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8BB07071A2
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 21:12:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229954AbjEQTMa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 15:12:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229951AbjEQTM1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 15:12:27 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D81CA255
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 12:12:13 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id d9443c01a7336-1ae52ce3250so10175235ad.2
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 12:12:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1684350732; x=1686942732;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2TweVo7pe1RT0U4fJi1MmEd78Di3WvMfNoLR23I7nbs=;
        b=lbYAiBBRmL5JG7kvR3ch5RRhu+skJcHwpvcGTQun5EtQJEpcQC3jTxCTGQOM3dVW8X
         CrEjomYR2sZtOYw2xbyl9tOqhSYF/zT86dd11oD3tjkwXgF0T+QbRmX+4Bqihn7a/Yqh
         gkQW0IJ+k9LTKm7tT9O4BR/ogticSCt2HQ3+c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684350732; x=1686942732;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2TweVo7pe1RT0U4fJi1MmEd78Di3WvMfNoLR23I7nbs=;
        b=TJnpjGBYjjHmbA0EUYQZUFNZg7RzvzKAPA1BNwYMzWPhyp6QTGLDQGi4UXBDnCYfj1
         8AK03iaf7yQWqVIt2IqlPwCbORGSBrrFFiLjkuqy0uJIDT5EvGMnq7yOp8hC8Hao8qXL
         8VrrGMfRANA9Tv4FcEeQA1aFdxt4U1xJxIPnA2VRc4beP23s7RhrlAyKmFZK7PGNTG+m
         KRjaNM4MJJf7GIkt4WNaABaSIsTpNmgtKSZcJAL+gCIQcBrvtlHeDPkMZp/PhSdfHF3R
         l9axOWr/Nop//u2T+7iIqfgO71vhGVP51Nq8UrjRntSNbk/FLa+mXhlxYPl7ERLoR+dr
         lMew==
X-Gm-Message-State: AC+VfDyrShSE3+w7AI4J0/p6gPAA/l8xm3cx82+UwqFxnLsBcNWu/QFs
        i48gx4Y72AAicvxq/m4LYbl1gg==
X-Google-Smtp-Source: ACHHUZ7YR5PTferdj6NHTPRa9xPJnCLNgUmoVpZYWgZwyj3/ZkalIoXAhIaQ+cJHTVYO73t+U3vEJg==
X-Received: by 2002:a17:902:9a46:b0:1ae:5f7e:c117 with SMTP id x6-20020a1709029a4600b001ae5f7ec117mr1313241plv.60.1684350732651;
        Wed, 17 May 2023 12:12:12 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id x21-20020a17090300d500b001a687c505e6sm18019526plc.232.2023.05.17.12.12.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 May 2023 12:12:12 -0700 (PDT)
Date:   Wed, 17 May 2023 12:12:11 -0700
From:   Kees Cook <keescook@chromium.org>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     Stanimir Varbanov <stanimir.k.varbanov@gmail.com>,
        Vikash Garodia <quic_vgarodia@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH 2/2][next] media: venus: hfi_cmds: Use struct_size()
 helper
Message-ID: <202305171212.11465CFF3@keescook>
References: <cover.1684278538.git.gustavoars@kernel.org>
 <fd52d6ddce285474615e4bd96931ab12a0da8199.1684278538.git.gustavoars@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fd52d6ddce285474615e4bd96931ab12a0da8199.1684278538.git.gustavoars@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 16, 2023 at 05:14:49PM -0600, Gustavo A. R. Silva wrote:
> Prefer struct_size() over open-coded versions of idiom:
> 
> sizeof(struct-with-flex-array) + sizeof(typeof-flex-array-elements) * count
> 
> where count is the max number of items the flexible array is supposed to
> contain.
> 
> Link: https://github.com/KSPP/linux/issues/160
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
