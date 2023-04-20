Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C9A96E9BD3
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 20:41:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231667AbjDTSl0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Apr 2023 14:41:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230500AbjDTSlY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Apr 2023 14:41:24 -0400
Received: from mail-oa1-x35.google.com (mail-oa1-x35.google.com [IPv6:2001:4860:4864:20::35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6C4A109
        for <linux-kernel@vger.kernel.org>; Thu, 20 Apr 2023 11:41:23 -0700 (PDT)
Received: by mail-oa1-x35.google.com with SMTP id 586e51a60fabf-1879e28ab04so935273fac.2
        for <linux-kernel@vger.kernel.org>; Thu, 20 Apr 2023 11:41:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20221208.gappssmtp.com; s=20221208; t=1682016083; x=1684608083;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mJOW7tdNgKJptT0vz8GVP6fpHJhg0ViOZfphMyrTOKs=;
        b=iUb5SJbjn0lEofl87QYBQKeE8RTSeu4ViyKSzkGEF5P33PiclxgC5jTMRzMirA3Sww
         Vr6zOtvSetClEs2xIERLER7OQizuWzZ2wyjVDhaQGo0YsCxLUHTtyl8f4TrreE7OxCxR
         taXbS00VtICuKw1ntGs24xieuQex922fi9pv44b0XiowMIqjao7z2a7kBLCXcZ10udIR
         /GuTsOfe1XlpVvXaOHXGsELxfbVjYEYDVjXLx3Rcm6sIedsf4XaNirju0kivZIiT3bMw
         KSEDPPL+z6OXjwIx/DOX+ynZa5Qil0/ljy1M+oeaaeC2ENq2gWqLs8RTG48vpqBvXeoT
         T3dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682016083; x=1684608083;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mJOW7tdNgKJptT0vz8GVP6fpHJhg0ViOZfphMyrTOKs=;
        b=Pb3h9i/KFWbecbbmvL+TDKZVsOlMxDbfNC0jwglacjTBFGopyHZ/4ZeTfonjjVAAt/
         l4Qc8xVOf14Di3trEVEXAiW2aoyPfHgV0kCcsT97Nk0YDVgtKjLzSNd/O9KOQONxTtWq
         5OFYTBHnA7ntaWdMY+Xas8oKI+qW5Rbc3UIdGWxKokV44iYhmJ8thPMJHanezLwrN4tE
         hdLzvvWa57P1HaFB8+8Ljy15i0c6k+q/jirfhyEKkSmfxS8+wWSyERNswT0afGBDO44R
         otS4EqPWtKwQg3v8Nc6voGpioaO2+J0/2WPpbRuspL7Sxplf+V1+gut+Bbh5+BQ0bmVg
         9BOA==
X-Gm-Message-State: AAQBX9cmdSDkq7h1uh83tRG3vawLTZRRtRSvEpOHPFeUTdywdFNzXGua
        9Oi5OZD4GseD2VVF3sgN2bXhwA==
X-Google-Smtp-Source: AKy350a2WzpIB21aXY995ufG+7K0Ate5m83Ms3Vg2JDfzF9uIDNes3caJq/+cV1JM9iieyh1Mfqsdw==
X-Received: by 2002:a05:6808:1407:b0:38d:e632:82fe with SMTP id w7-20020a056808140700b0038de63282femr1418396oiv.9.1682016082910;
        Thu, 20 Apr 2023 11:41:22 -0700 (PDT)
Received: from ?IPV6:2804:14d:5c5e:44fb:7668:3bb3:e9e3:6d75? ([2804:14d:5c5e:44fb:7668:3bb3:e9e3:6d75])
        by smtp.gmail.com with ESMTPSA id j11-20020a4a888b000000b00524fe20aee5sm901348ooa.34.2023.04.20.11.41.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Apr 2023 11:41:22 -0700 (PDT)
Message-ID: <803f6502-76dc-d6e6-1bb2-5632de12e5ee@mojatatu.com>
Date:   Thu, 20 Apr 2023 15:41:17 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH net v2] net/sched: cls_api: Initialize miss_cookie_node
 when action miss is not used
Content-Language: en-US
To:     Ivan Vecera <ivecera@redhat.com>, netdev@vger.kernel.org
Cc:     Jamal Hadi Salim <jhs@mojatatu.com>,
        Cong Wang <xiyou.wangcong@gmail.com>,
        Jiri Pirko <jiri@resnulli.us>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Simon Horman <simon.horman@corigine.com>,
        Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
        open list <linux-kernel@vger.kernel.org>
References: <20230420183634.1139391-1-ivecera@redhat.com>
From:   Pedro Tammela <pctammela@mojatatu.com>
In-Reply-To: <20230420183634.1139391-1-ivecera@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/04/2023 15:36, Ivan Vecera wrote:
> Function tcf_exts_init_ex() sets exts->miss_cookie_node ptr only
> when use_action_miss is true so it assumes in other case that
> the field is set to NULL by the caller. If not then the field
> contains garbage and subsequent tcf_exts_destroy() call results
> in a crash.
> Ensure that the field .miss_cookie_node pointer is NULL when
> use_action_miss parameter is false to avoid this potential scenario.
> 
> Fixes: 80cd22c35c90 ("net/sched: cls_api: Support hardware miss to tc action")
> Signed-off-by: Ivan Vecera <ivecera@redhat.com>
> ---
>   net/sched/cls_api.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/net/sched/cls_api.c b/net/sched/cls_api.c
> index 35785a36c80298..3c3629c9e7b65c 100644
> --- a/net/sched/cls_api.c
> +++ b/net/sched/cls_api.c
> @@ -3211,6 +3211,7 @@ int tcf_exts_init_ex(struct tcf_exts *exts, struct net *net, int action,
>   #ifdef CONFIG_NET_CLS_ACT
>   	exts->type = 0;
>   	exts->nr_actions = 0;
> +	exts->miss_cookie_node = NULL;
>   	/* Note: we do not own yet a reference on net.
>   	 * This reference might be taken later from tcf_exts_get_net().
>   	 */

Reviewed-by: Pedro Tammela <pctammela@mojatatu.com>
