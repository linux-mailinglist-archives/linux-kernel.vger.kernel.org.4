Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D59A36D6F44
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 23:49:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236461AbjDDVtp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 17:49:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235833AbjDDVto (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 17:49:44 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED3223C06
        for <linux-kernel@vger.kernel.org>; Tue,  4 Apr 2023 14:49:42 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id k37so44189101lfv.0
        for <linux-kernel@vger.kernel.org>; Tue, 04 Apr 2023 14:49:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680644981;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=c9m8JcZMmWZ1S9B7I0X4OWYztsfYf55/KOOKuskJIlc=;
        b=Z4DI99E4RIjphWZMJHkO8FxQhtyyrv0FLzs52XFk/NCyBuzC3aIkbbB18/VZ0bMg+N
         74ywJTvuCPUi6M/CzGnDfV8nLhYpMZXX+4JqujjyExMaaqlqr+hoyPRnRYh34/kPmBPt
         qo7mDyk/bRvemXBO4wox7UZNCGcn5b9B1XMuC2Ho90ezrTaZ5Xq2cRuWJDzPpfVnOuyU
         mNA45YViz2w99XSWPszDS47rphCs9hsHke2IG/t1JHsHrOIHZgGWVZw+iS9YfXR1btIA
         pi0/DSsCWXAqeJaJmNqR+sIe04N3oI/H/pRpnLRtmF4JG/CxxMUGISAeoUgCEgOBWQJJ
         TLBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680644981;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=c9m8JcZMmWZ1S9B7I0X4OWYztsfYf55/KOOKuskJIlc=;
        b=a43KiHq1OYbOpBfiBYAEWQnQhDqqSpe+C8kPix6b6Vxc5v2kxzEigHWD5bVsyYd6OD
         ohAmVY6K5IKL4u+inDP5Mt5uttEfyPpWKuSh/qZruxhZutpQDhgxwEl8pgYWBPE+MK/V
         Ow0BsVF6u7ktV5B7os7Lj5AVCj7kEUejwQtVy7laohTxgWu+pmpyiDwtoniDFJVv2XS8
         NeunUvDEw0esxQFxswgG4YwH0PYUGLrwwsIqvYC8AqLwbdoY4UDCd2EXml1UBCC5Y3WT
         JtI1VaWWvurducuLB5JPSa7IRC4VSBXuqZpkHTb29IjRlwKsYw6cX8FDDgKpho7KzYGg
         F94w==
X-Gm-Message-State: AAQBX9cjwuAGjcVn/+CL51o72pg/rRNjqmaAhUEmUYWhK9bqO6UD+pk7
        LM21ZoFQM6A4QId6Vba7IbFdHA==
X-Google-Smtp-Source: AKy350Zf+ul31Abg44Eo9e+Yy1lnbFlwfl8KiguNoPQHOntwSsbASgV+RlHuOW80PHwf7RqxDqt39g==
X-Received: by 2002:a19:a40c:0:b0:4eb:50ba:cb06 with SMTP id q12-20020a19a40c000000b004eb50bacb06mr291289lfc.49.1680644981217;
        Tue, 04 Apr 2023 14:49:41 -0700 (PDT)
Received: from ?IPV6:2001:14ba:a085:4d00::8a5? (dzccz6yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a085:4d00::8a5])
        by smtp.gmail.com with ESMTPSA id c20-20020a197614000000b004db9dbe09c6sm2501436lff.89.2023.04.04.14.49.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Apr 2023 14:49:40 -0700 (PDT)
Message-ID: <55828eac-32a7-1c6c-25de-2e031ac12f49@linaro.org>
Date:   Wed, 5 Apr 2023 00:49:40 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH] drm/msm/mdp5: set varaiable msm8x76_config
 storage-class-specifier to static
Content-Language: en-GB
To:     Tom Rix <trix@redhat.com>, robdclark@gmail.com,
        quic_abhinavk@quicinc.com, sean@poorly.run, airlied@gmail.com,
        daniel@ffwll.ch, vladimir.lypak@gmail.com
Cc:     linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20230404185329.1925964-1-trix@redhat.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20230404185329.1925964-1-trix@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/04/2023 21:53, Tom Rix wrote:
> smatch reports
> drivers/gpu/drm/msm/disp/mdp5/mdp5_cfg.c:658:26: warning: symbol
>    'msm8x76_config' was not declared. Should it be static?
> 
> This variable is only used in one file so should be static.
> 
> Signed-off-by: Tom Rix <trix@redhat.com>
> ---
>   drivers/gpu/drm/msm/disp/mdp5/mdp5_cfg.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry

