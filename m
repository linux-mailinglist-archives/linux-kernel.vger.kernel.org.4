Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD0B273FA0A
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 12:19:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230195AbjF0KTB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 06:19:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbjF0KSR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 06:18:17 -0400
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com [IPv6:2607:f8b0:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7E4F3A99;
        Tue, 27 Jun 2023 03:15:54 -0700 (PDT)
Received: by mail-oi1-x22a.google.com with SMTP id 5614622812f47-3a1e6022b93so1128651b6e.1;
        Tue, 27 Jun 2023 03:15:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687860954; x=1690452954;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hVVzoMXdpNjtgUHY250Y/W5hOx8AigmyoHcaBv9Xj10=;
        b=LjOBDS4/K1nP0HoVX8WCclOQn7pQ/8iXxDkxd2EJZUZIqL8CU+WBtEb2dbMRXIV+xW
         hx2e+Bfjd2qjVdRqcI1yWk0+RL+wnpCpmxEHEV49SbegpKBXo7w324p4AU+g4nbQufcT
         L33nhOWiZgUoYXZ+qgy5OZ1wGOLBmiwMowWB2NwSbRg6E8jOrPlCh/7FiRl/AZK/Gojc
         QQK5REJcXX5w2UghRVPnEyLmr+cB8eKAWoyJTsxeQtR/I8Jz2xGtI+KMmyYY/PUv4XdN
         cZYbTCx4452vernxkvXK1Je4I1bQQt61t9xXcAQUsjSU96fm/Ly9Ce/vvPPHpxZwicmA
         2pug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687860954; x=1690452954;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hVVzoMXdpNjtgUHY250Y/W5hOx8AigmyoHcaBv9Xj10=;
        b=B8HydU5L3LlgBdcy3retH4TYyIezRlzrxt90udnFLf1XO2kCRst+2XRz/vUnXg8ua2
         xr3QSPVExZbpQI7Jt64cHo5cZVRL4q2ULSbGS4b6MyhUO8VHrSb8u3LQdnN8kfMqsJUd
         LMGZuSsVuAu036Mgwcas3k6s+j5JhPQmAGSod+UsZI3Pod5k+vspsj76AVqictuibUwF
         3UT+8Fa9anY0QPEDfrzXDghpd7bqoWl9T0lDHPqN5l/WP5L1RHj0Z30fFLWCbKadBy2E
         xYd/sZNtNfL9W6aTcnH1tTfBX0gElIpytUoMSzZ50Y8VrP6eirDAWeL8PlNtMIHeDeKN
         HKiw==
X-Gm-Message-State: AC+VfDwPVUj9XddDZ9Vx4Fle8WwTYunP8ALkya1vSnmf6DFRFEu+ehlv
        feQG4CynDaXyLdUPJxY9hlo=
X-Google-Smtp-Source: ACHHUZ4D4aCFbAdAdylYjRsMiktTcMuKpBXxQJbIUAzAKWIfqqhf+oEuf1AZTXi3NvUtUseIGyC/nQ==
X-Received: by 2002:a05:6808:1cf:b0:3a1:dcca:9628 with SMTP id x15-20020a05680801cf00b003a1dcca9628mr5197155oic.10.1687860954084;
        Tue, 27 Jun 2023 03:15:54 -0700 (PDT)
Received: from [192.168.0.103] ([103.131.18.64])
        by smtp.gmail.com with ESMTPSA id t4-20020a62ea04000000b00659b8313d08sm5146492pfh.78.2023.06.27.03.15.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Jun 2023 03:15:53 -0700 (PDT)
Message-ID: <99b64dfd-be4a-2248-5c42-8eb9197824e1@gmail.com>
Date:   Tue, 27 Jun 2023 17:15:42 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: Fwd: High cpu usage caused by kernel process when upgraded to
 linux 5.19.17 or later
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     "Steven Rostedt (Google)" <rostedt@goodmis.org>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        Jozsef Kadlecsik <kadlec@netfilter.org>,
        Florian Westphal <fw@strlen.de>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Lingutla Chandrasekhar <clingutla@codeaurora.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        "J. Avila" <elavila@google.com>,
        Vivek Anand <vivekanand754@gmail.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Thomas Renninger <trenn@suse.com>,
        Shuah Khan <shuah@kernel.org>, Borislav Petkov <bp@alien8.de>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Regressions <regressions@lists.linux.dev>,
        Linux Netfilter Development <netfilter-devel@vger.kernel.org>,
        Netfilter Core Developers <coreteam@netfilter.org>,
        Linux Networking <netdev@vger.kernel.org>,
        Linux Power Management <linux-pm@vger.kernel.org>,
        x86@kernel.org
References: <01ac399d-f793-49d4-844b-72cd8e0034df@gmail.com>
 <ZJpJkL3dPXxgw6RK@debian.me>
 <20230627073035.GV4253@hirez.programming.kicks-ass.net>
Content-Language: en-US
From:   Bagas Sanjaya <bagasdotme@gmail.com>
In-Reply-To: <20230627073035.GV4253@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/27/23 14:30, Peter Zijlstra wrote:
> I can't tell from this. Also, please don't use bugzilla.

Why not BZ? I'm confused too...

-- 
An old man doll... just what I always wanted! - Clara

