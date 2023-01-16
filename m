Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AF0B66BB3A
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Jan 2023 11:08:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229865AbjAPKH7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Jan 2023 05:07:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230013AbjAPKH1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jan 2023 05:07:27 -0500
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 049601BAC7
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jan 2023 02:07:09 -0800 (PST)
Received: by mail-ej1-f41.google.com with SMTP id bk15so9359984ejb.9
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jan 2023 02:07:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZTCz+isani3C/5J+9yJj7obK7LQvYU7O69T/Y+9F+F8=;
        b=wdH/2nWMIOS0GwywLIT+2RHNtg5X933hpQFSNtAOgEudTESnr55wpLFmkujYRGBNME
         lSqo86Kdg3hsvhYgE3fjGYcw7qEj6gOZBzXkXYOcuss+1XnZLrmBSCYIrPGJ1+7N12qp
         H0lazrQfSd4O+r7Vur9BE2Js6l3rnJDEI6Tp2Snzd3tLNgo2RJl/d6HGGsU0AslA1QVH
         3ZmRu5EE+NuJri30RwmYpUaWhdrQuUakaa4H7rZxiJHod1hU+8is94WOOCHm+25XnjgQ
         s+bGGu/geUUQOXQNf4lmVEWWldA+SUiA4g6A1Wa6OTX/g2J74AsE5GX+PDaXi4ZI+mXl
         i3ig==
X-Gm-Message-State: AFqh2krLvGIf2bUxPwNEvDpjB8YrQYY5Izwe30yKAtz1QakcUtkO+7UL
        DzfKxkNJtkJLfI3RvDtk4FRcFXUut/E=
X-Google-Smtp-Source: AMrXdXsoGN1R8oF/zMup0p81IbrEwnhugbv+jd1MwxDTPJ4pXgmiBMp0RTVnBqgFsTVGo8lCZygipg==
X-Received: by 2002:a17:906:5786:b0:78d:f455:3105 with SMTP id k6-20020a170906578600b0078df4553105mr72739023ejq.45.1673863627486;
        Mon, 16 Jan 2023 02:07:07 -0800 (PST)
Received: from [192.168.1.49] (185-219-167-24-static.vivo.cz. [185.219.167.24])
        by smtp.gmail.com with ESMTPSA id du1-20020a17090772c100b0084bfd56fb3bsm11517899ejc.162.2023.01.16.02.07.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Jan 2023 02:07:07 -0800 (PST)
Message-ID: <f7be9afd-c581-c5bf-3967-717977c1979c@kernel.org>
Date:   Mon, 16 Jan 2023 11:07:06 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH] BRANCH_MARKER: work
Content-Language: en-US
To:     "Jiri Slaby (SUSE)" <jirislaby@kernel.org>, airlied@redhat.com
Cc:     linux-kernel@vger.kernel.org
References: <20230116100611.12712-1-jirislaby@kernel.org>
 <20230116100611.12712-2-jirislaby@kernel.org>
From:   Jiri Slaby <jirislaby@kernel.org>
In-Reply-To: <20230116100611.12712-2-jirislaby@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Please, ignore this :).

On 16. 01. 23, 11:06, Jiri Slaby (SUSE) wrote:
> From: Jiri Slaby <jslaby@suse.cz>
> 
> ---
>   branch/work | 1 +
>   1 file changed, 1 insertion(+)
>   create mode 100644 branch/work
> 
> diff --git a/branch/work b/branch/work
> new file mode 100644
> index 000000000000..587be6b4c3f9
> --- /dev/null
> +++ b/branch/work
> @@ -0,0 +1 @@
> +x

-- 
js
suse labs

