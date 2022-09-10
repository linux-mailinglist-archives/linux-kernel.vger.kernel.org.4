Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 277605B46D0
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Sep 2022 16:34:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229733AbiIJOeU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Sep 2022 10:34:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229730AbiIJOeD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Sep 2022 10:34:03 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8B795301B;
        Sat, 10 Sep 2022 07:33:37 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id pj10so4028643pjb.2;
        Sat, 10 Sep 2022 07:33:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date;
        bh=r9dCl7QhjCZXvtpCmodoTGwKF+jhrQb09rsPLN1AZYY=;
        b=daWbxKwCfJ9fWeKWKg07Zm8xLPXdxLUm626AwPcfeWMcljAT49UkJ2C2lN+G/WaWHB
         KTnBGT+1sVLuwtIS70HjbicpBr0DMv5acelE4db3yNHspPITt0kD+XABdrNEo8o45VDY
         CeuP+dqKcsdq1cHQATRZiAoLttsVQ0J79Ax91bKRIWnRTmua3fxd378a+v+GV36YOGUF
         gk/JT2r7ScBdEQMYkzdBDw9h2GJDAEzf+P4UlLlRCnvtqMuFalG+Gx50CIx6mQrlCZn9
         nx7sB0B6Hf/DVwcpg2s+YR/BSV/9a0obSR7gADiNo3VN7DBhdfF0tBITu737l8yK6iMG
         9a0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date;
        bh=r9dCl7QhjCZXvtpCmodoTGwKF+jhrQb09rsPLN1AZYY=;
        b=i6C9gXkTgloi/A31YJM+eSeTbAQaMChyAq9qbWvZQml4Ob68IkR/rrSIIIJfuckh47
         btbYe5m2sycnPZ94p0maerOMsvnpb+jJGQfHga2DfGaZ8hX+uQdE5JmguSdssVf7Pn7F
         qLTl6qbNGV36kVSq+CMo2sIIT5HrtmEKJG9bCIR/ja/+qTaJ/dInn5V7aCgZYyw8LNKg
         wHp92ZXGBBvyz8UgdjTgiTCv1Kqx5QlX6ITRGIjbaZ+QodDEGVZfyHUpMdb4kb5Y0SJ0
         OFmB0iRJB+WYL+vFwTZY1+h0bkEjQ2MnyINWINx4+EOUUqZioBcaXq3lrniOiiybpOQ0
         Ujvg==
X-Gm-Message-State: ACgBeo0L5i9s5CZGzByRdc5FYc1jZqMYeJ8rXNKZaTGn/j/n2VFVzxxP
        usgSkf7aP4fxYevepjDsclc=
X-Google-Smtp-Source: AA6agR6jTqCa7me4rGP7gL1yUCl5YRTMNspblb2vT1sA0U6ZBNjNZjPx0jIS11Sn2TcCnGKa0KOq+Q==
X-Received: by 2002:a17:902:b106:b0:176:70e2:df21 with SMTP id q6-20020a170902b10600b0017670e2df21mr18841963plr.127.1662820412978;
        Sat, 10 Sep 2022 07:33:32 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id y75-20020a62644e000000b005365aee486bsm1755899pfb.192.2022.09.10.07.33.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 10 Sep 2022 07:33:32 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <7ff5df5b-8816-4454-70d2-656f87d6b970@roeck-us.net>
Date:   Sat, 10 Sep 2022 07:33:30 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 1/2] nvme-hwmon: Cache-line-align the NVME SMART
 log-buffer
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>,
        Serge Semin <Sergey.Semin@baikalelectronics.ru>
Cc:     Jonathan Derrick <jonathan.derrick@intel.com>,
        Revanth Rajashekar <revanth.rajashekar@intel.com>,
        Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>,
        Jens Axboe <axboe@fb.com>, Sagi Grimberg <sagi@grimberg.me>,
        Serge Semin <fancer.lancer@gmail.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220909191916.16013-1-Sergey.Semin@baikalelectronics.ru>
 <20220909191916.16013-2-Sergey.Semin@baikalelectronics.ru>
 <20220910053045.GA23052@lst.de>
From:   Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <20220910053045.GA23052@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/9/22 22:30, Christoph Hellwig wrote:
> I think this will work, but unless we have to I'd generally prefer
> to just split dta that is DMAed into into a separate allocation.
> That is, do a separate kmalloc for the nvme_smart_log structure.
> 
> Guenter, is this ok with you?

Seems to be a bit overkill, but sure.

Guenter
