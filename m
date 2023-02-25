Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D87E36A2A83
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Feb 2023 16:38:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229601AbjBYPif (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Feb 2023 10:38:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229529AbjBYPie (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Feb 2023 10:38:34 -0500
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 656EE12BF8
        for <linux-kernel@vger.kernel.org>; Sat, 25 Feb 2023 07:38:33 -0800 (PST)
Received: by mail-pl1-x62b.google.com with SMTP id p6so1638580plf.0
        for <linux-kernel@vger.kernel.org>; Sat, 25 Feb 2023 07:38:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H11nsR0/WzFHGTh9YPgkjgdmBW7qFVGMVXyzNotAwfk=;
        b=a6CvAgPpiEZiWKTDLuxleTalH656U6ziYflK8CpUT80zHXkB6cZI7VjtqpDKDcwhon
         UfG56aId+KqRWZJfEcpbW6iuSpaaZGNHPU6TGgt3Gk8vKwh6G+lNIYpChlW5BdI7pZY3
         6Mw3i4JZjKnH4rqKKhVzFhtaKiZFxNKJFmmqM57KoFH2nqimDH0v9cBwAQUPVHOx269i
         bvwyUAYjISI6wreXuZPJgkwf7zOmGcY7H1c1AtHNWmv5rf9IsteL7k/Qvqr8NsXff2TR
         6d3BLB+KWoE+mq/Z36g1vcMD//NOkhmd+dPG1/X65hwHNPZ4kIfPLajEoD+cRiG4MCjy
         Z+vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=H11nsR0/WzFHGTh9YPgkjgdmBW7qFVGMVXyzNotAwfk=;
        b=QkUhinXDNrjR2tpRxRy2yFmmZUHmQb/VcAfTFB5ZOIZzOg2+BqQLG5Gve5g4x0YsK3
         PmWdA3WFEPhAa1LecHT8hC+yPUdDFU1v6z794WVdA8SuOAUO+wtN/0iSw42hBF3fHHtp
         P0tU54t4AfnlTrKY16mr4d2Uh0jq1J6/jauFwV1mWjLYNl8dv4vIQ4MMCEOwWuW+Yu5M
         9WrI6ItFt7HvkkRTgv5vZbhNvN4rHDciqdsTwDZhd5bHZT2FOjnMFRqMyB0Tb12aUhmm
         NXhihhpcuAkeE3JTN4MMTKOxspkETkQX4O87mbhbx3ru0zbSAaX/mEN0Ps8C5G5PEe6F
         5NKA==
X-Gm-Message-State: AO0yUKW0VNBlFNrerRStaB+yrNxm0FwCUL05/zk42l+m7DbiMAo8n2MM
        JcIYb2RKMAhT/4njYkaRKvk=
X-Google-Smtp-Source: AK7set8C4/svYKf97HHf/4v/m54cJ6pTR/yVJXeuyna/qECt9pt7k6EZSxDymUG7X/HLiRKyoBac/A==
X-Received: by 2002:a17:902:f549:b0:19c:90d2:c909 with SMTP id h9-20020a170902f54900b0019c90d2c909mr20469285plf.42.1677339512733;
        Sat, 25 Feb 2023 07:38:32 -0800 (PST)
Received: from ?IPV6:2600:8802:b00:4a48:1c16:31cb:9a06:c73e? ([2600:8802:b00:4a48:1c16:31cb:9a06:c73e])
        by smtp.gmail.com with ESMTPSA id 6-20020a170902ee4600b0019a96d3b456sm1441140plo.44.2023.02.25.07.38.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 25 Feb 2023 07:38:32 -0800 (PST)
Message-ID: <03b70a8a-0591-f28b-a567-9d2f736f17e5@gmail.com>
Date:   Sat, 25 Feb 2023 07:38:31 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Content-Language: en-US
To:     Saravana Kannan <saravanak@google.com>,
        Stefan Wahren <stefan.wahren@i2se.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel <linux-kernel@vger.kernel.org>
From:   Florian Fainelli <f.fainelli@gmail.com>
Subject: Raspberry Pi 4B: Failed to create device link with soc:firmware:gpio
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Saravana,

Using v6.2-10217-ga93e884edf61v my Raspberry Pi 4B issues the following 
for the "extended GPIO" provider:

[    5.969855] uart-pl011 fe201000.serial: Failed to create device link 
with soc:firmware:gpio

The kernel configuration I am using can be found here:

https://gist.github.com/ffainelli/4eb83740c25b10f75b54560f8c8febb1

And the DTS is arch/arm*/boot/dts/bcm2711-rpi-4-b.dts

Does this ring any bell?

Thanks!
-- 
Florian
