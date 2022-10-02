Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A913C5F2251
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Oct 2022 11:25:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229713AbiJBJZb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Oct 2022 05:25:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbiJBJZ2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Oct 2022 05:25:28 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 520463BC76;
        Sun,  2 Oct 2022 02:25:26 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id v10-20020a17090a634a00b00205e48cf845so12831767pjs.4;
        Sun, 02 Oct 2022 02:25:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:subject:from:reply-to:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date;
        bh=RS87/OMI0Aoi7/wAWBy+a2IoLMxK46Hso1++35Znhl4=;
        b=Xd9E8KCVc+gQe+SAizBHsD8rOuIuiI5Yl4lsFTaYIKrY+E/HLGZpHAWZTKH3d7RVv+
         /85plcy6Sy5cSCW8iY5Q0VUUUH1eZpSbwf+kLgwzvy22I0c41oZMjxph4TdL/Zdg6rab
         yWwOrlRlAsVkRDgQXU06kxdbVrKsnockFt4uQs31BM5vgnSPaxRMXwGUlVHeqvnnsdqW
         DKb4VGfN3bAvOEyi2Z/15MmdZDTVa8mhtbcXCWrmpNxqwhbcCNe2WbLyqBKwAJFhwVE0
         1PSOtInKf7SwWBVXsBh/d5QXfysYZEY2zZ+p6GSb9oKnDvnndz4MxNslV4PagqkgQUQM
         xeJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:subject:from:reply-to:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date;
        bh=RS87/OMI0Aoi7/wAWBy+a2IoLMxK46Hso1++35Znhl4=;
        b=121fn7EqjaWFVSKDGFO4vjnzFlTsdbZQ8iF+5MyiCzWvY2IaLfBQn52zE0WFt/C9XB
         Z3zNcOZ/vK97fyYdlofDR8UZ0KqxQfk0o/qsgExZjErk/9HVhaf0/9mja8JRDOEjExqO
         uhCg31ghXp1FZ+XL3sje+xUF784qtpgVDkAk/1VLo9P9bwy/z8kEjrsy0zvcBbJPKVwO
         qCQdbF4F1p+cYvoLdH0jY7yJiGn7cTnZbPrFzgkgjinxJuJuvUi90n36V9DSChPtjGnR
         xNnXCydmZhLPyhV06rHgm8Hd9DVIZm218uUNId3lheUR5J3R3ARwvqPjtNBczjwh3E02
         e6kQ==
X-Gm-Message-State: ACrzQf2T7EwAnPXo91mdF4kQaDmTEja1c7FtXrWaGh5UOIR56Lwi3Ame
        38551tBzl0IuQmcFvpLZnUoP+X6eQ8uSVA==
X-Google-Smtp-Source: AMsMyM5LLcpVOhf6oryT2wAIYU90Ivuuut50G6j2/hpb5ypDf/R6oQcPRspE6I+EH6qQ5ClXS0/2Qg==
X-Received: by 2002:a17:90b:2246:b0:205:97a5:520e with SMTP id hk6-20020a17090b224600b0020597a5520emr6817538pjb.244.1664702725736;
        Sun, 02 Oct 2022 02:25:25 -0700 (PDT)
Received: from [192.168.0.110] ([103.159.189.149])
        by smtp.gmail.com with ESMTPSA id l18-20020a170903121200b0017a8aed0a5asm5088377plh.136.2022.10.02.02.25.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 02 Oct 2022 02:25:25 -0700 (PDT)
Message-ID: <3b7a3398-0826-04de-f805-c926b39e7d35@gmail.com>
Date:   Sun, 2 Oct 2022 15:25:21 +0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Content-Language: en-US
To:     konishi.ryusuke@gmail.com, linux-kernel@vger.kernel.org,
        linux-nilfs@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        syzbot <syzbot+b8c672b0e22615c80fe0@syzkaller.appspotmail.com>
Reply-To: 000000000000219dcd05e9f95ed9@google.com
From:   Khalid Masum <khalid.masum.92@gmail.com>
Subject: Re: [syzbot] KASAN: use-after-free Read in nilfs_segctor_confirm
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

The reproducer triggers the same bug in upstream 6.0-rc7 as well.


Thanks,

   -- Khalid Masum

