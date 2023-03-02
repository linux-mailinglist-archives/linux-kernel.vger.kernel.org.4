Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 212F76A7A33
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Mar 2023 04:53:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229766AbjCBDxW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Mar 2023 22:53:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229661AbjCBDxT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Mar 2023 22:53:19 -0500
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C88D16896;
        Wed,  1 Mar 2023 19:53:16 -0800 (PST)
Received: by mail-pj1-x102a.google.com with SMTP id h17-20020a17090aea9100b0023739b10792so1427060pjz.1;
        Wed, 01 Mar 2023 19:53:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1677729196;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ar0XxaRzkCTA8E2JFdUWamlA7+uw4UZJbuAUnYzNZgs=;
        b=okq5JpU0rUq6hpQSLXVeTssVE20LYTIrY5bIPmoeky15NtC/cfWmWfUvDabcXyGxos
         nAIKLjEmXGDStRQEuLQtSZLGte5IGiANqeB+pVHx0G1XqPVE9LCJ0cX4bDNofKi63y4F
         9b2klZrfobA4CjHc4cbt61biiCHlmf+F/5rD781Bs+u12GEH8KfeKkkUlh2bSxQMTgHI
         pqArtUaxl8G7kQN3uEHDm7MeLT7V+VAEI9Yp7awuoDPqyN4XrnhlNKyajr5A4Pt0ZqWt
         SuKLkgMKywAaHAziko2oAS7xreolzPMQ72KZmn6SH+Pye7kuh+CrnuXM2C4HMzv+842U
         JN0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677729196;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ar0XxaRzkCTA8E2JFdUWamlA7+uw4UZJbuAUnYzNZgs=;
        b=oh4ATyLpNQ3Rs2YfNpjLYf+NL/kZ6R05v2/D+gttBPJpd08lFIXcu2ke4Z6w1skcIV
         QwJj+hoAWNk/sHdj/7hhC9WM+ykYTzNFVZsgg0wpJxltQcT1sWEkY6bw/8n+DQRdg9ZJ
         IGJKdXW0CpfAgJ+j3pgdHsNp/szdk7bC+PertBValsh3rnPk7NGJT9xucBctaFQ2gNs0
         RE7sm6SLHbB2sNhN/SMVRDS3G9DXJQzIOdiNY2uVbqoHmqbII4ni4+ywGY502yLfcycC
         YnCC+Itu4UaEBfyniZtYOSEiHiTNj47ujR4pYJKor0hFD0zgmWSQj3nLxkHv0iQp6TTU
         BvZA==
X-Gm-Message-State: AO0yUKWdV87xteY2dFXVx+b7ITFK804nZWURcAt0W8g6K9XRzQmkN68G
        aZX7jIuKNA6/PHD2SlznvpA=
X-Google-Smtp-Source: AK7set9pEhkDcOvNaUZ+nbW1+O1Ffb/lnv60lzghhfXKe7ia18SG2SXQMj5xEMa7VT5QKofHYACHSw==
X-Received: by 2002:a17:902:dad1:b0:19c:d32a:befc with SMTP id q17-20020a170902dad100b0019cd32abefcmr9763318plx.15.1677729195657;
        Wed, 01 Mar 2023 19:53:15 -0800 (PST)
Received: from [192.168.1.108] (ip72-194-116-95.oc.oc.cox.net. [72.194.116.95])
        by smtp.gmail.com with ESMTPSA id i15-20020a170902cf0f00b0019b06263bdasm9220619plg.69.2023.03.01.19.53.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Mar 2023 19:53:15 -0800 (PST)
Message-ID: <c90281a5-ea45-46b1-0bc2-81e543becef5@gmail.com>
Date:   Wed, 1 Mar 2023 19:53:13 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v1] serdev: Set fwnode for serdev devices
Content-Language: en-US
To:     Saravana Kannan <saravanak@google.com>,
        Rob Herring <robh@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>
Cc:     Stefan Wahren <stefan.wahren@i2se.com>, kernel-team@android.com,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230302023509.319903-1-saravanak@google.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20230302023509.319903-1-saravanak@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/1/2023 6:35 PM, Saravana Kannan wrote:
> This allow fw_devlink to do dependency tracking for serdev devices.
> 
> Reported-by: Florian Fainelli <f.fainelli@gmail.com>
> Link: https://lore.kernel.org/lkml/03b70a8a-0591-f28b-a567-9d2f736f17e5@gmail.com/
> Cc: Stefan Wahren <stefan.wahren@i2se.com>
> Signed-off-by: Saravana Kannan <saravanak@google.com>

Tested-by: Florian Fainelli <f.fainelli@gmail.com>

Thanks for the quick fix!
-- 
Florian
