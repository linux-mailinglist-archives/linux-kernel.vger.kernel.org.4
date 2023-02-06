Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 863A668B40B
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 03:01:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229499AbjBFCAz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Feb 2023 21:00:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbjBFCAx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Feb 2023 21:00:53 -0500
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 005EA1ADC1
        for <linux-kernel@vger.kernel.org>; Sun,  5 Feb 2023 18:00:52 -0800 (PST)
Received: by mail-pf1-x432.google.com with SMTP id bd15so7339431pfb.8
        for <linux-kernel@vger.kernel.org>; Sun, 05 Feb 2023 18:00:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L5euQeRNKs1Kj9wMLlIQEXGdYJaSH2fOQxZcUhV1cvw=;
        b=ioB2zpH192Kd4Mtg3bXfxT65uqqtiX9vkfwv7RmynFcvuU5RUkSxfAO9BmknROIpKl
         oyQHgCbceZGsZgJgtO3PHlYxF0MT+iKt4VABglcNH7BqfHRBHIAP7LMYdYmVQh0Y84O4
         s3b3WRrzgz/+KPFcMf1jJlDFkEmmd1TKMWj5zU5pXXg5Jbb1wz+AgEAqfDD8nwFrLnWM
         m7GaxTDWeaLs6TMh4ZgCk+lGsedlxlskUyFFvUdk65Xyts5pFJvBt/vq5MNXJgqzsLQ9
         QJYorOPFYogol5lbDlNrtsKMZyOeK7//1j6BHaUSlc7jXLPdCIPIkaqfMAxKWj3I4c9T
         VGnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=L5euQeRNKs1Kj9wMLlIQEXGdYJaSH2fOQxZcUhV1cvw=;
        b=eqcT4Qj2nM4JpIbt7ly1Kcz+QDThCIJUmjvaJH4DozfIiS8YqfPx3Y8GT6akJ1Cwgr
         2/Jr1MStycBsbBSx73FPB+k2BWgr4ktMkrxRKkLb/aESmgj/fIMZp6/Zt1zGvBcZ+Je2
         Ecns8xwBEoHpoRyvNZZFBET3AC2mImwl88+TU4GtdyvygMP4Pfe7bOXVPzkZDLhXS9RX
         SYze6HP1KKzfQp7VZELwVWhHj0AxfNrvCwslecSusmaesUuh+UK8DNI6zhQPLm4/nRgQ
         VbfEwiGQJiFAvnKnZI8HTVAeUsmOKB6CIFDAOsv+Z+/qgHLkqaD3DZQFfJ05yRCRaxcP
         G9Uw==
X-Gm-Message-State: AO0yUKWLvEe40X3dT/Yikht627QSP6Bs+x6rccw5SYn+s3xkQDL5WZ8A
        3OmmFRqPg66n/NUtFVEIKJ2G3fy9qx8=
X-Google-Smtp-Source: AK7set/sOJACxrV0+v1BUMxEo02CyoaMpWmJoTjNPHcAQluzTvSiouru/T7TKykj1JVOEHJpaHCxTQ==
X-Received: by 2002:a05:6a00:23d5:b0:592:629a:c9b5 with SMTP id g21-20020a056a0023d500b00592629ac9b5mr21066957pfc.14.1675648852506;
        Sun, 05 Feb 2023 18:00:52 -0800 (PST)
Received: from localhost ([156.236.96.165])
        by smtp.gmail.com with ESMTPSA id y126-20020a623284000000b0055f209690c0sm5726076pfy.50.2023.02.05.18.00.50
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 05 Feb 2023 18:00:52 -0800 (PST)
Date:   Mon, 6 Feb 2023 10:06:32 +0800
From:   Yue Hu <zbestahu@gmail.com>
To:     Gao Xiang <hsiangkao@linux.alibaba.com>
Cc:     linux-erofs@lists.ozlabs.org, Chao Yu <chao@kernel.org>,
        Jeffle Xu <jefflexu@linux.alibaba.com>,
        LKML <linux-kernel@vger.kernel.org>, huyue2@coolpad.com,
        zhangwen@coolpad.com
Subject: Re: [PATCH 3/6] erofs: remove tagged pointer helpers
Message-ID: <20230206100632.00004cd7.zbestahu@gmail.com>
In-Reply-To: <20230204093040.97967-3-hsiangkao@linux.alibaba.com>
References: <20230204093040.97967-1-hsiangkao@linux.alibaba.com>
        <20230204093040.97967-3-hsiangkao@linux.alibaba.com>
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

On Sat,  4 Feb 2023 17:30:37 +0800
Gao Xiang <hsiangkao@linux.alibaba.com> wrote:

> Just open-code the remaining one to simplify the code.
> 
> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>

Reviewed-by: Yue Hu <huyue2@coolpad.com>

