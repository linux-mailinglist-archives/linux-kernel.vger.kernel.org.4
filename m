Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 787346640C1
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 13:45:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233276AbjAJMo3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 07:44:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238249AbjAJMoK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 07:44:10 -0500
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD3844FCDD
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 04:44:09 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id k22-20020a05600c1c9600b003d1ee3a6289so9796828wms.2
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 04:44:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:references:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cO7o6zy9XbYcdv1KxtYdYV7GfWo9hu8NVg99Zup2H9k=;
        b=Cc8RYrCqPQ4c95px4RkdI6rs5reesi/TMAVQ218tvGHEb3pId+EqOHCSSSSsnBGWis
         MK0N1gzx1+sX9EgzsaY1iGgUmUpyEmCYxHJ5FUrR7DvXUznIT+xby0ei30EZ3laua0mu
         C6Pm/PfMsSn/PfGthjDHczsoLvHo1pmjaOIFeoOrb1YKJlJAi0gplcwKHaRdk/+Bm5LY
         i0nDFADAHKbSrSXLPCy7D+amF8e+Si55GhmS/6Rep7xWZ65IF6GuEO87Sa+XcPxlDHzk
         UlXxfs5urTUZRfBKQXytgNIiNJAG77e7suskerqeiXBxNPQ5y6ZnQn5xA4XBcZTcWA6E
         6NiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cO7o6zy9XbYcdv1KxtYdYV7GfWo9hu8NVg99Zup2H9k=;
        b=f0v6GdGm/cVmAfHuZLnMMQX8SrQvUcT0y30gZAHlorrW/o3tZgEdl6AjaZfOPgSVVW
         YqT15F1yEvIvHs/Yr04MfP10apo8LGFCtw5aSz4wlmvxphnCtzU3UWvfjKHD8YkMnT0M
         ysUv7AZs+5gwG6N/Iv9X8z+wIPNqJRpFa2aRdh9n3dhlhXCp2P4Q8/PyMEElLA4M39ed
         g1+FHS5MdOcU7PwpHPWA4uKeHxtPx1km7dffc/IjyeqBrHWTsyfAE8bCViXLPJ+sF5Xq
         cNHndXaXZNMzHRU9XGPPkajAEiZ0qcxpcCCdHcNQPA00x/Ht6of9dl9rQgZwPbmaisM2
         0evQ==
X-Gm-Message-State: AFqh2kriGspEk5eNIbLrLhKUurhDjN5FPsLZk9fI28uSZe/X/H8PMOw+
        /RApcDenG5+ts6SX/7CthxoC2nNHYeGvKf1gqU0=
X-Google-Smtp-Source: AMrXdXvQvCteRkPCbsD3dIE2ainnx19Y/LNT4VaAtHHS8WmURwc++TV3QsBXKWjBloWEac9pUIW8LA==
X-Received: by 2002:a05:600c:1d89:b0:3d3:5cd6:781 with SMTP id p9-20020a05600c1d8900b003d35cd60781mr48576618wms.37.1673354648289;
        Tue, 10 Jan 2023 04:44:08 -0800 (PST)
Received: from [192.168.0.162] (188-141-3-169.dynamic.upc.ie. [188.141.3.169])
        by smtp.gmail.com with ESMTPSA id m17-20020a05600c3b1100b003cfbbd54178sm1899192wms.2.2023.01.10.04.44.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Jan 2023 04:44:07 -0800 (PST)
Message-ID: <06f76774-1b2e-f563-7128-7d5b9547dfe9@linaro.org>
Date:   Tue, 10 Jan 2023 12:44:07 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: ieee80211_handle_wake_tx_queue and dynamic ps regression
Content-Language: en-US
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
To:     linux-kernel@vger.kernel.org, alexander@wetzel-home.de,
        johannes.berg@intel.com, Kalle Valo <kvalo@codeaurora.org>,
        linux-wireless@vger.kernel.org
References: <19015168-c747-17b7-f0ae-9d2ee27d221c@linaro.org>
In-Reply-To: <19015168-c747-17b7-f0ae-9d2ee27d221c@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+ linux-wireless
On 10/01/2023 12:35, Bryan O'Donoghue wrote:
> commit a790cc3a4fad75048295571a350b95b87e022a5a 
> (wake_tx_queue-broken-23-08-01)
> Author: Alexander Wetzel <alexander@wetzel-home.de>
> Date:   Sun Oct 9 18:30:39 2022 +0200
> 
>      wifi: mac80211: add wake_tx_queue callback to drivers
> 
> is causing a regression with
> 
> - CONF_PS = 1
> - CONF_DYNAMIC_PS = 0
> - ieee80211_handle_wake_tx_queue
> 
> In this case we get stuck in a loop similar to this
> 
> // IEEE80211_CONF_CHANGE_PS
> [   17.255480] wcn36xx: wcn36xx_change_ps/312 enable
> [   18.088835] ieee80211_tx_h_dynamic_ps/263 setting 
> IEEE80211_QUEUE_STOP_REASON_PS
> [   18.088906] ieee80211_handle_wake_tx_queue/334 entry
> [   18.091505] ieee80211_dynamic_ps_disable_work/2250 calling 
> ieee80211_hw_config()
> [   18.095370] ieee80211_handle_wake_tx_queue/338 wake_tx_push_queue
> 
> // IEEE80211_CONF_CHANGE_PS
> [   18.102625] wcn36xx: wcn36xx_change_ps/312 disable
> [   18.107643] wake_tx_push_queue/303 entry
> 
> // txq is stopped here reason == IEEE80211_QUEUE_STOP_REASON_PS
> [   18.107654] wake_tx_push_queue/311 q_stopped bitmask 0x00000002 
> IEEE80211_QUEUE_STOP_REASON_PS true
> [   18.107661] wake_tx_push_queue/324 exit
> [   18.107667] ieee80211_handle_wake_tx_queue/342 exit
> [   18.115560] ieee80211_handle_wake_tx_queue/334 entry
> [   18.139937] ieee80211_handle_wake_tx_queue/338 wake_tx_push_queue
> [   18.145163] wake_tx_push_queue/303 entry
> [   18.150016] ieee80211_dynamic_ps_disable_work/2252 completed 
> ieee80211_hw_config()
> 
> // now we unset IEEE80211_QUEUE_STOP_REASON_PS but too late
> [   18.151145] wake_tx_push_queue/311 q_stopped bitmask 0x00000002 
> IEEE80211_QUEUE_STOP_REASON_PS true
> [   18.155263] ieee80211_dynamic_ps_disable_work/2254 clearing 
> IEEE80211_QUEUE_STOP_REASON_PS
> [   18.162531] wake_tx_push_queue/324 exit
> [   18.162548] ieee80211_handle_wake_tx_queue/342 exit
> [   18.183639] ieee80211_dynamic_ps_disable_work/2259 cleared 
> IEEE80211_QUEUE_STOP_REASON_PS
> 
> // IEEE80211_CONF_CHANGE_PS runs again
> [   18.215487] wcn36xx: wcn36xx_change_ps/312 enable
> 
> We get stuck in that loop. Packets getting transmitted is a rare event, 
> most are dropped.
> 
> I tried this as a fix
> 
> --- a/net/mac80211/mlme.c
> +++ b/net/mac80211/mlme.c
> @@ -2245,15 +2245,15 @@ void ieee80211_dynamic_ps_disable_work(struct 
> work_struct *work)
>                  container_of(work, struct ieee80211_local,
>                               dynamic_ps_disable_work);
> 
> -       if (local->hw.conf.flags & IEEE80211_CONF_PS) {
> -               local->hw.conf.flags &= ~IEEE80211_CONF_PS;
> -               ieee80211_hw_config(local, IEEE80211_CONF_CHANGE_PS);
> -       }
> -
>          ieee80211_wake_queues_by_reason(&local->hw,
>                                          IEEE80211_MAX_QUEUE_MAP,
>                                          IEEE80211_QUEUE_STOP_REASON_PS,
>                                          false);
> +
> +       if (local->hw.conf.flags & IEEE80211_CONF_PS) {
> +               local->hw.conf.flags &= ~IEEE80211_CONF_PS;
> +               ieee80211_hw_config(local, IEEE80211_CONF_CHANGE_PS);
> +       }
>   }
> 
> but it only "slightly improves" the situation, the fundamental race 
> condition is still there.
> 
> Suggest reverting this change and trying again.
> 
> ---
> bod

