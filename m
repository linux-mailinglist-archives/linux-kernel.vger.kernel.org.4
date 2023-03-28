Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCE4C6CC82F
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 18:38:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232861AbjC1Qi5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 12:38:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232822AbjC1Qix (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 12:38:53 -0400
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32F89A5FA
        for <linux-kernel@vger.kernel.org>; Tue, 28 Mar 2023 09:38:43 -0700 (PDT)
Received: by mail-io1-xd29.google.com with SMTP id m22so5608608ioy.4
        for <linux-kernel@vger.kernel.org>; Tue, 28 Mar 2023 09:38:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1680021522; x=1682613522;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=U9KH8xtjT2uay9RuE8InbX2zUThEe1/Y3p+Ny+ncZsQ=;
        b=PytFRiSdnJikNU1nfaYuauOKvTIz0ErnRZMUxY2Cz1177f9USRCA116Akn58EcBll4
         YhZ4W7Wz8janbfNCyn3IgXfC3Wt2JKnxLm2yF4g3FFyPZuYhOEOFJbWS63KqZC+azTCn
         5kiuYWy+00/QbPPK+468NDppzKZh1yt+vDt3A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680021522; x=1682613522;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=U9KH8xtjT2uay9RuE8InbX2zUThEe1/Y3p+Ny+ncZsQ=;
        b=SOla0icSTJvws8O0DxOiNDyDkyBPgVrMBUGLO7teA1ed/hJsArvcOwUyCxYh82mP94
         subWu/prdNQ5K24Pi9usgkSUxghQDG7Yumiw7GRTxPcoMe5+4N9mTtetdvZ8mbq4VGhA
         QR7sfVQdd0Xl8EH73bz8aP5LhdUlv3pibECmcsRmWQrr0nzHgl161aQG7f01CmTAdK5y
         MRXEbDPSm5acy2jA9oE4T5zIQwzjw8fYzzzY0UvqMU2mCzr8wPefwpDP+hkpUyfxvyKm
         ky6pwmtrhDqmjDG5IDYYHZ+CowoTO2StVSQNwVYRcBXJURzuRD2Ss/v4QMxvtjg36ibg
         XfAQ==
X-Gm-Message-State: AO0yUKVAoCMG57XWG2WWmBOWz/re3xKaW6jlFmOslXCam+TZ/6yLnlNw
        uVuE/2NtstDJCPvv48R895vnGQ==
X-Google-Smtp-Source: AK7set/VnehVyoKm9sETjZ4TBO9vEVJfQpDQrPAW1oUdZAWB6BlMISkZOgxV5oAlXQH9LSavp6NmFw==
X-Received: by 2002:a05:6602:2f04:b0:758:9dcb:5d1a with SMTP id q4-20020a0566022f0400b007589dcb5d1amr11633484iow.2.1680021522586;
        Tue, 28 Mar 2023 09:38:42 -0700 (PDT)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id q12-20020a05663810cc00b003e8a17d7b1fsm10078548jad.27.2023.03.28.09.38.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Mar 2023 09:38:42 -0700 (PDT)
Message-ID: <68ef1d33-af91-48df-8735-49c6750f1b99@linuxfoundation.org>
Date:   Tue, 28 Mar 2023 10:38:41 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v2] selftests: sched: Add more core schedule prctl calls
Content-Language: en-US
To:     Ivan Orlov <ivan.orlov0322@gmail.com>
Cc:     himadrispandya@gmail.com, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20230327201855.121821-1-ivan.orlov0322@gmail.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20230327201855.121821-1-ivan.orlov0322@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/27/23 14:18, Ivan Orlov wrote:
> The core sched kselftest makes prctl calls only with correct
> parameters. This patch will extend this test with more core
> schedule prctl calls with wrong parameters to increase code
> coverage.
> 
> Signed-off-by: Ivan Orlov <ivan.orlov0322@gmail.com>
> ---
> V1 -> V2: Unnecessary printing removed - 'validate' will
> automatically print the message in case or error
> 

Thank you. Now applied to linux-kselftest next for Linux 6.4-rc1.

thanks,
-- Shuah

