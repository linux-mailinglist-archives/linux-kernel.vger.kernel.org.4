Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 123D460B1BF
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 18:35:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231793AbiJXQf2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 12:35:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230451AbiJXQe4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 12:34:56 -0400
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD5F2181D94;
        Mon, 24 Oct 2022 08:21:51 -0700 (PDT)
Received: by mail-io1-xd35.google.com with SMTP id b79so7970876iof.5;
        Mon, 24 Oct 2022 08:21:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=evfC5qrbat5g8kksSTEWXdIJpPb8xkaNh1YJLTm0RMg=;
        b=LeNZFecy1AwjsMQagj5g99fdDRhQX3eanrowmkstwFRrQcRdsvPVR00C8blbFAKpoJ
         QdvWRTX4q3yOK/3PpfM3apsV3yCUwTjJ5NH6XfrJ5tGbKG2Z0nV50AyELDo1nlV3+UnW
         1TeVxBuHWBOp6iT22xDahPULAouxPsg/E//9X/I8Dv55zU+Gt0wGqiefd+9GCLoQbHfM
         OtZZiCy4dwrbrsqz3T71ZkETQyUyX2wE6pWEXxdKcxwz4CYK/8nd4Gr2JPglDXd34CBr
         zRe+nTO2s/agK0+urFBP0ivFKy4Qc45JIrUwqdgsDi7mJtKhlIj8+0IDOmmLcPPfEL7G
         8NkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=evfC5qrbat5g8kksSTEWXdIJpPb8xkaNh1YJLTm0RMg=;
        b=xUJxsf6KbUCX8yijYeSMRdVa/J/uX+Ak44iLJrJXq+OH/TPeQGbbQlB7tZNmadbL5y
         Qwhwyub4Cbl7mxfynF3snafhg6Xa3iNztONtpsFoON2SOdidjgOaoJHxD2J1tnkMMzxO
         f/eIc7ugUZIPCCCPNhKHN9TAuWarCw8BWK39NRcopee7tvSqGrvzLNwWHg28YxTnUGRd
         AI1DTrb0WDPWP181Xy+UPnqBV6dxeZurLCRiia3i+WgnktwjYDIPxZ9offSnEX1GZWc0
         6g9fcttHo9cwBTkANYcQ4T9819nqRFdzI23lfbTG/a52ptm0QI8CP6xc7oFPT/xFOjTn
         P2uw==
X-Gm-Message-State: ACrzQf2wPwFx4LP+myTcyschswyg/1ogSBo/zgFpXhcUFauDqmMsMXbf
        vXlGKyJ9uuY9CKykfzJiGL1g7JVbTq189pQdji8cp5sj0cE=
X-Google-Smtp-Source: AMsMyM6xAcuFaIU4N0GhIaR+jU9LGyc1XvUqCeYS3gJbA1F8CI9X9aN5Yv3D4lK7izns8qxb5tnWbUd38hir/41av5k=
X-Received: by 2002:a05:6638:4113:b0:363:f47e:7efd with SMTP id
 ay19-20020a056638411300b00363f47e7efdmr23726957jab.264.1666624810260; Mon, 24
 Oct 2022 08:20:10 -0700 (PDT)
MIME-Version: 1.0
References: <20221014142454.871196-2-carlos.bilbao@amd.com>
 <48b4a5a1-2a52-4159-699b-9db73a012892@gmail.com> <Y01pkubcT7FOwCjL@casper.infradead.org>
 <8e2a1da1-2914-b223-85b0-a769339d9c39@gmail.com> <9e65ba16-68d3-8d11-c6ac-c35c29026688@amd.com>
In-Reply-To: <9e65ba16-68d3-8d11-c6ac-c35c29026688@amd.com>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Mon, 24 Oct 2022 17:19:59 +0200
Message-ID: <CANiq72njV3TN8AsRU=7oUPq_VBgS7uaLnSnp1-qMaqcUt7E+nQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] Documentation: Start translations to Spanish
To:     Carlos Bilbao <carlos.bilbao@amd.com>
Cc:     Akira Yokosawa <akiyks@gmail.com>,
        Matthew Wilcox <willy@infradead.org>, bilbao@vt.edu,
        corbet@lwn.net, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 24, 2022 at 3:40 PM Carlos Bilbao <carlos.bilbao@amd.com> wrote:
>
> Fortunately for us, versions of Spanish differ much more in spoken form
> than they do when written.

Agreed: in Spanish, the differences, in particular in formal/technical
texts, are very minor.

Cheers,
Miguel
