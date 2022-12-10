Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBD576490BE
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Dec 2022 21:54:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229791AbiLJUyd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Dec 2022 15:54:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229779AbiLJUyW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Dec 2022 15:54:22 -0500
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AC5717403
        for <linux-kernel@vger.kernel.org>; Sat, 10 Dec 2022 12:54:22 -0800 (PST)
Received: by mail-pl1-x636.google.com with SMTP id d7so8290547pll.9
        for <linux-kernel@vger.kernel.org>; Sat, 10 Dec 2022 12:54:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:reply-to:subject:mime-version:from:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PYwkHxpnQAf/j6hVbOuHsfpcNTzM4x9BQKZcSB0Ugdw=;
        b=VQOVrBc3whsqzQdmIGb3w6mZn+yw8EYZ5hoDTseNRsqQk3oYPEwDgtJxdfR601CGum
         toJevVE9PJWkWkaNhtU6z880IqQjmNHMWh8+xbuTBZOOsxbT9V1l6gvRMIjrqxqzX1Ra
         nCIJzhXi8CtpanxDGhgYMSgjkbx/pxQ7OdbWzH2uE4BK+BXVJYRQw1eeGQ/X8jFLDecO
         itzVH0lRFd2hY19/ySZOsz/axO2pU9cUHIDKOHN8kB8GyMB253qO9lScXfSCo/UJGMmH
         PH41BINVbE+D5yz7fVSFXsizRPun6xuIEcKDG2uQ80qiKS0yYszi+stbWYoDUXahr0Xp
         AOXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:reply-to:subject:mime-version:from:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PYwkHxpnQAf/j6hVbOuHsfpcNTzM4x9BQKZcSB0Ugdw=;
        b=KnrawZhO8syKyUoXLzqyZTvc1soYelb222HN9IrMjH+aKer++mMiIZBEmHIqwnqSvN
         fguUNg5PoZVPZgD63nxE5QPIc9Jbjf0AJkrIlOydwbwh5M6l3Ym7gCBJu+rguyIAMk43
         eS7X7Xd1fAxss33STt7wXK1gsE7n4HIQbjMIUOxA/swsU/GQqLjXg9MTjlxlgj75jAlY
         zT5OnzqYpC6NGrOXxPRboMjs1mzfD3bIStdkbL+Ev3gHCvs42U71uWyMOlwHy4oqZ5+x
         5nUZXu+hl0fjqlBN0TTK3W58ZoWD0iUsU7tFuLG7Jf0IdegozrF3CMihE5T9Vokl5l58
         vYmg==
X-Gm-Message-State: ANoB5pnlZ6Vc1Z96UFAJhmJEIcVMzxun6AgEkAcQWd9jWf/gSIFRwtG/
        Z3BjM8AnQ9+eurBGfUtURVP8+/ojXHL9PQcM
X-Google-Smtp-Source: AA0mqf52l0Vo+JfLdKr5rGMxYJ7uarFrhTqdsV9MEDHPg+W33efc6J0fNFXSJ8OszP9o4G24Gvpokw==
X-Received: by 2002:a17:90b:2685:b0:21b:c5d9:3478 with SMTP id pl5-20020a17090b268500b0021bc5d93478mr9984784pjb.0.1670705661698;
        Sat, 10 Dec 2022 12:54:21 -0800 (PST)
Received: from [127.0.1.1] ([202.184.51.63])
        by smtp.gmail.com with ESMTPSA id z9-20020a17090a7b8900b001fd6066284dsm2864132pjc.6.2022.12.10.12.54.20
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Dec 2022 12:54:21 -0800 (PST)
Message-ID: <6394f1fd.170a0220.c72d1.5884@mx.google.com>
Date:   Sat, 10 Dec 2022 12:54:21 -0800 (PST)
From:   Maria Chevchenko <17jackson5ive@gmail.com>
X-Google-Original-From: Maria Chevchenko <mariachevchenko417@outlook.com>
Content-Type: multipart/alternative; boundary="===============0290070728803801404=="
MIME-Version: 1.0
Subject: Compliment Of The Day,
Reply-To: Maria Chevchenko <mariachevchenko417@outlook.com>
To:     linux-kernel@vger.kernel.org
X-Spam-Status: No, score=1.9 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLYTO,
        FREEMAIL_REPLYTO_END_DIGIT,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--===============0290070728803801404==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

Please, i need your help; I have important business/project information that i wish to share with you. And, I want you to handle the investment. 
  Please, reply back for more information about this.
  Thank you.
--===============0290070728803801404==--
