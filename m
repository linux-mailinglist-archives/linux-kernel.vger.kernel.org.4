Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15753716FFF
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 23:51:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233599AbjE3Vu5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 17:50:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231158AbjE3Vuz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 17:50:55 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 670A4C7
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 14:50:54 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id d9443c01a7336-1b04949e4e9so15654275ad.3
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 14:50:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1685483454; x=1688075454;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qRVnrkfI461qrvcEb8rSb2NenPhq34qymwuOIIwape8=;
        b=EuE5zdMBWfn99VbLUbG01rDj/zB95BmppDynbVaJhhPOmJCCuf+Dx7IyrbEd6xvNGs
         tPWk/ml+xtavbMiLpGhGOZ6tMeOxNUb9AvDHZLi8VenLSgPkMgx7RcHnDJ42h6Rmkej5
         JPEqeudSt72B5cmmpo6EK8/vc8i3qYr12sNMA0CaBxm5Ucr4JLwZwrKqjxKXIn1vjgVe
         5YuB8TSV0a0MYy7G4Nz0ILS6b1C7rBYq4R8mjeBqTwqVJHcT97/p9RK/tzX+e4H9/qkL
         nX6w3EWqgHPPRSwbtro4ZNHeVXC/dzi2NeYgK3KpEKbWejmC7wGg4J00ygNFMOkdVGgL
         Pkqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685483454; x=1688075454;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qRVnrkfI461qrvcEb8rSb2NenPhq34qymwuOIIwape8=;
        b=ihe/nj5VYqHu6EjOnhCthJYxMuwhWQ7a7WWhT0pyoP+nFlMTfiZ51Pdf6kWScm9AGz
         +PPT5sGD5zjcBsgMlZkbjJNNJgw6YNDgB6rukf8VNI267Mri/LPuQbc+nOIk0pgm5Ul7
         RxrqrPWQmqlOqKrTlhqgrltEfxUJWJY+Tf9ZkqaGcC0SklIyICLaPZbpSaLX0abYCyqj
         yE1s9QqtZWEInezrl+fqzf1S7/pURI7v0e1wds9ouCccv/4A4pTWbz298dQ99Hquaoe8
         x9GnSulY910S/XYoQdIvkzeuMYUJY8p6HqrTlS9s24UNV8JakgQW+NNyuBnhae+/YX/k
         O3Dw==
X-Gm-Message-State: AC+VfDz6s0pLenmkX4PtGZEFc2RNXIvPUBVLC7fKOIkc1t8qdu4mIYj4
        n+k6fCrmE42NP08u0euhdqZdRA==
X-Google-Smtp-Source: ACHHUZ5jkxi5ZAPfXlloWvkLRbdfPHSORs9oJxc2QrDTfifJfdAy4R9ZP/5z1PJeb4q56ovXAhjToQ==
X-Received: by 2002:a17:902:e545:b0:1b0:f727:bc41 with SMTP id n5-20020a170902e54500b001b0f727bc41mr960902plf.42.1685483453720;
        Tue, 30 May 2023 14:50:53 -0700 (PDT)
Received: from [192.168.60.239] (124.190.199.35.bc.googleusercontent.com. [35.199.190.124])
        by smtp.gmail.com with ESMTPSA id m18-20020a170902db1200b001aae64e9b36sm10754865plx.114.2023.05.30.14.50.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 May 2023 14:50:53 -0700 (PDT)
Message-ID: <b1d1c907-406a-57bd-daf5-4366f8714cad@google.com>
Date:   Tue, 30 May 2023 14:50:52 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v4 1/2] usb: gadget: udc: core: Invoke usb_gadget_connect
 only when started
To:     Badhri Jagan Sridharan <badhri@google.com>
Cc:     Francesco Dolcini <francesco@dolcini.it>,
        Alistair <alistair@alistair23.me>, gregkh@linuxfoundation.org,
        stern@rowland.harvard.edu, colin.i.king@gmail.com,
        xuetao09@huawei.com, quic_eserrao@quicinc.com,
        water.zhangjiantao@huawei.com, peter.chen@freescale.com,
        balbi@ti.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Linux regressions mailing list <regressions@lists.linux.dev>
References: <20230407030741.3163220-1-badhri@google.com>
 <0cf8c588b701d7cf25ffe1a9217b81716e6a5c51.camel@alistair23.me>
 <1ac16f0a-3cca-40ca-c444-82719f85a24c@leemhuis.info>
 <ZGStr1oZvmJ0XzSu@francesco-nb.int.toradex.com>
 <53213ba8-be58-0f97-8a06-3c9380bdff53@leemhuis.info>
 <CAPTae5Lz=efNKhCnoy6Hp78HFqCLqxtWdZQ7zSDx2omeYf2KDw@mail.gmail.com>
Content-Language: en-US
From:   Avichal Rakesh <arakesh@google.com>
In-Reply-To: <CAPTae5Lz=efNKhCnoy6Hp78HFqCLqxtWdZQ7zSDx2omeYf2KDw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-17.7 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/17/23 10:45, Badhri Jagan Sridharan wrote:
> Keeping the thread updated. I sent out
> https://www.spinics.net/lists/kernel/msg4792009.html few hours earlier
> and have requested help from Francesco, Alistair and others who
> reported the issue.
> Discussing with Alan stern on the feedback he had left.
> 

Tangential to the original issues: it looks like patch 2/2 also
breaks gadget functions that sets `bind_deactivated` to true.

When usb_gadget_connect is called while the gadget is deactivated from
functions binding, it sets gadget->connected to true, but does not call
the pullup function. Later, when the gadget function calls
usb_gadget_activate which in turn calls usb_gadget_connect, the pullup
function isn't called because gadget->connected is true.

- Avi
