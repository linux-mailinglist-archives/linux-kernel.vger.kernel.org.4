Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7070D5F1151
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Sep 2022 20:04:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231695AbiI3SEo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Sep 2022 14:04:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231426AbiI3SEj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Sep 2022 14:04:39 -0400
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BAD21CC;
        Fri, 30 Sep 2022 11:04:33 -0700 (PDT)
Received: by mail-pj1-f41.google.com with SMTP id a5-20020a17090aa50500b002008eeb040eso7426625pjq.1;
        Fri, 30 Sep 2022 11:04:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=z6h56ttOnD5XpiV4jB5m9Kwfr3sY8gjzhabJaOrR6dk=;
        b=6RXCanBf+JIIWJ4c8cjX1g2ywy8h4Cqwo2Sh8ifUhhpx9h/f6TWVh0ff9BMth7SUIe
         Rdsc8A01/a0QRoL/uowFTr9prYBjcWOSDFT7RM5jvVBhh0qZMRUSVEl3LQgUo1cJ3HPm
         YGtvghzTQTf5Ct6A4wJ+zjN+DsCHM0aBOO0foWfDCAD8vbuBn3eUIGX9+fYIEcL3Np4L
         hZb9PSevqhWynMEFeyVTGscRZxxnC95qqKTV9KN0zgK7F9asmaaNMaojOqjMaCTYkizF
         W6eN0Tpg+v4+qTb+gEvPUJkFMbKN5sUO/5QVDgCRvbV7oeAI1Wf4FWIfHzTil/Db7vio
         Ntaw==
X-Gm-Message-State: ACrzQf2X8edXy+e0oVjcxv9G4rDFJMwMJd02/x3i/NfgzG8fg6Mlp544
        qisCVXmkZ6KOCQBYEJ3xjFw=
X-Google-Smtp-Source: AMsMyM4WIeGABb8iJNPkzRr2/j6sqiBPmdHl8F9XRdpsSZ2yo1kNNX0KrvvG7O80njFyHid7yqe0PA==
X-Received: by 2002:a17:90b:3c02:b0:205:fb96:1779 with SMTP id pb2-20020a17090b3c0200b00205fb961779mr14025622pjb.168.1664561072548;
        Fri, 30 Sep 2022 11:04:32 -0700 (PDT)
Received: from ?IPV6:2620:15c:211:201:56f2:482f:20c2:1d35? ([2620:15c:211:201:56f2:482f:20c2:1d35])
        by smtp.gmail.com with ESMTPSA id n16-20020a170902f61000b0017691eb7e17sm2151417plg.239.2022.09.30.11.04.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 30 Sep 2022 11:04:31 -0700 (PDT)
Message-ID: <8754e66c-d696-75a7-dca3-770dd7e2030b@acm.org>
Date:   Fri, 30 Sep 2022 11:04:29 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH] scsi: ufs: Remove unneeded casts from void *
Content-Language: en-US
To:     Markus Fuchs <mklntf@gmail.com>, jejb@linux.ibm.com,
        martin.petersen@oracle.com
Cc:     alim.akhtar@samsung.com, avri.altman@wdc.com,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
References: <20220928222241.131334-1-mklntf@gmail.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20220928222241.131334-1-mklntf@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/28/22 15:22, Markus Fuchs wrote:
> The end_io_data member of the "struct request" type has type "void *", so no
> cast is necessary.

Reviewed-by: Bart Van Assche <bvanassche@acm.org>
