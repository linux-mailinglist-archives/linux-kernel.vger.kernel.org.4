Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9969466B9C3
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Jan 2023 10:02:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232524AbjAPJCA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Jan 2023 04:02:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232428AbjAPJAA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jan 2023 04:00:00 -0500
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D352813528
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jan 2023 00:59:30 -0800 (PST)
Received: by mail-lf1-x134.google.com with SMTP id b3so41755941lfv.2
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jan 2023 00:59:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=norrbonn-se.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EJMjpZ2ePdq4QsXq5r/GaTYNTcCjHGHNdiTm8AbaYvU=;
        b=kh7H1sgTfLjtAfLKGvuuIC2auIxf2jpKBvP9Arr+XfC1JiASpqc2JmoF+QPbMei0Pm
         1AbmIJ3nqcIS+Nq2BKmL43CxyrSoHCvcRh5y2vJggefT4qCBTK9M2XnrD0bl+wEi3Pbw
         zRxBC6aZu8JaRCRktw8JySXLWPXQwFCVDQKaXDYHpIb8fkBmnxWU4blqHtONg606TIFa
         mGP42tP1dVfJ5FIx3366qAqkuuhcq3pTCujsQ6aejAYopq6+VIqyWLR3Ih+nHY3tJotw
         q6txA5vycRRzLI78EvgXw0dGtHVbZLRQAba/ox+h/dH41u2M8dKdlOznFavpHIEmDPBC
         e8kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=EJMjpZ2ePdq4QsXq5r/GaTYNTcCjHGHNdiTm8AbaYvU=;
        b=GoxBRjb1Dtyqj+iseWetXSL91/+5xBoUaAoHUqr2aEvWhWzHGmuNfucIak8i6QBFm2
         HY5gU08WKBVlR3ZaBrl5pW72ygAVq5PJfJ6FrcG7ik0yrWt1ZZCcyAsO9YtXH9jNZy2z
         TwO76ztp0QUpqVIgtlksZx+dmlQOb4ZLZ2ruGqbZmFiAzLWPu+On9/WE4BxBWsAY1X++
         LstC1edRYQQGs2Wb+TQAtbaP6AaP6rcbeJ0G3OOpxNRZSJFjUfzX3SpD6HqGYsoyHsPU
         1qaduhvy9LvuETrdh/0fykHwzWq5vRdXKfZDW5DElRZEH9jzugJ3moJSKwPwLhTXnB2R
         XE+A==
X-Gm-Message-State: AFqh2kojByj/pokwhDHZ9046/NmgDyuACFeMw1bN10F5j1bIHav9i+yP
        5UEsHkzfpRhs1kzH/MHONKklmOTTLv2G9IpS
X-Google-Smtp-Source: AMrXdXvdJaMwzFYKMK5Bij5tk7QpSVgJtVg1Mfmp2izNKI8aAL/gQtJuNrZ1DXmsPOVQMtRdOxsLKw==
X-Received: by 2002:a05:6512:2308:b0:4b5:6b87:a5ce with SMTP id o8-20020a056512230800b004b56b87a5cemr30341753lfu.46.1673859569205;
        Mon, 16 Jan 2023 00:59:29 -0800 (PST)
Received: from [192.168.1.213] (h-155-4-88-185.A159.priv.bahnhof.se. [155.4.88.185])
        by smtp.gmail.com with ESMTPSA id s10-20020a2e98ca000000b0028837c7a7b7sm2211724ljj.128.2023.01.16.00.59.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Jan 2023 00:59:28 -0800 (PST)
Message-ID: <75a2cb16-9e39-4123-de8e-b846c9b482f0@norrbonn.se>
Date:   Mon, 16 Jan 2023 09:59:27 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Content-Language: en-US
To:     "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>
Cc:     LKML <linux-kernel@vger.kernel.org>
From:   Jonas Bonn <jonas@norrbonn.se>
Subject: vhost-net
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I have a question about using vhost-net with an IFF_TUN device.  I'm 
uncertain about the behaviour I'm seeing which is:

i)  on RX, the descriptor contains no Ethernet header, which is what I 
was expecting
ii)  on TX, the first 14 bytes of the transmitted _IP_ packet are lost; 
if I prepend an extra 14 bytes (zeroes) before the IP packet and extend 
the packet length accordingly, then things appear to work as expected.

In vhost_net_build_xdp() it appears that the userspace packet data is 
copied verbatim to an XDP packet structure that assumes the presence of 
an ethernet header; as such, the IP header is copied into the ethernet 
header area.  I think this accounts for losing the first 14 bytes of the 
IP header...

If I set SO_SNDBUF to something less than INT_MAX, then the XDP path is 
bypassed and transmission of IP packets works.  This means that knowing 
the value of SO_SNDBUF becomes important in the userspace application in 
order to know whether an extra 14 bytes needs to be prepended to the IP 
packet... which is awkward, at best.

For an IFF_TUN device, should vhost-net not be adding an implicit 
ethernet header in _build_xdp()?  Can this be done without backward 
compatibility implications?

Thanks,
Jonas
