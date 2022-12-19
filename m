Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0CE765150A
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Dec 2022 22:40:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232559AbiLSVkc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Dec 2022 16:40:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232541AbiLSVka (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Dec 2022 16:40:30 -0500
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69062B1C3
        for <linux-kernel@vger.kernel.org>; Mon, 19 Dec 2022 13:40:29 -0800 (PST)
Received: by mail-yb1-xb2e.google.com with SMTP id d131so10998570ybh.4
        for <linux-kernel@vger.kernel.org>; Mon, 19 Dec 2022 13:40:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:references:in-reply-to:reply-to
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=cZO0VTSbbcbYZiJPaOMLh4dyINA59L0dviM5rTB/N30=;
        b=NPULvP3taBFh8ae2lTIa6cPUTUst+Y6VXInxdJI4scftRD7LuI6h+p6+41A7vhNlXA
         mcwSCLLYOlN8j9chBk+ewBmiD8lWcm0kmxXP7JLu9V0r7XjqcBAxfHJyR89hJl1kBhnU
         WiLSYGh8/HttPOpyzC8UhFXrX2ny9ij2TeNxuMt0I6LABoERXNBdVfz+T7HnI5VVHCe9
         0+eNkNcwv0575Ql0pbdtFDG5++FOppHpUM7gAQu6QnLCmxy3eViYNxzeNb++4OPY3VLP
         2H64fyRkT2HuZIMUaOyou4F9/mu1szS2bwjktm6PwgktDlPkr3Vh1lAXCDh+LbsFbMqX
         EkbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:references:in-reply-to:reply-to
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cZO0VTSbbcbYZiJPaOMLh4dyINA59L0dviM5rTB/N30=;
        b=70kZsJKCKR8hZ1DR+0AXK3ajxnAgx3LszJp7F37xa1Gsna7JjTw0vyraHuLZh8A5Vl
         n+jNFRg5G2y2yghzzLorLQ95sUqR18Dc0KVXmD5SO49ywBUoU+RCQIZ63IXgHhfqEtc5
         3dmhjsrJORvKqM/Cow2AMS61u43LHNPcHCRfC4RA8yyxTbhnA6NPv8BniUwqq8of3cvx
         a5hv4pWIOQtrkGmaI8Cw38+xMrMetBvye8XXBgWpzTHyEQs3MXbB4zzWH6+xbDGv9EmD
         jD0jwBWVqqDvgpcXI6EqfN1V2ClbJQu4/x/uMuULhldYN3Xxcnzof+wvbkAreA7vJuAf
         3cww==
X-Gm-Message-State: ANoB5pnpJQj/tR0EWpqQRwkFimVatTzQqTyfolBbWpLC8sGHnHPAvTPG
        1giGZ9wlHVgWJe4ydmXiL3eKYfDclT3YwsCfhRg=
X-Google-Smtp-Source: AA0mqf6A8ygeZt3VzuoMdEJkoKe/D7O/1Gu1z2XSmyUm9QMU+E/InYHwB03pLKiXaWVf5yjZYSCjfMvqwcpuzrvZYFg=
X-Received: by 2002:a25:30c1:0:b0:6ef:fb99:4af9 with SMTP id
 w184-20020a2530c1000000b006effb994af9mr68421880ybw.108.1671486028435; Mon, 19
 Dec 2022 13:40:28 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a05:7000:a002:b0:3dd:33d2:9876 with HTTP; Mon, 19 Dec 2022
 13:40:27 -0800 (PST)
Reply-To: rebecca9407128@gmail.com
In-Reply-To: <CAMynKgf1_RnugYozmnEfjsd5YxzPY13u8giKhAhxa+FhJAFhgQ@mail.gmail.com>
References: <CAMynKgf1_RnugYozmnEfjsd5YxzPY13u8giKhAhxa+FhJAFhgQ@mail.gmail.com>
From:   Rebecca Johnson <adhirikasamyane@gmail.com>
Date:   Mon, 19 Dec 2022 13:40:27 -0800
Message-ID: <CAMynKgfbvvnxmiPj6ib+DUEpMTV9wj7SjdrcBBeoDWC-FOWaig@mail.gmail.com>
Subject: Re: Come
To:     adhirikasamyane@gmail.com
Content-Type: text/plain; charset="UTF-8"
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

-- 
My name is Rebecca Johnson from Canada I want to open Charity
Foundation and Company in your country on your behalf
is this okay
