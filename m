Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43D7A73CDD3
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Jun 2023 03:36:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230169AbjFYBgZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Jun 2023 21:36:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229537AbjFYBgX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Jun 2023 21:36:23 -0400
Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com [209.85.167.169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE09BE5F;
        Sat, 24 Jun 2023 18:36:22 -0700 (PDT)
Received: by mail-oi1-f169.google.com with SMTP id 5614622812f47-39ecf031271so1739778b6e.1;
        Sat, 24 Jun 2023 18:36:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687656982; x=1690248982;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6QES8iPVEs5Vp3VQZYa61QQkFQNBLSrnWKF7w6PAZtA=;
        b=QG6FKqHYaoaONGGum/fcu/e23BgVbvLri3Btc7WrsT4pzp6FaPk5kZuw4WiGbTFuyO
         oAX7EcYng4AVlja/R20qngrLmr5QXYtfUPa4+djzwKJHJrREc221CTfeel8K/r6r1Bwf
         UPwmeYsITKN/TwDnusHennjGR4z14ijhp0/7ak6u+Eq2EbiZwmHka+3/hhfvrtLPRFWN
         didqUCOwKEj5V8ZQhmJupJ1ds3mq+qT2Mq0dAfr3pQhl4v699wyRP49Z0cifkDwWvFq7
         sAAtZr72K08srKUER+29F6uoWzn8enTdLtQUUWCF4W51HJeN2UVzDGkyGxXC23tELPXX
         AzYQ==
X-Gm-Message-State: AC+VfDy3WZ8WPXGYZ+//jUSHtStl1YwaJMukD39M1W0I+Q/ZMDOY+rEF
        h6AGf3kVdMg+brubOAEVpnlsdXtH5xc=
X-Google-Smtp-Source: ACHHUZ4It5O46YdG9BmcmgbA5yUzsHMVPQoRSR1CkNrQcEXwpZtIfr57LBj3oN85Na3xYuxKaULfQg==
X-Received: by 2002:a05:6808:ec3:b0:39e:b58c:13d5 with SMTP id q3-20020a0568080ec300b0039eb58c13d5mr28074938oiv.17.1687656982135;
        Sat, 24 Jun 2023 18:36:22 -0700 (PDT)
Received: from [192.168.3.219] ([98.51.102.78])
        by smtp.gmail.com with ESMTPSA id x42-20020a056a000bea00b0066f37665a6asm690494pfu.117.2023.06.24.18.36.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 24 Jun 2023 18:36:21 -0700 (PDT)
Message-ID: <83fcf19d-b9a1-5369-d8f0-d80e00ae8dfd@acm.org>
Date:   Sat, 24 Jun 2023 18:36:19 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v2] docs: target: Remove useless tcm_mod_builder.py
Content-Language: en-US
To:     Rong Tao <rtoax@foxmail.com>, martin.petersen@oracle.com
Cc:     rongtao@cestc.cn, Jonathan Corbet <corbet@lwn.net>,
        "open list:SCSI TARGET SUBSYSTEM" <linux-scsi@vger.kernel.org>,
        "open list:SCSI TARGET SUBSYSTEM" <target-devel@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
References: <tencent_E3643D5F0AA8CCBEF28C6A233A18B808CD0A@qq.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <tencent_E3643D5F0AA8CCBEF28C6A233A18B808CD0A@qq.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/24/23 17:50, Rong Tao wrote:
> This script is not used and requires additional development to sync with
> the SCSI target code.

Reviewed-by: Bart Van Assche <bvanassche@acm.org>
