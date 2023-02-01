Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 342A3686090
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Feb 2023 08:26:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231863AbjBAH0H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Feb 2023 02:26:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231478AbjBAH0F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 02:26:05 -0500
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com [IPv6:2607:f8b0:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E7976580
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 23:26:04 -0800 (PST)
Received: by mail-oi1-x232.google.com with SMTP id bg12so8361781oib.5
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 23:26:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ufispace-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=qXn8YvLc7wfEXI5vFtc33NHxxjtwjsNAOGS5qreHpPE=;
        b=cL6EEZS8MNorcG7mSX41wkRI8BR8mWiS+xY40vZZFx2DuywCFVd61LAmAMfjGVtzKu
         D4cPDBbBZoM3PA5LlTNUOzByo0VnI93o7UkOSd71hi/FCfthZ9OP8l+CGYvl1d6XDwaE
         MaOQgJG/02qa7m6GwHnUf4Ml7/aLB8a8axQaoTrURkUZZXcs/C9YSCz4Jm8KTBXv/tF0
         d2x8MQGFMuOmp1Vq6XGwAJ34m/dPv/7j/N1ytJ3RmxxkDFwacYTLIJKpFpOSIRtlRguF
         xVaCz5VGEpTp/J8XoY2tv8smYrq9GiUCDJzAwjFC4Ddbvb0de3pDX50Pv6dfJEsvYfuG
         K+3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qXn8YvLc7wfEXI5vFtc33NHxxjtwjsNAOGS5qreHpPE=;
        b=ZpBllbY0FYie9NCocJW0oKHPkDXUF7IlrO/KXeaNN1Yg9wXSOQ7kCQ8FJNR2m7TYD6
         B+trmGfs5/8f0r5bx/jV+2s+S/RM9mOfHe6i3if/EeWGKj/j8tH/AFE8AGXfPU0ovT0w
         ZYQONROXrsm0xFk2a5WJZlEr/w8UhBbN+U7DccQLT66diCTsDidqeJ/4Y0RHXwa4MjCF
         Rip8iuonCV6SGKlHkwg4HSUn18pzF7q1hSBxdqyJtQGERWi2MzmaaQHr+67x2x144Xwg
         Di7wsYsnd/Y65HlDAbxOc4EDmexE8mPWMucGCvI9QrZWOHuNs8A+jfIxpaH8BxDR4hfZ
         ZAWQ==
X-Gm-Message-State: AO0yUKVL+BK9SPUyxXhqawB/XEJdq4hDKPKpSR91vk2g+MXe7tsdAk6N
        OmL6zzQVicBFHz3K/oM+iFJ5CfuFB/urcl+fId9HGg==
X-Google-Smtp-Source: AK7set//uWq5+H+SkpL7GYpussphKlKfUl/mCfcWI54aiDISn4XGgEsTj11TRIXogRd1jwIetIRWjg14sObGaOFVxnM=
X-Received: by 2002:a54:470d:0:b0:378:7c48:f8d6 with SMTP id
 k13-20020a54470d000000b003787c48f8d6mr92029oik.166.1675236363478; Tue, 31 Jan
 2023 23:26:03 -0800 (PST)
MIME-Version: 1.0
References: <20230119102102.73414-1-jordan.chang@ufispace.com>
 <20230119102102.73414-2-jordan.chang@ufispace.com> <bc2329ec-bc3c-51ff-5738-51d2c78fcdc0@linaro.org>
In-Reply-To: <bc2329ec-bc3c-51ff-5738-51d2c78fcdc0@linaro.org>
From:   Jordan Chang <jordan.chang@ufispace.com>
Date:   Wed, 1 Feb 2023 15:25:52 +0800
Message-ID: <CAJ3czeRe+NgWYWhRfZvr3NJFm02H382+04uRYG0fpcgYtyjFhw@mail.gmail.com>
Subject: Re: [PATCH 1/3] dt-bindings: vendor-prefixes: Add prefix for Ufi Space
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        krzysztof.kozlowski+dt@linaro.org, joel@jms.id.au, andrew@aj.id.au,
        robh+dt@kernel.org, jay.tc.lin@ufispace.com,
        eason.ys.huang@ufispace.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzysztof,

Thanks for your comment. I will resend the patch.

Best regards,
Jordan Chang


On Thu, Jan 19, 2023 at 6:57 PM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On 19/01/2023 11:21, Jordan Chang wrote:
> > |This e-mail is confidential. |
>
> Sorry, we cannot work with confidential emails. Everything you send to
> mailing list is public and must not be confidential.
>
> Best regards,
> Krzysztof
>
