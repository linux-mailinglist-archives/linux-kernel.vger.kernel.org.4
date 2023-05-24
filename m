Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03E8870F9BB
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 17:05:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234128AbjEXPFu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 11:05:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231835AbjEXPFt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 11:05:49 -0400
Received: from mail-oo1-xc2d.google.com (mail-oo1-xc2d.google.com [IPv6:2607:f8b0:4864:20::c2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51FC69C
        for <linux-kernel@vger.kernel.org>; Wed, 24 May 2023 08:05:48 -0700 (PDT)
Received: by mail-oo1-xc2d.google.com with SMTP id 006d021491bc7-5557d18020bso369908eaf.0
        for <linux-kernel@vger.kernel.org>; Wed, 24 May 2023 08:05:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20221208.gappssmtp.com; s=20221208; t=1684940747; x=1687532747;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jsXDqOwIthljXpliSBNwW9fUfKgJoKh43UtzFtV9dOU=;
        b=qLup07BqTqy6KbTsvZUZyVtPx3/sc2qHkOeCdXLH2mPxT5WksE/UmyeaXqxs/xZiNr
         Yjzl6miNyUemQI0e+x/SyHr9w0NVy90FIFBMItokZ4WSVbLziRU5a/2A8xMS0EuiNVPw
         6bFh7vRTJ99gZFyUmCAHUtUKlTr/asWIlmR5WZ/xAUUS8P3vBjKpZvkACxnSht4aYnQY
         eoOrC7utzWYU4QGOJtPT7AMJaMDJkWraHlFZUGNyesnxu2OaXvCj6WsH3jcg7PkT3MNr
         /+XtwFQgN3FgfRaFjbuvb1L8XIK+LqJjwl0Yh8TFdmI8Pe+GsP7DH3C8v0yy1PCqYpmq
         1KjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684940747; x=1687532747;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jsXDqOwIthljXpliSBNwW9fUfKgJoKh43UtzFtV9dOU=;
        b=iKhOi+BNtbq9D6em2Npkw8EaJdZXot05uf6Le99wvTzt6j8xwRFg+VWd+HK5WCxs9c
         okV1uNTnqerFf9+mF0Z1KTgAuxPgW8vQMyqFCguGm1XtTlTvghqMve4ZFFw/FW6qGQBY
         BR26hAd1a6zaJpIPJmxh3oHAzovRm5DUPAE7rVuxs3mx4rwB42dbZ0xYWDzw5WUeBuXG
         bLeZpnW7FOW417hDihf7gBnf2iU/WMWpvO2OlL0NcmTieTh+m1QUN7JhqMljvu4y8qvF
         rv0FRqFS5yhzlsEVoo1jR0DXFK64+geX+WdMMAleE8zDeyszpgX9qAiy2eAPmVsUIzq4
         Woww==
X-Gm-Message-State: AC+VfDwJKZBNa/mfr+8RHsB1gC8gzIEkh657x+/ljL4k8M3LA1fOr5Fm
        /N15O8eIqmtRf9KCmpZhzIGutA==
X-Google-Smtp-Source: ACHHUZ5SxBaXmW3shszgya23SMXxWUTnb1BSfAgQZcfVtJPI0Bi6Ve7lvtA1ZzDzTOopnJ+/LM3Xcw==
X-Received: by 2002:a4a:625c:0:b0:555:5ab5:a0e0 with SMTP id y28-20020a4a625c000000b005555ab5a0e0mr3518499oog.8.1684940747668;
        Wed, 24 May 2023 08:05:47 -0700 (PDT)
Received: from ?IPV6:2804:14d:5c5e:44fb:522c:f73f:493b:2b5? ([2804:14d:5c5e:44fb:522c:f73f:493b:2b5])
        by smtp.gmail.com with ESMTPSA id z6-20020a056830128600b006a44338c8efsm1856740otp.44.2023.05.24.08.05.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 May 2023 08:05:47 -0700 (PDT)
Message-ID: <b811578d-bb53-f226-424c-7d2428ffd845@mojatatu.com>
Date:   Wed, 24 May 2023 12:05:43 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [syzbot] [net?] KASAN: slab-use-after-free Write in
 mini_qdisc_pair_swap
Content-Language: en-US
From:   Pedro Tammela <pctammela@mojatatu.com>
To:     syzbot+b53a9c0d1ea4ad62da8b@syzkaller.appspotmail.com
Cc:     davem@davemloft.net, edumazet@google.com, jhs@mojatatu.com,
        jiri@resnulli.us, kuba@kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, pabeni@redhat.com,
        syzkaller-bugs@googlegroups.com, xiyou.wangcong@gmail.com
References: <0000000000006cf87705f79acf1a@google.com>
 <f309f841-3997-93cf-3f30-fa2b06560fc0@mojatatu.com>
In-Reply-To: <f309f841-3997-93cf-3f30-fa2b06560fc0@mojatatu.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SCC_BODY_URI_ONLY,
        SORTED_RECIPS,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

#syz test: https://gitlab.com/tammela/net.git peilin-patches
Let's try with https then...
