Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54498671C61
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 13:43:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229769AbjARMn0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 07:43:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230126AbjARMk4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 07:40:56 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48BC04A237
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 04:05:53 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id b7so7706447wrt.3
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 04:05:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jOtBx7iuzRQsPxKN1y+9m4RLuvwP28DoAs7Gu1XGBOA=;
        b=P6bO8vngjWSIT1XrIAM91BorkF/ywf8NRmLu2N4HPgWbx6ENup6EZGFzyFAaO4kTyt
         BijCwnc6YuX5l0kgMI7QPtk+dH9VJi0YUSTnNkej28eJfuWziyV4CyTR2wa2RR0dtvPA
         eKFFMdq73UeGETv/MccUPmItb+t0dezwpF1CPwa0WLXNtNoq/EYzbJlAnSyTUmdRMQfW
         4hvHPmQv+XHF/3mXO1A6++0s/dnEYYlunbplWUXEK0RfddDtPWUxg4dnM+FDAgGprwVP
         HEjiA6GM4PPYsjjCnf7/cbAlPzzE7K/ZQhYKGUwX1Oiy/c4+608MHijUSO0Z0aE+1hkJ
         41nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jOtBx7iuzRQsPxKN1y+9m4RLuvwP28DoAs7Gu1XGBOA=;
        b=Dh4/9ueO/D8zAjW2OdBkBeHof4tXW4E5LMS9CxqN+YHMomP0Cflg/SqYu7gk0Zv75L
         WlGe03eWnpW3fAIxLJ5tQwtlSIZYovvGpIJsyulpVhl+2hnoYG5BIoq1/zg9WzkdiwDP
         0yqtESbNaYYEkp0xhvAzsxQTdmpejkX0CHEoxKiNKItTnrnNKtE7aaOmzRtGPa+Vncq/
         ZYgQ+wkrR6bwl6ayxmCpVn6uQ2FvkXy6PKLCMgeZK7ryuXlRmI5Wza9SiQe1Q6btXvKi
         42onvJplMciZjCCTPT1aCLcPs1nLnXqeQiZDz19OnvPx6hHPtKSW9v6X4rBO7RlxPkOz
         d3ug==
X-Gm-Message-State: AFqh2kploJ7j3Xf8zj7rxKAZsP941Kqolj+r0AhM650XnCoyrxDq/EA1
        Rdht+YhQ/cF5ENZcECBUMxwwhg==
X-Google-Smtp-Source: AMrXdXvC7BWWUHoh9f7f73Qbm2nv6DQNkQWjt2oVVrh14s35bOVD3wyjjp8Q+p1rcAfALaOJuwvL8g==
X-Received: by 2002:a5d:6e82:0:b0:242:5563:c3b with SMTP id k2-20020a5d6e82000000b0024255630c3bmr5868223wrz.59.1674043551833;
        Wed, 18 Jan 2023 04:05:51 -0800 (PST)
Received: from [192.168.0.162] (188-141-3-169.dynamic.upc.ie. [188.141.3.169])
        by smtp.gmail.com with ESMTPSA id j3-20020adfff83000000b002bddc1ac273sm14126833wrr.87.2023.01.18.04.05.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Jan 2023 04:05:51 -0800 (PST)
Message-ID: <7822949a-c373-3028-6a42-66a04245e93b@linaro.org>
Date:   Wed, 18 Jan 2023 12:05:50 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH v3 1/8] dt-bindings: arm: qcom: Document MSM8939 SoC
 binding
Content-Language: en-US
To:     Stephan Gerhold <stephan@gerhold.net>
Cc:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        djakov@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-arm-msm@vger.kernel.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, benl@squareup.com,
        shawn.guo@linaro.org, fabien.parent@linaro.org, leo.yan@linaro.org,
        dmitry.baryshkov@linaro.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
References: <20230117024846.1367794-1-bryan.odonoghue@linaro.org>
 <20230117024846.1367794-2-bryan.odonoghue@linaro.org>
 <Y8eyIO8BqKzvulbB@gerhold.net>
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
In-Reply-To: <Y8eyIO8BqKzvulbB@gerhold.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/01/2023 08:47, Stephan Gerhold wrote:
> On Tue, Jan 17, 2023 at 02:48:39AM +0000, Bryan O'Donoghue wrote:
>> Document the MSM8939 and supported boards in upstream Sony "Tulip" M4 Aqua
>> and Square APQ8039 T2.
>>
>> MSM8939 is one of the older SoCs so we need to expand the list of
>> qcom,board-ids to allow for the bootloader DTS board-id matching
>> dependency.
>>
> 
> The original LK bootloaders cannot boot your msm8939.dtsi correctly,
> because a spin-table implementation is required to get the other CPU
> cores up. This means that a modified bootloader is always needed from
> the upstream point of view, since I doubt anyone wants to use these
> devices with a single core only. lk2nd (as the primary spin-table
> implementation right now) has never required qcom,board-ids and any
> custom LK would be easy to patch to ignore these.

The system boots just fine with the shipped LK. We get display, USB, SD, 
WiFi.

We just don't support booting the second cluster via any other means 
than lk2nd right now.

You could also not use lk2nd, stick with your default LK and import LPM 
patches.

Default LK:
root@linaro-alip:~# cat /proc/cpuinfo
processor       : 0
BogoMIPS        : 38.40
Features        : fp asimd evtstrm aes pmull sha1 sha2 crc32 cpuid
CPU implementer : 0x41
CPU architecture: 8
CPU variant     : 0x0
CPU part        : 0xd03
CPU revision    : 4

root@linaro-alip:~# iw wlan0 info 
 

Interface wlan0
         ifindex 6
         wdev 0x1
         addr e2:b9:a0:ef:3a:ba
         type managed
         wiphy 0
         channel 52 (5260 MHz), width: 80 MHz, center1: 5290 MHz
         txpower 20.00 dBm
         multicast TXQ:
                 qsz-byt qsz-pkt flows   drops   marks   overlmt hashcol 
tx-bytes        tx-packets
                 0       0       0       0       0       0       0 
0               0
root@linaro-alip:~# uname -a
Linux linaro-alip 6.2.0-rc4-next-20230116-00029-gf1a46ff9e812-dirty #392 
SMP PREEMPT Tue Jan 17 23:46:42 GMT 2023 aarch64 GNU/Linux


LK2ND:
root@linaro-alip:~# cat /proc/cpuinfo
processor       : 0
BogoMIPS        : 38.40
Features        : fp asimd evtstrm aes pmull sha1 sha2 crc32 cpuid
CPU implementer : 0x41
CPU architecture: 8
CPU variant     : 0x0
CPU part        : 0xd03
CPU revision    : 4

processor       : 1
BogoMIPS        : 38.40
Features        : fp asimd evtstrm aes pmull sha1 sha2 crc32 cpuid
CPU implementer : 0x41
CPU architecture: 8
CPU variant     : 0x0
CPU part        : 0xd03
CPU revision    : 4

processor       : 2
BogoMIPS        : 38.40
Features        : fp asimd evtstrm aes pmull sha1 sha2 crc32 cpuid
CPU implementer : 0x41
CPU architecture: 8
CPU variant     : 0x0
CPU part        : 0xd03
CPU revision    : 4

processor       : 3
BogoMIPS        : 38.40
Features        : fp asimd evtstrm aes pmull sha1 sha2 crc32 cpuid
CPU implementer : 0x41
CPU architecture: 8
CPU variant     : 0x0
CPU part        : 0xd03
CPU revision    : 4

processor       : 4
BogoMIPS        : 38.40
Features        : fp asimd evtstrm aes pmull sha1 sha2 crc32 cpuid
CPU implementer : 0x41
CPU architecture: 8
CPU variant     : 0x0
CPU part        : 0xd03
CPU revision    : 4

processor       : 5
BogoMIPS        : 38.40
Features        : fp asimd evtstrm aes pmull sha1 sha2 crc32 cpuid
CPU implementer : 0x41
CPU architecture: 8
CPU variant     : 0x0
CPU part        : 0xd03
CPU revision    : 4

processor       : 6
BogoMIPS        : 38.40
Features        : fp asimd evtstrm aes pmull sha1 sha2 crc32 cpuid
CPU implementer : 0x41
CPU architecture: 8
CPU variant     : 0x0
CPU part        : 0xd03
CPU revision    : 4

processor       : 7
BogoMIPS        : 38.40
Features        : fp asimd evtstrm aes pmull sha1 sha2 crc32 cpuid
CPU implementer : 0x41
CPU architecture: 8
CPU variant     : 0x0
CPU part        : 0xd03
CPU revision    : 4

root@linaro-alip:~# iw wlan0 info
Interface wlan0
         ifindex 6
         wdev 0x1
         addr 02:00:0e:66:5c:21
         type managed
         wiphy 0
         channel 64 (5320 MHz), width: 80 MHz, center1: 5290 MHz
         txpower 20.00 dBm
         multicast TXQ:
                 qsz-byt qsz-pkt flows   drops   marks   overlmt hashcol 
tx-bytes        tx-packets
                 0       0       0       0       0       0       0 
0               0
root@linaro-alip:~# uname -a
Linux linaro-alip 6.2.0-rc4-next-20230116-00029-gf1a46ff9e812-dirty #392 
SMP PREEMPT Tue Jan 17 23:46:42 GMT 2023 aarch64 GNU/Linux

---
bod
