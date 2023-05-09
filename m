Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C40086FC162
	for <lists+linux-kernel@lfdr.de>; Tue,  9 May 2023 10:10:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234914AbjEIIKg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 May 2023 04:10:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234775AbjEIIKO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 May 2023 04:10:14 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3A1E10A3B
        for <linux-kernel@vger.kernel.org>; Tue,  9 May 2023 01:09:31 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id ffacd0b85a97d-3077d134028so2763707f8f.3
        for <linux-kernel@vger.kernel.org>; Tue, 09 May 2023 01:09:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=6wind.com; s=google; t=1683619770; x=1686211770;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:reply-to:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=35hz8Z/xg13fLArl/ZpQL1D9nkPqIFjBwfYdZ4iTcWE=;
        b=FBTDi2ltieFeWR4F7Bqmksllkp/RkmAHmlLmMzX3uRBu368LlWtbIgAT2nO78qiar0
         6l2b7PWkoZDr1IS8mb1CzfkLhq0St+5GPbyn6Gre0LtmheOtGHpKF+Vf5D6Yw/XO1yRI
         HyO4agmF3QXzfhM55+gKZ2PMAfticdVI6glM+IvvXxpNTdEPu2SFJfN0/IzfGpQwudYy
         YOcr1joFP6vOKOOzhT4d8fyUP3TThAVMtDeY4XSWMG9YaJRp2pfGmK4JweFRXpwxCsht
         qPs3y9ILEd+L1gjUWOJhQoWZbfW11sVb73A+YD8ytJ43j3vbwDjWuVTSrrHNnrLn0FcU
         Nqcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683619770; x=1686211770;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:reply-to:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=35hz8Z/xg13fLArl/ZpQL1D9nkPqIFjBwfYdZ4iTcWE=;
        b=R/RK5h7nfR63tSRDvJzDsI1Rq5hnhpI6heMAtFmYjUB2IiR45QIh6YLCrtPuTk+muV
         Y624ehheMxUp8zFfqJ+R3J6d/XN6lGi8QLp0s7yR6Occq3Q56NIgtW7OY5RB3TNJOzw4
         Oe2kG9bDfL5Td63RCmaW2gyjb9m7c+i/J9Sg7bHC51rJmZozlGXAS887yB4FUwIVDqhd
         MHLH76tNrpEvGPy3U0DqqHo0RayEHH9ahnHa9X320+7wxZkZ4iK1/n9iXXcB8Hc0sKCx
         uR0MYrcu8p5hrIbqxCOKtsdbpOeiwsc5/ZLotii57+nM91CxP8em6ifk9q0sdB9HQMee
         gZxQ==
X-Gm-Message-State: AC+VfDxJA2ZnJUQeb+4dElRDflADVsgfImh1Q/7G6aGIuz7zY5Q2ymkG
        AFdA3bPvQxAaU+xF+yhyo+4Cvw==
X-Google-Smtp-Source: ACHHUZ41zaLLbqDPhGTqV1B1hfpw5WfoRyJ+bKOqP44pQRQ67htlS7LMy1WFW3Xcy6ulRUXHQRJMNg==
X-Received: by 2002:a5d:4344:0:b0:2f5:fbe5:bb1c with SMTP id u4-20020a5d4344000000b002f5fbe5bb1cmr8448658wrr.63.1683619770158;
        Tue, 09 May 2023 01:09:30 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:b41:c160:60c6:b628:2847:4133? ([2a01:e0a:b41:c160:60c6:b628:2847:4133])
        by smtp.gmail.com with ESMTPSA id c15-20020adfed8f000000b003047f7a7ad1sm13594025wro.71.2023.05.09.01.09.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 May 2023 01:09:29 -0700 (PDT)
Message-ID: <172df925-48ae-bc25-81fc-a2d6b39b8739@6wind.com>
Date:   Tue, 9 May 2023 10:09:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Reply-To: nicolas.dichtel@6wind.com
Subject: Re: [PATCH v11 8/8] vhost: use vhost_tasks for worker threads
Content-Language: en-US
To:     Mike Christie <michael.christie@oracle.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Christian Brauner <brauner@kernel.org>
Cc:     hch@infradead.org, stefanha@redhat.com, jasowang@redhat.com,
        mst@redhat.com, sgarzare@redhat.com,
        virtualization@lists.linux-foundation.org, ebiederm@xmission.com,
        konrad.wilk@oracle.com, linux-kernel@vger.kernel.org
References: <20230202232517.8695-1-michael.christie@oracle.com>
 <20230202232517.8695-9-michael.christie@oracle.com>
 <aba6cca4-e66c-768f-375c-b38c8ba5e8a8@6wind.com>
 <CAHk-=wgadfsCnKHLON7op=Qs5t3w3PVz5ZDbvbKsfb=yBg=yjQ@mail.gmail.com>
 <78c5e150-26cf-7724-74ee-4a0b16b944b1@oracle.com>
From:   Nicolas Dichtel <nicolas.dichtel@6wind.com>
Organization: 6WIND
In-Reply-To: <78c5e150-26cf-7724-74ee-4a0b16b944b1@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le 06/05/2023 à 00:37, Mike Christie a écrit :
[snip]
> (Nicolas, I confirmed it fixes the 'ps a' case, but couldn't replicate the 'ps'
> case. If you could test the ps only case or give me info on what /usr/bin/example
> was doing I can replicate and test here):
With you patch:
$ ps a
  PID TTY      STAT   TIME COMMAND
  191 ttyS0    Ss     0:00 /bin/sh -li
 1255 ttyS0    SLl    0:53 /usr/bin/example
 1742 ttyS0    R+     0:00 ps a
$ ps
  PID TTY          TIME CMD
  191 ttyS0    00:00:00 sh
 1743 ttyS0    00:00:00 ps

This fixes the regression on our side, but now, 'example' is not displayed
anymore with 'ps'.

Thank you,
Nicolas
