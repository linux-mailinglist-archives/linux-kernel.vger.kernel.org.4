Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B520678629
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 20:21:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231857AbjAWTVL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 14:21:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231836AbjAWTVI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 14:21:08 -0500
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D4403C3D;
        Mon, 23 Jan 2023 11:21:07 -0800 (PST)
Received: by mail-qt1-x82b.google.com with SMTP id o5so10639848qtr.11;
        Mon, 23 Jan 2023 11:21:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2hDWT4R3evnKcGBTHLEy6CPS3Ves2RMswyJb5mXghec=;
        b=JJbcjiGwPMwZwsZF48ECa0ORaxgpnlaK5tp74HwW20bfuoUECJtltCzfCrkqRPzGGu
         OVfAK8urpYVOmfX2ujO+8uvtcWHWHvUcULcYdmqWDljQl1WVFOc142PUKIlzgEErRLjO
         7F5XxxTXPea+tZK01hpeZTbnBvxwGriKvd4J09QNAlWHpNpeN9nhAly1j3lXRQTwocFJ
         Vxb+EV5UB81DIQB8atKerehrbqMjbNfchC61/GDVmaYdHVTOSpDBqKNF6fjWpNkfatie
         CfMoDRp7y+C2G4WYujGfktWtG/abkZgAGhzzCVd2bVpChyu8Hr4Qu+qmkblDHAKripau
         ReRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2hDWT4R3evnKcGBTHLEy6CPS3Ves2RMswyJb5mXghec=;
        b=KuSQZD6He4VA7S8q4n7edEvNlV7/fLnhZHpT4UJZqOKZTUo5arBcOewKV7f2wzNy35
         yda3KhcNBfdJ9ARlWamvyvDHUJ+aj58TeSndZtcjLvoPVHkANZrLvoI6BP9mbju+T/Q3
         ehBQGs4HLg3n4zTn7/53huJbjnPXhfJw4XRnilhkxvEEG+u+TzS+6qbqjFWxu9Fv4+BX
         N+JMNjn+2cDYO0vP6ZIDYmN3pFTl9oSfEkpBpdFQKYOgoPDXYk+RaDDWw1ctmHf+xMJ/
         CuhDOHsclIA0UA793xXgX1XHc84+/KkzFOFpQgKh+2R+HfxvwM4VpKapTWaIkhUmLSQj
         5fHg==
X-Gm-Message-State: AFqh2kpNmVSXzPanBFu8JAovZRWVjUljwJTUEBIaU+71sWyxcRESCCCJ
        Mc7mVdc0/es6B0VD9Yc5fJU=
X-Google-Smtp-Source: AMrXdXuwlvmWS4km19SGclC3Wu8j1GaOgKpCgYnLUkHTKCa1Vknzq6OZyLPgIdgdqBBdJWeNgU4txQ==
X-Received: by 2002:ac8:4e39:0:b0:3b6:3af6:f2e1 with SMTP id d25-20020ac84e39000000b003b63af6f2e1mr35523447qtw.59.1674501666721;
        Mon, 23 Jan 2023 11:21:06 -0800 (PST)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id u24-20020ac87518000000b003b2365c9aa6sm16501554qtq.14.2023.01.23.11.20.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Jan 2023 11:21:05 -0800 (PST)
Message-ID: <4509fb17-f73d-c8f8-081f-584d2d177f8e@gmail.com>
Date:   Mon, 23 Jan 2023 11:20:55 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH 2/6] rtc: brcmstb-waketimer: non-functional code changes
Content-Language: en-US
To:     Doug Berger <opendmb@gmail.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     Brian Norris <computersforpeace@gmail.com>,
        Markus Mayer <mmayer@broadcom.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>, linux-rtc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20230120190147.718976-1-opendmb@gmail.com>
 <20230120190147.718976-3-opendmb@gmail.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20230120190147.718976-3-opendmb@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/20/23 11:01, Doug Berger wrote:
> These changes are not intended to affect functionality, but
> simplify the source code. They are performed here to simplify
> review and reduce confusion with other changes in this set.
> 
> Since set_alarm includes the alarm_irq_enable functionality call
> it directly from that function for simplicity (even though it
> does nothing at the moment). The order of the declarations is
> changed to prevent the need for a prototype.
> 
> The function device_init_wakeup() is used to replace the
> functions device_set_wakeup_capable() and device_wakeup_enable()
> since it is equivalent.
> 
> Signed-off-by: Doug Berger <opendmb@gmail.com>

Acked-by: Florian Fainelli <f.fainelli@gmail.com>
-- 
Florian

