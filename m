Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60E036104AC
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 23:47:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237012AbiJ0VrL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 17:47:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234947AbiJ0VrI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 17:47:08 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9E2E86FBF
        for <linux-kernel@vger.kernel.org>; Thu, 27 Oct 2022 14:47:07 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id e4so3063270pfl.2
        for <linux-kernel@vger.kernel.org>; Thu, 27 Oct 2022 14:47:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ja3qAAlJZugC/Es/RSOKzSqL9uZV3VA3Zv/T9/UTjYg=;
        b=qtuqabFSThdC26D11+nDhikBZAw2AkBLK4AzNzwvnmll2XKGyvgXY3ezZ9XMGqFALo
         hBxQAuN44MHqKM5fJoH1QsIoVv6/jdKf05eL9fCPM6UWpwXRne6WD5aT0t+GC+liXKe6
         7CPRuPYZOyK2Tse3e9WU4Dxw70kbx+9seiuKuFM6Ls5TcTpj98oAz/T5RWosdG6WgJ9L
         f5/x64CId2Lqbfp5b3QaMs9A12hAgeDyOo4Xiv5x5Gcpe9XRzB9rkZquJsRcWVge2Rpv
         WyV4MS3pZ+ioq6jW9U9WfkocpYTIikqfFR3kEYc/vHrjZesRxaGJb6GH8eeuV2BP05z/
         5EsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ja3qAAlJZugC/Es/RSOKzSqL9uZV3VA3Zv/T9/UTjYg=;
        b=oqBHbduB2H0acoShxUicS+MYcPGFSDVjkyC+BRnQc6yOCUMdbdqsgeVLxmtIQIOyNm
         QnRnCJLhfacb1wcuwPU7FYjXrhaOdTKvoaG9EbgQ6aLCISKpe6hk4ALfo+57EXUM6jEM
         tpvuKjFMSVv+p/eiQ25nYJcpCjK0HwWdSJ4W4tfXs2YMpTlUbWNT7RyhnUFr8yyuxRTY
         zwAMqoKF9WtQoEoXy1n2uUoxdGR20FztdLBIiybCBRxV2GUpoyje2SimZrIm2RpxzX8S
         /2M9bPpAq+M5J0657+0s4sU2FzEG+aaxGL8uJyJNooQx3lUNsl31mafgR1128UhWRTP0
         LSCw==
X-Gm-Message-State: ACrzQf2AQOYys6vi/67a5mLvqXI6SO29XISp+KThzYZw6rnR8duuAdQY
        xp5EGKFW+WnoXw44IJINapoeTQ==
X-Google-Smtp-Source: AMsMyM6osrTc8DwGIePiVdDEKxQzMIG5H0kxkuiued7w68/8y/0kWpem1mT/afgZEIrnOmaOxyxpMg==
X-Received: by 2002:a65:6cc7:0:b0:42a:4d40:8dc1 with SMTP id g7-20020a656cc7000000b0042a4d408dc1mr44291095pgw.321.1666907227190;
        Thu, 27 Oct 2022 14:47:07 -0700 (PDT)
Received: from localhost ([50.221.140.188])
        by smtp.gmail.com with ESMTPSA id a11-20020a1709027e4b00b00186a68ec086sm1631017pln.193.2022.10.27.14.47.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Oct 2022 14:47:06 -0700 (PDT)
Date:   Thu, 27 Oct 2022 14:47:06 -0700 (PDT)
X-Google-Original-Date: Thu, 27 Oct 2022 14:47:01 PDT (-0700)
Subject:     Re: linux-next: Signed-off-by missing for commit in the risc-v tree
In-Reply-To: <20221028063027.362963bb@canb.auug.org.au>
CC:     Paul Walmsley <paul@pwsan.com>, linux-kernel@vger.kernel.org,
        linux-next@vger.kernel.org
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Message-ID: <mhng-f863de75-c99d-4fca-96c0-e2d5eb380916@palmer-ri-x1c9a>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 27 Oct 2022 12:30:27 PDT (-0700), Stephen Rothwell wrote:
> Hi all,
>
> Commit
>
>   b2ea3c7a7d21 ("RISC-V: Cache SBI vendor values")
>
> is missing a Signed-off-by from its committer.

Sorry about that, this should be fixed.
