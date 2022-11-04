Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3561619491
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 11:38:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231769AbiKDKiK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Nov 2022 06:38:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231610AbiKDKiE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Nov 2022 06:38:04 -0400
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE72726547
        for <linux-kernel@vger.kernel.org>; Fri,  4 Nov 2022 03:38:02 -0700 (PDT)
Received: by mail-il1-f198.google.com with SMTP id 15-20020a056e0220cf00b0030099e75602so3532459ilq.21
        for <linux-kernel@vger.kernel.org>; Fri, 04 Nov 2022 03:38:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xwwbHVqJA6b/WaoXynWZOPz9nibzpmlhsBICyuCZYx0=;
        b=xRBSrOK7E6ziIRv5BD1mORycdUBWi4f9UE5o7M4qlZB2HuqOrMnXTMKbUBlOgAa4+/
         4r8co13r01FKxTIMSCA8ZrY6Mjf90g3Y4ApQooIJdCKZfE9RZ7I1bgXynDngPhsm+qc8
         Z1X4Ag1vADXYORgqG6uPurNK9qFBs5gNXXVxSotQxxubp9X/RU/Cmunn+bHMzhMFeNF/
         uKE2QMNg57TOJmJkC1L88QgQ6u9jl4NINgujgrjgAuRUlFDq5uZJ075GNtUYfs9EIBQF
         1ZoINrmmlKDKb2BWRrzWikrPUsidFofUO+EKmFB8W3UQFbiZyMvBEH9gep+8f0IvaYik
         y4LA==
X-Gm-Message-State: ACrzQf3ZoZfYBa72cfwYpjira9FG8ldtfycVLpkKWPNLZW+Grf+L/Q46
        m6i8RMvbpZt+694jEvFOj35oSusnoyFYEs+WyhVwV7LVSUmW
X-Google-Smtp-Source: AMsMyM5tBYbEB/tIc1vyNY36bmsMJqJ4+y57wYe1YbRmlCCFcmHl14cXR1t5a3eyIjn37px1nw/ITPfPHm9L2fdsV/7f2uMV78FJ
MIME-Version: 1.0
X-Received: by 2002:a6b:6010:0:b0:6d6:e9b0:5d2a with SMTP id
 r16-20020a6b6010000000b006d6e9b05d2amr2776731iog.198.1667558282167; Fri, 04
 Nov 2022 03:38:02 -0700 (PDT)
Date:   Fri, 04 Nov 2022 03:38:02 -0700
In-Reply-To: <CAG_fn=WhGa21EVCPNFp6BO3=CMzHFYNfwpXK+S0m6oxPr9xdrg@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000000d0b9b05eca2ab68@google.com>
Subject: Re: [PATCH] ipv6: addrlabel: fix infoleak when sending struct
 ifaddrlblmsg to network
From:   syzbot 
        <syzbot+3553517af6020c4f2813f1003fe76ef3cbffe98d@syzkaller.appspotmail.com>
To:     Alexander Potapenko <glider@google.com>
Cc:     davem@davemloft.net, dsahern@kernel.org, glider@google.com,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        yoshfuji@linux-ipv6.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>>
>> This patch ensures that the reserved field is always initialized.
>>
>> Reported-by: syzbot+3553517af6020c4f2813f1003fe76ef3cbffe98d@syzkaller.appspotmail.com
>
> My bad, should be:
>   Reported-by: syzbot+fa5414772d5c445dac3c@syzkaller.appspotmail.com

I see the command but can't find the corresponding bug.
The email is sent to  syzbot+HASH@syzkaller.appspotmail.com address
but the HASH does not correspond to any known bug.
Please double check the address.

