Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7ED6E6BAB54
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 09:59:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231793AbjCOI7P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 04:59:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231814AbjCOI7J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 04:59:09 -0400
Received: from mail-yw1-x1130.google.com (mail-yw1-x1130.google.com [IPv6:2607:f8b0:4864:20::1130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52A4718B36
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 01:59:04 -0700 (PDT)
Received: by mail-yw1-x1130.google.com with SMTP id 00721157ae682-5418d54d77bso183121287b3.12
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 01:59:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678870743;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=p178/Yt1AQvAYQmHaMU/28S2xb2U5Dc2cDgqtBRRFc4=;
        b=IyklznoKDGFRV+Pud2mDVLgQpwluHt0Zyacy3oTwOZ2bQ7qYV9FqqHgR9ycY8380d6
         zsYhw8HqYi/4tKYQ6Jyim08AbPT008m38Kh0M03+yv4UQR18XNCz1CRkxm3aSURUg2MP
         11adGxrCA+Y9EV55D7Lb5+dPmZ6OE9Y9mnV++8ZwXOOvzWQCJwxSBMjEMjczA7vJ2JNY
         OJNmTTsexSVrf9gubdeIk22YK4bDilMNk5z9YebzapAOP7wjvrzGjERYOrnz+KyRManS
         L4uXs6806M6ky0zOlrtKd3ilcPzXQXdFx2Joe6lldv4GM4sx41bDeMXk26GbMzNVA0sj
         prrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678870743;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=p178/Yt1AQvAYQmHaMU/28S2xb2U5Dc2cDgqtBRRFc4=;
        b=4oGdSoFF900GHyieocs9h2JvDtnblj649GTe6wOV+5XPJIHRQBt4mOeMt0ImqFzIlY
         alrchtIhuC4fYNp/no++FYy4Ho824UvpdIZUDAbrwFSYHqa+SZ9ykbVmz4zKx8iU0bdJ
         WpqpziJN9RjE9fzjzyqvufefxQVjEBIVFjhnVdGo5pPd1yCRtSxuOSY8Ve2bZN2hUF8B
         68H5M+lwfj+DGYxlj5Ji3EsKd0a6wtt7SeYL5WzuZAz+fgtMGkng4Yv34ROIcusU63cN
         vfvOp3uOVo+p12bkPP3lMODUcZrKLUQL1mYw0lIxThCtAx92QtLDPjJ+Ti13BDx+8F4G
         liDA==
X-Gm-Message-State: AO0yUKWOZndevPkh33ukitTlclXTXF1sgGtbFBCS7Uli4tf/frk1dpjJ
        sgJHnLldy9M+zEc78nRDy+7Z0eA12UG9giNjfSM=
X-Google-Smtp-Source: AK7set9c9z1odGZls8KWQpX+Ly2EileWzj/YuZpnwae91b6cmT49sDWtCRDsJhv9d3AbtHm1Lco7nXuedYLKbp/RRAY=
X-Received: by 2002:a81:b503:0:b0:543:9065:b225 with SMTP id
 t3-20020a81b503000000b005439065b225mr5708168ywh.5.1678870743540; Wed, 15 Mar
 2023 01:59:03 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:7110:128b:b0:1bd:9908:1c5 with HTTP; Wed, 15 Mar 2023
 01:59:03 -0700 (PDT)
Reply-To: paulsonjessica399@gmail.com
From:   Jessica Paulson <jessica.u.meir38@gmail.com>
Date:   Wed, 15 Mar 2023 08:59:03 +0000
Message-ID: <CAPvMxY_aH9Kn3HQ3MNLCNLq1fL4_wMTdh0pOKRvx_6ne06cGXA@mail.gmail.com>
Subject: 
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=5.0 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,UNDISC_FREEM autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Report: *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:1130 listed in]
        [list.dnswl.org]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [jessica.u.meir38[at]gmail.com]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [jessica.u.meir38[at]gmail.com]
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [paulsonjessica399[at]gmail.com]
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        *  2.9 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
X-Spam-Level: *****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, I'm Jessica, from the United States, I what to share ideas
