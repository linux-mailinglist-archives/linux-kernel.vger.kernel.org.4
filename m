Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCD856A526D
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Feb 2023 05:48:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229880AbjB1EsE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Feb 2023 23:48:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229511AbjB1EsC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Feb 2023 23:48:02 -0500
Received: from mail-oa1-x32.google.com (mail-oa1-x32.google.com [IPv6:2001:4860:4864:20::32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C32409EF3
        for <linux-kernel@vger.kernel.org>; Mon, 27 Feb 2023 20:48:00 -0800 (PST)
Received: by mail-oa1-x32.google.com with SMTP id 586e51a60fabf-172b0ba97b0so9785335fac.4
        for <linux-kernel@vger.kernel.org>; Mon, 27 Feb 2023 20:48:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1677559680;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=K8WrLUHrOkZwVtvZ+lvnGv80l/swT3uPg3ZR+9WAcCI=;
        b=oBCwEc4dOUXxpjMLKyrKB1QjJJXpes/EDey9HoLGks6snYWmI6UchYmN8ItfnHKKPx
         RfacIv+K75PDYDOeUD11zPJm5r6uw3D9Ij777rjRkFhscuKhnBX6N65IlYqar4wkXNFV
         QfEE07PfydX33YVqalVMuvSnRU9YV6lzqP3n5RYonJKJFxGm8LeR0hFP+wZ0c1yAz1tc
         Ei49vYBy4qyePeB1LiVi5nmDsAtDzGyurAi/wA5KVQ8oere5aDDLdYThq74ah+I+ztwU
         dJJhzp2DfT6ochx9CvRWx64NQm0l/KASLBGVYatSfXUiq3QUSfVX1FMi+bj5ZzRA0+f4
         32zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677559680;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=K8WrLUHrOkZwVtvZ+lvnGv80l/swT3uPg3ZR+9WAcCI=;
        b=nX05dmI84p+He4QG7sbZGJEmHQU2vD3HF9hh94SVsIL/gCz2Z5ldd6B9jU1M++hj/5
         217S/rHLLs8jjjKPFBE0OizqWO98GWofO3E+V9WnMjAqcn0WG7L+ugQ/MIQm5aPjibzS
         4HgIfX5j75pSXimJFmEKt6s8jvNWWirHD9tGr3GOY+gw8xPAHs+JPY22Sy+CpqpbeD+/
         pke2dOev3T2TowwLygqkHhqbi9Imx55tPftcUcaqt6S7LAU1EPobPmjnkU69HA1vQHQW
         VriX1wh7UMeAbFqrIzqBK61a+Ttk9unEwOr8SNqXTDgXYLBkIbgVqt30CT7LGvCiwA07
         rPOA==
X-Gm-Message-State: AO0yUKWX/a64Z2hjap2TtzkBJRd2X5SPZhz1gdvpYs/60UwS9wNnIBNu
        tILouzS7/7Pa0IWZMOt2qsrx6lmBA1d4CoCYAC721Q==
X-Google-Smtp-Source: AK7set9JwUW2YQ7DpFFt31o8JbaZ+IMzObGX/ZQoBxVB4MK0wJoMnkEmUQMsMFY4Ai/Diyc3/c5VzK7fzYBls1tfzX0=
X-Received: by 2002:a05:6870:98aa:b0:16e:93b3:2059 with SMTP id
 eg42-20020a05687098aa00b0016e93b32059mr243150oab.9.1677559679935; Mon, 27 Feb
 2023 20:47:59 -0800 (PST)
MIME-Version: 1.0
References: <20230208093322.75816-1-hsiangkao@linux.alibaba.com>
 <Y/ewpGQkpWvOf7qh@gmail.com> <ca1e604a-92ba-023b-8896-dcad9413081d@linux.alibaba.com>
 <8e067230-ce1b-1c75-0c23-87b926357f96@linux.alibaba.com> <CAB=BE-SQZA7gETEvxnHmy0FDQ182fUSRoa0bJBNouN33SFx3hQ@mail.gmail.com>
In-Reply-To: <CAB=BE-SQZA7gETEvxnHmy0FDQ182fUSRoa0bJBNouN33SFx3hQ@mail.gmail.com>
From:   Sandeep Dhavale <dhavale@google.com>
Date:   Mon, 27 Feb 2023 20:47:48 -0800
Message-ID: <CAB=BE-Svf7TMPs-eA+sVuGtYjVWfKd1Nd_AkA9im4Op7TCLW3g@mail.gmail.com>
Subject: Re: [PATCH v5] erofs: add per-cpu threads for decompression as an option
To:     Gao Xiang <hsiangkao@linux.alibaba.com>
Cc:     Eric Biggers <ebiggers@kernel.org>, linux-erofs@lists.ozlabs.org,
        LKML <linux-kernel@vger.kernel.org>,
        Nathan Huckleberry <nhuck@google.com>,
        Yue Hu <huyue2@coolpad.com>, kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,
I completed the tests and the results are consistent with
our previous observation. We can see that removing WQ_UNBOUND
helps but the scheduling latency by using high priority per cpu
kthreads is even lower. Below is the table.

|---------------------+-------+-------+------+-------|
| Table               | avg   | med   | min  | max   |
|---------------------+-------+-------+------+-------|
| Default erofs       | 19323 | 19758 | 3986 | 35051 |
|---------------------+-------+-------+------+-------|
| !WQ_UNBOUND         | 11202 | 10798 | 3493 | 19822 |
|---------------------+-------+-------+------+-------|
| hipri pcpu kthreads | 7182  | 7017  | 2463 | 12300 |
|---------------------+-------+-------+------+-------|


Thanks,
Sandeep.
