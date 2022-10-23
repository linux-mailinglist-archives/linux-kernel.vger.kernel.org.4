Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A08A16091B5
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Oct 2022 09:48:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230022AbiJWHsJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Oct 2022 03:48:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229610AbiJWHsH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Oct 2022 03:48:07 -0400
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45E4E6D540
        for <linux-kernel@vger.kernel.org>; Sun, 23 Oct 2022 00:48:05 -0700 (PDT)
Received: by mail-wr1-f44.google.com with SMTP id a14so8184746wru.5
        for <linux-kernel@vger.kernel.org>; Sun, 23 Oct 2022 00:48:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=u4cEua3dqzOA/JMmEvNuxV14qAoFZ+U73JfDUS5Yf+uoatHv9BtEYqyX2UeH935TkO
         hsWDnWXnR597Z/N3noL9yU50cenQ5xSNXpmpfjl5Kj9GxKDDUbDw6wykcp7bChIGIG9W
         rekhJPay7QlrHytsTOaeroLMS9qjwUZz/fHOsfS/qfVYESRLVbVXZy29PV8AoLuHaHow
         zuqnASgoyfaQGsVxNNRFCpRiUExJLnV39nLvatqr7RBEE02uM5A+sPltp4al75SeLeP2
         FDrsb1KnC1OIzUSymrPga15q5JmDHEytNBHOht0WE6fambvQqlAmVcwbqqU+fpl62HPO
         5ZiQ==
X-Gm-Message-State: ACrzQf0kTUb/+/Y2cwdYl0XHu6ZRrVDEJzpr+7xXqL6xB/27S1pYhdil
        HapTYlqH8OwLZukNjYwaiiiKHGaad8k=
X-Google-Smtp-Source: AMsMyM5XSFqzw73AwdvbcrxsFx7bjgI89kEENwwOnUkZ+nl8/6H3qwUWSB9/FwIN3fAnvurisUVgzg==
X-Received: by 2002:a05:6000:1e07:b0:236:759:929d with SMTP id bj7-20020a0560001e0700b002360759929dmr10627230wrb.199.1666511283779;
        Sun, 23 Oct 2022 00:48:03 -0700 (PDT)
Received: from [192.168.64.53] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id bj19-20020a0560001e1300b002238ea5750csm7233376wrb.72.2022.10.23.00.48.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 23 Oct 2022 00:48:03 -0700 (PDT)
Message-ID: <788e164a-4825-e273-d40d-4dd67e1b55d3@grimberg.me>
Date:   Sun, 23 Oct 2022 10:48:01 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH] nvme-tcp: replace sg_init_marker() with sg_init_table()
Content-Language: en-US
To:     Nam Cao <namcaov@gmail.com>, kbusch@kernel.org, axboe@fb.com,
        hch@lst.de
Cc:     linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20221022174635.15643-1-namcaov@gmail.com>
From:   Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20221022174635.15643-1-namcaov@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,TVD_SPACE_RATIO autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
