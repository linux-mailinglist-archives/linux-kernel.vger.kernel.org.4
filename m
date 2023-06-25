Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64D3573D175
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Jun 2023 16:28:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230280AbjFYO23 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Jun 2023 10:28:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229509AbjFYO22 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Jun 2023 10:28:28 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4957EC6
        for <linux-kernel@vger.kernel.org>; Sun, 25 Jun 2023 07:28:27 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id 4fb4d7f45d1cf-50c079eb705so538355a12.1
        for <linux-kernel@vger.kernel.org>; Sun, 25 Jun 2023 07:28:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687703306; x=1690295306;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QT+PeXl9J1H04ELBR+b0mv138YocFRtBZpqWo3biTeQ=;
        b=pFPJF+nL1+7yicddC8DWtsDDnARAvpaZoonNi+nkCytcArspBkKMW/H6Z8m1i4K2vt
         k3IThHWOJbCYJOvhQ9UciO34cj40hLlI5GY4pO04K6ndIbaTE3ShF2YL1zdqXXZFngy/
         penTW77DHZA5E/53Wq+19/khWLFktBa4gcsym+hZtOialuLwo+SJGWGVY3RbC3iYBJZk
         RlVIkPcV3Dn2qEvU9YXjjw39L2DvaGYTa/iHvU4kH9JsW26ysURjBIr0fCzukVQm+/g1
         X2skcWa5OwSHSsnc362MYDGbb9NEMzjX1v4HYw8ELSxItEQ9ljQWanDCcswn3R2kIWsz
         WGLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687703306; x=1690295306;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QT+PeXl9J1H04ELBR+b0mv138YocFRtBZpqWo3biTeQ=;
        b=hGdYMA5jHUhWoKfF2ZDR1G/soD11MBf/4+JAy7PUTc6cdwZWE1tJzOS7BvKytzLfXE
         HohbmSbPTT3VkLMzwvP3+AbOf5NCkRVhNaOjL1Xmjgv6HheGxdiwTbU8hEmIWJm5gknL
         xf0Z4GOwMSZeKtSCMhOBHsV80h4FvIKQq3EbCn7bu1euyD8Un5J2lwIggzWN1KPQcZJ+
         1/G1wvQE8KoNZomSfT0gISUsIBzTrthZlNvdIvT28XNAPiQRBIKOdmmCWmAYISyUCo7b
         7xmthjx/aD0jWTudoG/1/RYiekGPLuwdr1EZPj8RFLlHN0CTAcCRsKJIk/HvHQqPwfw1
         VSxg==
X-Gm-Message-State: AC+VfDzsla7d/HNQs1fgl6n4E/AnrasA8iUVGijjZnvwaVCiVoHhP+9S
        QlLbAQNnu2izdoH+kpf/+wA=
X-Google-Smtp-Source: ACHHUZ6os37D661SyBYWn8eKEtOqZk83KO6XdClDibKqY0YbZ9o/ON3/tyKS13IT9RTpsbRB3cK6ew==
X-Received: by 2002:a05:6402:254d:b0:51d:895f:aa93 with SMTP id l13-20020a056402254d00b0051d895faa93mr2511451edb.1.1687703305452;
        Sun, 25 Jun 2023 07:28:25 -0700 (PDT)
Received: from [192.168.0.101] (p57ba2e0b.dip0.t-ipconnect.de. [87.186.46.11])
        by smtp.gmail.com with ESMTPSA id be28-20020a0564021a3c00b0051bfb7de166sm1812104edb.39.2023.06.25.07.28.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 25 Jun 2023 07:28:24 -0700 (PDT)
Message-ID: <ca4d6bdf-158b-1d5a-da1f-9401d9d95931@gmail.com>
Date:   Sun, 25 Jun 2023 16:28:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] staging: rtl8192e: Rename function IsHTHalfNmodeAPs to
 is_ht_half_nmode_a_ps
Content-Language: en-US
To:     Tree Davies <tdavies@darkphysics.net>, gregkh@linuxfoundation.org,
        dan.carpenter@linaro.org
Cc:     linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev
References: <ZJdz9oWjPuE3xZ8Y@tacos.darkphysics>
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
In-Reply-To: <ZJdz9oWjPuE3xZ8Y@tacos.darkphysics>
Content-Type: text/plain; charset=UTF-8; format=flowed
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

On 6/25/23 00:53, Tree Davies wrote:
> Rename function IsHTHalfNmodeAPs to is_ht_half_nmode_a_ps in order to
> fix checkpatch warning: Avoid CamelCase
> 

Hi Tree

If you look where the function is used you will see that it is used in 
rtllib_rx_auth_resp which is used in:
rtllib_rx_auth which is used in:
rtllib_rx_frame_softmac which is used in:
rtllib_rx_frame_mgmt which is used in:
rtllib_rx_InfraAdhoc


This has for me to do with access points so please do not cut the ap apart.

Thanks

Bye Philipp



