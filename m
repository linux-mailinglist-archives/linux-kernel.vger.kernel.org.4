Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7CC868B41E
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 03:20:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229493AbjBFCUy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Feb 2023 21:20:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbjBFCUx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Feb 2023 21:20:53 -0500
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4951D1BDB
        for <linux-kernel@vger.kernel.org>; Sun,  5 Feb 2023 18:20:52 -0800 (PST)
Received: by mail-pl1-x629.google.com with SMTP id e19so2753796plc.9
        for <linux-kernel@vger.kernel.org>; Sun, 05 Feb 2023 18:20:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pEQCtfMR+5dSwpbJDOXVU+mL5V7BhUb0kLAyubaJajM=;
        b=byfKP8/l8keSImq7cnPLHDfCjptrupPzRTdCSPragJoRB6+5ClO0TECnkAy2rMYlJk
         FlBRjkITtH0gwPoMeAxeyRfdad8hR62ZbQR6DztzYsYLOXx84UEGDaEuC+kRuzJa0i5f
         21AStq2ftGTz2s7zshbWzNmlzQP/BIdq6PQF8dMN5X+j/EVxRtPVjuDKtUH7hJAjCmd/
         IOEFYp14DrCpm3w9CPQvpkwkpLtUBjudf5XnuHPPcVuiJEv4WKGeH1A8WO2APxGT37Jq
         +y8r0PNAU13wfHxVlWiQcaMemNp44EFLu8cfAOx06xealKO+Jx1Ov+qRe3X6UY3jSMh4
         EOlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pEQCtfMR+5dSwpbJDOXVU+mL5V7BhUb0kLAyubaJajM=;
        b=xRbuSNpPWBHf7G5QWmYsH01783v8bwxPk6lFD5RWNIxN071NwFrTFc+Qr8zSfWGbjc
         tn3IwFWwxLT1fVnTskJ0mzY42+GY38cF6a9gnUkOWco3uwCuSoFE5cYXuM2umOTe8DQG
         tW8Fc1RxeGD+RUOewdbXe5j9TE0fcpcjnD3zvHu1WAhgxq0fONEaIDaeau/yRcMGWhZ9
         2jvJ/6Mbdtf/nqrBVYzZ4qCvr2tvLFTI4kta8qAPkH/lBuSqruGjt86d4R38Q+VOJEG9
         qzA9jlJVwkca4or1GHuYk16lbE9UJ7VcaxpnyzNijdhKQdlgQHWhitVZxx+JDRbLyIbg
         1TQQ==
X-Gm-Message-State: AO0yUKXrk+iWBuV3CGHe/63M9L2q+NltkdyipKrv1lTN5BjwlH6yksu5
        Bl9cS44gEZXLShZuWINW6a0=
X-Google-Smtp-Source: AK7set9wViMZiXUdECyYWP2h029GD5rzQpoJHF8LBMhon7pJWwMxw44tNa17TNTmVYONcK1cou7Yqw==
X-Received: by 2002:a05:6a21:33a7:b0:be:a9c7:5d12 with SMTP id yy39-20020a056a2133a700b000bea9c75d12mr25029561pzb.18.1675650051794;
        Sun, 05 Feb 2023 18:20:51 -0800 (PST)
Received: from localhost ([156.236.96.165])
        by smtp.gmail.com with ESMTPSA id b26-20020a63715a000000b004784cdc196dsm5118713pgn.24.2023.02.05.18.20.50
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 05 Feb 2023 18:20:51 -0800 (PST)
Date:   Mon, 6 Feb 2023 10:26:31 +0800
From:   Yue Hu <zbestahu@gmail.com>
To:     Gao Xiang <hsiangkao@linux.alibaba.com>
Cc:     linux-erofs@lists.ozlabs.org, Chao Yu <chao@kernel.org>,
        Jeffle Xu <jefflexu@linux.alibaba.com>,
        LKML <linux-kernel@vger.kernel.org>, huyue2@coolpad.com,
        zhangwen@coolpad.com
Subject: Re: [PATCH 6/6] erofs: tidy up internal.h
Message-ID: <20230206102631.000044f5.zbestahu@gmail.com>
In-Reply-To: <20230204093040.97967-6-hsiangkao@linux.alibaba.com>
References: <20230204093040.97967-1-hsiangkao@linux.alibaba.com>
        <20230204093040.97967-6-hsiangkao@linux.alibaba.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat,  4 Feb 2023 17:30:40 +0800
Gao Xiang <hsiangkao@linux.alibaba.com> wrote:

> Reorder internal.h code so that removing unneeded macros and more.
> No logic changes.
> 
> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>

Reviewed-by: Yue Hu <huyue2@coolpad.com>
