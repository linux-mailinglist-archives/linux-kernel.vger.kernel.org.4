Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F00770613C
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 09:34:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230120AbjEQHeU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 03:34:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230004AbjEQHdl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 03:33:41 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AF8C5241
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 00:33:07 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id a640c23a62f3a-965f7bdab6bso68878866b.3
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 00:33:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20221208.gappssmtp.com; s=20221208; t=1684308785; x=1686900785;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dNSDSFrDFbpPqdYEuN89e9yeuyZne6fiLX09JZpnnaQ=;
        b=VmMAPOyosODi0Oa3kk/lczgV+F2wFxVZqk/0hszxe6QSeo3ux81DeWhkAFDUa5ku0B
         EBVL5IutHi6M7si8Vm8aAiOTcMFGFAjk2kxuqfj5x+sT5Wgsu9+Yjj6y0E0+GkB7eV/2
         FcWAUoD3eg8bs96ntWcLX2TarfzeCS74IoXx8FkajG2BQ+HIC36UoFg/oq4Yl4J/r7eB
         yxTxC+pJiMcArvLGowXWqL736Ukqmfc4j7mLQYNDCwG8QVYKAAeWyzgOZK/HILnza1fW
         erNjN9FdiNH4EGuBRrPcKURazxmzSrlDlhDlg9c1cencscueOAOfdJbO3HGQHPACDuZv
         +vgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684308785; x=1686900785;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dNSDSFrDFbpPqdYEuN89e9yeuyZne6fiLX09JZpnnaQ=;
        b=VzLYUeuVkzRvZRXsWHH82imXufHCCL5OhZ6i98ZT0sUTQUWF1GdwDvHhxgcPx0g9xg
         Ah94ERVNSM9X79LHgouigUPkhIyLQJGzNwdle3zwAqTlLRbkqixehEF/qZiypeN2BXJe
         8Ctwpnq9POaC9SgefS5lSYGyGh3rnxuCckcGDxOjlNM1DOZOSndkJF310M3UaoOhcal0
         6jl4e/f88v5vvglb6SzhcdmarsagyqCrt5bTMu6u/+C1yHubgnJDOX6Q58NZwZrMWg4a
         uQVL010L9GRx/VMHjPwBh1mRR7UOfkyy7NTdzfFxOrSmM6fZ89FYCmuKIhlIchEYIXtl
         MfBA==
X-Gm-Message-State: AC+VfDxjimdHff5I3ojhv+BOnwHOZBfDV2T5oOsWdMgHrTUCDoGht2sM
        3u2RR/kRSc4QeiMBpXLmH+9r3g==
X-Google-Smtp-Source: ACHHUZ4bKH6nuAL+Av8BpnIu5DQ26jMK8Rn4ZGnWU07q0yJ5uj8FsA7prleEWrWha2M97z1kBLUvMA==
X-Received: by 2002:a17:907:6d23:b0:96a:349a:6c91 with SMTP id sa35-20020a1709076d2300b0096a349a6c91mr23819008ejc.23.1684308785373;
        Wed, 17 May 2023 00:33:05 -0700 (PDT)
Received: from [192.168.0.161] (62-73-72-43.ip.btc-net.bg. [62.73.72.43])
        by smtp.gmail.com with ESMTPSA id m26-20020a17090677da00b0096ae4451c65sm5850503ejn.157.2023.05.17.00.33.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 May 2023 00:33:04 -0700 (PDT)
Message-ID: <63f12ee5-bd7d-a734-af98-e99196d84441@blackwall.org>
Date:   Wed, 17 May 2023 10:33:03 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 3/4] bridge: always declare tunnel functions
Content-Language: en-US
To:     Arnd Bergmann <arnd@kernel.org>, netdev@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, Roopa Prabhu <roopa@nvidia.com>,
        bridge@lists.linux-foundation.org, linux-kernel@vger.kernel.org
References: <20230516194625.549249-1-arnd@kernel.org>
 <20230516194625.549249-3-arnd@kernel.org>
From:   Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20230516194625.549249-3-arnd@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/05/2023 22:45, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> When CONFIG_BRIDGE_VLAN_FILTERING is disabled, two functions are still
> defined but have no prototype or caller. This causes a W=1 warning for
> the missing prototypes:
> 
> net/bridge/br_netlink_tunnel.c:29:6: error: no previous prototype for 'vlan_tunid_inrange' [-Werror=missing-prototypes]
> net/bridge/br_netlink_tunnel.c:199:5: error: no previous prototype for 'br_vlan_tunnel_info' [-Werror=missing-prototypes]
> 
> The functions are already contitional on CONFIG_BRIDGE_VLAN_FILTERING,
> and I coulnd't easily figure out the right set of #ifdefs, so just
> move the declarations out of the #ifdef to avoid the warning,
> at a small cost in code size over a more elaborate fix.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  net/bridge/br_private_tunnel.h | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 

This should be for -net.

Fixes: 188c67dd1906 ("net: bridge: vlan options: add support for tunnel id dumping")
Fixes: 569da0822808 ("net: bridge: vlan options: add support for tunnel mapping set/del")
Acked-by: Nikolay Aleksandrov <razor@blackwall.org>

Thanks,
 Nik



