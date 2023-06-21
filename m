Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8B1C7389F6
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 17:43:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233799AbjFUPnC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 11:43:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233705AbjFUPmq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 11:42:46 -0400
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32116E68;
        Wed, 21 Jun 2023 08:42:24 -0700 (PDT)
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1b50e309602so47944165ad.0;
        Wed, 21 Jun 2023 08:42:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687362122; x=1689954122;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FTJzUZXq823ZXnmLS5AS4rZZIfTqatFrJY6YpC4QzpE=;
        b=BoocG/dCUaNbOvH580ePfIw424DALlxJpTkKvSEKXH7mR7tpaLzPk1+JLpVttUy2t6
         LM7wGbHTwWpJLJRExnC9fMrO2Kcx23CnQ2ZTOykU+vllB8pjhJdgDJtVFrSf/oa6TYaL
         /EKD/HrhztwjLJ+vbpeHyVyMnUh6aoRKFROsTiWzgrutzI2LVG+SvRHl5qTBV5RwqO7X
         Qbf8M0DTwmKwxImUsRx7JEnkCxYmuiJF3P5kgCw7IOhZkhe+RYoEU5pLYKkqpTZtK3bH
         E7ORuuNs7H8PTdXFer2Mn1C3ck7GM7NWr2yuGw73zqLcFskL2FsYpPwsgNna4VbZFJqI
         ClXQ==
X-Gm-Message-State: AC+VfDzFoYTRdPW6EntrmsGNkyaAm2o3t77CHtexfASIQZXua5coZ+xG
        W0lYKL6cf4+DR+HVNSXCQAc=
X-Google-Smtp-Source: ACHHUZ75AgZuplMcSb1kEuUFuGEsTg5FBp+Eusurp/PRz9+EQrBqDaV+XQmO0a4stt8z/TTWglepIQ==
X-Received: by 2002:a17:903:1108:b0:1b0:2d08:eb51 with SMTP id n8-20020a170903110800b001b02d08eb51mr19783283plh.12.1687362122342;
        Wed, 21 Jun 2023 08:42:02 -0700 (PDT)
Received: from ?IPV6:2620:15c:211:201:9bb2:be1e:34e3:7c45? ([2620:15c:211:201:9bb2:be1e:34e3:7c45])
        by smtp.gmail.com with ESMTPSA id u9-20020a17090341c900b001ac741dfd29sm3637788ple.295.2023.06.21.08.42.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Jun 2023 08:42:01 -0700 (PDT)
Message-ID: <debdc47a-c377-e457-5643-415d93ced54a@acm.org>
Date:   Wed, 21 Jun 2023 08:41:58 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
From:   Bart Van Assche <bvanassche@acm.org>
Subject: Re: [PATCH] docs: target: Convert tcm_mod_builder.py print syntax to
 python3
To:     Rong Tao <rtoax@foxmail.com>, martin.petersen@oracle.com
Cc:     rongtao@cestc.cn, Jonathan Corbet <corbet@lwn.net>,
        "open list:SCSI TARGET SUBSYSTEM" <linux-scsi@vger.kernel.org>,
        "open list:SCSI TARGET SUBSYSTEM" <target-devel@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Mike Christie <michael.christie@oracle.com>
References: <tencent_F3895D0EA868BCCE8C56221619BC093D660A@qq.com>
Content-Language: en-US
In-Reply-To: <tencent_F3895D0EA868BCCE8C56221619BC093D660A@qq.com>
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

On 6/21/23 00:33, Rong Tao wrote:
> diff --git a/Documentation/target/tcm_mod_builder.py b/Documentation/target/tcm_mod_builder.py
> index 54492aa813b9..e2ef72925de3 100755
> --- a/Documentation/target/tcm_mod_builder.py
> +++ b/Documentation/target/tcm_mod_builder.py
> @@ -20,7 +20,7 @@ fabric_mod_port = ""
>   fabric_mod_init_port = ""
>   
>   def tcm_mod_err(msg):
> -	print msg
> +	print(msg)
>   	sys.exit(1)

How about deleting the file Documentation/target/tcm_mod_builder.py? I
don't think anyone is using this script. Additionally, it takes effort
to keep this script in sync with the rest of the SCSI target code. I'm
not sure anyone is interested in maintaining this script.

Thanks,

Bart.
