Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40C18695C1C
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 09:06:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231818AbjBNIGr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 03:06:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231882AbjBNIG1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 03:06:27 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 061C4658D
        for <linux-kernel@vger.kernel.org>; Tue, 14 Feb 2023 00:06:25 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id m20-20020a05600c3b1400b003e1e754657aso4598633wms.2
        for <linux-kernel@vger.kernel.org>; Tue, 14 Feb 2023 00:06:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CexkYCgiU8jqIy3gLQMuVr94YSYODTF1ZIZpmznHWI0=;
        b=oq8fELe1ypAvc08FOz5CbHNTQBld5o23Jvdy+nLY0zG/DnFqza+VDZVuxwBfk8xIVm
         ImZ0fQYX3iD2kpEI2wrrJJ+EOv/ECI1pGCu4gDD9IhpbKAyXQe2Gg+36UgHDi0uWRsxw
         QKFTlhrsHNwTjUGRfM18bUeuqZqenYwJ9+lXPP+TIJmtJqj3qO11s6scjudecRVlXd8G
         yx+52LcS4QzLrkx17Mf0iokjziy/G8h1s4OnVBPi13160Z/MlgxAwmyWSoN4FxAoR886
         R7GzWQlscuhv0+syQCFg7BJqUBMsODphxlVZ4n5BE8SY37bZ4PSRi5tZBcsQ8dac5j5Y
         pIYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CexkYCgiU8jqIy3gLQMuVr94YSYODTF1ZIZpmznHWI0=;
        b=IL7d5bSLXkuDTkOchaBLuziNXnrOVWxTYruX+wwuf5z/VguQfydFfY3VB+zN3cawHC
         hGz4QMNEGmI+gRYf/1GwYmwfRo/BAM+wTQNBaoS/hN968dnr482ylONhNdFLimNkoY4S
         gfDU7tQ+H/YW81YzwK3Sg0mzEsJt/JqKtKvF+4NmuEmd+BUZoX8AyKP8sG04K88mKIR4
         p89epeD98QitXRLDDsEeLOIP+RPiuk2PB9vwn2wQfBjYe2U4ehw15Y0HkP8SjmkDbFVc
         zNqj6RhDC9iHrrkfozRaf5U2ez90jABTKdzi2FZ0KOkizNHsY0KAd2Dq1pHVAQwR5Vck
         dScQ==
X-Gm-Message-State: AO0yUKVRKdHyvlOsMYWNx6m7xUsx6Ysf6HRHTJImt6QDeHKDwSUX050p
        V+si0oFYo23sajpq2N/rgO5N3Q==
X-Google-Smtp-Source: AK7set/UWPyupxpQUXAnyOBo4TUryVO/JI+oWwYyspwHedd26Hv1CWYJdsr5ZpbLTAOsriaer/Ifsg==
X-Received: by 2002:a05:600c:a698:b0:3db:bc5:b2ae with SMTP id ip24-20020a05600ca69800b003db0bc5b2aemr1053106wmb.41.1676361983644;
        Tue, 14 Feb 2023 00:06:23 -0800 (PST)
Received: from [192.168.30.216] ([81.0.6.76])
        by smtp.gmail.com with ESMTPSA id he7-20020a05600c540700b003e1f6e18c95sm773496wmb.21.2023.02.14.00.06.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Feb 2023 00:06:23 -0800 (PST)
Message-ID: <fa2028d1-501f-523e-7b83-2e72d374812c@linaro.org>
Date:   Tue, 14 Feb 2023 09:06:20 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.7.2
Subject: Re: [PATCH v2 08/24] loongarch/cpu: Mark play_dead() __noreturn
Content-Language: en-US
To:     Josh Poimboeuf <jpoimboe@kernel.org>, linux-kernel@vger.kernel.org
Cc:     jgross@suse.com, richard.henderson@linaro.org,
        ink@jurassic.park.msu.ru, mattst88@gmail.com,
        linux-alpha@vger.kernel.org, linux@armlinux.org.uk,
        linux-arm-kernel@lists.infradead.org, catalin.marinas@arm.com,
        will@kernel.org, guoren@kernel.org, linux-csky@vger.kernel.org,
        linux-ia64@vger.kernel.org, chenhuacai@kernel.org,
        kernel@xen0n.name, loongarch@lists.linux.dev, f.fainelli@gmail.com,
        bcm-kernel-feedback-list@broadcom.com, tsbogend@alpha.franken.de,
        linux-mips@vger.kernel.org, jiaxun.yang@flygoat.com,
        mpe@ellerman.id.au, npiggin@gmail.com, christophe.leroy@csgroup.eu,
        linuxppc-dev@lists.ozlabs.org, ysato@users.sourceforge.jp,
        dalias@libc.org, linux-sh@vger.kernel.org, davem@davemloft.net,
        sparclinux@vger.kernel.org, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org,
        hpa@zytor.com, chris@zankel.net, jcmvbkbc@gmail.com,
        linux-xtensa@linux-xtensa.org, peterz@infradead.org,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
        paulmck@kernel.org
References: <cover.1676358308.git.jpoimboe@kernel.org>
 <4da55acfdec8a9132c4e21ffb7edb1f846841193.1676358308.git.jpoimboe@kernel.org>
From:   =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <4da55acfdec8a9132c4e21ffb7edb1f846841193.1676358308.git.jpoimboe@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/2/23 08:05, Josh Poimboeuf wrote:
> play_dead() doesn't return.  Annotate it as such.  By extension this
> also makes arch_cpu_idle_dead() noreturn.
> 
> Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
> ---
>   arch/loongarch/include/asm/smp.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


