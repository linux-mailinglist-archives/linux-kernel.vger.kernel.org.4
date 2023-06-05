Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EC8F7231E3
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 23:04:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232059AbjFEVEV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 17:04:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229740AbjFEVET (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 17:04:19 -0400
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB30EEE
        for <linux-kernel@vger.kernel.org>; Mon,  5 Jun 2023 14:04:18 -0700 (PDT)
Received: by mail-qk1-x72f.google.com with SMTP id af79cd13be357-75d4a4cf24aso265035985a.1
        for <linux-kernel@vger.kernel.org>; Mon, 05 Jun 2023 14:04:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1685999058; x=1688591058;
        h=in-reply-to:references:subject:cc:to:from:message-id:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=8tLbIUuv5lgaEeoqnLtnBMIzF9WaGkUC0lTRYTnhjLY=;
        b=CURFfuND+w9EpS4CBMuYDAtf4AQRaiKtH+aPQKwanjanSK4cJJrzSVZansct4nIFtb
         JVtVZvgcQB35AZZNRCyC7KO7K7TCdLQMEVtiSBOWcueMna25en8AxctGxR+eDDM4omgC
         zBuAU0nZlJAVRMIEsPXU/eVBrHj43nMWJiZhJxxxntOeEQpfEoBGQLffNNIo4FXTb9sI
         gz33U0mStlUVRZ41MrmVSvoE+NnwZEbjguMXmCmME+p/MxLtGzlGJ4oLn7GiK9YPfZue
         2+p0jYeRPD6sBhsQHIIr1j67OOLvBRlpQz4bhklTtLXLVVdPPpMkqpyk2hDFfjdtS5cY
         /Tsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685999058; x=1688591058;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8tLbIUuv5lgaEeoqnLtnBMIzF9WaGkUC0lTRYTnhjLY=;
        b=XoAcDIoAviMIthaHpDO6xEafs+VoYk5KJS0d/V2XANgQU+QPViOxjuqarMcUsbqS5c
         v3HIbZ4YhZtvGyHDn7Ad0vwEppzx/wuk+USPvyefVCU3VvCPyXEfEe/4P3KCVzL4VCvu
         PoMZ3l38Y+oVr3nDZd/W9hMDQO/gS1d4jrBYcv0zIFnCnonBtrXql6vC0aBKS8MalI1o
         YE18ZmHN803/C90psC9qv081e7GNId3Xl+9//mi4qmW9sd8eDWqaSHtTgji6+7DV/ZKZ
         j2DvCi+2I7b7wkazYRvpA08KSEmoQ8+FHbwkMXn6AB6b3mMWuBGS48+oL392gStwrOHO
         RiEw==
X-Gm-Message-State: AC+VfDy4tH22sl4eGQK3RJtE9M30qP7SjxIfKYqZyMV3vgpGjuZtw97a
        0C1EtdbOQhEosd/6VetESUev
X-Google-Smtp-Source: ACHHUZ6DNQxwPJvuRFMN55TajOTfrEzsxKPLCwOnacjxiCw/Lil/yh4+xY7MA2kgUc5OPfmmAnS93g==
X-Received: by 2002:a37:64c4:0:b0:75b:23a0:d9c1 with SMTP id y187-20020a3764c4000000b0075b23a0d9c1mr943116qkb.23.1685999057142;
        Mon, 05 Jun 2023 14:04:17 -0700 (PDT)
Received: from localhost (static-96-237-115-254.bstnma.fios.verizon.net. [96.237.115.254])
        by smtp.gmail.com with ESMTPSA id s15-20020a05620a16af00b00746b2ca65edsm4453045qkj.75.2023.06.05.14.04.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jun 2023 14:04:16 -0700 (PDT)
Date:   Mon, 05 Jun 2023 17:04:15 -0400
Message-ID: <0be47690050b0d5aa3eaf2422d4feac2.paul@paul-moore.com>
From:   Paul Moore <paul@paul-moore.com>
To:     =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>,
        selinux@vger.kernel.org
Cc:     Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] selinux: avoid bool as identifier name
References: <20230602133511.30239-1-cgzones@googlemail.com>
In-Reply-To: <20230602133511.30239-1-cgzones@googlemail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,PP_MIME_FAKE_ASCII_TEXT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Jun  2, 2023 =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com> wrote:
> 
> Avoid using the identifier `bool` to improve support with future C
> standards.  C23 is about to make `bool` a predefined macro (see N2654).
> 
> Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
> ---
>  security/selinux/ss/conditional.c | 8 ++++----
>  security/selinux/ss/conditional.h | 2 +-
>  2 files changed, 5 insertions(+), 5 deletions(-)

Merged into selinux/next, thanks.

--
paul-moore.com
