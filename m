Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52AE66B5F20
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Mar 2023 18:37:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230013AbjCKRh2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Mar 2023 12:37:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229703AbjCKRh0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Mar 2023 12:37:26 -0500
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCB391DBB1
        for <linux-kernel@vger.kernel.org>; Sat, 11 Mar 2023 09:36:47 -0800 (PST)
Received: by mail-ed1-x534.google.com with SMTP id g10so4172174eda.1
        for <linux-kernel@vger.kernel.org>; Sat, 11 Mar 2023 09:36:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678556144;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=inkmI/Yc55oH+OAgW/G1RQMkGyBxBvxe3t8F6Rn9vUA=;
        b=pHGpBQ073xM2B56EvVGdkyPDPc2e2lY3LZlq3DkqgmHpKoMzrOTG37LsE8XI4w/sQw
         mdWuBiAqqwl/ni9QcB2IYANfjhTKVScmyjinmHlpDPAMczMY4MFlRQKCiu2Qz3IE7pHZ
         O4vYJq0slSj+TYuraVo2VYJALXgswIP4fvY0YwFe1E6whfGGQWjw6GamzeVL0F0BeFTm
         CXuPvhSbluqR2MJ27JNghrZSz4lheJBkldd+U+6nYeQkpW1GlSgQsT77KvAgRzZecQhM
         Fqwmp8DK4Fo0JV/07N2SffV4diUn9KdGD+vmWG6lsWp3hmpcCHm7UH1ulgxRirRJeNtb
         th6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678556144;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=inkmI/Yc55oH+OAgW/G1RQMkGyBxBvxe3t8F6Rn9vUA=;
        b=NRJC8S4jruckaVtsH5rc/DpcKLXKRsjGCaSBmQKVYSimJo0PYSHk+GSSL9FdRh4oxn
         RkNcKZHwr73lEx7E3rfhj0bVnTn225T595OINn0Sswh1eR7yTX/8toHSiRj6TLAtgNqv
         FQJ8E+AJqZUCGa9JqEsV75BGVWMzrjRXo0wbI3172yS0bhMXvkkLTAb3ioCJlZthkHbL
         TMjLtiPf6oefSEv+RAq9iNGowC5Mj1XI7JGf/ywuZlLkW/hKJ0m1fRlka+AKEOGTrwYE
         vCnUWdiDnIVLqBHjvl4QlxB05M3TFdVfLOCfhd6i9jPegptEZARAg19xsPGCAxjHHo1g
         Wfjg==
X-Gm-Message-State: AO0yUKWVsKJ9tIfbRZP0wJlHHF3HCKrwToEIecDq0hynlbUtPu70wwnv
        L8jvqwNjfx2dLT08xsg18C8=
X-Google-Smtp-Source: AK7set+wjuNcDAjxAcSlBFN1Kql0mhZJD7n898URWMUbIbQwCZ7D6krXKc5StYEaRyb8plJ2mAqAaQ==
X-Received: by 2002:a17:906:10c8:b0:8b1:94cc:10b1 with SMTP id v8-20020a17090610c800b008b194cc10b1mr6628865ejv.7.1678556143979;
        Sat, 11 Mar 2023 09:35:43 -0800 (PST)
Received: from [192.168.10.15] ([37.252.81.68])
        by smtp.gmail.com with ESMTPSA id h14-20020a50c38e000000b004fa610895b5sm962679edf.7.2023.03.11.09.35.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 11 Mar 2023 09:35:43 -0800 (PST)
Message-ID: <d5bb5ff0-1102-c7cd-c21b-c3a7f4f31717@gmail.com>
Date:   Sat, 11 Mar 2023 21:35:41 +0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH] 9P FS: Fix wild-memory-access write in v9fs_get_acl
Content-Language: en-US
To:     David Kahurani <k.kahurani@gmail.com>
Cc:     ericvh@gmail.com, lucho@ionkov.net, asmadeus@codewreck.org,
        linux_oss@crudebyte.com, linux-kernel@vger.kernel.org,
        syzbot+cb1d16facb3cc90de5fb@syzkaller.appspotmail.com,
        v9fs-developer@lists.sourceforge.net,
        linux-kernel-mentees@lists.linuxfoundation.org
References: <20230310202619.433269-1-ivan.orlov0322@gmail.com>
 <CAAZOf24yhpSBd1926v7T=qDwqvFfLsWMJeMKTafeZ=69hJ4rdw@mail.gmail.com>
From:   Ivan Orlov <ivan.orlov0322@gmail.com>
In-Reply-To: <CAAZOf24yhpSBd1926v7T=qDwqvFfLsWMJeMKTafeZ=69hJ4rdw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> I'm not sure what are the rules around here but I prefer to use brackets 
> more generously.

I think in this particular case they can just make the code less 
readable (considering they will not change the behavior in any way). 
However, this is eternal discussion and I saw examples of both in the 
kernel sources.
