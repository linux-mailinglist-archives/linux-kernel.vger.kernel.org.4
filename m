Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 166666461ED
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Dec 2022 20:57:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229713AbiLGT5o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Dec 2022 14:57:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229752AbiLGT53 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Dec 2022 14:57:29 -0500
Received: from mail-yw1-x112b.google.com (mail-yw1-x112b.google.com [IPv6:2607:f8b0:4864:20::112b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FCD87616E
        for <linux-kernel@vger.kernel.org>; Wed,  7 Dec 2022 11:57:25 -0800 (PST)
Received: by mail-yw1-x112b.google.com with SMTP id 00721157ae682-3b56782b3f6so197843167b3.13
        for <linux-kernel@vger.kernel.org>; Wed, 07 Dec 2022 11:57:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:sender:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aX8dUQRtFkXXMjfbTbbfrNQqglctFU+dpWydQ5KKVSo=;
        b=Yqnr3JtGLYi76vfgKeN7hD6TKXnOFW3Ymz7zwdGx9tItwoif3Nst0ktsS8MlGkf7UU
         6xwO4bpDhg+BCFZiEKrLyUfz3imwMDm0KgjGRp+b8sgdkkw+chsq/3jLyPuTDpvh/s81
         ChKq1UHEeZJilX/QVFC5YJH5kBOrlDlZM1i1oCeHBT8C7Nsktvge15j5AvjS8AijdjFy
         rqeHCpNPCTIwNA1RfNcrIf6E7R09434DTD9Z0v0kIKNuhJgKbOTSBPdrKsjgTpTNhISC
         0G0PUc+j2azY6beOxzptuNj9ptgkdH9SpE7hcblP8vEKtPG9N5KlGAWb9vIsXRMoM9nk
         pY4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:sender:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aX8dUQRtFkXXMjfbTbbfrNQqglctFU+dpWydQ5KKVSo=;
        b=b+ORTttrB4aXFYW1My7wnf1aHiz/IJOsO2SP7wnSoTa0wj7gcxycsyPndWO0yo+4rp
         msFdqGD+wnitBjq6JDVVyiChvb5c8bpYpfWPNng3K4Is0x9L3GKeIf9LDPLk/fcGogM+
         ytwqoRuVD760WPLjhYM35wyt26gDItmKGh+RtT0kY9MjsTYKtYToXpyFipeujvPpj4UO
         qYzeDLwOHckdSOD8XfY6jZrMrQ4giX0Uw20RQMvIQe5hims+ISOTmtX9Jned8nBErVjz
         YgDrK/pj91F5ytMAvfCDghU7/3Jpp6kJwRtu3B5LXdjh/wtNqdUGSGdkr9xu0AGqqFTI
         IdXA==
X-Gm-Message-State: ANoB5plTqY2LwPJBWG9JDeyKj+9FQ8YjBXfA/5YOpVDbMmNudTDkaito
        SqSdqwxN3OgEPlSvCfd8bw2k29f6v3BtWYMduPQ=
X-Google-Smtp-Source: AA0mqf79xjl3Qt2wTOcP7xOn5XCnmnKyNvfutfp25ACJTFgQlrQUntglZ17F7SlcR91CJJkuhrYTzSH8A1bLarQXiZY=
X-Received: by 2002:a0d:f741:0:b0:3aa:ab1d:b9c4 with SMTP id
 h62-20020a0df741000000b003aaab1db9c4mr3635825ywf.388.1670443044645; Wed, 07
 Dec 2022 11:57:24 -0800 (PST)
MIME-Version: 1.0
Sender: wassibi12@gmail.com
Received: by 2002:a05:7010:111:b0:316:4d7f:d83 with HTTP; Wed, 7 Dec 2022
 11:57:24 -0800 (PST)
From:   Tomani David <davidtomani24@gmail.com>
Date:   Wed, 7 Dec 2022 19:57:24 +0000
X-Google-Sender-Auth: HZZU8ncFkeP72cS17r1vrcJX84A
Message-ID: <CAGZUqcQyw0c_zu5Lo-EREf6PhbEi95oD-4kLA5HWrEpCzunH2A@mail.gmail.com>
Subject: Opportunity
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.9 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Good evening,

My name is Mr. David Tomani, I'm Operations Director, and I have a
proposal for you.


Regards,
Mr. David
