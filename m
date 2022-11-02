Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EA876163CA
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 14:25:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231335AbiKBNZ1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 09:25:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230414AbiKBNZY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 09:25:24 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8A7929348
        for <linux-kernel@vger.kernel.org>; Wed,  2 Nov 2022 06:25:20 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id a14so24538591wru.5
        for <linux-kernel@vger.kernel.org>; Wed, 02 Nov 2022 06:25:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=6wind.com; s=google;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:reply-to:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=VpoOzIyshCBPU2NRN3naMF/Ra/n1K3WGYIOqB/gwlHE=;
        b=HIqGTs2Sun3grbHHeNcwaw0BmvTBT85pOmwOOd4TALZ4fT4N4xfKztJYsthl44aolO
         mkcJ6uL2FqrY8DHV26Kaqa83fBjIj14/KbsQKrMzXbbiesqM0JPo1BpXZQCAc9N0sJ2l
         0SdcjJ5SBKtpsbjPr5XfDOmrw7wcCCTZFQAhEyPfC2FDnmbeHU+05khvzX91vaAxEN7o
         GiWDIDQzJIYHw3pJWgeOcFCO7joEWta0zqKWvWXgx1YEJcmDlt9t40dzb8FN1C7ccyoP
         Qm/gwD8j/SESxqcdK3s3purirUP8tkiBlqTwTJCv5uAQHVl0z7ODCNmFSTjkqik3Gcws
         Nxpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:reply-to:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VpoOzIyshCBPU2NRN3naMF/Ra/n1K3WGYIOqB/gwlHE=;
        b=uyouM4aHwpICgan9m+N1tIynIctQn0MNRprltsFWuDEG6x3mV8hz/5KkSRoZNVqP+K
         HMtq/9uk5Q6IIFjNBuFgV5/RYp88ZkqoVq3+IhVNmnS04ISmU2foeF7Ijld+XGtuGLB5
         YLZhKVjRJOmu8bVt7cvsLLFzwjCt/U7TxNrjpGyDs7OLvIUTyoWa6hLnUQWiyiN+jQq8
         Ut0Bh6AFFqV77elxOWiwDVZvcwAt8QXRg1ZiQkJ4TY02fhE61//alPmab3+OVMXV7Puy
         hkBDGquiT8g1ryU4Ia9WHHLhyFl3tpbyBqnuwLt8V7Vb4EMzC3FuPvU0cBsphbuPVbtM
         hrEg==
X-Gm-Message-State: ACrzQf3fbWZNZg3S1e00KW7tSaXNh/9oglTT3FuJzGCj+7N1gXQXKLva
        FmgOvgWAT0KMT4HnTywofaH7siDEs16amw==
X-Google-Smtp-Source: AMsMyM7M8hjrSk3mi8Gohax5odFc/p4bcQRN5e5M+Gp2y2CDWaj+TVgF5MQot6HSwxlF26aZPhkaaQ==
X-Received: by 2002:a05:6000:1549:b0:22e:519e:f39d with SMTP id 9-20020a056000154900b0022e519ef39dmr15161903wry.703.1667395519324;
        Wed, 02 Nov 2022 06:25:19 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:b41:c160:e0c8:95f4:2716:85d9? ([2a01:e0a:b41:c160:e0c8:95f4:2716:85d9])
        by smtp.gmail.com with ESMTPSA id l2-20020a05600c1d0200b003cf878c4468sm2256039wms.5.2022.11.02.06.25.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Nov 2022 06:25:18 -0700 (PDT)
Message-ID: <39232de9-9497-3a8b-294a-702ed54e273c@6wind.com>
Date:   Wed, 2 Nov 2022 14:25:17 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Reply-To: nicolas.dichtel@6wind.com
Subject: Re: [PATCH net-next] net: tun: bump the link speed from 10Mbps to
 10Gbps
Content-Language: en-US
To:     Ilya Maximets <i.maximets@ovn.org>, netdev@vger.kernel.org
Cc:     Jakub Kicinski <kuba@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>, linux-kernel@vger.kernel.org
References: <20221031173953.614577-1-i.maximets@ovn.org>
From:   Nicolas Dichtel <nicolas.dichtel@6wind.com>
Organization: 6WIND
In-Reply-To: <20221031173953.614577-1-i.maximets@ovn.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le 31/10/2022 à 18:39, Ilya Maximets a écrit :
> The 10Mbps link speed was set in 2004 when the ethtool interface was
> initially added to the tun driver.  It might have been a good
> assumption 18 years ago, but CPUs and network stack came a long way
> since then.
> 
> Other virtual ports typically report much higher speeds.  For example,
> veth reports 10Gbps since its introduction in 2007.
> 
> Some userspace applications rely on the current link speed in
> certain situations.  For example, Open vSwitch is using link speed
> as an upper bound for QoS configuration if user didn't specify the
> maximum rate.  Advertised 10Mbps doesn't match reality in a modern
> world, so users have to always manually override the value with
> something more sensible to avoid configuration issues, e.g. limiting
> the traffic too much.  This also creates additional confusion among
> users.
> 
> Bump the advertised speed to at least match the veth.
> 
> Alternative might be to explicitly report UNKNOWN and let the user
> decide on a right value for them.  And it is indeed "the right way"
> of fixing the problem.  However, that may cause issues with bonding
> or with some userspace applications that may rely on speed value to
> be reported (even though they should not).  Just changing the speed
> value should be a safer option.
> 
> Users can still override the speed with ethtool, if necessary.
> 
> RFC discussion is linked below.
> 
> Link: https://lore.kernel.org/lkml/20221021114921.3705550-1-i.maximets@ovn.org/
> Link: https://mail.openvswitch.org/pipermail/ovs-discuss/2022-July/051958.html
> Signed-off-by: Ilya Maximets <i.maximets@ovn.org>
Reviewed-by: Nicolas Dichtel <nicolas.dichtel@6wind.com>
