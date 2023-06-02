Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49C5D71FC41
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 10:42:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234611AbjFBIm1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jun 2023 04:42:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229515AbjFBImY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jun 2023 04:42:24 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 071D018C
        for <linux-kernel@vger.kernel.org>; Fri,  2 Jun 2023 01:42:23 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id a640c23a62f3a-970056276acso256476866b.2
        for <linux-kernel@vger.kernel.org>; Fri, 02 Jun 2023 01:42:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1685695341; x=1688287341;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ulq4OZiXYAieRrRq88dpEIE3RYucbrr7NukGwo0ANhU=;
        b=0KKmwxtDonKpBq+O708ULhKF4QlbPgf94kGe2VLNAjZ3+/QOc9xqt1INoayrixM/U3
         s3/WjddTz2GQ2z1bJaCKLSoShDhd/tLJZ0hO4VQ7IYRmCe9BsbKIk+vGYY7uD54N5YHI
         SKhalpFYKOOO79+ci8cH1Q8vQr3az7dBFptKctQuHtqF0tVTr798eU8JY+kzEBHYKdlo
         EG8R7khB6g31qGyNZT345mKl0EmenU+e6K/pciw7ZywPuuqi2j/5QP5yufxUDHoDaNRA
         s6S7XLUKEn48WzIYTvDaegOaUIB/DAjU7YKW+yUekoAuNWh3mjr1nLbxGBa0KCmVbuvz
         prag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685695341; x=1688287341;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ulq4OZiXYAieRrRq88dpEIE3RYucbrr7NukGwo0ANhU=;
        b=iiVb3l/KAgFlWJQ0Kl3hb6kdeuzQeAQBJKnRbe1Mh2M1MeebZ22cDaibh4pw4Rp5Bt
         HFDG8eg39SDkEsq6cOLnDPslRsqPhcCoZ1zl1RmcT8XrvXr52K2rzFGAZzsx1KB3uAIx
         pyUYDDYUUhhLqdMa+AgYfiXkDebKACkE/2/LuCbHU3UGBOR/8pWecK6IZYX5LJDZYGOx
         SAzWca5jmBvTt+/4GcqSFoqRmePB/IYCiAFMBCCSSshU1loYbRFFH2AOppQ4o2oOVEE7
         nyFlfFvpfbUCs9IG/MDJncV1wAo7uRfRKl5C2pi6qtsLqP3QRcB88i0IadXkGHbC7Q0c
         ITLA==
X-Gm-Message-State: AC+VfDyccsE4HWHskvnohn4MlJlehIPyQ/Hb/h0Agh2Q0g8X9RNaDJMy
        cdf3EEyBqWl68RKFef3/y3GeJw==
X-Google-Smtp-Source: ACHHUZ5ZsLXqx11LfoQxvoMVtqGUxOmwKXFSjmo5X8DLvf5yXtEl91+0aCV+faaobRckakgFHhjGHA==
X-Received: by 2002:a17:907:2d11:b0:973:ed4a:375f with SMTP id gs17-20020a1709072d1100b00973ed4a375fmr9939546ejc.46.1685695341354;
        Fri, 02 Jun 2023 01:42:21 -0700 (PDT)
Received: from [10.44.2.5] ([81.246.10.41])
        by smtp.gmail.com with ESMTPSA id o9-20020a1709064f8900b0094e6a9c1d24sm500066eju.12.2023.06.02.01.42.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 Jun 2023 01:42:21 -0700 (PDT)
Message-ID: <68035bad-b53e-91cb-0e4a-007f27d62b05@tessares.net>
Date:   Fri, 2 Jun 2023 10:42:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH net-next RFC] net: skip printing "link become ready" v6
 msg
Content-Language: en-GB
To:     David Ahern <dsahern@kernel.org>,
        Stephen Hemminger <stephen@networkplumber.org>
Cc:     mptcp@lists.linux.dev, "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Mat Martineau <martineau@kernel.org>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230601-net-next-skip_print_link_becomes_ready-v1-1-c13e64c14095@tessares.net>
 <20230601103742.71285cf1@hermes.local>
 <63ee166d-6b33-2293-4ff2-2c42d350580a@kernel.org>
From:   Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <63ee166d-6b33-2293-4ff2-2c42d350580a@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stephen, David,

On 01/06/2023 19:43, David Ahern wrote:
> On 6/1/23 11:37 AM, Stephen Hemminger wrote:
>> On Thu, 01 Jun 2023 16:34:36 +0200
>> Matthieu Baerts <matthieu.baerts@tessares.net> wrote:
>>
>>> This following message is printed in the console each time a network
>>> device configured with an IPv6 addresses is ready to be used:
>>>
>>>   ADDRCONF(NETDEV_CHANGE): <iface>: link becomes ready
>>>
>>> When netns are being extensively used -- e.g. by re-creating netns with
>>> veth to discuss with each other for testing purposes like mptcp_join.sh
>>> selftest does -- it generates a lot of messages: more than 700 when
>>> executing mptcp_join.sh with the latest version.
>>
>> Don't add yet another network nerd knob.
>> Just change message from pr_info to pr_debug.
> 
> +1

Thank you both for your quick replies! I will send a patch doing that.

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
